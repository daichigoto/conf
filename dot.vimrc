" users generic .vimrc file for vim(1)
"
" Copyright (c) 2001-2021 Daichi GOTO <daichi@ongs.co.jp>
" Copyright (c) 2006,2009-2012,2015,2019 ONGS Inc. <info@ongs.co.jp>
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

" ----------------------------------------------------------------------
" Dein plug-ins management system
" ----------------------------------------------------------------------
" How to install Dein (UNIX):
"   mkdir -p ~/.cache/vim/dein
"   cd ~/.cache/vim/dein/
"   curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
"   sh ./installer.sh .
"   rm ./installer.sh
" ----------------------------------------------------------------------
" How to install Dein (Windows):
"   mkdir ~\.cache\vim\dein
"   cd ~\.cache\vim\dein\
"   Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
"   ./installer.ps1 .
"   del ./installer.ps1
" ----------------------------------------------------------------------
if &compatible
	set nocompatible
endif

" Required:
set runtimepath+=~/.cache/vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/vim/dein')
	call dein#begin('~/.cache/vim/dein/')

	" Let dein manage dein
	" Required:
	call dein#add('Shougo/dein.vim')

	" Add or remove your plugins here
	call dein#add('junegunn/seoul256.vim')
	call dein#add('fholgado/minibufexpl.vim')
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('junegunn/fzf', {'build': './install --all'})
	call dein#add('junegunn/fzf.vim')
	call dein#add('sheerun/vim-polyglot')
	call dein#add('dense-analysis/ale')
	call dein#add('tpope/vim-commentary')
	call dein#add('junegunn/vim-easy-align')
	"call dein#add('preservim/nerdtree')
	"call dein#add('Shougo/denite.nvim')
	"call dein#add('roxma/nvim-yarp') " required by denite.vim
	"call dein#add('roxma/vim-hug-neovim-rpc') " required by denite.vim
	"call dein#add('tpope/vim-fugitive')

	" Required:
	call dein#end()
	call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

" ----------------------------------------------------------------------
" Settings for each plugin
" ----------------------------------------------------------------------
" seoul256
let g:seoul256_background = 233
colo seoul256

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'

" minibufexpl
"  bn		move to next buffer
"  b1		move to buffer 1
"  b2		move to buffer 2
"  b3		move to buffer 3
"  b4		move to buffer 4
"  b5		move to buffer 5
"  b6		move to buffer 6
"  b7		move to buffer 7
"  b8		move to buffer 8
"  b9		move to buffer 9
nnoremap <silent> <C-t> :bnext<CR>
"nnoremap <silent> bn :<C-u>:bnext<CR>
"nnoremap <silent> b1 :<C-u>:b1<CR>
"nnoremap <silent> b2 :<C-u>:b2<CR>
"nnoremap <silent> b3 :<C-u>:b3<CR>
"nnoremap <silent> b4 :<C-u>:b4<CR>
"nnoremap <silent> b5 :<C-u>:b5<CR>
"nnoremap <silent> b6 :<C-u>:b6<CR>
"nnoremap <silent> b7 :<C-u>:b7<CR>
"nnoremap <silent> b8 :<C-u>:b8<CR>
"nnoremap <silent> b9 :<C-u>:b9<CR>
let g:miniBufExplorerMoreThanOne = 0 " always show MiniBufExplorer

" fzf
"  fzf		list files and directories
"  ls		list buffers
nnoremap <silent> <C-o> :Files<CR>
nnoremap <silent> fzf :Files<CR>
nnoremap <silent> bu :Buffers<CR>

" vim-easy-align
"  ga		start interactive EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" NERDTree
"  <C-o> open NERDTree
"    <C-o>      close NERDTree
"    <CR>       open file and close NERDTree
"nnoremap <silent> <C-o> :NERDTreeToggle<CR>
"let g:NERDTreeQuitOnOpen = 1

" denite
"  <C-b> open Denite-buffer-list
"    <C-b>	close Denite-buffer-list
"    <Esc>	close Denite-buffer-list
"    <Space>	select multiple buffers
"    <CR>	open buffers
"    o		open buffers
"    s		open buffers in split windows (horizonal)
"    v		open buffers in split windows (vertical)
"    i		filter by string
"    ..		move to directory above
"
" If you use Denite, also execute the following command:
" 	pip install --user pynvim
"
"nnoremap <silent> <C-b> :<C-u>Denite buffer file:new<CR>
"autocmd FileType denite call s:denite_my_settings()
"function! s:denite_my_settings() abort
"	nnoremap <silent><buffer><expr> <C-b>
"		\ denite#do_map('quit')
"	nnoremap <silent><buffer><expr> <Esc>
"		\ denite#do_map('quit')
"	nnoremap <silent><buffer><expr> <Space>
"		\ denite#do_map('toggle_select').'j'
"	nnoremap <silent><buffer><expr> <CR>
"		\ denite#do_map('do_action')
"	nnoremap <silent><buffer><expr> o
"		\ denite#do_map('do_action')
"	nnoremap <silent><buffer><expr> s
"		\ denite#do_map('do_action', 'split')
"	nnoremap <silent><buffer><expr> v
"		\ denite#do_map('do_action', 'vsplit')
"	nnoremap <silent><buffer><expr> i
"		\ denite#do_map('open_filter_buffer')
"	nnoremap <silent><buffer><expr> ..
"		\ denite#do_map('move_up_path')
"endfunction

