local HttpService = game:GetService("HttpService")

local module = {}

function module.Read(File)
    if isfile(game.PlaceId.."/"..File..".json") then
        return readfile(game.PlaceId.."/"..File..".json")
    else
        warn("File.Read Error: Unknown File "..File)
    end
end

function module.Write(File, Data)
    if isfolder(game.PlaceId) == false then
        makefolder(game.PlaceId)
    end
    writefile(game.PlaceId.."/"..File..".json",Data)
end

function module.Append(File, Data)
    if isfile(game.PlaceId.."/"..File..".json") then
        appendfile(game.PlaceId.."/"..File..".json",Data)
    else
        module.Write(File,Data)
    end
end

function module.Delete(File)
    if isfile(game.PlaceId.."/"..File..".json") then
        delfile(game.PlaceId.."/"..File..".json")
    else
        warn("File.Delete Error: Unknown File "..File)
    end
end

return module