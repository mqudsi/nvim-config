"dein Scripts-----------------------------
if &compatible
	set nocompatible
endif

let g:python3_host_prog = "python3"

" Options which must be forward declared
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'Location' " prevent it from overwriting qfix when loading a file via qfix
let g:LanguageClient_selectionUI = 'fzf'
let g:matchup_matchparen_deferred = 1

" disable the following (neo)vim plugins
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_tutor_mode_plugin = 1

" indentLine completely breaks some syntaxes, notably markdown and latex
" See https://github.com/Yggdroot/indentLine/issues/78
let g:indentLine_fileTypeExclude = ['tex', 'markdown']

set runtimepath+=$HOME/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
filetype off
syntax off

if dein#load_state('$HOME/.config/nvim/bundle/')
	call dein#begin('$HOME/.config/nvim/bundle/')
	if !has('nvim')
	  call dein#add('roxma/nvim-yarp')
	  call dein#add('roxma/vim-hug-neovim-rpc')
	endif

	" Add or remove your plugins here:
	" call dein#add('flazz/vim-colorschemes')
	" call dein#add('Haron-Prime/evening_vim')

	"core plugins that change the behavior of vim and how we use it globally
	call dein#add('nixprime/cpsm',
		\{'build' : 'sh -c "mkdir -p build && cd build && cmake -DPY3:BOOL=ON .. && make install"'})
	call dein#add('kien/ctrlp.vim')
	call dein#add('junegunn/fzf')
	" call dein#add('haya14busa/incsearch.vim')
	" call dein#add('othree/eregex.vim')
	call dein#add('Yggdroot/indentLine')
	call dein#add('itchyny/lightline.vim')
	call dein#add('alvan/vim-closetag',
		\{'on_ft': ['html', 'xhtml', 'xml']})
	call dein#add('mqudsi/vim-ripgrep')
	" call dein#add('qpkorr/vim-bufkill')
	call dein#add('sickill/vim-pasta',
		\{'on_event': 'InsertEnter'})
	call dein#add('tomtom/tcomment_vim')
	call dein#add('tpope/vim-repeat',
		\{'on_event': 'InsertEnter'})

	"general programming-related plugins
	call dein#add('vim-scripts/a.vim',
		\{'on_cmd': 'A'})
	call dein#add('Chiel92/vim-autoformat',
		\{'on_cmd': 'Autoformat'})
	call dein#add('tpope/vim-endwise.git',
		\{'on_ft': ['vim']}) "handle only languages with PITA syntax
	call dein#add('sheerun/vim-polyglot')
	call dein#add('tpope/vim-surround')
	call dein#add('andymass/vim-matchup')
	call dein#add('neomake/neomake',
		\{'on_cmd': 'Neomake'})
	call dein#add('ludovicchabant/vim-gutentags',
		\{'on_event': 'InsertEnter'})

	"git-related extensions
	call dein#add('rhysd/committia.vim')
	call dein#add('jreybert/vimagit',
		\{'on_cmd': ['Magit', 'MagitOnly']})
	call dein#add('airblade/vim-gitgutter')
	call dein#add('tpope/vim-rhubarb')

	"deoplete and deoplete core plugins
	call dein#add('roxma/nvim-completion-manager')
	" call dein#add('Shougo/deoplete.nvim',
	"	\{'on_i': 1})
	" call dein#add('Shougo/context_filetype.vim',
	" 	\{'on_i': 1})
	" call dein#add('Shougo/neopairs.vim',
	" 	\{'on_i': 1})
	" call dein#add('Shougo/echodoc.vim',
	" 	\{'on_i': 1})

	"deoplete sources
	call dein#add('autozimu/LanguageClient-neovim',
		\{'rev': 'next', 'build': 'bash ./install.sh',
		\'on_ft': ['c', 'cpp', 'js', 'rust', 'typescript']})
	" call dein#add('zchee/deoplete-clang',
	"	\{'on_event': 'InsertEnter', 'on_if': "index(['c', 'cpp'], &ft) != -1"})
	" call dein#add('Chilledheart/vim-clangd',
	call dein#add('roxma/ncm-clang',
		\{'on_event': 'InsertEnter', 'on_if': "index(['c', 'cpp'], &ft) != -1"})
	call dein#add('othree/csscomplete.vim',
		\{'on_event': 'InsertEnter', 'on_if': "index(['css'], &ft) != -1"})
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
	"	\{'on_ft': ['doxygen']})
	call dein#add('dag/vim-fish',
		\{'on_ft': ['fish']})
	call dein#add('elzr/vim-json',
		\{'on_ft': ['json']})
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
autocmd BufRead,BufNewFile *.expect set filetype=expect
autocmd BufRead,BufNewFile *.fish set filetype=fish
autocmd BufRead,BufNewFile *.git/COMMIT_EDITMSG set filetype=gitcommit
autocmd BufRead,BufNewFile *.ps1 set filetype=ps1
autocmd BufRead,BufNewFile *.xaml set filetype=xml
autocmd BufRead,BufNewFile *.csproj,*.targets set filetype=xml
autocmd BufRead,BufNewFile */php-fpm*.conf set filetype=dosini
autocmd BufRead,BufNewFile /usr/*include/c++/* set filetype=cpp
autocmd BufRead,BufNewfile *.conf set filetype=conf
autocmd BufRead,BufNewfile */*nginx*/*.conf set filetype=nginx
autocmd BufRead,BufNewfile */ninja.build set filetype=ninja

