-- Flappy fish Love2D

function love.load()
    -- Load assets
    birdImage = love.graphics.newImage("Assets/fish.png")
    pipeImage = love.graphics.newImage("Assets/enemy.png")
    
    -- Game variables
    fish = {
        x = 62,
        y = 250,
        width = birdImage:getWidth() - 20,  -- Adjusted collision box width
        height = birdImage:getHeight() - 20,  -- Adjusted collision box height
        velocity = 0,
        gravity = 1000,
        flapHeight = -300,
        rotation = 0
    }
    
    pipes = {}
    pipeSpawnTimer = 0
    pipeInterval = 2
end

function love.update(dt)
    -- fish movement
    fish.velocity = fish.velocity + fish.gravity * dt
    fish.y = fish.y + fish.velocity * dt
    
    -- Rotate fish based on velocity and angle of ascent/descent
    fish.rotation = math.rad(fish.velocity * 0.1) -- Adjust the rotation factor as desired
    
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

    -- Draw fish with rotation
    love.graphics.draw(birdImage, fish.x, fish.y, fish.rotation, 1, 1, fish.width / 2, fish.height / 2)
    
    -- Draw pipes
    for _, enemy in ipairs(pipes) do
        love.graphics.draw(pipeImage, enemy.x, enemy.y)
    end
end

function love.keypressed(key)
    -- fish flap
    if key == "space" or key == "up" then
        fish.velocity = fish.flapHeight
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
    return a.x + a.width > b.x + 20 and
           a.x < b.x + pipeImage:getWidth() - 0 and
           a.y + a.height > b.y + 20 and
           a.y < b.y + pipeImage:getHeight() - 0
end