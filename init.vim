"dein Scripts-----------------------------
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/mqudsi/.config/nvim/dein/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('flazz/vim-colorschemes')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('valloric/MatchTagAlways')
call dein#add('hail2u/vim-css3-syntax',
	\{'on_ft': ['css']})
call dein#add('tpope/vim-fugitive')
"call dein#add('altercation/vim-colors-solarized')
"call dein#add('frankier/neovim-colors-solarized-truecolor-only')
call dein#add('craigemery/vim-autotag')
"call dein#add('jnurmine/Zenburn')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('majutsushi/tagbar')
call dein#add('airblade/vim-gitgutter')
call dein#add('vim-syntastic/syntastic')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
	  
:map [D <Left>
:map [C <Right>
:map [A <Up>
:map [B <Down>

:map! [D <Left>
:map! [C <Right>
:map! [A <Up>
:map! [B <Down>

set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set number
filetype indent on
syntax on
syntax enable

set t_Co=256
"set background=light
set background=dark
let g:solarized_termcolors=256
let g:solarized_diffmode="high"

:map [H <Home>
:map [5~  "page up
:map [6~  "page down

let &t_8b = "\<ESC>[48;2,%lu,%lum"
let &t_8f = "\<ESC>[38;2,%lu,%lum"
let &t_AB = "\e[48;5;%dm"
let &t_AF = "\e[38;5;%dm"
"set termguicolors

colo evening
"colorscheme solarized

" colors for MatchTagAlways highlights
let g:mta_use_matchparen_group = 0
hi link MatchTag Underlined
autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG set ft=gitcommit

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -fpermissive'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline_theme='bubblegum'
