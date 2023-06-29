local Server = script.Parent
local Cmdr = require(Server:WaitForChild('Cmdr'))

-- Cmdr:RegisterDefaultCommands() -- This loads the default set of commands that Cmdr comes with. (Optional)
Cmdr:RegisterCommandsIn(Cmdr.CmdrCommands) 
