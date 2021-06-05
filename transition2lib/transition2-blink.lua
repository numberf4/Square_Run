
return {
    getStartValue = function(displayObject, params)     
        return 1
    end,

    getEndValue = function(displayObject, params)
        return 0
    end,

    onValue = function(displayObject, params, value, isReverseCycle)
        displayObject.alpha = value
    end,
    
    getParams = function(displayObject, params) 
        local params = params or {}
        
        params.transition = easing.inSine
        params.reverse = false
        params.iterations = 0
        params.iterationDelay = nil
        params.time = params.time or 1000
        params.static = false
        
        return params
    end,
    
    cancelWhen = function(displayObject, params)
        return not displayObject.alpha
    end    
}