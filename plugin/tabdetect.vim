" Asynchronous indentation detector, powered by jobstart

autocmd BufReadPost * :call DetectTabExpand()

" let s:IndentationHelper = {
" \ 'stdout_buffered': v:true,
" \ 'stderr_buffered': v:true
" \}
"
" function! s:IndentationHelper.on_exit(job_id, data, event)
"     let stdout = join(get(self, 'stdout', []), '')
"     " :echoerr "job " . a:job_id  . " stdout: " . stdout
"     let count = str2nr(stdout)
"
"     let stderr = join(get(self, 'stderr', []), '')
"     " :echoerr "job " . a:job_id  . " stderr: " . stderr
"
"     " Store the result in the associated field
"     let s:IndentationCounts[a:job_id] = count
" endfunction

" This isn't buffer-local since it's cloned each time
let s:IndentationHelper = {
\ 'stdout': [],
\ 'count': 0,
\ }
function! s:IndentationHelper.on_stdout(job_id, data, event)
    let self.stdout += a:data
    let self.count = str2nr(join(self.stdout, ''))
endfunction
function! s:IndentationHelper.on_stderr(job_id, data, event)
    if len(a:data) > 1
        :echoerr(join(a:data, ''))
    end
endfunction

function! DetectTabExpand()
    " Don't bother running if we're in a read-only buffer to speed things up
    if &ro != 0
        return
    endif

    let file_path = shellescape(expand("%:p"))
    if empty(file_path)
        return
    endif

    " Run both space and tab detections simultaneously
	let spaces = deepcopy(s:IndentationHelper)
    let spaces.name = "spaces"
    let job_spaces = jobstart("grep -c '^  ' " . file_path, spaces)
	let tabs = deepcopy(s:IndentationHelper)
    let tabs.name = "tabs"
    let job_tabs = jobstart("grep -c '^\t' " . file_path, tabs)

    " Also start background jobs to count transitions from 2-space indents
    " to 4-space indents (for sw=2) and from 4-space to 8-space (for sw=4)
	let double_spaces = deepcopy(s:IndentationHelper)
    let double_spaces.name = "double spaces"
    let job_2spaces = jobstart(['sh', '-c', "sed -z 's/\\n  [^ ][^\\n]*\\n    [^ ]/'\\036'/g' " . file_path . " | grep -c \\036"], double_spaces)
	let quadruple_spaces = deepcopy(s:IndentationHelper)
    let quadruple_spaces.name = "quadruple spaces"
    let job_4spaces = jobstart(['sh', '-c', "sed -z 's/\\n    [^ ][^\\n]*\\n        [^ ]/'\\036'/g' " . file_path . " | grep -c \\036"], quadruple_spaces)

    " Wait for both processes to complete in any order
    :call jobwait([job_spaces, job_tabs])

    " Evaluate results
    if spaces.count > tabs.count
        setlocal expandtab

        " Need to determine preferred shiftwidth (width of one expanded tab)
        :call jobwait([job_2spaces, job_4spaces])

        if double_spaces.count > quadruple_spaces.count
            setlocal shiftwidth=2
        elseif quadruple_spaces.count > double_spaces.count
            setlocal shiftwidth=4
        endif

    elseif tabs.count > spaces.count
        setlocal noexpandtab
        " make sure we don't get mixed soft and hard tabs
        :call execute(":set shiftwidth=" . &tabstop)
    endif

    let b:tabs_count = tabs.count
    let b:spaces_count = spaces.count
    let b:spaces2_count = double_spaces.count
    let b:spaces4_count = quadruple_spaces.count
endfunction

