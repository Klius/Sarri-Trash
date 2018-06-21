gameStates = {}
gameStates.carSelect = {
  bindings = {
      enterRace = function( id )
                    if mode == gameModes.multiplayer and carSelect.player == 1 and id ==player.gamepad then
                      player.car = carlist.cars[carlist.selectedCar]
                      carSelect.player = 2
                    elseif mode == gameModes.multiplayer and carSelect.player == 2 and id == player2.gamepad then
                      player2.car = carlist.cars[carlist.selectedCar]
                      carSelect.player = 1
                      maplist:loadMap()
                      race:reset()
                      state = gameStates.gameLoop
                --SINGLEPLAYER
                    elseif mode ~= gameModes.multiplayer  then
                      carSelect.player = 1
                      player.car = carlist.cars[carlist.selectedCar]
                      maplist:loadMap()
                      race:reset()
                      state = gameStates.gameLoop
                    end
                  end,
      changeCarMin = function(id)
                        if carSelect.player == 1 and mode == gameModes.multiplayer 
                        and id== player.gamepad then 
                          carlist:changeSelectedCar(-1)
                        elseif carSelect.player == 2 and mode == gameModes.multiplayer 
                        and id== player2.gamepad then
                          carlist:changeSelectedCar(-1)
                        elseif mode ~= gameModes.multiplayer then
                          carlist:changeSelectedCar(-1)
                        end
                      end,
      changeCarPl = function(id)
                      if carSelect.player == 1 and mode == gameModes.multiplayer 
                      and id== player.gamepad then 
                          carlist:changeSelectedCar(1)
                      elseif carSelect.player == 2 and mode == gameModes.multiplayer 
                        and id== player2.gamepad then
                          carlist:changeSelectedCar(1)
                      elseif mode ~= gameModes.multiplayer then
                        carlist:changeSelectedCar(1)
                      end
                    end,
      back = function()
                state = gameStates.mapSelect
                carSelect.player = 1
              end
  },
  keys = {
      space     = "enterRace",
      ["return"] = "enterRace",
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
                        if id == player.gamepad  then
                          player.accelerating = true
                        elseif id ==player2.gamepad then
                          player2.accelerating = true
                        end
          end,
          releaseGas       = function(id)
            if id == player.gamepad  then
              player.accelerating = false 
            elseif id ==player2.gamepad then
              player2.accelerating = false 
            end
          end,
          rotateLeft       = function(id)
            if id == player.gamepad  then
              player:rotate(true)
            elseif id ==player2.gamepad then
              player2:rotate(true)
            end
          end,
          rotateRight      = function(id) 
            if id == player.gamepad  then
              player:rotate(false)
            elseif id ==player2.gamepad then
              player2:rotate(false)
            end 
          end,
          releaseRotateRight     = function(id)
            if id == player.gamepad then
              player.rotatingRight = false 
            elseif id ==player2.gamepad then
              player2.rotatingRight = false
            end 
          end,
          releaseRotateLeft     = function(id)
            if id == player.gamepad then
              player.rotatingLeft = false 
            elseif id ==player2.gamepad then
              player2.rotatingLeft = false
            end   
          end,
          rotateLeftJoy       = function(id)
            if id == player.gamepad  then
              player:rotateJoy(true)
            elseif id ==player2.gamepad then
              player2:rotateJoy(true)
            end
          end,
          rotateRightJoy      = function(id) 
            if id == player.gamepad  then
              player:rotateJoy(false)
            elseif id ==player2.gamepad then
              player2:rotateJoy(false)
            end 
          end,
          releaseRotateRightJoy     = function(id)
            if id == player.gamepad then
              player.joyrotatingRight = false 
            elseif id ==player2.gamepad then
              player2.joyrotatingRight = false
            end 
          end,
          releaseRotateLeftJoy     = function(id)
            if id == player.gamepad then
              player.joyrotatingLeft = false 
            elseif id ==player2.gamepad then
              player2.joyrotatingLeft = false
            end   
          end,
          brake = function(id)
           if id == player.gamepad then  
              player.braking = true
            elseif id ==player2.gamepad then
              player2.braking = true
            end
          end,
          releaseBrake      = function(id)
             if id == player.gamepad then  
              player.braking = false
            elseif id ==player2.gamepad then
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
          jleft   = "rotateLeftJoy",
          jright   = "rotateRightJoy",
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
        jleft  = "releaseRotateLeftJoy",
        jright = "releaseRotateRightJoy",
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
          confirm = function() resultScreen:confirm() end,
          adjustplus = function() resultScreen.adjustor = resultScreen.adjustor+1 end,
          adjustminus = function() resultScreen.adjustor = resultScreen.adjustor-1 end,
      },
      keys = {
          ["return"] = "confirm",
          space = "confirm",
          left   = "decrementRecordSpace",
          right  = "incrementRecordSpace",
          up = "decrementRecordLetter",
          down = "incrementRecordLetter",
          x = "returnToStartScreen",
          d = "returnToStartScreen",
          q = "adjustplus",
          a = "adjustminus"
      },
      keysReleased = {
      },
      buttons = {
          start    = "confirm",
          a       = "confirm",
          x       = "confirm",
          dpleft  = "decrementRecordSpace",
          dpright = "incrementRecordSpace",
          dpup = "decrementRecordLetter",
          dpdown = "incrementRecordLetter",
          back    = "returnToStartScreen",
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
  bindings = {
    goBack = function() state = gameStates.mainMenu end,
    moveUp = function( inputId ) controllerScreen:moveController(inputId,true) end,
    moveDown = function( inputId ) controllerScreen:moveController(inputId,false) end,
    assignControllers = function() controllerScreen:assignControllers() end,
  },
  keys = {
    space     = "assignControllers",
    ["return"] = "assignControllers",
    up = "moveUp",
    down = "moveDown", 
    escape = "goBack"
  },
  keysReleased = {},
  buttons = {
    dpup = "moveUp",
    dpdown = "moveDown",
    a = "assignControllers",
    start = "assignControllers"
  },
  buttonsReleased = {}
}