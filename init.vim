"dein Scripts-----------------------------
if &compatible
	set nocompatible
endif

set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
filetype off

if dein#load_state('$HOME/.config/nvim/dein/')
	call dein#begin('$HOME/.config/nvim/dein/')
	call dein#add('Shougo/dein.vim')

	" Add or remove your plugins here:
	call dein#add('Shougo/deoplete.nvim',
		\{'on_i': 1})
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('flazz/vim-colorschemes')
	call dein#add('ctrlpvim/ctrlp.vim')
	call dein#add('valloric/MatchTagAlways',
		\{'on_ft': ['html', 'xml', 'htm', 'cshtml']})
	call dein#add('hail2u/vim-css3-syntax',
		\{'on_ft': ['css']})
	call dein#add('tpope/vim-fugitive')
	call dein#add('tpope/vim-surround')
	call dein#add('itchyny/lightline.vim')
	"call dein#add('mgee/lightline-bufferline')
	"call dein#add('altercation/vim-colors-solarized')
	"call dein#add('frankier/neovim-colors-solarized-truecolor-only')
	call dein#add('craigemery/vim-autotag')
	"call dein#add('jnurmine/Zenburn')
	call dein#add('majutsushi/tagbar')
	call dein#add('airblade/vim-gitgutter')
	call dein#add('rust-lang/rust.vim',
		\{'on_ft': ['rust']})
	"call dein#add('racer-rust/vim-racer',
	"	\{'on_ft': ['rust']})
	call dein#add('sebastianmarkow/deoplete-rust',
		\{'on_ft': ['rust']})
	call dein#add('Shougo/neco-vim',
		\{'on_ft': ['vim']})
	call dein#add('ponko2/deoplete-fish',
		\{'on_ft': ['fish']})
	call dein#add('Shougo/neopairs.vim')
	"call dein#add('vim-syntastic/syntastic',
	"	\{'on_ft': ['cpp', 'c', 'h', 'rs']})
	" call dein#add('othree/eregex.vim',
	" 	\{'on_func': 'eregex#toggle'})
	"call dein#add('chrisbra/csv.vim',
	"	\{'on_ft': ['csv']})
	call dein#add('vim-scripts/cmdalias.vim')
	call dein#add('vim-syntastic/syntastic',
		\{'on_ft': ['cpp', 'c', 'h', 'rust']})
	call dein#add('StanAngeloff/php.vim',
		\{'on_ft': ['php']})
	call dein#add('sickill/vim-pasta')
	call dein#add('cespare/vim-toml')

	" You can specify revision/branch/tag.
	"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
	call dein#add('Shougo/vimshell')
	call dein#add('Shougo/vimproc.vim', { 'build': 'make' })
	call dein#add('pangloss/vim-javascript',
		\{'on_ft': ['js']})
	call dein#add('HerringtonDarkholme/yats.vim')
	call dein#add('mhartington/nvim-typescript',
		\{'on_ft': ['ts']})
	call dein#add('Quramy/tsuquyomi',
		\{'on_ft': ['ts']})
	call dein#add('tomtom/tcomment_vim')
"		\{'on_ft': ['cpp', 'c', 'rust', 'php', 'js', 'css', 'cs']})
	call dein#add('dag/vim-fish',
		\{'on_ft': ['fish']})
	call dein#add('haya14busa/incsearch.vim')

	" Required:
	call dein#end()
	call dein#save_state()
endif

