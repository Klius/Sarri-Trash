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
          gas       = function() player.accelerating = true end,
          releaseGas       = function() player.accelerating = false end,
          rotateLeft       = function() player:rotate(true) end,
          rotateRight      = function() player:rotate(false) end,
          releaseRotateRight     = function() player.rotatingRight = false end,
          releaseRotateLeft     = function() player.rotatingLeft = false end,
          brake      = function() player.braking = true end,
          releaseBrake      = function() player.braking = false end,
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