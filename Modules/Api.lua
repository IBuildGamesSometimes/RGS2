local HttpService = game:GetService('HttpService')
local module = {}

local executors = {
    ['Synapse'] = 'syn.request',
    ['Krnl'] = 'request'
}

--[[
SetDefaultUrl: sets a default URL to be used with the post function

@param url: (string) the URL to be set
@return: nil

Example:
Modules.Api.SetDefaultUrl('DiscordWebhookUrl')
]]
function module.SetDefaultUrl(url:string)
    getgenv().DefaultUrl = url
end

--[[
Post: sends a HTTP POST request to the specified URL, If no URL is provided, it will use the default URL set with `module.SetDefaultUrl`

@param data: (table) The data to send in the request body
@param url: (string) The URL to send the request to, If not provided, the default URL will be used
@return: (table) The status of the request

Example:
local response = Modules.Api.Post({key1 = 'value1',key2 = 'value2'},'https://httpbin.org/post')
]]
function module.Post(data:table,url:string)
    url = url or getgenv().DefaultUrl
    if not url then
        warn('[Api.Post] Failed to request, no URL was given')
        return
    end
    local httpRequest = {
        Url = url,
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = HttpService:JSONEncode(data)
    }
    local executor = string.split(identifyexecutor()," ")[1]
    if not executors[executor] then
        local executorList = ""
        for key,_ in pairs(executors) do
            if executorList ~= "" then
                executorList = executorList..", "
            end
            executorList = executorList..key
        end
        warn('[Api.Post] Your executor is not supported yet by this program:\nExecutor: '..executor..'\nSupported Executors: '..executorList)
        return
    end
    local func = loadstring("return "..executors[executor])
    local request = func()
    local response = request(httpRequest)
    if not response.Success then
        warn('[Api.Post] Failed to post:\nSuccess: '..tostring(response.Success)..'\nStatus Code: '..tostring(response.StatusCode)..'\nStatus Message: '..tostring(response.StatusMessage))
    end
    return response
end

--[[
Get: sends an HTTP GET request to the specified URL and returns the response

@param url: (string) the URL to send the request to
@return: (table) the response from the request

Example:
local response = Modules.Api.Get('https://httpbin.org/get')
]]
function module.Get(url:string)
    if not url then
        warn('[Api.Get] Failed to request, no URL was given')
        return
    end
    local success, response = pcall(game.HttpGet,game,url)
    if not success or not response then
        warn('[Api.Get] Failed to request URL:\nURL: '..tostring(url)..'\nSuccess: '..tostring(success)..'\nReponse: '..tostring(response))
    end
    return response
end

return module
