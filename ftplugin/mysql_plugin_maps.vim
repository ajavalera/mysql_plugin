" Abbreviations for SQL files.

iabbrev select SELECT
iabbrev where WHERE
iabbrev on ON
iabbrev inner INNER 
iabbrev outer OUTER
iabbrev join JOIN
iabbrev as AS
iabbrev order ORDER BY
iabbrev limit LIMIT
iabbrev count COUNT(
iabbrev from FROM
iabbrev desc DESC
iabbrev asc ASC
iabbrev now NOW(
iabbrev create CREATE
iabbrev by BY
iabbrev column COLUMN
iabbrev use USE
iabbrev show SHOW
iabbrev table TABLE
iabbrev column COLUMN

" Change buffers/windows focus.
noremap <leader>xl :Mysqlexec left<cr><c-w>l
noremap <leader>xx :Mysqlexec bot<cr><c-w>k

" Execute from insert mode and go back to initial buffer.
inoremap <leader>xx <esc>:w<cr>:Mysqlexec bot<cr><c-w>k 
