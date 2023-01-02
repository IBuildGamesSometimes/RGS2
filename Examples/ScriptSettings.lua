local Modules = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Main.lua'))()
Modules.Start({"File"})

local function ApplySettings(Settings)
    ... -- A function to apply the settings to your script
end

local SavedSettings = Modules.File.Read("Settings") -- Return the data of the file "Settings"

if SavedSettings then
    -- Apply the Saved Settings
    ApplySettings(SavedSettings)
else
    -- Apply the Default Settings
    local DefaultSettings = {
        ["Setting1"] = true,
        ["Setting2"] = 100,
        ["Setting3"] = "Locked",
        ...
    }

    Modules.File.Write("Settings",DefaultSettings) -- Save the settings
    ApplySettings(DefaultSettings)
end