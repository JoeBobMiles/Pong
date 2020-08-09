local State = require("core.state.State")

local PlayState = {}

function PlayState:new(state)
    state = state or State:new()

    setmetatable(state, self)
    self.__index = self

    return state
end

function PlayState:update(game, dt)
    if game.isPaused then return self end

    game.world:update(dt)

    for name, object in pairs(game.objects)
    do
        object:update(dt)
    end

    return self
end

return PlayState