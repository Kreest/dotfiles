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
nnoremap <Leader>x "+
nnoremap ;         :
vnoremap ;         :
nnoremap Y         y$
map      <Leader>v :so ~/.vimrc<CR>:edit!<CR>
inoremap <F5>      <C-R>=strftime("%Y-%m-%d %H:%M:%S (%Z)")<CR>
nnoremap <Leader>, ;
nnoremap <Leader>; ,

nnoremap k gk
nnoremap j gj

" Force write as superuser
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Search and Substitute
set hls
set ignorecase
set smartcase

"" Last modified operator
onoremap <expr> il ':<C-u>norm! `['.strpart(getregtype(), 0, 1).'`]<cr>'

"" Explore in vertical split
nnoremap <Leader>e :Explore! <enter>

"" Viminfo
set viminfo='100,n$HOME/.vim/files/info/viminfo

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
    Plug 'whatyouhide/vim-gotham'
    " Pope
    Plug 'tpope/vim-sensible'             " Sensible default settings
    Plug 'tpope/vim-commentary'           " Commenting blocks
    Plug 'tpope/vim-surround'             " Dealing with surrounding thing (),[]...
    Plug 'tpope/vim-repeat'               " Extended .
    Plug 'tpope/vim-sleuth'               " Sensible indenting
    Plug 'tpope/vim-fugitive'             " For blaming stuff
    Plug 'tpope/vim-abolish'              " Autocorrect+subversion+coercion
    Plug 'adelarsq/vim-matchit'		  " Better % matching
    " Editing
    Plug 'ervandew/supertab'              " Enhanced TAB key
    Plug 'Valloric/YouCompleteMe'         " Code completion
    Plug 'sirver/ultisnips'               " Snippet manager
    Plug 'honza/vim-snippets'             " Common snippets
    Plug 'junegunn/vim-easy-align'        " Linus up text better
    " Plug 'matze/vim-move'                 " Better :move + bindings
    Plug 'wellle/targets.vim'             " Adds text objects for extra editing power
    " Navigation and marks
    Plug 'kshenoy/vim-signature'          " Marking lines
    Plug 'airblade/vim-gitgutter'         " Displays git changes
    Plug 'francoiscabrol/ranger.vim'      " Ranger instead of netrw
    Plug 'TheLastProject/vim-betterK'	  " Better K help
    " Languages
    Plug 'rust-lang/rust.vim'             " Config for rust
    Plug 'sheerun/vim-polyglot'           " Many-many language specific settings
    Plug 'zah/nim.vim'                    " Nim editing
    Plug 'python-mode/python-mode', { 'branch': 'develop' }
					  " For python things
    " Markdown and writing
    Plug 'junegunn/goyo.vim'              " Distraction free writing
    Plug 'junegunn/limelight.vim'         " Highlighter for goyo
    Plug 'vim-pandoc/vim-pandoc-syntax'   " Markdown
    Plug 'vim-pandoc/vim-pandoc'          " Markdown
    Plug 'ledger/vim-ledger'		  " For budgeting
    Plug 'vimwiki/vimwiki'		  " Personal Wiki management
    Plug 'lervag/vimtex'		  " Latex editing
call plug#end()

" ----------------------------------------------------------------------------
" Plugin settings
" ----------------------------------------------------------------------------

"" Theme
colorscheme gotham    "set vim colorscheme
set background=dark    "use dark variant
hi Normal ctermfg=252 ctermbg=none

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

"" Goyo
fun! s:goyo_enter()
  Limelight
endf

fun! s:goyo_leave()
  Limelight!
  hi Normal ctermfg=252 ctermbg=none
endf

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"" Limelight settings
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

"" Pymode
let g:pymode_python = 'python3'
let g:pymode_run_bind = '<leader>örasdkfjqlkjralsdkfja' "delete this
let g:pymode_indent = 1
" Run
nnoremap <silent> <leader>pr :terminal++close python -i %<CR>
" Debug
nnoremap <silent> <leader>pd :terminal++close ipdb %<CR>
" Debug until current line
nnoremap <silent> <leader>pl :terminal++close python -m ipdb -c "unt <C-r>=line('.')<CR>" %<CR>
" Autolint
nnoremap <silent> <leader>pa :PymodeLintAuto<CR>


"" Ranger
let g:ranger_replace_netrw = 1

"" Latex
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
let g:polyglot_disabled = ['latex']
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'      " for sane file recognition
let g:vimtex_compiler_latexmk_engines = {
    \ 'pdflatex'         : '-pdf',
    \}

"" VimWiki
function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'tabnew ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction


" TODO: Plugins to check out:
"
" TODO: Repos to check out and steal from:
