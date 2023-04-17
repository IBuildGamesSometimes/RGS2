local module = {}

--[[
toInteger: converts a Color3 value to an integer

@param color3: (Color3) the color to convert
@return: (number) the integer value of the color

Example:
local integer = toInteger(Color3.new(255,255,255))

#This function is local and cannot be accessed from outside the module,
#If you need to use or modify this function, consider modifying the module or copying the relevant code into your own script
]]
local function toInteger(color3:Color3)
    return math.floor(color3.r*255)*256^2 + math.floor(color3.g*255)*256 + math.floor(color3.b*255)
end

--[[
Embed: returns a table formatted as a Discord Embed that can be sent to a Discord Webhook

@param color3: (Color3, optional) the color of the embed
@param title: (string, optional) the title of the embed
@param description: (string, optional) the description of the embed
@param fields: (table, optional) the fields of the embed
@return: (table) the table representing the embed

Example:
local embed = Modules.Discord.Embed(
    Color3.fromRGB(125,255,125),
    'Embed Title',
    'Embed Description',
    {
        {['name'] = 'FieldName1',['value'] = 'FieldValue1'},
        {['name'] = 'FieldName2',['value'] = 'FieldValue2'}
    }
)
]]
function module.Embed(color3:Color3,title:string,description:string,fields:table)
    return {
        ['embeds'] = {{
            ['color'] = toInteger(color3 or Color3.fromRGB(255,255,255)),
            ['title'] = title or 'Roblox',
            ['description'] = description or '------',
            ['fields'] = fields
        }},
        ['username'] = game.Players.LocalPlayer.Name
    }
end

return module
