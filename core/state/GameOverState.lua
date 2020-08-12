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

    love.graphics.printf(
        "Game Over!\nPress <Space> to restart.",
        0, love.graphics.getHeight() / 2,
        love.graphics.getWidth(),
        "center")
end

function GameOverState:keyreleased(game, key, scancode)
    if key == "space"
    then
        return TransitionTable:transitionTo("init")
    else
        return self
    end
end

TransitionTable:register("gameover", GameOverState)
return GameOverState
