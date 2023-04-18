local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({'Web'})

local function OnMessage(Message)
    ... -- A function to handle messages from the server
end

Modules.Web.Connect('Replace_With_WebSocket_Url',OnMessage) -- Connects to the WebSocket and fires 'OnMessage' on new messages

Modules.Web.Send('This is a testing message') -- Sends a message to the connected WebSocket