car = {
        name = "Utande FX55",
        description = "it's a car!",
        sprite = love.graphics.newImage("assets/fx.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/fx.png"),32,32),
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 12,
        acceleration = 5,
        steering = 150,
        brakes = 10,
      }

return car