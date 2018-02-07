gameStates = {}
gameStates.carSelect = {
  bindings = {
      enterRace = function()
                    player.car = carlist.cars[carlist.selectedCar]
                    race:reset()
                    state = gameStates.gameLoop
                  end,
      changeCarMin = function()
                        carlist:changeSelectedCar(-1)
                      end,
      changeCarPl = function()
                        carlist:changeSelectedCar(1)                    
                    end,
      back = function()
                state = gameStates.mapSelect
              end
  },
  keys = {
      space     = "enterRace",
      left         = "changeCarMin",
      right       = "changeCarPl",
      escape = "back"
  },
  keysReleased = {},
  buttons = {
      start = "enterRace",
      dpleft   = "changeCarMin",
      dpright = "changeCarPl",
      a    = "backToGame",
      y = "quit"
  },
  buttonsReleased = {},
  
}
gameStates.mapSelect = {
      bindings = {
          selectCar = function()  
                        maplist:loadMap() 
                        state = gameStates.carSelect 
                        end,
          changeMapMin = function() maplist:changeSelectedMap(-1) end,
          changeMapPl = function() maplist:changeSelectedMap(1) end,
          select     = function()  end,
          quit       = function() love.event.quit() end,
      },
      keys = {
          space     = "selectCar",
          left         = "changeMapMin",
          right       = "changeMapPl",
          ["return"] = "select",
          escape = "quit"
      },
      keysReleased = {},
      buttons = {
          start = "selectCar",
          dpleft   = "changeMapMin",
          dpright = "changeMapPl",
          a    = "selectCar",
          y = "quit"
      },
      buttonsReleased = {},
      -- <...>
  }
  gameStates.gameLoop = {
      bindings = {
          openMenu   = function()  state = gameStates.mapSelect  end,
          gas       = function() player.accelerating = true end,
          releaseGas       = function() player.accelerating = false end,
          rotateLeft       = function() player.rotatingLeft = true end,
          rotateRight      = function() player.rotatingRight = true end,
          releaseRotateLeft       = function() player.rotatingLeft = false end,
          releaseRotateRight      = function() player.rotatingRight = false end,
          brake      = function() player.braking = true end,
          releaseBrake      = function() player.braking = false end,
          reloadMap         = function() 
                                maplist:loadMap()
                              end,
          debug = function() 
                    if debug then 
                      debug = false
                    else
                      debug = true
                    end 
                  end
          
      },
      keys = {
          escape = "openMenu",
          space = "gas",
          left   = "rotateLeft",
          right  = "rotateRight",
          x = "brake",
          d = "debug"
      },
      keysReleased = {
        space = "releaseGas",
        x       = "releaseBrake",
        left  = "releaseRotateLeft",
        right = "releaseRotateRight",
      },
      buttons = {
          start    = "openMenu",
          a       = "gas",
          x       = "brake",
          dpleft  = "rotateLeft",
          dpright = "rotateRight",
          back    = "reloadMap"
      },
      buttonsReleased = {
        a = "releaseGas",
        x       = "releaseBrake",
        dpleft  = "releaseRotateLeft",
        dpright = "releaseRotateRight",
      }
      -- <...>
  }
    gameStates.resultScreen = {
      bindings = {
          returnToStartScreen   = function()  state = gameStates.mapSelect  end
      },
      keys = {
          escape = "returnToStartScreen",
          space = "returnToStartScreen",
          left   = "returnToStartScreen",
          right  = "returnToStartScreen",
          x = "returnToStartScreen",
          d = "returnToStartScreen"
      },
      keysReleased = {
      },
      buttons = {
          start    = "returnToStartScreen",
          a       = "returnToStartScreen",
          x       = "returnToStartScreen",
          dpleft  = "returnToStartScreen",
          dpright = "returnToStartScreen",
          back    = "returnToStartScreen"
      },
      buttonsReleased = {
      }
      -- <...>
  }