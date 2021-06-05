-- Import

local composer = require("composer")
local relayout = require("libs.relayout")
local utilities = require("classes.utilities")

--
-- Set variables

-- Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY 

-- Scene
local scene = composer.newScene()

-- Groups
local _grpMain

-- Sounds
local clickSound = audio.loadStream("assets/sounds/click.wav")


--
-- Local functions

local function gotoGame()
    utilities:playSound(clickSound)
    composer.gotoScene( "scenes.game" )
end

local function gotoGame2()
    utilities:playSound(clickSound)
    composer.gotoScene("scenes.game2")
end 

local function gotoSettings()
    utilities:playSound(clickSound)
    composer.gotoScene( "scenes.settings" )
end


--
-- Scene events functions

function scene:create( event )

    print("scene:create - menu")

    _grpMain = display.newGroup()

    self.view:insert(_grpMain)

    --

    local background = display.newImageRect(_grpMain, "assets/images/background.jpeg", _W, _H)
    background.x = _CX
    background.y = _CY

    local lblTitle = display.newText("Square Run", _CX, 100, "assets/fonts/Galada.ttf", 70)
    lblTitle.fill = { 1, 1, 1 }
    _grpMain:insert(lblTitle)

    local btnPlay = display.newRoundedRect( _grpMain, _CX, _CY , 220, 80, 20)
    btnPlay.fill = { 0.5, 1, 1 }
    btnPlay.alpha = 0.4;
    local txtPlay = display.newText("Play ", _CX, _CY, "assets/fonts/Galada.ttf", 50)
    txtPlay.fill = { 0, 0, 0 } 
    _grpMain:insert(txtPlay)

    btnPlay:addEventListener("tap", gotoGame)

    -- local btnPlay2 = display.newRoundedRect( _grpMain, _CX, _CY +100, 220, 80, 20)
    -- btnPlay2.fill = {0.5, 1, 1}
    -- btnPlay2.alpha = 0.4;
    -- local txtPlay2 = display.newText("Play", _CX, _CY + 100, "assets/fonts/Galada.ttf", 50)
    -- txtPlay2.fill = {0,0,0}
    -- _grpMain:insert(txtPlay2)

    -- btnPlay2:addEventListener("tap", gotoGame2)

    local lblSettings = display.newText("Settings", _CX, _H -50, "assets/fonts/Galada.ttf", 26)
    lblSettings.fill = { 1, 1, 1 }
    _grpMain:insert(lblSettings)

    lblSettings:addEventListener("tap", gotoSettings)

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


--
-- Scene event listeners

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene