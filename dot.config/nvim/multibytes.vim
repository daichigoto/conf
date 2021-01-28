" Copyright (c) 2020,2021 Daichi GOTO <daichi@ongs.co.jp>
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
" first edition: Tue Jul  7 12:51:17 JST 2020

" do not insert white space when concatenating multi-byte characters
set formatoptions+=mM

" add parenthesis combination
set matchpairs+=「:」,（:）,「:」,『:』,【:】,［:］,〈:〉,《:》,〔:〕,[:],｛:｝

" viS - Extend the selection of the sentence to the Japanese
nnoremap vis ?\(。\\|\.\\|^$\\|[>:]\)<CR>lv/\(。\\|\.\\|^$\\|<\\|:\)<CR>

" ( ) - Extend the movement of the sentence to the Japanese
nnoremap ( ?\(。\\|、\\|[.:][ \t\n]\\|[\[>][^<]\)<CR>h?\(。\\|、\\|[.:][ \t\n]\\|[\[>][^<]\)<CR>l
vnoremap ( hh?\(。\\|、\\|[.:][ \t\n]\\|[\[>][^<]\)<CR>l
nnoremap ) /\(。\\|、\\|[.:][ \t\n]\\|[^>]<\/\\|^\n\)<CR>l
vnoremap ) /\(。\\|、\\|[.:][ \t\n]\\|<\/\\|^\n\)<CR>
