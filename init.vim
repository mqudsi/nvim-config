"dein Scripts-----------------------------
if &compatible
    set nocompatible
endif

let s:nvimroot = $HOME . '/.config/nvim'
let g:python3_host_prog = "python3"
" let g:node_host_prog = get(split(system('which neovim-node-host'), '\n'), 0)

" Options which must be forward declared

let g:LanguageClient_autoStart = 0
let g:LanguageClient_diagnosticsList = 'Location' " prevent it from overwriting qfix when loading a file via qfix
let g:LanguageClient_hasSnippetSupport = 0
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_selectionUI = 'fzf'
let g:matchup_matchparen_deferred = 1
let g:polyglot_disabled = ['latex', 'tex']

" disable the following (neo)vim plugins
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_tutor_mode_plugin = 1

" indentLine completely breaks some syntaxes, notably markdown and latex
" See https://github.com/Yggdroot/indentLine/issues/78
let g:indentLine_fileTypeExclude = ['tex', 'markdown']

let s:dein_cache = '$HOME/.config/nvim/bundle'
let s:dein_home = s:dein_cache . '/repos/github.com/Shougo/dein.vim'
exe 'set rtp +=' . s:dein_home

filetype off
syntax off

if dein#load_state('$HOME/.config/nvim/bundle/')
    call dein#begin('$HOME/.config/nvim/bundle/')
    call dein#add(s:dein_home)

    " Add or remove your plugins here:
    call dein#add('flazz/vim-colorschemes')
    call dein#add('danilo-augusto/vim-afterglow')
    call dein#add('mqudsi/base16-vim')
    " need to first call `let ayucolor="light|dark|mirage"`
    call dein#add('ayu-theme/ayu-vim')

    "core plugins that change the behavior of vim and how we use it globally
    " call dein#add('kien/ctrlp.vim')
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
    call dein#add('machakann/vim-highlightedyank')
    call dein#add('roxma/nvim-yarp')

    "general programming-related plugins
    call dein#add('vim-scripts/a.vim',
        \{'on_cmd': 'A'})
    call dein#add('Chiel92/vim-autoformat',
        \{'on_cmd': 'Autoformat'})
    call dein#add('tpope/vim-endwise') "only handles languages with PITA syntax
    call dein#add('mqudsi/vim-closetag') "only handles (x)html
    call dein#add('sheerun/vim-polyglot')
    call dein#add('tpope/vim-surround')
    " disable vim-matchup for latex
    " call dein#add('andymass/vim-matchup')
    call dein#add('neomake/neomake',
        \{'lazy': 1,
        \'on_cmd': 'Neomake'})
    " call dein#add('ludovicchabant/vim-gutentags',
    "     \{'on_event': 'InsertEnter'})

    "git-related extensions
    call dein#add('rhysd/committia.vim')
    call dein#add('jreybert/vimagit',
        \{'on_cmd': ['Magit', 'MagitOnly']})
    call dein#add('airblade/vim-gitgutter')
    call dein#add('tpope/vim-rhubarb')

    "deoplete and deoplete core plugins
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/context_filetype.vim',
        \{'on_event': 'InsertEnter'})
    "requires cmdheight=2 to show function signature in cmdline, or else noshowmode
    " call dein#add('Shougo/echodoc.vim',
    "     \{'on_i': 1})

    "deoplete sources
    call dein#add('autozimu/LanguageClient-neovim',
        \{'rev': 'next', 'build': 'bash ./install.sh'})
    call dein#add('othree/csscomplete.vim',
        \{'on_event': 'InsertEnter', 'on_if': "index(['css'], &ft) != -1"})

    "syntax plugins, sorted by filetype
    call dein#add('ARM9/arm-syntax-vim.git')
    call dein#add('octol/vim-cpp-enhanced-highlight')
    call dein#add('ap/vim-css-color')
    call dein#add('hail2u/vim-css3-syntax')
    call dein#add('OrangeT/vim-csharp')
    " call dein#add('vim-scripts/DoxyGen-Syntax',
    "    \{'on_ft': ['doxygen']})
    call dein#add('elzr/vim-json')
    call dein#add('pangloss/vim-javascript')
    call dein#add('mqudsi/meson.vim')
    call dein#add('mqudsi/ninja.vim')
    call dein#add('tbastos/vim-lua')
    call dein#add('gabrielelana/vim-markdown')
    call dein#add('jvirtanen/vim-octave')
    call dein#add('StanAngeloff/php.vim')
    call dein#add('PProvost/vim-ps1')
    call dein#add('rust-lang/rust.vim')
    call dein#add('cespare/vim-toml')
    call dein#add('HerringtonDarkholme/yats.vim')
    " call dein#add('Quramy/tsuquyomi',
    "     \{'on_ft': ['typescript']})
    " call dein#add('lervag/vimtex',
    "     \{'on_ft': ['tex']})

    " Required:
    call dein#end()
    call dein#save_state()
