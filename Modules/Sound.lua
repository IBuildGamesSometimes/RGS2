local SoundService = game:GetService("SoundService")

local module = {}

local Sounds = {
    Click = 876939830, -- By @IcyTea
    Win = 576560247, -- By @Iighthour
    Start = 499381494, -- By @imdone13
    Error = 550209561 -- By @Fierzaa
    -- All sounds will be replaced with sounds by @Roblox in the future
}

function module.Play(Sound)
    if Sounds[Sound] then
        Sound = Sounds[Sound]
    end
    local Instance = Instance.new("Sound")
    Instance.SoundId = "rbxassetid://"..tostring(Sound)
    SoundService:PlayLocalSound(Instance)
    Instance:Destroy()
end

return module