" hide modeline because airline/lightline includes the mode
set noshowmode
let g:lightline = {}
let g:lightline.colorscheme = 'jellybeans'

let g:lightline.active = {
    \ 'left': [ [ 'mode', 'paste' ],
    \           [ 'readonly', 'filename', 'modified' ],
    \           [ 'neomake' ],
    \           [ 'spinner' ]],
    \ 'right': [
    \            [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ],
    \            [ ]] }
let g:lightline.inactive = {
    \ 'left': [ [ 'filename' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }
" let g:lightline.tabline = {
"     \ 'left': [ [ 'tabs' ] ],
"     \ 'right': [ [ 'close' ] ] }

let g:lightline.component = {
    \ 'mode': '%{lightline#mode()}',
    \ 'absolutepath': '%F',
    \ 'relativepath': '%f',
    \ 'filename': '%t',
    \ 'modified': '%M',
    \ 'bufnum': '%n',
    \ 'paste': '%{&paste?"PASTE":""}',
    \ 'readonly': '%R',
    \ 'charvalue': '%b',
    \ 'charvaluehex': '%B',
    \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
    \ 'fileformat': '%{&ff}',
    \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
    \ 'percent': '%3p%%',
    \ 'percentwin': '%P',
    \ 'spell': '%{&spell?&spelllang:""}',
    \ 'lineinfo': '%3l:%-2v',
    \ 'line': '%l',
    \ 'column': '%c',
    \ 'close': '%999X X '
\}

let g:lightline.component_function = {
    \    'neomake': 'LightlineNeomake',
    \    'spinner': 'SpinnerText'
    \ }

" let s:error_symbol = 'E:'
" let s:warn_symbol = 'W:'
"
" function! s:get_counts()
"     let l:counts = neomake#statusline#LoclistCounts()
"
"     if empty(l:counts)
"       return neomake#statusline#QflistCounts()
"     else
"       return l:counts
"     endif
" endfunction
"
" function! NeomakeWarnCount()
"   let counts = s:get_counts()
"   let warnings = get(counts, 'W', 0)
"   return warnings ? s:warn_symbol.warnings : ''
" endfunction
"
" function! NeomakeErrorCount()
"   let counts = s:get_counts()
"   let errors = get(counts, 'E', 0)
"   return errors ? s:error_symbol.errors : ''
" endfunction

function! LightlineNeomake()
    if !exists(':Neomake')
        return
    endif

    return neomake#statusline#QflistStatus()

    " let s:neomake_text = NeomakeWarnCount() . ' ' . NeomakeErrorCount()
    " if s:neomake_text == ''
    "     return 'No Errors'
    " endif
    " return s:neomake_text
endfunction

let s:spinner_index = 0
let s:active_spinners = 0
" let s:spinner_states = ['|', '/', '--', '\', '|', '/', '--', '\']
" let s:spinner_states = ['┤', '┘', '┴', '└', '├', '┌', '┬', '┐']
" let s:spinner_states = ['←', '↑', '→', '↓']
" let s:spinner_states = ['d', 'q', 'p', 'b']
" let s:spinner_states = ['.', 'o', 'O', '°', 'O', 'o', '.']
if has("wsl")
    let s:spinner_states = ['←', '↖', '↑', '↗', '→', '↘', '↓', '↙']
else
    let s:spinner_states = ['■', '□', '▪', '▫', '▪', '□', '■']
endif

function! StartSpinner()
    let b:show_spinner = 1
    let s:active_spinners += 1
    if s:active_spinners == 1
        let s:spinner_timer = timer_start(1000 / len(s:spinner_states), 'SpinSpinner', {'repeat': -1})
    endif
endfunction

function! StopSpinner()
    let b:show_spinner = 0
    let s:active_spinners -= 1
    if s:active_spinners == 0
        :call timer_stop(s:spinner_timer)
    endif
endfunction

function! SpinSpinner(timer)
    let s:spinner_index = float2nr(fmod(s:spinner_index + 1, len(s:spinner_states)))
endfunction

function! SpinnerText()
    if get(b:, 'show_spinner', 0) == 0
        return " "
    endif

    return s:spinner_states[s:spinner_index]
endfunction

augroup neomake_hooks
    au!
    autocmd User NeomakeJobInit :call StartSpinner()
    " autocmd User NeomakeJobInit :echom "Build started"
    autocmd User NeomakeFinished :call StopSpinner()
    " autocmd User NeomakeFinished :echom "Build complete"
augroup END
