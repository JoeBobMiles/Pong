local GameState = require("engine.state.GameState")

-- PlayState class
local PlayState = GameState:new()

function PlayState:new(state, stateMachine)
    state = state or GameState:new(state, stateMachine)

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

local function isPlayer(fixture)
    return fixture:getUserData() == "Player"
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
            self.stateMachine:transitionTo("gameover") 
        elseif
            (isBall(fixtureA) and isPlayer(fixtureB)
            or isPlayer(fixtureA) and isBall(fixtureB))
            and contact:isTouching()
        then
            game.score = game.score + 1
        end
    end
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
        self.stateMachine:transitionTo("pause")
    end
end

return PlayState