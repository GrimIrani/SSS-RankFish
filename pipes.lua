pipes = {}
pipeSpawnTimer = 0
pipeInterval = 2

function updatePipes(dt)
    pipeSpawnTimer = pipeSpawnTimer + dt
    if pipeSpawnTimer > pipeInterval then
        spawnPipe()
        pipeSpawnTimer = pipeSpawnTimer - pipeInterval
    end

    for i, enemy in ipairs(pipes) do
        enemy.x = enemy.x - 180 * dt

        if checkCollision(fish, enemy) then
            love.event.quit("restart")
        end

        if enemy.x < -pipeImage:getWidth() then
            table.remove(pipes, i)
        end
    end
end

function drawPipes()
    for _, enemy in ipairs(pipes) do
        love.graphics.draw(pipeImage, enemy.x, enemy.y)
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