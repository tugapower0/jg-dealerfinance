fx_version "cerulean"
game "gta5"
lua54 'yes'

title "LB Phone - App Template | React TS"
description "A template for creating apps for the LB Phone."
author "Breze & Loaf"

client_script "client.lua"
server_scripts { "server.lua", "@oxmysql/lib/MySQL.lua" }
shared_scripts { "config.lua", '@ox_lib/init.lua', "framework.lua"}

files {
    "ui/dist/**/*",
    "ui/icon.png"
}

-- ui_page "ui/dist/index.html"
ui_page "http://localhost:3000"
