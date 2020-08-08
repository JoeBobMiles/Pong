-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    -- Create new Box2D World object, with no gravity.
    world = love.physics.newWorld(0, 0, true)

    objects = {} -- A table to store all our game entities.

    -- Create the ball
    objects.ball = {}
    objects.ball.body = love.physics.newBody(
        world,
        window.width / 2, window.height / 2,
        "dynamic")
    objects.ball.shape = love.physics.newCircleShape(5)
    objects.ball.fixture = love.physics.newFixture(
        objects.ball.body,
        objects.ball.shape,
        1) -- Density of 1, may need to be higher...

    -- Create the player
    objects.player.body = love.physics.newBody(
        world,
        0, window.height - 40,
        "kinematic")
    objects.player.shape = love.physics.newRectangleShape(100, 20)
    objects.player.fixture = love.physics.newFixture(
        objects.player.body,
        objects.player.shape,
        1) -- Density of 1, may need to be higher...

    isPaused = false
end

function love.keyreleased(key, scancode)
    if key == "escape"
    then
        love.event.quit()
    elseif key == "space"
    then
        isPaused = not isPaused
    end
end

function love.update(dt)
    if isPaused then return end

    world:update(dt)

    objects.player.body:setX(love.mouse.getX())
end

function love.draw()
    -- Draw ball
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle(
        "fill",
        objects.ball.body:getX(),
        objects.ball.body:getY(),
        objects.ball.shape:getRadius())

    -- Draw player
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon(
        "fill",
        objects.player.body:getWorldPoints(
            objects.player.shape:getPoints()))
end