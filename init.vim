"dein Scripts-----------------------------
if &compatible
	set nocompatible
endif

let g:python3_host_prog = "python3"
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1

set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
filetype off

if dein#load_state('$HOME/.config/nvim/dein/')
	call dein#begin('$HOME/.config/nvim/dein/')
	call dein#add('Shougo/dein.vim')

	" Add or remove your plugins here:
	" call dein#add('flazz/vim-colorschemes')
	call dein#add('Haron-Prime/evening_vim')

	"core plugins that change the behavior of vim and how we use it globally
	call dein#add('junegunn/fzf',
		\{'build': './install --all 2>/dev/null'})
	call dein#add('jremmen/vim-ripgrep')
	call dein#add('airblade/vim-gitgutter')
	call dein#add('haya14busa/incsearch.vim')
	call dein#add('itchyny/lightline.vim')
	" call dein#add('sickill/vim-pasta')
	call dein#add('tomtom/tcomment_vim')

	"general programming-related plugins
	call dein#add('tpope/vim-surround')
	call dein#add('neomake/neomake',
		\{'on_ft': ['rust', 'c', 'cpp', 'json', 'php', 'python']})
	call dein#add('ludovicchabant/vim-gutentags')
	call dein#add('Chiel92/vim-autoformat',
		\{'on_ft': ['rust', 'c', 'cpp', 'javascript', 'css',
		\ 'vim', 'markdown', 'html', 'go', 'csharp']})

	"deoplete and deoplete core plugins
	call dein#add('Shougo/deoplete.nvim',
		\{'on_i': 1})
	call dein#add('Shougo/context_filetype.vim',
		\{'on_i': 1})
	call dein#add('Shougo/neopairs.vim',
		\{'on_i': 1})
	call dein#add('Shougo/echodoc.vim',
		\{'on_i': 1})

	"deoplete sources
	call dein#add('autozimu/LanguageClient-neovim',
		\{'on_ft': ['rust', 'javascript', 'typescript', 'json', 'html']})
	call dein#add('zchee/deoplete-clang',
		\{'on_i': 1}, {'on_ft': ['cpp', 'c']})
	call dein#add('Shougo/neoinclude.vim',
		\{'on_i': 1}, {'on_ft': ['cpp', 'c']})
	call dein#add('Shougo/neco-vim',
		\{'on_i': 1}, {'on_ft': ['vim']})
	call dein#add('ponko2/deoplete-fish',
		\{'on_i': 1}, {'on_ft': ['fish']})
	call dein#add('Shougo/neco-syntax',
		\{'on_i': 1})

	"syntax plugins, sorted by filetype
	call dein#add('hail2u/vim-css3-syntax',
		\{'on_ft': ['css']})
	call dein#add('vim-scripts/DoxyGen-Syntax',
		\{'on_ft': ['*.doxygen']})
	call dein#add('dag/vim-fish',
		\{'on_ft': ['fish']})
	call dein#add('valloric/MatchTagAlways',
		\{'on_ft': ['html', 'xml']})
	call dein#add('pangloss/vim-javascript',
		\{'on_ft': ['javascript']})
	call dein#add('rhysd/vim-gfm-syntax',
		\{'on_ft': ['markdown']})
	call dein#add('mqudsi/meson.vim',
		\{'on_ft': ['meson']})
	call dein#add('mqudsi/ninja.vim',
		\{'on_ft': ['ninja']})
	call dein#add('tbastos/vim-lua',
		\{'on_ft': ['lua']})
	call dein#add('StanAngeloff/php.vim',
		\{'on_ft': ['php']})
	call dein#add('PProvost/vim-ps1',
		\{'on_ft': ['ps1']})
	call dein#add('rust-lang/rust.vim',
		\{'on_ft': ['rust']})
	call dein#add('cespare/vim-toml',
		\{'on_ft': ['toml']})
	call dein#add('HerringtonDarkholme/yats.vim',
		\{'on_ft': ['typescript']})
	call dein#add('mhartington/nvim-typescript',
		\{'on_ft': ['typescript']})
	call dein#add('Quramy/tsuquyomi',
		\{'on_ft': ['typescript']})
	call dein#add('lervag/vimtex',
		\{'on_ft': ['tex']})

	" Required:
	call dein#end()
	call dein#save_state()
endif

"specify custom filetypes before loading the filetype plugin
autocmd BufRead,BufNewfile */*nginx*/*.conf setfiletype nginx
autocmd BufNewFile,BufRead *.xaml set filetype=xml
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufRead,BufNewFile *.git/COMMIT_EDITMSG set ft=gitcommit
autocmd BufRead,BufNewFile *.fish set filetype=fish
autocmd BufRead,BufNewFile *.expect set filetype=expect
autocmd BufRead,BufNewFile */php-fpm*.conf set filetype=dosini
autocmd BufRead /usr/*include/c++/* set filetype=cpp
autocmd BufRead,BufNewFile *.ps1 set filetype=ps1
autocmd BufRead,BufNewfile */ninja.build set filetype=ninja

"specify comments for languages that commentary does not support oob
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType ninja setlocal commentstring=#\ %s

" Required:
filetype plugin indent on
syntax enable

let g:cargo_makeprg_params = "build"
autocmd FileType rust compiler cargo
autocmd FileType fish compiler fish
autocmd FileType ninja set mp=ninja
autocmd FileType ninja set efm=%Eninja:\ error:\ %f:%l:\ %m,%Z%p^\ near\ here,%-C%s
autocmd FileType nginx setlocal mp=sudo\ nginx\ -t\ -c\ %
autocmd FileType typescript setlocal mp=tsc

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

function! ConfigDeoplete()
    set shortmess +=c
	let g:deoplete#auto_complete_delay = 10
	call deoplete#custom#set('racer', 'rank', 99999)
    call deoplete#custom#set('clang', 'rank', 99999)
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    "enable tabbing through autocomplete results only when the popup is visible
    " inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endfunction

" Removes trailing spaces
function! Trim(path)
    return substitute(a:path, "^[ \t\r\n]*\\|[ \t\r\n]*\$", "", "g")
endfunction

function! PickPath(options)
    for p in a:options
        let path = glob(p)
        if !empty(path)
            return Trim(split(path)[0])
        endif
    endfor
endfunction

function! ConfigDeopleteClang()
  "deoplete-clang configuration
  let clang_path_options = [
      \'/usr/lib/llvm-*/lib/libclang.so',
      \'/Library/Developer/CommandLineTools/usr/lib/libclang.dylib',
      \'/usr/local/llvm*/lib/libclang.so',
    \]
  let g:deoplete#sources#clang#libclang_path = PickPath(clang_path_options)

  let clang_header_options= [
      \'/usr/lib/clang',
      \'/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/',
      \'/usr/include/clang/',
    \]
  let g:deoplete#sources#clang#clang_header = PickPath(clang_header_options)
endfunction

function! ConfigNeomake()
	let g:neomake_enabled_makers = ['makeprg']
	let g:neomake_makeprg_maker = {
		\ 'exe': &makeprg,
		\ 'args': [ '-j4' ],
		\ 'errorformat': &errorformat,
		\ }
	let g:neomake_cpp_clangxx_maker = neomake#makers#ft#cpp#clang()
	let g:neomake_cpp_clangxx_maker.args += ['-I./']
	let g:neomake_cpp_clangtidy_maker = neomake#makers#ft#cpp#clangtidy()
	let g:neomake_cpp_clangtidy_maker.args = ['--'] + g:neomake_cpp_clangxx_maker.args
	let g:neomake_cpp_enabled_makers = ['clangxx', 'clangtidy']
endfunction

let g:neomake_open_list = 1
call dein#set_hook('deoplete.nvim', 'hook_source', function('ConfigDeoplete'))
call dein#set_hook('deoplete-clang', 'hook_source', function('ConfigDeopleteClang'))
call dein#set_hook('neomake', 'hook_source', function('ConfigNeomake'))

let g:deoplete#ignore_sources =  {'_': ['omni', 'omnifunc']}
let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_refresh_always = 1
let deoplete#tag#cache_limit_size = 5000000
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['buffer', 'tag']
" let g:deoplete#sources.cpp = ['clang']
" let g:deoplete#sources.rust = ['rust', 'buffer', 'tag']
" autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

