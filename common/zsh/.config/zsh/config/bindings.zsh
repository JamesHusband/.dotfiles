# ==============================================================================
# Key Bindings
# ==============================================================================

# Custom key bindings

# Ctrl + Left/Right arrows for word navigation
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Alt + Left/Right arrows for word navigation (alternative)
bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word

# Home/End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Delete key
bindkey '^[[3~' delete-char

# Page Up/Down
bindkey '^[[5~' beginning-of-history
bindkey '^[[6~' end-of-history

# Ctrl + R for reverse history search (already default, but ensuring it's set)
bindkey '^R' history-incremental-search-backward

# Ctrl + S for forward history search
bindkey '^S' history-incremental-search-forward

# Ctrl + P/N for history navigation
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# Alt + P/N for history search
bindkey '^[P' history-search-backward
bindkey '^[N' history-search-forward

# Tab completion
bindkey '^I' expand-or-complete

# Shift + Tab for reverse completion
bindkey '^[[Z' reverse-menu-complete

# Ctrl + Space for expanding glob patterns
bindkey '^@' expand-word

# Ctrl + U to delete from cursor to beginning of line
bindkey '^U' backward-kill-line

# Ctrl + K to delete from cursor to end of line
bindkey '^K' kill-line

# Ctrl + W to delete from cursor to previous word boundary
bindkey '^W' backward-kill-word

# Ctrl + Y to yank (paste)
bindkey '^Y' yank

# Escape + . to insert last word from previous command
bindkey '^[.' insert-last-word

# Smart URL escaping
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
