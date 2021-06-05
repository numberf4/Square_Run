

local utils = require("transition2lib.utils")

local function calculateStartOffset(params)
    return {
        x = params.forceCentering and 0 or (params.radiusX * math.sin(utils.toRadians(params.startDegreesX))),
        y = params.forceCentering and 0 or (params.radiusY * math.sin(utils.toRadians(params.startDegreesY))),
    }
end

return {
    getStartValue = function(displayObject, params)        
        return {
            x = params.startDegreesX,
            y = params.startDegreesY
        }
    end,

    getEndValue = function(displayObject, params)
        return {
            x = params.deltaDegreesX + params.startDegreesX,
            y = params.deltaDegreesY + params.startDegreesY
        }
    end,

    onValue = function(displayObject, params, value, isReverseCycle)
        local degrees = value        
        
        if (params.radiusX ~= 0) then
            local offsetX = (params.radiusX * math.sin(utils.toRadians(degrees.x)))            
            displayObject.x = params.startX + offsetX - params.startOffset.x
        end
        
        if (params.radiusY ~= 0) then
            local offsetY = (params.radiusY * math.sin(utils.toRadians(degrees.y)))
            displayObject.y = params.startY + offsetY - params.startOffset.y
        end
    end,
 
    getParams = function(displayObject, params)        
        params.transition = easing.linear
        params.transitionReverse = easing.linear
        params.reverse = false
        params.time = params.time or 500  
        params.startX = displayObject.x
        params.startY = displayObject.y
        params.startDegreesX = params.startDegreesX and (params.startDegreesX % 360) or 0
        params.deltaDegreesX = params.deltaDegreesX or 360
        params.startDegreesY = params.startDegreesY and (params.startDegreesY % 360) or 0
        params.deltaDegreesY = params.deltaDegreesY or 360
        params.radiusX = params.radiusX or 0
        params.radiusY = params.radiusY or 0
        params.static = false
        
        params.startOffset = calculateStartOffset(params)
        
        -- If we want to recalculate new position for each iteration we must also change the calculated start values
        if (params.recalculateOnIteration) then
            local wrappedIterationComplete = params.onIterationComplete
            params.onIterationComplete = function(obj, params)            
                if (wrappedIterationComplete) then
                    wrappedIterationComplete(obj, params)
                end
                
                params.startX = obj.x
                params.startY = obj.y
                params.startOffset = calculateStartOffset(params)
            end            
        end
 
        return params
    end,
    
    cancelWhen = function(displayObject, params)
        -- This will cancel the transition if the display object no longer has x and y values
        return displayObject.x == nil or displayObject.y == nil
    end
}