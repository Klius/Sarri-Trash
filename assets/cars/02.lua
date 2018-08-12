car = {
        name = "Utande Interceptor",
        description = "it's a car!",
        sprite = love.graphics.newImage("assets/cars/sprites/fx.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/fx.png"),32,32),
        skid = "assets/cars/sprites/skid-fx.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 11,
        acceleration = 5,
        steering = 150,
        brakes = 7,
        driftBoost = 1.3,
        weight = 32,
        previewScale =1,
        width = 32,
        height = 32,
        colBox = {
          ox = 2,
          oy = 2,
          w = 27,
          h = 27,
        },
        sfx ={
          engine = love.audio.newSource("assets/audio/sfx/idle.ogg","static")
        }
      }

return car