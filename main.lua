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
    box = BoundingBox:new()

    box.x = self.x
    box.y = self.y

    box.width = self.width
    box.height = self.height

    return box
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
    box = BoundingBox:new()

    -- The ball's x and y are the center of the circle drawn by love. We have to
    -- translate that position to the top-left corner for BoundingBox.
    box.x = self.x - self.radius
    box.y = self.y - self.radius
    box.height = self.radius * 2
    box.width = self.radius * 2

    return box
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
end

function love.draw()
    if ball:boundingBox():isCollidingWith(player:boundingBox())
    then
        love.graphics.print(
            "COLLISION!",
            window.height / 2,
            window.width / 2)

        love.graphics.setColor(1, 0, 0)
    end

    -- Draw ball
    love.graphics.setColor(1, 1, 1)
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
    ball.x = ball.x + (ball.speed * dt)
    ball.y = ball.y + (ball.speed * dt)

    player.x = love.mouse.getX() - player.width / 2
end