local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({"Api","Discord"})

local Embed = Modules.Discord.Embed(
    Color3.fromRGB(255,255,255),
    "Title",
    "Description",
    {
        {["name"] = "FieldName", ["value"] = "FieldValue"}
    }
)

Modules.Api.SetUrl("Discord_Webhook_Url")
Modules.Api.Post(Embed)