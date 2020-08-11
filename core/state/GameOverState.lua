local State = require("core.state.State")
local TransitionTable = require("core.state.TransitionTable")

local GameOverState = State:new()

function GameOverState:new(state)
    state = state or State:new()

    setmetatable(state, self)
    self.__index = self

    return state
end

function GameOverState:update(game, dt)
    return self
end

function GameOverState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function GameOverState:keyreleased(game, key, scancode)
    return self
end

TransitionTable:register("gameover", GameOverState)
return GameOverState
