car = {
        name = "Potorrús Meteor",
        description = "it's a car!",
        sprite = love.graphics.newImage("assets/cars/sprites/type-h.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/type-h.png"),32,32),
        skid = "assets/cars/sprites/skid-fx.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 15,
        acceleration = 30,
        steering = 100,
        brakes = 10,
        driftBoost = 2.2,
      }

return car