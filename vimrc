set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'othree/html5.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'travisjeffery/vim-auto-mkdir'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'digitaltoad/vim-pug'
Plugin 'scrooloose/nerdtree'
Plugin 'nvie/vim-flake8'
Plugin 'gregsexton/MatchTag'
Plugin 'chriskempson/base16-vim'
call vundle#end()

syntax on
filetype indent plugin on

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType js set omnifunc=htmlcomplete#CompleteTags

"set statusline=%F%m 
set omnifunc=syntaxcomplete#Complete
set hlsearch
set incsearch
set ignorecase
set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set background=dark
set synmaxcol=1000
set wildmode=longest,list,full
set wildmenu
set backupcopy=yes

let g:jsx_ext_required = 0

if exists('+cc')
  set cc=80
endif

" Change dir to current file
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

command! Pudb :normal iimport pudb; pudb.set_trace()
command! Pdb :normal iimport pdb; pdb.set_trace()
command! Ipdb :normal iimport ipdb; ipdb.set_trace()
command! Killall bufdo bdelete
command! SudoSave :w !sudo tee %

" ctrl-j inserts a line break in normal mode
:nnoremap <NL> i<CR><ESC>

map <C-n> :NERDTreeToggle<CR>

