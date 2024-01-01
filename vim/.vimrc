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
set noequalalways

" Appearance
set cursorline
filetype plugin indent on
syntax on
set termguicolors
set lazyredraw
set number
set ruler
set foldcolumn=1
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
nnoremap Q @@

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

" ----------------------------------------------------------------------------
" Plugins, Manager - https://github.com/junegunn/vim-plug
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
    " Theme
    " Plug 'whatyouhide/vim-gotham'
    " Plug 'robertmeta/nofrils'
    Plug 'kien/rainbow_parentheses.vim'   " So pretty
    Plug 'morhetz/gruvbox'
    " TPope or as good or your money back
    Plug 'tpope/vim-sensible'             " Sensible default settings
    Plug 'tpope/vim-commentary'           " Commenting blocks
    Plug 'tpope/vim-surround'             " Dealing with surrounding thing (),[]...
    Plug 'tpope/vim-repeat'               " Extended . for plugins
    Plug 'tpope/vim-sleuth'               " Sensible indenting
    Plug 'tpope/vim-fugitive'             " For blaming stuff
    Plug 'tpope/vim-abolish'              " Autocorrect+subversion+coercion
    Plug 'tpope/vim-eunuch'               " Sudo write
    Plug 'tpope/vim-obsession'            " Session handling for tmux
    Plug 'adelarsq/vim-matchit'		  " Better % matching
    " Editing
    Plug 'machakann/vim-swap'             " Swapping things
    Plug 'sirver/ultisnips'               " Snippet manager
    Plug 'honza/vim-snippets'             " Common snippets
    Plug 'junegunn/vim-easy-align'        " Linus up text better
    Plug 'mbbill/undotree'		  " Undoes trees
    Plug 'farmergreg/vim-lastplace'       " Last place
    Plug 'wellle/targets.vim'             " Adds text objects for extra editing power
    Plug 'airblade/vim-gitgutter'
    " Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }
    Plug 'nvim-lua/plenary.nvim'          " Telescope dependency
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'fannheyward/telescope-coc.nvim'
    " Navigation and marks
    Plug 'kshenoy/vim-signature'          " Marking lines
    Plug 'junegunn/fzf.vim'               " Fuzzy finder
    " Languages
    Plug 'rust-lang/rust.vim'             " Config for rust
    Plug 'sheerun/vim-polyglot'           " Many-many language specific settings
    Plug 'zah/nim.vim'                    " Nim editing
    Plug 'python-mode/python-mode', { 'branch': 'develop' }
    Plug 'gauteh/vim-cppman'		      " Cppman integration
    Plug 'PolyCement/vim-tweego'		      
    Plug 'wlangstroth/vim-racket'
    " Writing, non-code
    Plug 'junegunn/goyo.vim'              " Distraction free writing
    " Plug 'junegunn/limelight.vim'         " Highlighter for goyo
    " Plug 'vim-pandoc/vim-pandoc-syntax'   " Markdown
    " Plug 'vim-pandoc/vim-pandoc'          " Markdown
    Plug 'ledger/vim-ledger'		      " For budgeting
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }		          " Personal Wiki management
    " Plug 'tools-life/taskwiki'	    " Taskwarrior in vimwiki
    Plug 'lervag/vimtex'		    " Latex editing
    Plug 'rhysd/vim-grammarous'	            " Grammarly but cooler
    Plug 'pangloss/vim-javascript'
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'

    " nvim specific
    if has("nvim")
        Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
        Plug 'antoinemadec/coc-fzf'
        Plug 'jbyuki/instant.nvim'                " Code collab
        Plug 'kyazdani42/nvim-web-devicons'       " for file icons
        Plug 'kyazdani42/nvim-tree.lua'
        Plug 'feline-nvim/feline.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'puremourning/vimspector'
        " Plug 'github/copilot.vim'
    endif
call plug#end()

" ----------------------------------------------------------------------------
" Plugin settings
" ----------------------------------------------------------------------------

"" Theme
colorscheme gruvbox   "set vim colorscheme
hi Normal ctermbg=none guibg=none
let &t_TI = ""
let &t_TE = ""

"" Autocompletion
set completeopt=menu,menuone,noinsert
set shortmess+=c " Turn off completion messages

"" Snippets
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
let g:UltiSnipsListSnippets       = "<c-r>"
let g:UltiSnipsEditSplit          = "context"
let g:UltiSnipsExpandTrigger      = "<c-j>"

