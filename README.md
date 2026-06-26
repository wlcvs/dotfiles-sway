# dotfiles-sway

Sway WM configuration for **Fedora 44** on a ThinkPad.

> This is the archived Sway setup. For the base dotfiles (shell, editor, terminal),
> see [dotfiles](https://github.com/wlcvs/dotfiles). Install base first.

## Stack

| Role | Tool |
|---|---|
| Compositor | Sway |
| Bar | Waybar |
| Screen lock | swaylock + swayidle |
| Login manager | greetd + tuigreet |
| Launcher | Rofi (config in base dotfiles) |
| Notifications | Dunst (config in base dotfiles) |
| Screenshots | Grimshot (grim + slurp) |
| Clipboard history | cliphist + wl-clipboard |
| Night mode | wlsunset |

## Design

Monochromatic HUD — only black, white and gray. JetBrains Mono. No icons, no rounded corners.

## Installation

```bash
# 1. Install base dotfiles first
git clone https://github.com/wlcvs/dotfiles ~/dotfiles && ~/dotfiles/install.sh

# 2. Then install Sway layer
git clone https://github.com/wlcvs/dotfiles-sway ~/dotfiles-sway
chmod +x ~/dotfiles-sway/install.sh
~/dotfiles-sway/install.sh
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
| `Super+Minus` | Scratchpad show |
| `Super+Shift+P` | Clipboard history |
| `Super+Shift+B` | Toggle Waybar |
| `Print` | Area → clipboard |
| `Alt+Print` | Window → clipboard |
| `Ctrl+Print` | Fullscreen → clipboard |

## Notes

- `volume-popup` and `wifi-popup` in `.local/bin/` are archived (GtkLayerShell was unreliable on Wayland)
- `sway-alt-tab` requires `python3-i3ipc`
- logind power config (`system/logind-thinkpad.conf`) lives in the base dotfiles
- greetd requires a dedicated `greeter` user — created automatically by install.sh
