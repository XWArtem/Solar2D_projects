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
local ship1
local ship1Title_imp1
local ship1Btn
local ship1BtnText_imp1

local ship2
local ship2Title_imp1
local ship2Btn
local ship2BtnText_imp1


-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _grpImproving1

--sounds
local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

-- local functions
local function gotoMenu()
    data.setCurrentImprovingPage(0)
    composer.gotoScene("Scenes.menu")
end

local function prevPage()
    composer.gotoScene("Scenes.improving")
end

local function nextPage()
    composer.gotoScene("Scenes.improving_2")
end

local function equipShipWithGuns()
    if (data.getCurrentShipIndex() ~= 1) then
        data.setCurrentShipIndex(1)
        print ("new current ship index: ")
        print (data.getCurrentShipIndex())
        ship1Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
        ship1BtnText_imp1.text = 'IN USE'
        ship1BtnText_imp1.x = _CX

        if (data.getShipDamageX2Av() == true) then
            ship2BtnText_imp1.text = "USE"
        end
        --shipDefaultBtnText_imp1.text = "USE"
    end
end

local function equipShipDamageX2()
    if (data.getCurrentShipIndex() ~= 2) then
        data.setCurrentShipIndex(2)
        print ("new current ship index: ")
        print (data.getCurrentShipIndex())
        ship2Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
        ship2BtnText_imp1.text = 'IN USE'
        ship2BtnText_imp1.x = _CX

        if (data.getShipWithGunsAv() == true) then
            ship1BtnText_imp1.text = "USE"
        end
    end
end

local function buyShipWithGuns()
    if (data.setShipWithGunsAv() == false) then
        data.setGold(data.getGold() - 300)
        data.setShipWithGunsAv(true)
    end
    equipShipWithGuns()
end

local function buyShipDamageX2()
    if (data.getShipDamageX2Av() == false) then
        data.setGold(data.getGold() - 1000)
        data.setShipDamageX2Av(true)
    end
    equipShipDamageX2()
end

-- scene events functions

function scene:create( event )

    print("scene:create - improving1")
    _grpImproving1 = display.newGroup()
    self.view:insert(_grpImproving1)

end

