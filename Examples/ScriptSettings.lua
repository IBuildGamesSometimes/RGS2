local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({'File'})

local function ApplySettings(settings)
    -- A function to apply the settings to your script
    for setting,value in pairs(settings) do
        ...
    end
end

local savedSettings = Modules.File.Read('settings') -- Return the data of the file 'settings'

if savedSettings then
    -- Apply the Saved Settings
    ApplySettings(savedSettings)
else
    -- Apply the Default Settings
    local defaultSettings = {
        ['Setting1'] = true,
        ['Setting2'] = 100,
        ['Setting3'] = 'Locked',
        ...
    }
    Modules.File.Write('settings',defaultSettings) -- Save the new settings
    ApplySettings(defaultSettings)
end
