local module = {}

function module.Start(Modules)
    for _,Module in pairs(Modules) do
        module[Module] = loadstring(game:HttpGet('https://raw.githubusercontent.com/IBuildGamesSometimes/RGS2/main/Modules/'..Module..'.lua'),Module)()
    end
end

return module