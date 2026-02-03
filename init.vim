"dein Scripts-----------------------------
if &compatible
    set nocompatible
endif

let s:nvimroot = $HOME . '/.config/nvim'
" Speed up startup by preventing neovim from searching the filesystem trying
" to find a python3 interpreter. This requires `python3` to be in $PATH.
let g:python3_host_prog = "python3"
" let g:node_host_prog = get(split(system('which neovim-node-host'), '\n'), 0)
" Disable netrw
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1

" Options which must be forward declared

let mapleader = " "
" Improve performance by delaying highlighting of matching keyword (matchup)
let g:matchup_matchparen_deferred = 1
" Disable poor polyglot plugins, keep the rest
" The csv plugin in particular has an extremely buggy version of elastic tabs
" and causes lots of hangs and even data loss.
let g:polyglot_disabled = ['sensible', 'latex', 'tex', 'csv']
" We have our own, better indentation detection plugin
let g:polyglot_disabled += ['autoindent']

" disable the following unused (neo)vim plugins to speed things up.
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_tutor_mode_plugin = 1

" indentLine completely breaks some syntaxes, notably markdown and latex
" See https://github.com/Yggdroot/indentLine/issues/78
" https://stackoverflow.com/questions/40601818#comment68457913_40604923
let g:indentLine_fileTypeExclude = ['tex', 'markdown', 'jsonc']
let s:dein_cache = '$HOME/.cache/dein.vim'
let s:dein_home = '$HOME/.config/nvim/dein.vim'
exe 'set rtp +=' . s:dein_home

" committia sets the main editor pane to 80 characters for git commit
" messages, but under recent neovim versions with line numbers and a git
" gutter, that isn't enough and causes lines to wrap.
let g:committia_edit_window_width = 86

" Clear jump list at startup so Ctrl-O/Ctrl-I only track current session.
" We can't just call :clearjumps because the jump list hasn't been loaded yet.
autocmd VimEnter * :clearjumps

filetype off
syntax off

