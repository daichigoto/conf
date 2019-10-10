" users generic init.vim file for nvim(1)
"
" Copyright (c) 2001-2004 Daichi GOTO <daichi@ongs.co.jp>
" Copyright (c) 2006,2009-2012,2015,2016 ONGS Inc. <info@ongs.co.jp>
" Copyright (c) 2010 Hiroaki TOMIDA <7gou@kiku33.com>
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

" author: Daichi GOTO (daichi@ongs.co.jp), Hiroaki TOMIDA (7gou@kiku33.com)
" first edition: Fri May 17 12:31:53 JST 2002
" last modified: $Date: 2006-05-16 14:14:35 $
" version: $Revision: 1.11 $

" mouse feature off
set mouse=

set pastetoggle=<F2>

" plug-ins management
" git clone https://github.com/Shougo/dein.vim ~/.config/nvim/dein.vim
if isdirectory(expand('~/.config/nvim/dein.vim'))
	set runtimepath+=~/.config/nvim/dein.vim
	call dein#begin(expand('~/.config/nvim/dein'))
	call dein#add('Shougo/unite.vim')
	call dein#add('junegunn/seoul256.vim')
	call dein#end()

	" Unite
	nnoremap <silent> <C-o> :<C-u>Unite file buffer<CR>
	autocmd FileType unite nmap <silent><buffer> <ESC><ESC> q

	" seoul256
	let g:seoul256_background = 233
	colo seoul256
endif

" allow some keys to move the cursor left/right to move to 
" the previous/next line when the cursor is on the first/last
" character in the line.
"  b - [Backspace]  normal visual 
"  s - [Space]      normal visual
"  < - [Left]       normal visual
"  > - [Right]      normal visual
"  [ - [Left]       insert replace
"  ] - [Right]      insert replace
"  ~ - ~            normal
set whichwrap=b,s,[,],<,>,~,h,l

" syntax highlight on
syntax on
set nohlsearch " non-highlight for search keyword<Paste>
set cursorline " use cursorline indicator

" line numbers on
set number

" incremental search and not case-sensitive on
set ignorecase

" use extended menu complementation feature
set wildmenu wildmode=list:full

" displayed line movement gj/gk as default instead of j/k
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" tab jump
nmap <silent> <Tab> 15<Right>
vmap <silent> <Tab> <C-o>15<Right>
nmap <silent> <S-Tab> 15<Left>
vmap <silent> <S-Tab> <C-o>15<Left>

" for useful argdo mutli-files replaces
set hidden

" laod some ustomized files: ~/.config/nvim/*.vim
let customvims = globpath(expand('~/.config/nvim'), "*.vim")
while strlen(customvims) > 0
	let i = stridx(customvims, "\n")
	if i < 0
		let f = customvims
		let customvims = ""
	else
		let f = strpart(customvims, 0, i)
		let customvims = strpart(customvims, i+1, 9999)
	endif
	if f !~ '\s*/init.vim' && filereadable(f)
		exe 'source ' . f
	endif
	unlet f
	unlet i
endwhile
unlet customvims

" load user .nvimrc configuration file
if filereadable(expand('~/.nvimrc'))
	source ~/.nvimrc
endif
