player = {
      car ={
        name = "Richie",
        description = "it's a cat!",
        sprite = love.graphics.newImage("assets/cars/sprites/richie-grey.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/cars/sprites/richie-grey.png"),32,32),
        skid = "assets/cars/sprites/skid-richie.png",
        orientation = 0,
        topSpeed = 8,
        acceleration = 5,
        steering = 150,
        brakes = 10,
        driftBoost = 2
      },
      frameCount = 0,
      currentFrame = 0,
      frameDuration = 0.1,
      animationSpeeds = { 
        [1] = 0.2,
        [2] = 0.1,
        [3] = 0.05,
        [4] = 0.01
      },
      x      = 0,
      y      = 0,
      w = 32,
      h = 32,
      ox     = 16 ,
      oy     = 16,
      driftangle = 0,
      orientation = 0,
      spriterotation = 0,
      currentSpeed = 0,
      rotatingLeft = false,
      rotatingRight = false,
      accelerating = false,
      braking = false,
      checkPoints = { false,false,false},
      skidPool = SkidPool()
   }
player.spawnPlayer = function (self)
                         local spawn
                         for k, object in pairs(map.objects) do
                            if object.name == "Player" then
                             spawn = object
                             break
                            end
                         end
                         self.x = spawn.x
                         self.y = spawn.y
                         world:add(self,self.x,self.y,self.w,self.h)
                         self.currentSpeed = 0
                         self.orientation = spawn.rotation
                         self.spriteRotation = self.orientation
                         self.driftangle = self.orientation * 1
                         self.rotatingLeft = false
                         self.rotatingRight = false
                         self.accelerating = false
                         self.braking = false
                         self.checkPoints = { false,false,false}
                         --map:removeLayer("Spawn Point")
                         self.skidPool = SkidPool(self.car.skid)
                    end
player.draw = function (self)
                        self.skidPool:draw()
                        love.graphics.draw(
                             self.car.sprite,
                             self.car.spritesheet[self.currentFrame],
                             math.floor(self.x+self.ox),
                             math.floor(self.y+self.oy),	 
                             self.spriteRotation,
                             1,
                             1,
                             self.ox,
                             self.oy
                        )
end
player.update = function (self,dt)
                      self.skidPool:update(dt)
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
                        local frictionbrake = self.currentSpeed/32
                        if self.currentSpeed > 0  and self.accelerating == false then
                          self.currentSpeed = self.currentSpeed - frictionbrake
                        elseif self.currentSpeed < 0 and self.braking == false then
                          self.currentSpeed = self.currentSpeed - frictionbrake
                        end
                      end
                      
                      
                      if self.currentSpeed < self.car.topSpeed * -1 then
                        self.currentSpeed = self.car.topSpeed * -1
                      elseif self.currentSpeed > self.car.topSpeed then
                        self.currentSpeed = self.car.topSpeed
                      end
                      
                      local drifting = self.braking and self.accelerating
                      
                    --ORIENTATION
                    if self.rotatingLeft and self.accelerating or self.rotatingLeft and self.braking or self.rotatingLeft and math.floor(self.currentSpeed) > 0 then
                      if drifting then
                        self.orientation = self.orientation - ((self.car.steering*self.car.driftBoost) * dt) * math.pi / 180
                        self.driftangle = self.orientation -0.5 * -1
                        self.spriteRotation = self.orientation -0.5 
                      else
                        self.orientation = self.orientation - (self.car.steering * dt) * math.pi / 180
                        self.driftangle = self.orientation -0.5 * -1
                      end
                    elseif self.rotatingRight and self.accelerating or self.rotatingRight and self.braking or self.rotatingRight and math.floor(self.currentSpeed) > 0 then
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
                    local testx = self.x+self.w/2
                    local testy = self.y+self.h
                    if drifting and self.rotatingLeft and self.currentSpeed > 0 or drifting and self.rotatingRight and self.currentSpeed > 0  then
                      goalX = self.x - math.cos(self.driftangle) *self.currentSpeed
                      goalY = self.y - math.sin(self.driftangle)*self.currentSpeed
                    else
                      goalX = self.x - math.cos(self.orientation)*self.currentSpeed
                      goalY = self.y - math.sin(self.orientation)*self.currentSpeed
                      self.spriteRotation = self.orientation
                    end
                    --goalX = self.x - math.cos(self.orientation)*self.currentSpeed
                    --goalY = self.y - math.sin(self.orientation)*self.currentSpeed
                    
                    --COLISIONS
                    local playerFilter = function(item, other)
                      if other.properties.isCheckpoint or other.properties.isFinishLine then return 'cross'
                        else return 'slide'
                        end
                    
                    end
                    
                    local actualX, actualY, cols, len = world:move(self, goalX, goalY, playerFilter)
                    self.x, self.y = actualX, actualY
                    for i=1,len do
                      local other = cols[i].other
                      if other.properties.isCheckpoint then
                        addCheckpoint(other.properties.checkpointNum)
                      elseif other.properties.isFinishLine then
                        finishLineCrossed()
                      else
                        --Decelerate car
                        self.currentSpeed = self.currentSpeed - self.currentSpeed/16

                      end
                    end
                    
                    --ANIMATION
                    if self.currentSpeed > 0.5 or self.currentSpeed < -0.5 then
                      self.frameCount = self.frameCount + dt
                    else
                      self.currentFrame = 0  
                    end
                    if self.currentSpeed > self.car.topSpeed - self.car.topSpeed/3 then
                      self.frameDuration = self.animationSpeeds[4]
                    elseif self.currentSpeed > self.car.topSpeed / 2 then
                      self.frameDuration = self.animationSpeeds[3]
                    elseif self.currentSpeed > self.car.topSpeed / 3 then
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
player.rotate = function (self,rotate)
                  if rotate then --rotate left
                      self.rotatingLeft = true
                  else --rotate right
                     self.rotatingRight = true
                  end
end