car = {
        name = "GreenValley Type-H",
        description = "What do you get if you lock a room full of engineers obsessed with mechanical cogs?\nThe Type-H is the answer to that question, boosting a motor powering an omnidirectional cog-wheel, the traction is superb but steering it is another thing...",
        sprite = love.graphics.newImage("assets/cars/sprites/type-h.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/type-h.png"),32,32),
        skid = "assets/cars/sprites/skid-type-h.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 10,
        acceleration = 20,
        steering = 80,
        brakes = 8,
        driftBoost = 2.6,
        weight = 32,
        previewScale = 1 ,
        width = 32,
        height = 32,
        colBox = {
          ox = 0,
          oy = 4,
          h = 23,
          w = 32,
          
        },
        sfx ={
          engine = love.audio.newSource("assets/audio/sfx/idle.ogg","static")
        }
      }

return car