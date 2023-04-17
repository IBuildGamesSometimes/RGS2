local HttpService = game:GetService('HttpService')
local module = {}

--[[
Request: sends an HTTP GET request to the specified URL and returns the response

@param url: (string) the URL to send the request to
@return: (table) the response from the request

Example:
local response = Request('https://httpbin.org/get')

#This function is local and cannot be accessed from outside the module,
#There is accessible version of this function in module 'Api.Get'
]]
local function Request(url:string)
    if not url then
        warn('[Main.Request] Failed to request, no URL was given')
        return
    end
    local success, response = pcall(game.HttpGet,game,url)
    if not success or not response then
        warn('[Main.Request] Failed to request URL:\nURL: '..tostring(url)..'\nSuccess: '..tostring(success)..'\nReponse: '..tostring(response))
    end
    return response
end

--[[
Start: downloads and loads Lua modules from the RGS2 GitHub repository

@param modules: (table, optional) a table of module file names to import. If no table is given, all available modules will be imported
@return: nil

Example:
-- Import all available modules
Modules.Start()
-- Import specific modules
Modules.Start({'Sound','Api','File'})
]]
function module.Start(modules:table)
    if modules then
        for _,file in pairs(modules) do
            local script = Request('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Modules/'..file..'.lua')
            module[string.split(file,'.lua')[1]] = loadstring(script,file)()
        end
    else
        local fileListJson = Request('https://api.github.com/repos/IBuildGamesSometimes/RGS2/contents/Modules')
        local fileList = HttpService:JSONDecode(fileListJson)
        for _,file in pairs(fileList) do
            local script = Request(file.download_url)
            local fileName = string.split(file.name,'.lua')[1]
            module[fileName] = loadstring(script,fileName)()
        end
    end
end

return module
