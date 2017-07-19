call system("which matcher")
if v:shell_error == 0
	let g:path_to_matcher = systemlist("which matcher")[0]

	let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']

	let g:ctrlp_match_func = { 'match': 'GoodMatch' }

	function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

	  " Create a cache file if not yet exists
	  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
	  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
		call writefile(a:items, cachefile)
	  endif
	  if !filereadable(cachefile)
		return []
	  endif

	  " a:mmode is currently ignored. In the future, we should probably do
	  " something about that. the matcher behaves like "full-line".
	  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
	  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
		let cmd = cmd.'--no-dotfiles '
	  endif
	  let cmd = cmd.a:str

	  return split(system(cmd), "\n")

	endfunction
endif
