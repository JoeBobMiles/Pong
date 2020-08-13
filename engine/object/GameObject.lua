-- GameObject class
local GameObject = {
    body = nil,
    shape = nil,
    fixture = nil,
}

function GameObject:new(object, body, shape, fixture)
    object = object or {}

    setmetatable(object, self)
    self.__index = self

    body = body or nil
    shape  = shape or nil
    fixture = fixture or nil

    return object
end

function GameObject:update()
    error("GameObject:update() is not implemented", 2)
end

function GameObject:draw(dt)
    error("GameObject:draw() is not implemented", 2)
end

return GameObject