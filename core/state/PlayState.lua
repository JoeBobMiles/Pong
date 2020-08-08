local State = require("State")

local PlayState = {}

function PlayState:new(state)
    state = state or State:new()

    setmetatable(state, self)
    self.__index = self

    return state
end

return PlayState