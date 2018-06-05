-----------------------------------------------------------------------------------------
--
-- Unit5.1
--這章會將整個結構幾乎大改,我們先將需要的函式庫以及自字型檔之類的直接放到最前端
-----------------------------------------------------------------------------------------

--呼叫composer函式庫
local composer = require( "composer" )

--創建新場景
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- 然後將一些公共參數先打出來
-- -----------------------------------------------------------------------------------
local bgm = audio.loadSound ("fd.mp3")
local playBgm = audio.play(bgm,{channel=2,loops=-1,fadeim=1000})

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight
local tPrevious = system.getTimer()
-- Define reference points locations anchor ponts
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5

display.setStatusBar( display.HiddenStatusBar )

-- The sky as background


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
-- -----------------------------------------------------------------------------------
-- 這里以下才是場景開始時要出現的畫面
-- -----------------------------------------------------------------------------------
local sky = display.newImage( "xxxx.png", centerX, centerY )

    local baseline = 280

    local tree = {}
    tree[1] = display.newImage( "10.png" )
    tree[1].xScale = 0.2; tree[1].yScale = 0.5
    tree[1].anchorY = BOTTOM_REF
    tree[1].x = 20; tree[1].y = baseline -80
    tree[1].dx = 0.1
    tree[2] = display.newImage( "20.png" )
    tree[2].xScale = 0.2; tree[2].yScale = 0.5
    tree[2].anchorY = BOTTOM_REF
    tree[2].x = 120; tree[2].y = baseline -120
    tree[2].dx = 0.2
    tree[3] = display.newImage( "30.png" )
    tree[3].xScale = 0.2; tree[3].yScale = 0.5
    tree[3].anchorY = BOTTOM_REF
    tree[3].x = 200; tree[3].y = baseline -40
    tree[3].dx = 0.3
    tree[4] = display.newImage( "0.png" )
    tree[4].xScale = 1; tree[4].yScale = 1
    tree[4].anchorY = BOTTOM_REF
    tree[4].x = baseline; tree[4].y = baseline -115
    tree[4].dx = 0.4
    tree[5] = display.newImage( "1.png" )
    tree[5].xScale = 0.6; tree[5].yScale = 0.5
    tree[5].anchorY = BOTTOM_REF
    tree[5].x = 300; tree[5].y = baseline -210
    tree[5].dx = 0.5
    tree[6] = display.newImage( "40.png" )
    tree[6].xScale = 0.2; tree[5].yScale = 0.2
    tree[6].anchorY = BOTTOM_REF
    tree[6].x = 300; tree[6].y = baseline
    tree[6].dx = 0.6
    tree[7] = display.newImage( "222.png" )
    tree[7].xScale = 1.2; tree[7].yScale = 1
    tree[7].anchorY = BOTTOM_REF
    tree[7].x = 400; tree[7].y = baseline +30
    tree[7].dx = 0.3
    tree[8] = display.newImage( "50.png" )
    tree[8].xScale = 0.2; tree[5].yScale = 0.2
    tree[8].anchorY = BOTTOM_REF
    tree[8].x = 300; tree[6].y = baseline
    tree[8].dx = 0.4


    local sheet1 = graphics.newImageSheet( "runningcat1.png", { width=512, height=256, numFrames=8 } )

    local instance1 = display.newSprite( sheet1, { name="cat", frames={1,2,3,4,5,6}, time=1000 } )
    instance1.x = display.contentWidth -300
    instance1.y = baseline -70
    instance1.xScale = .5
    instance1.yScale = .5
    instance1:play()

    local sheet2 = graphics.newImageSheet( "gogo1.png", { width=256, height=512, numFrames=8 } )

    local instance2 = display.newSprite( sheet2, { name="cat11", frames={1,2,3,4,5,6,7,8}, time=2000 } )
    instance2.x = display.contentWidth -40
    instance2.y = baseline -75
    instance2.xScale = .25
    instance2.yScale = .25
    instance2:play()

    local grass = display.newImage( "grass.png" )
    grass.anchorX = LEFT_REF
    grass.x = 0
    grass.y = baseline +140
    local grass2 = display.newImage( "grass.png" )
    grass2.anchorX = LEFT_REF
    grass2.x = 480
    grass2.y = baseline +140
    
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    

-- solid ground, doesn't need to move

-- A per-frame event to move the elements
local tPrevious = system.getTimer()

end --這個end是scene:create的
-- -----------------------------------------------------------------------------------
-- 然後將移動function寫在場景以外的部分
-- -----------------------------------------------------------------------------------
--設置移動功能
local function move(event)
    local tDelta = event.time - tPrevious
    tPrevious = event.time
    local xOffset = ( 0.2 * tDelta )

    grass.x = grass.x - xOffset
    grass2.x = grass2.x - xOffset
  
    if (grass.x + grass.contentWidth) < 0 then
    grass:translate( 480 * 2, 0)
    end
    if (grass2.x + grass2.contentWidth) < 0 then
    grass2:translate( 480 * 2, 0)
    end
  
    local i
     for i = 1, #tree, 1 do
     tree[i].x = tree[i].x - tree[i].dx * tDelta * 0.2
      if (tree[i].x + tree[i].contentWidth) < 0 then
      tree[i]:translate( 480 + tree[i].contentWidth * 2, 0 )
    end
  end
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        Runtime:addEventListener( "enterFrame", move )
    elseif ( phase == "did" ) then

        -- Code here runs when the scene is entirely on screen
        --記得移除上個場景
         composer.removeScene("menu")
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
      
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    print("destroy_menu")
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene


