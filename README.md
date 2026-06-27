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
| Login manager | greetd + tuigreet |
| Launcher | Rofi |
| Notifications | Dunst |
| Screenshots | Grimshot (grim + slurp) |
| Clipboard history | cliphist + wl-clipboard |
| Night mode | wlsunset |

## Installation

> Arch Linux only. Requires `yay` for AUR packages (`autotiling`, `dmz-cursor-themes`).

```bash
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway && ~/dotfiles-sway/install.sh
```

> **greetd warning:** if something goes wrong, switch to a TTY (Ctrl+Alt+F3), log in as root,
> run `systemctl disable greetd` and reboot.

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

- `waybar/config.jsonc` references `~/.local/bin/power-profile` (from base dotfiles)
- `volume-popup` and `wifi-popup` are archived — GtkLayerShell was unreliable
