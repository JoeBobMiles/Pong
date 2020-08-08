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

function love.draw()
    local playerBoundingBox = player:boundingBox()
    local ballBoundingBox = ball:boundingBox()

    love.graphics.setColor(1, 1, 1)
    -- Draw ball
    love.graphics.circle(
        "fill",
        ball.position.x,
        ball.position.y,
        ball.radius)
    -- Draw ball's bounding box
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "line",
        ballBoundingBox.x,
        ballBoundingBox.y,
        ballBoundingBox.width,
        ballBoundingBox.height)


    -- Draw player
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle(
        "fill",
        player.position.x,
        player.position.y,
        player.width,
        player.height)
    -- Draw player's bounding box
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "line",
        playerBoundingBox.x,
        playerBoundingBox.y,
        playerBoundingBox.width,
        playerBoundingBox.height)

    if ballBoundingBox:isCollidingWith(playerBoundingBox)
    then
        local collisionVector =
            ballBoundingBox:collisionVectorWith(playerBoundingBox):normalize()

        collisionVector.x = collisionVector.x * 20
        collisionVector.y = collisionVector.y * 20

        love.graphics.setColor(1,1,1,0.5)
        love.graphics.print(
            string.format(
                "Collision vector: [%d, %d]",
                collisionVector.x,
                collisionVector.y),
            0, 0)

        love.graphics.setColor(0,1,0)
        love.graphics.line(
            ball.position.x,
            ball.position.y,
            ball.position.x + collisionVector.x,
            ball.position.y + collisionVector.y)

        isPaused = true
    end
end

function love.update(dt)
    if isPaused then return end

    ball.position.x = ball.position.x + (ball.velocity.x * dt)
    ball.position.y = ball.position.y + (ball.velocity.y * dt)

    player.position.x = love.mouse.getX() - player.width / 2

    local playerBoundingBox = player:boundingBox()
    local ballBoundingBox = ball:boundingBox()

    if ballBoundingBox:isCollidingWith(playerBoundingBox)
    then
        local collisionVector =
            ballBoundingBox:collisionVectorWith(playerBoundingBox)

        if collisionVector.x ~= 0
        then
            ball.velocity.x = -ball.velocity.x
        end

        if collisionVector.y ~= 0
        then
            ball.velocity.y = -ball.velocity.y
        end
    end
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