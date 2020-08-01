
function love.load()
    love.window.setTitle("🏓PONG")

    speed = 40
    x = 0
    y = 0
end

function love.draw()
    love.graphics.circle("fill", x, y, 5)
end

function love.update(dt)
    x = x + (speed * dt)
    y = y + (speed * dt)
end