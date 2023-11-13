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
local title 
local desc

local shipDefault
local shipDefaultBtn
local shipDefaultBtnText_imp0

local ship1
local ship1Title_imp0
local ship1Btn
local hip1BtnText_imp0


-- layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- scene
local scene = composer.newScene()

-- groups
local _grpImproving

--sounds
local _bgMusic = audio.loadStream("Assets/sound/bg.mp3")

-- local functions
local function gotoMenu()
    data.setCurrentImprovingPage(0)
    composer.gotoScene("Scenes.menu")
end

local function nextPage()
    -- remove texts

    data.setCurrentImprovingPage(currentImprovingPage + 1)
    composer.gotoScene("Scenes.improving_1")

end

local function equipDefaultShip()
    if (data.getCurrentShipIndex() ~= 0) then
        data.setCurrentShipIndex(0)
        print ("new current ship index: ")
        print (data.getCurrentShipIndex())
        ship1BtnText_imp0.text = 'USE'
        ship1BtnText_imp0.x = _CX
        -- center
        shipDefaultBtnText_imp0.text = "IN USE"
        shipDefaultBtnText_imp0.x = _CX
    end
end

local function equipShipWithGuns()
    if (data.getCurrentShipIndex() ~= 1) then
        data.setCurrentShipIndex(1)
        print ("new current ship index: ")
        print (data.getCurrentShipIndex())
        ship1Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
        ship1BtnText_imp0.text = 'IN USE'
        ship1BtnText_imp0.x = _CX
        -- center
        shipDefaultBtnText_imp0.text = "USE"
    end
end

local function buyShipWithGuns()
    if (data.getShipWithGunsAv() == false) then
        data.setGold(data.getGold() - 300)
        data.setShipWithGunsAv(true)
    end
    
    equipShipWithGuns()
end

function scene:create( event )

    print("scene:create - improving")
    
    _grpImproving = display.newGroup()

    self.view:insert(_grpImproving)
end

