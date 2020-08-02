-- BoundingBox class
BoundingBox = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
}

function BoundingBox:new(box, x, y, width, height)
    box = box or {}

    setmetatable(box, self)
    self.__index = self

    self.x = x or 0
    self.y = y or 0
    self.width = width or 0
    self.height = height or 0

    return self
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

    box.x = self.x + self.width/2
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
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function love.update(dt)
    ball.x = ball.x + (ball.speed * dt)
    ball.y = ball.y + (ball.speed * dt)

    player.x = love.mouse.getX() - player.width / 2
end