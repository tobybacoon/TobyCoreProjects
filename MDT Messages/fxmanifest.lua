fx_version 'cerulean'
game 'gta5'

author 'Toby'
description 'MDT Messages'
version '1.0.0'

dependency 'core'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@core/imports/import.lua',
    '@utils/init.lua'
}

-- files {}
