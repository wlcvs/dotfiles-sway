# dotfiles-sway

Sway WM configuration — distro-agnostic.

> Requires [base dotfiles](https://github.com/wlcvs/dotfiles) installed first.

## Design

Monochromatic — only black, white and gray. JetBrains Mono. No icons, no rounded corners.

## Stack

| Role | Tool |
|---|---|
| Compositor | Sway |
| Bar | Waybar |
| Screen lock | swaylock + swayidle |
| Login manager | greetd + tuigreet (optional) |
| Launcher | Rofi |
| Notifications | Dunst |
| Screenshots | Grimshot (grim + slurp) |
| Clipboard history | cliphist + wl-clipboard |
| Night mode | wlsunset |

## Installation

### 1. Install packages

**Arch**
```bash
sudo pacman -S --needed \
  sway waybar swaylock swayidle swaynag \
  grim slurp grimshot \
  wlsunset cliphist wl-clipboard \
  rofi dunst \
  greetd tuigreet \
  python-i3ipc python-gobject gtk-layer-shell

yay -S --needed autotiling
```

**Debian / Ubuntu**
```bash
sudo apt install \
  sway waybar swaylock swayidle \
  grim slurp \
  wlsunset wl-clipboard \
  rofi dunst \
  greetd \
  python3-i3ipc python3-gi gir1.2-gtk-layer-shell-0.1

pip3 install autotiling --user
# cliphist: install from https://github.com/sentriz/cliphist/releases
```

**Fedora**
```bash
sudo dnf install \
  sway waybar swaylock swayidle \
  grim slurp grimshot \
  wlsunset wl-clipboard cliphist \
  rofi dunst \
  greetd tuigreet \
  python3-i3ipc python3-gobject gtk-layer-shell

pip3 install autotiling --user
```

### 2. Run install script
```bash
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway
chmod +x ~/dotfiles-sway/install.sh
~/dotfiles-sway/install.sh
```

### 3. (Optional) greetd login manager
```bash
sudo cp ~/dotfiles-sway/system/greetd-config.toml /etc/greetd/config.toml
# Create greeter user if needed:
id greeter &>/dev/null || sudo useradd -M -G video greeter
sudo systemctl enable greetd
```

## Keybindings

| Shortcut | Action |
|---|---|
| `Super+Enter` | Alacritty (new tmux window) |
| `Super+D` | Rofi launcher |
| `Super+Shift+E` | Power menu (lock/logout/suspend/reboot/shutdown) |
| `Super+H/J/K/L` | Focus (vim-style) |
| `Super+Shift+H/J/K/L` | Move window |
| `Super+1..9` | Switch workspace |
| `Super+Shift+1..9` | Move window to workspace |
| `Super+N` | First empty workspace |
| `Super+Tab` | Last workspace |
| `Alt+Tab` | Next window (all workspaces) |
| `Super+R` | Resize mode |
| `Super+F` | Fullscreen |
| `Super+Shift+Space` | Toggle floating |
| `Super+Minus` | Scratchpad |
| `Super+Shift+P` | Clipboard history |
| `Super+Shift+B` | Toggle Waybar |
| `Print` | Area → clipboard |
| `Alt+Print` | Window → clipboard |
| `Ctrl+Print` | Fullscreen → clipboard |

## Notes

- `sway-alt-tab` requires `python-i3ipc`
- `waybar/config.jsonc` references `~/.local/bin/power-profile` (from base dotfiles)
- `volume-popup` and `wifi-popup` are archived — GtkLayerShell was unreliable
