
return {
    getStartValue = function(displayObject, params)     
        return {
            x = displayObject.xScale,
            y = displayObject.yScale,
        }
    end,

    getEndValue = function(displayObject, params)
        return {
            x = (params.delta and (displayObject.xScale + (params.xScale or 0)) or (params.xScale or displayObject.xScale)),
            y = (params.delta and (displayObject.yScale + (params.yScale or 0)) or (params.yScale or displayObject.yScale)),
        }
    end,

    onValue = function(displayObject, params, value, isReverseCycle)
        displayObject.xScale = value.x
        displayObject.yScale = value.y
    end,
    
    getParams = function(displayObject, params) 
        local params = params or {}               
        params.static = false
        
        return params
    end,
    
    cancelWhen = function(displayObject, params)
        return not displayObject.xScale
    end    
}