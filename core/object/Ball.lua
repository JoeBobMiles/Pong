local GameObject = require("core.object.GameObject")

-- Ball class
local Ball = GameObject:new()

function Ball:new(ball, world, x, y, radius)
    ball = ball or GameObject:new()

    setmetatable(ball, self)
    self.__index = self

    ball.body = love.physics.newBody(world, x, y, "dynamic")
    ball.shape = love.physics.newCircleShape(radius)
    ball.fixture = love.physics.newFixture(
        ball.body,
        ball.shape,
        1)

    ball.fixture:setRestitution(1)
    ball.fixture:setFriction(0)

    ball.fixture:setUserData("Ball")

    return ball
end

function Ball:update(dt)
    print(self.body:getX(), self.body:getY())
end

function Ball:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle(
        "fill",
        self.body:getX(),
        self.body:getY(),
        self.shape:getRadius())
end

return Ball