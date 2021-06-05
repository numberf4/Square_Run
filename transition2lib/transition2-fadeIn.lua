
local utils = require("transition2lib.utils")
local fade = require("transition2lib.transition2-fade")

local fadeIn = utils.copyTable(fade)

fadeIn.getParams = function(displayObject, params)    
    params.alpha = 1    
    return fade.getParams(displayObject, params)
end    

return fadeIn