Player = Object:extend()

function Player:new()
  self.car = {
        name = "Richie The Cat",
        description = "it's a cat!",
        sprite = love.graphics.newImage("assets/cars/sprites/richie-grey.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/richie-grey.png"),32,32),
        skid = "assets/cars/sprites/skid-richie.png",
        frameDuration = 0.1,
        currentSpeed = 0,
        topSpeed = 12,
        acceleration = 10,
        steering = 100,
        brakes = 10,
        driftBoost = 2,
        weight = 32,
        width = 32,
        height = 32,
        colBox = {
          ox = 5,
          oy = 15,
          h = 34,
          w = 51,
          
        },
        sfx = {
          engine = love.audio.newSource("assets/audio/sfx/idle.ogg","static")
        }
  }
  self.frameCount = 0
  self.currentFrame = 0
  self.frameDuration = 0.1
  self.animationSpeeds = { 
        [1] = 0.2,
        [2] = 0.1,
        [3] = 0.05,
        [4] = 0.01
      }
  self.x      = 0
  self.y      = 0
  self.colX = 0
  self.colY = 0
  self.colTime = 0

  self.ox = self.car.width/2
  self.oy = self.car.height/2
  self.tx = 0
  self.ty = 0
  self.driftangle = 0
  self.orientation = 0
  self.spriterotation = 0
  self.currentSpeed = 0
  self.rotatingLeft = false
  self.rotatingRight = false
  self.joyrotatingLeft = false
  self.joyrotatingRight = false
  self.accelerating = false
  self.braking = false
  self.checkPoints = { false,false,false}
  self.skidPool = SkidPool()
  self.properties = { isCar = true}
  self.camera = Camera(self)
  self.speedometer = Speedometer()
  self.gamepad = "keyboard"
  self.race = {
    lapsTotal = 3,
    currentLap = 0,
    currentTime = 0,
    timer = 0,
    isTiming = false,
    lapTimes = {0,0,0},
    totalTime = 0
  }
  self.cameFirst = false
  self.engineFX = self.car.sfx.engine
  self.bonkFX = love.audio.newSource("assets/audio/sfx/bonk.wav","static")
  self.scratchFX = love.audio.newSource("assets/audio/sfx/scratch.wav","static")
  self.driftFX = love.audio.newSource("assets/audio/sfx/skid.wav","static")
  self.collided = false
end
function Player:raceReset()
  local race = {
                  lapsTotal = 3,
                  currentLap = 0,
                  lapTimes = {0,0,0},
                  currentTime = 0,
                  pauseTime = 0,
                  isTiming = false,
                  timer = 0,
                  totalTime = 0
                }
  self.race = race
end
function Player:spawnPlayer(spawnPoint)
  local spawn
  spawnPoint = spawnPoint or "player"
  for k, object in pairs(map.objects) do
    if spawnPoint == string.lower(object.name) then
      spawn = object
      break
    end
  end
  self.x = spawn.x or 800
  self.y = spawn.y or 800
  world:add(self,self.x+self.car.colBox.ox,self.y+self.car.colBox.oy,self.car.colBox.w,self.car.colBox.w)
  self.currentSpeed = 0
  self.orientation = spawn.rotation
  self.spriteRotation = self.orientation
  self.driftangle = self.orientation * 1
  self.rotatingLeft = false
  self.rotatingRight = false
  self.joyrotatingLeft = false
  self.joyrotatingRight = false
  self.accelerating = false
  self.colSpeed = 0
  self.braking = false
  self.collided = false
  self.checkPoints = { false,false,false}
                         --map:removeLayer("Spawn Point")
  self.skidPool = SkidPool(self.car.skid)
  if self.car.sfx == nil then
    love.audio.newSource("assets/audio/sfx/idle.ogg","static")
  else
    self.engineFX = self.car.sfx.engine or love.audio.newSource("assets/audio/sfx/idle.ogg","static")
  end
end
function Player:draw()
  --self.skidPool:draw()
  love.graphics.draw(self.car.sprite, self.car.spritesheet[self.currentFrame],
    math.floor(self.x+self.car.width/2), math.floor(self.y+self.car.height/2),	self.spriteRotation,1,1,self.car.width/2,self.car.height/2)
  --debug
  if debug then
    love.graphics.push()
    love.graphics.setPointSize(10)
    love.graphics.points(math.floor(self.x+self.car.colBox.ox+self.car.colBox.w/2),math.floor(self.y+self.car.colBox.oy+self.car.colBox.h/2))
    love.graphics.setColor(0,0,0,1)
    love.graphics.translate(math.floor(self.x+self.car.colBox.ox+self.car.colBox.w/2),math.floor(self.y+self.car.colBox.oy+self.car.colBox.h/2))
    love.graphics.rotate(self.spriteRotation)
    love.graphics.rectangle("fill",-self.car.colBox.w/2,-self.car.colBox.h/2,self.car.colBox.w,self.car.colBox.h)
    love.graphics.setColor(1,1,1,1)
    love.graphics.pop()
  end
