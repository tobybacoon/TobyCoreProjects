fx_version 'cerulean'
game 'gta5'

author 'Toby'
description 'Anim Replacements'
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

files {
    'data/*.meta',
    'stream/*.ycd'
}

data_file 'WEAPON_ANIMATIONS_FILE' 'data/weaponanimations.meta'

lua54 'yes'
