local Game = require("game.Game")


-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    game = Game:new()
end

function love.keyreleased(key, scancode)
    if key == "escape"
    then
        love.event.quit()
    else
        game:keyreleased(key, scancode)
    end
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end