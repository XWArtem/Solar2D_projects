-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")
local data = require("classes.data")

-- variables
local buttonImproving
local buttonSound_set
local buttonMusic_set
local buttonClose

-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _settingsLayer
local _grpText

-- local functions

local function closeSettings()
    composer.gotoScene("Scenes.menu")
end

local function gotoImproving()
    composer.gotoScene("Scenes.improving")
end

local function soundToggle_set()
    if (data.getSound() == true) then
        data.setSound(false)
        buttonSound_set.fill = {type = "image", filename = "Assets/setting_pause/SOUND_off.png"}
    else data.setSound(true)
        buttonSound_set.fill = {type = "image", filename = "Assets/setting_pause/SOUND_on.png"}
    end
    data.save()
end

local function musicToggle_set()
    if (data.getMusic() == true) then
        data.setMusic(false)
        buttonMusic_set.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_off.png"}
    else data.setMusic(true)
        buttonMusic_set.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_on.png"}
    end
    data.save()
end
-- scene events functions

function scene:create( event )

    print("scene:create - settings")
    _settingsLayer = display.newGroup()
    _grpText = display.newGroup()
    self.view:insert(_settingsLayer)

    --
    
    backgroundPause = display.newImageRect(_settingsLayer, "Assets/start/start_bg.png", _W, _H)
    backgroundPause.x = _CX
    backgroundPause.y = _CY
end

function scene:show( event )
    if (event.phase == "will") then
        -- data.load()
        buttonClose = display.newImageRect(_settingsLayer, "Assets/setting_pause/CLOSE-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonClose.x = _CX + display.contentWidth * 0.42
        buttonClose.y = display.contentCenterY - display.contentHeight * 0.44

        local titleContainerSettings = display.newRect(_grpText, display.contentCenterX, display.contentCenterY - display.contentHeight * 0.24, display.contentWidth - 250, display.contentHeight - 250)
        titleContainerSettings:setFillColor(0, 0, 0, 0) -- transparent
        print("scene:create - settings2")
        titleSettings = display.newText({
            parent = _settingsLayer,
            text = "SETTING",
            x = titleContainerSettings.x,
            y = titleContainerSettings.y,
            font = "Assets/font/DALEK__.ttf",
            fontSize = 204* data.getRatioX()
        })
        
        titleSettings:setTextColor(255, 216, 0)
        titleSettings.anchorX = 0.5
        titleSettings.anchorY = 0.5
        
        buttonImproving = display.newImageRect(_settingsLayer, "Assets/setting_pause/improving-BTN.png", 472* data.getRatioX(), 157* data.getRatioX())
        buttonImproving.x = _CX
        buttonImproving.y = _CY

        buttonSound_set = display.newImageRect(_settingsLayer, "Assets/setting_pause/SOUND_on.png", 209* data.getRatioX(), 209* data.getRatioX())
        buttonSound_set.x = _CX + _CX * 0.22
        buttonSound_set.y = _CY + _CY * 0.46

        buttonMusic_set = display.newImageRect(_settingsLayer, "Assets/setting_pause/MUSIC_on.png", 209* data.getRatioX(), 209* data.getRatioX())
        buttonMusic_set.x = _CX - _CX * 0.22
        buttonMusic_set.y = _CY + _CY * 0.46

        if (data.getSound() == true) then
            buttonSound_set.fill = {type = "image", filename = "Assets/setting_pause/SOUND_on.png"}
        else 
            buttonSound_set.fill = {type = "image", filename = "Assets/setting_pause/SOUND_off.png"}
        end

        if (data.getMusic() == true) then
            buttonMusic_set.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_on.png"}
        else 
            buttonMusic_set.fill = {type = "image", filename = "Assets/setting_pause/MUSIC_off.png"}
        end

        -- events
        buttonImproving:addEventListener("tap", gotoImproving)
        buttonClose:addEventListener("tap", closeSettings)
        buttonSound_set:addEventListener("tap", soundToggle_set)
        buttonMusic_set:addEventListener("tap", musicToggle_set)
        
    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
        buttonImproving:removeEventListener("tap", gotoImproving)
        buttonClose:removeEventListener("tap", closeSettings)
        buttonSound_set:removeEventListener("tap", soundToggle_set)
        buttonMusic_set:removeEventListener("tap", musicToggle_set)
        display.remove(titleSettings)
        titleSettings = nil
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