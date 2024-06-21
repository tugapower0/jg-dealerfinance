fx_version "cerulean"
game "gta5"
lua54 'yes'

title "JG Finance"
description "App to manage your financed vehicles."
author "Wyknx & Lindholm"

client_script "client.lua"
server_scripts { "@oxmysql/lib/MySQL.lua", "server.lua",  }
shared_scripts { "@jg-dealerships/config.lua", '@ox_lib/init.lua', "framework.lua", }

files {
    "ui/dist/**/*",
    "ui/icon.png"
}

dependencies {
    "jg-dealerships"
}

ui_page "ui/dist/index.html"
-- ui_page "http://localhost:3000"
