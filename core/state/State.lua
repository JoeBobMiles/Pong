-- State class
local State = {}

function State:new(state)
    state = state or {}

    setmetatable(state, self)
    self.__index = self

    return state
end

function State:transition(game)
    error("State:transition() is not implemented", 2)
end

return State