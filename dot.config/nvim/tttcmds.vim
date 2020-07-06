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

" set SSV file as csv compatible file (you need chrisbra/csv.vim)
" 	g:csv_delim=' '		Set delimiter to a space
" 	g:csv_highlight_column='y'
" 				highlight the column on which the cursor is
autocmd BufNewFile,BufRead *.SSV let g:csv_delim=' '
autocmd BufNewFile,BufRead *.TAG let g:csv_highlight_column='y'
autocmd BufNewFile,BufRead *.SSV set filetype=csv

autocmd BufNewFile,BufRead *.TAG let g:csv_delim=' '
autocmd BufNewFile,BufRead *.TAG let g:csv_highlight_column='y'
autocmd BufNewFile,BufRead *.TAG set filetype=csv

autocmd BufNewFile,BufRead *.csv let g:csv_highlight_column='y'
"
" chrisbra/csv.vim
" 	Ctrl-→ or L		move field forwards
" 	Ctrl-← or E		move field backwards
" 	Ctrl-↑ or K		move lines upwards within the same column
" 	Ctrl-↓ or J		move lines downwards within the same column
" 	:CSVNrColumns		show number of columns
" 	:CSVWhatColumn		show current index of columns