endif

"specify custom filetypes before predicating actions on FileType below
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
autocmd BufRead,BufNewfile .clang-format set filetype=yaml

"specify comments for languages that commentary does not support oob
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType ninja setlocal commentstring=#\ %s

"specify default make programs and other settings by file type
let g:cargo_makeprg_params = "build"
autocmd FileType fish compiler fish
autocmd FileType html,php set smartindent
autocmd FileType ninja set mp=ninja
autocmd FileType tex set mp=xelatex\ -halt-on-error\ %:S\;rm\ -f\ %:r:S.\{log,aux,out\}\ %:r:h:S/texput.log
autocmd FileType ninja setlocal efm=%Eninja:\ error:\ %f:%l:\ %m,%Z%p^\ near\ here,%-C%s mp=ninja expandtab
autocmd FileType nginx setlocal mp=sudo\ nginx\ -t\ -c\ %
autocmd FileType rust compiler cargo
autocmd FileType typescript setlocal mp=tsc
autocmd FileType markdown setlocal mp=pandoc\ %:~:.\ -o\ %:~:.:r.pdf\;\ open\ %:~:.:r.pdf

" enable spell-checking by default for these file types
autocmd FileType markdown,plaintex,tex,text set spell

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

function! ConfigDeoplete()
    set shortmess +=c
    call deoplete#custom#option('auto_complete_delay', 20)
    call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
    call deoplete#custom#source('_', 'sorters', []) "sorting already done by cpsm, don't resort

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    "enable tabbing through autocomplete results only when the popup is visible
    " inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endfunction

" Removes trailing spaces
function! Trim(path)
    return substitute(a:path, "^[ \t\r\n]*\\|[ \t\r\n]*\$", "", "g")
endfunction

" Finds the first valid path of the possible paths array passed in as `options`
function! PickPath(options)
    for p in a:options
        let path = glob(p)
        if !empty(path)
            return Trim(split(path)[0])
        endif
    endfor
endfunction

function! ConfigNeomake()
    let g:neomake_open_list = 1
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
    "F7 to build project (like Visual Studio)
    nnoremap <F7> :w <CR> :Neomake! <CR>
    inoremap <F7> <Esc> :w <CR> :Neomake! <CR>
    "F8 to build/lint single file
    nnoremap <F8> :w <CR> :Neomake <CR>
    inoremap <F8> <Esc> :w <CR> :Neomake <CR>

    "see plugin/lightline.vim
    let g:enable_LightlineNeomake = 1
endfunction

