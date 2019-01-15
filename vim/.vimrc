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
map      <Leader>v :so ~/.vimrc<CR>
inoremap <F5>      <C-R>=strftime("%Y-%m-%d %H:%M:%S (%Z)")<CR>
nnoremap <Leader>, ,
nnoremap <Leader>; ;

nnoremap k gk
nnoremap j gj

" Force write as superuser
cmap w!! w !sudo tee > /dev/null %

" Search and Substitute
set hls
set ignorecase
set smartcase
nnoremap <silent> <leader><space> :nohls<enter>

"" Last modified operator
onoremap <expr> il ':<C-u>norm! `['.strpart(getregtype(), 0, 1).'`]<cr>'

"" Omnicompletion
set filetype=on
set omnifunc=syntaxcomplete#Complete
set rtp+=~/.vim/plugged/YouCompleteMe

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

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" ----------------------------------------------------------------------------
" Plugins, Manager - https://github.com/junegunn/vim-plug
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    " Theme
    Plug 'morhetz/gruvbox'
    " Plug 'dracula/vim', { 'as': 'dracula' }
    " Pope
    Plug 'tpope/vim-sensible'             " Sensible default settings
    Plug 'tpope/vim-commentary'           " Commenting blocks
    Plug 'tpope/vim-surround'             " Dealing with surrounding thing (),[]...
    Plug 'tpope/vim-repeat'               " Extended .
    Plug 'tpope/vim-sleuth'               " Sensible indenting
    Plug 'tpope/vim-fugitive'             " For blaming stuff
    Plug 'tpope/vim-abolish'              " Autocorrect+subversion+coercion
    " Editing
    Plug 'ervandew/supertab'              " Enhanced TAB key
    Plug 'Valloric/YouCompleteMe'         " Code completion
    Plug 'sirver/ultisnips'               " Snippet manager
    Plug 'honza/vim-snippets'             " Common snippets
    Plug 'junegunn/vim-easy-align'        " Linus up text better
    Plug 'matze/vim-move'               " Better :move + bindings
    Plug 'wellle/targets.vim'             " Adds text objects for extra editing power
    " Navigation and marks
    Plug 'kshenoy/vim-signature'          " Marking lines
    Plug 'airblade/vim-gitgutter'         " Displays git changes
    " Languages
    Plug 'rust-lang/rust.vim'             " Config for rust
    Plug 'sheerun/vim-polyglot'           " Many-many language specific settings
    Plug 'tmux-plugins/vim-tmux'          " tmux config editing
    Plug 'zah/nim.vim'                    " Nim editing
    Plug 'python-mode/python-mode', { 'branch': 'develop' }
    " Markdown and writing
    Plug 'junegunn/goyo.vim'              " Distraction free writing
    Plug 'junegunn/limelight.vim'         " Highlighter for goyo
    Plug 'vim-pandoc/vim-pandoc-syntax'   " Markdown
    Plug 'vim-pandoc/vim-pandoc'          " Markdown
    Plug 'ledger/vim-ledger'		  " For budgeting
    Plug 'vimwiki/vimwiki'		  " Personal Wiki management
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
set completeopt=menu,menuone,noinsert,preview
set shortmess+=c " Turn off completion messages

let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'

let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
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

"" Limelight settings
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

"" Pymode
let g:pymode_python = 'python3'
let g:pymode_run_bind = '<leader>pr'
let g:pymode_indent = 1
" Debug
nnoremap <leader>pd :terminal++close ipdb %<CR>
" Debug until current line
nnoremap <leader>pl :terminal++close python -m ipdb -c "unt <C-r>=line('.')<CR>" %<CR>
let g:move_key_modifier = 'C'
" TODO: Plugins to check out:
"
" TODO: Repos to check out and steal from:
