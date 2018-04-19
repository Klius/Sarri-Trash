gameStates = {}
gameStates.carSelect = {
  bindings = {
      enterRace = function()
                    player.car = carlist.cars[carlist.selectedCar]
                    maplist:loadMap()
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
      a    = "enterRace",
      y = "back"
  },
  buttonsReleased = {},
  
}
gameStates.mapSelect = {
      bindings = {
          selectCar = function()  
                        state = gameStates.carSelect 
                        end,
          changeMapMin = function() maplist:changeSelectedMap(-1) end,
          changeMapPl = function() maplist:changeSelectedMap(1) end,
          select     = function()  end,
          back       = function() state = gameStates.mainMenu end,
      },
      keys = {
          space     = "selectCar",
          left         = "changeMapMin",
          right       = "changeMapPl",
          ["return"] = "selectCar",
          escape = "back"
      },
      keysReleased = {},
      buttons = {
          start = "selectCar",
          dpleft   = "changeMapMin",
          dpright = "changeMapPl",
          a    = "selectCar",
          y = "back"
      },
      buttonsReleased = {},
      -- <...>
  }
  gameStates.gameLoop = {
      bindings = {
          openMenu   = function()  state = gameStates.mapSelect  end,
          gas       = function(id)
                        if id == "keyboard" then
                          player.accelerating = true
                        else
                          player2.accelerating = true
                        end
          end,
          releaseGas       = function(id)
            if id == "keyboard" then
              player.accelerating = false 
            else
              player2.accelerating = false 
            end
          end,
          rotateLeft       = function(id)
            if id == "keyboard" then
              player:rotate(true)
            else
              player2:rotate(true)
            end
          end,
          rotateRight      = function(id) 
            if id == "keyboard" then
              player:rotate(false)
            else
              player2:rotate(false)
            end 
          end,
          releaseRotateRight     = function(id)
            if id == "keyboard" then
              player.rotatingRight = false 
            else
              player2.rotatingRight = false
            end 
          end,
          releaseRotateLeft     = function(id)
            if id == "keyboard" then
              player.rotatingLeft = false 
            else
              player2.rotatingLeft = false
            end   
          end,
          brake = function(id)
           if id == "keyboard" then  
              player.braking = true
            else
              player2.braking = true
            end
          end,
          releaseBrake      = function(id)
             if id == "keyboard" then  
              player.braking = false
            else
              player2.braking = false
            end
          end,
          reloadMap         = function() 
                                maplist:loadMap()
                                race:reset()
                              end,
          debug = function() 
                    if debug then 
                      debug = false
                    else
                      debug = true
                    end 
                  end,
          upDriftBoost = function() player.car.driftBoost= player.car.driftBoost+0.1 end,
          downDriftBoost = function() player.car.driftBoost= player.car.driftBoost-0.1 end,
      },
      keys = {
          escape = "openMenu",
          space = "gas",
          left   = "rotateLeft",
          right  = "rotateRight",
		  r = "reloadMap",
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
          y       = "debug",
          dpleft  = "rotateLeft",
          jleft   = "rotateLeft",
          jright   = "rotateRight",
          dpright = "rotateRight",
          --dpup = "upDriftBoost",
         -- dpdown ="downDriftBoost",
          back    = "reloadMap"
      },
      buttonsReleased = {
        a = "releaseGas",
        x       = "releaseBrake",
        dpleft  = "releaseRotateLeft",
        dpright = "releaseRotateRight",
        jleft  = "releaseRotateLeft",
        jright = "releaseRotateRight",
      }
      -- <...>
  }
gameStates.resultScreen = {
      bindings = {
          returnToStartScreen   = function()  state = gameStates.mapSelect  end,
          incrementRecordSpace = function() resultScreen:nextSpace(1) end,
          decrementRecordSpace = function() resultScreen:nextSpace(-1) end,
          incrementRecordLetter = function() resultScreen:nextLetter(1) end,
          decrementRecordLetter = function() resultScreen:nextLetter(-1) end,
          confirm = function() resultScreen:confirm() end
      },
      keys = {
          escape = "returnToStartScreen",
          space = "returnToStartScreen",
          left   = "decrementRecordSpace",
          right  = "incrementRecordSpace",
          up = "incrementRecordLetter",
          down = "decrementRecordLetter",
          x = "returnToStartScreen",
          d = "returnToStartScreen"
      },
      keysReleased = {
      },
      buttons = {
          start    = "returnToStartScreen",
          a       = "confirm",
          x       = "returnToStartScreen",
          dpleft  = "decrementRecordSpace",
          dpright = "incrementRecordSpace",
          dpup = "incrementRecordLetter",
          dpdown = "decrementRecordLetter",
          back    = "returnToStartScreen"
      },
      buttonsReleased = {
      }
      -- <...>
  }
gameStates.mainMenu = {
  bindings = {
    changeOptionUp = function() mainMenuScreen:changeOption(-1) end,
    changeOptionDown = function() mainMenuScreen:changeOption(1) end,
    selectOption = function() mainMenuScreen:selectOption() end,
    quit       = function() love.event.quit() end,
  },
  keys = {
    space     = "selectOption",
    up         = "changeOptionUp",
    down       = "changeOptionDown",
    ["return"] = "selectOption",
    escape = "quit"
  },
  keysReleased ={
  },
  buttons = {
    dpup = "changeOptionUp",
    dpdown ="changeOptionDown",
    a = "selectOption",
    y = "quit",
    start = "selectOption",
  },
  buttonsReleased = {
  }
}
gameStates.multiplayerScreen = {
  bindings = {},
  keys = {},
  keysReleased = {},
  buttons = {},
  buttonsReleased = {}
}