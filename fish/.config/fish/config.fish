if set -q XDG_SESSION_DESKTOP
    set -x _JAVA_AWT_WM_NONREPARENTING 1 # Used to make Java apps work properly under Wayland
    set -x MOZ_ENABLE_WAYLAND 1 # Enables Wayland for Firefox
    set -x XCURSOR_THEME Breeze_Snow
end

# I have no idea why this isn't done automatically but whatever
set -x LC_ALL "en_US.UTF-8"

# Make bat colorize man pages
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Allow less to show stuff like archives
set -x LESSOPEN "|lesspipe.sh %s"

set -x EDITOR helix
alias hx="helix"

set fish_greeting (set_color C41202 --bold)">"(set_color normal) Welcome, operator. Using (fish --version | sed 's/, version//'). Good luck.

alias miniterm="python3 -m serial.tools.miniterm -e"
alias rm="rm -v"
alias ls="exa"
alias ll="exa -lah"
alias tree="exa --tree"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias uuuu="cd ../../../.."
