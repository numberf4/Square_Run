--
-- Import

local GGData = require("libs.GGData")

--
-- Create class, set variables

local utilities = {}
local db = GGData:new("db")
--
-- Init db

if not db.sounds then
    db:set("sounds", "On")
    db:save()
end

if not db.music then
    db:set("music", "On")
    db:save()
end

if not db.highscore then
    db:set("highscore", 0)
    db:save()
end

if not db.tmpscore then
    db:set("tmpscore", 0)
    db:save()
end



--
-- Sounds

function utilities:checkSounds()

    return db.sounds
end

function utilities:playSound(sound)

    if db.sounds == "On" then
        audio.stop(2)
        audio.play(sound, { channel=2 })
    end
end

function utilities:toggleSounds()

    if db.sounds == "On" then
        db:set("sounds", "Off")
    else
        db:set("sounds", "On")
    end

    db:save()
end

function utilities:checkMusic()

    return db.music
end

function utilities:playMusic(music)

    if db.music == "On" then
        audio.play(music, { loops=-1, channel=1})
        audio.setVolume(0.6, {channel=1})
    end
end

function utilities:toggleMusic()

    if db.music == "On" then
        db:set("music", "Off")
    else
        db:set("music", "On")
    end

    db:save()
end


--
-- Score

function utilities:getHighscore()

    return db.highscore
end

function utilities:setHighscore()

    if db.tmpscore > db.highscore then
        db:set("highscore", db.tmpscore)
        db:save()

        return true
    else
        return false
    end
end

function utilities:getTmpScore()

    return db.tmpscore
end

function utilities:setTmpScore(score)

    db:set("tmpscore", score)
    db:save()
end

--
-- Return

return utilities