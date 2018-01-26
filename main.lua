-- Include Simple Tiled Implementation into project
sti = require "libs/sti"
--moonshine = require "libs/moonshine"
bump = require "libs/bump"
bump_debug = require "libs/bump_debug"
Object = require "libs/classic"
require "objects/mapManager"
require "objects/music"
require "objects/gamestates"
function love.load()
  require "objects/race"
  require "objects/mapSelect"
  require "objects/phoneui"
   -- Load map file
   debug = false
   touchdebug = {x = 0,y = 0,dx = 10, dy = 10}
   --effect = moonshine(moonshine.effects.glow)
   maplist:loadMaps()
   print(maplist.maps[maplist.selectedMap])
   audiomanager = MusicManager()
   map = sti(maplist.maps[maplist.selectedMap],{"bump"})
   world = bump.newWorld()
   map:bump_init(world)
  
  keydebug =""
  state = gameStates.mapSelect
  --Spawn player
   spawnPlayer()
   camera = {
      
     scale = 2,
     screen_width = love.graphics.getWidth() / 2,
     screen_height = love.graphics.getHeight() / 2,
     scene = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight()),

   -- Translate world so that player is always centred
     tx = math.floor(player.x - (love.graphics.getWidth() / 2) / 2),
     ty = math.floor(player.y - (love.graphics.getHeight() / 2) / 2),
     scaleIntervals = 0.5,
     zoomIn = 2,
     zoomOut = 1.5,
     update = function(self,dt) 
                if player.currentSpeed> player.topSpeed/2 then
                  self.scale = self.scale - self.scaleIntervals*dt
                  if self.scale < self.zoomOut then
                    self.scale=self.zoomOut
                  end
                else
                  self.scale = self.scale + self.scaleIntervals*dt
                  if self.scale > self.zoomIn then
                    self.scale=self.zoomIn
                  end
                end  
                self.screen_width = love.graphics.getWidth() / self.scale
                self.screen_height = love.graphics.getHeight() / self.scale

              -- Translate world so that player is always centred
                self.tx = math.floor(player.x - self.screen_width / 2)
                self.ty = math.floor(player.y - self.screen_height / 2)
                
                --Scene
                love.graphics.setCanvas(self.scene)
                love.graphics.scale(self.scale)
                love.graphics.translate(-self.tx, -self.ty)
                map:draw(-self.tx, -self.ty, self.scale,self.scale)
                drawPlayer()
                
                love.graphics.setCanvas()
                
              end
    }
end

function love.update(dt)
   -- Update world
   if state == gameStates.gameLoop then
     updatePlayer(dt)
     map:update(dt)
     camera:update(dt)
     race:update(dt)
     if race.endRace then
      state = gameStates.resultScreen
     end
   end
end

function love.draw()
  
  if state == gameStates.gameLoop then
   

   
    

   -- Draw world
    --effect(function()
      love.graphics.draw(camera.scene)
      race:draw()
      --love.graphics.scale(camera.scale)
      --love.graphics.translate(-camera.tx, -camera.ty)
      --map:draw(-camera.tx, -camera.ty, camera.scale,camera.scale)
     
     --drawPlayer()
    --end)
    if debug then
      love.graphics.print ("FPS:"..love.timer.getFPS(),0,0)
      love.graphics.print ("Checkpoint 1: "..tostring(player.checkPoints[1]).." Checkpoint 2:"..tostring(player.checkPoints[2]).." Checkpoint 3:"..tostring(player.checkPoints[3]),0,20)
      love.graphics.print(race.currentTime,0,40)
    end
    
  elseif state == gameStates.mapSelect then
    mapSelect:draw()
  elseif state == gameStates.resultScreen then
    love.graphics.print("this is the result screen, press space to continue")
  end
  phoneUI:draw()
  love.graphics.rectangle("line",touchdebug.x,touchdebug.y,touchdebug.dx,touchdebug.dy)
--map:bump_draw(world)
--bump_debug.draw(world)
  -- map:draw(-tx, -ty, scale,scale)
end
function spawnPlayer()
 local sprite = love.graphics.newImage("assets/car-test.png")
   local spritesheet = getAnimations(sprite,32,32)
   local spawn
   for k, object in pairs(map.objects) do
      if object.name == "Player" then
	 spawn = object
	 break
      end
   end
   player = {
      sprite = sprite,
      frames = spritesheet,
      frameDuration = 0.5,
      frameCount = 0,
      currentFrame = 0,
      x      = spawn.x,
      y      = spawn.y,
      w = 32,
      h = 32,
      ox     = 16 ,
      oy     = 16 ,
      orientation = 0,
      currentSpeed = 0,
      topSpeed = 8,
      acceleration = 5,
      steering = 150,
      brakes = 10,
      rotatingLeft = false,
      rotatingRight = false,
      accelerating = false,
      braking = false,
      checkPoints = { false,false,false}
   }
   world:add(player,player.x,player.y,player.w,player.h)
   --map:removeLayer("Spawn Point")
   
