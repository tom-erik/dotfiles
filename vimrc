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
Plug 'joshdick/onedark.vim'

call plug#end()

set nocompatible

set number
set relativenumber
set signcolumn=yes

set numberwidth=5
set colorcolumn=72,88,120
set cursorline
set autoread
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set autowrite     " Automatically :write before running commands
set noerrorbells visualbell t_vb=

" Backup and swap
set nobackup
set nowritebackup

set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

""
"" Whitespace
""

set expandtab                     " use spaces, not tabs
set shiftwidth=2                  " an autoindent (with <<) is three spaces
set tabstop=2                     " a tab is two spaces
set smarttab
set wrap
set textwidth=80
set formatoptions=qrn1j

set autoindent
set nosmartindent

set listchars=nbsp:·,tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·
set list                          " Show invisible characters
set showbreak=↪

set backspace=indent,eol,start " make backspace work like most other apps
set nojoinspaces                      " 1 space, not 2, when joining sentences.

""
"" Wild settings
""

set wildmode=longest,list,full
set wildmenu

set wildignore+=.hg,.git,.svn                    " Version control

set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,node_modules

" Ignore c# output folders
set wildignore+=*/bin/*,*/obj/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

" Disable OSX
set wildignore+=*.DS_Store

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

  " Save when losing focus
  autocmd FocusLost * :silent! wall

  " Resize splits when the window is resized
  autocmd VimResized * :wincmd 

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'commit' && line("'\"") > 0 && line("'\"") <= line("$") |
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
  autocmd FileType commit setlocal textwidth=72 spell spelllang=en

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

"  autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
augroup END

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

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

" Spelling
"
" There are three dictionaries I use for spellchecking:
"
"   /usr/share/dict/words
"   Basic stuff.
"
"   ~/.vim/custom-dictionary.utf-8.add
"   Custom words (like my name).  This is in my (version-controlled) dotfiles.
"
"   ~/.vim-local-dictionary.utf-8.add
"   More custom words.  This is *not* version controlled, so I can stick
"   work stuff in here without leaking internal names and shit.
"
" I also remap zG to add to the local dict (vanilla zG is useless anyway).
" set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add
nnoremap zG 2zg

" Autocomplete with dictionary words when spell check is on
set complete+=kspell
set complete=.,w,b,u,t
set completeopt=longest,menuone

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

" Colors 

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme onedark
set background=dark  
hi StatusLine guibg=#cf3030
hi StatusLineNC guibg=#54211e guifg=#5dc1c6

set guifont=Menlo:h14

" Convenience mappings ---------------------------------------------------- {{{

" Copying/pasting text to the system clipboard.
noremap  <leader>p "+p
vnoremap <leader>y "+y
nnoremap <leader>y VV"+y
nnoremap <leader>Y "+y

" select line
nmap <space><space> V

" Man
nnoremap M K

" Yank to end of line
nnoremap Y y$

" Reselect last-pasted text
nnoremap gv `[v`]

" Substitute
nnoremap <c-s> :%s/
vnoremap <c-s> :s/

" Open current directory in Finder
nnoremap <leader>O :!open .<cr>

" necessary for incessant Vim config updates
nnoremap <Leader>ss :source $MYVIMRC<CR>

" follow tag, easier for Norwegian keyboard
nnoremap t <C-]>

" better movement between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Adjust viewports to the same size
nnoremap - <C-w>=

" saving and quitting are very common commands

" Hit S in command mode to save, as :w<CR> is a mouthful and MacVim
" Command-S is a bad habit when using terminal Vim.
" We overload a command, but use 'cc' for that anyway.
noremap S :w<CR>

" Make Q useful and avoid the confusing Ex mode.
noremap Q <nop>
" Close window.
noremap QQ :q<CR>
" Close a full tab page.
noremap QW :windo bd<CR>
" Close all.
noremap QA :qa<CR>

nnoremap <leader>o :Files<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" tab and shift+tab to indent and de-indent
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Sort lines
nnoremap <leader>s vip:sort<cr>
vnoremap <leader>s :sort<cr>

