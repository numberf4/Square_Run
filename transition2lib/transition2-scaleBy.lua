
local utils = require("transition2lib.utils")
local scale = require("transition2lib.transition2-scale")

local scaleTo = utils.copyTable(scale)

scaleTo.getParams = function(displayObject, params)
    params.delta = true
    
    return scale.getParams(displayObject, params)
end    

return scaleTo