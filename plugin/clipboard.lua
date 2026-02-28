local function get_clipboard_config()
    -- WSL Detection
    if vim.fn.has("wsl") == 1 then
        return {
            name = 'win32yank-wsl',
            copy = {
                ['+'] = 'win32yank.exe -i --crlf',
                ['*'] = 'win32yank.exe -i --crlf',
            },
            paste = {
                ['+'] = 'paste.exe --lf',
                ['*'] = 'paste.exe --lf',
            },
            cache_enabled = 0,
        }
    end

    -- SSH / Lemonade Detection
    local ssh_conn = vim.env.SSH_CONNECTION
    if ssh_conn and vim.fn.executable('lemonade') == 1 then
        -- Extract the remote IP from $SSH_CONNECTION
        -- $SSH_CONNECTION is "REMOTE_IP REMOTE_PORT LOCAL_IP LOCAL_PORT"
        local ssh_client = ssh_conn:gsub("%s.*", "")

        -- lemonade doesn't support IPv6
        if not ssh_client:find("::") then
            return {
                name = 'lemonade-ssh',
                copy = {
                    ['+'] = { 'lemonade', '--host', ssh_client, 'copy' },
                    ['*'] = { 'lemonade', '--host', ssh_client, 'copy' },
                },
                paste = {
                    -- Pipe through sed to strip carriage returns
                    ['+'] = { 'sh', '-c', 'lemonade --host ' .. ssh_client .. ' paste | sed "s/\\r$//"' },
                    ['*'] = { 'sh', '-c', 'lemonade --host ' .. ssh_client .. ' paste | sed "s/\\r$//"' },
                },
                cache_enabled = 0,
            }
        end
    end

    return nil
end

local config = get_clipboard_config()
if config then
    vim.g.clipboard = config
end

-- trim trailing \r upon bracketed paste (when clipboard provider is bypassed)
vim.paste = (function(overridden)
  return function(lines, phase)
    for i, line in ipairs(lines) do
      -- Remove all carriage returns from each line string
      lines[i] = line:gsub('\r', '')
    end
    return overridden(lines, phase)
  end
end)(vim.paste)
