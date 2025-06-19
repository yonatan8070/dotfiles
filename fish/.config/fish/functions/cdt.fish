function cdt --wraps lstr
    if command -q lstr
        set selected_dir (lstr interactive -gGa --icons)

        if test -n "$selected_dir" -a -d "$selected_dir"
            cd "$selected_dir"
        end
    else
        echo "lstr not available, please install it"
    end
end