if dein#load_state(s:dein_cache)
    call dein#begin(s:dein_cache)

    " Add or remove your plugins here:
    call dein#add('flazz/vim-colorschemes')
    call dein#add('danilo-augusto/vim-afterglow')
    call dein#add('mqudsi/base16-vim')
    " need to first call `let ayucolor="light|dark|mirage"`
    call dein#add('ayu-theme/ayu-vim')

    " NeoVim bugfixes and enhancements
    " vim-fetch lets `nvim foo.cpp:17` work (open file and go to line)
    call dein#add('wsdjeg/vim-fetch')

    " Core plugins that change the behavior of vim and how we use it globally
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('junegunn/fzf')
    " call dein#add('haya14busa/incsearch.vim')
    " call dein#add('othree/eregex.vim')
    call dein#add('Yggdroot/indentLine')
    call dein#add('itchyny/lightline.vim')
    call dein#add('mqudsi/vim-ripgrep')
    " call dein#add('qpkorr/vim-bufkill')
    call dein#add('sickill/vim-pasta',
        \{'on_event': 'InsertEnter'})
    call dein#add('tomtom/tcomment_vim')
    call dein#add('tpope/vim-repeat',
        \{'on_event': 'InsertEnter'})
    call dein#add('machakann/vim-highlightedyank')
    call dein#add('roxma/nvim-yarp')
    call dein#add('andymass/vim-visput')
    " structural search-and-replace for TreeSitter languages
    " Keys mapped in lua below: <leader>sr to search and <leader>cr to replace all
    call dein#add('cshuaimin/ssr.nvim')
    " Support ci", etc. across lines
    call dein#add('nvim-mini/mini.ai', #{
	\ 	lua_post_source: "require('mini.ai').setup()"
	\ })

    " General programming-related plugins
    call dein#add('mqudsi/a.vim')
    call dein#add('Chiel92/vim-autoformat',
        \{'on_cmd': 'Autoformat'})
    call dein#add('tpope/vim-endwise') " Only handles languages with PITA syntax
    call dein#add('mqudsi/vim-polyglot')
    call dein#add('tpope/vim-surround')
    " TODO: disable vim-matchup for latex
    call dein#add('andymass/vim-matchup')

    " These are LSP plugins using neovim 0.5's native LSP support
    call dein#add('neovim/nvim-lspconfig')
    call dein#add('hrsh7th/nvim-cmp')
    call dein#add('hrsh7th/cmp-nvim-lsp')
    " cmp requires a snippets engine because it refuses to filter snippet
    " suggestions out from LSPs that don't check if snippets are supported.
    call dein#add('L3MON4D3/LuaSnip')
    call dein#add('saadparwaiz1/cmp_luasnip')

    call dein#add('neomake/neomake',
        \{'lazy': 1,
        \'on_cmd': 'Neomake'})
    call dein#add('nvim-treesitter/nvim-treesitter',
        \{'hook_post_update': 'TSUpdate all'})

    " git-related extensions
    call dein#add('rhysd/committia.vim')
    call dein#add('jreybert/vimagit',
        \{'on_cmd': ['Magit', 'MagitOnly']})
    call dein#add('airblade/vim-gitgutter')
    call dein#add('tpope/vim-rhubarb')

    call dein#add('Shougo/context_filetype.vim',
        \{'on_event': 'InsertEnter'})
    " requires cmdheight=2 to show function signature in cmdline, or else noshowmode
    call dein#add('Shougo/echodoc.vim',
        \{'on_i': 1})

    " syntax plugins, sorted by filetype
    call dein#add('ARM9/arm-syntax-vim.git')
    call dein#add('cespare/vim-toml',
        \{'rev': 'main'})
    " call dein#add('ap/vim-css-color')
    call dein#add('hail2u/vim-css3-syntax')
    " call dein#add('vim-scripts/DoxyGen-Syntax',
    "    \{'on_ft': ['doxygen']})
    call dein#add('elzr/vim-json')
    call dein#add('gabrielelana/vim-markdown')
    call dein#add('HerringtonDarkholme/yats.vim')
    call dein#add('hjson/vim-hjson')
    call dein#add('jvirtanen/vim-octave')
    call dein#add('pangloss/vim-javascript')
    call dein#add('mqudsi/meson.vim')
    call dein#add('mqudsi/ninja.vim')
    call dein#add('norcalli/nvim-colorizer.lua')
    call dein#add('octol/vim-cpp-enhanced-highlight')
    " This is no longer maintained:
    " call dein#add('OrangeT/vim-csharp')
    call dein#add('PProvost/vim-ps1')
    call dein#add('rust-lang/rust.vim')
    call dein#add('StanAngeloff/php.vim')
    call dein#add('tbastos/vim-lua')
    " call dein#add('Quramy/tsuquyomi',
    "     \{'on_ft': ['typescript']})
    " call dein#add('lervag/vimtex',
    "     \{'on_ft': ['tex']})

    " Required:
    call dein#end()
    call dein#save_state()
    call dein#call_hook('source')
endif
autocmd VimEnter * call dein#call_hook('post_source')

