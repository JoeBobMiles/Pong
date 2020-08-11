local State = require("core.state.State")
local TransitionTable = require("core.state.TransitionTable")

-- PlayState class
local PlayState = State:new()

function PlayState:new(state)
    state = state or State:new()

    setmetatable(state, self)
    self.__index = self

    return state
end

function PlayState:update(game, dt)
    game.world:update(dt)

    for name, object in pairs(game.objects)
    do
        object:update(dt)
    end

    return self
end

function PlayState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function PlayState:keyreleased(game, key, scancode)
    if key == "space"
    then
        return TransitionTable:transitionTo("pause")
    else
        return self
    end
end

TransitionTable:register("play", PlayState)
return PlayState