"specify comments for languages that commentary does not support oob
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType ninja setlocal commentstring=#\ %s

"specify default make programs by file type
let g:cargo_makeprg_params = "build"
autocmd FileType fish compiler fish
autocmd FileType html,php set smartindent
autocmd FileType ninja set mp=ninja
autocmd FileType tex set mp=xelatex\ -halt-on-error\ %:S\;rm\ -f\ %:r:S.\{log,aux,out\}\ %:r:h:S/texput.log
autocmd FileType ninja set efm=%Eninja:\ error:\ %f:%l:\ %m,%Z%p^\ near\ here,%-C%s
autocmd FileType ninja set mp=ninja
autocmd FileType nginx setlocal mp=sudo\ nginx\ -t\ -c\ %
autocmd FileType rust compiler cargo
autocmd FileType typescript setlocal mp=tsc

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

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

function! AfterNeomake()
	:echoerr "neomake loaded"
	"F7 to build project (like Visual Studio)
	nnoremap <F7> :w <CR> :Neomake! <CR>
	inoremap <F7> <Esc> :w <CR> :Neomake! <CR>
	"F8 to build/lint single file
	nnoremap <F8> :w <CR> :Neomake <CR>
	inoremap <F8> <Esc> :w <CR> :Neomake <CR>
endfunction

function! ConfigLanguageClient()
	" :call dein#remote_plugins()
	nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
	silent! nunmap gd
	nmap <silent> gd :call LanguageClient_textDocument_definition()<CR>
	silent! nunmap <F12>
	nmap <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
	nmap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
	nmap <silent> <M-F> :call LanguageClient_textDocument_references()<CR>
	" See https://vi.stackexchange.com/a/4291/13499
	" nmap <silent> <C-R> :call LanguageClient_workspace_symbol()<CR>
	autocmd BufEnter *.c,*.cpp,*.js,*.rs,*.ts :silent! LanguageClientStart
endfunction

let g:neomake_open_list = 1
" call dein#set_hook('neomake', 'hook_source', function('ConfigNeomake'))
" call dein#set_hook('neomake', 'hook_post_source', function('AfterNeomake'))
call dein#set_hook('LanguageClient-neovim', 'hook_source', function('ConfigLanguageClient'))

