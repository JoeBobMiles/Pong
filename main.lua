
function love.load()
    love.window.setTitle("🏓PONG")

    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()

    ball_speed = 40
    ball_x = 0
    ball_y = 0

    player_width = 100
    player_x = love.mouse.getX() - player_width / 2
    player_y = window_height - 40
end

function love.draw()
    love.graphics.circle("fill", ball_x, ball_y, 5)

    love.graphics.rectangle("fill", player_x, player_y, 100, 20)
end

function love.update(dt)
    ball_x = ball_x + (ball_speed * dt)
    ball_y = ball_y + (ball_speed * dt)

    player_x = love.mouse.getX() - player_width / 2
    player_y = window_height - 40
end