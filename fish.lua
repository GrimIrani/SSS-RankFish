-- fish.lua
fish = {
    x = 62,
    y = 250,
    width = birdImage:getWidth() - 20,
    height = birdImage:getHeight() - 20,
    velocity = 0,
    gravity = 1000,
    flapHeight = -300,
    rotation = 0
}

function updateFish(dt)
    fish.velocity = fish.velocity + fish.gravity * dt
    fish.y = fish.y + fish.velocity * dt

    fish.rotation = math.rad(fish.velocity * 0.1)
end

function drawFish()
    love.graphics.draw(birdImage, fish.x, fish.y, fish.rotation, 1, 1, fish.width / 2, fish.height / 2)
end

function fishKeyPressed(key)
    if key == "space" or touch_pressed then
        fish.velocity = fish.flapHeight
    elseif key == "v" then
        cameraFocus = not cameraFocus
    end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    -- Set touch_pressed to true when a touch event occurs
    touch_pressed = true
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    -- Set touch_pressed to false when a touch event ends
    touch_pressed = false
end