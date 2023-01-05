local HttpService = game:GetService("HttpService")

local module = {}

function module.Read(File)
    if isfile(game.GameId.."/"..File..".json") then
        return readfile(game.GameId.."/"..File..".json")
    else
        warn("File.Read Error: Unknown File "..File)
    end
end

function module.Write(File, Data)
    if isfolder(game.GameId) == false then
        makefolder(game.GameId)
    end
    writefile(game.GameId.."/"..File..".json",Data)
end

function module.Append(File, Data)
    if isfile(game.GameId.."/"..File..".json") then
        appendfile(game.GameId.."/"..File..".json",Data)
    else
        module.Write(File,Data)
    end
end

function module.Delete(File)
    if isfile(game.GameId.."/"..File..".json") then
        delfile(game.GameId.."/"..File..".json")
    else
        warn("File.Delete Error: Unknown File "..File)
    end
end

return module