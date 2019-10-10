" users generic .vimrc file for vim(1)
"
" Copyright (c) 2001-2004 Daichi GOTO <daichi@ongs.co.jp>
" Copyright (c) 2006,2009-2012,2015 ONGS Inc. <info@ongs.co.jp>
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

" full vim mode
set nocompatible

" evim.vim will already have done these configuration.
if v:progname == "evim"
  finish
endif

" allow [Backspace] over insert mode to remove charactors
"  start - allow all charactors to remove
"  eol - allow to remove eol and join lines
"  indent - allow to remove indent in autoindent mode
set backspace=start,eol,indent

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

" mouse feature off
set mouse=

" syntax highlight on
syntax on
set nohlsearch " non-highlight for search keyword
set cursorline " use cursorline indicator

" line numbers on
set number

" status line on
set laststatus=2 " always displaying status line
set statusline=%F%r%h%= " statusline format

" incremental search and not case-sensitive on
set incsearch
set ignorecase

" use extended menu complementation feature
set wildmenu wildmode=list:full

" use decimal instead of octal
set nrformats=

" set tab indent depth
autocmd Filetype xml set tabstop=1 shiftwidth=1 softtabstop=1
autocmd Filetype html set tabstop=1 shiftwidth=1 softtabstop=1

" displayed line movement gj/gk as default instead of j/k
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" for useful argdo mutli-files replaces
set hidden

" autoload configurations files
set runtimepath+=~/.vim/
runtime! userautoload/*.vim

" load user .vimrc configuration file
if filereadable(expand('~/.vimrc.mine'))
  source ~/.vimrc.mine
endif