" Specify custom filetypes before predicating actions on FileType below
autocmd BufRead,BufNewFile *.expect setlocal filetype=expect
autocmd BufRead,BufNewFile *.fish setlocal filetype=fish
autocmd BufRead,BufNewFile *.git/COMMIT_EDITMSG setlocal filetype=gitcommit
autocmd BufRead,BufNewFile *.ps1 setlocal filetype=ps1
autocmd BufRead,BufNewFile *.xaml setlocal filetype=xml
autocmd BufRead,BufNewFile *.csproj,*.targets setlocal filetype=xml
autocmd BufRead,BufNewFile */php-fpm*.conf setlocal filetype=dosini
autocmd BufRead,BufNewFile /usr/*include/c++/* setlocal filetype=cpp
autocmd BufRead,BufNewfile *.conf setlocal filetype=conf
autocmd BufRead,BufNewfile */*nginx*/*.conf setlocal filetype=nginx
autocmd BufRead,BufNewfile .clang-format setlocal filetype=yaml
autocmd BufRead,BufNewfile *.strace setlocal filetype=strace
autocmd BufRead,BufNewfile *.trace setlocal filetype=strace

" Prevent accidentally modifying cargo registry
autocmd BufRead,BufNewFile,FileReadPost,FilterReadPost
    \ */.cargo/registry/src/* setlocal readonly

" Support triple slash for inline documentation in languages that use such a
" thing. This supports joining and continuing. Vim overrides this in c.vim,
" so we need to either place this in syntax/after/c.vim or use this hack to do
" it here in init.vim
autocmd Filetype c,cpp,csharp :execute timer_start(250, "AddTripleSlash")
function! AddTripleSlash(_1)
    :setlocal comments^=:///
endfunction

" Specify comments for languages that commentary does not support oob
autocmd FileType meson setlocal commentstring=#\ %s
autocmd FileType ninja setlocal commentstring=#\ %s

" Specify default make programs and other settings by file type
let g:cargo_makeprg_params = "build"
autocmd FileType fish compiler fish
autocmd FileType html,php setlocal smartindent
autocmd FileType ninja setlocal mp=ninja
autocmd FileType tex setlocal mp=xelatex\ -halt-on-error\ %:S\;rm\ -f\ %:r:S.\{log,aux,out\}\ %:r:h:S/texput.log
autocmd FileType ninja setlocal efm=%Eninja:\ error:\ %f:%l:\ %m,%Z%p^\ near\ here,%-C%s mp=ninja expandtab
autocmd FileType nginx setlocal mp=sudo\ nginx\ -t\ -c\ %
autocmd FileType rust compiler cargo
autocmd FileType typescript setlocal mp=tsc
autocmd FileType markdown setlocal mp=pandoc\ %:~:.\ --pdf-engine\ tectonic\ -o\ %:~:.:r.pdf\&\&\ open\ %:~:.:r.pdf

" Allow comments in JSON files. We could use a whitelist, but it's too hard.
autocmd Filetype json :execute timer_start(50, "SetJsonWithComments")
function! SetJsonWithComments(_1)
    :setlocal ft=jsonc
endfunction

" Allow folding but don't fold everything by default
set foldlevelstart=99
set foldmethod=syntax

" Enable spell-checking by default for these file types
autocmd FileType markdown,plaintex,tex,text,gitcommit setlocal spell
" Disable spelling errors on uncapitalized first letter of line (breaks on
" hard text wrapping)
set spellcapcheck=no

" Fix indentation in switch blocks
autocmd FileType c,cpp,csharp setlocal cinoptions+=l1

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Add support for SRT files (together with ./syntax/srt.vim)
au BufNewFile,BufRead *.srt setf srt
au BufNewFile,BufRead *.srt setlocal spell

" End dein Scripts-------------------------

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Only use <TAB> to accept an autocompletion, which fixes the conflict between
" enter for newline and enter to accept completions.
" 1B,5B,43: right arrow
" 05: <C-E>
" 19: <C-Y>
let g:completion_trigger_character = ['.', '/', ':']
function! EnhancedAutocomplete()
    " if exists("b:pum_close_pending") && b:pum_close_pending == v:true
    "   let b:pum_close_pending = v:false
    "   return "\<c-y>"
    " elseif pumvisible()
    if pumvisible()
        let b:pum_close_pending = v:true
        return "\<c-y>"
    else
        return "\<tab>"
    end
endfunction
inoremap <expr><tab> EnhancedAutocomplete()
" Automatically select the first item in the menu when shown but do not insert
set completeopt=menuone,noinsert
" Map <C-space> to trigger the popup menu like in Visual Studio
inoremap <expr><c-space> pumvisible() ? "\<c-space>" : "\<c-x>\<c-o>"

function! s:VisualStudio()
    " Visual Studio doesn't have a toggle comment action, so we need to use
    " separate shortcuts there to comment and uncomment selections. For
    " muscle-memory reasons, add the same bingings here:
endfunction
xmap <C-K><C-U> :TComment<CR>
xmap <C-K><C-C> :TComment<CR>
call s:VisualStudio()

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

" autocmd BufEnter *.c,*.cpp,*.js,*.rs,*.ts,*.sh,*.py,*.cs :call LanguageClientSupportedLanguage()
function! LanguageClientSupportedLanguage()
    " let g:LanguageClient_hoverPreview = "Never"
    nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
    silent! nunmap gd
    nmap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    " Also use the Visual Studio F12 shortcut for goto definition
    nmap <silent> <F12> :call LanguageClient_textDocument_definition()<CR>
    " Obviously we can't use the Visual Studio shortcut, that's the binding
    " for redo!
    " nmap <silent> <C-R><C-R> :call LanguageClient_textDocument_rename()<CR>
    nmap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
    nmap <silent> <M-F> :call LanguageClient_textDocument_references()<CR>
    " See https://vi.stackexchange.com/a/4291/13499
    " nmap <silent> <C-R> :call LanguageClient_workspace_symbol()<CR>

    "now start LanguageClient only if it wasn't already started
    if exists('b:lcStarted')
        return
    endif

    silent! LanguageClientStart
    let b:lcStarted = 1
endfunction

call dein#set_hook('neomake', 'hook_source', function('ConfigNeomake'))
call dein#set_hook('neomake', 'hook_post_source', function('AfterNeomake'))

set shortmess +=c

" LSP providers installation instructions:
" * c/cpp: sudo apt-get install clang-tools-7 (under Debian/Ubuntu)
" * rust: cargo install rust-analyzer
" * python: sudo pip3 install python-language-server
" * bash/js/ts/css/html/json: `yarn install` in config root

lua << EOF

-- Key map to enable %% in command mode to expand to %:h (e.g. to create file in current dir)
vim.keymap.set("c", "%%", "<C-R>=expand('%:h').'/'<cr>")

-- SSR structural search and replace mappings
require("ssr").setup {
  min_width = 50,
  min_height = 5,
  keymaps = {
    close = "q",
    next_match = "n",
    prev_match = "N",
    replace_all = "<leader><cr>",
  },
}
vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)

-- Begin LSP configuration

-- GLOBAL DEFAULTS
-- Apply these to *all* servers automatically.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- disable snippets because they take up an entire page of completions
-- and can't (yet) be sorted to show after everything else :(
capabilities.textDocument.completion.completionItem.snippetSupport = false

vim.lsp.config('*', {
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- KEYMAPPINGS
-- As of neovim 0.11, we are forced to use an autocommand (instead of passing `on_attach` for each server)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Helper functions
    local opts = { noremap=true, silent=true, buffer=bufnr }
    local function buf_set_option(name, value) vim.api.nvim_set_option_value(name, value, { buf = bufnr }) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- LSP mappings
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<M-F>', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)

    -- Inlay Hints (Optional)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
})

-- Global diagnostics mappings (not buffer specific)
local global_opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, global_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, global_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, global_opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, global_opts)

-- LANGUAGE-SPECIFIC SERVER CONFIGURATIONS
-- Provide specific configs for servers to override certain default settings.

-- Rust Analyzer

-- Determine if we'll use the Windows or Linux rust-analyzer.exe
local cwd = vim.fn.getcwd()
local is_windows_drive = string.match(cwd, "^/mnt/%l/")

-- Overall rust lsp configuration/integration
ra_capabilities = vim.tbl_deep_extend('force', {}, capabilities)
-- from the nvim-lspconfig wiki:
ra_capabilities.experimental = {
  serverStatusNotification = true,
  commands = {
    commands = {
      'rust-analyzer.showReferences',
      'rust-analyzer.runSingle',
      'rust-analyzer.debugSingle',
    },
  },
}

local ra_config = {
    capabilities = ra_capabilities,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = { group = "module" },
                prefix = "self",
            },
            cargo = {
                buildScripts = { enable = true },
                features = "all",
            },
            procMacro = { enable = true },
            assist = { emitMustUse = true },
            -- completion = { snippets = { custom = {} } },
            -- neovim doesn't support markdown links in documentation
            hover = { links = { enable = false } },
            completion = {
                autoimport = {
                    exclude = {
                        {
                            path = "std::fmt::Debug",
                            type = "methods",
                        },
                        {
                            path = "std::fmt::Display",
                            type = "methods",
                        },
                        {
                            path = "std::fmt::Pointer",
                            type = "methods",
                        },
                        {
                            path = "std::any::Any",
                            type = "methods",
                        },
                        {
                            path = "std::borrow::Borrow",
                            type = "methods",
                        },
                        {
                            path = "std::borrow::BorrowMut",
                            type = "methods",
                        },
                        {
                            path = "std::clone::CloneToUninit",
                            type = "methods",
                        },
                        {
                            path = "tracing::Instrument",
                            type = "methods",
                        },
                        {
                            path = "tracing::instrument::WithSubscriber",
                            type = "methods",
                        },
                        {
                            path = "std::ops::Deref",
                            type = "methods",
                        },
                    }
                }
            },
            inlayHints = {
                -- closureReturnTypeHints = { enable = true },
                -- discriminantHints = { enable = true },
                -- renderColons = false,
                typeHints = {
                    hideNamedConstructor = true,
                },
            },
            -- adapted from default lspconfig settings:
            lens = {
                enable = true,
                run = { enable = true },
                debug = { enable = true },
                implementations = { enable = true },
                references = {
                    adt = { enable = true },
                    enumVariant = { enable = true },
                    method = { enable = true },
                    trait = { enable = true },
                },
                updateTest = { enable = true },
            }
        }
    }
}

-- Attach the rust-analyzer config to neovim's LSP client settings
vim.lsp.config('rust_analyzer', ra_config)

-- Clangd
vim.lsp.config('clangd', {
  cmd = { 'clangd', '--background-index', '--compile-commands-dir=' .. vim.fn.getcwd() .. '/build' },
  filetypes = { "c", "cpp" },
  -- Native 0.11 uses 'root_markers' list instead of a root_dir function
  root_markers = { "build/compile_commands.json", "compile_commands.json", "compile_flags.txt", ".git" },
})

-- VimLS
vim.lsp.config('vimls', {
  cmd = { vim.fn.stdpath("config") .. '/node_modules/.bin/vim-language-server', '--stdio' },
})

-- Omnisharp
vim.lsp.config('omnisharp', {
  cmd = { "/opt/omnisharp/run", "-lsp", "-hpid", tostring(vim.fn.getpid()) },
})

-- TypeScript language server
-- Note: 'tsserver' is deprecated and renamed to 'ts_ls'
vim.lsp.config('ts_ls', {
  cmd = { vim.fn.stdpath("config") .. '/node_modules/.bin/typescript-language-server', '--stdio' },
})

-- Lua LS
vim.lsp.config('lua_ls', {
  cmd = { "/opt/lua-language-server/bin/lua-language-server" },
})

-- ENABLE SERVERS
-- Finally, enable the servers you want.
local servers = {
  "pyright",
  "rust_analyzer",
  "cmake",
  "clangd",
  "vimls",
  "omnisharp",
  "ts_ls",
  "lua_ls"
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- CMP CONFIGURATION
-- nvim-lsp only provides completion; autocompletion must be provided by another plugin (here, nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
  sources = {
    { name = 'nvim_lsp' },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
})


-- DIAGNOSTICS MOUSE INTEGRATION
-- Diagnostics do not appear in any of (neo)vim's lists, and are shown only with
-- `:lua vim.diagnostic.open_float()`, either manually or on a keybinding. Here
-- we bind them to show when clicked on with the mouse.
vim.keymap.set({'n', 'i'}, '<LeftMouse>', function()
  -- 1. Get the position of the mouse click
  local pos = vim.fn.getmousepos()

  -- If clicked outside a valid window (e.g. command line), just return
  if pos.winid == 0 then
    return
  end

  -- 2. Move the cursor to the clicked position (mimic normal click behavior)
  vim.api.nvim_set_current_win(pos.winid)
  -- pos.line is 1-based, pos.column is 1-based (byte index)
  -- nvim_win_set_cursor expects 1-based line, 0-based column
  pcall(vim.api.nvim_win_set_cursor, pos.winid, {pos.line, pos.column - 1})

  -- 3. Check for diagnostics at the clicked position
  local buf = vim.api.nvim_win_get_buf(pos.winid)
  local line_diagnostics = vim.diagnostic.get(buf, { lnum = pos.line - 1 })

  -- Mouse column is 1-based, diagnostic indices are 0-based
  local clicked_col = pos.column - 1

  for _, d in ipairs(line_diagnostics) do
    -- Check if the click is within the diagnostic's range
    -- d.col is inclusive, d.end_col is exclusive
    if clicked_col >= d.col and clicked_col < d.end_col then
      -- 4. Open the float
      vim.schedule(function()
        vim.diagnostic.open_float({ scope = "cursor", focus = false })
      end)
      return
    end
  end
end, { noremap = true, silent = true, desc = "Move cursor and show diagnostic on click" })


EOF

set title
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

" Make sure the default fallback ~/.local/share/nvim/backup exists!
set backupdir-=.

" Persist undo/redo history across sessions.
" Neovim appears to automatically create ~/.local/share/nvim/undo
"
" Git commit messages share a path but are distinct each time, so they should
" be excluded.
autocmd BufRead,BufNewFile * :call <SID>SetUndoFile()
function! <SID>SetUndoFile()
    if index(["gitcommit", "gitrebase"], &ft) == -1
        :silent! set undofile
    endif
endfunction

:map <Esc>[H <Home>
:map <Esc>[5~ <C-B> "page up
:map <Esc>[6~ <C-F> "page down
:map <M-left> :normal <Home><CR>
:map <M-right> :normal <End><CR>
" Alt + F4 to (cleanly) exit
nnoremap <F52> :q <CR>

" Compatibility with tmux-style buffer switching
:nnoremap <c-b>n :bn<CR>
:nnoremap <c-b>p :bp<CR>
:nnoremap <c-b>d :bd<CR>

" colors for MatchTagAlways highlights
let g:mta_use_matchparen_group = 0
hi link MatchTag Underlined

set wildignorecase "ignore case for filename completions
set infercase "allow ctrl+n to complete without matching case when combined with ignorecase
"set ignorecase "but ignorecase makes regex searches case-insensitive :(

" Clear highlight on double esc
nnoremap <silent> <esc> :noh<cr>:ccl<cr>:lclose<esc>

" Automatically save on buffer change
set hidden
set autowrite
" Reload file if it hasn't been changed since save but it's changed on disk
set autoread
au FocusGained * :checktime

" Disable ex mode
nmap Q <Nop>
nmap q: <Nop>

" Typing quickly often results in, e.g. :w being typed in as :W
" Fortunately, :W is not a default command for anything
command! W :write
command! Bn :bn
command! Bp :bp

" Disable F1
nmap <F1> <Nop>
vmap <F1> <Nop>
imap <F1> <Esc>

" Build via makeprg with F8
nnoremap <F8> :w <CR> :make <CR>
inoremap <F8> <Esc> :w <CR> :make <CR>

" Allow copy-and-paste by mouse selection and ctrl+c/v
vnoremap <C-c> "*y
" Mark undo point and then paste
inoremap <C-v> <C-G>u<Esc>"*pa

" We don't want to disable ctrl+v in normal mode, but we do want
" copy-and-paste - this is a good compromise. Ctrl+V twice will paste, as the
" first <C-V> will enter visual mode, then the second will trigger the paste.
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

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
function! <SID>StripTrailingWhitespaces()
    " Exclude certain file types from whitespace modification
    if index(["diff", "gitcommit", "gitrebase", "rst"], &ft) != -1
        return
    endif

    " Save cursor location so it does not change after modifications
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e

    " Restore previous cursor location
    call cursor(l, c)
endfun

" F12 to go to definition (like Visual Studio)
noremap <F12> <C-]>

" Allow % to match angle brackets
set matchpairs+=<:>

" Set a timeout (in ms) for matchpairs to prevent any sluggishness
let g:matchup_matchparen_timeout = 20
let g:matchup_matchparen_insert_timeout = 20

" ctrl+s save
inoremap <C-s> <esc>:w<CR><esc>
nnoremap <C-s> :w<CR>
vmap <C-s> <esc>:w<CR>gv

" ctrl+a to select all in normal mode
nnoremap <C-a> ggVG

" alt+a to switch to header file, courtesy of a.vim
nnoremap <M-a> :A<CR>

" As (neo)vim does not support ctrl+shift+x modifiers, and <C-T> does
" not work in the web browser, map F3/Shift-F3 to have something that
" works everywhere for jumping to next/previous match while doing an
" incremental search.
augroup vimrc-unified-search-jumping
  autocmd!
  autocmd CmdlineEnter /,\? cnoremap <F3> <C-G>
  autocmd CmdLineEnter /,\? cnoremap <F15> <C-T>

  autocmd CmdlineLeave /,\? :cunmap <F3>
  autocmd CmdlineLeave /,\? :cunmap <F15>
augroup END

" Hide highlight on insert
autocmd InsertEnter * setlocal nohlsearch
autocmd InsertLeave * setlocal hlsearch lz
inoremap <silent><Esc> <Esc>:nohl<bar>set nolz<CR>
inoremap <silent><C-c> <C-c>:nohl<bar>set nolz<CR>

" autocmd BufRead *.rs :setlocal tags=./tags;/,$RUST_SRC_PATH/tags
" these have bad indentfiles by default, so no autoformatting here
" autocmd FileType vim,tex let b:autoformat_autoindent=0
autocmd FileType html,vim let b:autoformat_autoindent=0

" :command! does not allow lowercase commands, but I don't care.
" Allows things like mapping `:verbose cmd` to `:verbose Cmd`, but
" doesn't mess with things like `:echo cmd`
function! <SID>cmdabbr(shortcut, cmd)
    :execute "cnoreabbrev <expr> " . a:shortcut .
        \ " (getcmdtype() == ':' && getcmdline() =~ '^" . a:shortcut . "$')" .
        \ " ? '" . a:cmd . "' : '" . a:shortcut . "'"
endfunction

autocmd! BufRead,BufNewFile *.vim inoreabbrev <expr> ; ""

:call <SID>cmdabbr("autoformat", "Autoformat")
:call <SID>cmdabbr("neomake", "Neomake")
:call <SID>cmdabbr("rg", "Rg")

" ripgrep stuff
nmap <m-r> :Rg<CR>
let g:default_rg_ignore = '-g "!*.{o,out,po}" -g "!tags" -g "!target" -g "!*~"'
let g:rg_command = 'rg --vimgrep -S ' . g:default_rg_ignore
let g:rg_highlight = 1

" Remap up/down arrow keys to move by screen line
nnoremap <Up> g<Up>
nnoremap <Down> g<Down>
nnoremap <silent> <Home> g<Home>
nnoremap <silent> <End> g<End>
inoremap <silent> <Home> <c-o>g<Home>
inoremap <silent> <End> <c-o>g<End>

" Copy text on right-click in visual mode
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
autocmd BufEnter,BufRead,BufNewFile * setlocal signcolumn=yes
autocmd BufEnter * sign define dummy
autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

" Reduce vim updatetime to allow gitgutter and others to reflect things faster
set updatetime=100 "ms

" Remove unneeded spam from completions status messages
set shortmess +=c

" IndentLine configuration
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239

" Set default maximum line lengths for various types
autocmd FileType cpp setlocal tw=100
autocmd FileType gitcommit setlocal tw=80
autocmd FileType rust setlocal tw=100
autocmd FileType plaintex,tex setlocal tw=100
autocmd FileType markdown setlocal tw=0
autocmd FileType ninja setlocal tw=0

" Improve granuarity of undo commands
:silent inoremap <CR>=EnhancedEnter()
" Begin improve undo granularity/smart undo
function! EnhancedEnter()
    if false && pumvisible()
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

" alt-bkspc to remove last word
inoremap <M-BS> <C-W>

" Explicitly fish as the shell
set shell=fish

" Use our own ctrl+p implementation built around FZF and ripgrep
nnoremap <C-p> :call ctrlp#CtrlP()<CR>

" Enable nvim-colorizer for all file types
" Note: Neovim 0.4.2+ required or you'll see errors about tbl_flatten
lua require'colorizer'.setup()

" After everything else
filetype plugin indent on
syntax enable

:silent! colo base16-tomorrow-night

" Save all open files and exit cleanly when USR1 is received.
" This comes in handy when you have an SSH session open to a server from
" one machine, then remote in from another and realize you weren't using
" screen/tmux before editing the files you were working on. You can run
" `killall -USR1 nvim` then open the files and resume editing.
autocmd Signal SIGUSR1 call SaveAndExit()
function SaveAndExit()
    " This will save files that have a valid path, e.g. where `expand('%:p')
    " does not evaluate to an empty value.
    :wa
    :cq!
endfunction

" Neovim TreeSitter is still very much experimental and I have not found a
" language where the legacy regex-based highlighting and indenting isn't a
" superior option (as of 2021-10-04 and nvim NVIM v0.6.0-dev+334-g9cde1e589)

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { "rust" },
  },
  indent = {
    enable = true,
    disable = { "rust" },
  }
}
EOF