end
function Player:update(dt)
  self.collided = false
  self.skidPool:update(dt,self)
  local speed = self.car.acceleration * dt
  local brakes = self.car.brakes * dt
  --Acceleration
                      if self.braking or self.accelerating and self.braking then
                        self.currentSpeed = self.currentSpeed - brakes
                      elseif self.accelerating then
                        self.currentSpeed = self.currentSpeed + speed
                        if self.currentSpeed > self.car.topSpeed then
                          self.currentSpeed = self.car.topSpeed
                        end
                      else
                        --if you let go of accelerator when speeding or reversing it slows down
                        local frictionbrake = self.currentSpeed/self.car.weight
                        if self.currentSpeed > 0  and self.accelerating == false then
                          if self.currentSpeed < 0.02 then
                            self.currentSpeed = 0
                          else
                            self.currentSpeed = self.currentSpeed - frictionbrake
                          end
                        elseif self.currentSpeed < 0 and self.braking == false then
                          if self.currentSpeed > -0.02 then
                            self.currentSpeed = 0
                          else
                            self.currentSpeed = self.currentSpeed - frictionbrake
                          end
                        end
                      end
                      
                      
                      if self.currentSpeed < self.car.topSpeed * -1 then
                        self.currentSpeed = self.car.topSpeed * -1
                      elseif self.currentSpeed > self.car.topSpeed then
                        self.currentSpeed = self.car.topSpeed
                      end
                      
                      local drifting = self.braking and self.accelerating
                      
                    --ORIENTATION
                    if self.rotatingLeft and self.accelerating or self.rotatingLeft and self.braking or self.rotatingLeft and math.floor(self.currentSpeed) > 0 or self.joyrotatingLeft and self.accelerating or self.joyrotatingLeft and self.braking or self.joyrotatingLeft and math.floor(self.currentSpeed) > 0 then
                      if drifting then
                        self.orientation = self.orientation - ((self.car.steering*self.car.driftBoost) * dt) * math.pi / 180
                        self.driftangle = self.orientation -0.5 * -1
                        self.spriteRotation = self.orientation -0.5 
                      else
                        self.orientation = self.orientation - (self.car.steering * dt) * math.pi / 180
                        self.driftangle = self.orientation -0.5 * -1
                      end
                    elseif self.rotatingRight and self.accelerating or self.rotatingRight and self.braking or self.rotatingRight and math.floor(self.currentSpeed) > 0 or self.joyrotatingRight and self.accelerating or self.joyrotatingRight and self.braking or self.joyrotatingRight and math.floor(self.currentSpeed) > 0 then
                      if drifting then
                        self.orientation = self.orientation + ((self.car.steering*self.car.driftBoost) * dt) * math.pi / 180
                        self.driftangle = self.orientation-0.5 * 1
                        self.spriteRotation = self.orientation +0.5
                      else
                        self.orientation = self.orientation + (self.car.steering * dt) * math.pi / 180
                        self.driftangle = self.orientation-0.5 * 1
                      end
                    end
                    --Change position
                    
                    local goalX = self.x
                    local goalY = self.y
                    if self.colTime <= 0 then
                      if drifting and self.rotatingLeft and self.currentSpeed > 0 or drifting and self.rotatingRight and self.currentSpeed > 0 or 
                      drifting and self.joyrotatingLeft and self.currentSpeed > 0 or drifting and self.joyrotatingRight and self.currentSpeed > 0 then
                        goalX = self.x - math.cos(self.driftangle) *self.currentSpeed
                        goalY = self.y - math.sin(self.driftangle)*self.currentSpeed
                      else
                        goalX = self.x - math.cos(self.orientation)*self.currentSpeed
                        goalY = self.y - math.sin(self.orientation)*self.currentSpeed
                        self.spriteRotation = self.orientation
                      end
                    else --if there's a collision going on
                      self.colTime = self.colTime - dt
                      if drifting and self.rotatingLeft and self.currentSpeed > 0 or drifting and self.rotatingRight and self.currentSpeed > 0 or 
drifting and self.joyrotatingLeft and self.currentSpeed > 0 or drifting and self.joyrotatingRight and self.currentSpeed > 0   then
                        goalX = self.x- math.cos(self.driftangle) *self.currentSpeed
                        goalY = self.y - math.sin(self.driftangle)*self.currentSpeed
                      else
                        goalX = self.x - math.cos(self.colO)*self.colSpeed
                        goalY = self.y - math.sin(self.colO)*self.colSpeed
                        self.spriteRotation = self.orientation
                      end
                    end
                    --goalX = self.x - math.cos(self.orientation)*self.currentSpeed
                    --goalY = self.y - math.sin(self.orientation)*self.currentSpeed
                  self:move(goalX,goalY)
                  
    self.camera:update(dt,self)
  --ANIMATION
  self:animate(dt)
  self:playSounds()
