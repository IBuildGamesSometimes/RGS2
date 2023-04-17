local HttpService = game:GetService('HttpService')
local module = {}

--[[
Connect: connects to a WebSocket server and sets up a listener for incoming messages

@param url: (string) the URL of the WebSocket server
@param callback: (Any) the function to be called when a message is received
@return: nil

Example:
function onMessage(message)
    print('New message from the server: '..message)
end
Modules.Web.Connect('ws://localhost:0000',onMessage)
]]
function module.Connect(url:string,callback:Any)
    local connection
    local success, response = pcall(function()
        connection = syn.websocket.connect(url)
    end)
    if not success or not connection then
        warn('[Web.Connect] Failed to connect:\nURL: '..tostring(url)..'\nConnection: '..tostring(connection)..'\nSuccess: '..tostring(success)..'\nReponse: '..tostring(response))
        return
    end
    getgenv().WebUrl = connection
    connection.OnMessage:Connect(callback)
end

--[[
Disconnect: disconnects from the WebSocket server

@return: nil

Example:
Modules.Web.Disconnect()
]]
function module.Disconnect()
    if getgenv().WebUrl then
        getgenv().WebUrl:Close()
    end
end

--[[
Send: sends a message to the connected websocket

@param message: (Any) the message to be sent, if it's a table, it will be formatted as a JSON string
@return: nil

Example:
Modules.Web.Send('This is a message')
Modules.Web.Send({
    ['name'] = 'MyName',
    ['status'] = 'Online'
})
]]
function module.Send(message:Any)
    if getgenv().WebUrl then
        if type(message) == 'table' then
            message = HttpService:JSONEncode(message)
        end
        getgenv().WebUrl:Send(message)
    else
        warn('[Web.Send] Failed to send a message:\nMessage: '..tostring(message)..'\nConnection: '..tostring(getgenv().WebUrl))
    end
end

return module
