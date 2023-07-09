-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")

-- variables
local buttonCloseHTP
local title
local desc

-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _grpHTP

--sounds
local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

-- local functions

local function closeHTP()
    composer.gotoScene("Scenes.menu")
end

-- scene events functions

function scene:create( event )

    print("scene:create - HTP")

    _grpHTP = display.newGroup()

    self.view:insert(_grpHTP)

    local background = display.newImageRect(_grpHTP, "Assets/start/start_bg.png", _W, _H)
    background.x = _CX
    background.y = _CY

end

function scene:show( event )
    if (event.phase == "will") then
        

        buttonCloseHTP = display.newImageRect(_grpHTP, "Assets/setting_pause/CLOSE-BTN.png", 106 * data.getRatioX(), 106* data.getRatioX())
        buttonCloseHTP.x = _CX + display.contentWidth * 0.42
        buttonCloseHTP.y = display.contentCenterY - display.contentHeight * 0.44

        local titleContainer = display.newRect(_grpHTP, display.contentCenterX, display.contentCenterY - display.contentHeight * 0.24, display.contentWidth - 250, display.contentHeight - 250)
        titleContainer:setFillColor(0, 0, 0, 0) -- transparent

        title = display.newText({
            parent = _grpHTP,
            text = "PROTECT YOUR GOLD ON\nYOUR WAY TO VALHALLA!",
            x = titleContainer.x,
            y = titleContainer.y,
            font = "Assets/font/DALEK__.ttf",
            fontSize = 85* data.getRatioX()
        })
        title:setTextColor(255, 216, 0)
        title.anchorX = 0.5
        title.anchorY = 0.5

        local descContainer = display.newRect(_grpHTP, display.contentCenterX, display.contentCenterY + display.contentHeight * 0.1, display.contentWidth - 250, display.contentHeight - 250)
        descContainer:setFillColor(0, 0, 0, 0) -- transparent
        
        desc = display.newText({
            parent = _grpHTP,
            text = "CONTROL YOUR SHIP BY\nTILTING THE SCREEN,\nSHOOT THE CHEEKY\nPIRATES WITH YOUR TAP\nAND COLLECT BARRELS OF\nGOLD COINS!",
            x = descContainer.x,
            y = descContainer.y,
            font = "Assets/font/DALEK__.ttf",
            fontSize = 70 * data.getRatioX()
        })
        desc:setTextColor(255, 255, 255)

        buttonCloseHTP:addEventListener("tap", closeHTP)

    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
        buttonCloseHTP:removeEventListener("tap", closeHTP)
        display.remove(title)
        title = nil
        display.remove(desc)
        desc = nil
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