local loadsave = require( "classes.loadsave" )

-- define the data
data = {
    currentShipIndex = 0,
    currentImprovingPage = 0,
    shipWithGunsAv = false,
    shipDamageX2Av = false,
    shipDamageX3Av = false,
    gold = 0,
    distance = 0,
    music = true,
    sound = true,
    ratioX = display.contentWidth/1200,
    ratioY = display.contentHeight/1600,
    heroTargetX = 0,
    heroTargetY = 0,
    mainHeroHealth = 3,
    speed = 0,
    enemyHealth = 3,
    mainHeroAttackDamage = 0,
    mainHeroIsProtected = false,
    buttonShieldOnCooldown = false,
    framesToResetBtnShield = 120,
    shieldAnimIndex = 1,
    framesShieldAnim = 10,
    framesForBlow = 0,
    accelSpeed = 0
}

playerPrefs = {
    Gold = 0,
    CurrentShipIndex = 0,
    ShipWithGunsAvailable,
    ShipDamageX2Available,
    ShipDamageX3Available,
    sound,
    music
}

--sounds
local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

-- functions
-- gold

function data.save()
    playerPrefs.Gold = data.gold
    playerPrefs.CurrentShipIndex = data.currentShipIndex
    playerPrefs.ShipWithGunsAvailable = data.shipWithGunsAv
    playerPrefs.ShipDamageX2Available = data.shipDamageX2Av
    playerPrefs.ShipDamageX3Available = data.shipDamageX3Av
    playerPrefs.sound = data.sound
    playerPrefs.music = data.music
    loadsave.saveTable( playerPrefs, "PlayerPrefs2.json" )
end

function data.load()
    local loadedSettings = loadsave.loadTable( "PlayerPrefs2.json" )
    data.currentShipIndex = loadedSettings.CurrentShipIndex
    data.gold = loadedSettings.Gold
    data.shipWithGunsAv = loadedSettings.ShipWithGunsAvailable
    data.shipDamageX2Av = loadedSettings.ShipDamageX2Available
    data.shipDamageX3Av = loadedSettings.ShipDamageX3Available
    data.sound = loadedSettings.sound
    data.music = loadedSettings.music
    -- if (data.sound == true) then data.setSound(true)
    -- else data.setSound(false)
    -- end
    -- if (data.music == true) then data.setMusic(true)
    -- else data.setMusic(false)
    -- end
    print("Loaded gold from PlayerPrefs: ")
    print(data.gold)
    print(data.shipWithGunsAv)
    print(data.shipDamageX2Av)
    print(data.shipDamageX3Av)
end

-- other
function data.getSpeed()
    return data.getRatioX() * 2
end

function data.getCurrentShipIndex()
    return data.currentShipIndex
end

function data.setCurrentShipIndex(currentShipIndex)
    data.currentShipIndex = currentShipIndex
    if (currentShipIndex == 0) then data.mainHeroAttackDamage = 0
    elseif (currentShipIndex == 1) then data.mainHeroAttackDamage = 1
    elseif (currentShipIndex == 2) then data.mainHeroAttackDamage = 2
    elseif (currentShipIndex == 3) then data.mainHeroAttackDamage = 3
    end
    data.save()
end

function data.getCurrentImprovingPage()
    return data.currentImprovingPage
end

function data.setCurrentImprovingPage(currentImprovingPage)
    data.currentImprovingPage = currentImprovingPage
end

function data.getGold()
    return data.gold
end

function data.setGold(gold)
    data.gold = gold
end

function data.getDistance()
    return data.distance
end

function data.setDistance(distance)
    data.distance = distance
end

function data.getMusic()
    return data.music
end

function data.setMusic(value)
    data.music = value
    if (value == true) then
        audio.setVolume(0.6, { channel = 1 }) 
    else
        audio.setVolume(0, { channel = 1 }) 
    end
end

function data.getSound()
    return data.sound
end

function data.setSound(value)
    data.sound = value
    if (value == true) then
        audio.setVolume(0.6, { channel = 2 }) 
        audio.setVolume(0.6, { channel = 3 }) 
        audio.setVolume(0.6, { channel = 4 }) 
        audio.setVolume(0.6, { channel = 5 }) 
        audio.setVolume(0.6, { channel = 6 }) 
    else
        audio.setVolume(0, { channel = 2 }) 
        audio.setVolume(0, { channel = 3 }) 
        audio.setVolume(0, { channel = 4 }) 
        audio.setVolume(0, { channel = 5 }) 
        audio.setVolume(0, { channel = 6 }) 
    end
end

function data.getRatioX()
    return data.ratioX
end


function data.getRatioY()
    return data.ratioY
end

function data.getHeroTargetX()
    return data.heroTargetX
end

function data.setHeroTargetX(value)
    data.heroTargetX = value
end

function data.getHeroTargetY()
    return data.heroTargetY
end

function data.setHeroTargetY(value)
    data.heroTargetY = value
end

function data.getHeroHealth()
    return data.mainHeroHealth
end

function data.setHeroHealth(value)
    data.mainHeroHealth = value
end
-- ship availability
function data.getShipWithGunsAv()
    return data.shipWithGunsAv
end

function data.setShipWithGunsAv(value)
    data.shipWithGunsAv = value
    data.save()
end

function data.getShipDamageX2Av()
    return data.shipDamageX2Av
end

function data.setShipDamageX2Av(value)
    data.shipDamageX2Av = value
    data.save()
end

function data.getShipDamageX3Av()
    return data.shipDamageX3Av
end

function data.setShipDamageX3Av(value)
    data.shipDamageX3Av = value
    data.save()
end

function data.getEnemyHealth()
    return data.enemyHealth
end

function data.setEnemyHealth(enemyHealth)
    data.enemyHealth = enemyHealth
end

function data.getMainHeroAttackDamage()
    return data.mainHeroAttackDamage
end

function data.setMainHeroAttackDamage(mainHeroAttackDamage)
    data.mainHeroAttackDamage = mainHeroAttackDamage
end

function data.getMainHeroProtected()
    return data.mainHeroIsProtected
end

function data.setMainHeroProtected(mainHeroIsProtected)
    data.mainHeroIsProtected = mainHeroIsProtected
end

function data.getButtonShieldOnCooldown()
    return data.buttonShieldOnCooldown
end

function data.setButtonShieldOnCooldown(buttonShieldOnCooldown, seconds)
    data.buttonShieldOnCooldown = buttonShieldOnCooldown
    if (buttonShieldOnCooldown == true) then data.setFramesToResetBtnShield(seconds)
    end
end

function data.getFramesToResetBtnShield()
    return data.framesToResetBtnShield
end

function data.setFramesToResetBtnShield(framesToResetBtnShield)
    data.framesToResetBtnShield = framesToResetBtnShield
end

function data.getShieldAnimIndex()
    return data.shieldAnimIndex
end

function data.setShieldAnimIndex(shieldAnimIndex)
    data.shieldAnimIndex = shieldAnimIndex
end

function data.getFramesShieldAnim()
    return data.framesShieldAnim
end

function data.setFramesShieldAnim(framesShieldAnim)
    data.framesShieldAnim = framesShieldAnim
end

function data.getFramesForBlow()
    return data.framesForBlow
end

function data.setFramesForBlow(framesForBlow)
    data.framesForBlow = framesForBlow
end

function data.getAccelSpeed()
    return data.accelSpeed
end

function data.setAccelSpeed(accelSpeed)
    data.accelSpeed = accelSpeed
end

-- Return the module
return data
