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

#========================================================================
# Linux commands definition used via wsl
#========================================================================
$_linux_path = @('/usr/local/sbin', '/usr/local/bin', '/usr/sbin', 
                 '/usr/bin', '/sbin', '/bin')
$_linux_command_names = wsl ls $_linux_path 

# Generate Linux command functions
ForEach($n in $_linux_command_names) {
    if ($n -ne "") {
        $_linux_functions += "
            function $n {
                `$Input | wsl $n `$(_path_to_linux `$Args)
            }"
    }
}
$_linux_functions += @'
    function _path_to_linux {
        $linuxpath = @()
    
        # Convert arguments to Linux path style
        ForEach($winpath in $Args) {
            if ($winpath -eq $null) {
                Break
            }
        
            # Change drive path to mount path
            if ($winpath -match '^[A-Z]:') {
                $drive = $winpath.Substring(0,1).ToLower()
                $linuxpath += "/mnt/" + $drive + $winpath.Substring(2).Replace('\','/')
            }
            # Option is not converted
            elseif ($winpath -match '^[-+]') {
                $linuxpath += $winpath
            }
            # Other argument is converted
            else {
                $linuxpath += ([String]$winpath).Replace('\','/')
            }
        }
    
        $linuxpath
    }
'@

# Prepare temporary file path with extension .ps1
$_temp = New-TemporaryFile
$_temp_ps1 = $_temp.FullName + ".ps1"
Remove-Item $_temp

# Write function definition to temporary .ps1 file and parse
$_linux_functions | Out-File $_temp_ps1
. $_temp_ps1
Remove-Item $_temp_ps1

# Delete unnecessary variables
Remove-Variable _temp
Remove-Variable _temp_ps1
#Remove-Variable _linux_path
#Remove-Variable _linux_command_names
#Remove-Variable _linux_functions

#========================================================================
# Individual Linux command function definitions
#========================================================================
# grep
function grep {
    $pattern_exists = $False
    $path_exists = $False
    $skip = $False
    $i = 0

    ForEach($a in $Args) {
        if ($skip) {
            $skip = $False
            $i++
            continue
        }

        # Options without argumetn
        if ($a -cmatch '^-[abcdDEFGHhIiJLlmnOopqRSsUVvwxZ]') {
        }
        # Options with argument
        elseif ($a -cmatch '^-[ABC]') {
            $skip = $True
        }
        # Pattern file specification option
        elseif ($a -ceq '-f') {
            $skip = $True
            $pattern_exists = $True
            $Args[$i+1] = _path_to_linux $Args[$i+1]
        }
        # Pattern specification option
        elseif ($a -ceq '-e') {
            $skip = $True
            $pattern_exists = $True
        }
        # Pattern or file path
        elseif ($a -cnotmatch '^-') {
            if ($pattern_exists) {
                $path_exists = $True
            }
            else {
                $pattern_exists = $True
            }
        }

        $i++
    }

    # Change file path
    if ($path_exists) {
        $Args[-1] = _path_to_linux $Args[-1]
    }

    $Input | wsl grep $Args
}

# ls
Get-Alias ls *> $null && Remove-Item alias:ls
function ls { wsl ls --color=auto $Args }
function ll { ls -l }
function la { ls -a }

#========================================================================
# Alias definition
#========================================================================
Set-Alias -Name open -Value explorer
Set-Alias -Name edge -Value "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Set-Alias -Name chrome -Value "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
