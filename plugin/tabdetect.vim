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
    if &ro != 0 || @% == ""
        return
    endif

    let file_path = shellescape(expand("%:p"))
    if empty(file_path)
        return
    endif

    " Run both space and tab detections simultaneously
    let s:spaces = deepcopy(s:IndentationHelper)
    let s:spaces.name = "spaces"
    let s:spaces.on_exit = function('s:OnSpacesTabsExit')
    let s:job_spaces = jobstart("head -n 250 " . file_path . " | grep -c '^  '", s:spaces)
    let s:tabs = deepcopy(s:IndentationHelper)
    let s:tabs.name = "tabs"
    let s:tabs.on_exit = function('s:OnSpacesTabsExit')
    let s:job_tabs = jobstart("head -n 250 " . file_path . " | grep -c '^\t'", s:tabs)

    " Also start background jobs to count transitions from 2-space indents
    " to 4-space indents (for sw=2) and from 4-space to 8-space (for sw=4)
    let s:double_spaces = deepcopy(s:IndentationHelper)
    let s:double_spaces.name = "double spaces"
    " We need to count transitions from one indent level to another, not just
    " occurences of n-spaced indents.
    " `grep -z` is not support on macOS 10.10 (and maybe even later),
    " otherwise we could directly use `grep -c -z '\\n  [^ ][^\\n]*\\n    [^ ]'`
    " It also does not support `sed -z`, so we can't even do this:
    " `sed -z 's/\\n  [^ ][^\\n]*\\n    [^ ]/'\\036'/g' | grep -c \\036
    " Nor does its grep have any support for octal escapes, so we need to use
    " string interpolation or command substitution to get it working :'(
    let s:job_2spaces = jobstart(['sh', '-c', "head -n 250 " . file_path . " | tr '\\n' '\\036' | sed 's/'$'\\036''  [^ ][^'$'\\036'']*'$'\\036''    [^ ]/'$'\\037''/g' | tr '\\036' '\\n' | grep -c $'\\037'"], s:double_spaces)
    let s:quadruple_spaces = deepcopy(s:IndentationHelper)
    let s:quadruple_spaces.name = "quadruple spaces"
    let s:job_4spaces = jobstart(['sh', '-c', "head -n 250 " . file_path . " | tr '\\n' '\\036' | sed 's/'$'\\036''    [^ ][^'$'\\036'']*'$'\\036''        [^ ]/'$'\\037''/g' | tr '\\036' '\\n' | grep -c $'\\037'"], s:quadruple_spaces)
endfunction

function! s:OnSpacesTabsExit(job_id, data, event)
    " Wait for both processes to complete in any order. Whichever finishes
    " last will continue in this function.
    let wait = jobwait([s:job_spaces, s:job_tabs], 0)
    if (wait[0] == -1 || wait[1] == -1)
        return
    endif

    " Evaluate results
    if s:spaces.count > s:tabs.count
        setlocal expandtab

        " Need to determine preferred shiftwidth (width of one expanded tab)
        :call jobwait([s:job_2spaces, s:job_4spaces])

        if s:double_spaces.count > s:quadruple_spaces.count
            setlocal shiftwidth=2
        elseif s:quadruple_spaces.count > s:double_spaces.count
            setlocal shiftwidth=4
        endif

    elseif s:tabs.count > s:spaces.count
        setlocal noexpandtab
        " make sure we don't get mixed soft and hard tabs
        " :call execute(":set shiftwidth=" . &tabstop)
        set sw=0
    endif

    let b:tabs_count = s:tabs.count
    let b:spaces_count = s:spaces.count
    let b:spaces2_count = s:double_spaces.count
    let b:spaces4_count = s:quadruple_spaces.count
endfunction
