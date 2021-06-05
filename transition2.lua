
package.path = package.path .. ";./?.lua;./transition2lib/?.lua;"

local createTransition2 = require("transition2lib.transition2-main")

local transition2 = createTransition2({        
    -- New transition functions
    color = require("transition2lib.transition2-color"),
    bounce = require("transition2lib.transition2-bounce"),
    moveSine = require("transition2lib.transition2-moveSine"),   
    moveBungy = require("transition2lib.transition2-moveBungy"),   
    zRotate = require("transition2lib.transition2-zRotate"),
    waterBalloon = require("transition2lib.transition2-waterBalloon"),    
    
    -- Convenience functions (specialized versions of transitions)
    glow = require("transition2lib.transition2-glow"),  
    
    -- Overridden transition library functions
    blink = require("transition2lib.transition2-blink"),
    to = require("transition2lib.transition2-to"),
    from = require("transition2lib.transition2-from"),
    scaleTo = require("transition2lib.transition2-scaleTo"),
    scaleBy = require("transition2lib.transition2-scaleBy"),
    fadeIn = require("transition2lib.transition2-fadeIn"),
    fadeOut = require("transition2lib.transition2-fadeOut"),
    moveTo = require("transition2lib.transition2-moveTo"),
    moveBy = require("transition2lib.transition2-moveBy"),    
})


transition2.fallingLeaf = require("transition2lib.transition2-fallingLeaf")(transition2)


transition2.dissolve = require("transition2lib.transition2-dissolve")(transition2)

return transition2