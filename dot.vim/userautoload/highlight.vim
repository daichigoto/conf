" Copyright (c) 2010-2012 ONGS Inc. <info@ongs.co.jp>
" All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions
" are met:
"
" 1. Redistributions of source code must retain the above copyright
"    notice, this list of conditions and the following disclaimer.
" 2. Redistributions in binary form must reproduce the above copyright
"    notice, this list of conditions and the following disclaimer in the
"    documentation and/or other materials provided with the distribution.
"
" THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
" ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
" IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
" PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
" BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
" CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
" SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
" INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
" IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
" ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
" THE POSSIBILITY OF SUCH DAMAGE.

" author: Daichi GOTO (daichi@ongs.co.jp)
" first edition: Mon Feb 15 14:28:33 JST 2010
" last modified: $Date$
" version: $Revision$

" default terminal background color
let s:terminalbgcolor = "black"

" default color
"highlight Normal ctermbg=black ctermfg=grey " maybe bug of Terminator, this line should be excluded
highlight StatusLine ctermfg=black ctermbg=grey
highlight CursorLine ctermfg=none ctermbg=darkgray cterm=none
highlight MatchParen ctermfg=none ctermbg=darkgray
highlight Comment ctermfg=DarkGreen ctermbg=NONE
highlight Directory ctermfg=DarkGreen ctermbg=NONE
set cursorline

" reverse video function
function! <SID>reverseVideo()
  if "white" ==? <SID>terminalbgcolor
    let s:terminalbgcolor = "black"
    highlight Normal ctermbg=black ctermfg=grey
    highlight StatusLine ctermfg=black ctermbg=grey
    highlight CursorLine ctermfg=none ctermbg=darkgray cterm=none
    highlight MatchParen ctermfg=none ctermbg=darkgray
    highlight Comment ctermfg=DarkGreen ctermbg=NONE
  else
    let s:terminalbgcolor = "white"
    highlight Normal ctermfg=black
    highlight StatusLine ctermfg=grey ctermbg=black
    highlight CursorLine ctermfg=darkgray ctermbg=none cterm=none
    highlight MatchParen ctermfg=none ctermbg=darkgray
  endif
endfunction

" display syntax/number/list switching function
function! <SID>switchHighLight()
  if !exists("g:syntax_on")
    syntax on
  else
    syntax off
  endif
endfunction

" shortcut key
"nmap <silent> hl :call <SID>switchHighLight()<CR>
"nmap <silent> RV :call <SID>reverseVideo()<CR>
"imap <silent> <C-x>hh <C-o>:call <SID>switchHighLight()<CR>
"imap <silent> <C-x>RV <C-o>:call <SID>reverseVideo()<CR>

" filename extension highlight
au BufNewFile,BufRead *.CSS setfiletype css

" shebang syntax highlight
if did_filetype()
  finish
endif
if getline(1) =~# '^#!.*sh.*'
  setfiletype sh
elseif getline(1) =~# '^\<.*'
  setfiletype html
endif

"" status line for insert-mode or not
"function! <SID>insertModeStatusline()
"  if "white" ==? <SID>terminalbgcolor
"    highlight StatusLine ctermfg=darkblue ctermbg=grey
"  else
"    highlight StatusLine ctermfg=grey ctermbg=darkblue
"  endif
"endfunction
"
"function! <SID>otherModeStatusline()
"  if "white" ==? <SID>terminalbgcolor
"    highlight StatusLine ctermfg=black ctermbg=grey
"  else
"    highlight StatusLine ctermfg=grey ctermbg=black
"  endif
"endfunction
"
"" status line
"call <SID>otherModeStatusline()
"augroup SwitchingStatuslineColor
"  autocmd!
"  autocmd InsertEnter * call <SID>insertModeStatusline()
"  autocmd InsertLeave * call <SID>otherModeStatusline()
"augroup End
