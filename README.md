# dotfiles-sway

Sway WM configuration for Arch Linux.

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

```bash
sudo pacman -S --needed \
  sway waybar swaylock swayidle swaynag \
  grim slurp grimshot \
  wlsunset cliphist wl-clipboard \
  rofi dunst \
  greetd tuigreet \
  python-i3ipc python-gobject gtk-layer-shell

yay -S --needed autotiling dmz-cursor-themes
```

### 2. Run install script
```bash
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway
chmod +x ~/dotfiles-sway/install.sh
~/dotfiles-sway/install.sh
```

### 3. (Optional) greetd login manager

> **Warning:** do this only after confirming all steps above work.
> Getting greetd wrong locks you out — follow the order exactly.

```bash
# 1. Disable any existing display manager first
sudo systemctl disable gdm sddm lightdm ly 2>/dev/null || true

# 2. Ensure tuigreet is installed and the greeter user exists
which tuigreet || { echo "Install tuigreet first"; exit 1; }
id greeter &>/dev/null || sudo useradd -M -G video greeter

# 3. Verify the sway session file is present
ls /usr/share/wayland-sessions/sway.desktop || { echo "Sway session file missing"; exit 1; }

# 4. Copy config and enable greetd
sudo cp ~/dotfiles-sway/system/greetd-config.toml /etc/greetd/config.toml
sudo systemctl enable --now greetd
```

**If greetd breaks login:** switch to a TTY (Ctrl+Alt+F3), log in as root,
run `systemctl disable greetd` and reboot.

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
