
function fish_should_add_to_history
    string match -qr "(^sudo rm)|(^rm)|(^clear)" -- $argv; and return 1
    return 0
end
