local module = {}

local Modules = {
	"Console", "Api", "Files", "Settings", "Sound", "Functions", "System"
}

function module.Start()
    for _,Module in pairs(Modules) do
        module[Module] = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Modules/'..Module..'.lua'),Module)()
    end
end

return module