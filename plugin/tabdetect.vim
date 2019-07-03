" Asynchronous indentation detector, powered by jobstart

autocmd BufReadPost * :call DetectTabExpand()

let s:IndentationCounts = {}
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

let s:IndentationHelper = {
\ 'stdout': [],
\ }
function! s:IndentationHelper.on_stdout(job_id, data, event)
    let self.stdout += a:data
    let count = str2nr(join(self.stdout, ''))

    " Store the result in the associated field
    let s:IndentationCounts[a:job_id] = count
endfunction

function! DetectTabExpand()
    let file_path = shellescape(expand("%:p"))
    if empty(file_path)
        return
    endif

    " Run both space and tab detections simultaneously
    let job_spaces = jobstart("grep -c '^  ' " . file_path, deepcopy(s:IndentationHelper))
    let job_tabs = jobstart("grep -c '^\t' " . file_path, deepcopy(s:IndentationHelper))

    " Also start background jobs to count transitions from 2-space indents
    " to 4-space indents (for sw=2) and from 4-space to 8-space (for sw=4)
    let job_2spaces = jobstart(['sh', '-c', "sed -z 's/\\n  [^ ][^\\n]*\\n    [^ ]/'\\036'/g' " . file_path . " | grep -c \\036"], deepcopy(s:IndentationHelper))
    let job_4spaces = jobstart(['sh', '-c', "sed -z 's/\\n    [^ ][^\\n]*\\n        [^ ]/'\\036'/g' " . file_path . " | grep -c \\036"], deepcopy(s:IndentationHelper))

    " Wait for both processes to complete in any order
    :call jobwait([job_spaces, job_tabs])

    " Evaluate results
    let spaces = s:IndentationCounts[job_spaces]
    let tabs = s:IndentationCounts[job_tabs]

    if spaces > tabs
        set expandtab

        " Need to determine preferred shiftwidth (width of one expanded tab)
        :call jobwait([job_2spaces, job_4spaces])

        let double_spaces = s:IndentationCounts[job_2spaces]
        let quad_spaces = s:IndentationCounts[job_4spaces]

        if double_spaces > quad_spaces
            set shiftwidth=2
        elseif quad_spaces > double_spaces
            set shiftwidth=4
        endif

    elseif tabs > spaces
        set noexpandtab
    endif
endfunction

