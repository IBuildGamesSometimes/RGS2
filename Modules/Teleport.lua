local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local module = {}

local sortOrders = {
    ['Full'] = 'Des',
    ['Empty'] = 'Asc'
}

--[[
Request: sends an HTTP GET request to the specified URL and returns the response

@param url: (string) the URL to send the request to
@return: (table) the response from the request or nil

Example:
local response = Request('https://httpbin.org/get')

#This function is local and cannot be accessed from outside the module,
#There is accessible version of this function in module 'Api.Get'
]]
local function Request(url:string)
    if not url then
        warn('[Teleport.Request] Failed to request, no URL was given')
        return
    end
    local success, response = pcall(game.HttpGet,game,url)
    if not success or not response then
        warn('[Teleport.Request] Failed to request URL:\nURL: '..tostring(url)..'\nSuccess: '..tostring(success)..'\nReponse: '..tostring(response))
        return
    end
    return HttpService:JSONDecode(response)
end

--[[
Teleport: teleports the player to a specified server id

@param server: (string or table) The server id or the server information table to teleport to
@return: nil

Example:
Modules.Teleport.Teleport('Server_Id')

#This function is local and cannot be accessed from outside the module,
#If you need to use or modify this function, consider modifying the module or copying the relevant code into your own script
]]
local function Teleport(server:string?)
    if type(server) == 'table' and server.id then
        server = server.id
    end
    TeleportService:TeleportToPlaceInstance(game.PlaceId,server,game.Players.LocalPlayer)
end

--[[
GetRandomServer: retrieves a table with a random server data from the game's public server list

@param sortOrder: (string) The order to sort the server list by, options are 'Empty','Asc','Full','Desc', default 'Asc'
@return: (table) A table containing information about a random server, including 'id','maxPlayers','playing','playerTokens','players','fps','ping'

Example:
local serverData = Modules.Teleport.GetRandomServer('Empty')
print(serverData.id,serverData.playing,serverData.maxPlayers)
]]
function module.GetRandomServer(sortOrder:string)
    local sortOrder = sortOrders[sortOrder] or sortOrder or 'Asc'
    local serversList = Request('https://games.roblox.com/v1/games/'..game.PlaceId..'/servers/Public?sortOrder='..sortOrder..'&excludeFullGames=true&limit=100')
    return serversList.data[math.random(#serversList.data)]
end

--[[
TeleportNextServer: teleports the player to a random available server from the game's public server list

@param sortOrder: (string) The order to sort the server list by, options are 'Empty','Asc','Full','Desc', default 'Asc'
@return: nil

Example:
Modules.Teleport.TeleportRandomServer('Empty')
]]
function module.TeleportRandomServer(sortOrder:string)
    TeleportService.TeleportInitFailed:Connect(function(player,teleportResult,errorMessage,targetPlaceId,teleportOptions)
        warn('[Teleport.TeleportRandomServer] Teleport failed, retrying:\nTeleportResult: '..tostring(teleportResult)..'\nErrorMessage: '..tostring(errorMessage))
        Teleport(module.GetRandomServer(sortOrder))
    end)
    Teleport(module.GetRandomServer(sortOrder))
end

--[[
GetNextServer: retrieves the next server the player hasn't joined yet from the game's public server list

@return: (table) A table containing information about the next server, including 'id','maxPlayers','playing','playerTokens','players','fps','ping'

Example:
local serverData = Modules.Teleport.GetNextServer()
print(serverData.id,serverData.playing,serverData.maxPlayers)
]]
function module.GetNextServer()
    local cursor = readfile(game.PlaceId..'/cursor.json') or ''
    local joinedServers = HttpService:JSONDecode(readfile(game.PlaceId..'/joinedServers.json')) or {}
    while task.wait(1) do
        local serversList = Request('https://games.roblox.com/v1/games/'..game.PlaceId..'/servers/Public?sortOrder=Asc&excludeFullGames=true&limit=100&cursor='..cursor)
        for _,serverData in pairs(serversList.data) do
            if not table.find(joinedServers,serverData.id) then
                return serverData
            end
        end
        cursor = serversList.nextPageCursor or ''
        writefile(game.PlaceId..'/cursor.json',cursor)
    end
end

--[[
TeleportNextServer: teleports the player to the next available server he hasn't joined yet from the game's public server list

@return: nil

Example:
Modules.Teleport.TeleportNextServer()
]]
function module.TeleportNextServer()
    if not isfolder(game.PlaceId) then
        makefolder(game.PlaceId)
    end
    if not isfile(game.PlaceId..'/joinedServers.json') then
        writefile(game.PlaceId..'/joinedServers.json','{}')
    end
    if not isfile(game.PlaceId..'/cursor.json') then
        writefile(game.PlaceId..'/cursor.json','')
    end
    local joinedServers = HttpService:JSONDecode(readfile(game.PlaceId..'/joinedServers.json')) or {}
    table.insert(joinedServers,game.JobId)
    writefile(game.PlaceId..'/joinedServers.json',joinedServers)
    TeleportService.TeleportInitFailed:Connect(function(player,teleportResult,errorMessage,targetPlaceId,teleportOptions)
        warn('[Teleport.TeleportNextServer] Teleport failed, retrying:\nTeleportResult: '..tostring(teleportResult)..'\nErrorMessage: '..tostring(errorMessage))
        Teleport(module.GetNextServer())
    end)
    Teleport(module.GetNextServer())
end

return module
