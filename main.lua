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

    self.x = (x or 0) - self.width/2
    self.y = y or 0

    return player
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
        love.mouse.getX(),
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