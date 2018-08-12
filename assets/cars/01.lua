 car = {
        name = "Richie The Cat",
        description = "it's a cat!",
        sprite = love.graphics.newImage("assets/cars/sprites/richie-grey.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/richie-grey.png"),32,32),
        skid = "assets/cars/sprites/skid-richie.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 12,
        acceleration = 10,
        steering = 100,
        brakes = 10,
        driftBoost = 2,
        weight = 32,
        previewScale =1,
        width = 32,
        height = 32,
        colBox = {
          ox = 0,
          oy = 0,
          w = 32,
          h = 32,
        },
        sfx ={
          engine = love.audio.newSource("assets/audio/sfx/richie.ogg","static")
        }
      }

return car