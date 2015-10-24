" Stop tracking time for any task
function! time#End()
    let l:winview = winsaveview()
    try
        execute "normal! gg" . "/  TIME: [\\d\\{4\\}-\\d\\{2\\}-\\d\\{2\\} \\d\\{2\\}:\\d\\{2\\}\\]$" . "\<cr>"

        execute "normal A--" . time#CurrentTime()

        call time#TimeDifference()

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

"rReturn a formatted date string
function! time#CurrentTime()
    return "[" . strftime("%Y-%m-%d %H:%M") . "]"
endfunction


" Get the formatted time string from under the cursor
function! time#Time()
    let l:winview = winsaveview()
    let l:temp = @a

    normal "ayi[

    let l:date = @a

    let @a = l:temp
    call winrestview(l:winview)

    return l:date
endfunction

function! s:CalculateTime(start, end)
python << EOF
from datetime import datetime
import vim

def parseTime(date):
    return datetime.strptime(date, "%Y-%m-%d %H:%M")

start = vim.eval("a:start")
end = vim.eval("a:end")

seconds = (parseTime(end) - parseTime(start)).seconds

vim.command("let l:seconds = " + str(seconds))
EOF

    return l:seconds
endfunction

" Calculate the time difference from a date-row
function! time#TimeDifference()
    let l:winview = winsaveview()
    let l:temp = @a

    normal ^f[

    let l:start = time#Time()

    normal f[

    let l:end = time#Time()

    let l:seconds = s:CalculateTime(l:start, l:end)

    let l:totalMinutes = floor(l:seconds / 60.0)

    let l:hours = floor(l:totalMinutes / 60.0)
    let l:minutes = l:totalMinutes - (l:hours * 60)

    let l:formatted = printf("%02d:%02d", float2nr(l:hours), float2nr(l:minutes))

    execute "normal A: " . l:formatted

    let @a = l:temp
    call winrestview(l:winview)
endfunction
