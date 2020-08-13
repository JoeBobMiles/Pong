local StateMachine = require("engine.state.StateMachine")

-- GameStateMachine class
local GameStateMachine = StateMachine:new()

function GameStateMachine:new(stateMachine)
    stateMachine = stateMachine or StateMachine:new()

    setmetatable(stateMachine, self)
    self.__index = self

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