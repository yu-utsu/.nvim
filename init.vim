set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See details:
"   http://qiita.com/delphinus/items/00ff2c0ba972c6e41542
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $HOME/colemak/vimremap.vim

if $XDG_CONFIG_HOME != ""
  " Plugin's directories
  let s:dein_dir      = expand('$XDG_CONFIG_HOME/nvim/dein.vim')
  " dein.vim's destination
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif

  " Configure begin
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " loading TOML
    let g:rc_dir      = expand('$XDG_CONFIG_HOME/nvim/rc')
    let s:toml        = g:rc_dir . '/dein.toml'
    let s:lazy_toml   = g:rc_dir . '/dein_lazy.toml'

    " caching TOML
    call dein#load_toml(s:toml,       {'lazy': 0})
    call dein#load_toml(s:lazy_toml,  {'lazy': 1})

    " End and save
    call dein#end()
    call dein#save_state()
  endif

  " If you want to install not installed plugins on startup.
  if dein#check_install()
    call dein#install()
  endif
endif

set ambiwidth=double
set autoindent
set backspace=indent,eol,start
set cmdheight=2
set copyindent
set cursorline
set encoding=utf-8
set expandtab
set fileformats=unix
set fileencodings=ucs-bom,iso-2022-jp,iso-2022-jp-3,sjis,cp932,euc-jp,eucjp-ms,euc-jisx0213,cp20932,utf-8
set formatexpr=autofmt#japanese#formatexpr()
set formatoptions+=mM
set helplang=ja,en
set laststatus=2
set list
set listchars=tab:>-,trail:-
set noshowmode
set number
set ruler
set scroll=15
set shiftwidth=2
set showcmd
set smartindent
set smarttab
set splitright
set tabstop=4
set updatetime=100
set virtualedit+=block
set whichwrap=b,s,[,],<,>

scriptencoding utf-8
syntax enable
filetype plugin indent on

set background=dark

if $VIMCOLOR == 'hybrid'
  colorscheme hybrid
endif

if $VIMCOLOR == 'molokai'
  colorscheme molokai
endif

execute "set colorcolumn=" . join(range(80, 9999), ',')

" IM control on fcitx
if $XMODIFIERS == "@im=fcitx"
  "##### auto fcitx  ###########
  let g:input_toggle = 0
  function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
    endif
  endfunction

  function! Fcitx2zh()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
    endif
  endfunction

  "set timeout timeoutlen=3000 ttimeoutlen=100
  set timeout
  set timeoutlen=500
  set ttimeout
  set ttimeoutlen=100
  " Leave insert-mode
  autocmd InsertLeave * call Fcitx2en()
  " Enter insert-mode
  autocmd InsertEnter * call Fcitx2zh()
  "##### auto fcitx end ######
endif

source $XDG_CONFIG_HOME/nvim/lightline-config.vim
