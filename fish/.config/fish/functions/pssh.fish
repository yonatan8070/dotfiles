function pssh --description "Ping host until reachable, then ssh" --wraps ssh
    if test (count $argv) -eq 0
        echo "Usage: pssh [ssh arguments...] host [command]"
        return 1
    end

    set -l dest
    set -l end_of_options 0

    for arg in $argv
        if test "$end_of_options" -eq 0
            if test "$arg" = "--"
                set end_of_options 1
                continue
            end

            if string match -qr '^-' -- $arg
                continue
            end
        end

        set dest $arg
        break
    end

    if test -z "$dest"
        echo "Could not determine SSH destination"
        return 1
    end

    set -l config (command ssh -G $argv 2>/dev/null)

    if test -z "$config"
        echo "Could not resolve SSH configuration for '$dest'"
        return 1
    end

    set -l host (string match -r '^hostname .*' -- $config | string replace 'hostname ' '')
    set -l proxyjump (string match -r '^proxyjump .*' -- $config | string replace 'proxyjump ' '')

    if test -z "$host"
        echo "Could not resolve hostname for '$dest'"
        return 1
    end

    echo "Waiting for $host..."

    if test "$proxyjump" != "none" -a -n "$proxyjump"
        while not command ssh -o BatchMode=yes \
                -o ConnectTimeout=3 \
                -o ConnectionAttempts=1 \
                -o StrictHostKeyChecking=yes \
                -o NumberOfPasswordPrompts=0 \
                $argv true >/dev/null 2>&1
            sleep 1
        end
    else
        while not ping -c 1 -W 1 "$host" >/dev/null 2>&1
            sleep 1
        end
    end

    echo "$host is reachable, connecting..."
    command ssh $argv
end
