--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

local aspectRatio = display.pixelHeight / display.pixelWidth
local width = 360
local height = width * aspectRatio

application =
{
	content =
	{
		width = 300,
        height = 400,
        scale = "adaptive",
        fps = 60,
        
        imageSuffix =
        {
            ["@2"] = 1.5,
            ["@3"] = 2.5,
        },
	},
}
