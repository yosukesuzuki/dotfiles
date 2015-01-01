" install mvim if you want to launch macvim by mvim command -> http://d.hatena.ne.jp/namutaka/20100419/1271694518

sy on

:filetype on
:filetype indent on
:filetype plugin on
set autoindent
set cindent
set expandtab
set tabstop=8
set softtabstop=4
set expandtab
set smarttab
set number
set nocompatible
set sw=4 " no of spaces for indenting
"set ts=4 " show \t as 2 spaces and treat 2 spaces as \t when deleting, etc.

"行頭のスペースの連続をハイライトさせる
""Tab文字も区別されずにハイライトされるので、区別したいときはTab文字の表示を別に
"設定する必要がある。
function! SOLSpaceHilight()
  syntax match SOLSpace "^\s\+" display containedin=ALL
  highlight SOLSpace term=underline ctermbg=LightGray
endf

"全角スペースをハイライトさせる。
function! JISX0208SpaceHilight()
  syntax match JISX0208Space "　" display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

if has("syntax")
  syntax on
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call SOLSpaceHilight()
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
  augroup END
endif

set nocompatible               " be iMproved
filetype off                   " required!

"gocode
"set rtp+=$GOROOT/misc/vim


"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

" let Vundle manage Vundle
" required! 
"Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
"
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
endif

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'tpope/vim-rails.git'
NeoBundle "pangloss/vim-javascript"
" NeoBundle 'jnwhiteh/vim-golang.git'
NeoBundle 'Blackrush/vim-gocode.git'
NeoBundle 'maksimr/vim-jsbeautify'
NeoBundle 'einars/js-beautify'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
" js BDDツール
NeoBundle 'claco/jasmine.vim'
" indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'

" auto pair
NeoBundle 'jiangmiao/auto-pairs'

" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
" non github repos
NeoBundle 'git://git.wincent.com/command-t.git'
NeoBundle "Chiel92/vim-autoformat"

" color schema
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/rdark'

:colorscheme railscasts
"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" ...

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set encoding=utf-8
set fileencodings=utf8

execute pathogen#infect()

" go setttings
filetype off
filetype plugin indent off
set rtp+=$GOROOT/misc/vim
" au FileType go setlocal sw=4 ts=4 sts=4 noet
" au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m
" au BufWritePre *.go Fmt
filetype plugin indent on
syntax on
autocmd FileType go autocmd BufWritePre <buffer> Fmt
if $GOPATH != ''
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
  exe "set rtp+=".globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
  let g:syntastic_go_checkers = ['go', 'golint']
endif

" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

" vimにhtmlファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.html set filetype=html
" インデントを設定
autocmd FileType html setlocal sw=2 sts=2 ts=2 et

" 事前に pip install autopep8する
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

" Shift + F で自動修正
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

"map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <S-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <S-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <S-f> :call CSSBeautify()<cr>

nnoremap <silent><C-e> :NERDTreeToggle<CR>

" install autopep8 pep8 pyflakes see -> http://ton-up.net/technote/2013/11/26/vim-python-style-check-and-fix/
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

set completeopt-=preview
set completeopt+=longest
" set omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
