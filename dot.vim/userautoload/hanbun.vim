" Copyright (c) 2010,2012 ONGS Inc. <info@ongs.co.jp>
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

function! <SID>spaces(num)
  let l:i = 1
  let l:s = ''
  while l:i < a:num
    let l:s = l:s . ' '
    let l:i += 1
  endwhile
  return l:s
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
  let l:hs = <SID>spaces(eleidx)

  if 'docgroup' == l:tag
    let l:bf = 
    \       '<docgroup>' . "\<CR>" .
    \  hs . ' <docinfo>' . "\<CR>" .
    \  hs . '  <title><p></p></title>' . "\<CR>" .
    \  hs . ' </docinfo>' . "\<CR>" .
    \       "\<CR>" .
    \  hs . ' <p></p>' . "\<CR>" .
    \       "\<CR>" .
    \  hs . ' <p></p>' . "\<CR>" .
    \       "\<CR>" .
    \  hs . ' <p></p>' . "\<CR>" .
    \       "\<CR>" .
    \  hs . ' <p></p>' . "\<CR>" .
    \  hs . '</docgroup>' .
    \  <SID>back(76) . <SID>back(6 * (l:eleidx - 1))

  elseif 'list' == l:tag
    let l:bf = 
    \       '<list>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . ' <item><p></p></item>' . "\<CR>" .
    \  hs . '</list>' .
    \  <SID>back(217) . <SID>back(10 * (l:eleidx - 1))

  elseif 'access' == l:tag
    let l:bf = '<access ref=""></access>' . <SID>back(11)

  else
    let l:bf = '<'.l:tag.'></'.l:tag.'>' . <SID>back(3 + strlen(l:tag))
  endif
  return l:bf
endfunction

augroup AddHanbunMode
  autocmd!
  autocmd BufNewFile,BufRead *.xml imap <C-c>t <C-r>=<SID>hanbunTagInsert()<CR>
  autocmd Filetype xml set omnifunc=xmlcomplete#CompleteTags
  autocmd Filetype xml inoremap <bf> </ </<C-x><C-o>
augroup End
