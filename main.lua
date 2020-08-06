-- BoundingBox class
BoundingBox = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
}

function BoundingBox:new(box)
    box = box or {}

    setmetatable(box, self)
    self.__index = self

    box.top = box.y
    box.bottom = box.y + box.height
    box.left = box.x
    box.right = box.x + box.width

    return box
end

function BoundingBox:isCollidingWith(box)
    return
        -- Check horizontal overlap
        ((self.left <= box.left and box.left <= self.right)
            or (box.left <= self.left and self.left <= box.right))
        and
        -- Check vertical overlap
        ((self.top <= box.top and box.top <= self.bottom)
            or (box.top <= self.top and self.top <= box.bottom))
end

-- Player class
Player = {
    width = 100,
    height = 20,
    x = 0,
    y = 0,
}

function Player:new(player)
    player = player or {}

    setmetatable(player, self)
    self.__index = self

    return player
end

function Player:boundingBox()
    return BoundingBox:new{
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height,
    }
end

-- Ball class
Ball = {
    x = 0,
    y = 0,
    radius = 5,
    speed = 40,
}

function Ball:new(ball)
    ball = ball or {}

    setmetatable(ball, self)
    self.__index = self

    return ball
end

function Ball:boundingBox()
    return BoundingBox:new{
        -- The ball's x and y are the center of the circle drawn by love. We
        -- have to translate that position to the top-left corner for
        -- BoundingBox.
        x = self.x - self.radius,
        y = self.y - self.radius,
        width = self.radius * 2,
        height = self.radius * 2,
    }
end

-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    ball = Ball:new{
        x = window.width/2,
        y = window.height/2,
        radius = 5,
    }

    player = Player:new{
        x = 0,
        y = window.height - 40,
    }

    isPaused = false
end

function love.draw()
    if ball:boundingBox():isCollidingWith(player:boundingBox())
    then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(1, 1, 1)
    end

    -- Draw ball
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    -- Draw ball's bounding box
    ballBoundingBox = ball:boundingBox()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "line",
        ballBoundingBox.x,
        ballBoundingBox.y,
        ballBoundingBox.width,
        ballBoundingBox.height)


    -- Draw player
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    -- Draw player's bounding box
    playerBoundingBox = player:boundingBox()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "line",
        playerBoundingBox.x,
        playerBoundingBox.y,
        playerBoundingBox.width,
        playerBoundingBox.height)
end

function love.update(dt)
    if isPaused then return end

    ball.x = ball.x + (ball.speed * dt)
    ball.y = ball.y + (ball.speed * dt)

    player.x = love.mouse.getX() - player.width / 2

    if ball:boundingBox():isCollidingWith(player:boundingBox())
    then
        ball.speed = -ball.speed
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