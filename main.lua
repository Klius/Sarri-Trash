-- Include Simple Tiled Implementation into project
sti = require "libs/sti"
--moonshine = require "libs/moonshine"
bump = require "libs/bump"
bump_debug = require "libs/bump_debug"
Object = require "libs/classic"
require "objects/audio-engine"
require "objects/gamestates"
require "objects/transition"
require "objects/config"
require "objects/animations"
require "objects/arrows"
require "objects/mainMenuScreen"
require "objects/mapManager"
require "objects/music"
require "objects/controllerScreen"
require "objects/mapSelect"
require "objects/carSelect"
require "objects/save"
function love.load()
  require "objects/minimap"
  require "objects/race"
  require "objects/phoneui"
  require "objects/carManager"
  require "objects/skid"
  require "objects/skidpools"
  require "objects/player"
  require "objects/camera"
  require "objects/speedometer"
  require "objects/transition"
  require "objects/audioControl"
  require "objects/settingsScreen"
  
  
  --transition
  defTransition = Transition()
  love.mouse.setVisible( false )
   -- Load map file
   debug = false
   cheat = ""
   touchdebug = {x = 0,y = 0,dx = 10, dy = 10, id = 0}
   maplist:loadMaps()
   carlist:loadCars()
   map = sti(maplist.maps[maplist.selectedMap],{"bump"})
   world = bump.newWorld()
   map:bump_init(world)
  
  keydebug =""
  state = gameStates.mainMenu
  gameModes = {
    timeAttack = 1,
    multiplayer = 2
  }
  mode = gameModes.timeAttack
  require "objects/resultScreen"
  --Spawn player
  scenes = { 
              [1] = love.graphics.newCanvas(love.graphics.getWidth(),love.graphics.getHeight()),
              [2] = love.graphics.newCanvas(love.graphics.getWidth(),love.graphics.getHeight())
            }
  player = Player() 
  player:spawnPlayer()
  player2 = Player() 
  if mode == gameModes.multiplayer then
    player2:spawnPlayer("player2")
  end
  --play music
  audiomanager = Audio()
end

function love.update(dt)
   -- Update world
     if state == gameStates.gameLoop then
       player:update(dt)
      if mode == gameModes.multiplayer then
        player2:update(dt)
      end
       map:update(dt)
       race:update(dt)
       checkForCheats()
       drawCanvas()
       if race.endRace then
        state = gameStates.resultScreen
        player:stopSounds()
        player2:stopSounds()
       end
     end
     if state == gameStates.mapSelect then
      mapSelect:update(dt)
     end
     if state == gameStates.carSelect then
       carSelect:update(dt)
     end
     if state == gameStates.resultScreen then
       resultScreen:update(dt)
     end
    if state == gameStates.multiplayerScreen then
      controllerScreen:update(dt)
    end
    if state == gameStates.mainMenu then
      mainMenuScreen:update(dt)
    end
    if state == gameStates.settingsScreen then
      settingsScreen:update(dt)
    end
    defTransition:update(dt)
end

function love.draw()
  --if defTransition.started == false then
    if state == gameStates.gameLoop then
      -- Draw world
      --effect(function()
       if mode == gameModes.multiplayer then
        --SPLIT SCREEEEEEEEEEEAM
          love.graphics.setScissor(0,0,love.graphics.getWidth(),love.graphics.getHeight()/2)
          --############
          love.graphics.draw(scenes[1],0,-300)
          love.graphics.setScissor(0,love.graphics.getHeight()/2,love.graphics.getWidth(),love.graphics.getHeight()/2)
          love.graphics.draw(scenes[2],0,200)
          love.graphics.setScissor()
          love.graphics.setColor(0,0,0,1)
          love.graphics.rectangle("fill",0,love.graphics.getHeight()/2,love.graphics.getWidth(),6)
          love.graphics.setColor(1,1,1,1)
        else
          love.graphics.draw(scenes[1],0,0)
        end
        race:draw()
        
      if debug then
        love.graphics.print ("FPS:"..love.timer.getFPS(),0,0)
        love.graphics.print ("Checkpoint 1: "..tostring(player.checkPoints[1]).." Checkpoint 2:"..tostring(player.checkPoints[2]).." Checkpoint 3:"..tostring(player.checkPoints[3]),0,20)
        love.graphics.print("Time:"..player.race.currentTime,0,40)
        love.graphics.print (player.currentSpeed,0,60)
        love.graphics.print("x:"..player.x,0,80)
        love.graphics.print("y:"..player.y,0,100)
        love.graphics.print("tx:"..math.cos(player.orientation)*1,0,120)
        love.graphics.print("ty"..math.sin(player.orientation)*1,0,140)
        love.graphics.print("ox:"..player2.x,0,160)
        love.graphics.print("oy:"..player2.y,0,180)
        love.graphics.print("orientation:"..player.orientation,0,200)
        love.graphics.print("DriftAngle:"..player.driftangle,0,220)
        love.graphics.print("driftX:"..player.x + math.cos(player.driftangle)*player.currentSpeed,0,240)
        love.graphics.print("DriftY:"..player.y + math.sin(player.driftangle)*player.currentSpeed,0,260)
        love.graphics.print("DriftBoost:"..player.car.driftBoost,0,280)
        love.graphics.print("MEM:"..math.floor(collectgarbage('count')).."KB",200,0)
        love.graphics.print("ch:"..cheat,400,0)
      end
      
    elseif state == gameStates.mapSelect then
      mapSelect:draw()
    elseif state == gameStates.carSelect then
      carSelect:draw()
    elseif state == gameStates.resultScreen then
      resultScreen:draw()
    elseif state == gameStates.mainMenu then
      mainMenuScreen:draw()
    elseif state == gameStates.settingsScreen  then
      settingsScreen:draw()
    end
    if state == gameStates.multiplayerScreen then
      controllerScreen:draw(dt)
    end
  --end
  phoneUI:draw()
  defTransition:draw()
end

function drawCanvas()
      love.graphics.setCanvas(scenes[1])
      love.graphics.push()
      love.graphics.scale(player.camera.scale)
      love.graphics.translate(-player.camera.tx, -player.camera.ty)
      map:draw(-player.camera.tx, -player.camera.ty, player.camera.scale,player.camera.scale)
      player.skidPool:draw()
      if mode==gameModes.multiplayer then
        player2.skidPool:draw()
        player2:draw()
      end
      player:draw()
      love.graphics.pop()
      if mode == gameModes.multiplayer then
     -- love.graphics.setScissor(love.graphics.getWidth()/2,love.graphics.getHeight()/2,love.graphics.getWidth(),love.graphics.getHeight()/2)
        love.graphics.setCanvas(scenes[2])
        love.graphics.push()
        love.graphics.scale(player2.camera.scale)
        love.graphics.translate(-player2.camera.tx, -player2.camera.ty)
        map:draw(-player2.camera.tx, -player2.camera.ty, player2.camera.scale,player2.camera.scale)
        player.skidPool:draw()
        player2.skidPool:draw()
        player:draw()
        player2:draw()
        love.graphics.pop()
      end
      love.graphics.setCanvas()
      
end

--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    Drawing functions
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
]]
function drawMenuBackground()
  love.graphics.setColor(223/255,113/255,38/255,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(1,1,1,1)
end
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@
  CHEATS
@@@@@@@@@@@@@@@@@@@@@@@@@@
]]
function checkForCheats()
  local cheats = {
    weiner = function() 
              for i=1,3 do
                race:nextLap(player)
              end
             end,
    cls = function()
            cheat = ""
          end,
    changetrack = function()
      audiomanager:changeTrack(self.audios.race[1])
    end
  }
  for i,v in pairs(cheats) do
    if string.find(cheat,i) then
      cheats[i]()
      cheat =""
    end
  end
  if cheat:len() > 20  then
    cheat = ""
  end
