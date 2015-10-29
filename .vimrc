execute pathogen#infect()

syntax on
filetype indent plugin on
colorscheme desert

set statusline+=%F
set omnifunc=syntaxcomplete#Complete
set hlsearch
set ignorecase
set number
set tabstop=8
set expandtab
set shiftwidth=2
set softtabstop=2
set background=dark

if exists('+cc')
  set cc=80
endif

" Change dir to current file
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

" Break into pdb
command! Pdb :normal iimport pdb; pdb.set_trace()

