local SoundService = game:GetService("SoundService")

local module = {}

local Sounds = {
    Click = 876939830, -- By @IcyTea
    Win = 576560247, -- By @Iighthour
    Start = 499381494, -- By @imdone13
    Error = 550209561 -- By @Fierzaa
    -- All sounds will be replaced with sounds by @Roblox in the future
}

local function SetupSounds()
    local Folder = Instance.new("Folder")
    Folder.Name = "Sounds"
    Folder.Parent = game
    for Sound,Id in pairs(Sounds) do
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://"..tostring(Id)
        Sound.Name = Name
        Sound.Parent = Folder
    end
end

function module.Play(Sound)
    if Sounds[Sound] then
        local Folder = game:FindFirstChild("Sounds")
        if Folder == nil then SetupSounds() end
        SoundService:PlayLocalSound(game.Sounds[Sound])
    else
        return warn("Sound.Play Error: Unknown Sound: "..tostring(Sound))
    end
end

return module