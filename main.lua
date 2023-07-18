-- main.lua
require("assets")
require("fish")
require("pipes")
require("camera")

function love.load()
    -- Empty
end

function love.update(dt)
    updateFish(dt)
    updatePipes(dt)
    if cameraFocus then
        updateCamera(fish, love.graphics.getWidth(), love.graphics.getHeight())
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