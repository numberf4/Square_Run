
local utils = require("transition2lib.utils")
local move = require("transition2lib.transition2-move")

local moveTo = utils.copyTable(move)

moveTo.getParams = function(displayObject, params)
    params.delta = false
    
    return move.getParams(displayObject, params)
end    

return moveTo