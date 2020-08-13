local StateMachine = require("engine.state.StateMachine")

local InitState = require("core.state.InitState")
local PlayState = require("core.state.PlayState")
local PauseState = require("core.state.PauseState")
local GameOverState = require("core.state.GameOverState")

-- GameStateMachine class
local GameStateMachine = StateMachine:new()

function GameStateMachine:new(stateMachine)
    stateMachine = stateMachine or StateMachine:new()

    setmetatable(stateMachine, self)
    self.__index = self

    self:register("init", InitState)
    self:register("play", PlayState)
    self:register("pause", PauseState)
    self:register("gameover", GameOverState)

    self:transitionTo("init")

    return stateMachine
end

function GameStateMachine:update(game, dt)
    self.currentState = self.currentState:update(game, dt)
end

function GameStateMachine:draw(game)
    self.currentState:draw(game)
end

function GameStateMachine:keyreleased(game, key, scancode)
    self.currentState = self.currentState:keyreleased(game, key, scancode)
end

return GameStateMachine