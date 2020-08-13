-- StateMachine class
local StateMachine = {
    _transitionTable = {},
    currentState = nil
}

function StateMachine:new(stateMachine)
    stateMachine = stateMachine or {}

    setmetatable(stateMachine, self)
    self.__index = self

    return stateMachine
end

function StateMachine:register(stateName, prototype)
    if self._transitionTable[stateName] == nil
    then
        self._transitionTable[stateName] = prototype
        return true
    else
        error(
            "A state with name '" .. stateName .. "' is already registered.", 2)
        return false
    end
end

function StateMachine:transitionTo(stateName)
    local prototype = self._transitionTable[stateName]

    if prototype ~= nil
    then
        currentState = prototype:new()
    else
        error("State '" .. stateName .. "' is not registered", 2)
        return nil
    end
end

return StateMachine