function scene:show( event )
    if (event.phase == "will") then
        data.load()

        currentImprovingPage = data.getCurrentImprovingPage()

        background = display.newImageRect(_grpImproving1, "Assets/start/start_bg.png", _W, _H)
        background.x = _CX
        background.y = _CY

        -- buttons
        buttonExit = display.newImageRect(_grpImproving1, "Assets/setting_pause/CLOSE-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonExit.x = _CX - display.contentWidth * 0.42
        buttonExit.y = display.contentCenterY - display.contentHeight * 0.44

        buttonNext = display.newImageRect(_grpImproving1, "Assets/Improving_ship/DOWN-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonNext.x = _CX - display.contentWidth * 0.42
        buttonNext.y = display.contentCenterY + display.contentHeight * 0.44

        buttonPrevious = display.newImageRect(_grpImproving1, "Assets/Improving_ship/UP-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonPrevious.x = _CX - display.contentWidth * 0.42
        buttonPrevious.y = display.contentCenterY - display.contentHeight * 0.2

        -- ship1
        ship1 = display.newImageRect(_grpImproving1, "Assets/Improving_ship/ship_1.png", 489* data.getRatioX(), 436* data.getRatioX())
        ship1.x = _CX
        ship1.y = _CY - display.contentWidth * 0.3
        ship1Title_imp1 = display.newText('SHIP WITH GUNS', ship1.x, ship1.y + display.contentWidth * 0.22, "Assets/font/DALEK__.ttf", 60* data.getRatioX())

        if (data.currentShipIndex ~= 1) then 
            ship1Btn = display.newImageRect(_grpImproving1, "Assets/Improving_ship/buy_btn.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship1Btn.x = _CX
            ship1Btn.y = display.contentCenterY  -- HERE
            ship1BtnText_imp1 = display.newText('300', ship1Btn.x + display.contentHeight * 0.02, ship1Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            if (data.getShipWithGunsAv() == false and data.getGold() > 299) then
                -- ship with guns can be bought
                ship1BtnText_imp1:setFillColor(1, 1, 1, 1)
                ship1Btn:addEventListener("tap", buyShipWithGuns)
            else if (data.getShipWithGunsAv() == false and data.getGold() < 299) then
                -- ship with guns cannot be bought
                ship1BtnText_imp1:setFillColor(1, 1, 1, 0.5)
            else if (data.getShipWithGunsAv() == true) then
                -- ship is already available
                ship1Btn:addEventListener("tap", equipShipWithGuns)
                ship1BtnText_imp1.text = 'USE'
                ship1Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
                ship1BtnText_imp1.x = _CX
            end
            end
            end
        else
            ship1Btn = display.newImageRect(_grpImproving1, "Assets/Improving_ship/inuse_frame.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship1Btn.x = _CX
            ship1Btn.y = display.contentCenterY
            ship1BtnText_imp1 = display.newText('IN USE', ship1Btn.x, ship1Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ship1Btn:addEventListener("tap", equipShipWithGuns)
        end

         -- ship2
        ship2 = display.newImageRect(_grpImproving1, "Assets/Improving_ship/ship_2.png", 529* data.getRatioX(), 429* data.getRatioX())
        ship2.x = _CX
        ship2.y = _CY + display.contentWidth * 0.27
        ship2Title_imp1 = display.newText('DAMAGE X2', _CX, _CY + display.contentWidth * 0.48, "Assets/font/DALEK__.ttf", 60* data.getRatioX())

        if data.currentShipIndex ~= 2 then 
            ship2Btn = display.newImageRect(_grpImproving1, "Assets/Improving_ship/buy_btn.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship2Btn.x = _CX
            ship2Btn.y = _CY + display.contentWidth * 0.57
            ship2BtnText_imp1 = display.newText('1000', ship2Btn.x + display.contentHeight * 0.02, ship2Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ---- START
            if (data.getShipDamageX2Av() == false and data.getGold() > 999) then
                -- ship with guns can be bought
                ship2BtnText_imp1:setFillColor(1, 1, 1, 1)
                ship2Btn:addEventListener("tap", buyShipDamageX2)
                else if (data.getShipDamageX2Av() == false and data.getGold() < 999) then
                    -- ship with guns cannot be bought
                    ship2BtnText_imp1:setFillColor(1, 1, 1, 0.5)
                    else if (data.getShipDamageX2Av() == true) then
                        -- ship is already available
                        ship2Btn:addEventListener("tap", equipShipDamageX2)
                        ship2BtnText_imp1.text = 'USE'
                        ship2Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
                        ship2BtnText_imp1.x = _CX
                    end
                end
            end
        else
            ship2Btn = display.newImageRect(_grpImproving1, "Assets/Improving_ship/inuse_frame.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship2Btn.x = _CX
            ship2Btn.y = _CY + display.contentWidth * 0.57
            ship2BtnText_imp1 = display.newText('IN USE', ship2Btn.x, ship2Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ship2Btn:addEventListener("tap", equipShipDamageX2)
        end

        -- function buttons
        buttonExit:addEventListener("tap", gotoMenu)
        buttonPrevious:addEventListener("tap", prevPage)
        buttonNext:addEventListener("tap", nextPage)

    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
        display.remove(ship1BtnText_imp1)
        ship1BtnText_imp1 = nil
        display.remove(ship2Title_imp1)
        ship2Title_imp1 = nil
        display.remove(ship2BtnText_imp1)
        ship2BtnText_imp1 = nil
        display.remove(ship1Title_imp1)
        ship1Title_imp1 = nil
        buttonExit:removeEventListener("tap", gotoMenu)
        buttonPrevious:removeEventListener("tap", prevPage)
        buttonNext:removeEventListener("tap", nextPage)
        ship1Btn:removeEventListener("tap", equipShipWithGuns)
        ship1Btn:removeEventListener("tap", buyShipWithGuns)
        ship2Btn:removeEventListener("tap", equipShipDamageX2)
        ship2Btn:removeEventListener("tap", buyShipDamageX2)
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