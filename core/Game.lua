local InitState = require("core.state.InitState")
local PlayState = require("core.state.PlayState")
local PauseState = require("core.state.PauseState")
local GameOverState = require("core.state.GameOverState")


-- Game class
local Game = {
    world = nil,
    objects = nil,
    state = InitState:new(),
}

function Game:new(game)
    game = game or {}

    setmetatable(game, self)
    self.__index = self

    return game
end

function Game:update(dt)
    self.state = self.state:update(self, dt)
end

function Game:draw()
    self.state:draw(self)
end

function Game:keyreleased(key, scancode)
    self.state = self.state:keyreleased(self, key, scancode)
end

return Game