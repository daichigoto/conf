# Copyright (c) 2016,2021 Daichi GOTO <daichi@ongs.co.jp>
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

switch $USER
case root toor
	set --export LANG en_US.UTF-8
case '*'
	set --export LANG ja_JP.UTF-8
end	

function prompt_pwd
	set -l realhome ~
	awk -v PWD=(echo $PWD | sed "s|^$realhome|~|") -v COLS=$COLUMNS \
	'BEGIN {
		limit=COLS*4/10
		len=length(PWD)
		if (len>limit) {
			print "..." substr(PWD, len-limit)
		}
		else {
			print PWD
		}
	}'
end

function fish_prompt
  set -q host
	or set host (hostname -s | tr 'a-z' 'A-Z') > /dev/null 2>&1
	set -l color_cwd
	set -l color_hst
	set -l suffix
	switch $USER
	case root toor
		set color_cwd $fish_color_cwd_root
		set color_hst $color_cwd
		set suffix '#'
		echo -n -s (set_color $color_hst) "$host" ' ' (set_color $color_cwd) (prompt_pwd) "$suffix " (set_color normal)
	case '*'
		set color_cwd $fish_color_cwd
		set color_hst white
		set suffix '%'
		echo -n -s "$host" ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
	end
end

switch $TERM
case 'xterm*' 'vt*'
	set --export LSCOLORS cxFxCxdxBxegedabagacad
	set --export LS_COLORS 'di=32:ln=35:so=01:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	set --export CLICOLOR
case 'cons25'
	set --export LSCOLORS cxFxCxdxBxegedabagacad
	set --export LS_COLORS 'di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	set --export CLICOLOR
case '*'
	set --export LSCOLORS cxFxCxdxBxegedabagacad
	set --export LS_COLORS 'di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
	set --export CLICOLOR
end

alias less="less -X"
alias du="du -h"
alias df="df -h"
alias su="su -l"
alias dir="ls -l"

## shortcut keys
bind \cD kill-word		# Ctrl-d
bind \cW backward-kill-word	# Ctrl-w

## load user .aliases*
function source_alias --description "source ~/.aliase* of Bourne Shell"
  for f in ~/.aliases*
    grep '^[a-z0-9][a-z0-9_-]*=' "$f" | sed 's/^/set /' | sed 's/=/ /' | source
    grep '^alias ' "$f" | sed -e 's/$(/(/g' -e 's/&&/; and /g' | source
  end
end
source_alias

[ -f ~/.fishrc ]
and source ~/.fishrc
