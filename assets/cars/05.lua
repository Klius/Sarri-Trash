car = {
        name = "Encorreur Mice",
        description = "",
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
        previewScale = 1,
        weight = 128,
        width = 32,
        height = 32,
        colBox = {
          ox = 1,
          oy = 1,
          h = 29,
          w = 29,
          
        },
        sfx ={
          engine = love.audio.newSource("assets/audio/sfx/idle.ogg","static")
        }
      }

return car