"fzf configuration and ctrl+p to search all natural sources

let $FZF_DEFAULT_COMMAND = 'rg -files ' . g:default_rg_ignore

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

function! ctrlp#CtrlP()
	" We want the output to include
	" a) files in neovim's current (aka startup) directory,
	" b) files in the same directory as the file being edited,
	" c) recently edited files
	"
	" We want all this to be done asynchronously, so we don't pre-populate
	" these values and pass them to `fzf`; instead, we'll massage and
	" manipulate the fzf `source` command and then its output via the
	" `reducer` option.

	" Exclude some auto-edited files present in v:oldfiles
	" To deal with vim's odd regex syntax, we dynamically escape regex chars,
	" then we escape yet again to pass the expression as a string to `filter()`
	let regex = "/\.git|\.tmp|-->|:/"
	let oldfiles = filter(v:oldfiles, escape(escape('v:val !~ "' . l:regex . '"', '(|)'), '\'))

	let nvim_cwd = getcwd()
	let file_cwd = expand("%:h")

	" ripgrep does not (at least yet) filter out textually duplicate results
	let regex = "^(" . l:nvim_cwd . "|" . l:file_cwd . ")/"
	let oldfiles = filter(oldfiles, escape(escape('v:val !~ "' . l:regex . '"', '(|)'), '\'))

	let sources = l:oldfiles + ["./"]
	if (l:file_cwd !~ "^" . l:nvim_cwd)
		let sources += [l:file_cwd]
	end

	let sources = map(l:sources, "shellescape(v:val)")
	let sources = join(l:sources, " ")

	" `rg --files` does not exclude binary files, whereas `rg . -l` does
	" BUT `rg .` is way too slow under WSLv2 accessing Windows paths :'(
	let l:binary_excludes = " -g '!*.{exe,dll,so,o,pyc,png,jpg,jpeg,webp,gif,pdf,zip,gz,tar,7z,node,onnx,avif,doc,docx,odt,ods,xlsx,a,dylib}' "

	let cmd = "rg --files --no-config --no-messages --line-buffered --color always "
				\ . g:default_rg_ignore
				\ . l:binary_excludes
				\ . " " . l:sources

	" DEBUG BLOCK START
	" let l:debug_cmd = substitute(l:cmd, '--color always', '', 'g')
	" let l:start_time = reltime()
	" let l:debug_output = system(l:debug_cmd)
	" let l:duration = reltimestr(reltime(l:start_time))
	" let l:log_entry = [
	" 	\ "========================================",
	" 	\ "TIME: " . strftime("%Y-%m-%d %H:%M:%S"),
	" 	\ "DURATION: " . l:duration . " seconds",
	" 	\ "COMMAND: " . l:cmd,
	" 	\ "RESULT COUNT: " . len(split(l:debug_output, "\n")),
	" 	\ "--- OUTPUT START ---",
	" 	\ l:debug_output,
	" 	\ "--- OUTPUT END ---",
	" 	\ ""
	" 	\ ]
	" call writefile(l:log_entry, "rg_debug.log", "")
	" DEBUG BLOCK END

	call fzf#run({'sink': 'e',
				\ 'source': l:cmd,
				\ 'options': '--ansi --filepath-word',
				\ 'down': '~40%'})
endfunction

