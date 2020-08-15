local State = require("engine.state.State")

-- GameState object
local GameState = State:new()

function GameState:new(state, stateMachine)
    state = state or State:new(state, stateMachine)

    setmetatable(state, self)
    self.__index = self

    return state
end

function GameState:update(game, dt)
    error("GameState:update() is not implemented", 2)
end

function GameState:draw(game)
    error("GameState:draw() is not implemented", 2)
end

function GameState:keyreleased(game, key, scancode)
    error("GameState:keyreleased() is not implemented", 2)
end

return GameState