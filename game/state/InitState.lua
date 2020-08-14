local GameState = require("engine.state.GameState")

local Ball = require("game.object.Ball")
local Player = require("game.object.Player")
local Wall = require("game.object.Wall")
local Goal = require("game.object.Goal")

local InitState = GameState:new()

function InitState:new(state, stateMachine)
    state = state or GameState:new(state, stateMachine)

    setmetatable(state, self)
    self.__index = self

    return state
end

function InitState:update(game, dt)
    game.world = love.physics.newWorld(0, 0, true)

    local window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    game.objects = {}

    game.objects.ball = Ball:new(
        nil,
        game.world,
        window.width / 2, window.height / 2,
        5)

    local initialVelocity = 256
    game.objects.ball.body:setLinearVelocity(initialVelocity, initialVelocity)

    game.objects.player = Player:new(
        nil,
        game.world,
        0, window.height - 40)

    game.objects.right_wall = Wall:new(
        nil,
        game.world,
        window.width, 0,
        window.width, window.height)
    game.objects.left_wall = Wall:new(
        nil,
        game.world,
        0, 0,
        0, window.height)
    game.objects.top_wall = Wall:new(
        nil,
        game.world,
        0, 0,
        window.width, 0)
    game.objects.bottom_wall = Goal:new(
        nil,
        game.world,
        0, window.height,
        window.width, window.height)

    self.stateMachine:transitionTo("play")
end

function InitState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function InitState:keyreleased(game, key, scancode)
    return
end

return InitState