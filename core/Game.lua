-- Game class
local Game = {
    world = nil,
    objects = nil,
}

function Game:new(game)
    game = game or {}

    setmetatable(game, self)
    self.__index = self

    return game
end

return Game