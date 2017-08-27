if !empty(matchstr(system("uname -a"), "Microsoft"))
    let g:clipboard = {
	\ 'name': 'win32yank',
	\ 'copy': {
	\	'+': 'noerr win32yank.exe -i --crlf',
	\	'*': 'noerr win32yank.exe -i --crlf',
	\	},
	\ 'paste': {
	\	'+': 'noerr win32yank.exe -o --lf',
	\	'*': 'noerr win32yank.exe -o --lf',
	\	},
	\ 'cache_enabled': 1,
	\ }
endif