end

--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  
  HANDLING
  
@@@@@@@@@@@@@@@@@@@@@@@@@@]]

function inputHandler( input , id)
    local action = state.bindings[input]
    if action then  return action( id )  end
end

function love.keypressed( k )
    -- you might want to keep track of this to change display prompts
    INPUTMETHOD = "keyboard"
    cheat = cheat .. k
    local binding = state.keys[k]
    return inputHandler( binding ,"keyboard")
end
function love.keyreleased( k )
    local binding = state.keysReleased[k]
    return inputHandler( binding , "keyboard" )
end
function love.gamepadpressed( gamepad, button )
    -- you might want to keep track of this to change display prompts
    INPUTMETHOD = "gamepad"
    local binding = state.buttons[button]
    return inputHandler( binding , gamepad:getGUID())
end
function love.gamepadreleased( gamepad, button )
    local binding = state.buttonsReleased[button]
    return inputHandler( binding , gamepad:getGUID() )
end

function love.touchpressed( id, x, y, dx, dy, pressure )
  local binding = state.buttons[phoneUI:checkButtonTouched(x,y,10,10,id)]
  touchdebug = {x = x,y = y, dx = 10, dy = 10, id= id}
  return inputHandler( binding )
end
function love.touchreleased( id, x, y, dx, dy, pressure )
  local binding = state.buttonsReleased[phoneUI:checkButtonTouched(x,y,10,10,id)]
  touchdebug = {x = dx,y = dy, dx = 10, dy = 10 ,id= id}
  return inputHandler( binding )
end
function love.gamepadaxis( gamepad, axis, value )
  INPUTMETHOD = "gamepad"
  local direction = gamepad:getGamepadAxis("leftx")
  local button = ""
  local binding = ""
  if direction > config.joy_sen[1] then
    button = "jright"
    binding = state.buttons[button]
    inputHandler( binding ,gamepad:getGUID())
    --stop rotating left
    button = "jleft"
    binding = state.buttonsReleased[button]
    inputHandler( binding , gamepad:getGUID())
  elseif direction < -config.joy_sen[1] then
    button = "jleft"
    binding = state.buttons[button]
    inputHandler( binding, gamepad:getGUID() )
    --stop rotating right
    button = "jright"
    binding = state.buttonsReleased[button]
    inputHandler( binding, gamepad:getGUID() )
  else
    button = "jright"
    local button2="jleft"
    binding = state.buttonsReleased[button]
    inputHandler( binding, gamepad:getGUID() )
    binding = state.buttonsReleased[button2]
    inputHandler( binding, gamepad:getGUID() )
  end

  --[[se ha de pasar axis i value ]]
end

function love.joystickadded( joystick )
  controllerScreen.gamepads[joystick:getGUID()] = 0
  if mode ~= gameModes.multiplayer then
    player.gamepad = joystick:getGUID()
  end
end
function love.joystickremoved( joystick )
  controllerScreen.gamepads[joystick:getGUID()] = nil
  if mode ~= gameModes.multiplayer then
    player.gamepad = "keyboard"
  end
end