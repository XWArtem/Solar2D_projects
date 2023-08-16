-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )
display.setStatusBar( display.HiddenStatusBar )
native.setProperty("prefferedScreenEdgesDeferringSystemGestures", true )

if (system.getInfo("platform") == "ios") then
	att = require("plugin.att")
	attStatus = att.status
end

function attListener(e)
    print("Status is " .. tostring(e.status))
end
 
local function tapListener()
	if (system.getInfo("platform") == "ios") then
		att.request(attListener)
	end
end

Runtime:addEventListener( "tap", tapListener)

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"



-- event listeners for tab buttons:
local function onFirstView( event )
	system.setAccelerometerInterval(0.1)
	composer.gotoScene( "Scenes.menu" )
end


onFirstView()	-- invoke first tab button's onPress event manually
