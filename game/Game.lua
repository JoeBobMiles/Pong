local GameStateMachine = require("engine.state.GameStateMachine")

local InitState = require("game.state.InitState")
local PlayState = require("game.state.PlayState")
local PauseState = require("game.state.PauseState")
local GameOverState = require("game.state.GameOverState")

-- Game class
local Game = {
    world = nil,
    objects = nil,
    stateMachine = GameStateMachine:new(),
}

function Game:new(game)
    game = game or {}

    setmetatable(game, self)
    self.__index = self

    self.stateMachine:register("init", InitState)
    self.stateMachine:register("play", PlayState)
    self.stateMachine:register("pause", PauseState)
    self.stateMachine:register("gameover", GameOverState)

    self.stateMachine:transitionTo("init")

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