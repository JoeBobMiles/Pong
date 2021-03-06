local GameObject = require("engine.object.GameObject")
local Wall = require("game.object.Wall")

-- Goal class
local Goal = GameObject:new()

function Goal:new(goal, world, x1, y1, x2, y2)
    goal = goal or Wall:new(nil, world, x1, y1, x2, y2)

    setmetatable(goal, self)
    self.__index = self

    goal.fixture:setUserData("Goal")
end

return Goal