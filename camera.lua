camera = {
    x = 0,
    y = 0
}
cameraFocus = false

function updateCamera(fish, screenWidth, screenHeight)
    camera.x = fish.x - screenWidth / 2
    camera.y = fish.y - screenHeight / 2
end