end
function Player:playSounds()
  --Adjust Volume on all sounds
  if(self.engineFX:getVolume() ~= audiomanager.sfxVolume ) then
    self:adjustVolume()
  end
  --Engine
  if  not self.engineFX:isPlaying() then
    self.engineFX:setLooping(true)
    love.audio.play(self.engineFX)
  end
  local enginePitch = 1+math.abs(self.currentSpeed) / self.car.topSpeed
  self.engineFX:setPitch(enginePitch)
  --collision
  if self.collided then
    if math.abs(self.currentSpeed)/self.car.topSpeed > 0.55 then
      love.audio.play(self.bonkFX)
    else
      love.audio.play(self.scratchFX)
    end
  end
  if self.braking and self.accelerating then
    love.audio.play(self.driftFX)
  else
    love.audio.stop(self.driftFX)
  end
end
function Player:stopSounds()
  love.audio.stop(self.engineFX)
end
--Adjust the SFX volumes 
function Player:adjustVolume()
  self.engineFX:setVolume(audiomanager.sfxVolume)
  self.bonkFX:setVolume(audiomanager.sfxVolume)
  self.scratchFX:setVolume(audiomanager.sfxVolume)
  self.driftFX:setVolume(audiomanager.sfxVolume)
end
function Player:move(goalX,goalY)
--COLISIONS
    local playerFilter = function(item, other)
      if other.properties.isCheckpoint or other.properties.isFinishLine then return 'cross'
      else return 'slide'
      end
    end
                    
    local actualX, actualY, cols, len = world:move(self, goalX, goalY, playerFilter)
    self.x, self.y = actualX, actualY
    if self.colTime > 0 then
      self.colX,self.colY = actualX,actualY
    end
    for i=1,len do
      self.collided = true
      local other = cols[i].other
      if other.properties.isCheckpoint then
        self:addCheckpoint(other.properties.checkpointNum)
        self.collided = false
      elseif other.properties.isFinishLine then
        self:finishLineCrossed()
        self.collided = false
      elseif other.properties.isCar then
        if math.abs(self.currentSpeed) > math.abs(other.currentSpeed) then
          other.colSpeed = self.currentSpeed
          self.currentSpeed = self.currentSpeed - self.currentSpeed/16
          other.colO = self.orientation
          other.colTime = self.currentSpeed / self.car.topSpeed
        else
          self.colSpeed = other.currentSpeed
          other.currentSpeed = other.currentSpeed - other.currentSpeed/16
          self.colO = other.orientation
          self.colTime = 0.1
        end
      else
        --Decelerate car
        --self:addSparkles(cols[i].touch)
        self.currentSpeed = self.currentSpeed - self.currentSpeed/16
      end
    end
end
function Player:animate (dt)
  if self.currentSpeed > 0.5 or self.currentSpeed < -0.5 then
    self.frameCount = self.frameCount + dt
  else
    self.currentFrame = 0  
  end
  if math.abs(self.currentSpeed) > self.car.topSpeed - self.car.topSpeed/3 then
    self.frameDuration = self.animationSpeeds[4]
  elseif math.abs(self.currentSpeed) > self.car.topSpeed / 2 then
    self.frameDuration = self.animationSpeeds[3]
  elseif math.abs(self.currentSpeed) > self.car.topSpeed / 3 then
    self.frameDuration = self.animationSpeeds[2]
  else
    self.frameDuration = self.animationSpeeds[1]
  end
  if self.frameCount > self.frameDuration then
    self.frameCount = 0
    self.currentFrame = 1 + self.currentFrame
    if self.currentFrame > #self.car.spritesheet then
      self.currentFrame = 1
    end
  end
end
--this function is only called on input
function Player:rotate (rotate)
  if rotate then --rotate left
    self.rotatingLeft = true
    self.rotatingRight = false
  else --rotate right
    self.rotatingRight = true
    self.rotatingLeft = false
  end
end
--duplicate for joystick
function Player:rotateJoy (rotate)
  if rotate then --rotate left
    self.joyrotatingLeft = true
    self.joyrotatingRight = false
  else --rotate right
    self.joyrotatingRight = true
    self.joyrotatingLeft = false
  end
end
function Player:addCheckpoint (index)
  if self.checkPoints[index] == false then
    if index > 1 then
      if self.checkPoints[index -1] then
        self.checkPoints[index] = true
      end
    elseif index == 1 then
      self.checkPoints[index] = true
    end
  end
end

function Player:resetCheckpoint()
  self.checkPoints[1] = false
  self.checkPoints[2] = false
  self.checkPoints[3] = false
end

function Player:finishLineCrossed()
  if self.checkPoints[1] and self.checkPoints[2] and self.checkPoints[3] then
    race:nextLap(self)
    self:resetCheckpoint()
    self.race.pauseTime = 0
  end
  if self.race.isTiming == false then
    race:timerStart(self)
  end
end