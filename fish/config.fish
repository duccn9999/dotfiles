set -U fish_greeting ""
starship init fish | source
# Long views
alias l='eza -blF --git --header --group-directories-first --icons=auto --color=auto'
alias ls='eza -la --git --header --octal-permissions --group-directories-first --icons=auto --color=auto'
alias la='eza -la --git --header --group-directories-first --icons=auto --color=auto'
alias lm='eza -l --git --header --sort=modified --reverse --group-directories-first --icons=auto --color=auto'

# Compact and specialist views
alias l1='eza --oneline --group-directories-first --icons=auto --color=auto'
alias lt='eza --tree --level=2 --group-directories-first --icons=auto --color=auto'
alias l.='eza -a --oneline --color=never | grep -E "^\."'
alias cat='bat'

set -gx EDITOR nvim
set -gx VISUAL nvim

# History
set -g fish_history fish

fzf --fish | source
zoxide init fish | source


set -U fish_user_paths $HOME/go/bin $fish_user_path

set -x PKG_CONFIG_PATH (nix eval --raw nixpkgs#openssl.dev)/lib/pkgconfig $PKG_CONFIG_PATH
