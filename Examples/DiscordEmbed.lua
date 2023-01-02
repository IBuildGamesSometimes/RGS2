local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({"Api","Discord"})

Modules.Api.SetUrl("Replace_With_Url") -- Sets a Default-Url

local Embed = Modules.Discord.Embed(
    Color3.fromRGB(255,255,255),    -- Color : Color3
    "Title",                        -- Title : String
    "Description",                  -- Description : String
    {                               -- Fields : Table [Optional]
        {["name"] = "FieldName", ["value"] = "FieldValue"}
    }
)

Modules.Api.Post(Embed,"Replace_With_Url") -- Sends 'Embed' to the Url, or the Default-Url if no Url was given