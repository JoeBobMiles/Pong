local State = require("core.state.State")
local TransitionTable = require("core.state.TransitionTable")

-- PlayState class
local PlayState = State:new()

function PlayState:new(state, stateMachine)
    state = state or State:new(state, stateMachine)

    setmetatable(state, self)
    self.__index = self

    return state
end

local function isBall(fixture)
    return fixture:getUserData() == "Ball"
end

local function isGoal(fixture)
    return fixture:getUserData() == "Goal"
end

function PlayState:update(game, dt)
    game.world:update(dt)

    for name, object in pairs(game.objects)
    do
        object:update(dt)
    end

    for key, contact in pairs(game.world:getContacts())
    do
        fixtureA, fixtureB = contact:getFixtures()

        if isBall(fixtureA) and isGoal(fixtureB)
            or isGoal(fixtureA) and isBall(fixtureB)
        then
            return self.stateMachine:transitionTo("gameover")
        end
    end

    return self
end

function PlayState:draw(game)
    for name, object in pairs(game.objects)
    do
        object:draw()
    end
end

function PlayState:keyreleased(game, key, scancode)
    if key == "space"
    then
        return self.stateMachine:transitionTo("pause")
    else
        return self
    end
end

return PlayState