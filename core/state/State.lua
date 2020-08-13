-- State class
local State = {
    stateMachine = nil,
}

function State:new(state, stateMachine)
    state = state or {}

    setmetatable(state, self)
    self.__index = self

    return state
end

function State:transitionTo(stateName)
    return self.stateMachine:transitionTo(stateName)
end

function State:update(game, dt)
    error("State:update() is not implemented", 2)
end

function State:draw(game)
    error("State:draw() is not implemented", 2)
end

function State:keyreleased(game, key, scancode)
    error("State:keyreleased() is not implemented", 2)
end

return State