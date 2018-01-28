car = {
        name = "Utande FX55",
        description = "it's a car!",
        sprite = love.graphics.newImage("assets/fx.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/fx.png"),32,32),
        frameDuration = 0.1,
        frameCount = 0,
        currentFrame = 0,
        orientation = 0,
        currentSpeed = 0,
        topSpeed = 8,
        acceleration = 5,
        steering = 150,
        brakes = 10,
      }

return car