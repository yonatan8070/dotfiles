if set -q XDG_SESSION_DESKTOP
    set -x _JAVA_AWT_WM_NONREPARENTING 1 # Used to make Java apps work properly under Wayland
    set -x MOZ_ENABLE_WAYLAND 1 # Enables Wayland for Firefox
    set -x XCURSOR_THEME Breeze_Snow
end

if test -d "$HOME/.local/opt/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/"
    fish_add_path "$HOME/.local/opt/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/"
end

if test -d ~/.cargo/bin
    fish_add_path ~/.cargo/bin
end

if test -d /home/yonatan/.local/bin
    fish_add_path /home/yonatan/.local/bin
end

# I have no idea why this isn't done automatically but whatever
set -x LC_ALL "en_US.UTF-8"

# Make bat colorize man pages
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Allow less to show stuff like archives
# set -x LESSOPEN "|lesspipe.sh %s"

if command -q helix
    set -x EDITOR helix
    alias hx="helix"
else
    set -x EDITOR hx
end

if command -q tailscale
    tailscale completion fish | source
end


set fish_greeting (set_color C41202 --bold)">"(set_color normal) Welcome, operator. Using (fish --version | sed 's/, version//'). Good luck.

alias ip="ip -h"
alias imgcat="wezterm imgcat"
alias dcr="docker compose down && docker-compose up -d"
alias miniterm="python3 -m serial.tools.miniterm -e"
alias rm="rm -v"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias uuuu="cd ../../../.."

if command -q exa
    alias ls="exa"
    alias ll="exa -lah"
    alias tree="exa --tree"
end

if command -q eza
    alias ls="eza"
    alias ll="eza -lah"
    alias tree="eza --tree"
end

. "$HOME/.config/fish/functions/prompt.fish"


if command -q zoxide
    zoxide init fish --cmd cd | source
end

