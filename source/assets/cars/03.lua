car = {
        name = "A-Eccles Sdrawkcab",
        description = "In a bold stylistic move, scandinavian chair maker A-Eccles designed and manufactered the first car that drives backwards.\nOnly 2 units out of 10000 were sold, the fact that you had to look all the time into the rear-view mirror didn't make it more popular...\nPressing the brake will accelerate and flooring the accelerator will brake it.",
        sprite = love.graphics.newImage("assets/cars/sprites/sdrawkcab.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/sdrawkcab.png"),32,32),
        skid = "assets/cars/sprites/skid-sdrawkcab.png",
        frameDuration = 0.1,
        frameCount = 0,
        currentFrame = 0,
        orientation = 0,
        currentSpeed = 0,
        topSpeed = 9,
        acceleration = -5,
        steering = 150,
        brakes = -10,
        driftBoost = 1.5,
        weight = 32,
        previewScale =1,
        width = 32,
        height = 32,
        colBox = {
          ox = 1,
          oy = 4,
          w = 29,
          h = 28,
        },
        sfx ={
          engine = love.audio.newSource("assets/audio/sfx/idle.ogg","static")
        }
      }

return car