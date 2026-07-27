set -U fish_greeting ""
starship init fish | source
alias ls='eza -lah --icons'
alias cat='bat'
# Environment
set -gx EDITOR nvim
set -gx VISUAL nvim

# History
set -g fish_history fish

fzf --fish | source
zoxide init fish | source
