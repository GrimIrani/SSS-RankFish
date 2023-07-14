-- Flappy fish Love2D

function love.load()
    -- Load assets
    birdImage = love.graphics.newImage("Assets/fish.png")
    pipeImage = love.graphics.newImage("Assets/enemy.png")
    
    -- Game variables
    fish = {
        x = 62,
        y = 250,
        width = birdImage:getWidth(),
        height = birdImage:getHeight(),
        yVelocity = 0,
        gravity = 1000,
        flapHeight = -300
    }
    
    pipes = {}
    pipeSpawnTimer = 0
    pipeInterval = 2
end

function love.update(dt)
    -- fish movement
    fish.yVelocity = fish.yVelocity + fish.gravity * dt
    fish.y = fish.y + fish.yVelocity * dt
    
    -- enemy spawning
    pipeSpawnTimer = pipeSpawnTimer + dt
    if pipeSpawnTimer > pipeInterval then
        spawnPipe()
        pipeSpawnTimer = pipeSpawnTimer - pipeInterval
    end
    
    -- Pipes movement and collision
    for i, enemy in ipairs(pipes) do
        enemy.x = enemy.x - 180 * dt
        
        if checkCollision(fish, enemy) then
            -- Game over condition
            love.load()
        end
        
        if enemy.x < -pipeImage:getWidth() then
            table.remove(pipes, i)
        end
    end
end

function love.draw()
    -- Draw the background
    love.graphics.setBackgroundColor(255, 255, 255)  -- White background

    -- Draw fish
    love.graphics.draw(birdImage, fish.x, fish.y)
    
    -- Draw pipes
    for _, enemy in ipairs(pipes) do
        love.graphics.draw(pipeImage, enemy.x, enemy.y)
    end
end

function love.keypressed(key)
    -- fish flap
    if key == "space" or key == "up" then
        fish.yVelocity = fish.flapHeight
    end
end

function spawnPipe()
    local enemy = {
        x = love.graphics.getWidth(),
        y = love.math.random(200, love.graphics.getHeight() - 200)
    }
    table.insert(pipes, enemy)
end

function checkCollision(a, b)
    return a.x < b.x + pipeImage:getWidth() and
           a.x + fish.width > b.x and
           a.y < b.y + pipeImage:getHeight() and
           a.y + fish.height > b.y
end