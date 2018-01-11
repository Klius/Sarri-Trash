gameStates = {}
gameStates.menu = {
      bindings = {
          backToGame = function()  maplist:loadMap() 
                        state = gameStates.gameLoop  
                        end,
          changeMapMin = function() maplist:changeSelectedMap(-1) end,
          changeMapPl = function() maplist:changeSelectedMap(1) end,
          select     = function()  end,
          quit       = function() love.event.quit() end,
      },
      keys = {
          space     = "backToGame",
          left         = "changeMapMin",
          right       = "changeMapPl",
          ["return"] = "select",
          escape = "quit"
      },
      keysReleased = {},
      buttons = {
          start = "backToGame",
          dpleft   = "changeMapMin",
          dpright = "changeMapPl",
          a    = "select",
          y = "quit"
      },
      buttonsReleased = {}
      -- <...>
  }
  gameStates.gameLoop = {
      bindings = {
          openMenu   = function()  state = gameStates.menu  end,
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
                              end 
          
      },
      keys = {
          escape = "openMenu",
          space = "gas",
          left   = "rotateLeft",
          right  = "rotateRight",
          x = "brake"
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