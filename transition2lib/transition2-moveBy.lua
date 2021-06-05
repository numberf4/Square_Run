
local utils = require("transition2lib.utils")
local move = require("transition2lib.transition2-move")

local moveBy = utils.copyTable(move)

moveBy.getParams = function(displayObject, params)
    params.delta = true
    
    return move.getParams(displayObject, params)
end    

return moveBy