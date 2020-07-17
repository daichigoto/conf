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
" first edition: Mon Jul  6 18:41:38 JST 2020

" added sh compatible file name extension
autocmd BufNewFile,BufRead *.OSH set filetype=sh
autocmd BufNewFile,BufRead *.SH  set filetype=sh
autocmd BufNewFile,BufRead *.RC  set filetype=sh
autocmd BufNewFile,BufRead mk_*  set filetype=sh

" set SSV file as csv compatible file (you need chrisbra/csv.vim)
"   chrisbra/csv.vim
" 	Ctrl-→ or L		move field forwards
" 	Ctrl-← or E		move field backwards
" 	Ctrl-↑ or K		move lines upwards within the same column
" 	Ctrl-↓ or J		move lines downwards within the same column
"
" 	:%ArrangeCol		show in table style (experimental)
" 	:HiColumn		highlight current column (:HiColumn!)
" 	:Header			separate header (:Header!)
" 	:VHeader		separate vertical header (:VHeader!)
" 	:Search COL /PATTERN/	search specified column
" 	:WhatCol		show current index of columns
" 	:NrCol			show number of columns
"
" 	g:csv_delim=' '		set delimiter to a space
" 	b:csv_headerline=0	no head lines
"	g:csv_no_conceal=1	do not use vertical line display
"	
autocmd BufNewFile,BufRead *.SSV let g:csv_delim=' '
autocmd BufNewFile,BufRead *.SSV let b:csv_headerline=0
autocmd BufNewFile,BufRead *.SSV set filetype=csv

autocmd BufNewFile,BufRead *.ssv let g:csv_delim=' '
autocmd BufNewFile,BufRead *.ssv let b:csv_headerline=0
autocmd BufNewFile,BufRead *.ssv set filetype=csv

autocmd BufNewFile,BufRead *.TAG let g:csv_delim=' '
autocmd BufNewFile,BufRead *.TAG set filetype=csv

autocmd BufNewFile,BufRead *.tsv let g:csv_no_conceal=1
autocmd BufNewFile,BufRead *.tsv set tabstop=20
autocmd BufNewFile,BufRead *.tsv set filetype=csv

" move to the specified column of CSV, or show the number of columns 
" if no column is specified
function TTTCSVMoveToColumn(...)
  if a:0 == 0
    CSVNrColumns
  else
    let cmd = "normal 0"
    execute(cmd)

    let offset = a:1 - 1
    let cmd = "normal " . offset . "L"
    execute(cmd)
  end
endfunction
command -nargs=? Retu call TTTCSVMoveToColumn(<f-args>)
command -nargs=? R call TTTCSVMoveToColumn(<f-args>)

" show the header name of the specified column of CSV, or show the 
" header name of the current column if no column is specified
function TTTCSVShowHeaderNameOfColumn(...)
  if a:0 == 0
    CSVWhatColumn!
  else
    let cursor_pos = getpos(".")
    call TTTCSVMoveToColumn(a:1)
    CSVWhatColumn!
    call setpos('.',cursor_pos)
  end
endfunction
command -nargs=? Retuname call TTTCSVShowHeaderNameOfColumn(<f-args>)
command -nargs=? Retumei call TTTCSVShowHeaderNameOfColumn(<f-args>)
