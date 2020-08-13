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

    -- HACK: When this function updates, the initial dt is incredibly small,
    -- which means the force applied to the ball is applied over an incredibly
    -- small period of time. By applying it over the (approximately) same amount
    -- of time as the average mid-game frame, we get a ball that travels at a
    -- consistent speed.
    game.world:update(0.017)

    return self.stateMachine:transitionTo("play")
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

return InitState