" denite
"  <C-o> open Denite-file-buffer-list
"    <C-o>	close Denite-file-buffer-list
"    <Esc>	close Denite-file-buffer-list
"    <Space>	select multiple files/buffers
"    <CR>	open files/buffers
"    o		open files/buffers
"    s		open files/buffers in split windows (horizonal)
"    v		open files/buffers in split windows (vertical)
"    i		filter by string
"    ..		move to directory above
"
" If you use Denite, also execute the following command:
" 	pip install --user pynvim
"
"nnoremap <silent> <C-o> :<C-u>Denite file buffer file:new<CR>
"autocmd FileType denite call s:denite_my_settings()
"function! s:denite_my_settings() abort
"	nnoremap <silent><buffer><expr> <C-o>
"		\ denite#do_map('quit')
"	nnoremap <silent><buffer><expr> <Esc>
"		\ denite#do_map('quit')
"	nnoremap <silent><buffer><expr> <Space>
"		\ denite#do_map('toggle_select').'j'
"	nnoremap <silent><buffer><expr> <CR>
"		\ denite#do_map('do_action')
"	nnoremap <silent><buffer><expr> o
"		\ denite#do_map('do_action')
"	nnoremap <silent><buffer><expr> s
"		\ denite#do_map('do_action', 'split')
"	nnoremap <silent><buffer><expr> v
"		\ denite#do_map('do_action', 'vsplit')
"	nnoremap <silent><buffer><expr> i
"		\ denite#do_map('open_filter_buffer')
"	nnoremap <silent><buffer><expr> ..
"		\ denite#do_map('move_up_path')
"endfunction

" ----------------------------------------------------------------------
" Other settings
" ----------------------------------------------------------------------
" disable mouse feature
set mouse=

" non-highlight for search keyword
set nohlsearch

" use cursorline indicator
set cursorline 

" enable line numbers
set number

" enable incremental search and non-case-sensitive
set ignorecase

" use extended menu complementation feature
set wildmenu wildmode=list:full

" use decimal instead of octal
set nrformats=

" for useful argdo mutli-files replaces
set hidden

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

" displayed line movement gj/gk as default instead of j/k
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" set the left side of the w key (q on US keyboard) to move in the opposite
" direction of w
nnoremap q b

" tab jump
nmap <silent> <Tab> 15<Right>
vmap <silent> <Tab> <C-o>15<Right>
nmap <silent> <S-Tab> 15<Left>
vmap <silent> <S-Tab> <C-o>15<Left>

" C-a   Move to the beginning of the line
" C-e   Move to the end of line
nnoremap <C-a> <Home>
inoremap <C-a> <Home>
cnoremap <C-a> <Home>
vnoremap <C-a> <Home>
nnoremap <C-e> <End>
inoremap <C-e> <End>
cnoremap <C-e> <End>
vnoremap <C-e> <End>

" ><    Move to the next empty element
" <>    Move to the pre empty element (Opposite direction of ><)
" ""    Move to the next empty double quotation
" ''    Move to the next empty single quotation
" ::    Move to the pre empty double quotation (Opposite direction of "")
" ;;    Move to the pre empty single quotation (Opposite direction of '')
nnoremap >< /<\([^>/]\+\)><\/\1><CR>/<<CR>
nnoremap <> ?<<CR>h?<\([^>/]\+\)><\/\1><CR>/<<CR>
nnoremap "" /""<CR>l
nnoremap '' /''<CR>l
nnoremap :: hh?""<CR>l
nnoremap ;; hh?''<CR>l

" Move cursor to center of line, scroll line to center of screen
function MoveCurtorToCenterOfScreen()
  let lwinheight = winheight('.')
  let lwinwidth = winwidth('.')
  let lhalfwidth = lwinwidth / 2
  let lwincol = wincol()

  " scroll line to center of screen
  execute("normal zz")

  " scroll line to the top quarter of the screen
  let offset = lwinheight / 4
  let index = 0
  while index < offset
    execute("normal ")
    let index = index + 1
  endwhile

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

" cc    Move cursor to center of line, scroll line to center of screen
nnoremap cc :call MoveCurtorToCenterOfScreen()<CR>

" autoload configurations files
set runtimepath+=~/.config
runtime! vim/*.vim

" load user .vimrc configuration file
if filereadable(expand('~/.vimrc.mine'))
  source ~/.vimrc.mine
endif
