# users generic .bashrc file for bash(1)
#
# Copyright (c) 2006,2008 Daichi GOTO <daichi@ongs.co.jp>
# Copyright (c) 2006,2009,2012-2014 ONGS Inc. <info@ongs.co.jp>
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
# first edition: Fri Apr  7 20:04:55 2006

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
[ "0" = $UID ] && LANG=en_US.UTF-8

## Alias configuration
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

## terminal configuration
#
# undef stop/start cchar for some applications to use C-s/C-q as their keybind
stty start undef
stty stop undef
#
# dismiss Ctrl-o for readline's operate-and-get-next
stty discard undef

case $TERM in
xterm*)
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	;;
kterm-color)
	stty erase '^H'
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	;;
kterm)
	stty erase '^H'
	;;
cons25)
	unset LANG
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	;;
jfbterm-color)
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	;;
*)
	export LSCOLORS=cxFxCxdxBxegedabagacad
	export LS_COLORS='di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	;;
esac

# set prompt
#
case $TERM in
xterm*)
	shortpwd() {
		l=$(( ${COLUMNS:-$(tput cols)} * 5 / 10 ))
		[ -z "${PWD:$l:1}" ] && echo $PWD || echo ...${PWD:$((${#PWD} - $l)):$l}
	}
	shortshortpwd() {
		l=$(( ${COLUMNS:-$(tput cols)} * 4 / 10 ))
		[ -z "${PWD:$l:1}" ] && echo $PWD || echo ...${PWD:$((${#PWD} - $l)):$l}
	}
	updateprompt() {
		case $UID in
		0)
			PS1='\[\033[1;36m\]'"$(echo ${HOSTNAME%%.*} | tr '[a-z]' '[A-Z]') "'\[\033[1;31m\]$(shortshortpwd)\$\[\033[0m\] '
			PS2='\[\033[1;31m\]>\[\033[0m\] '
			;;
		*)
			PS1='\[\033[;1;29m\]$(shortpwd)\$\[\033[0m\] '
			[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
				PS1="\[\033[;1;29m\]$(echo ${HOSTNAME%%.*} | tr '[a-z]' '[A-Z]') \[\033[;1;29m\]$(shortshortpwd)\$\[\033[0m\] "
			PS2='\[\033[;1;29m\]>\[\033[0m\] '
			;;
		esac
	}
	PROMPT_COMMAND='updateprompt'
	
	# first fire
	$PROMPT_COMMAND

	## window title setting
	#    PROMPT_COMMAND='echo -e "\033]0;'"${USER}@${HOSTNAME%%.*}:"'${PWD}\007\c"'
	;;
esac

## load user .aliases and .bashrc configuration file
#
[ -f $HOME/.aliases ] && . $HOME/.aliases
[ -f $HOME/.bashrc.mine ] && . $HOME/.bashrc.mine
