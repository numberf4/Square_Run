

local function getValidIntensity(intensity)
    local MAX_INTENSITY = 1
    local DEFAULT_INTENSITY = 0.25
    
    local validIntensity = DEFAULT_INTENSITY
    
    if (intensity and intensity > 0 and intensity <= MAX_INTENSITY) then
        validIntensity = intensity
    end
    
    return validIntensity
end

local SCALE_FACTOR = 0.5

return {
    getStartValue = function(displayObject, params)     
        return {
            xScale = params.originalXScale,
            yScale = params.originalYScale + (getValidIntensity(params.intensity) * SCALE_FACTOR * params.originalYScale),
        }
    end,

    getEndValue = function(displayObject, params)
        return {
            xScale = params.originalXScale + (getValidIntensity(params.intensity) * SCALE_FACTOR * params.originalXScale),
            yScale = params.originalYScale,
        }
    end,

    onValue = function(displayObject, params, value, isReverseCycle)
        displayObject.xScale = value.xScale
        displayObject.yScale = value.yScale
    end,
    
    cancelWhen = function(displayObject, params)        
        return not displayObject.xScale
    end,
    
    getParams = function(displayObject, params)
        params.reverse = true
        params.iterations = 0
        params.transition = easing.inOutQuad
        
        params.originalXScale = displayObject.xScale
        params.originalYScale = displayObject.yScale
        
        params.static = false
        
        return params
    end
}