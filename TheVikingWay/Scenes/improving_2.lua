-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")
local data = require("classes.data")

-- variables
local currentImprovingPage
local background
local buttonExit
local buttonNext
local ship2
local ship2Title_imp2
local ship2Btn
local ship2BtnText_imp2

local ship3
local ship3Title_imp2
local ship3Btn
local ship3BtnText_imp2

-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _grpImproving2

--sounds
local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

-- local functions
local function gotoMenu()
    data.setCurrentImprovingPage(0)
    composer.gotoScene("Scenes.menu")
end

local function prevPage()
    composer.gotoScene("Scenes.improving_1")
end

local function equipShipDamageX2()
    if (data.getCurrentShipIndex() ~= 2) then
        data.setCurrentShipIndex(2)
        print ("new current ship index: ")
        print (data.getCurrentShipIndex())
        ship2Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
        ship2BtnText_imp2.text = 'IN USE'
        ship2BtnText_imp2.x = _CX

        if (data.getShipDamageX3Av() == true) then
            ship3BtnText_imp2.text = "USE"
        end
    end
end

local function buyShipWithGuns()
    data.setGold(data.getGold() - 300)
    data.setShipWithGunsAv(true)
    equipShipWithGuns()
end

local function buyShipDamageX2()
    data.setGold(data.getGold() - 1000)
    data.setShipDamageX2Av(true)
    equipShipDamageX2()
end

local function equipShipDamageX3()
    if (data.getCurrentShipIndex() ~= 3) then
        data.setCurrentShipIndex(3)
        print ("new current ship index: ")
        print (data.getCurrentShipIndex())
        ship3Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
        ship3BtnText_imp2.text = 'IN USE'
        ship3BtnText_imp2.x = _CX

        if (data.getShipDamageX2Av() == true) then
            ship2BtnText_imp2.text = "USE"
        end
    end
end

local function buyShipDamageX2()
    data.setGold(data.getGold() - 1000)
    data.setShipDamageX2Av(true)
    equipShipDamageX2()
end

local function buyShipDamageX3()
    data.setGold(data.getGold() - 1500)
    data.setShipDamageX3Av(true)
    equipShipDamageX3()
end

-- scene events functions

function scene:create( event )

    print("scene:create - improving2")
    _grpImproving2 = display.newGroup()
    self.view:insert(_grpImproving2)

end

