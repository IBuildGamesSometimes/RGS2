local HttpService = game:GetService('HttpService')
local module = {}

--[[
Read: reads a file in JSON format and returns its contents

@param file: (string) the name of the file to read (without the .json extension)
@return: (table) the contents of the file in a Lua table format, or nil if the file doesn't exist

Example:
local data = Modules.File.Read('settings')
if data then
    print('Settings file found!')
    print(data)
else
    print('Settings file does not exist.')
end
]]
function module.Read(file:string)
    if isfile(game.PlaceId..'/'..file..'.json') then
        return HttpService:JSONDecode(readfile(game.PlaceId..'/'..file..'.json'))
    else
        warn('[File.Read] Unknown File '..file)
    end
end

--[[
Write: writes data to a file in JSON format

@param file: (string) the name of the file to write (without the .json extension)
@param data: (table) the data to write to the file
@return: nil

Example:
local data = {['AutoCollect'] = true, ['AutoSell'] = false}
Modules.File.Write('settings',data)
]]
function module.Write(file:string,data:table)
    if not isfolder(game.PlaceId) then
        makefolder(game.PlaceId)
    end
    writefile(game.PlaceId..'/'..file..'.json',HttpService:JSONEncode(data))
end

--[[
Append: Appends data to a JSON file. If the file does not exist, it will be created and the data will be written to it

@param file: (string) The name of the file to append data to (without the .json extension)
@param data: (table) The data to append to the file
@return: nil

Example:
local data = {['AutoPress'] = true}
Modules.File.Append('settings',data)
]]
function module.Append(file:string,data:table)
    if isfile(game.PlaceId..'/'..file..'.json') then
        local fileData = module.Read(file)
        if fileData then
            table.insert(fileData,data)
            module.Write(file,fileData)
        else
            warn('[File.Append] Failed to read file: '..file)
        end
    else
        module.Write(file,data)
    end
end

--[[
Delete: deletes a file

@param file: (string) the name of the file to delete (without the .json extension)
@return: nil

Example:
Modules.File.Delete('settings')
]]
function module.Delete(file:string)
    if isfile(game.PlaceId..'/'..file..'.json') then
        delfile(game.PlaceId..'/'..file..'.json')
    else
        warn('[File.Delete] Unknown File '..file)
    end
end

return module
