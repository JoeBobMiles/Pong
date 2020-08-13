local State = require("core.state.State")

-- PauseState class
local PauseState = State:new()

function PauseState:new(state, stateMachine)
    state = state or State:new(state, stateMachine)

    setmetatable(state, self)
    self.__index = self

    return state
end

function PauseState:update(game, dt)
    return self
end

function PauseState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function PauseState:keyreleased(game, key, scancode)
    if key == "space"
    then
        return self.stateMachine:transitionTo("play")
    else
        return self
    end
end

return PauseState