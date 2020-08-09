local GameObject = require("core.object.GameObject")

-- Player class
local Player = GameObject:new()

function Player:new(player, world, x, y)
    player = player or GameObject:new()

    setmetatable(player, self)
    self.__index = self

    player.body = love.physics.newBody(world, x, y, "kinematic")
    player.shape = love.physics.newRectangleShape(100, 10)
    player.fixture = love.physics.newFixture(
        player.body,
        player.shape,
        1)

    return player
end

function Player:update()
    self.body:setX(love.mouse.getX())
end

function Player:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon(
        "fill",
        self.body:getWorldPoints(
            self.shape:getPoints()))
end

return Player