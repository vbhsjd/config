set tabstop=4
set shiftwidth=4
" 使用制表符代替空格
set expandtab
set number
" 开启自动缩进
set autoindent
" 开启自动换行
set wrap
" 保持与上一行的缩进相同
set shiftround
" 搜索时不区分大小写
set ignorecase
" 语法高亮
syntax on
"  加快滑动速度
set ttyfast
colorscheme zellner
set scrolloff=5
set hlsearch
set backspace=indent,eol,start

" vim 复制到系统剪贴板
set clipboard=unnamed

"  插件
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()