autocmd BufEnter *.c,*.cpp,*.js,*.rs,*.ts,*.sh,*.py :call LanguageClientSupportedLanguage()
function! LanguageClientSupportedLanguage()
    nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
    silent! nunmap gd
    nmap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    nmap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
    nmap <silent> <M-F> :call LanguageClient_textDocument_references()<CR>
    " See https://vi.stackexchange.com/a/4291/13499
    " nmap <silent> <C-R> :call LanguageClient_workspace_symbol()<CR>

    "ignore buffer source when we have valid completions
    call deoplete#custom#option('ignore_sources', { &ft: ['buffer', 'member', 'around', 'omni', 'omnifunc', 'tags', 'tag'] })

    "now start LanguageClient only if it wasn't already started
    if exists('b:lcStarted')
        return
    endif

    silent! LanguageClientStart
    let b:lcStarted = 1
endfunction

call dein#set_hook('neomake', 'hook_source', function('ConfigNeomake'))
call dein#set_hook('neomake', 'hook_post_source', function('AfterNeomake'))
call dein#set_hook('deoplete.nvim', 'hook_source', function('ConfigDeoplete'))

" deoplete configuration
let g:deoplete#enable_at_startup = 1
if exists("deoplete#custom#option")
    call deoplete#custom#option({
        \'auto_complete_delay': 100,
        \'ignore_sources': { '_': ['omni', 'omnifunc', 'snippet'] },
        \'camel_case': 1,
        \'max_list': 250,
        \'num_processes': 8,
        \'smart_case': true,
        \'min_pattern_length': 0,
        \'yarp': v:true,
    \})
    autocmd InsertEnter * call deoplete#enable()
endif

" LSP providers installation instructions:
" * c/cpp: sudo apt-get install clang-tools-7 (under Debian/Ubuntu)
" * rust: rustup component add rls-preview --toolchain=nightly
" * python: sudo pip3 install python-language-server
" * bash/js/ts/css/html/json: `yarn install` in config root

