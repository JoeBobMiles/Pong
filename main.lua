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

function BoundingBox:new(box, x, y, width, height)
    box = box or {}

    setmetatable(box, self)
    self.__index = self

    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0

    self.top = self.y
    self.bottom = self.y + self.height
    self.left = self.x
    self.right = self.x + self.width

    return self
end

function BoundingBox:isCollidingWith(box)
    return
        -- Check horizontal overlap
        ((self.left < box.right and box.left < self.left)
        or (self.right < box.right and box.left < self.right))
        and
        -- Check vertical overlap
        ((self.top < box.bottom and box.top < self.top)
        or (self.bottom < box.bottom and box.top < self.bottom))
end

-- Player class
Player = {
    width = 100,
    height = 20,
    x = 0,
    y = 0,
}

function Player:new(player, x, y)
    player = player or {}

    setmetatable(player, self)
    self.__index = self

    self.width = 100
    self.height= 20

    self.x = x or 0
    self.y = y or 0

    return player
end

function Player:boundingBox()
    return BoundingBox:new(
        nil,
        self.x,
        self.y,
        self.width,
        self.height)
end

-- Ball class
Ball = {
    x = 0,
    y = 0,
    radius = 5,
    speed = 40,
}

function Ball:new(ball, x, y, radius)
    ball = ball or {}

    setmetatable(ball, self)
    self.__index = self

    self.x = x or 0
    self.y = y or 0
    self.radius = radius or 5
    self.speed = 40

    return ball
end

function Ball:boundingBox()
    return BoundingBox:new(
        nil,
        -- The ball's x and y are the center of the circle drawn by love. We
        -- have to translate that position to the top-left corner for
        -- BoundingBox.
        self.x - self.radius,
        self.y - self.radius,
        self.radius * 2,
        self.radius * 2)
end

-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    ball = Ball:new(
        nil,
        window.width/2,
        window.height/2,
        5)

    player = Player:new(
        nil,
        0,
        window.height - 40)

    isPaused = false
end

function love.draw()
    -- Reset draw color
    love.graphics.setColor(1, 1, 1)

    if ball:boundingBox():isCollidingWith(player:boundingBox())
    then
        love.graphics.setColor(1, 0, 0)
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

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.print(
        string.format(
            "Ball bounding box\n\tTop: %d\tBottom: %d\n\tLeft: %d\tRight %d",
            ballBoundingBox.top,
            ballBoundingBox.bottom,
            ballBoundingBox.left,
            ballBoundingBox.right),
        0, 0)

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

    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.print(
        string.format(
            "Player bounding box\n\tTop: %d\tBottom: %d\n\tLeft: %d\tRight %d",
            playerBoundingBox.top,
            playerBoundingBox.bottom,
            playerBoundingBox.left,
            playerBoundingBox.right),
        0, 50)
end

function love.update(dt)
    if isPaused then return end

    ball.x = ball.x + (ball.speed * dt)
    ball.y = ball.y + (ball.speed * dt)

    player.x = love.mouse.getX() - player.width / 2
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