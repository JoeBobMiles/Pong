local State = require("core.state.State")
local TransitionTable = require("core.state.TransitionTable")

-- PauseState class
local PauseState = State:new()

function PauseState:new(state)
    state = state or State:new()

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
        return TransitionTable:transitionTo("play")
    else
        return self
    end
end

TransitionTable:register("pause", PauseState)
return PauseState