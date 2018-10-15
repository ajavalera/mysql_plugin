if !has("python3")
    echo "mysql_plugin will not work without python3 support... Sorry..."
    finish
endif

" Only load the library once.
if exists('g:mysql_plugin')
    finish
endif

" Setting global commodity variables
let g:mysql_plugin_path = expand("<sfile>:p:h")

execute("source " . expand("<sfile>:p:h") . "/mysql_plugin_functions.vim")
execute("source " . expand("<sfile>:p:h") . "/mysql_plugin_maps.vim")

if !exists('g:mysql_hostfile')
    execute "Mysqlsethost default"
endif

let g:mysql_plugin = 1
