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

if !empty($SSH_CLIENT) && executable('lemonade')
	let ssh_client = systemlist('echo $SSH_CLIENT | egrep -o "^\S+"')[0]
	let g:clipboard = {
	  \   'name': 'lemonade',
	  \   'copy': {
	  \      '+': 'lemonade --host ' . ssh_client . ' copy',
	  \      '*': 'lemonade --host ' . ssh_client . ' copy',
	  \    },
	  \   'paste': {
	  \      '+': 'lemonade --host ' . ssh_client . ' paste',
	  \      '*': 'lemonade --host ' . ssh_client . ' paste',
	  \   },
	  \   'cache_enabled': 1,
	  \ }
endif