end
function drawPlayer()
  love.graphics.draw(
                         player.sprite,
                         player.frames[player.currentFrame],
                         math.floor(player.x+player.ox),
                         math.floor(player.y+player.oy),	 
                         player.orientation,
                         1,
                         1,
                         player.ox,
                         player.oy
                            )

      -- Temporarily draw a point at our location so we know
      -- that our sprite is offset properly
      love.graphics.setPointSize(1)
      --love.graphics.rectangle('line', world:getRect(player))
      love.graphics.print(player.currentSpeed,player.x,player.y)
end
function updatePlayer(dt)
  local speed = player.acceleration * dt
      local brakes = player.brakes * dt
      --Acceleration
      if player.accelerating then
        player.currentSpeed = player.currentSpeed + speed
        if player.currentSpeed > player.topSpeed then
          player.currentSpeed = player.topSpeed
        end
      else
        player.currentSpeed = player.currentSpeed - speed
        if player.currentSpeed < 0 and player.braking == false then
          player.currentSpeed = 0
        end
      end
      if player.braking then
        player.currentSpeed = player.currentSpeed - brakes
        if player.currentSpeed < -2 then
          player.currentSpeed = -2
        end
      end

    -- ORIENTATION
    if player.rotatingLeft then
      player.orientation = player.orientation - (player.steering * dt) * math.pi / 180
    elseif player.rotatingRight then
      player.orientation = player.orientation + (player.steering * dt) * math.pi / 180
    end
    
    --Change position
    
    goalX = player.x - math.cos(player.orientation)*player.currentSpeed
    goalY = player.y - math.sin(player.orientation)*player.currentSpeed
    local playerFilter = function(item, other)
      if other.properties.isCheckpoint or other.properties.isFinishLine then return 'cross'
      else return 'slide'
      end
    
      end
    local actualX, actualY, cols, len = world:move(player, goalX, goalY, playerFilter)
    player.x, player.y = actualX, actualY
    --COLISIONS
    for i=1,len do
      local other = cols[i].other
      if other.properties.isCheckpoint then
        addCheckpoint(other.properties.checkpointNum)
      elseif other.properties.isFinishLine then
        finishLineCrossed()
      else
        --Decelerate car
        player.currentSpeed = player.currentSpeed - player.currentSpeed/16

      end
    end
    
    --ANIMATION
    if player.currentSpeed > 0 then
      player.frameCount = player.frameCount + dt
    else
      player.currentFrame = 0  
    end
    if player.frameCount > player.frameDuration then
      player.frameCount = 0
      player.currentFrame = 1 + player.currentFrame
      if player.currentFrame > 3 then
        player.currentFrame = 0
      end
    end

end
function addCheckpoint (index)
  if player.checkPoints[index] == false then
    if index > 1 then
      if player.checkPoints[index -1] then
        player.checkPoints[index] = true
      end
    elseif index == 1 then
      player.checkPoints[index] = true
    end
  end
end

function resetCheckpoint()
  player.checkPoints[1] = false
  player.checkPoints[2] = false
  player.checkPoints[3] = false
end

function finishLineCrossed()
  if player.checkPoints[1] and player.checkPoints[2] and player.checkPoints[3] then
    race:nextLap()
    resetCheckpoint()
  end
  if race.isTiming == false then
    race:timerStart()
  end
end
function getAnimations(sprite,width,height)
  local spritesheet = {}
  local i = 0
  local y = 0
  local x = 0
  while x < sprite:getWidth() do
    spritesheet[i] = love.graphics.newQuad(x,y,width,height,sprite:getDimensions())
    x = x+width
    i = i+1
  end
  return spritesheet
  
end

  --[
  -- HANDLING
  --]


function inputHandler( input )
    local action = state.bindings[input]
    if action then  return action()  end
end

function love.keypressed( k )
    -- you might want to keep track of this to change display prompts
    INPUTMETHOD = "keyboard"
    local binding = state.keys[k]
    return inputHandler( binding )
end
function love.keyreleased( k )
    local binding = state.keysReleased[k]
    return inputHandler( binding )
end
function love.gamepadpressed( gamepad, button )
    -- you might want to keep track of this to change display prompts
    INPUTMETHOD = "gamepad"
    keydebug = button
    local binding = state.buttons[button]
    return inputHandler( binding )
end
function love.gamepadreleased( gamepad, button )
    local binding = state.buttonsReleased[button]
    return inputHandler( binding )
end

function love.touchpressed( id, x, y, dx, dy, pressure )
  local binding = state.buttons[phoneUI:checkButtonTouched(x,y,10,10)]
  touchdebug = {x = x,y = y, dx = 10, dy = 10}
  return inputHandler( binding )
end
function love.touchreleased( id, x, y, dx, dy, pressure )
  local binding = state.buttonsReleased[phoneUI:checkButtonTouched(x,y,10,10)]
  touchdebug = {x = x,y = y, dx = 10, dy = 10}
  return inputHandler( binding )
end