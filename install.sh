#!/usr/bin/env bash
# Sway WM dotfiles for Arch Linux

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

safe_link() {
    local src="$1" dst="$2"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "    skip: $dst"
        return
    fi
    ln -sf "$src" "$dst"
    echo "    link: $dst"
}

safe_copy() {
    local src="$1" dst="$2"
    if [ -f "$dst" ]; then
        echo "    skip: $dst"
        return
    fi
    cp "$src" "$dst"
    echo "    copy: $dst"
}

echo "==> Installing packages..."
sudo pacman -S --needed --noconfirm \
  sway waybar swaylock swayidle sway-contrib \
  alacritty \
  grim slurp \
  brightnessctl wireplumber playerctl \
  wlsunset cliphist wl-clipboard \
  rofi dunst \
  gnome-keyring \
  power-profiles-daemon \
  fzf jq \
  greetd greetd-tuigreet \
  python-i3ipc python-gobject gtk-layer-shell \
  xcursor-vanilla-dmz

if command -v yay &>/dev/null; then
    yay -S --needed --noconfirm autotiling
else
    echo "    warning: yay not found — install autotiling manually"
fi

echo "==> Linking Alacritty and Tmux configs..."
mkdir -p ~/.config/alacritty
safe_link "$DOTFILES/.config/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
safe_link "$DOTFILES/.tmux.conf" ~/.tmux.conf

echo "==> Linking Sway configs..."
mkdir -p ~/.config/sway/config.d
safe_link "$DOTFILES/.config/sway/config"                               ~/.config/sway/config
safe_link "$DOTFILES/.config/sway/config.d/00-input.conf"               ~/.config/sway/config.d/00-input.conf
safe_link "$DOTFILES/.config/sway/config.d/01-terminal.conf"            ~/.config/sway/config.d/01-terminal.conf
safe_link "$DOTFILES/.config/sway/config.d/10-theme.conf"               ~/.config/sway/config.d/10-theme.conf
safe_link "$DOTFILES/.config/sway/config.d/20-bindings-extra.conf"      ~/.config/sway/config.d/20-bindings-extra.conf
safe_link "$DOTFILES/.config/sway/config.d/60-bindings-screenshot.conf" ~/.config/sway/config.d/60-bindings-screenshot.conf
safe_link "$DOTFILES/.config/sway/config.d/90-power-menu.conf"          ~/.config/sway/config.d/90-power-menu.conf
safe_link "$DOTFILES/.config/sway/config.d/90-swayidle.conf"            ~/.config/sway/config.d/90-swayidle.conf
safe_link "$DOTFILES/.config/sway/config.d/95-gnome-keyring.conf"       ~/.config/sway/config.d/95-gnome-keyring.conf
safe_link "$DOTFILES/.config/sway/config.d/98-autostart.conf"           ~/.config/sway/config.d/98-autostart.conf
safe_link "$DOTFILES/.config/sway/environment"                          ~/.config/sway/environment

mkdir -p ~/.config/waybar
safe_link "$DOTFILES/.config/waybar/config.jsonc" ~/.config/waybar/config.jsonc
safe_link "$DOTFILES/.config/waybar/style.css"    ~/.config/waybar/style.css

mkdir -p ~/.config/swaylock
safe_link "$DOTFILES/.config/swaylock/config" ~/.config/swaylock/config

mkdir -p ~/.config/swaynag
safe_link "$DOTFILES/.config/swaynag/config" ~/.config/swaynag/config

echo "==> Installing desktop entries for TUI apps..."
mkdir -p ~/.local/share/applications
for f in "$DOTFILES/applications/"*.desktop "$DOTFILES/applications/hidden/"*.desktop; do
    safe_copy "$f" ~/.local/share/applications/"$(basename "$f")"
done

echo "==> Linking Rofi, Dunst and GTK configs..."
mkdir -p ~/.config/rofi
safe_link "$DOTFILES/.config/rofi/config.rasi" ~/.config/rofi/config.rasi
safe_link "$DOTFILES/.config/rofi/theme.rasi"  ~/.config/rofi/theme.rasi

mkdir -p ~/.config/dunst
safe_link "$DOTFILES/.config/dunst/dunstrc" ~/.config/dunst/dunstrc

mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
safe_link "$DOTFILES/.config/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
safe_link "$DOTFILES/.config/gtk-4.0/settings.ini" ~/.config/gtk-4.0/settings.ini
gsettings set org.gnome.desktop.interface gtk-theme    'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Vanilla-DMZ'
gsettings set org.gnome.desktop.interface cursor-size  24

echo "==> Linking scripts..."
mkdir -p ~/.local/bin
safe_link "$DOTFILES/.local/bin/clipboard"             ~/.local/bin/clipboard
safe_link "$DOTFILES/.local/bin/volume-tui"            ~/.local/bin/volume-tui
safe_link "$DOTFILES/.local/bin/power-profile"         ~/.local/bin/power-profile
safe_link "$DOTFILES/.local/bin/sway-alt-tab"          ~/.local/bin/sway-alt-tab
safe_link "$DOTFILES/.local/bin/first-empty-workspace" ~/.local/bin/first-empty-workspace
safe_link "$DOTFILES/.local/bin/grimshot"              ~/.local/bin/grimshot
chmod +x \
  "$DOTFILES/.local/bin/clipboard" \
  "$DOTFILES/.local/bin/volume-tui" \
  "$DOTFILES/.local/bin/power-profile" \
  "$DOTFILES/.local/bin/sway-alt-tab" \
  "$DOTFILES/.local/bin/first-empty-workspace" \
  "$DOTFILES/.local/bin/grimshot"

echo "==> Configuring greetd..."
id greeter &>/dev/null || sudo useradd -M -G video greeter
if ! diff -q "$DOTFILES/system/greetd-config.toml" /etc/greetd/config.toml &>/dev/null; then
    sudo cp "$DOTFILES/system/greetd-config.toml" /etc/greetd/config.toml
    echo "    copy: /etc/greetd/config.toml"
else
    echo "    skip: /etc/greetd/config.toml"
fi
systemctl is-enabled greetd &>/dev/null || sudo systemctl enable greetd

echo ""
echo "==> Done! Start Sway or run: swaymsg reload"
