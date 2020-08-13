local GameState = require("engine.state.GameState")

-- PauseState class
local PauseState = GameState:new()

function PauseState:new(state, stateMachine)
    state = state or GameState:new(state, stateMachine)

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