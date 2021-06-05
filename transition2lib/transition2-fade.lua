
return {
    getStartValue = function(displayObject, params)     
        return displayObject.alpha
    end,

    getEndValue = function(displayObject, params)        
        return (params.alpha or displayObject.alpha)
    end,

    onValue = function(displayObject, params, value, isReverseCycle)
        displayObject.alpha = value
    end,
    
    getParams = function(displayObject, params)                 
        params = params or {}
                
        params.delta = false
        params.static = false
        
        return params
    end,
    
    cancelWhen = function(displayObject, params)
        return not displayObject.alpha
    end    
}