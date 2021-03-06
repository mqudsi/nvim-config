if has("wsl")
    let g:clipboard = {
    \ 'name': 'win32yank',
    \ 'copy': {
    \   '+': 'noerr win32yank.exe -i --crlf',
    \   '*': 'noerr win32yank.exe -i --crlf',
    \   },
    \ 'paste': {
    \   '+': 'noerr paste.exe --lf',
    \   '*': 'noerr paste.exe --lf',
    \   },
    \ 'cache_enabled': 0,
    \ }
elseif !empty($SSH_CONNECTION) && executable('lemonade')
    let ssh_client = substitute($SSH_CONNECTION, "\\s.*", "", "")
    " lemonade does not support IPv6
    if match(ssh_client, "::") != 0
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
          \   'cache_enabled': 0,
          \ }
    endif
endif
