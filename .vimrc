execute pathogen#infect()

syntax on
filetype indent plugin on
colorscheme desert

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
command! Pudb :normal iimport pudb; pudb.set_trace()
command! Pdb :normal iimport pdb; pdb.set_trace()
command! Ipdb :normal iimport ipdb; ipdb.set_trace()

" ctrl-j inserts a line break in normal mode
:nnoremap <NL> i<CR><ESC>

