# Copyright (c) 2020,2021 Daichi GOTO <daichi@ongs.co.jp>
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
# Set encoding to UTF-8
#========================================================================
# [System.Console]::OutputEncoding is set to local encoding, so character 
# corruption occurs when piped from WSL to WSL. Therefore, set 
# [System.Console]::OutputEncoding and $OutputEncoding to UTF-8 to avoid 
# the problem.
$OutputEncoding = [System.Console]::OutputEncoding =
    [System.Text.UTF8Encoding]::new()

#========================================================================
# Linux commands integration mode
#========================================================================
function linuxcmds {

    #----------------------------------------------------------------
    # Definition of Linux commands used via wsl
    #----------------------------------------------------------------
    # Linux pagers
    $_linux_pagers = @("less", "lv")
    
    # Linux PATH and commands
    Write-Host "checking linux commands:"
    $_linux_path = (wsl echo '$PATH').Split(":") -NotMatch "/mnt"
    $_linux_command_paths = (
        wsl ls -d ($_linux_path[($_linux_path.Length - 1)..0] -replace 
            "$","/*")
    ) 2> $null
    
    # Generate Linux commands functions
    ForEach($n in $_linux_command_paths) {
        $_n = (Split-Path -Leaf $n)
        $_linux_functions += "
            function global:$_n {
                if (`$Input.Length) {
                    `$Input.Reset()
                    `$Input | wsl $n ([String]`$(_path_to_linux 
                        `$Args)).Split(' ')
                }
                else {
                    wsl $n ([String]`$(_path_to_linux `$Args)).Split(' ')
                }
            }
            Write-Host -NoNewline .
        "
        Write-Host -NoNewline '_'
    }
    
    # Generate Linux pagers functions
    ForEach($_n in $_linux_pagers) {
        $_linux_functions += "
            function global:$_n {
                if (`$Input.Length) { 
                    `$Input.Reset(); 
            
                    # Prepare temporary file path
                    `$_temp = New-TemporaryFile
            
                    # Write data from pipeline to the temporary file
                    `$Input | Out-File `$_temp
            
                    # Do $_n
                    wsl $_n `$(_path_to_linux `$Args).Split(' ') ``
                        `$(_path_to_linux `$_temp.ToString()).Split(' ')
            
                    # Delete unnecessary temporary file and variable
                    Remove-Item `$_temp
                    Remove-Variable _temp
                } 
                else { 
                    wsl $_n `$(_path_to_linux `$Args).Split(' ')
                }
            }
            Write-Host -NoNewline .
        "
        Write-Host -NoNewline '_'
    }
    
    # Function that converts Windows paths to Linux paths
    $_linux_functions += @'
        function global:_path_to_linux {
            $linuxpath = @()
        
            # Convert arguments to Linux path style
            ForEach($winpath in $Args) {
                if ($winpath -eq $null) {
                    Break
                }
            
                # Change drive path to mount path
                if ($winpath -match '^[A-Z]:') {
                    $drive = $winpath.Substring(0,1).ToLower()
                    $linuxpath += "/mnt/" + $drive + 
		        $winpath.Substring(2).Replace('\','/')
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
        Write-Host .
'@
    Write-Host -NoNewline '_'
    
    # Prepare temporary file path with extension .ps1
    $_temp = New-TemporaryFile
    $_temp_ps1 = $_temp.FullName + ".ps1"
    Remove-Item $_temp
    
    # Write function definition to temporary .ps1 file and parse
    $_linux_functions | Out-File $_temp_ps1
    Write-Host
    Write-Host "functionizing linux commands:"
    . $_temp_ps1
    Remove-Item $_temp_ps1
    
    # Delete unnecessary variables
    Remove-Variable n
    Remove-Variable _n
    Remove-Variable _temp
    Remove-Variable _temp_ps1
    Remove-Variable _linux_pagers
    Remove-Variable _linux_path
    Remove-Variable _linux_command_paths
    Remove-Variable _linux_functions
    
    #----------------------------------------------------------------
    # Individual Linux command function definitions
    #----------------------------------------------------------------
    # grep
    function global:grep {
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
    function global:ls { wsl ls --color=auto $(_path_to_linux 
        $Args).Split(' ') }
    function global:ll { ls -l $(_path_to_linux $Args).Split(' ') }
    function global:la { ls -a $(_path_to_linux $Args).Split(' ') }
}
    
#========================================================================
# Alias definition
#========================================================================
Set-Alias -Name open -Value explorer
Set-Alias -Name edge -Value `
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
Set-Alias -Name chrome -Value `
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
Get-Alias man *> $null && Remove-Item alias:man

#========================================================================
# cd shortcuts
#========================================================================
#function cd1 { cd (dir -Directory)[-1] }
#function cd2 { cd (dir -Directory)[-2] }
#function cd3 { cd (dir -Directory)[-3] }
#function cd4 { cd (dir -Directory)[-4] }
#function cd5 { cd (dir -Directory)[-5] }
#function cd6 { cd (dir -Directory)[-6] }
#function cd7 { cd (dir -Directory)[-7] }
#function cd8 { cd (dir -Directory)[-8] }
#function cd9 { cd (dir -Directory)[-9] }
#function cd10 { cd (dir -Directory)[-10] }
#function cd11 { cd (dir -Directory)[-11] }
#function cd12 { cd (dir -Directory)[-12] }
#function cd13 { cd (dir -Directory)[-13] }
#function cd14 { cd (dir -Directory)[-14] }
#function cd15 { cd (dir -Directory)[-15] }
#function cd16 { cd (dir -Directory)[-16] }
#function cd17 { cd (dir -Directory)[-17] }
#function cd18 { cd (dir -Directory)[-18] }
#function cd19 { cd (dir -Directory)[-19] }
#function cd20 { cd (dir -Directory)[-20] }
function cd1 { cd (dir | Select-String -Pattern '[0-9]{8}')[-1] }
function cd2 { cd (dir | Select-String -Pattern '[0-9]{8}')[-2] }
function cd3 { cd (dir | Select-String -Pattern '[0-9]{8}')[-3] }
function cd4 { cd (dir | Select-String -Pattern '[0-9]{8}')[-4] }
function cd5 { cd (dir | Select-String -Pattern '[0-9]{8}')[-5] }
function cd6 { cd (dir | Select-String -Pattern '[0-9]{8}')[-6] }
function cd7 { cd (dir | Select-String -Pattern '[0-9]{8}')[-7] }
function cd8 { cd (dir | Select-String -Pattern '[0-9]{8}')[-8] }
function cd9 { cd (dir | Select-String -Pattern '[0-9]{8}')[-9] }
function cd10 { cd (dir | Select-String -Pattern '[0-9]{8}')[-10] }
function cd11 { cd (dir | Select-String -Pattern '[0-9]{8}')[-11] }
function cd12 { cd (dir | Select-String -Pattern '[0-9]{8}')[-12] }
function cd13 { cd (dir | Select-String -Pattern '[0-9]{8}')[-13] }
function cd14 { cd (dir | Select-String -Pattern '[0-9]{8}')[-14] }
function cd15 { cd (dir | Select-String -Pattern '[0-9]{8}')[-15] }
function cd16 { cd (dir | Select-String -Pattern '[0-9]{8}')[-16] }
function cd17 { cd (dir | Select-String -Pattern '[0-9]{8}')[-17] }
function cd18 { cd (dir | Select-String -Pattern '[0-9]{8}')[-18] }
function cd19 { cd (dir | Select-String -Pattern '[0-9]{8}')[-19] }
function cd20 { cd (dir | Select-String -Pattern '[0-9]{8}')[-20] }

#========================================================================
# utilities shortcuts
#========================================================================
function genkey { openssl rand -base64 20 }
function tree { tree.com /f }

#========================================================================
# load ~/.profile.ps1
#========================================================================
if (Test-Path ~/.profile.ps1) {
            . ~/.profile.ps1
}
