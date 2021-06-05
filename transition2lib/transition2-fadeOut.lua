
local utils = require("transition2lib.utils")
local fade = require("transition2lib.transition2-fade")

local fadeOut = utils.copyTable(fade)

fadeOut.getParams = function(displayObject, params)    
    params.alpha = 0
    return fade.getParams(displayObject, params)
end    

return fadeOut