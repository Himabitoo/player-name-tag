fx_version 'cerulean'

games { 'gta5' }

author 'Project-Nazu'

version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/client.lua',
	'config.lua',
}

server_scripts {
	'server/server.lua',
	-- '@mysql-async/lib/MySQL.lua'
}