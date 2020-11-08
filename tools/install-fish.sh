#!/bin/sh
#
# Copyright (c) 2020 Daichi GOTO <daichi@ongs.co.jp>
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
# first edition: Sun Nov  8 17:31:49 JST 2020

#===================================================================
# Move to config top directory
#===================================================================
cd $(dirname ${0})/../

#===================================================================
# Install configuration files
#===================================================================
config_dir="${HOME}"/.config/fish
mkdir -p "${config_dir}"
for i in dot.config/fish/*fish
do
	src="$i"
	dst="${config_dir}/$(basename "$i")"

	# Do not install if the last update time is the same
	if [ -f $src -a -f $dst ]
	then
		if [ ! "$src" -nt "$dst" -a ! "$src" -ot "$dst" ]
		then
			continue
		fi
	fi

	# Install configuration files
	cp "$src" "$dst"
	touch -r "$src" "$dst"
	echo "copy $src -> $dst"
done
echo "fish: done"
