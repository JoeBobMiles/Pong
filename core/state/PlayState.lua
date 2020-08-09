local State = require("core.state.State")

local PlayState = State:new()

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

function PlayState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function PlayState:keyreleased(game, key, scancode)
    if key == "escape"
    then
        love.event.quit()
    elseif key == "space"
    then
        game.isPaused = not game.isPaused
    end

    return self
end

return PlayState