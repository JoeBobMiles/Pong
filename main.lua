local Game = require("core.Game")
local GameObject = require("core.object.GameObject")

local Ball = require("core.object.Ball")
local Player = require("core.object.Player")


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

-- Goal class
local Goal = GameObject:new()

function Goal:new(goal, world, x1, y1, x2, y2)
    goal = goal or Wall:new(nil, world, x1, y1, x2, y2)

    setmetatable(goal, self)
    self.__index = self

    goal.fixture:setUserData("Goal")
end

-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    game = Game:new()

    local window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    game.world = love.physics.newWorld(0, 0, true)
    game.world:setCallbacks(beginContact, nil, nil, nil)

    game.objects = {}

    game.objects.ball = Ball:new(
        nil,
        game.world,
        window.width / 2, window.height / 2,
        5)

    local initialForce = 12800
    game.objects.ball.body:applyForce(initialForce, initialForce)

    game.objects.player = Player:new(
        nil,
        game.world,
        0, window.height - 40)

    game.objects.right_wall = Wall:new(
        nil,
        game.world,
        window.width, 0,
        window.width, window.height)
    game.objects.left_wall = Wall:new(
        nil,
        game.world,
        0, 0,
        0, window.height)
    game.objects.top_wall = Wall:new(
        nil,
        game.world,
        0, 0,
        window.width, 0)
    game.objects.bottom_wall = Goal:new(
        nil,
        game.world,
        0, window.height,
        window.width, window.height)

    isPaused = false
end

function love.keyreleased(key, scancode)
    if key == "escape"
    then
        love.event.quit()
    elseif key == "space"
    then
        isPaused = not isPaused
    end
end

function love.update(dt)
    if isPaused then return end

    game.world:update(dt)

    for name, object in pairs(game.objects)
    do
        object:update()
    end
end

function love.draw()
    for name, object in pairs(game.objects)
    do
        object:draw()
    end

    love.graphics.setColor(0,1,0)
    love.graphics.circle(
        "fill",
        love.graphics.getWidth() / 2, love.graphics.getHeight() / 2,
        2)
end

-- World Collision Callbacks
function beginContact(a, b, coll)
    if a:getUserData() == "Ball" and b:getUserData() == "Goal"
        or a:getUserData() == "Goal" and b:getUserData() == "Ball"
    then
        love.event.quit()
    end
end