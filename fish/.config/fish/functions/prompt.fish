function fish_prompt
    set exclude_cmd "bash|less|man|more|ssh|bat|helix|vim|hx|btop|fg"
    if test $CMD_DURATION -gt 1000
        and echo $history[1] | grep -vqE "^($exclude_cmd).*";

        # Show duration of the last command in seconds
        set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3f", $1 / $2}')
        echo -se "Command " (set_color brblue) (echo $history[1] | cut -d " " -f1) (set_color normal) \
                 " finished in " (set_color brgreen) $duration (set_color normal) "s"

        # Send a notification if the command took longer than 30 seconds in case I'm looking at something else
        if test $CMD_DURATION -gt 30000
            if type -q notify-send
                notify-send -u normal -a "Fish" "Command $(echo $history[1] | cut -d " " -f1) finished in $(echo $duration)s"
            end
        end
    end

    set PROMPT_PWD (set_color red)"["(set_color normal)(prompt_pwd --full-length-dirs 100)(set_color red)"]"(set_color normal)
    
    # Print the rest of the prompt
    printf '%s\n%s%s%s@%s%s%s%s > \n' "$PROMPT_PWD" (set_color $fish_color_user) $USER (set_color normal) $hostname (fish_git_prompt)

    if test (echo $FISH_VERSION | string split . -f 1) -lt 4;
        if echo $history[1] | grep -Eq "(^sudo rm)|(^rm)|(^clear)";
            history delete --exact --case-sensitive $history[1]
        end
    end

    #set -U fish_history_merge_variable (math $fish_history_merge_variable + 1)
end
