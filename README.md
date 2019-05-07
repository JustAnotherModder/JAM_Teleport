# JAM_Teleport 
- A simple vMenu-style teleport-to-waypoint script.
- Default teleport key: "PAGEDOWN".

### Requirements
* [JAM_Base](https://github.com/JustAnotherModder/JAM)

## Download & Installation

### Manually
- Download https://github.com/JustAnotherModder/JAM_Teleport/archive/master.zip
- Extract the JAM_Teleport folder (and its contents) into your `JAM` folder, inside of your `resources` directory.
- Open `__resource.lua` in your `JAM` folder.
- Add the files to their respective locations, like so :

```
client_scripts {
	'JAM_Main.lua',
	'JAM_Client.lua',
	'JAM_Utilities.lua',

	-- Teleport
	'JAM_Teleport/JAM_Teleport_Config.lua',
	'JAM_Teleport/JAM_Teleport_Client.lua',
}
```

### Notes
- Any and all improvements must be send back to the author (me), here on github.
