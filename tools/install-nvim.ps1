#!/usr/bin/env pwsh
#
# Copyright (c) 2021 Daichi GOTO <daichi@ongs.co.jp>
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
# first edition: Fri Jul 31 11:30:49 JST 2020

#===================================================================
# Source and destination directories
#===================================================================
$srcdir='dot.config\nvim'
$dstdir="${HOME}\AppData\Local\nvim"

#===================================================================
# Move to config top directory
#===================================================================
$script_dir = $(Split-Path -Parent $MyInvocation.MyCommand.Path)
$config_dir = $(Split-Path -Parent $script_dir)
Set-Location $config_dir

#===================================================================
# Create the destination directory
#===================================================================
New-Item $dstdir -ItemType Directory > $null 2>&1

#===================================================================
# Install configuration file
#===================================================================
foreach ($src in Get-ChildItem $srcdir) {
	# source file name
	$name = Split-Path $src -Leaf

	# Install if $dst is not exist
	if (-Not (Test-Path $dstdir\$name)) {
		Copy-Item $src $dstdir
		echo "copy $name --> $dstdir\$name"
	}

	# Install when configuration file is updated
	$src_modtime = $(Get-ItemProperty $src).LastWriteTime
	$dst_modtime = $(Get-ItemProperty $dstdir\$name).LastWriteTime
	
	if ($src_modtime -ne $dst_modtime) {
		Copy-Item $src $dstdir
		Set-ItemProperty $dstdir\$name -Name LastWriteTime -Value $src_modtime
		echo "copy $name --> $dstdir\$name"
	}
}

echo "nvim: done"
