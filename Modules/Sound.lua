local SoundService = game:GetService('SoundService')
local module = {}

local Sounds = {
    Click = {Id = 876939830}, -- By @IcyTea
    Win = {Id = 576560247}, -- By @Iighthour
    Start = {Id = 499381494}, -- By @imdone13
    Error = {Id = 550209561}, -- By @Fierzaa
    -- All sounds will be replaced with sounds by @Roblox in the future
}

--[[
Play: Plays the given sound from the table 'Sounds' locally

@param sound: (string) - The name of the sound to play
@return: nil

Example:
Modules.Sound.Play('Start')
]]
function module.Play(sound:string)
    if not Sounds[sound] then
        warn('[Sound.Play] Invalid sound: '..tostring(sound))
        return
    end
    if not Sounds[sound].Instance then
        local instance = Instance.new('Sound')
        instance.SoundId = 'rbxassetid://'..Sounds[sound].Id
        Sounds[sound] = {Instance = instance}
    end
    SoundService:PlayLocalSound(Sounds[sound].Instance)
end

return module
