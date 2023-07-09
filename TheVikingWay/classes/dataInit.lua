dataInit = {
    --ShipIndex = 0,
    --improvingPage = 0,
    initGold = 0,
    initDistance = 0,
    initMusic = true,
    initSound = true,
    fireball_distance_to_hit = 200
}
-- functions
function dataInit.getInitGold()
    return dataInit.initGold
end

function dataInit.setInitGold(initGold)
    dataInit.initGold = initGold
end

function dataInit.getinitDistance()
    return dataInit.initDistance
end

function dataInit.setinitDistance(initDistance)
    dataInit.initDistance = initDistance
end

function dataInit.getFireBallDistanceToHit()
    return dataInit.fireball_distance_to_hit
end

-- Return the module
return dataInit