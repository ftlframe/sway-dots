#!/usr/bin/env bash
set -euo pipefail

# Sway rice installer for Ubuntu
# Usage: ./install.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/backup-pre-sway-$(date +%Y-%m-%d)"

echo "=== Sway Rice Installer ==="
echo ""

# --- Detect distro ---
if command -v apt &>/dev/null; then
    PKG_MGR="apt"
elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
else
    echo "Unsupported package manager. Only apt (Ubuntu/Debian) and dnf (Fedora) are supported."
    exit 1
fi

echo "Detected package manager: $PKG_MGR"

# --- Install packages ---
echo ""
echo "=== Installing packages ==="

if [ "$PKG_MGR" = "apt" ]; then
    sudo apt update
    sudo apt install -y \
        sway swaync swaylock swayidle \
        waybar \
        wofi \
        wlogout \
        fish \
        tmux \
        copyq \
        playerctl \
        pavucontrol \
        grim slurp swappy wl-clipboard \
        fonts-inter \
        jq

    # JetBrains Mono Nerd Font (bundled)
    if ! fc-list | grep -qi "JetBrainsMono Nerd"; then
        echo "Installing JetBrains Mono Nerd Font..."
        mkdir -p ~/.local/share/fonts
        cp "$SCRIPT_DIR/fonts/"*.ttf ~/.local/share/fonts/
        fc-cache -f
    fi

    # Starship prompt
    if ! command -v starship &>/dev/null; then
        echo "Installing starship..."
        sudo apt install -y starship 2>/dev/null || echo "NOTE: starship not in apt repos. Install manually: https://starship.rs"
    fi

    # Ghostty — needs manual install on Ubuntu
    if ! command -v ghostty &>/dev/null; then
        echo ""
        echo "NOTE: Ghostty is not in Ubuntu repos."
        echo "Install it manually from: https://ghostty.org/download"
        echo "Or use: sudo snap install ghostty --classic (if available)"
        echo ""
    fi

elif [ "$PKG_MGR" = "dnf" ]; then
    sudo dnf install -y \
        sway swaync swaylock swayidle \
        waybar \
        wofi \
        wlogout \
        fish \
        copyq \
        playerctl \
        pavucontrol \
        grim slurp swappy wl-clipboard \
        google-noto-fonts-common \
        jq

    if ! fc-list | grep -qi "JetBrainsMono Nerd"; then
        echo "Installing JetBrains Mono Nerd Font..."
        mkdir -p ~/.local/share/fonts
        cp "$SCRIPT_DIR/fonts/"*.ttf ~/.local/share/fonts/
        fc-cache -f
    fi

    if ! command -v starship &>/dev/null; then
        echo "Installing starship..."
        sudo dnf install -y starship 2>/dev/null || echo "NOTE: starship not in dnf repos. Install manually: https://starship.rs"
    fi

    if ! command -v ghostty &>/dev/null; then
        echo "NOTE: Install ghostty separately (COPR or from source)."
    fi
fi

# --- Backup existing configs ---
echo ""
echo "=== Backing up existing configs to $BACKUP_DIR ==="
mkdir -p "$BACKUP_DIR"

for dir in sway waybar wofi wlogout swaync fish ghostty tmux; do
    if [ -d "$HOME/.config/$dir" ]; then
        cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
        echo "  Backed up $dir"
    fi
done
[ -f "$HOME/.config/starship.toml" ] && cp "$HOME/.config/starship.toml" "$BACKUP_DIR/"

# --- Copy configs ---
echo ""
echo "=== Installing configs ==="

for dir in sway waybar wofi wlogout swaync fish ghostty tmux; do
    if [ -d "$SCRIPT_DIR/config/$dir" ]; then
        mkdir -p "$HOME/.config/$dir"
        cp -r "$SCRIPT_DIR/config/$dir/." "$HOME/.config/$dir/"
        echo "  Installed $dir"
    fi
done

if [ -f "$SCRIPT_DIR/config/starship.toml" ]; then
    cp "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    echo "  Installed starship.toml"
fi

# --- Wallpaper ---
echo ""
echo "=== Installing wallpaper ==="
mkdir -p "$HOME/Pictures/wallpapers"
if [ -f "$SCRIPT_DIR/wallpaper_grey.png" ]; then
    cp "$SCRIPT_DIR/wallpaper_grey.png" "$HOME/Pictures/wallpapers/"
    echo "  Installed wallpaper"
fi

# --- Set fish as default shell ---
if command -v fish &>/dev/null; then
    FISH_PATH="$(command -v fish)"
    if [ "$SHELL" != "$FISH_PATH" ]; then
        echo ""
        read -p "Set fish as default shell? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if ! grep -q "$FISH_PATH" /etc/shells; then
                echo "$FISH_PATH" | sudo tee -a /etc/shells
            fi
            chsh -s "$FISH_PATH"
            echo "  Default shell set to fish"
        fi
    fi
fi

echo ""
echo "=== Done! ==="
echo "Log out and select 'Sway' from your display manager to get started."
echo "Keybinds: Super+Enter (terminal), Super+d (launcher), Super+p (power menu)"
