car = {
        name = "Encorreur Mice",
        description = "it's a car!",
        sprite = love.graphics.newImage("assets/cars/sprites/scarab.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/scarab.png"),32,32),
        skid = "assets/cars/sprites/skid-scarab.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 12,
        acceleration = 8,
        steering = 150,
        brakes = 0.5,
        driftBoost = 1.5,
        weight = 128
      }

return car