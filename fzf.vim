"fzf configuration and ctrl+p to search all natural sources

let g:default_rg_ignore = '-g "!*.{o,out,po}" -g "!tags" -g "!target" -g "!*~"'
let $FZF_DEFAULT_COMMAND = 'rg --files ' . g:default_rg_ignore
" let g:rg_command = "rg " . g:default_rg_ignore . ' --vimgrep -S '
let g:rg_command = 'rg --vimgrep -S ' . g:default_rg_ignore
let g:rg_highlight = 1

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"default search function
"combines cwd files and open buffers
function! FzfSearchAll()
	let list1 = split(system($FZF_DEFAULT_COMMAND), "\n")
	let list2 = map(range(1, bufnr('$')),'bufname(v:val)')
	let list3 = split(substitute(execute(":oldfiles"), "[0-9][0-9]*: ", "", "g"), "\n")
	"remove no longer existent files fromr list3
	let list3 = filter(list3, '!empty(glob(v:val))')

	let deduplicated = {}
	for l in list1 + list2 + list3
		let deduplicated[l] = ''
	endfor

	call fzf#run({'sink': 'e',
				\'source': keys(deduplicated),
				\'down': '~40%'})
endfunction

"map fzf to ctrl+p
" noremap  :FZF<CR>
noremap  :call FzfSearchAll()<CR>

