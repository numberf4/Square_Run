-----------------------------------------------------------------------------------------
--
-- fail.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
		
	-- go to level1.lua scene
	composer.gotoScene( "scenes.game2", "fade", 800 )
	
	return true	-- indicates successful touch
end

local function onMainBtnRelease()
	
	composer.gotoScene( "scenes.menu", "fade", 800 )
	return true	-- indicates successful touch
end

function scene:create( event )

	local sceneGroup = self.view

	local title = display.newText("Game Over", 50, 60, "assets/fonts/Galada.ttf",60)
	title:setFillColor(1,1,1)
	title.x, title.y = display.contentWidth/2, 50
	
	percent = display.newText( "You completed "..tostring(savedCurrentPercent ).."% of the level!", 240, 160, "assets/fonts/Galada.ttf", 24 )
	percent:setFillColor( 1.0, 1.0, 1.0 )
	
	attemptNumber = display.newText( "You played "..tostring(loadedCurrentAttempt ).."times", 240, 190, "assets/fonts/Galada.ttf", 24 )
	attemptNumber:setFillColor( 1.0, 1.0, 1.0 )
	
	local background = display.newImageRect( "assets/images/bg_horizontal.jpeg", display.contentWidth, display.contentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = 0, 0
	
	playBtn = display.newText("Play Again", 50, 50, "assets/fonts/JosefinSans-Regular.ttf",25)
	playBtn.x, playBtn.y = 130, 240
	playBtn:addEventListener("tap", onPlayBtnRelease)
	
	mainBtn = display.newText("Main Menu", 50, 50, "assets/fonts/JosefinSans-Regular.ttf",25)
	mainBtn.x, mainBtn.y = 350, 240
	mainBtn:addEventListener("tap", onMainBtnRelease)

	-- all display objects must be inserted into group
	
	sceneGroup:insert( background )
	sceneGroup:insert(title)
	sceneGroup:insert( playBtn )
	sceneGroup:insert( mainBtn )
	sceneGroup:insert(percent)
	sceneGroup:insert(attemptNumber)
end



function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		
	composer.removeHidden()

	function loadTextFile( fname, base )
	local base = base or system.DocumentsDirectory
	local path = system.pathForFile( fname, base )
	local txtData
	local file = io.open( path, "r" )
	if file then
	   txtData = file:read( "*a" )
	   io.close( file )
	end
	return txtData
end

savedCurrentPercent = loadTextFile("currentPercent.txt")
loadedCurrentAttempt = loadTextFile("currentAttempt.txt")


percent.text = "You completed ".. tostring(savedCurrentPercent).. "% of the level!"
attemptNumber.text = "This was attempt #".. tostring(loadedCurrentAttempt)

	
	elseif phase == "did" then
	
end
end


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )



-----------------------------------------------------------------------------------------

return scene