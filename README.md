# sway-rice

Rose-Pine themed Sway desktop environment. Portable dotfiles bundle for Ubuntu (apt) and Fedora (dnf).

## Screenshots

TODO

## What's included

| Component | Config path | Description |
|-----------|------------|-------------|
| Sway | `config/sway/` | Tiling WM config, vim keybinds, autotiling, gaps, thin borders |
| Waybar | `config/waybar/` | Top bar — workspaces, clock, cpu, memory, network, pulseaudio, bluetooth, mpris, tray |
| Wofi | `config/wofi/` | App launcher (drun mode) |
| wlogout | `config/wlogout/` | Power menu (lock, logout, reboot, shutdown) |
| swaync | `config/swaync/` | Notification center |
| Fish | `config/fish/` | Shell config |
| Starship | `config/starship.toml` | Shell prompt |
| Ghostty | `config/ghostty/` | Terminal emulator |
| tmux | `config/tmux/` | Terminal multiplexer — Ctrl+Space prefix, vim keybinds, rose-pine status bar |
| Fonts | `fonts/` | JetBrainsMono Nerd Font (bundled, no download needed) |
| Wallpaper | `wallpaper_grey.png` | Default wallpaper |

## Dependencies

Installed automatically by `dotfiles.sh`:

**Core:**
- `sway` — Wayland compositor
- `waybar` — status bar
- `wofi` — app launcher
- `wlogout` — power menu
- `swaync` — notification center
- `swaylock` — lock screen
- `swayidle` — idle manager

**Terminal/Shell:**
- `ghostty` — terminal emulator (manual install, not in repos)
- `fish` — shell
- `starship` — prompt
- `tmux` — terminal multiplexer

**Utilities:**
- `copyq` — clipboard manager
- `playerctl` — media control
- `pavucontrol` — audio GUI
- `grim` + `slurp` — screenshots
- `wl-clipboard` — Wayland clipboard
- `jq` — JSON parser (used by setup-displays.sh)
- `autotiling` — automatic tiling direction (install via pip: `pip install autotiling`)

**Fonts:**
- Inter (UI font) — `fonts-inter` (apt) / `google-noto-fonts-common` (dnf)
- JetBrainsMono Nerd Font (terminal/icons) — bundled in `fonts/`

## Install

```bash
git clone <this-repo> ~/sway-rice
cd ~/sway-rice
chmod +x dotfiles.sh
./dotfiles.sh
```

The installer will:
1. Detect your package manager (apt or dnf)
2. Install all dependencies
3. Back up your existing configs to `~/.config/backup-pre-sway-<date>/`
4. Copy all configs to `~/.config/`
5. Install the wallpaper and fonts
6. Optionally set fish as your default shell

## Display setup

After installing and logging into Sway for the first time:

```bash
~/.config/sway/setup-displays.sh
```

This interactive script will:
- Detect all connected monitors
- Dim each display to help you identify which is which
- Let you pick your main and secondary monitors
- Handle portrait/landscape orientation
- Assign workspaces (1-5 main, 6-10 secondary)
- Auto-disable laptop display if not selected

The generated `~/.config/sway/displays.conf` is sourced by the main sway config.

## Keybinds

| Bind | Action |
|------|--------|
| `Super+Enter` | Terminal (ghostty) |
| `Super+d` | App launcher (wofi) |
| `Super+q` | Kill window |
| `Super+p` | Power menu (wlogout) |
| `Super+e` | File explorer (ranger) |
| `Super+c` | Clipboard (CopyQ) |
| `Super+n` | Notification center |
| `Super+f` | Fullscreen |
| `Super+hjkl` | Focus left/down/up/right |
| `Super+Shift+hjkl` | Move window |
| `Super+Ctrl+hjkl` | Resize (30px) |
| `Super+Ctrl+Shift+hjkl` | Resize fast (100px) |
| `Super+1-0` | Switch workspace |
| `Super+Shift+1-0` | Move to workspace |
| `Super+[` / `Super+]` | Prev/next workspace |
| `Super+x` | Toggle last workspace |
| `Super+Shift+Space` | Toggle floating |
| `Super+Shift+c` | Reload config |
| `Print` | Screenshot (flameshot) |

## Color palette (Rose-Pine)

| Role | Hex |
|------|-----|
| Background | `#080709` |
| Surface | `#1a1520` |
| Surface alt | `#2d2735` |
| Text | `#e0ceed` |
| Muted | `#614e6e` |
| Accent (cyan) | `#9ccfd8` |
| Secondary (pink) | `#f5b0ef` |
| Success | `#c4e881` |
| Error | `#fc4649` |

## Notes

- Ghostty must be installed manually — it's not in Ubuntu or Fedora repos
- `autotiling` is a Python package: `pip install autotiling`
- The sway config uses `include ~/.config/sway/displays.conf` so it works on any monitor setup
- wlogout layout auto-detects Hyprland vs Sway for lock/logout commands
