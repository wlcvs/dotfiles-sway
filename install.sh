#!/usr/bin/env bash
set -e

# Requires base dotfiles to be installed first:
# https://github.com/wlcvs/dotfiles

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing Sway stack packages (Fedora/dnf)..."
sudo dnf install -y \
  sway \
  grim slurp grimshot \
  swaylock swayidle \
  waybar \
  wlsunset \
  cliphist wl-clipboard \
  greetd tuigreet \
  autotiling \
  python3-i3ipc \
  gtk-layer-shell \
  python3-gobject

echo "==> Configuring greetd (replaces SDDM)..."
sudo cp "$DOTFILES/system/greetd-config.toml" /etc/greetd/config.toml
id greeter &>/dev/null || sudo useradd -M -G video greeter
sudo systemctl disable sddm 2>/dev/null || true
sudo systemctl enable greetd

echo "==> Linking Sway configs..."
mkdir -p ~/.config/sway/config.d
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

echo "==> Linking Sway scripts..."
mkdir -p ~/.local/bin
ln -sf "$DOTFILES/.local/bin/sway-alt-tab"          ~/.local/bin/sway-alt-tab
ln -sf "$DOTFILES/.local/bin/first-empty-workspace" ~/.local/bin/first-empty-workspace
chmod +x "$DOTFILES/.local/bin/sway-alt-tab" "$DOTFILES/.local/bin/first-empty-workspace"

echo ""
echo "==> Done! Next steps:"
echo "    1. Reboot (applies greetd login manager)"
echo "    2. Run: swaymsg reload (applies Sway config)"
