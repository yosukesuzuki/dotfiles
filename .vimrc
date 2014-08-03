sy on

:colorscheme desert
":colorscheme hybrid
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
let g:neocomplcache_enable_at_startup = 1
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_EnableUnderbarCompletion = 1

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
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
set rtp+=$GOROOT/misc/vim
"golint
exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")


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
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'tpope/vim-rails.git'
NeoBundle "pangloss/vim-javascript"
NeoBundle 'jnwhiteh/vim-golang.git'
NeoBundle 'Blackrush/vim-gocode.git'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'

" syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
" js BDDツール
NeoBundle 'claco/jasmine.vim'
" indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'

" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
" non github repos
NeoBundle 'git://git.wincent.com/command-t.git'

NeoBundle "Chiel92/vim-autoformat"
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
set fileencodings=iso-2022-jp,sjis,utf8

execute pathogen#infect()

" go setttings
filetype off
filetype plugin indent off
set runtimepath+=/usr/local/go/misc/vim
au FileType go setlocal sw=4 ts=4 sts=4 noet
au FileType go setlocal makeprg=go\ build\ ./... errorformat=%f:%l:\ %m
au BufWritePre *.go Fmt
au BufRead,BufNewFile *.md set filetype=markdown
filetype plugin indent on
syntax on

" vimにcoffeeファイルタイプを認識させる
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデントを設定
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et

