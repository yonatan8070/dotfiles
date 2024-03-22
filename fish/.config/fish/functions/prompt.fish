function fish_prompt
    set exclude_cmd "bash|less|man|more|ssh|bat|helix|vim|hx|btop|fg"
    if begin
        test $CMD_DURATION -gt 1000
        and echo $history[1] | grep -vqE "^($exclude_cmd).*"
    end

        # Show duration of the last command in seconds
        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3f", $1 / $2}')
        echo -se "Command " (set_color brblue) $(echo $history[1] | cut -d " " -f1) (set_color normal) \
                 " finished in " (set_color brgreen) $duration (set_color normal) "s"

        # Send a notification if the command took longer than 30 seconds in case I'm looking at something else
        if test $CMD_DURATION -gt 30000
            if type -q notify-send
                notify-send -u normal -a "Fish" "Command $(echo $history[1] | cut -d " " -f1) finished in $(echo $duration)s"
            end
        end
    end

    if test "$LAST_PWD" != "$PWD"
        set PROMPT_PWD (prompt_pwd --full-length-dirs 100)
        set -g LAST_PWD "$PWD"
    else
        set PROMPT_PWD (echo -en "\b")
    end
    
    # Print the rest of the prompt
    printf '%s%s%s@%s %s%s%s%s > \n' (set_color $fish_color_user) $USER (set_color normal) $hostname \
        (set_color $fish_color_cwd) "$PROMPT_PWD" (set_color normal) (fish_git_prompt)

    if echo $history[1] | grep -Eq "(^sudo rm)|(^rm)|(^clear)";
        history delete --exact --case-sensitive $history[1]
    end
end
