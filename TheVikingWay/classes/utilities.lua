-- Import

local GGData = require("libs.GGData")

-- Variables
local utilities = {}
local db = GGData:new("db")

-- Init db

if not db.sounds then
    db:set("sounds", "On")
    db:save()
end

-- Sounds

function utilities:playSound(sound)

    if db.sounds == "On" then
        audio.stop(2)
        audio.play(sound, {channel=2})
    end
end

-- return
return utilities