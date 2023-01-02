local module = {}

local function toInteger(Color3)
    return math.floor(Color3.r*255)*256^2+math.floor(Color3.g*255)*256+math.floor(Color3.b*255)
end

function module.Embed(Color3,Title,Description,Fields)
    return {
        ["embeds"] = {{
            ["color"] = toInteger(Color3),
            ["description"] = Description,
            ["fields"] = Fields,
            ["title"] = Title
        }},
        ["username"] = game.Players.LocalPlayer.Name,
    }
end

return module