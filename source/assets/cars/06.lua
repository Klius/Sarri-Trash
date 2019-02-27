car = {
        name = "Potorrús Meteor",
        description = "it's a car!",
        sprite = love.graphics.newImage("assets/cars/sprites/k-type.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/k-type.png"),64,64),
        skid = "assets/cars/sprites/skid-k-type.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 15,
        acceleration = 30,
        steering = 100,
        brakes = 10,
        driftBoost = 2.2,
        weight = 16,
        previewScale =0.5,
        width = 64,
        height = 64,
        colBox = {
          ox = 5,
          oy = 15,
          h = 34,
          w = 51,
          
        },
        sfx ={
          engine = love.audio.newSource("assets/audio/sfx/meteor.ogg","static")
        }
      }

return car