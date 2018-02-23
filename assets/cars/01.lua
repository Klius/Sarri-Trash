 car = {
        name = "Richie The Cat",
        description = "it's a cat!",
        sprite = love.graphics.newImage("assets/richie-grey.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/richie-grey.png"),32,32),
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 12,
        acceleration = 10,
        steering = 100,
        brakes = 10,
      }

return car