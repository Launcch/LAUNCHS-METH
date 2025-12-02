fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'QBCore Acid & LSD Drug Script with ox_target and Modern UI'
version '1.0.0'

-- Add the lation_ui compatibility layer to shared_scripts
shared_scripts {
    '@ox_lib/init.lua',
    '@lation_ui/init.lua',  -- Must come before your own shared scripts
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Only needed if you plan to save/load data to DB
    'server.lua'
}

lua54 'yes'
