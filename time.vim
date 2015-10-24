" Return a formatted date string
function! CurrentTime()
    return "[" . strftime("%Y-%m-%d %H:%M") . "]"
endfunction

" Start a new timer for current task
function! Start()
    let l:winview = winsaveview()

    execute ":normal o  TIME: " . CurrentTime()

    call winrestview(l:winview)
endfunction

" Get the formatted time string from under the cursor
function! Date()
    let l:winview = winsaveview()
    let l:temp = @a

    normal "ayi[

    let l:date = @a

    let @a = l:temp
    call winrestview(l:winview)

    return l:date
endfunction

" Calculate the time difference from a date-row
function! DateDifference()
    let l:winvivew = winsaveview()
    let l:temp = @a

    let @a = l:temp
    call winrestview(l:winview)
endfunction

" Stop tracking time for any task
function! End()
    let l:winview = winsaveview()

    try
        execute "normal! gg" . "/  TIME: [\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\} \\d\\{2\\}:\\d\\{2\\}\\]$" . "\<cr>"

        execute "normal A--" . CurrentTime()

    catch /Pattern not found/
        echom "No running timer"
    endtry

    call winrestview(l:winview)
endfunction
