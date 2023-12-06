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

" vim 复制到系统剪贴板
set clipboard=unnamed

"  插件
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" tab  补全命令
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

