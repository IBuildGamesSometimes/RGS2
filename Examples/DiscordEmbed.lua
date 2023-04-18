local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({'Api','Discord'})

Modules.Api.SetDefaultUrl('Replace_With_Webhook_Url') -- Sets a Url as the Default-Url to be used from the Api.Post function

local embed = Modules.Discord.Embed(
    Color3.fromRGB(255,255,255),    -- Color : Color3 [Optional]
    'Title',                        -- Title : String [Optional]
    'Description',                  -- Description : String [Optional]
    {                               -- Fields : Table [Optional]
        {['name'] = 'FieldName1', ['value'] = 'FieldValue1'},
        {['name'] = 'FieldName2', ['value'] = 'FieldValue2'}
    }
)

Modules.Api.Post(embed) -- Sends the embed to your Discord webhook (using the Default-Url)
