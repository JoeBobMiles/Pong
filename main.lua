local Game = require("core.Game")


-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    game = Game:new()
    game:init()
end

function love.keyreleased(key, scancode)
    game:keyreleased(key, scancode)
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end