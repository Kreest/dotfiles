" --------------------------------------------------------------------------
" Basic options
" --------------------------------------------------------------------------

" Formatting
set encoding      =utf-8
set textwidth     =80
set tabstop       =4
set softtabstop   =4
set shiftwidth    =4
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

"Basic keybindings
nnoremap <Space>   <C-D>
nnoremap <Leader>x "+
nnoremap ;         :
vnoremap ;         :
let      mapleader=','
nnoremap Y         y$
map      <Leader>r :so ~/.vimrc<CR>
inoremap <F5>      <C-R>=strftime("%Y-%m-%d %H:%M:%S (%Z)")<CR>
nnoremap <Leader>, ,
nnoremap <Leader>; ;

" Force write as superuser
cmap w!! w !sudo tee > /dev/null %

" Search and Substitute
set hls
set ignorecase
set smartcase
nnoremap <silent> <leader><space> :nohls<enter>

"" Omnicompletion
 set filetype=on
 set omnifunc=syntaxcomplete#Complete

"" NetRW
let g:netrw_liststyle =1                       " Detail View
let g:netrw_sizestyle ="H"                     " Human-readable file sizes
let g:netrw_list_hide ='\(^\|\s\s\)\zs\.\S\+'  " hide dotfiles
let g:netrw_hide      =1                       " hide dotfiles by default
let g:netrw_banner    =0                       " Turn off banner

"" Explore in vertical split
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
    Plug 'dracula/vim', { 'as': 'dracula' }
    " Pope
    Plug 'tpope/vim-sensible'             " Sensible default settings
    Plug 'tpope/vim-commentary'           " Commenting blocks
    Plug 'tpope/vim-surround'             " Dealing with surrounding thing (),[]...
    Plug 'tpope/vim-repeat'               " Extended .
    Plug 'tpope/vim-sleuth'               " Sensible indenting
    " Editing
    Plug 'ervandew/supertab'              " Enhanced TAB key
    Plug 'Valloric/YouCompleteMe'         " Code completion
    Plug 'sirver/ultisnips'               " Snippet manager
    Plug 'honza/vim-snippets'             " Common snippets
    Plug 'junegunn/vim-easy-align'        " Linus up text better
    " Plug 'matze/vim-move'               " Better :move + bindings
    Plug 'tpope/vim-abolish'              " Autocorrect+subversion+coercion
    Plug 'christoomey/vim-tmux-navigator' " tmux compatibility
    " Navigation and marks
    Plug 'kshenoy/vim-signature'          " Marking lines
    Plug 'airblade/vim-gitgutter'         " Displays git changes
    " Languages
    Plug 'rust-lang/rust.vim'             " Config for rust
    Plug 'sheerun/vim-polyglot'           " Many-many language specific settings
    Plug 'tmux-plugins/vim-tmux'          " tmux config editing
    " Markdown and writing
    Plug 'junegunn/goyo.vim'              " Distraction free writing
    Plug 'junegunn/limelight.vim'         " Highlighter for goyo
    Plug 'vim-pandoc/vim-pandoc-syntax'   " Markdown
    Plug 'vim-pandoc/vim-pandoc'          " Markdown
call plug#end()

" ----------------------------------------------------------------------------
" Plugin settings
" ----------------------------------------------------------------------------

"" Theme
let g:gruvbox_italic=1 "allow italics
colorscheme gruvbox    "set vim colorscheme
set background=dark    "use dark variant
hi Normal ctermfg=252 ctermbg=none

"" Move with Alt+dir
let g:move_key_modifier = 'A'

"" Autocompletion
set completeopt=menuone,noinsert,noselect
set shortmess+=c " Turn off completion messages

let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'

let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

"" Signature
nmap <leader>s :SignatureToggle<CR>

" TODO: Look into NetRW usge
" TODO: Fix vim-move
" TODO: Reeval omnifunc lines
" TODO: Plugins to check out:
"   vim-matchit     " Improved % matching ? There should be a macro for this
"   FastFold        " Folding
"   vim-sneak       " Two-key search
"   startuptime     " For debug
"   peekaboo        " Register peeker
"   rooter          " changes working directory to project
"   ctags
"
" TODO: Consider splitting the config file
"
" TODO: Repos to check out and steal from:
"   xero/dotfiles
"   gcmt/dotfiles
