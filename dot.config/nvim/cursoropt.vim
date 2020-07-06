" Copyright (c) 2020 Daichi GOTO <daichi@ongs.co.jp>
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
" first edition: Mon Jul  6 12:50:17 JST 2020

" move cursor to center of line, scroll line to center of screen
function MoveCurtorToCenterOfScreen()
  let lwinwidth = winwidth('.')
  let lhalfwidth = lwinwidth / 2
  let lwincol = wincol()

  " scroll line to center of screen
  execute("normal zz")
  if lwincol > lhalfwidth
    let offset = lwincol - lhalfwidth
    let index = 0
    " move cursor to center of line
    while index < offset
      execute("normal zl")
      let index = index + 1
    endwhile
  elseif lwincol < lhalfwidth
    let offset = lhalfwidth - lwincol
    let index = 0
    " move cursor to center of line
    while index < offset
      execute("normal zh")
      let index = index + 1
    endwhile
  endif
endfunction

nnoremap cc :call MoveCurtorToCenterOfScreen()<CR>
