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

" Move current line / visual line selection up or down.
nnoremap <silent> <C-j> :m+<CR>==
nnoremap <silent> <C-k> :m-2<CR>==
vnoremap <silent> <C-j> :m'>+<CR>gv=gv
vnoremap <silent> <C-k> :m-2<CR>gv=gv

cmap w!! w !sudo tee > /dev/null %

" Search and Substitute
set hls
set ignorecase
set smartcase
nnoremap <silent> <leader><space> :nohls<enter>

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

"" Python Version ---- Needed?
augroup python3
    au! BufEnter *.py setlocal omnifunc=python3complete#Complete
augroup END

" Create directories as needed when writing files.
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" ----------------------------------------------------------------------------
" Plugins, Manager - https://github.com/junegunn/vim-plug
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    " Theme
    Plug 'morhetz/gruvbox'
    " Pope
    Plug 'tpope/vim-sensible'       " Sensible default settings
    Plug 'tpope/vim-commentary'     " Commenting blocks
    Plug 'tpope/vim-surround'       " Dealing with surrounding thing (),[]...
    Plug 'tpope/vim-repeat'         " Extended .
    Plug 'tpope/vim-sleuth'         " Sensible indenting
    " Editing
    Plug 'ervandew/supertab'        " Enhanced TAB key
    Plug 'Valloric/YouCompleteMe'   " Code completion
    Plug 'sirver/ultisnips'         " Snippet manager
    Plug 'honza/vim-snippets'       " Common snippets
    Plug 'godlygeek/tabular'        " Lines up text
    " Navigation and marks
    Plug 'kshenoy/vim-signature'    " Marking lines
    Plug 'airblade/vim-gitgutter'   " Displays git changes
    " Languages
    Plug 'rust-lang/rust.vim'       " Config for rust
    Plug 'sheerun/vim-polyglot'     " Many-many language specific settings
    " Markdown and writing
    Plug 'junegunn/goyo.vim'        " Distraction free writing
    Plug 'junegunn/limelight.vim'   " Highlighter for goyo
    Plug 'vim-pandoc/vim-pandoc-syntax' " Markdown
    Plug 'vim-pandoc/vim-pandoc'    " Markdown
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

""" Signature
nmap <leader>s :SignatureToggle<CR>

"" Ultisnips
" let g:UltiSnipsExpandTrigger="<C-J>"
" let g:UltiSnipsJumpForwardTrigger="<C-J>"
" let g:UltiSnipsJumpBackwardTrigger="<C-K>"
"
"
" TODO: Integrate sleuth better
" TODO: Look into NetRW usge
" TODO: Reeval omnifunc lines
" TODO: Look into other completers
" TODO: Plugins to check out:
"   vim-abolish     " For case coercion and autocorrection
"   vim-move        " For improved moving
"   vim-matchit     " Improved % matching
"   FastFold        " Folding C
"   nerdcommenter   " As alternative to commentary C
"   vim-sneak       " Two-key search B
"   startuptime     " For debug B
"   gitgutter       " git diff integration A+
"   peekaboo        " Register peeker A
"   signature       " Mark navigation A++++
"   rooter          " changes working directory to project
"   ctags
"
" TODO: Check out that weird black outline
" TODO: Make signature play nice with gitgutter
" TODO: Consider splitting the config file
"
" TODO: Repos to check out and steal from:
"   xero/dotfiles
"   gcmt/dotfiles
"   