function scene:show( event )
    if (event.phase == "will") then
        data.load()

        currentImprovingPage = data.getCurrentImprovingPage()
        
        background = display.newImageRect(_grpImproving, "Assets/start/start_bg.png", _W, _H)
        background.x = _CX
        background.y = _CY

        buttonExit = display.newImageRect(_grpImproving, "Assets/setting_pause/CLOSE-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonExit.x = _CX - display.contentWidth * 0.42
        buttonExit.y = display.contentCenterY - display.contentHeight * 0.44

        buttonNext = display.newImageRect(_grpImproving, "Assets/Improving_ship/DOWN-BTN.png", 106* data.getRatioX(), 106* data.getRatioX())
        buttonNext.x = _CX - display.contentWidth * 0.42
        buttonNext.y = display.contentCenterY + display.contentHeight * 0.44

        title = display.newText('IMPROVING', _CX, display.contentCenterY - display.contentHeight * 0.42, "Assets/font/DALEK__.ttf", 115* data.getRatioX())
        desc = display.newText('UPDATE YOUR SHIP WITH NEW GUNS!', _CX, display.contentCenterY - display.contentHeight * 0.34, "Assets/font/DALEK__.ttf", 50* data.getRatioX())

        -- ship default
        shipDefault = display.newImageRect(_grpImproving, "Assets/Improving_ship/defolt_ship.png", 430* data.getRatioX(), 357* data.getRatioX())
        shipDefault.x = _CX
        shipDefault.y = _CY - display.contentWidth * 0.2


        shipDefaultBtn = display.newImageRect(_grpImproving, "Assets/Improving_ship/inuse_frame.png", 340* data.getRatioX(), 113* data.getRatioX())
        shipDefaultBtn.x = _CX
        shipDefaultBtn.y = display.contentCenterY

        if data.currentShipIndex == 0 then 
            shipDefaultBtnText_imp0 = display.newText('IN USE', shipDefaultBtn.x, shipDefaultBtn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
        else
            shipDefaultBtnText_imp0 = display.newText('USE', shipDefaultBtn.x, shipDefaultBtn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
        end
        shipDefaultBtn:addEventListener("tap", equipDefaultShip)

        -- ship 1
        ship1 = display.newImageRect(_grpImproving, "Assets/Improving_ship/ship_1.png", 489* data.getRatioX(), 436* data.getRatioX())
        ship1.x = _CX
        ship1.y = _CY + display.contentWidth * 0.27
        ship1Title_imp0 = display.newText('SHIP WITH GUNS', _CX, _CY + display.contentWidth * 0.48, "Assets/font/DALEK__.ttf", 60* data.getRatioX())

        if (data.currentShipIndex ~= 1) then 
            ship1Btn = display.newImageRect(_grpImproving, "Assets/Improving_ship/buy_btn.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship1Btn.x = _CX
            ship1Btn.y = _CY + display.contentWidth * 0.57
            ship1BtnText_imp0 = display.newText('300', ship1Btn.x + display.contentHeight * 0.02, ship1Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            if (data.getShipWithGunsAv() == false and data.getGold() > 300) then
                -- ship with guns can be bought
                ship1BtnText_imp0:setFillColor(1, 1, 1, 1)
                ship1Btn:addEventListener("tap", buyShipWithGuns)
                else if (data.getShipWithGunsAv() == false and data.getGold() < 300) then
                    -- ship with guns cannot be bought
                    ship1BtnText_imp0:setFillColor(1, 1, 1, 0.5)
                    else if (data.getShipWithGunsAv() == true) then
                        -- ship is already available
                        ship1Btn:addEventListener("tap", equipShipWithGuns)
                        ship1BtnText_imp0.text = 'USE'
                        ship1Btn.fill = { type = "image", filename = "Assets/Improving_ship/inuse_frame.png" }
                        ship1BtnText_imp0.x = _CX
                    end
                end
            end
        else
            ship1Btn = display.newImageRect(_grpImproving, "Assets/Improving_ship/inuse_frame.png", 340* data.getRatioX(), 113* data.getRatioX())
            ship1Btn.x = _CX
            ship1Btn.y = _CY + display.contentWidth * 0.57
            ship1BtnText_imp0 = display.newText('IN USE', ship1Btn.x, ship1Btn.y, "Assets/font/DALEK__.ttf", 60* data.getRatioX())
            ship1Btn:addEventListener("tap", equipShipWithGuns)
        end

        -- function buttons
        buttonExit:addEventListener("tap", gotoMenu)
        buttonNext:addEventListener("tap", nextPage)
    
    elseif (event.phase == "did") then
    end
end

function scene:hide( event )
    if (event.phase == "will") then
         display.remove(title)
         title = nil
         display.remove(desc)
         desc = nil
         display.remove(shipDefaultBtnText_imp0)
         shipDefaultBtnText_imp0 = nil
         display.remove(ship1BtnText_imp0)
         ship1BtnText_imp0 = nil
         display.remove(ship1Title_imp0)
         ship1Title_imp0 = nil
        buttonExit:removeEventListener("tap", gotoMenu)
        buttonNext:removeEventListener("tap", nextPage)
        ship1Btn:removeEventListener("tap", equipShipWithGuns)
        ship1Btn:removeEventListener("tap", buyShipWithGuns)
        shipDefaultBtn:removeEventListener("tap", equipDefaultShip)
    elseif (event.phase == "did") then
    end
end

function scene:destroy( event )
    if (event.phase == "will") then
        buttonExit:removeEventListener("tap", gotoMenu)
        buttonNext:removeEventListener("tap", nextPage)
        ship1Btn:removeEventListener("tap", equipShipWithGuns)
        ship1Btn:removeEventListener("tap", buyShipWithGuns)
        shipDefaultBtn:removeEventListener("tap", equipDefaultShip)
    elseif (event.phase == "did") then
    end
end

-- scene event listeners

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene