# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch
unsetopt autocd notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ahito/.config/zsh/.zshrc'

autoload -Uz compinit
compinit

autoload -U colors
colors

#prompt colors
prompt_color_user=#f0c040
prompt_color_host=#aaaaff
prompt_color_path=#00fff7
prompt_color_git=#aaff00


#git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats " %F{$prompt_color_git}(%b)%f"

#old prompt
#PROMPT="%{%F{11}%}%n%{%F{15}%}@%{%F{214}%}%m %{%F{51}%}%~%{%f%}%0(?.. %F{red}✘%f)${vcs_info_msg_0_} $ "

#prompt construction
PROMPT=""
PROMPT+="%F{$prompt_color_user}%n%f"
PROMPT+="@"
PROMPT+="%F{$prompt_color_host}%m%f "
PROMPT+="%F{$prompt_color_path}%~%f"
PROMPT+='${vcs_info_msg_0_}'
PROMPT+="%0(?.. %F{red}✘%f)"
PROMPT+=' $ ';
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
