local module = {}

function module.Connect(Url,Function)
    local Connection
    local Success,Response = pcall(function()
        Connection = syn.websocket.connect(Url)
    end)
    if Success then
        getgenv().WebUrl = Connection
        Connection.OnMessage:Connect(Function)
    else
        warn("Web.Connect Error: Connecting Failed: "..Response)
    end
end

function module.Disconnect()
    if getgenv().WebUrl then
        getgenv().WebUrl:Close()
    end
end

function module.Send(Data)
    if getgenv().WebUrl then
        getgenv().WebUrl:Send(Data)
    else
        warn("Web.Send Error: No connection was made")
    end
end

return module