local InitState = require("core.state.InitState")
local PlayState = require("core.state.PlayState")
local PauseState = require("core.state.PauseState")
local GameOverState = require("core.state.GameOverState")

local GameStateMachine = require("core.state.GameStateMachine")


-- Game class
local Game = {
    world = nil,
    objects = nil,
    state = InitState:new(),
    stateMachine = GameStateMachine:new(),
}

function Game:new(game)
    game = game or {}

    setmetatable(game, self)
    self.__index = self

    return game
end

function Game:update(dt)
    self.stateMachine:update(self, dt)
end

function Game:draw()
    self.stateMachine:draw(self)
end

function Game:keyreleased(key, scancode)
    self.stateMachine:keyreleased(self, key, scancode)
end

return Game