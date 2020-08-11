-- TransitionTable class
local TransitionTable = {
    prototypes = {}
}

function TransitionTable:register(stateName, prototype)
    if self.prototypes[stateName] == nil
    then
        self.prototypes[stateName] = prototype
        return true
    else
        error(
            "A state with name '" .. stateName .. "' is already registered.", 2)
        return false
    end
end

function TransitionTable:transitionTo(stateName)
    local prototype = self.prototypes[stateName]

    if prototype ~= nil
    then
        return prototype:new()
    else
        error("State '" .. stateName .. "' is not registered", 2)
        return nil
    end
end

return TransitionTable