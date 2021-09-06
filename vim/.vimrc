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
filetype plugin on
syntax on
set lazyredraw
set number
set norelativenumber
set ruler
set foldcolumn=2
set breakindent
set splitbelow
set splitright
set showcmd
set scrolloff =6

" Backup settings
set undofile
set backup
set backupdir =~/.vim/.backup//
set directory =~/.vim/.swp//
set undodir   =~/.vim/.undo//

" Basic keybindings
let      mapleader=','
nnoremap <Space>   <C-D>
nnoremap ;         :
vnoremap ;         :
nnoremap Y         y$
map      <Leader>v :so ~/.vimrc<CR>:edit!<CR>
inoremap <F5>      <C-R>=strftime("%Y-%m-%d %H:%M:%S (%Z)")<CR>
nnoremap <Leader>, ;
nnoremap <Leader>; ,

nnoremap k gk
nnoremap j gj
nnoremap H ^

" Force write as superuser cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

" Search and Substitute
set hls
set ignorecase
set smartcase

"" Last modified operator
onoremap <expr> il ':<C-u>norm! `['.strpart(getregtype(), 0, 1).'`]<cr>'

"" Viminfo
set viminfo='100,n$HOME/.vim/files/info/viminfo
if has("nvim")
    set viminfo='100,n$HOME/.vim/files/info/nviminfo
endif

"" GPG File editing setup
" Don't save backups of *.gpg files
set backupskip+=*.gpg

augroup encrypted
  au!
  " Disable swap files, and set binary file format before reading the file
  " To avoid that parts of the file is saved to .viminfo when yanking or
  " deleting, empty the 'viminfo' option.
  autocmd BufReadPre,FileReadPre *.gpg
    \ setlocal noswapfile bin |
    \ setlocal viminfo=
  " Decrypt the contents after reading the file, reset binary file format
  " and run any BufReadPost autocmds matching the file name without the .gpg
  " extension
  autocmd BufReadPost,FileReadPost *.gpg
    \ execute "'[,']!gpg -q --decrypt --default-recipient-self" |
    \ setlocal nobin |
    \ execute "doautocmd BufReadPost " . expand("%:r")
  " Set binary file format and encrypt the contents before writing the file
  autocmd BufWritePre,FileWritePre *.gpg
    \ setlocal bin |
    \ '[,']!gpg --encrypt --default-recipient-self
  " After writing the file, do an :undo to revert the encryption in the
  " buffer, and reset binary file format
  autocmd BufWritePost,FileWritePost *.gpg
    \ silent u |
    \ setlocal nobin
augroup END

" Create directories as needed when writing files.
autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Autoinstall vim-plug and create dirs
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  silent !mkdir -p ~/.vim/.swp ~/.vim/.backup ~/.vim/.undo ~/.vim/files/info
endif

"" Conjure
let g:conjure#log#hud#enabled=v:false

" ----------------------------------------------------------------------------
" Plugins, Manager - https://github.com/junegunn/vim-plug
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    " Theme
    Plug 'whatyouhide/vim-gotham'
    Plug 'robertmeta/nofrils'
    Plug 'kien/rainbow_parentheses.vim'   " So pretty
    " TPope or as good or your money back
    Plug 'tpope/vim-sensible'             " Sensible default settings
    Plug 'tpope/vim-commentary'           " Commenting blocks
    Plug 'tpope/vim-surround'             " Dealing with surrounding thing (),[]...
    Plug 'tpope/vim-repeat'               " Extended . for plugins
    Plug 'tpope/vim-sleuth'               " Sensible indenting
    Plug 'tpope/vim-fugitive'             " For blaming stuff
    Plug 'tpope/vim-abolish'              " Autocorrect+subversion+coercion
    Plug 'tpope/vim-eunuch'               " Sudo write
    Plug 'adelarsq/vim-matchit'		      " Better % matching
    Plug 'tpope/vim-obsession'            " Session handling for tmux
    " Editing
    Plug 'ervandew/supertab'              " Enhanced TAB key
    Plug 'Valloric/YouCompleteMe'         " Code completion
    Plug 'sirver/ultisnips'               " Snippet manager
    Plug 'honza/vim-snippets'             " Common snippets
    Plug 'junegunn/vim-easy-align'        " Linus up text better
    Plug 'mbbill/undotree'		          " Undoes trees
    Plug 'farmergreg/vim-lastplace'       " Last place
    Plug 'wellle/targets.vim'             " Adds text objects for extra editing power
    Plug 'airblade/vim-gitgutter'
    " Navigation and marks
    Plug 'kshenoy/vim-signature'          " Marking lines
    Plug 'francoiscabrol/ranger.vim'      " Ranger instead of netrw
    Plug 'junegunn/fzf.vim'               " Fuzzy finder
    " Languages
    Plug 'rust-lang/rust.vim'             " Config for rust
    Plug 'sheerun/vim-polyglot'           " Many-many language specific settings
    Plug 'zah/nim.vim'                    " Nim editing
    Plug 'python-mode/python-mode', { 'branch': 'develop' }
    Plug 'gauteh/vim-cppman'		      " Cppman integration
    Plug 'PolyCement/vim-tweego'		      
if has("nvim")
    Plug 'Olical/conjure'		          " LISP conversational development
endif
    Plug 'wlangstroth/vim-racket'
    " Writing, non-code
    Plug 'junegunn/goyo.vim'              " Distraction free writing
    Plug 'junegunn/limelight.vim'         " Highlighter for goyo
    Plug 'vim-pandoc/vim-pandoc-syntax'   " Markdown
    Plug 'vim-pandoc/vim-pandoc'          " Markdown
    Plug 'ledger/vim-ledger'		      " For budgeting
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }		          " Personal Wiki management
    Plug 'tools-life/taskwiki'		      " Taskwarrior in vimwiki
    Plug 'lervag/vimtex'		          " Latex editing
    Plug 'rhysd/vim-grammarous'	          " Grammarly but cooler
call plug#end()

" ----------------------------------------------------------------------------
" Plugin settings
" ----------------------------------------------------------------------------

"" Theme
let g:nofrils_heavylinenumbers=1
let g:nofrils_heavycomments=1
let g:nofrils_strbackgrounds=1
colorscheme nofrils-dark    "set vim colorscheme
hi Normal ctermbg=none
let &t_TI = ""
let &t_TE = ""

"" Autocompletion
set completeopt=menu,menuone,noinsert
set shortmess+=c " Turn off completion messages

let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'

"" Snippets
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsListSnippets	   = "<c-r>"
let g:UltiSnipsEditSplit           = "context"

"" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip,a)
xmap <Leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. ,aip)
nmap <Leader>a <Plug>(EasyAlign)

"" Signature
nmap <leader>s :SignatureToggle<CR>

"" Goyo
fun! s:goyo_enter()
  Limelight
endf

fun! s:goyo_leave()
  " Turns off limelight, restarts normal highlight coloring
  Limelight!
  hi Normal ctermbg=none
endf

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"" Limelight settings
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

"" Pymode
let g:pymode_python = 'python3'
let g:pymode_run = 0 
let g:pymode_indent = 1
" Run
nnoremap <silent> <leader>pr :terminal python -i %<CR>
" Debug
nnoremap <silent> <leader>pd :terminal ipdb %<CR>
" Debug until current line
nnoremap <silent> <leader>pl :terminal python -m ipdb -c "unt <C-r>=line('.')<CR>" %<CR>
" Autolint
nnoremap <silent> <leader>pa :PymodeLintAuto<CR>

"" Ranger
let g:ranger_replace_netrw = 1

"" Latex
"wordcount
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'      " for sane file recognition

"" VimWiki

" Wikis setup
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.path_html = '~/vimwiki_html/'

let wiki_2 = {}
let wiki_2.path = '~/games/dnd/poliwiki/'
let wiki_2.path_html = '~/games/dnd/poliwiki_html/'

let g:vimwiki_list = [wiki_1, wiki_2]

"" Undotree
nnoremap <F5> :UndotreeToggle<cr>

"" Octave options
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

"" Rainbow delims
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"" FZF
nnoremap <C-p> :Files<Cr>

" TODO: Plugins to check out:
"
" TODO: Repos to check out and steal from:
