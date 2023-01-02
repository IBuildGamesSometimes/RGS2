local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({"Web"})

local function OnMessage(Message)
    ... -- A function to handle messages from the server
end

Modules.Web.Connect("Replace_With_Url",OnMessage) -- Connects to the WebSocket and firing 'OnMessage' on new message

Modules.Web.Send("This is a testing message") -- Sends a message to the connected WebSocket