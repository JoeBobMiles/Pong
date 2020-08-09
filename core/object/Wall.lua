local GameObject = require("core.object.GameObject")

-- (Invisible) Wall class
local Wall = GameObject:new()

function Wall:new(wall, world, x1, y1, x2, y2)
    wall = wall or GameObject:new()

    setmetatable(wall, self)
    self.__index = self

    if not world
    then
        error("World cannot be nil!", 2)
    else
        wall.body = love.physics.newBody(world, x1, y1, "static")
        -- Shape coordinates are relative to body coordinates, so we have to
        -- transform the coordinates passed (absolute, world coordinates) into
        -- coordinates relative to the body position.
        wall.shape = love.physics.newEdgeShape(
            0, 0,
            x2 - x1, y2 - y1)
        wall.fixture = love.physics.newFixture(
            wall.body,
            wall.shape,
            1)
    end

    return wall
end

function Wall:update()
    return
end

function Wall:draw()
    return
end

return Wall