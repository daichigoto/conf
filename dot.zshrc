# users generic .zshrc file for zsh(1)
#
# Copyright (c) 2006 Daichi GOTO <daichi@ongs.co.jp>
# Copyright (c) 2006,2007,2009,2011-2014 ONGS Inc. <info@ongs.co.jp>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
# IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGE.

# author: Daichi GOTO (daichi@ongs.co.jp)
# first edition: Thu Dec 21 22:28:55 2006

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
[ "0" = $UID ] && LANG=en_US.UTF-8

## Default shell configuration
#
# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
# incremental backward/forward search with pattern string binded to ^R/^S
# 
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete

## Command history configuration
#
HISTFILE=$HOME/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

## Completion configuration
#
fpath=($HOME/.zsh/functions/Completion $fpath)

# Skip a compinit compilation to achieve a zsh fast booting up 
# when it was already compiled with 30 days
[ -z "$(find "$HOME" -name .zcompdump -maxdepth 1 -ctime -30d)" ] && {
	autoload -U compinit
	compinit
}

## zsh editor
#
autoload zed

## Prediction configuration
#
#autoload predict-on
#predict-off

## Alias configuration
#
# expand aliases before completing
#
case $OSTYPE in
freebsd*|darwin*)
	alias ls="ls -G -w"
	;;
linux*)
	alias ls="ls --color"
	;;
esac
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias less="less -X"
alias du="du -h"
alias df="df -h"
alias su="su -l"
# for safety
alias rm="noglob rm"

## terminal configuration
#
# undef stop/start cchar for some applications to use C-s/C-q as their keybind
stty start undef
stty stop undef

case $TERM in
xterm*)
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=32' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	;;
kterm-color)
	stty erase '^H'
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=32' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	;;
kterm)
	stty erase '^H'
	;;
cons25)
	unset LANG
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=;32;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	;;
jfbterm-color)
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=;32;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
	;;
*)
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	zstyle ':completion:*' list-colors 'di=32' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
	;;
esac

# set prompt
#
case $TERM in
xterm*)
	autoload colors
	colors
	updateprompt() {
		case ${UID} in
		0)
			PROMPT="%{${fg_bold[red]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%$(($COLUMNS * 4 / 10))<...<%d#%{${reset_color}%}%b "
			PROMPT2="%B%{${fg_bold[red]}%}%_#%{${reset_color}%}%b "
			SPROMPT="%B%{${fg_bold[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
			;;
		*)
			PROMPT="%{${fg_bold[default]}%}%$(($COLUMNS * 5 / 10))<...<%d%%%{${reset_color}%} "
			[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
				PROMPT="%{${fg_bold[default]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %$(($COLUMNS * 4 / 10))<...<%{${fg_bold[default]}%}%d%%%{${reset_color}%} "
			PROMPT2="%{${fg_bold[default]}%}%_%%%{${reset_color}%} "
			SPROMPT="%{${fg_bold[default]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
			;;
		esac
	}
	TRAPWINCH() {
		updateprompt
	}

	# first fire
	updateprompt

	## window title setting
	# echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
	;;
esac

## load user .aliases and .zshrc configuration file
#
[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.zshrc.mine ] && source $HOME/.zshrc.mine
