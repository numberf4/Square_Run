
return {
    getStartValue = function(displayObject, params)     
        return {
            x = displayObject.x,
            y = displayObject.y,
        }
    end,

    getEndValue = function(displayObject, params)
        return {
            x = (params.delta and (displayObject.x + (params.x or 0)) or (params.x or displayObject.x)),
            y = (params.delta and (displayObject.y + (params.y or 0)) or (params.y or displayObject.y)),
        }
    end,

    onValue = function(displayObject, params, value, isReverseCycle)
        displayObject.x = value.x
        displayObject.y = value.y
    end,
    
    getParams = function(displayObject, params) 
        local params = params or {}               
        
        params.static = false
        
        return params
    end,
    
    cancelWhen = function(displayObject, params)
        return not displayObject.x
    end    
}