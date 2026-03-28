if status is-interactive

    # No greeting
    set fish_greeting

    # PATH additions
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/.local/bin

    # Rose-pine theme (matching nvim - cyan/pink/purple vibrant)
    set -g fish_color_normal e0ceed           # default text
    set -g fish_color_command 9ccfd8 --bold   # commands (foam/cyan)
    set -g fish_color_keyword 8e6da6 --bold   # keywords (purple)
    set -g fish_color_error fc4649 --bold     # errors
    set -g fish_color_param a29dfa            # parameters (function purple)
    set -g fish_color_option f5b0ef           # options (pink)
    set -g fish_color_quote f5b0ef            # strings (pink)
    set -g fish_color_comment 614e6e          # comments
    set -g fish_color_autosuggestion 614e6e   # autosuggestions
    set -g fish_color_valid_path a29dfa --underline  # valid paths (purple)
    set -g fish_pager_color_prefix 9ccfd8 --bold     # completion prefix (cyan)
    set -g fish_pager_color_completion e0ceed         # completions
    set -g fish_pager_color_description 614e6e        # completion descriptions
    set -g fish_pager_color_selected_background --background=2d2735  # selection

    # Use starship
    starship init fish | source

    # Aliases
    alias clear "printf '\033[2J\033[3J\033[1;1H'" # fix: kitty doesn't clear properly
    alias celar "printf '\033[2J\033[3J\033[1;1H'"
    alias claer "printf '\033[2J\033[3J\033[1;1H'"
    alias ls 'eza --icons'
    alias pamcan 'sudo dnf'
    alias q 'qs -c ii'
    alias peon "bash /home/lambda/.claude/hooks/peon-ping/peon.sh"

end
