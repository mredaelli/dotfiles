function try
    env FZF_DEFAULT_COMMAND=echo fzf -q "$argv" --preview-window=up:99% --preview="eval {q}"
end
