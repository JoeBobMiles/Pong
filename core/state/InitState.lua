local State = require("core.state.State")
local TransitionTable = require("core.state.TransitionTable")

local Ball = require("core.object.Ball")
local Player = require("core.object.Player")
local Wall = require("core.object.Wall")
local Goal = require("core.object.Goal")

local InitState = State:new()

function InitState:new(state)
    state = state or State:new()

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

    local initialForce = 1200
    game.objects.ball.body:applyForce(initialForce, initialForce)

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

    return TransitionTable:transitionTo("play")
end

function InitState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function InitState:keyreleased(game, key, scancode)
    return self
end

TransitionTable:register("init", InitState)
return InitState