let $RUST_SRC_PATH = glob("$HOME/.rustup/toolchains/nightly*/lib/rustlib/src/rust/src/")
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
	\ 'javascript': ['/usr/local/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
	\ 'typescript': ['/usr/local/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
	\ 'html': ['html-languageserver', '--stdio'],
	\ 'json': ['json-languageserver', '--stdio'],
	\ 'css': ['css-languageserver', '--stdio'],
\ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <M-F> :call LanguageClient_textDocument_references()<CR>

set mouse=a
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set autoindent
set smartindent
set number

set t_Co=256
let g:solarized_termcolors=256
let g:solarized_diffmode="high"

:map [H <Home>
:map [5~  "page up
:map [6~  "page down

" colors for MatchTagAlways highlights
let g:mta_use_matchparen_group = 0
hi link MatchTag Underlined

source $HOME/.config/nvim/lightline.vim
source $HOME/.config/nvim/fzf.vim

set wildignorecase "ignore case for filename completions
set infercase "allow  to complete without matching case when combined with ignorecase
"set ignorecase "but ignorecase makes regex searches case-insensitive :(

"clear highlight on double esc
nnoremap <silent> <esc> :noh<cr>:ccl<cr>:lclose<esc>

"automatically save on buffer change
set hidden
set autowrite

"disable ex mode
noremap Q <Nop>
nmap <F1> <Nop>
vmap <F1> <Nop>
imap <F1> <Esc>

"strip trailing whitespace on save for certain filetypes
" autocmd FileType c,cpp,java,php,rust,javascript,vim,fish autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd BufWritePre <buffer> %s/\s\+$//e

"use Windows-style completions for OmniComplete because they're more
"Dvorak-friendly
"inoremap <C-Space> <C-x><C-o>
"inoremap <C-@> <C-Space>

"F7 to build project (like Visual Studio)
nnoremap <F7> :w <CR> :Neomake! <CR>
inoremap <F7> <Esc> :w <CR> :Neomake! <CR>
"F8 to build/lint single file
nnoremap <F8> :w <CR> :Neomake <CR>
inoremap <F8> <Esc> :w <CR> :Neomake <CR>
"F12 to go to definition (like Visual Studio)
noremap <F12> 

source $HOME/.config/nvim/clipboard.vim

"set termguicolors
if $TERM == 'xterm-256color'
	let t_ut = ""
end

set matchpairs+=<:>
"ctrl+s save
inoremap  :w<CR>
nnoremap  :w<CR>
vmap <C-s> <esc>:w<CR>gv

"magic search
function! s:noregexp(pattern) abort
    let pattern = substitute(pattern, '+', '\\+', "")
    let pattern = '\V' . substitute(pattern, '\\b', '\\>', "")
    echom pattern
    return pattern
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
let g:incsearch#magic = '\v'

"hide highlight on insert
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>

"insert at start of current line by typing in __ (two underscores)
function! DoubleUnderscore()
    let b:cur_col = getcurpos()[2]
    let b:underscore_count = get(b:, "underscore_count", 0)
    let b:underscore_count += 1
    " if b:cur_col != 1 || v:count != 0
    if v:count != 0
	let b:underscore_count = 0
    elseif b:underscore_count == 1
    else
	:silent call feedkeys('i')
	let b:underscore_count = 0
    endif
endfunction
nnoremap <silent> _ _:call DoubleUnderscore()<CR>

"Close quickfix when closing a buffer
"this prevents quickfix from being the only buffer left
source $HOME/.config/nvim/bufferclose.vim

autocmd BufRead *.rs :setlocal tags=./tags;/,$RUST_SRC_PATH/tags
" these have bad indentfiles by default, so no autoformatting here
autocmd FileType vim,tex let b:autoformat_autoindent=0

cabbrev <expr> rg 'Rg'
cabbrev <expr> neomake 'Neomake'

function! AutoExpandTabs()
	let file_path = shellescape(expand("%:p"))
	if empty(file_path)
		return
	endif
	let space_lines = str2nr(system("grep -c '^ ' " . file_path))
	let tab_lines =  str2nr(system("grep -c '^\t' " . file_path))
	if space_lines > tab_lines
		set expandtab
	else
		set noexpandtab
	endif
endfunction

autocmd BufReadPost * :call AutoExpandTabs()

colo evening
