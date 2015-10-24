" Stop tracking time for any task
function! time#End()
    let l:winview = winsaveview()

    try
        execute "normal! gg" . "/  TIME: [\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\} \\d\\{2\\}:\\d\\{2\\}\\]$" . "\<cr>"

        execute "normal A--" . time#CurrentTime()

    catch /Pattern not found/
        echom "No running timer"
    endtry

    call winrestview(l:winview)
endfunction

" Start a new timer for current task
function! time#Start()
    " Close any running task
    call time#End()

    let l:winview = winsaveview()

    execute ":normal o  TIME: " . time#CurrentTime()

    call winrestview(l:winview)
endfunction

" Stop tracking time for any task
function! time#End()
    let l:winview = winsaveview()

    try
        execute "normal! gg" . "/  TIME: [\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\} \\d\\{2\\}:\\d\\{2\\}\\]$" . "\<cr>"

        execute "normal A--" . time#CurrentTime()

    catch /Pattern not found/
        echom "No running timer"
    endtry

    call winrestview(l:winview)
endfunction

" Return a formatted date string
function! time#CurrentTime()
    return "[" . strftime("%Y-%m-%d %H:%M") . "]"
endfunction


" Get the formatted time string from under the cursor
function! time#Date()
    let l:winview = winsaveview()
    let l:temp = @a

    normal "ayi[

    let l:date = @a

    let @a = l:temp
    call winrestview(l:winview)

    return l:date
endfunction

" Calculate the time difference from a date-row
function! time#DateDifference()
    let l:winvivew = winsaveview()
    let l:temp = @a

    let @a = l:temp
    call winrestview(l:winview)
endfunction