"specify custom filetypes before loading the filetype plugin
autocmd BufRead,BufNewfile */nginx/*.conf setfiletype nginx
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufRead,BufNewFile *.git/COMMIT_EDITMSG set ft=gitcommit
autocmd BufRead,BufNewFile *.fish set filetype=fish

" Required:
filetype plugin indent on
syntax enable

let g:cargo_makeprg_params = "build"
autocmd FileType rust compiler cargo
autocmd FileType fish compiler fish
autocmd FileType nginx setlocal mp=sudo\ nginx\ -t\ -c\ %

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
":cnoreabbr cargo make
function ConfigDeoplete()
	call deoplete#custom#set('rust', 'rank', 1000)
	"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
	"enable tabbing through autocomplete results only when the popup is
	"visible
	inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endfunction
call dein#set_hook('deoplete.nvim', 'hook_source', function('ConfigDeoplete'))
call system("which racer")
if v:shell_error == 0
	let g:racer_cmd = systemlist('which racer')[0]
	let g:racer_experimental_completer = 1
	"since we are using deolete-* completions, we can comment that out
	"let g:deoplete#complete_method = 'omnifunc'
	let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
	let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_PATH
	let g:deoplete#sources#rust#documentation_max_height = 20
endif

"set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#sources#rust#show_duplicates = 0

" :map [D <Left>
" :map [C <Right>
" :map [A <Up>
" :map [B <Down>
"
" :map! [D <Left>
" :map! [C <Right>
" :map! [A <Up>
" :map! [B <Down>

" let &t_8b = "\<ESC>[48;2,%lu,%lum"
" let &t_8f = "\<ESC>[38;2,%lu,%lum"
" let &t_AB = "\e[48;5;%dm"
" let &t_AF = "\e[38;5;%dm"

set mouse=a
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set number

set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_diffmode="high"

:map [H <Home>
:map [5~  "page up
:map [6~  "page down


colo evening
"colorscheme solarized

" colors for MatchTagAlways highlights
let g:mta_use_matchparen_group = 0
hi link MatchTag Underlined

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -fpermissive'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" hide modeline because airline/lightline includes the mode
set noshowmode
let g:lightline = {}
let g:lightline.colorscheme      = 'jellybeans'

"bufferline configuration
" let g:lightline#bufferline#show_number  = 1
" let g:lightline#bufferline#shorten_path = 0
" let g:lightline#bufferline#unnamed      = '[No Name]'
" set showtabline=2
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
" let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
" let g:lightline.component_type   = {'buffers': 'tabsel'}

set wildignorecase "ignore case for filename completions
set infercase "allow  to complete without matching case when combined with ignorecase
"set ignorecase "but ignorecase makes regex searches case-insensitive :(

"clear highlight on double esc
nnoremap <silent> <esc> :noh<cr><esc>

"automatically save on buffer change
set hidden
set autowrite

"disable ex mode
noremap Q <Nop>
nmap <F1> <Nop>
vmap <F1> <Nop>
imap <F1> <Esc>

"syntax highlighting for git paging
function LessInitFunc()
	set syntax=diff
endfunction

"strip trailing whitespace on save for certain filetypes
autocmd FileType c,cpp,java,php,rust,js,vim autocmd BufWritePre <buffer> %s/\s\+$//e

"use Windows-style completions for OmniComplete because they're more
"Dvorak-friendly
"inoremap <C-Space> <C-x><C-o>
"inoremap <C-@> <C-Space>

noremap <F7> :make <CR>
inoremap <F7> <Esc>:make<CR>

if !empty(matchstr(system("uname -a"), "Microsoft"))
	let g:clipboard = {
		\ 'name': 'win32yank',
		\ 'copy': {
		\	'+': 'win32yank.exe -i --crlf',
		\	'*': 'win32yank.exe -i --crlf',
		\	},
		\ 'paste': {
		\	'+': 'noerr win32yank.exe -o --lf',
		\	'*': 'noerr win32yank.exe -o --lf',
		\	},
		\ 'cache_enabled': 1,
		\ }
endif

"set termguicolors
if $TERM == 'xterm-256color'
	let t_ut = ""
end

"better search for ctrlp plugin
source $HOME/.config/nvim/matcher.vim

set matchpairs += "<:>"
inoremap  :w<CR> "ctrl+s save
nnoremap  :w<CR> "ctrl+s save
vmap <C-s> <esc>:w<CR>gv "ctrl+s save

"magic search
function! s:noregexp(pattern) abort
  return '\V' . escape(a:pattern, '\')
endfunction

function! s:config() abort
  return {'converters': [function('s:noregexp')]}
endfunction

noremap <silent><expr> z/ incsearch#go(<SID>config())
"end magic search

"replace search with incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"automatically open quickfix on errors
"also, should close it automatically when there are none
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"hide highlight on insert
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>

"insert at start of current line by typing in __ (two underscores)
function DoubleUnderscore()
	if v:count == 0 && getcurpos()[2] == 1
		:silent call feedkeys('I', 'n')
	else
		:silent call feedkeys('^', v:count + 'n')
	endif
endfunction
nnoremap <silent> _ :call DoubleUnderscore()<CR>
