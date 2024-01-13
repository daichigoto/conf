" Copyright (c) 2010,2012,2016,2020,2021 ONGS Inc. <info@ongs.co.jp>
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

" Hanbun mode
function! HanbunTags(ArgLead, CmdLine, CusorPos)
  let l:tags= 
  \  'document'			. "\n" .
  \  'docgroup'			. "\n" .
  \  'docinfo'			. "\n" .
  \  'title'			. "\n" .
  \  'author'			. "\n" .
  \  'firstedition'		. "\n" .
  \  'lastmodified'		. "\n" .
  \  'initialnumber'		. "\n" .
  \  'p'			. "\n" .
  \  'list'			. "\n" .
  \  'order'			. "\n" .
  \  'item'			. "\n" .
  \  'thebibliography'		. "\n" .
  \  'bibitem'			. "\n" .
  \  'publisher'		. "\n" .
  \  'year'			. "\n" .
  \  'import'			. "\n" .
  \  'footnote'			. "\n" .
  \  'access'			. "\n" .
  \  'mark'			. "\n" .
  \  'ruby'			. "\n" .
  \  'alias'			. "\n" .
  \  'number'			. "\n" .
  \  'category'			. "\n" .
  \  'revisionnumber'		. "\n" .
  \  'newernumber'		. "\n" .
  \  'obsoletenumber'
  return l:tags
endfunction

function! <SID>back(num)
  let l:i = 0
  let l:b = ''
  while l:i < a:num
    let l:b = l:b . "\<Left>"
    let l:i += 1
  endwhile
  return l:b
endfunction

function! <SID>hanbunTagInsert()
  let l:tag = input('tag: ', '', 'custom,HanbunTags')
  let l:eleidx = col('.')

  if 'docgroup' == l:tag
    let l:bf = 
    \  '<docgroup>' . "\<CR>" .
    \  '<docinfo>' . "\<CR>" .
    \  '<title><p></p></title>' . "\<CR>" .
    \  "\<Left>" . '</docinfo>' . "\<CR>" .
    \  "\<CR>" .
    \  '<p></p>' . "\<CR>" .
    \  "\<CR>" .
    \  '<p></p>' . "\<CR>" .
    \  "\<CR>" .
    \  '<p></p>' . "\<CR>" .
    \  "\<CR>" .
    \  '<p></p>' . "\<CR>" .
    \  "\<Left>" . '</docgroup>' .
    \  <SID>back(0) . <SID>back(76 + 6 * (l:eleidx - 1))

  elseif 'list' == l:tag
    let l:bf = 
    \  '<list>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  "\<Left>" . '</list>' .
    \  <SID>back(0) . <SID>back(107 + 5 * (l:eleidx - 1))

  elseif 'order' == l:tag
    let l:bf = 
    \  '<list type="order">' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  '<item><p></p></item>' . "\<CR>" .
    \  "\<Left>" . '</list>' .
    \  <SID>back(0) . <SID>back(107 + 5 * (l:eleidx - 1))

  elseif 'access' == l:tag
    let l:bf = '<access ref=""></access>' . <SID>back(11)

  else
    let l:bf = '<'.l:tag.'></'.l:tag.'>' . <SID>back(3 + strlen(l:tag))
  endif
  return l:bf
endfunction

let g:genlist_timestamp = strftime("%H%M%S")
function! GenList()
  " [∥-￥] is a range of Japanese as much as possible in UTF-8.
  " [ -~] is a range of ASCII as much as possible.
  "
  " s/\([^ -~∥-￥]\)/ /g replaces invisible whitespace data 
  " included when copied from a browser with normal whitespace.
  if strftime("%H%M%S") != g:genlist_timestamp
    :'<,'>s/\([^ -~∥-￥]\)/ /g
    :'<,'>s/^[ ]*//g
    :'<,'>s/[ ]*$//g
    :'<,'>s/[ ][ ]*/ /g
    :'<,'>s/ *-> */->/g
    :'<,'>s/->\([-0-9a-zA-Z._]*\)/から\1までのバージョン/g
    :'<,'>s/ and earlier versions/およびこれよりも前のバージョン/g
    :'<,'>s/ and earlier versions/およびこれよりも前のバージョン/g
    :'<,'>s/およびそれ以前 (/およびそれよりも前のバージョン(/g
    :'<,'>s/およびそれ以前（/およびそれよりも前のバージョン（/g
    :'<,'>s/およびそれ以前$/およびそれよりも前のバージョン/g
    :'<,'>s/およびそれ以前の/およびそれよりも前のバージョン/g
    :'<,'>s/（Windows）/（Windows版）/g
    :'<,'>s/（macOS）/（macOS版）/g
    :'<,'>s/（Windows、macOS）/（Windows版、macOS版）/g
    :'<,'>s/Windows and macOS/(Windows版、macOS版)/g
    :'<,'>s/Windows$/(Windows版)/g
    :'<,'>s/macOS$/(macOS版)/g
    :'<,'>s/^\(.*\)$/   <item><p>\1<\/p><\/item>/
    let g:genlist_timestamp = strftime("%H%M%S")
  endif
endfunction

augroup AddHanbunMode
  autocmd!

  " A space is the indent
  set shiftwidth=1

  " Makefile.win file type definition
  autocmd BufRead,BufNewFile Makefile.win setfiletype make

  " <C-n> or <C-t>	tab forwarding when make post mode
  autocmd BufNewFile,BufRead typescript*.xml inoremap <C-t> <ESC>:w<CR>:bn<CR>gg=G/POST:]<CR>5li
  autocmd BufNewFile,BufRead typescript*.xml inoremap <C-n> <ESC>:w<CR>:bn<CR>gg=G/POST:]<CR>5li
  autocmd BufNewFile,BufRead typescript*.xml nnoremap <C-n>      :w<CR>:bn<CR>gg=G/POST:]<CR>5li

  " <C-c>t	Insert Hanbun tag
  autocmd BufNewFile,BufRead typescript*.xml inoremap <C-c>t <C-r>=<SID>hanbunTagInsert()<CR>

  " LT		Smart list generator
  autocmd BufNewFile,BufRead typescript*.xml vnoremap LT :call GenList()<CR>

  " useful jump
  autocmd BufNewFile,BufRead typescript*.xml nnoremap LEAD /lead:<CR>5l
  autocmd BufNewFile,BufRead typescript*.xml nnoremap TITLE /   <title><p><CR>13l
augroup End
