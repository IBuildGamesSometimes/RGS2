local HttpService = game:GetService("HttpService")

local module = {}

function module.SetUrl(Url)
    getgenv().PostUrl = Url
end

function module.Post(Content,Url)
    if Url == nil then
        if getgenv().PostUrl then
            Url = getgenv().PostUrl
        else
            return warn("No URL was set.")
        end
    end
    local HttpRequest = {
        Url = Url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(Content)
    }
    local Response = syn.request(HttpRequest)
    if Response.Success == false then
        warn("Api.Post Error: \n - "..tostring(Response.Success).."\n - "..tostring(Response.StatusCode).."\n - "..tostring(Response.StatusMessage))
    end
end

function module.Get(Url)
    if Url == nil then
        return warn("No URL was set.")
    end
    local HttpRequest = {
        Url = Url,
        Method = "GET",
        Headers = {
            ["Content-Type"] = "application/json"
        }
    }
    local Response = syn.request(HttpRequest)
    if Response.Success == false then
        return("Api.Get Error: \n - "..tostring(Response.Success).."\n - "..tostring(Response.StatusCode).."\n - "..tostring(Response.StatusMessage))
    else
        return HttpService:JSONDecode(Response.Body)
    end
end

return module