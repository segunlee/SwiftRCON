# Server Settings/Controls
chat.serverlog <true/false (default true)> - If true, chat will be logged to the console
echo "text" - Prints text to the server console
env.time - 
event.run - Sends an airdrop from a random direction to drop crates at (0,0,0)
find <name or . for all> - Search for a command
say "message" - Broadcasts a message in chat to ALL players
server.globalchat <true/false (default true?)> - If true, chat will be broadcasted to ALL players
server.hostname "server name" - Sets the server name
server.identity "identity" - Sets the server’s identity. This is used for the folder name of the server data
server.level "map name" : Sets the server’s map
server.maxplayers <number (default 500)> - Sets the maximum amount of players that can connect
server.port <number (default 28015)> - Sets the connection port of the server
server.save - Forces the server to save the map and player data
server.saveinterval <number (default 60)> - Sets the server’s auto-save interval
server.secure <true/false (default true)> - If true, EAC will kick banned or unregistered users upon joining
server.seed <number (default 123456)> - Sets the server’s map generation seed
server.stability true/false - If true, structure stability is enabled on the server
server.start - Uhh… starts your server? Wait, isn’t it already running?
server.stop "reason" - Stops yours server with a specified reason
server.tickrate <number (default 30)> - Uhh… sets the tick rate?
server.worldsize <number (default 4000)> - Sets the size of the map/world
server.writecfg - Writes and saves server configuration files
quit - Saves everything and stops the server

# Player Administration
ban "player name" "reason"
banid <steamid64> "player name" "reason"
banlist - List of banned users
banlistex - List of banned users with reasons and usernames
kick <steamid64> "player name" "reason" - Kicks player, with optional reason
kickall <invalid parameter, just put ""> "reason" - Kicks all players, with optional reason
listid <steamid64> - List of banned users by Steam ID
moderatorid <steamid64> "player name" "reason" - Sets player as a server moderator with auth level 1
ownerid <steamid64> "player name" "reason" - Sets player as a server admin with auth level 2
removemoderator <steamid64> - Removes player as moderator
removeowner <steamid64> - Removes player as owner
unban <steamid64> - Unbans player by Steam ID

# Player Controls
chat.say - Sends a message from the in-game F1 console to the in-game chat as player
craft.add -
craft.cancel -
craft.canceltask -
find <name or . for all> - Search for a command
inventory.endloot -
inventory.give -
inventory.giveid -
inventory.givebp -
kill - Suicide/kill yourself
quit - Saves everything and closes the game
respawn - Force yourself to respawn
respawn_sleepingbag - Force yourself to respawn in your sleeping bag
sleep -
spectate -
wakeup -

# Informational
players - Shows currently connected clients
status - Shows currently connected clients
users - Show user info for players on server

# Debugging/Development
colliders -
ddraw.arrow -
ddraw.line -
ddraw.sphere -
ddraw.text -
dev.culling -
dev.hidelayer -
dev.sampling -
dev.showlayer -
dev.togglelayer -
entity.debug_toggle -
entity.nudge -
gc.collect - Recollects unused memory and unloads unused assets

# objects -
perf - Print out performance data
physics_iterations <number (default: 7)> - The default solver iteration count permitted for any rigid bodies. Must be positive
physics_steps ?? - The amount of physics steps per second
queue - Shows the stability and surroundings queues
report - Generates a report of all spawned entities in the server's root directory
textures - Lists the loaded textures
Oxide Specific
oxide.load "file name" - Loads plugin with name given (do not include file extension, ex. lua, js, py)
oxide.reload "file name" - Reloads plugin with name given (do not include file extension, ex. lua, js, py)
oxide.unload "file name" - Unloads plugin with name given (do not include file extension, ex. lua, js, py)
version - Displays the Oxide version and the Rust network protocol version in the console
