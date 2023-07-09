local M = {}
 
local json = require( "json" )
local lfs = require("lfs")
local defaultLocation = system.DocumentsDirectory
local directoryPath = system.pathForFile("", system.DocumentsDirectory)

function M.checkJsonFile()
        -- Check if the JSON file exists
    local fileExists = false
        for file in lfs.dir(directoryPath) do
            if file == "PlayerPrefs2.json" then
                fileExists = true
                break
            end
        end
    return fileExists
end

function M.saveTable( t, filename, location )
 
    local loc = location
    if not location then
        loc = defaultLocation
    end
 
    -- Path for the file to write
    local path = system.pathForFile( filename, loc )
 
    -- Open the file handle
    local file, errorString = io.open( path, "w" )
 
    if not file then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
        return false
    else
        -- Write encoded JSON data to file
        file:write( json.encode( t ) )
        -- Close the file handle
        io.close( file )
        return true
    end
end

function M.loadTable( filename, location )

    if (M.checkJsonFile() == true) then
        print("File exist")
    else
        data.save()
    end

    local loc = location
    if not location then
        loc = defaultLocation
    end
 
    -- Path for the file to read
    local path = system.pathForFile( filename, loc )
 
    -- Open the file handle
    local file, errorString = io.open( path, "r" )
 
    if not file then
        -- Error occurred; output the cause
        print( "File error: " .. errorString )
    else
        -- Read data from file
        local contents = file:read( "*a" )
        -- Decode JSON data into Lua table
        local t = json.decode( contents )
        -- Close the file handle
        io.close( file )
        -- Return table
        return t
    end
end

return M