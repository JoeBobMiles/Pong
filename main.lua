
function love.load()
    love.window.setTitle("🏓PONG")

    window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    ball = {
        speed = 40,
        x = window.width / 2,
        y = window.height / 2,
    }

    player = {
        width = 100,
        x = love.mouse.getX() - player.width / 2,
        y = window.height - 40,
    }
end

function love.draw()
    love.graphics.circle("fill", ball.x, ball.y, 5)
    love.graphics.rectangle("fill", player.x, player.y, 100, 20)
end

function love.update(dt)
    ball.x = ball.x + (ball.speed * dt)
    ball.y = ball.y + (ball.speed * dt)

    player.x = love.mouse.getX() - player.width / 2
    player.y = window.height - 40
end