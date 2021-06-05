local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")

-- Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY 

-- Scene
local scene = composer.newScene()

-- Groups
local grpMain
local grpBackgrounds

function onOrientationChange( event )
    local currentOrientation = "landscapeLeft"
    print( "Current orientation: " .. currentOrientation )
end
  
   Runtime:addEventListener( "orientation", onOrientationChange )

-- Scene events functions
function scene:create( event )
	print("scene:create - game2")
    grpMain = display.newGroup()
    self.view:insert(grpMain)

    grpBackgrounds = display.newGroup()
    grpMain:insert(grpBackgrounds)

    local bg = display.newImageRect(grpBackgrounds, "assets/images/background.jpeg", _W, _H)
    bg.x = _CX
    bg.y = _CY
    bg.alpha = 0.3
 
end
function scene:show( event )

    if ( event.phase == "will" ) then
    elseif ( event.phase == "did" ) then
    end
end

function scene:hide( event )

    if ( event.phase == "will" ) then
    elseif ( event.phase == "did" ) then
    end
end

function scene:destroy( event )

    if ( event.phase == "will" ) then
    elseif ( event.phase == "did" ) then
    end
end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