" Tabs
noremap <S-Left> :tabp<CR>
noremap <S-Right> :tabn<CR>

" Ack/Quickfix windows
map <leader>q :cclose<CR>
" Center line on previous/next fix.
map - :cprev<CR> zz
map + :cnext<CR> zz
" Center line in previous/next file.
map g- :cpfile<CR> zz
map g+ :cnfile<CR> zz

" Create a split on the given side.
" From http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/ via joakimk.
nmap <leader><left>   :leftabove  vsp<CR>
nmap <leader><right>  :rightbelow vsp<CR>
nmap <leader><up>     :leftabove  sp<CR>
nmap <leader><down>   :rightbelow sp<CR>

cmap %% <C-R>=expand("%:h") . "/" <CR>
" }}}

" Window Resizing {{{
" right/up : bigger
" left/down : smaller
nnoremap <m-right> :vertical resize +3<cr>
nnoremap <m-left> :vertical resize -3<cr>
nnoremap <m-up> :resize +3<cr>
nnoremap <m-down> :resize -3<cr>
" }}}

" Quick editing ----------------------------------------------------------- {{{

nnoremap <leader>ed :vsplit ~/.vim/custom-dictionary.utf-8.add<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>


" }}}

" Searching and movement -------------------------------------------------- {{{

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=15
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

" Made D behave
nnoremap D d$

" Don't move on *
" I'd use a function for this but Vim clobbers the last search when you're in
" a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Directional Keys {{{

" It's 2013.
noremap j gj
noremap k gk
noremap gj j
noremap gk k

noremap <leader>v <C-w>v

" }}}

" List navigation {{{

nnoremap <left>  :bprev<cr>zvzz
nnoremap <right> :bnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

" }}}

" NERD Tree {{{

noremap  <F2> :NERDTreeToggle<cr>
inoremap <F2> <esc>:NERDTreeToggle<cr>
noremap  <S-F2> :NERDTreeFind<cr>
inoremap <S-F2> <esc>:NERDTreeFind<cr>

augroup ps_nerdtree
    au!

    au Filetype nerdtree setlocal nolist
    au Filetype nerdtree nnoremap <buffer> H :vertical resize -10<cr>
    au Filetype nerdtree nnoremap <buffer> L :vertical resize +10<cr>
    " au Filetype nerdtree nnoremap <buffer> K :q<cr>
augroup END

let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore = ['\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ '.*\.o$', 'db.db', 'tags.bak', '.*\.pdf$', '.*\.mid$',
                    \ '^tags$']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeMapJumpFirstChild = 'gK'

" }}}

" Vim {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker keywordprg=:help
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif

    au FileType vim vnoremap <localleader>S y:@"<CR>
    au FileType vim nnoremap <localleader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

    au FileType vim inoremap <c-n> <c-x><c-n>
augroup END

" }}}

" XML {{{

augroup ft_xml
    au!

    au FileType xml setlocal foldmethod=manual

    " Use <localleader>f to fold the current tag.
    au FileType xml nnoremap <buffer> <localleader>f Vatzf

    " Indent tag
    au FileType xml nnoremap <buffer> <localleader>= Vat=
augroup END

" }}}

" YAML {{{

augroup ft_yaml
    au!

    au FileType yaml set shiftwidth=2
augroup END

" }}}

" YAML {{{

augroup ft_python
    au!

    au BufNewFile,BufRead *.py
    \ setlocal tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix
augroup END

" }}}

" "Hub"
vnoremap <leader>H :Gbrowse<cr>
nnoremap <leader>H V:Gbrowse<cr>

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
let g:nv_search_paths = ['~/notes', '~/Documents/misc.md']

" Use fzf instead of Ctrl-p
nnoremap <C-p> :Files<cr>
nnoremap <C-g> :Rg<cr>
nnoremap <C-b> :Buffers<cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Gitgutter
let g:gitgutter_max_signs = 10000

if filereadable(expand("~/.vim/mappings.vim"))
    source ~/.vim/mappings.vim
endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

