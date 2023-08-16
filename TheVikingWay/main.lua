-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )
display.setStatusBar( display.HiddenStatusBar )
native.setProperty("prefferedScreenEdgesDeferringSystemGestures", true )
local att = require("plugin.att")

local status = att.status
local statusText = display.newText( status, display.contentCenterX, display.contentCenterY*0.5, nil, 14 )

local eventText = display.newText( "tap to request", display.contentCenterX, display.contentCenterY*1.5, display.contentWidth*0.5, display.contentHeight*0.25, nil, 14 )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

local function attListener(e)
    eventText.text = "Status is " .. tostring(e.status)
end
 
local function tapListener()
    att.request(attListener)
end

Runtime:addEventListener( "tap", tapListener)

-- event listeners for tab buttons:
local function onFirstView( event )
	system.setAccelerometerInterval(0.1)
	-- audio.reserveChannels(1) -- music
	-- audio.setVolume(0.6, { channel = 1 }) 
	-- audio.reserveChannels(2) -- sounds
	-- audio.setVolume(0.6, { channel = 2 })
	-- audio.reserveChannels(3) -- sounds
	-- audio.setVolume(0.6, { channel = 3 })
	-- audio.reserveChannels(4) -- sounds
	-- audio.setVolume(0.6, { channel = 4 })
	-- audio.reserveChannels(5) -- sounds
	-- audio.setVolume(0.6, { channel = 5 })
	-- audio.reserveChannels(6) -- sounds
	-- audio.setVolume(0.6, { channel = 6 })
	composer.gotoScene( "Scenes.menu" )
end

local function onSecondView( event )
	composer.gotoScene( "Scenes.level" )
end


-- create a tabBar widget with two buttons at the bottom of the screen

-- table to setup buttons
local tabButtons = {
	{ label="First", defaultFile="button1.png", overFile="button1-down.png", width = 32, height = 32, onPress=onFirstView, selected=true },
	{ label="Second", defaultFile="button2.png", overFile="button2-down.png", width = 32, height = 32, onPress=onSecondView },
}

-- create the actual tabBar widget

--local tabBar = widget.newTabBar{
	--top = display.contentHeight - 50,	-- 50 is default height for tabBar widget
	--buttons = tabButtons
--} 

onFirstView()	-- invoke first tab button's onPress event manually