command USE UltiSnipsEdit

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<Tab>" 

inoremap <silent><expr> <S-Tab> 
      \pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:coc_snippet_next = '<Tab>'

"" EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vip,a)
xmap <Leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. ,aip)
nmap <Leader>a <Plug>(EasyAlign)

"" Signature
nmap <leader>s :SignatureToggle<CR>

"" Pymode
let g:pymode_python = 'python3'
let g:pymode_run = 0 
let g:pymode_indent = 1
let g:pymode_lint_ignore = ["E127"]

" Run
augroup python
  autocmd!
  autocmd FileType python
        \ nnoremap <silent> <leader>pr :terminal python -i %<CR>
  autocmd FileType python
        \ nnoremap <silent> <leader>pd :terminal ipdb %<CR>
  autocmd FileType python
        \ nnoremap <silent> <leader>pl :terminal python -m ipdb -c "unt <C-r>=line('.')<CR>" %<CR>
  autocmd FileType python
        \ nnoremap <silent> <leader>pa :PymodeLintAuto<CR>
augroup END

"" Latex
"wordcount
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'      " for sane file recognition

"" VimWiki

" For Obsidian.md integration, along with .md file extension
function! VimwikiLinkHandler(link)
    if a:link =~ '\.\(pdf\|jpg\|jpeg\|png\|gif\|mp3\)$'
        call vimwiki#base#open_link(':e ', 'file:'.a:link)
        return 1
    endif
    return 0
endfunction

"" Vimwiki
source ~/.vimwikirc

"" Undotree
nnoremap <C-h> :UndotreeToggle<cr>

"" Nvim tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

lua<<EOF
require'nvim-tree'.setup {}
EOF

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
command! Ctrlp execute (exists("*fugitive#head") && len(fugitive#head())) ? 'GFiles' : 'Files'
map <C-p> :Ctrlp<CR>
nnoremap <C-A-p> :Commands<Cr>
nnoremap <silent> <Leader>sw :Ag <C-R><C-W><CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-f><c-k> <plug>(fzf-complete-word)
imap <c-f><c-f> <plug>(fzf-complete-path)
imap <c-f><c-l> <plug>(fzf-complete-line)

"" YEP COC
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

set updatetime=300
set signcolumn=yes

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx " was javascript
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx " was typescript

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>ca  <Plug>(coc-codeaction-selected)<cr>
nmap <leader>ca  <Plug>(coc-codeaction-selected)<cr>

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)


" Mappings for CoCList/Telescope coc
" Show all diagnostics.
nnoremap <silent><nowait> <leader>tc  :<C-u>Telescope coc<cr>
" Show all diagnostics.
nnoremap <silent><nowait> <leader>cd  :<C-u>Telescope coc workspace_diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>Telescope coc commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cr  :<C-u>CocListResume<CR>
" Toggle inlay hints (end of line hints
nnoremap <silent><nowait> <leader>ci :<C-u>CocCommand document.toggleInlayHint<CR>

"" Debugging
let g:vimspector_enable_mappings = 'HUMAN'
nmap <Leader>db <Plug>VimspectorBreakpoints
nmap <Leader>dj <Plug>VimspectorGoToCurrentLine

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

cnoreabbrev vr VimspectorReset

"" Statusline
lua << EOC
local gruvbox = {
  bg = '#282828',
  black = '#282828',
  yellow = '#d8a657',
  cyan = '#89b482',
  oceanblue = '#45707a',
  green = '#a9b665',
  orange = '#e78a4e',
  violet = '#d3869b',
  magenta = '#c14a4a',
  white = '#a89984',
  fg = '#a89984',
  skyblue = '#7daea3',
  red = '#ea6962',
}

require('feline').setup({
  theme = gruvbox,
})
EOC

"" Copilot
let g:copilot_filetypes = {
      \ '*': v:false,
      \ "rust": v:true,
      \ "python": v:true,
      \ }

"" Grammar
let g:grammarous#jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'

"" Telescope

nnoremap <leader>tt <cmd>Telescope<cr>

lua << EOF
require("telescope").setup({
  extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  },
})
require('telescope').load_extension('coc')
EOF

" TODO: Plugins to check out:
"
" TODO: Repos to check out and steal from:
