# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch
unsetopt autocd notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

autoload -Uz compinit
compinit

autoload -U colors
colors

#prompt colors
prompt_color_user=#404040
prompt_color_host=#ee7722
prompt_color_path=#404040
prompt_color_git=#606060
prompt_color_success=#8feb34
prompt_color_fail=#eb4034

#git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

#prompt contemporary
function prompt_contemporary_block
{
	[ -n "$1" ] && content="$1" || content=""
	[ -n "$2" ] && b_c="$2" || b_c="white"
	[ -n "$3" ] && t_c="$3" || t_c="black"
	if [ "$4" ]; then
	    echo "\b%F{$4}%K{$b_c}🭬%k%f%K{$b_c}%F{$t_c}$content %f%k%F{$b_c}🭬%f"
	else
		echo "%F{$b_c}🭨%f%K{$b_c}%F{$t_c}$content %f%k%F{$b_c}🭬%f"
	fi
}
#🭨🭬🭖🭀✔✘
zstyle ':vcs_info:git:*' formats "$(prompt_contemporary_block %b $prompt_color_git white $prompt_color_path)"
PS1=""
PS1+=$(prompt_contemporary_block "%m" "$prompt_color_user" "white")
PS1+=$(prompt_contemporary_block "%n" "$prompt_color_host" "white" "$prompt_color_user")
PS1+=$(prompt_contemporary_block "%~" "$prompt_color_path" "white")
PS1+='${vcs_info_msg_0_}'
PS1+='%0(?.$(prompt_contemporary_block "✔" "#333333" "$prompt_color_success").$(prompt_contemporary_block "✘" "$prompt_color_fail" "white"))'





export WGETRC="$XDG_CONFIG_HOME/wgetrc"

alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias cd..="cd .."
