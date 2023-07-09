-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")

-- variables
-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _grpMain

--sounds
local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

-- local functions


-- scene events functions

function scene:create( event )

    print("scene:create - game")

    _grpMain = display.newGroup()

    self.view:insert(_grpMain)

    --



    --buttonPlay:addEventListener("tap", gotoGame)

end

function scene:show( event )
    if (event.phase == "will") then
    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
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