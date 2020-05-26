" Copyright (c) 2012 ONGS Inc. <info@ongs.co.jp>
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
" first edition: Mon Jul  9 07:27:39 JST 2012
" last modified: $Date$
" version: $Revision$

" HTML mode
function! HtmlKeys(ArgLead, CmdLine, CusorPos)
  let l:keys = 
  \  'p'		. "\n" .
  \  'a'		. "\n" .
  \  'pre' 		. "\n" .
  \  'li' 		. "\n" .
  \  'ul' 		. "\n" .
  \  'dl' 		. "\n" .
  \  'dd' 		. "\n" .
  \  'dt' 		. "\n" .
  \  'ol' 		. "\n" .
  \  'div' 		. "\n" .
  \  'blockquote' 	. "\n" .
  \  'br' 		. "\n" .
  \  'hr' 		. "\n" .
  \  'img' 		. "\n" .
  \  'h1' 		. "\n" .
  \  'h2' 		. "\n" .
  \  'h3' 		. "\n" .
  \  'h4' 		. "\n" .
  \  'h5' 		. "\n" .
  \  'form' 		. "\n" .
  \  'input' 		. "\n" .
  \  'iframe' 		. "\n" .
  \  'table' 		. "\n" .
  \  'td' 		. "\n" .
  \  'th' 		. "\n" .
  \  'tr' 		. "\n" .
  \  'iframe' 		. "\n" .
  \  'date' 		. "\n" .
  \  'datebsd' 		. "\n" .
  \  'dategnu' 		. "\n" .
  \  'tukubai' 		. "\n" .
  \  'tukubaiabout' 	. "\n" .
  \  'tukubai3minabout'	. "\n" .
  \  'tukubaidownload' 	. "\n" .
  \  'tukubaimanual' 	. "\n" .
  \  'unicage' 		. "\n" .
  \  'unicageengineer' 	. "\n" .
  \  'unicageseminar' 	. "\n" .
  \  'unicageexam' 	. "\n" .
  \  'unicagetouroku' 	. "\n" .
  \  'uec' 		. "\n" .
  \  'usp' 		. "\n" .
  \  'uspmagazine' 	. "\n" .
  \  'usppublishing' 	. "\n" .
  \  'formatfield' 	. "\n" .
  \  'formatname'	. "\n" .
  \  'calclock'		. "\n" .
  \  'cgi-name'		. "\n" .
  \  'check_attr_name'	. "\n" .
  \  'check_need_name'	. "\n" .
  \  'cjoin0'		. "\n" .
  \  'cjoin1'		. "\n" .
  \  'cjoin2'		. "\n" .
  \  'comma'		. "\n" .
  \  'count'		. "\n" .
  \  'ctail'		. "\n" .
  \  'dayslash'		. "\n" .
  \  'delf'		. "\n" .
  \  'divsen'		. "\n" .
  \  'filehame'		. "\n" .
  \  'formhame'		. "\n" .
  \  'getfirst'		. "\n" .
  \  'getlast'		. "\n" .
  \  'gyo'		. "\n" .
  \  'han'		. "\n" .
  \  'join0'		. "\n" .
  \  'join1'		. "\n" .
  \  'join2'		. "\n" .
  \  'juni'		. "\n" .
  \  'kasan'		. "\n" .
  \  'keta'		. "\n" .
  \  'keycut'		. "\n" .
  \  'loopj'		. "\n" .
  \  'loopx'		. "\n" .
  \  'map'		. "\n" .
  \  'marume'		. "\n" .
  \  'mdate'		. "\n" .
  \  'mime-read'	. "\n" .
  \  'mojihame'		. "\n" .
  \  'nameread'		. "\n" .
  \  'plus'		. "\n" .
  \  'rank'		. "\n" .
  \  'ratio'		. "\n" .
  \  'retu'		. "\n" .
  \  'self'		. "\n" .
  \  'sm2'		. "\n" .
  \  'sm4'		. "\n" .
  \  'sm5'		. "\n" .
  \  'tarr'		. "\n" .
  \  'tateyoko'		. "\n" .
  \  'tcat'		. "\n" .
  \  'unmap'		. "\n" .
  \  'up3'		. "\n" .
  \  'yarr'		. "\n" .
  \  'ycat'		. "\n" .
  \  'yobi'		. "\n" .
  \  'ysum'		. "\n" .
  \  'zen'		. "\n" .
  \  'field-format'	. "\n" .
  \  'master-file'	. "\n" .
  \  'name-file'	. "\n" .
  \  'name-format'	. "\n" .
  \  'tag-format'	. "\n" .
  \  'transaction-file'
  return l:keys
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

function! <SID>htmlTagInsert()
  let l:tag = input('tag: ', '', 'custom,HtmlKeys')
  let l:eleidx = col('.')
  let l:hs = <SID>spaces(eleidx)

  if 'ul' == l:tag
    let l:bf = 
    \       '<ul>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '</ul>' .
    \  <SID>back(59) . <SID>back(5 * (l:eleidx - 1))

  elseif 'dl' == l:tag
    let l:bf = 
    \       '<dl>' . "\<CR>" .
    \  hs . '  <dt></dt>' . "\<CR>" .
    \  hs . '  <dd></dd>' . "\<CR>" .
    \  hs . '  <dt></dt>' . "\<CR>" .
    \  hs . '  <dd></dd>' . "\<CR>" .
    \  hs . '  <dt></dt>' . "\<CR>" .
    \  hs . '  <dd></dd>' . "\<CR>" .
    \  hs . '  <dt></dt>' . "\<CR>" .
    \  hs . '  <dd></dd>' . "\<CR>" .
    \  hs . '  <dt></dt>' . "\<CR>" .
    \  hs . '  <dd></dd>' . "\<CR>" .
    \  hs . '  <dt></dt>' . "\<CR>" .
    \  hs . '  <dd></dd>' . "\<CR>" .
    \  hs . '</dl>' .
    \  <SID>back(143) . <SID>back(12 * (l:eleidx - 1))

  elseif 'ol' == l:tag
    let l:bf = 
    \       '<ol start="1">' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '  <li></li>' . "\<CR>" .
    \  hs . '</ol>' .
    \  <SID>back(59) . <SID>back(5 * (l:eleidx - 1))

  elseif 'pre' == l:tag || 'div' == l:tag
    let l:bf = 
    \       '<' . l:tag . ' class="">' . "\<CR>" .
    \  hs . '</' . l:tag . '>' .
    \  <SID>back(6 + strlen(l:tag)) . <SID>back(1 * (l:eleidx - 1))

  elseif 'br' == l:tag || 'hr' == l:tag
    let l:bf =  '<' . l:tag . '/>'

  elseif 'table' == l:tag
    let l:bf = 
    \       '<table>' . "\<CR>" .
    \  hs . '  <tr>' . "\<CR>" .
    \  hs . '    <th></th>' . "\<CR>" .
    \  hs . '    <th></th>' . "\<CR>" .
    \  hs . '    <th></th>' . "\<CR>" .
    \  hs . '  </tr>' . "\<CR>" .
    \  hs . '  <tr>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '  </tr>' . "\<CR>" .
    \  hs . '  <tr>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '  </tr>' . "\<CR>" .
    \  hs . '  <tr>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '    <td></td>' . "\<CR>" .
    \  hs . '  </tr>' . "\<CR>" .
    \  hs . '</table>' .
    \  <SID>back(221) . <SID>back(19 * (l:eleidx - 1))

  elseif 'form' == l:tag
    let l:bf = 
    \       '<form action="/path/to/cgi.cgi" method="post">' . "\<CR>" .
    \  hs . '  <input type="hidden" name="TITLE" value="識別名" />' . "\<CR>" .
    \  hs . '  <input type="text" name="項目名01" />' . "\<CR>" .
    \  hs . '  <input type="text" name="項目名02" />' . "\<CR>" .
    \  hs . '  <input type="text" name="項目名03" />' . "\<CR>" .
    \  hs . '  <input type="submit" class="submit" value="送信ボタン" />' . "\<CR>" .
    \  hs . '</form>'

  elseif 'a' == l:tag
    let l:bf = '<a href=""></a>' . <SID>back(6)

  elseif 'img' == l:tag
    let l:bf = '<img src=""></img>' . <SID>back(8)

  elseif 'iframe' == l:tag
    let l:bf = '<iframe width="290" height="200" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src=""></iframe>' . <SID>back(11)

  elseif 'input' == l:tag
    let l:bf = '<input type="" name="" />' . <SID>back(12)

  elseif 'date' == l:tag
    let l:bf = '<a href="/CMD_TIPS/CGI/CMD_TIPS.CGI?POMPA=TIPS_date_posix">dateコマンドのフォーマット一覧 : IEEE Std 1003.1 "POSIX.1"</a>'

  elseif 'datebsd' == l:tag
    let l:bf = '<a href="/CMD_TIPS/CGI/CMD_TIPS.CGI?POMPA=TIPS_date_bsd">BSD date</a>'

  elseif 'dategnu' == l:tag
    let l:bf = '<a href="/CMD_TIPS/CGI/CMD_TIPS.CGI?POMPA=TIPS_date_gnu">GNU Shell Utilities date</a>'

  elseif 'tukubai' == l:tag
    let l:bf = '<a href="/TUKUBAI/CGI/TUKUBAI.CGI?POMPA=LIST">Open usp Tukubai</a>'

  elseif 'tukubaiabout' == l:tag
    let l:bf = '<a href="/TUKUBAI/CGI/TUKUBAI.CGI?POMPA=ABOUT">usp Tukubai / Open usp Tukubaiについて</a>'

  elseif 'tukubai3minabout' == l:tag
    let l:bf = '<a href="/TUKUBAI/CGI/TUKUBAI.CGI?POMPA=ABOUTTUKUBAI01">3分でわかるusp Tukubai</a>'

  elseif 'tukubaidownload' == l:tag
    let l:bf = '<a href="/TUKUBAI/CGI/TUKUBAI.CGI?POMPA=DOWNLOAD">Open usp Tukubaiダウンロード</a>'

  elseif 'tukubaimanual' == l:tag
    let l:bf = '<a href="/TUKUBAI_MAN/CGI/TUKUBAI_MAN.CGI?POMPA=LIST">Tukubaiオンラインコマンドマニュアル</a>'

  elseif 'unicage' == l:tag
    let l:bf = '<a href="/INFO/CGI/INFO.CGI?POMPA=ABOUTUNICAGE">ユニケージ開発手法</a>'

  elseif 'unicageengineer' == l:tag
    let l:bf = '<a href="/INFO/CGI/INFO.CGI?POMPA=ABOUTUNICAGECERTIFIEDENGINEER">ユニケージエンジニア</a>'

  elseif 'unicageseminar' == l:tag
    let l:bf = '<a href="/INFO/CGI/INFO.CGI?POMPA=EXAMSEMINAR">ユニケージ開発手法 教育講座</a>'

  elseif 'unicageexam' == l:tag
    let l:bf = '<a href="/INFO/CGI/INFO.CGI?POMPA=EXAM">ユニケージ開発手法 技能検定</a>'

  elseif 'unicagetouroku' == l:tag
    let l:bf = '<p class="annotation">※ <a href="/INFO/CGI/INFO.CGI?POMPA=ABOUTUNICAGE">ユニケージ</a>は<a href="http://www.usp-lab.com/">ユニバーサル・シェル・プログラミング研究所</a>の登録商標。</p>'

  elseif 'uec' == l:tag
    let l:bf = '<a href="http<SID>//uec.usp-lab.com/">UEC - usp engineers' . "'" . 'community site</a>'

  elseif 'usp' == l:tag
    let l:bf = '<a href="http://www.usp-lab.com/">ユニバーサル・シェル・プログラミング研究所</a>'

  elseif 'uspmagazine' == l:tag
    let l:bf = '<a href="/INFO/CGI/INFO.CGI?POMPA=USPMAGAZINE">USP MAGAZINE</a>'

  elseif 'usppublishing' == l:tag
    let l:bf = '<a href="/INFO/CGI/INFO.CGI?POMPA=BOOKSUSP">USP出版 書籍情報</a>'

  elseif 'formatfield' == l:tag
    let l:bf = '<a href="/TUKUBAI_MAN/CGI/TUKUBAI_MAN.CGI?POMPA=MAN5_field-format">フィールド形式(5)</a>'

  elseif 'formatname' == l:tag
    let l:bf = '<a href="/TUKUBAI_MAN/CGI/TUKUBAI_MAN.CGI?POMPA=MAN5_name-format">ネーム式(5)</a>'

  elseif 'calclock'		== l:tag ||
    \    'cgi-name'		== l:tag || 
    \    'check_attr_name'	== l:tag ||
    \    'check_need_name'	== l:tag ||
    \    'cjoin0'		== l:tag ||
    \    'cjoin1'		== l:tag ||
    \    'cjoin2'		== l:tag ||
    \    'comma'		== l:tag ||
    \    'count'		== l:tag ||
    \    'ctail'		== l:tag ||
    \    'dayslash'		== l:tag ||
    \    'delf'			== l:tag ||
    \    'divsen'		== l:tag ||
    \    'filehame'		== l:tag ||
    \    'formhame'		== l:tag ||
    \    'getfirst'		== l:tag ||
    \    'getlast'		== l:tag ||
    \    'gyo'			== l:tag ||
    \    'han'			== l:tag ||
    \    'join0'		== l:tag ||
    \    'join1'		== l:tag ||
    \    'join2'		== l:tag ||
    \    'juni'			== l:tag ||
    \    'kasan'		== l:tag ||
    \    'keta'			== l:tag ||
    \    'keycut'		== l:tag ||
    \    'loopj'		== l:tag ||
    \    'loopx'		== l:tag ||
    \    'map'			== l:tag ||
    \    'marume'		== l:tag ||
    \    'mdate'		== l:tag ||
    \    'mime-read'		== l:tag ||
    \    'mojihame'		== l:tag ||
    \    'nameread'		== l:tag ||
    \    'plus'			== l:tag ||
    \    'rank'			== l:tag ||
    \    'ratio'		== l:tag ||
    \    'retu'			== l:tag ||
    \    'self'			== l:tag ||
    \    'sm2'			== l:tag ||
    \    'sm4'			== l:tag ||
    \    'sm5'			== l:tag ||
    \    'tarr'			== l:tag ||
    \    'tateyoko'		== l:tag ||
    \    'tcat'			== l:tag ||
    \    'unmap'		== l:tag ||
    \    'up3'			== l:tag ||
    \    'yarr'			== l:tag ||
    \    'ycat'			== l:tag ||
    \    'yobi'			== l:tag ||
    \    'ysum'			== l:tag ||
    \    'zen'			== l:tag
    let l:bf = 
    \    '<a href="/TUKUBAI_MAN/CGI/TUKUBAI_MAN.CGI?POMPA=MAN1_' . 
    \    l:tag  . '">' . l:tag . '(1)</a>'

  elseif 'field-format'		== l:tag || 
    \    'master-file'		== l:tag ||
    \    'name-file'		== l:tag ||
    \    'name-format'		== l:tag ||
    \    'tag-format'		== l:tag ||
    \    'transaction-file'	== l:tag
    let l:bf = 
    \    '<a href="/TUKUBAI_MAN/CGI/TUKUBAI_MAN.CGI?POMPA=MAN5_' . 
    \    l:tag  . '">' . l:tag . '(5)</a>'

  else
    let l:bf = '<'.l:tag.'></'.l:tag.'>' . <SID>back(3 + strlen(l:tag))
  endif
  return l:bf
endfunction

augroup AddhtmlMode
  autocmd!
  autocmd BufNewFile,BufRead *.html imap <C-c>t <C-r>=<SID>htmlTagInsert()<CR>
  autocmd Filetype html set omnifunc=htmlcomplete#CompleteTags
  autocmd Filetype html inoremap <bf> </ </<C-x><C-o>
augroup End
