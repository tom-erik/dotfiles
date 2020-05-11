" Inspiration from
" https://github.com/nkantar/dotfiles/blob/master/vim/vimrc

let mapleader = ","

call plug#begin('~/.vim/bundle')

Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'jremmen/vim-ripgrep'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'

Plug 'davidoc/taskpaper.vim'
Plug 'w0rp/ale'

Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'itspriddle/vim-marked'
Plug 'rakr/vim-one'

call plug#end()

set nocompatible

set number
set relativenumber
set signcolumn=yes

set numberwidth=5
" set colorcolumn=50,72,88
set cursorline
set autoread
set nobackup
set nowritebackup
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands
set nowrap
set noerrorbells visualbell t_vb=

""
"" Whitespace
""

set expandtab                     " use spaces, not tabs
set shiftwidth=2                  " an autoindent (with <<) is three spaces
set tabstop=2                     " a tab is three spaces
set smarttab

set autoindent
set nosmartindent

set scrolloff=15

set list                          " Show invisible characters

set backspace=indent,eol,start " make backspace work like most other apps

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Wild settings
""

set wildmode=longest,list,full
set wildmenu

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Ignore c# output folders
set wildignore+=*/bin/*,*/obj/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Statusline
""

if has("statusline") && !&cp
  set laststatus=2                   " always show the status bar
  set statusline=%<\ %f\        " filename
  set statusline+=%m%r          " modified, readonly
  set statusline+=\ %y          " filetype
  set statusline+=\ %{fugitive#head()}
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*%=                 " left-right separation point
  set statusline+=\ %l/%L[%p%%] " current line/total lines
  set statusline+=\ %v[0x%B]    " current char [hex char]
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
"  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile todo.txt set filetype=taskpaper

  " Enable spellchecking for Markdown
  autocmd FileType markdown,mail setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72 spell spelllang=en

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

"  autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
augroup END

" Display extra whitespace
set list listchars=tab:»·

let g:netrw_list_hide= '^\.git/$,^\.DS_Store$'
let g:netrw_sizestyle="h"
let g:netrw_banner = 0
let g:netrw_liststyle = 3 "tree style listing

""
"" General Mappings (Normal, Visual, Operator-pending)
""

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
" set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
if &diff
   set diffopt+=vertical
endif

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>
map Q gq

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Toggle hlsearch with <leader>hs
nnoremap <CR> :noh<CR><CR>
nmap <leader>hs :set hlsearch! hlsearch?<CR>

set termguicolors
set background=dark  
colorscheme one

" system clipboard
vmap <Leader>y "+y
set clipboard=unnamed

" select line
nmap <space><space> V

" necessary for incessant Vim config updates
nnoremap <Leader>ss :source $MYVIMRC<CR>

" better movement between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Adjust viewports to the same size
map <Leader>= <C-w>=

" saving and quitting are very common commands
nnoremap <Leader>w :write<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>x :xit<CR>
nnoremap <Leader>e :edit<CR>
nnoremap <leader>o :Files<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"==================================================
" MacVim
"-------------------------
set guifont=Menlo:h14
if has("gui_macvim")
    set lines=75 columns=120
endif

"==================================================
" Plugin config
"-------------------------

" w0rp/ale
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin on

" Prettier
autocmd BufWritePre *.html execute ':Prettier'
autocmd BufWritePre *.scss execute ':Prettier'

" notational-fzf 
let g:nv_search_paths = ['~/Documents/notes', '~/Documents/misc.md']
nnoremap <silent> <c-s> :NV<CR>

" Use fzf instead of Ctrl-p
nnoremap <C-p> :Files<Cr>
nnoremap <C-g> :Rg<Cr>

" Gitgutter
let g:gitgutter_max_signs = 10000

if filereadable(expand("~/.vim/mappings.vim"))
    source ~/.vim/mappings.vim
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