let $RUST_SRC_PATH = glob("$HOME/.rustup/toolchains/nightly*/lib/rustlib/src/rust/src/")
let g:LanguageClient_serverCommands = {
	\ 'c': ['clangd', '-compile-commands-dir=$PWD/build'],
	\ 'cpp': ['clangd', '-compile-commands-dir=$PWD/build'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
	\ 'javascript': ['/usr/local/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
	\ 'typescript': ['/usr/local/lib/node_modules/javascript-typescript-langserver/lib/language-server-stdio.js'],
	\ 'html': ['html-languageserver', '--stdio'],
	\ 'json': ['json-languageserver', '--stdio'],
	\ 'css': ['css-languageserver', '--stdio'],
\ }

" Automatically start language servers.

set mouse=a
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set nofsync
set autoread
set laststatus=2
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set autoindent
set smartindent
set number

:map [H <Home>
:map [5~ <C-B> "page up
:map [6~ <C-F> "page down
:map <M-left> :normal <Home><CR>
:map <M-right> :normal <End><CR>

" colors for MatchTagAlways highlights
let g:mta_use_matchparen_group = 0
hi link MatchTag Underlined

set wildignorecase "ignore case for filename completions
set infercase "allow ctrl+n to complete without matching case when combined with ignorecase
"set ignorecase "but ignorecase makes regex searches case-insensitive :(

"clear highlight on double esc
nnoremap <silent> <esc> :noh<cr>:ccl<cr>:lclose<esc>

"automatically save on buffer change
set hidden
set autowrite

"disable ex mode
nmap Q <Nop>
nmap q: <Nop>

"disable F1
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

" Search for visually selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

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

"F12 to go to definition (like Visual Studio)
noremap <F12> <C-]>

set matchpairs+=<:>
"ctrl+s save
inoremap <C-s> <esc>:w<CR><esc>
nnoremap <C-s> :w<CR>
vmap <C-s> <esc>:w<CR>gv

"ctrl+a to select all in normal mode
nnoremap <C-a> ggVG

" "magic search
" function! s:noregexp(pattern) abort
"     let pattern = substitute(a:pattern, '+', '\\+', "")
"     let pattern = substitute(pattern, '\\b', '\\<', "")
"     " :echom pattern
"     return pattern
" endfunction
"
" function! s:config() abort
"     return {'converters': [function('s:noregexp')]}
" endfunction
"
" noremap <silent><expr> z/ incsearch#go(<SID>config())
" "end magic search
"
" "replace search with incsearch
" " map / <Plug>(incsearch-forward)
" map <silent><expr> / incsearch#go(<SID>config())
" map ? <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
" let g:incsearch#magic = '\v'

"hide highlight on insert
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>

autocmd BufRead *.rs :setlocal tags=./tags;/,$RUST_SRC_PATH/tags
" these have bad indentfiles by default, so no autoformatting here
" autocmd FileType vim,tex let b:autoformat_autoindent=0
autocmd FileType vim let b:autoformat_autoindent=0

cabbrev <expr> autoformat 'Autoformat'
" cabbrev <expr> neomake 'Neomake'

" ripgrep stuff
nmap R :Rg<CR>
cabbrev <expr> rg 'Rg'
let g:default_rg_ignore = '-g "!*.{o,out,po}" -g "!tags" -g "!target" -g "!*~"'
" let g:rg_command = "rg " . g:default_rg_ignore . ' --vimgrep -S '
let g:rg_command = 'rg --vimgrep -S ' . g:default_rg_ignore
let g:rg_highlight = 1

"map fzf to ctrl+p
" noremap <c-p> :call ctrlp#CtrlP()<CR>
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

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
nnoremap <silent> <Home> g<Home>
nnoremap <silent> <End> g<End>
inoremap <silent> <Home> <c-o>g<Home>
inoremap <silent> <End> <c-o>g<End>

" keep selections after realign
vmap < <gv
vmap > >gv

" copy text on right-click in visual mode
vmap <RightMouse> "*y

" work around WSL/nvim xterm-256color redraw bug
" let $TERM = ""

" Force the background color to use the terminal background color, regardless
" of colorscheme settings. This works around all background repaint bugs in
" vim and neovim.
" autocmd colorscheme * :highlight Normal ctermbg=0

set termguicolors
" colo evening
let g:colors_name = "evening"
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

" Reduce vim updatetime to allow gitgutter and others to reflect things faster
set updatetime=100

" Remove unneeded spam from completions status messages
set shortmess +=c

" Fish is our primary shell, but this makes things predictable:
set shell=bash

" IndentLine configuration
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239

" Improve granularity of undo
inoremap <CR> <C-G>u<CR>
function! s:start_delete(key)
    let l:result = a:key
    if !s:deleting
        let l:result = "\<C-G>u".l:result
    endif
    let s:deleting = 1
    return l:result
endfunction

function! s:check_undo_break(char)
    if s:deleting
        let s:deleting = 0
        call feedkeys("\<BS>\<C-G>u".a:char, 'n')
    endif
endfunction

augroup smartundo
    autocmd!
    autocmd InsertEnter * let s:deleting = 0
    autocmd InsertCharPre * call s:check_undo_break(v:char)
augroup END

inoremap <expr> <BS> <SID>start_delete("\<BS>")
inoremap <expr> <C-W> <SID>start_delete("\<C-W>")
inoremap <expr> <C-U> <SID>start_delete("\<C-U>")

" After everything else
filetype plugin indent on
syntax enable
