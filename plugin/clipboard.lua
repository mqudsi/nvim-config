if vim.fn.has("wsl") == 1 then
    vim.g.clipboard = {
        name = 'win32yank',
        copy = {
            ['+'] = 'win32yank.exe -i',
            ['*'] = 'win32yank.exe -i',
        },
        paste = {
            ['+'] = 'paste.exe --lf',
            ['*'] = 'paste.exe --lf',
        },
        cache_enabled = 0,
    }
elseif vim.env.SSH_CONNECTION ~= nil and vim.fn.executable('lemonade') == 1 then
    -- Extract the IP/Host from the SSH_CONNECTION env var
    local ssh_client = vim.env.SSH_CONNECTION:gsub("%s.*", "")

    -- lemonade does not support IPv6 (check if string contains "::")
    if not ssh_client:find("::") then
        vim.g.clipboard = {
            name = 'lemonade',
            copy = {
                ['+'] = 'lemonade --host ' .. ssh_client .. ' copy',
                ['*'] = 'lemonade --host ' .. ssh_client .. ' copy',
            },
            paste = {
                ['+'] = 'lemonade --host ' .. ssh_client .. ' paste',
                ['*'] = 'lemonade --host ' .. ssh_client .. ' paste',
            },
            cache_enabled = 0,
        }
    end
end

-- Regardless of clipboard provider, trim trailing \r
-- (mainly to fix lemonade)
vim.paste = (function(overridden)
  return function(lines, phase)
    for i, line in ipairs(lines) do
      -- Remove all carriage returns from each line string
      lines[i] = line:gsub('\r', '')
    end
    return overridden(lines, phase)
  end
end)(vim.paste)
