function fish_title
    if ! test -n "$WEZTERM_CONFIG_DIR"
        set -q argv[1]; or set argv fish
        echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
    end
end
