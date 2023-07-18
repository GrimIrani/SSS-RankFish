-- main.lua
require("assets")
require("fish")
require("pipes")

function love.load()
    -- Game variables
    camera = {
        x = -100,
        y = 0
    }
    cameraFocus = false
end

function love.update(dt)
    updateFish(dt)
    updatePipes(dt)
    -- Camera movement
    if cameraFocus then
        camera.x = fish.x - love.graphics.getWidth() / 2
        camera.y = fish.y - love.graphics.getHeight() / 2
    end
end

function love.draw()
    love.graphics.translate(-camera.x, -camera.y)
    love.graphics.setBackgroundColor(255, 255, 255)
    drawFish()
    drawPipes()
    love.graphics.origin()
end

function love.keypressed(key)
    fishKeyPressed(key)
end