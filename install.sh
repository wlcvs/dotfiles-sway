#!/usr/bin/env bash
# Sway WM dotfiles
# Install required packages first (see README for your distro), then run this.
# Requires base dotfiles: https://github.com/wlcvs/dotfiles

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Linking Sway configs..."
mkdir -p ~/.config/sway/config.d
ln -sf "$DOTFILES/.config/sway/config"                               ~/.config/sway/
ln -sf "$DOTFILES/.config/sway/config.d/00-input.conf"               ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/01-terminal.conf"            ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/10-theme.conf"               ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/20-bindings-extra.conf"      ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/60-bindings-screenshot.conf" ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/90-power-menu.conf"          ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/90-swayidle.conf"            ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/95-gnome-keyring.conf"       ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/config.d/98-autostart.conf"           ~/.config/sway/config.d/
ln -sf "$DOTFILES/.config/sway/environment"                          ~/.config/sway/

mkdir -p ~/.config/waybar
ln -sf "$DOTFILES/.config/waybar/config.jsonc" ~/.config/waybar/
ln -sf "$DOTFILES/.config/waybar/style.css"    ~/.config/waybar/

mkdir -p ~/.config/swaylock
ln -sf "$DOTFILES/.config/swaylock/config" ~/.config/swaylock/

mkdir -p ~/.config/swaynag
ln -sf "$DOTFILES/.config/swaynag/config" ~/.config/swaynag/

echo "==> Installing desktop entries for TUI apps..."
mkdir -p ~/.local/share/applications
cp "$DOTFILES/applications/"*.desktop ~/.local/share/applications/
cp "$DOTFILES/applications/hidden/"*.desktop ~/.local/share/applications/

echo "==> Installing DMZ-White cursor theme..."
if [ ! -d ~/.local/share/icons/DMZ-White ]; then
    DEB_URL="http://ftp.debian.org/debian/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_0.4.5_all.deb"
    curl -fsSL "$DEB_URL" -o /tmp/dmz.deb
    (
        cd /tmp
        ar x dmz.deb
        DATA=$(ls data.tar.* 2>/dev/null | head -1)
        if [ -z "$DATA" ]; then
            echo "    warning: could not find data archive inside dmz.deb"
        else
            tar -xf "$DATA"
            mkdir -p ~/.local/share/icons
            cp -r /tmp/usr/share/icons/DMZ-White ~/.local/share/icons/
        fi
        rm -f dmz.deb control.tar.* data.tar.* debian-binary
    )
else
    echo "    skipped: DMZ-White already installed"
fi

echo "==> Linking Rofi, Dunst and GTK configs..."
mkdir -p ~/.config/rofi
ln -sf "$DOTFILES/.config/rofi/config.rasi" ~/.config/rofi/
ln -sf "$DOTFILES/.config/rofi/theme.rasi"  ~/.config/rofi/

mkdir -p ~/.config/dunst
ln -sf "$DOTFILES/.config/dunst/dunstrc" ~/.config/dunst/

mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
ln -sf "$DOTFILES/.config/gtk-3.0/settings.ini" ~/.config/gtk-3.0/
ln -sf "$DOTFILES/.config/gtk-4.0/settings.ini" ~/.config/gtk-4.0/
gsettings set org.gnome.desktop.interface gtk-theme    'Adwaita'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'DMZ-White'
gsettings set org.gnome.desktop.interface cursor-size  24

echo "==> Linking scripts..."
mkdir -p ~/.local/bin
ln -sf "$DOTFILES/.local/bin/clipboard"             ~/.local/bin/clipboard
ln -sf "$DOTFILES/.local/bin/volume-tui"            ~/.local/bin/volume-tui
ln -sf "$DOTFILES/.local/bin/power-profile"         ~/.local/bin/power-profile
ln -sf "$DOTFILES/.local/bin/sway-alt-tab"          ~/.local/bin/sway-alt-tab
ln -sf "$DOTFILES/.local/bin/first-empty-workspace" ~/.local/bin/first-empty-workspace
ln -sf "$DOTFILES/.local/bin/grimshot"              ~/.local/bin/grimshot
chmod +x \
  "$DOTFILES/.local/bin/clipboard" \
  "$DOTFILES/.local/bin/volume-tui" \
  "$DOTFILES/.local/bin/power-profile" \
  "$DOTFILES/.local/bin/sway-alt-tab" \
  "$DOTFILES/.local/bin/first-empty-workspace" \
  "$DOTFILES/.local/bin/grimshot"

echo ""
echo "==> Done! Next steps:"
echo "    1. greetd: sudo cp system/greetd-config.toml /etc/greetd/config.toml"
echo "    2. Start Sway or run: swaymsg reload"
