"dein Scripts-----------------------------
if &compatible
	set nocompatible
endif

let g:python3_host_prog = "python3"
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1

" must be forward declared
let g:LanguageClient_diagnosticsList = 'Location' " prevent it from overwriting qfix when loading a file via qfix
let g:LanguageClient_selectionUI = 'fzf'

set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
filetype off

if dein#load_state('$HOME/.config/nvim/dein/')
	call dein#begin('$HOME/.config/nvim/dein/')
	"call dein#add('Shougo/dein.vim', {'rev': 'master'})

	" Add or remove your plugins here:
	" call dein#add('flazz/vim-colorschemes')
	call dein#add('Haron-Prime/evening_vim')

	"core plugins that change the behavior of vim and how we use it globally
	call dein#add('junegunn/fzf')
	call dein#add('airblade/vim-gitgutter')
	call dein#add('haya14busa/incsearch.vim')
	" call dein#add('othree/eregex.vim')
	call dein#add('itchyny/lightline.vim')
	call dein#add('qpkorr/vim-bufkill')
	call dein#add('sickill/vim-pasta')
	call dein#add('tomtom/tcomment_vim')
	call dein#add('tpope/vim-repeat')

	"general programming-related plugins
	call dein#add('tpope/vim-surround')
	call dein#add('benjifisher/matchit.zip')
	call dein#add('neomake/neomake',
		\{'on_ft': ['rust', 'c', 'cpp', 'json', 'php', 'python']})
	call dein#add('ludovicchabant/vim-gutentags')
	call dein#add('Chiel92/vim-autoformat',
		\{'on_ft': ['rust', 'c', 'cpp', 'javascript', 'css',
		\ 'vim', 'markdown', 'html', 'go', 'csharp']})

	"deoplete and deoplete core plugins
	call dein#add('roxma/nvim-completion-manager')
	" call dein#add('Shougo/deoplete.nvim',
	" 	\{'on_i': 1})
	call dein#add('Shougo/context_filetype.vim',
		\{'on_i': 1})
	call dein#add('Shougo/neopairs.vim',
		\{'on_i': 1})
	call dein#add('Shougo/echodoc.vim',
		\{'on_i': 1})

	"deoplete sources
	call dein#add('autozimu/LanguageClient-neovim',
		\{'rev': 'next', 'build': 'bash ./install.sh',
		\'on_if': "index(['c', 'cpp', 'js', 'rust'], &ft) != -1"})
	" call dein#add('zchee/deoplete-clang',
	" 	\{'on_event': 'InsertEnter', 'on_if': "index(['c', 'cpp'], &ft) != -1"})
	call dein#add('Shougo/neoinclude.vim',
		\{'on_event': 'InsertEnter', 'on_if': "index(['c', 'cpp'], &ft) != -1"})
	" call dein#add('Chilledheart/vim-clangd',
	call dein#add('roxma/ncm-clang',
		\{'on_event': 'InsertEnter', 'on_if': "index(['c', 'cpp'], &ft) != -1"})
	call dein#add('othree/csscomplete.vim',
		\{'on_event': 'InsertEnter', 'on_if': "index(['css'], &ft) != -1"})
	call dein#add('roxma/ncm-github',
		\{'on_if': "index(['c', 'cpp', 'gitcommit', 'js', 'ts', 'vim'], &ft) != -1"})
	call dein#add('Shougo/neco-vim',
		\{'on_event': 'InsertEnter', 'on_if': "index(['vim'], &ft) != -1"})
	call dein#add('ponko2/deoplete-fish',
		\{'on_event': 'InsertEnter', 'on_if': "index(['fish'], &ft) != -1"})
	call dein#add('Shougo/neco-syntax',
		\{'on_i': 1})

	"syntax plugins, sorted by filetype
	call dein#add('ARM9/arm-syntax-vim.git')
	call dein#add('hail2u/vim-css3-syntax',
		\{'on_ft': ['css']})
	call dein#add('OrangeT/vim-csharp')
	" call dein#add('vim-scripts/DoxyGen-Syntax',
	" 	\{'on_ft': ['doxygen']})
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
autocmd BufRead,BufNewfile *.conf set filetype=conf
autocmd BufRead,BufNewfile */*nginx*/*.conf set filetype=nginx
autocmd BufNewFile,BufRead *.xaml set filetype=xml
autocmd BufRead,BufNewFile *.git/COMMIT_EDITMSG set filetype=gitcommit
autocmd BufRead,BufNewFile *.fish set filetype=fish
autocmd BufRead,BufNewFile *.expect set filetype=expect
autocmd BufRead,BufNewFile */php-fpm*.conf set filetype=dosini
autocmd BufRead /usr/*include/c++/* set filetype=cpp
autocmd BufRead,BufNewFile *.ps1 set filetype=ps1
autocmd BufRead,BufNewfile */ninja.build set filetype=ninja
autocmd BufRead,BufNewFile */tsconfig.json set filetype=javascript

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
autocmd FileType html,php set smartindent

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

function! ConfigDeoplete()
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

function! ConfigLanguageClient()
	:call dein#remote_plugins()
	nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
	nmap <silent> gd :call LanguageClient_textDocument_definition()<CR>
	nmap <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
	nmap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
	nmap <silent> <M-F> :call LanguageClient_textDocument_references()<CR>
	nmap <silent> <C-R> :call LanguageClient_workspace_symbol()<CR>
	autocmd FileType cpp :let g:LanguageClient_serverCommands['cpp'] = ['clangd-6.0', '-compile-commands-dir=$PWD/build']
endfunction

let g:neomake_open_list = 1
" call dein#set_hook('deoplete.nvim', 'hook_source', function('ConfigDeoplete'))
" call dein#set_hook('deoplete-clang', 'hook_source', function('ConfigDeopleteClang'))
call dein#set_hook('neomake', 'hook_source', function('ConfigNeomake'))
call dein#set_hook('LanguageClient-neovim', 'hook_source', function('ConfigLanguageClient'))

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
	\ 'cpp': ['clangd-6.0', '-compile-commands-dir=$PWD/build'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
	\ 'javascript': ['/usr/local/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
	\ 'typescript': ['/usr/local/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
	\ 'html': ['html-languageserver', '--stdio'],
	\ 'json': ['json-languageserver', '--stdio'],
	\ 'css': ['css-languageserver', '--stdio'],
\ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

set mouse=a
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set autoindent
set smartindent
set number

:map [H <Home>
:map [5~  "page up
:map [6~  "page down

" colors for MatchTagAlways highlights
let g:mta_use_matchparen_group = 0
hi link MatchTag Underlined

source $HOME/.config/nvim/lightline.vim

set wildignorecase "ignore case for filename completions
set infercase "allow  to complete without matching case when combined with ignorecase
"set ignorecase "but ignorecase makes regex searches case-insensitive :(

"clear highlight on double esc
nnoremap <silent> <esc> :noh<cr>:ccl<cr>:lclose<esc>

"automatically save on buffer change
set hidden
set autowrite

"disable ex mode
nmap Q <Nop>
nmap <F1> <Nop>
vmap <F1> <Nop>
imap <F1> <Esc>

"allow copy-and-paste by mouse selection and ctrl+c/v
vnoremap <C-c> "*y
" nnoremap <C-v> "*gP
inoremap <C-v> <Esc>"*pi
" We don't want to disable ctrl+v in normal mode, but we do want
" copy-and-paste - this is a good compromise. Ctrl+v twice will paste,
" as the first <C-v> will enter visual mode, then the second will trigger the
" paste.
vnoremap <C-v> "*P

" From https://stackoverflow.com/a/37201230/17027
" Includes workaround for cursor jumping around on save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" autocmd FileType c,cpp,java,php,rust,javascript,vim,fish autocmd BufWritePre :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

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

set matchpairs+=<:>
"ctrl+s save
inoremap  <esc>:w<CR><esc>
nnoremap  :w<CR>
vmap <C-s> <esc>:w<CR>gv

"ctrl+a to select all in normal mode
nnoremap <C-a> ggVG

"magic search
function! s:noregexp(pattern) abort
    let pattern = substitute(a:pattern, '+', '\\+', "")
    let pattern = substitute(pattern, '\\b', '\\<', "")
    " :echom pattern
    return pattern
endfunction

function! s:config() abort
    return {'converters': [function('s:noregexp')]}
endfunction

noremap <silent><expr> z/ incsearch#go(<SID>config())
"end magic search

"replace search with incsearch
" map / <Plug>(incsearch-forward)
map <silent><expr> / incsearch#go(<SID>config())
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#magic = '\v'

"hide highlight on insert
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>

"Close quickfix when closing a buffer
"this prevents quickfix from being the only buffer left
source $HOME/.config/nvim/bufferclose.vim

autocmd BufRead *.rs :setlocal tags=./tags;/,$RUST_SRC_PATH/tags
" these have bad indentfiles by default, so no autoformatting here
" autocmd FileType vim,tex let b:autoformat_autoindent=0
autocmd FileType vim let b:autoformat_autoindent=0

cabbrev <expr> autoformat 'Autoformat'
cabbrev <expr> neomake 'Neomake'
cabbrev <expr> BN 'BF'
cabbrev <expr> BP 'BB'

" ripgrep stuff
nmap R :Rg<CR>
cabbrev <expr> rg 'Rg'
let g:default_rg_ignore = '-g "!*.{o,out,po}" -g "!tags" -g "!target" -g "!*~"'
" let g:rg_command = "rg " . g:default_rg_ignore . ' --vimgrep -S '
let g:rg_command = 'rg --vimgrep -S ' . g:default_rg_ignore
let g:rg_highlight = 1

" fzf.vim must be sourced after ripgrep init above
source $HOME/.config/nvim/fzf.vim

autocmd BufReadPost * :call DetectTabExpand()

function! DetectTabExpand()
	let file_path = shellescape(expand("%:p"))
	if empty(file_path)
		return
	endif

	let b:tabs_spaces = [0, 0]
	let b:tabs_spaces_index = 0
	call jobstart([&shell, &shcf, "grep -c '^ ' " . file_path . "; grep -c '^\t' " . file_path],
		\ { 'on_stdout': function('InnerDetectTabExpand') })
endfunction

function! InnerDetectTabExpand(job, lines, event) dict
	let b:tabs_spaces[b:tabs_spaces_index] = str2nr(a:lines[0])
	let b:tabs_spaces_index = b:tabs_spaces_index + 1

	if b:tabs_spaces_index == 2
		if b:tabs_spaces[0] > b:tabs_spaces[1] "more spaces than tabs
			set expandtab
		else
			set noexpandtab
		endif

		let b:tabs_spaces_index = 0
	endif
endfunction

" remap up/down arrow keys to move by screen line
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>

nnoremap <space> <c-d>

" copy text on right-click in visual mode
vmap <RightMouse> "*y

" work around WSL/nvim xterm-256color redraw bug
" let $TERM = ""

" Force the background color to use the terminal background color, regardless
" of colorscheme settings. This works around all background repaint bugs in
" vim and neovim.
" autocmd colorscheme * :highlight Normal ctermbg=0

colo evening
" cursorline disabled until the resolution of https://github.com/neovim/neovim/issues/8159
" set cursorline
" disable highlighting of cursorline, revert to underline only
:hi CursorLine ctermbg=NONE cterm=underline
" set cursorcolumn

" Keep the sign column visible to prevent jarring on/off due to plugin
" interactions
" this gets cancelled when neomake is loaded, so use an autocmd instead
" set signcolumn="yes"
" autocmd BufRead,BufNewFile setlocal signcolumn="yes"
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
set updatetime=100
set shortmess +=c
set shell=bash
