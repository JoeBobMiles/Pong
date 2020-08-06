-- BoundingBox class
BoundingBox = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
}

function BoundingBox:new(box)
    box = box or {}

    setmetatable(box, self)
    self.__index = self

    box.top = box.y
    box.bottom = box.y + box.height
    box.left = box.x
    box.right = box.x + box.width

    return box
end

function BoundingBox:isHorizontallyCollidingWith(box)
    return 
        ((self.left <= box.left and box.left <= self.right)
        or (box.left <= self.left and self.left <= box.right))
end

function BoundingBox:isVerticallyCollidingWith(box)
    return
        ((self.top <= box.top and box.top <= self.bottom)
        or (box.top <= self.top and self.top <= box.bottom))
end

function BoundingBox:isCollidingWith(box)
    return
        self:isHorizontallyCollidingWith(box)
        and self:isVerticallyCollidingWith(box)
end

function BoundingBox:collisionVectorWith(box)
    if not self:isCollidingWith(box) then return nil end

    local selfCenter = Vector2:new{
        x = (self.left + self.right) / 2,
        y = (self.top + self.bottom) / 2,
    }

    local boxCenter = Vector2:new{
        x = (box.left + box.right) / 2,
        y = (box.top + box.bottom) / 2,
    }

    return Vector2:new{
        x = boxCenter.x - selfCenter.x,
        y = boxCenter.y - selfCenter.y,
    }
end

-- Vector2 class
Vector2 = {
    x = 0,
    y = 0,
}

function Vector2:new(vector)
    vector = vector or {}

    setmetatable(vector, self)
    self.__index = self

    return vector
end

function Vector2:magnitude()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2:normalize()
    local magnitude = self:magnitude()

    return Vector2:new{
        x = self.x / magnitude,
        y = self.y / magnitude,
    }
end

-- Player class
Player = {
    position = Vector2:new{
        x = 0,
        y = 0
    },
    width = 100,
    height = 20,
}

function Player:new(player)
    player = player or {}

    setmetatable(player, self)
    self.__index = self

    return player
end

function Player:boundingBox()
    return BoundingBox:new{
        x = self.position.x,
        y = self.position.y,
        width = self.width,
        height = self.height,
    }
end

-- Ball class
Ball = {
    position = Vector2:new{
        x = 0,
        y = 0,
    },
    velocity = Vector2:new{
        x = 100,
        y = 100,
    },
    radius = 5,
}

function Ball:new(ball)
    ball = ball or {}

    setmetatable(ball, self)
    self.__index = self

    return ball
end

function Ball:boundingBox()
    return BoundingBox:new{
        -- The ball's x and y are the center of the circle drawn by love. We
        -- have to translate that position to the top-left corner for
        -- BoundingBox.
        x = self.position.x - self.radius,
        y = self.position.y - self.radius,
        width = self.radius * 2,
        height = self.radius * 2,
    }
end

-- Game code
function love.load()
    love.window.setTitle("🏓PONG")

    window = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
    }

    ball = Ball:new{
        position = Vector2:new{
            x = window.width/2,
            y = window.height/2,
        },
        radius = 5,
    }

    player = Player:new{
        position = Vector2:new{
            x = 0,
            y = window.height - 40,
        }
    }

    isPaused = false
end

function love.draw()
    local playerBoundingBox = player:boundingBox()
    local ballBoundingBox = ball:boundingBox()

    love.graphics.setColor(1, 1, 1)
    -- Draw ball
    love.graphics.circle(
        "fill",
        ball.position.x,
        ball.position.y,
        ball.radius)
    -- Draw ball's bounding box
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "line",
        ballBoundingBox.x,
        ballBoundingBox.y,
        ballBoundingBox.width,
        ballBoundingBox.height)


    -- Draw player
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle(
        "fill",
        player.position.x,
        player.position.y,
        player.width,
        player.height)
    -- Draw player's bounding box
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "line",
        playerBoundingBox.x,
        playerBoundingBox.y,
        playerBoundingBox.width,
        playerBoundingBox.height)

    if ballBoundingBox:isCollidingWith(playerBoundingBox)
    then
        local collisionVector =
            ballBoundingBox:collisionVectorWith(playerBoundingBox)

        love.graphics.setColor(1,1,1,0.5)
        love.graphics.print(
            string.format(
                "Collision vector: [%d, %d]",
                collisionVector.x,
                collisionVector.y),
            0, 0)

        love.graphics.setColor(0,1,0)
        love.graphics.line(
            ball.position.x,
            ball.position.y,
            ball.position.x + collisionVector.x,
            ball.position.y + collisionVector.y)

        isPaused = true
    end
end

function love.update(dt)
    if isPaused then return end

    ball.position.x = ball.position.x + (ball.velocity.x * dt)
    ball.position.y = ball.position.y + (ball.velocity.y * dt)

    player.position.x = love.mouse.getX() - player.width / 2

    local playerBoundingBox = player:boundingBox()
    local ballBoundingBox = ball:boundingBox()

    if ballBoundingBox:isCollidingWith(playerBoundingBox)
    then
        local collisionVector =
            ballBoundingBox:collisionVectorWith(playerBoundingBox)

        if collisionVector.x ~= 0
        then
            ball.velocity.x = -ball.velocity.x
        end

        if collisionVector.y ~= 0
        then
            ball.velocity.y = -ball.velocity.y
        end
    end
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