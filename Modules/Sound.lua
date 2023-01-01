local SoundService = game:GetService("SoundService")

local module = {}

local Sounds = {
    Click = {"Id" = 876939830}, -- By @IcyTea
    Win = {"Id" = 576560247}, -- By @Iighthour
    Start = {"Id" = 499381494}, -- By @imdone13
    Error = {"Id" = 550209561}, -- By @Fierzaa
    -- All sounds will be replaced with sounds by @Roblox in the future
}

function module.Play(Sound)
    if Sounds[Sound] == nil or Sounds[Sound].Instance == nil then
        local Instance = Instance.new("Sound")
        Instance.SoundId = "rbxassetid://"..tostring(Sound)
        Sounds[Sound] = {"Id" = Sound, "Instance" = Instance}
    end
    SoundService:PlayLocalSound(Sounds[Sound].Instance)
end

return module