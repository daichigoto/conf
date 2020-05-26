" Copyright (c) 2010 ONGS Inc. <info@ongs.co.jp>
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
" first edition: Fri Feb 12 17:15:51 JST 2010
" last modified: $Date$
" version: $Revision$

" Emacs keybind
function! <SID>emacsCtrlK()
  let l:curcolnum = col('.')
  let l:curcoleol = col('$')
  if  1 == l:curcolnum
    normal! D
    join!
    call cursor(line('.'), 1)
  elseif l:curcolnum < l:curcoleol
    normal! D
  elseif l:curcolnum == l:curcoleol
    join!
    call cursor(line('.'), l:curcolnum)
  endif
  return ''
endfunction

function! <SID>emacsCtrlXCtrlW()
  echo 'XXX not implemented yet'
endfunction

" Ctrl-a
imap <silent> <C-a> <C-o>:call cursor(line('.'), 1)<CR>
nmap <silent> <C-a> :call cursor(line('.'), 1)<CRi>

" Ctrl-e
imap <silent> <C-e> <C-o>:call cursor(line('.'), col('$'))<CR>
nmap <silent> <C-e> :call cursor(line('.'), col('$'))<CR>

" Ctrl-k
imap <silent> <C-k> <C-r>=<SID>emacsCtrlK()<CR>
nmap <silent> <C-k> :call <SID>emacsCtrlK()<CR>

" Ctrl-x Ctrl-f
imap <silent> <C-x><C-f> <C-o>:tabnew<CR><C-o>:edit .<CR>
nmap <silent> <C-x><C-f> :tabneb<CR>:edit .<CR>

" Ctrl-x Ctrl-s
imap <silent> <C-x><C-s> <C-o>:write<CR>
nmap <silent> <C-x><C-s> :write<CR>

" Ctrl-x Ctrl-w
imap <silent> <C-x><C-w> <C-o>:call <SID>emacsCtrlXCtrlW()<CR>
nmap <silent> <C-x><C-w> :call <SID>emacsCtrlXCtrlW()<CR>

" Ctrl-x Ctrl-q
imap <silent> <C-x><C-q> <C-o>:quit<CR>
nmap <silent> <C-x><C-q> :quit<CR>

" Backspace
nmap <silent> <BS> Xi
vmap <silent> <BS> di

" Ctrl-w
"imap <silent> <C-w> <BS>
"nmap <silent> <C-w> Xi
"vmap <silent> <C-w> di

" Space
nmap <silent> <Space> i 
vmap <silent> <Space> i 

" Ctrl-x u
imap <silent> <C-x>u <C-o>:undo<CR>
nmap <silent> <C-x>u :undo<CR>

" Ctrl-x Ctrl-u
imap <silent> <C-x><C-u> <C-o>:undo<CR>
nmap <silent> <C-x><C-u> :undo<CR>

" Ctrl-d
imap <silent> <C-d> <C-o>:normal! x<CR>
nmap <silent> <C-d> x

" Ctrl-f
imap <silent> <C-f> <ESC>/
nmap <silent> <C-f> /

" Enter
nmap <silent> <Return> i<CR>

" Ctrl-x 2
imap <silent> <C-x>2 <C-o>:sp<CR>$
nmap <silent> <C-x>2 :sp<CR>$

" Ctrl-x 3
imap <silent> <C-x>3 <C-o>:vsp<CR>$
nmap <silent> <C-x>3 :vsp<CR>$

" Ctrl-x 0
imap <silent> <C-x>0 <C-o>:quit<CR>$
nmap <silent> <C-x>0 :quit<CR>$