let s:node = s:nvimroot . '/node_modules/.bin/'
let g:LanguageClient_serverCommands = {
    \ 'c': ['clangd', '-compile-commands-dir=$PWD/build'],
    \ 'cpp': ['clangd', '-compile-commands-dir=$PWD/build'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'python': ['pyls'],
    \ 'css': [s:node . 'css-languageserver', '--stdio'],
    \ 'html': [s:node . 'html-languageserver', '--stdio'],
    \ 'json': [s:node . 'vscode-json-languageserver', '--stdio'],
    \ 'javascript': [s:node . 'javascript-typescript-stdio'],
    \ 'javascript.jsx': [s:node . 'javascript-typescript-stdio'],
    \ 'typescript': [s:node . 'javascript-typescript-stdio'],
    \ 'typescript.jsx': [s:node . 'javascript-typescript-stdio'],
    \ 'bash': [s:node . 'bash-language-server', 'start'],
    \ 'sh': [s:node . 'bash-language-server', 'start'],
\ }

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
" set cindent
set cinkeys-=0#
set indentkeys-=0#
set nojoinspaces " this isn't a typewriter

:map <Esc>[H <Home>
:map <Esc>[5~ <C-B> "page up
:map <Esc>[6~ <C-F> "page down
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
"reload file if it hasn't been changed since save but it's changed on disk
set autoread

"disable ex mode
nmap Q <Nop>
nmap q: <Nop>

"typing quickly often results in :w being typed in as :W
"fortunately, :W is not a default command for anything
command! W :write

"disable F1
nmap <F1> <Nop>
vmap <F1> <Nop>
imap <F1> <Esc>

"build via makeprg with F8
nnoremap <F8> :w <CR> :make <CR>
inoremap <F8> <Esc> :w <CR> :make <CR>

"allow copy-and-paste by mouse selection and ctrl+c/v
vnoremap <C-c> "*y
" nnoremap <C-v> "*gP
inoremap <C-v> <Esc>"*pa
" We don't want to disable ctrl+v in normal mode, but we do want
" copy-and-paste - this is a good compromise. Ctrl+v twice will paste,
" as the first <C-v> will enter visual mode, then the second will trigger the
" paste.
vnoremap <C-v> "*P

" And support using `gp` to select pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

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

" Includes workaround for cursor jumping around on save
" From https://stackoverflow.com/a/37201230/17027
function! <SID>StripTrailingWhitespaces()
    if index([], &ft) != -1
        return
    endif

    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"F12 to go to definition (like Visual Studio)
noremap <F12> <C-]>

" allow % to match angle brackets
set matchpairs+=<:>
" set a timeout (in ms) for matchpairs to prevent any sluggishness
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

"ctrl+s save
inoremap <C-s> <esc>:w<CR><esc>
nnoremap <C-s> :w<CR>
vmap <C-s> <esc>:w<CR>gv

"ctrl+a to select all in normal mode
nnoremap <C-a> ggVG

"alt+a to switch to header file, courtesy of a.vim
nnoremap <M-a> :A<CR>

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

" autocmd BufRead *.rs :setlocal tags=./tags;/,$RUST_SRC_PATH/tags
" these have bad indentfiles by default, so no autoformatting here
" autocmd FileType vim,tex let b:autoformat_autoindent=0
autocmd FileType html,vim let b:autoformat_autoindent=0

cabbrev <expr> autoformat 'Autoformat'
cabbrev <expr> neomake 'Neomake'

" ripgrep stuff
nmap <m-r> :Rg<CR>
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

" copy text on right-click in visual mode
vmap <RightMouse> "*y

" work around WSL/nvim xterm-256color redraw bug
" let $TERM = ""

" Force the background color to use the terminal background color, regardless
" of colorscheme settings. This works around all background repaint bugs in
" vim and neovim.
" autocmd colorscheme * :highlight Normal ctermbg=0
" autocmd colorscheme * :hi Normal guibg=#2E2E2E

" The vim-highlightedyank plugin flashes the text that was yanked as a result
" of an operation, but the default duration of the selection time is way too
" high that it almost seems persistent.
let g:highlightedyank_highlight_duration = 300

if empty($NO_TERMGUICOLORS)
    set termguicolors
endif
" colo evening
" let g:colors_name = "evening"
" let g:colors_name = "base16-tomorrow-night"
" cursorline disabled until the resolution of https://github.com/neovim/neovim/issues/8159
" set cursorline
" disable highlighting of cursorline, revert to underline only
:hi CursorLine ctermbg=NONE cterm=underline
" set cursorcolumn

" Keep the sign column visible to prevent jarring on/off due to plugin
" interactions
" this gets cancelled when neomake is loaded, so use an autocmd instead
autocmd BufEnter,BufRead,BufNewFile * set signcolumn=yes
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Reduce vim updatetime to allow gitgutter and others to reflect things faster
set updatetime=100 "ms

" Remove unneeded spam from completions status messages
set shortmess +=c

" IndentLine configuration
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239

:silent inoremap <CR>=EnhancedEnter()


" Set default maximum line lengths for various types
autocmd FileType cpp setlocal tw=100
autocmd FileType gitcommit setlocal tw=80
autocmd FileType markdown setlocal tw=100
autocmd FileType rust setlocal tw=100
autocmd FileType plaintex,tex setlocal tw=100

" Begin improve undo granularity/smart undo
function! EnhancedEnter()
    if pumvisible()
        " <Enter> with item selected causes that item to be inserted
        feedkeys('\<C-y>')
    else
        " Improve granularity of undo
        feedkeys("\<C-g>u\<CR>")
    endif
endfunction

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
inoremap <expr> <M-C-H> <SID>start_delete("\<C-W>")
" End improve undo granularity

" alt-bkspc remove last word
inoremap <M-BS> <C-W>

" Explicitly fish as the shell
set shell=fish

" Use our own ctrl+p implementation built around FZF and ripgrep
nnoremap <C-p> :call ctrlp#CtrlP()<CR>

" After everything else
filetype plugin indent on
syntax enable

:silent! colo base16-tomorrow-night
