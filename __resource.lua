fx_version 'cerulean'

games { 'gta5' }

author 'Himabitoo'

version '1.0.0'

client_scripts {

	'client/client.lua',
	'config.lua',
}

server_scripts {

	'server/server.lua',
	'@mysql-async/lib/MySQL.lua'

}