function scene:show( event )
    if (event.phase == "will") then
        data.load()
        currentImprovingPage = data.getCurrentImprovingPage()

        background = display.newImageRect(_grpImproving2, "Assets/start/start_bg.png", _W, _H)
        background.x = _CX
        background.y = _CY

        -- buttons
        buttonExit = display.newImageRect(_grpImproving2, "Assets/setting_pause/CLOSE-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonExit.x = _CX - display.contentWidth * 0.42
        buttonExit.y = display.contentCenterY - display.contentHeight * 0.44

        buttonNext = display.newImageRect(_grpImproving2, "Assets/Improving_ship/DOWN-BTN_inactive.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonNext.x = _CX - display.contentWidth * 0.42
        buttonNext.y = display.contentCenterY + display.contentHeight * 0.44

        buttonPrevious = display.newImageRect(_grpImproving2, "Assets/Improving_ship/UP-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonPrevious.x = _CX - display.contentWidth * 0.42
        buttonPrevious.y = display.contentCenterY - display.contentHeight * 0.2

        -- ship2
        ship2 = display.newImageRect(_grpImproving2, "Assets/Improving_ship/ship_2.png", 529* data.getRatioX(), 429* data.getRatioX())
        ship2.x = _CX
        ship2.y = _CY - display.contentWidth * 0.3
        ship2Title_imp2 = display.newText('DAMAGE X2', ship2.x, ship2.y + display.contentWidth * 0.22, "Assets/font/DALEK__.ttf", 60* data.getRatioX())

        if (data.currentShipIndex ~= 2) then 
            ship2Btn = display.newImageRect(_grpImproving2, "Assets/Improving_ship/buy_btn.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship2Btn.x = _CX
            ship2Btn.y = display.contentCenterY
            ship2BtnText_imp2 = display.newText('1000', ship2Btn.x + display.contentHeight * 0.02, ship2Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            if (data.getShipDamageX2Av() == false and data.getGold() > 999) then
                -- ship with guns can be bought
                ship2BtnText_imp2:setFillColor(1, 1, 1, 1)
                ship2Btn:addEventListener("tap", buyShipDamageX2)
            else if (data.getShipDamageX2Av() == false and data.getGold() < 999) then
                -- ship with guns cannot be bought
                ship2BtnText_imp2:setFillColor(1, 1, 1, 0.5)
            else if (data.getShipDamageX2Av() == true) then
                -- ship is already available
                ship2Btn:addEventListener("tap", equipShipDamageX2)
                ship2BtnText_imp2.text = 'USE'
                ship2Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
                ship2BtnText_imp2.x = _CX
            end
            end
            end
        else
            ship2Btn = display.newImageRect(_grpImproving2, "Assets/Improving_ship/inuse_frame.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship2Btn.x = _CX
            ship2Btn.y = display.contentCenterY
            ship2BtnText_imp2 = display.newText('IN USE', ship2Btn.x, ship2Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ship2Btn:addEventListener("tap", equipShipDamageX2)
        end

         -- ship3
        ship3 = display.newImageRect(_grpImproving2, "Assets/Improving_ship/ship_3.png", 552* data.getRatioX(), 455* data.getRatioX())
        ship3.x = _CX
        ship3.y = _CY + display.contentWidth * 0.27
        ship3Title_imp2 = display.newText('DAMAGE X3', _CX, _CY + display.contentWidth * 0.48, "Assets/font/DALEK__.ttf", 60* data.getRatioX())

        if data.currentShipIndex ~= 3 then 
            ship3Btn = display.newImageRect(_grpImproving2, "Assets/Improving_ship/buy_btn.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship3Btn.x = _CX
            ship3Btn.y = _CY + display.contentWidth * 0.57
            ship3BtnText_imp2 = display.newText('1500', ship3Btn.x + display.contentHeight * 0.02, ship3Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ---- START
            if (data.getShipDamageX3Av() == false and data.getGold() > 1499) then
                -- ship with guns can be bought
                ship3BtnText_imp2:setFillColor(1, 1, 1, 1)
                ship3Btn:addEventListener("tap", buyShipDamageX3)
                else if (data.getShipDamageX3Av() == false and data.getGold() < 1499) then
                    -- ship with guns cannot be bought
                    ship3BtnText_imp2:setFillColor(1, 1, 1, 0.5)
                    else if (data.getShipDamageX3Av() == true) then
                        -- ship is already available
                        ship3Btn:addEventListener("tap", equipShipDamageX3)
                        ship3BtnText_imp2.text = 'USE'
                        ship3Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
                        ship3BtnText_imp2.x = _CX
                    end
                end
            end
        else
            ship3Btn = display.newImageRect(_grpImproving2, "Assets/Improving_ship/inuse_frame.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship3Btn.x = _CX
            ship3Btn.y = display.contentCenterY
            ship3BtnText_imp2 = display.newText('IN USE', ship3Btn.x, ship3Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ship3Btn:addEventListener("tap", equipShipDamageX3)
        end


        buttonExit:addEventListener("tap", gotoMenu)
        buttonPrevious:addEventListener("tap", prevPage)

    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
        display.remove(ship2BtnText_imp2)
        ship2BtnText_imp2 = nil
        display.remove(ship2Title_imp2)
        ship2Title_imp2 = nil
        display.remove(ship3BtnText_imp2)
        ship3BtnText_imp2 = nil
        display.remove(ship3Title_imp2)
        ship3Title_imp2 = nil
        buttonExit:removeEventListener("tap", gotoMenu)
        buttonPrevious:removeEventListener("tap", prevPage)
        ship2Btn:removeEventListener("tap", equipShipDamageX2)
        ship2Btn:removeEventListener("tap", buyShipDamageX2)
        ship3Btn:removeEventListener("tap", equipShipDamageX3)
        ship3Btn:removeEventListener("tap", buyShipDamageX3)
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