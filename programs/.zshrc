# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) #include dotfiles

# vim mode
bindkey -v
export KEYTIMEOUT=20

# vim keys in drop down menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey jj vi-cmd-mode

# aliases
alias v="nvim"
alias l="ls --color=auto -l"
alias la="ls --color=auto -la"
alias jukit_kitty="kitty --listen-on=unix:@"$(date +%s%N)" -o allow_remote_control=yes"
alias hms="home-manager switch --flake ~jay/.dotfiles"
alias tn="tmux-new"

export FZF_DEFAULT_COMMAND="fd"
#export FZF_DEFAULT_COMMAND="fd --hidden . $HOME"  # include dotfiles in search
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

#load zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi
source /usr/share/autojump/autojump.zsh 2>/dev/null

tmux-new() {
    session=$(sesh list | fzf)
    sesh connect "$session"
}

stty -ixon

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
