-- Include Simple Tiled Implementation into project
sti = require "libs/sti"
--moonshine = require "libs/moonshine"
bump = require "libs/bump"
bump_debug = require "libs/bump_debug"
Object = require "libs/classic"
require "objects/animations"
require "objects/arrows"
require "objects/mapManager"
require "objects/music"
require "objects/gamestates"
require "objects/mapSelect"
require "objects/carSelect"
require "objects/resultScreen"
require "objects/save"
function love.load()

  require "objects/race"
  require "objects/phoneui"
  require "objects/carManager"
  require "objects/player"
  require "objects/speedometer"
  
   -- Load map file
   debug = false
   touchdebug = {x = 0,y = 0,dx = 10, dy = 10, id = 0}
   maplist:loadMaps()
   carlist:loadCars()
   print(maplist.maps[maplist.selectedMap])
   audiomanager = MusicManager()
   map = sti(maplist.maps[maplist.selectedMap],{"bump"})
   world = bump.newWorld()
   map:bump_init(world)
  
  keydebug =""
  state = gameStates.mapSelect
  --Spawn player
   player:spawnPlayer()
   camera = {
      
     scale = 2,
     screen_width = love.graphics.getWidth() / 2,
     screen_height = love.graphics.getHeight() / 2,
     scene = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight()),

   -- Translate world so that player is always centred
     tx = math.floor(player.x - (love.graphics.getWidth() / 2)),
     ty = math.floor(player.y - (love.graphics.getHeight() / 2)),
     scaleIntervals = 0.5,
     zoomIn = 2,
     zoomOut = 1.5,
     offsetX = 2,
     offsetY = 2,
     currentox = 2,
     currentoy = 2,
     intervalY = 1,
     intervalX = 1,
     speed = 1,
     goalX = 0,
     goalY = 0,
     update = function(self,dt) 
                if player.currentSpeed > player.car.topSpeed/4 then
                  self.scale = self.scale - self.scaleIntervals*dt
                  if self.scale < self.zoomOut then
                    self.scale=self.zoomOut
                  end
                elseif player.currentSpeed < player.car.topSpeed/2 then
                  self.scale = self.scale + self.scaleIntervals*dt
                  if self.scale > self.zoomIn then
                    self.scale=self.zoomIn
                  end
                end  
                self.screen_width = love.graphics.getWidth() / self.scale
                self.screen_height = love.graphics.getHeight() / self.scale
              -- Translate world so that player is always centred
                local goalX = (player.x-player.w/2) --math.cos(player.orientation)--*self.offset
                local goalY = (player.y-player.h/2) --math.sin(player.orientation)--*self.offset
          
                self:getCurrentOffset(dt)
                self.tx = self.tx - (self.tx - (math.floor(goalX - (self.screen_width -self.screen_width/self.currentox) )))--*dt*self.speed
                self.ty = self.ty - (self.ty - (math.floor(goalY - (self.screen_height -self.screen_height/self.currentoy) )))--*dt * self.speed      
              
                --self.tx = math.floor(goalX - self.screen_width /4)
                --self.ty = math.floor(goalY - self.screen_height /4)
                
                --Scene
                love.graphics.setCanvas(self.scene)
                love.graphics.scale(self.scale)
                love.graphics.translate(-self.tx, -self.ty)
                map:draw(-self.tx, -self.ty, self.scale,self.scale)
                player:draw()
                love.graphics.setCanvas()
                
              end,
    getCurrentOffset = function(self,dt)
      local ox = math.cos(player.orientation)*1
                local oy = math.sin(player.orientation)*1
                if player.currentSpeed >player.car.topSpeed/2 then
                  if oy > 0.95 then
                    self.offsetY = 3
                  elseif oy < -0.95 then
                    self.offsetY = 1.5
                  else
                    self.offsetY = 2
                  end
                  if ox > 0.95 then
                    self.offsetX = 3
                  elseif ox < -0.95 then
                    self.offsetX = 1.5
                  else
                    self.offsetX = 2
                  end
                else
                  self.offsetX = 2
                  self.offsetY = 2
                end
                  if self.currentoy > self.offsetY then  
                    self.intervalY = -(dt*self.speed)
                  elseif self.currentoy < self.offsetY then
                    self.intervalY = dt*self.speed
                  end
                  self.currentoy = self.currentoy + self.intervalY
                  
                  if self.currentox > self.offsetX then 
                    self.intervalX = -(dt*self.speed)
                  elseif self.currentox < self.offsetX then
                    self.intervalX = dt*self.speed
                  end
                  self.currentox = self.currentox + self.intervalX
                
                if self.intervalY > 0 and self.offsetY / self.currentoy < 1 then
                  self.currentoy = self.offsetY
                elseif self.intervalY < 0 and self.currentoy /  self.offsetY < 1 then
                  self.currentoy = self.offsetY
                end
                if self.intervalX < 0 and self.currentox / self.offsetX  < 1 then
                  self.currentox = self.offsetX
                elseif self.intervalX > 0 and  self.offsetX / self.currentox  < 1 then
                  self.currentox = self.offsetX
                end
      end
    }
    
end

function love.update(dt)
   -- Update world
   if state == gameStates.gameLoop then
     player:update(dt)
     map:update(dt)
     camera:update(dt)
     race:update(dt)
     if race.endRace then
      state = gameStates.resultScreen
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
      love.graphics.print (player.currentSpeed,0,60)
      love.graphics.print("tx:"..math.cos(player.orientation)*1,0,80)
      love.graphics.print("ty"..math.sin(player.orientation)*1,0,100)
      love.graphics.print("ox:"..camera.currentox,0,120)
      love.graphics.print("oy:"..camera.currentoy,0,140)
      love.graphics.print("MEM"..collectgarbage('count').."KB",400,0)
    end
    
  elseif state == gameStates.mapSelect then
    mapSelect:draw()
  elseif state == gameStates.carSelect then
    carSelect:draw()
  elseif state == gameStates.resultScreen then
    resultScreen:draw()
  end
  phoneUI:draw()
--map:bump_draw(world)
--bump_debug.draw(world)
  -- map:draw(-tx, -ty, scale,scale)
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
  local binding = state.buttons[phoneUI:checkButtonTouched(x,y,10,10,id)]
  touchdebug = {x = x,y = y, dx = 10, dy = 10, id= id}
  return inputHandler( binding )
end
function love.touchreleased( id, x, y, dx, dy, pressure )
  local binding = state.buttonsReleased[phoneUI:checkButtonTouched(x,y,10,10,id)]
  touchdebug = {x = dx,y = dy, dx = 10, dy = 10 ,id= id}
  return inputHandler( binding )
end