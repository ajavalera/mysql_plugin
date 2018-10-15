" Loads/Sources a host data configuration file.  This
" sets the global variables needed to configure the 
" mysql connection.
com! -nargs=1 Mysqlsethost call Mysql_SetHost(<f-args>)
fun! Mysql_SetHost(hostname)
    let hostfile = g:mysql_plugin_path . "/../host_files/" . a:hostname . ".vim"

    if !filereadable(hostfile)
        echo "The configuration file for " . a:hostname . " does not exist."
        echo "Please run "
        echo "Mysqlcreatehost " . a:hostname ." <host> <username> <password>"
        echo "In command mode to create the connection"
        return 1
    endif

    execute "source " . hostfile 
    echo "Loaded host " . a:hostname
endfun

" Executes the SQL script.
" This takes the currently being edited and saved file content
" and has mysql run it.
" Opens result in a new window/buffer.
com! -complete=shellcmd -nargs=+ Mysqlexec call Mysql_Exec(<f-args>)
fun! Mysql_Exec(position)
    if !exists("g:mysql_host")
        echo "There is no connection loaded,"
        echo "Please run:"
        echo "Mysqlsethost <connection>"
        echo "in command line mode to load a connection and proceed."
        return 1
    endif

    echo "Executing ". expand("%") . " file...(please wait)"

    if 'left' == a:position
        30vnew
    else
         new
    endif

    setlocal bufhidden=wipe nobuflisted noswapfile nowrap
    execute '$read ! mysql -t -h' . g:mysql_host . ' -u' . g:mysql_user . ' -p' . g:mysql_password . ' < ./#'
    1
endfun

" Creates a new host connection configuration file and loads it.
" connection => the name of the saved connection.
" host => IP of the mysql server to connect to.
" user => the host's valid username.
" password => the host's valid password.
com! -nargs=+ Mysqlcreatehost call Mysql_CreateHost(<f-args>)
fun! Mysql_CreateHost(connection, host, user, password)
    let hostfile = g:mysql_plugin_path . "/../host_files/" . a:connection . ".vim"
    execute "e " . hostfile
    execute "normal ggVGdd"
    execute 'read ' . g:mysql_plugin_path . "/../host_files/template.vim"
    execute 'normal ggdd'
    execute '%s/{host}/' . a:host
    execute '%s/{user}/' . a:user
    execute '%s/{password}/' . a:password
    execute '%s/{hostfile}/' . a:connection
    execute 'w'
    execute 'bd!'
    execute 'source ' . hostfile
    echo 'Created ' . a:connection . ' and loaded.'
endfun

com! -nargs=0 MysqlConvertToCsv call Mysql_ConvertToCsv()
fun! Mysql_ConvertToCsv()
    execute "normal gg"
    execute "/mysql"
    execute "normal dd"
    execute "normal gg"
    execute "/^\+--"
    execute "normal dd"
    execute "normal ndd"
    execute "normal ndd"
    execute "normal gg"
    execute "%s/|/,/g"
    execute "%s/ //g"
    execute "%normal 0x"
    execute "normal gg"
    1
endfun
