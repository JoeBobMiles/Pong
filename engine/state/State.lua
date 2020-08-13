-- State class
local State = {
    stateMachine = nil,
}

function State:new(state, stateMachine)
    state = state or {}

    setmetatable(state, self)
    self.__index = self

    self.stateMachine = stateMachine

    return state
end

function State:transitionTo(stateName)
    return self.stateMachine:transitionTo(stateName)
end

return State