local PlayState = require("core.state.PlayState")

local Ball = require("core.object.Ball")
local Player = require("core.object.Player")
local Wall = require("core.object.Wall")
local Goal = require("core.object.Goal")


-- Game class
local Game = {
    world = nil,
    objects = nil,
    state = nil,
    isPaused = false,
}

function Game:new(game)
    game = game or {}

    setmetatable(game, self)
    self.__index = self

    return game
end

function Game:init()
    self.state = PlayState:new()

    self.world = love.physics.newWorld(0, 0, true)
    self.world:setCallbacks(beginContact, nil, nil, nil)

    local window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    self.objects = {}

    self.objects.ball = Ball:new(
        nil,
        self.world,
        window.width / 2, window.height / 2,
        5)

    local initialForce = 12800
    self.objects.ball.body:applyForce(initialForce, initialForce)

    self.objects.player = Player:new(
        nil,
        self.world,
        0, window.height - 40)

    self.objects.right_wall = Wall:new(
        nil,
        self.world,
        window.width, 0,
        window.width, window.height)
    self.objects.left_wall = Wall:new(
        nil,
        self.world,
        0, 0,
        0, window.height)
    self.objects.top_wall = Wall:new(
        nil,
        self.world,
        0, 0,
        window.width, 0)
    self.objects.bottom_wall = Goal:new(
        nil,
        self.world,
        0, window.height,
        window.width, window.height)

    self.isPaused = false
end

function Game:update(dt)
    self.state = self.state:update(self, dt)
end

function Game:draw()
    for name, object in pairs(self.objects)
    do
        object:draw()
    end
end

return Game