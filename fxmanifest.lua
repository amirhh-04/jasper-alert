fx_version 'bodacious'
game 'gta5'

lua54 'yes'

author 'Jasper Development'
discord 'https://discord.gg/uRWCfxtgpH'
description 'Jasper script is an attractive and purposeful script designed for police roleplay that is responsible for transmitting alerts to the intended police officers. (+ sound alert)'
version '1.0.0'

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/js/*.js',
    'ui/css/*.css',
    'ui/audio/*.mp3',
    'ui/img/*.png'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

shared_script {
    'config.lua',
}
