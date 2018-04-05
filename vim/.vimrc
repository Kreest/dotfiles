" --------------------------------------------------------------------------
" Basic options
" --------------------------------------------------------------------------

" Formatting
set textwidth   =80
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set shiftround
set nowrap
set linebreak
set nolist
set formatoptions-=t
set formatoptions+=l

" Appearance
set cursorline
syntax on
set lazyredraw " tradeoff for cursorline and syntax
set number
set norelativenumber
set ruler
set foldcolumn=2
set breakindent
set splitbelow
set splitright
set showcmd
set scrolloff =6

" Misc settings
set undofile
set backup
set backupdir =~/.vim/.backup//
set directory =~/.vim/.swp//
set undodir   =~/.vim/.undo//

" Keybindings
nnoremap <Space> @q
nnoremap <Leader>x "+
nnoremap ; :
vnoremap ; :
let mapleader=','
nnoremap Y y$
map <Leader>v  :so ~/.vimrc<CR>
map <F1> <Esc>
map! <F1> <Esc>
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S (%Z)")<CR> 
nnoremap <Leader>, ,
nnoremap <Leader>; ;

cmap w!! w !sudo tee > /dev/null %

" Search and Substitute
set hls
set ignorecase
set smartcase
nnoremap <leader><space> :nohls<enter>

"" Omnicompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

""" NetRW
let g:netrw_liststyle =1 " Detail View
let g:netrw_sizestyle ="H" " Human-readable file sizes
let g:netrw_list_hide ='\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_hide      =1 " hide dotfiles by default
let g:netrw_banner    =0 " Turn off banner
""" Explore in vertical split
nnoremap <Leader>e :Explore! <enter>

"" Python Version
augroup python3
    au! BufEnter *.py setlocal omnifunc=python3complete#Complete
augroup END

" ----------------------------------------------------------------------------
" Plugins, Manager - https://github.com/junegunn/vim-plug
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    " Theme
    Plug 'morhetz/gruvbox'
    " Pope
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-sleuth'
    " Editing
    " Plug 'lifepillar/vim-mucomplete'
    Plug 'ervandew/supertab'
    Plug 'Valloric/YouCompleteMe'
    Plug 'sirver/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'godlygeek/tabular'
    " Languages
    Plug 'rust-lang/rust.vim'
    Plug 'sheerun/vim-polyglot'
    " Training
    Plug 'takac/vim-hardtime'
    " Markdown and writing
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vim-pandoc/vim-pandoc'
call plug#end()

"" Theme
let g:gruvbox_italic=1 "allow italics
colorscheme gruvbox    "set vim colorscheme
set background=dark    "use dark variant

"" Autocompletion
set completeopt=menuone,noinsert,noselect
set shortmess+=c " Turn off completion messages

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

"" Ultisnips
" let g:UltiSnipsExpandTrigger="<C-J>"
" let g:UltiSnipsJumpForwardTrigger="<C-J>"
" let g:UltiSnipsJumpBackwardTrigger="<C-K>"
