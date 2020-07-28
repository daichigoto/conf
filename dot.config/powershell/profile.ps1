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
# first edition: Mon Jun 22 18:20:36 JST 2020

function path_to_linux {
	$linuxpath = @()

	ForEach($winpath in $Args) {
		if ($winpath -ne $null) {
			if ($winpath -match '^C:') {
				$linuxpath += "/mnt/c" + $winpath.Replace('C:','').Replace('\','/')
			}
			else {
				$linuxpath += $winpath.Replace('\','/')
			}
		}
	}

	$linuxpath
}

function tree {
	wsl tree $(path_to_linux $Args)
}
function grep {
	$Args[-1] = path_to_linux $Args[-1]

	$Input | wsl grep $Args
}
function nvim {
	wsl nvim $(path_to_linux $Args)
}
function less {
	wsl less $(path_to_linux $Args)
}
function lv {
	wsl lv $(path_to_linux $Args)
}

Set-Alias -Name open -Value explorer

function ll {	Get-ChildItem -Force	}
function la {	Get-ChildItem -Force	}

Set-Alias -Name edge -Value "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Set-Alias -Name chrome -Value "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
