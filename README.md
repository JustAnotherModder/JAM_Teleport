# JAM_Teleport 
A simple vMenu-style teleport-to-waypoint script.

### Requirements
* [JAM_Base](https://github.com/JustAnotherModder/JAM_Base)

## Download & Installation

### Manually
- Download https://github.com/JustAnotherModder/JAM_Teleport/archive/master.zip
- Put it in the `JAM` folder, inside of your `resources` directory.
- Open `__resource.lua` in your `JAM` folder.
- Add the files to their respective locations, like so :

```
client_scripts {
	'JAM_Main.lua',
	'JAM_Utilities.lua',

	'JAM_Commands.lua',

	-- Teleport
	'JAM_Teleport/JAM_Teleport_Config.lua',
	'JAM_Teleport/JAM_Teleport_Client.lua',
}

server_scripts {	
	'JAM_Main.lua',
	'JAM_Utilities.lua',

	'@mysql-async/lib/MySQL.lua',

	-- Teleport
	'JAM_Teleport/JAM_Teleport_Config.lua',
	'JAM_Teleport/JAM_Teleport_Server.lua',
}
```

## Installation
- Add this in your server.cfg :

```
start JAM_Garage
```
