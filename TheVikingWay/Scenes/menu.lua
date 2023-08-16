-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")
local data = require("classes.data")

-- variables
local buttonPlay
local buttonHTP
local buttonImproving
local buttonSettings

-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _grpMain

-- local functions
local function gotoGame()
    composer.gotoScene("Scenes.level", { params = { reload = true } })
end

local function gotoImproving()
    composer.gotoScene("Scenes.improving")
end

local function gotoHTP()
    composer.gotoScene("Scenes.HTP")
end

local function gotoSettings()
    composer.gotoScene("Scenes.settings")
end
-- scene events functions

function scene:create( event )

    print("scene:create - menu")
    print("display.contentHeight is: ")
    print(display.contentHeight)
    print("display.contentWidth")
    print(display.contentWidth)
    data.load()
    --music
    local backgroundMusic = audio.loadStream("Assets/sound/bg.mp3")
     audio.play(backgroundMusic, { channel = 1, loops = -1 })

    _grpMain = display.newGroup()

    self.view:insert(_grpMain)
    data.setMusic(true)
    -- --
    -- local background2 = display.newImageRect(_grpMain, "Assets/start/start_bg.png", _W * 2, display.actualContentHeight * 2) -- HERE
    -- background2.x = _CX
    -- background2.y = _CY

    local background = display.newImageRect(_grpMain, "Assets/start/start_bg.png", _W, _H) -- HERE
    background.x = _CX
    background.y = _CY

    local backgroundLogo = display.newImageRect(_grpMain, "Assets/start/logo.png", 886 * data.getRatioX(), 854 * data.getRatioX())
    backgroundLogo.x = _CX
    backgroundLogo.y = display.contentCenterY - display.contentHeight * 0.2
end

function scene:show( event )
    if (event.phase == "will") then
        data.load()
        
        audio.reserveChannels(1) -- music

        if (data.getMusic() == true) then
            audio.setVolume(0.6, { channel = 1 }) 
        else 
            audio.setVolume(0, { channel = 1 }) 
        end
        
        audio.reserveChannels(2) -- sounds
        audio.reserveChannels(3) -- sounds
        audio.reserveChannels(4) -- sounds
        audio.reserveChannels(5) -- sounds
        audio.reserveChannels(6) -- sounds

        if (data.getSound() == true) then
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
        
        buttonPlay = display.newImageRect(_grpMain, "Assets/start/PLAY-BTN.png", 700* data.getRatioX(), 290* data.getRatioX())
        buttonPlay.x = _CX
        buttonPlay.y = display.contentCenterY + display.contentHeight * 0.2
    
        buttonHTP = display.newImageRect(_grpMain, "Assets/start/how-to-play-BTN.png", 339* data.getRatioX(), 113* data.getRatioX())
        buttonHTP.x = _CX - display.contentWidth * 0.15
        buttonHTP.y = display.contentCenterY + display.contentHeight * 0.36
    
        buttonImproving = display.newImageRect(_grpMain, "Assets/start/improving-BTN.png", 339* data.getRatioX(), 113* data.getRatioX())
        buttonImproving.x = _CX + display.contentWidth * 0.15
        buttonImproving.y = display.contentCenterY + display.contentHeight * 0.36
    
        buttonSettings = display.newImageRect(_grpMain, "Assets/start/setting-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonSettings.x = _CX + display.contentWidth * 0.42
        buttonSettings.y = display.contentCenterY + display.contentHeight * 0.44
    
        buttonPlay:addEventListener("tap", gotoGame)
        buttonImproving:addEventListener("tap", gotoImproving)
        buttonHTP:addEventListener("tap", gotoHTP)
        buttonSettings:addEventListener("tap", gotoSettings)
    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
        buttonPlay:removeEventListener("tap", gotoGame)
        buttonImproving:removeEventListener("tap", gotoImproving)
        buttonHTP:removeEventListener("tap", gotoHTP)
        buttonSettings:removeEventListener("tap", gotoSettings)
    elseif (event.phase == "did") then
    end
end

function scene:destroy( event )
    if (event.phase == "will") then
    elseif (event.phase == "did") then
    end
end

-- scene event listeners

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene