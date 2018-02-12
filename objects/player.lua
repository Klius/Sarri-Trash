player = {
      car ={
        name = "Richie",
        description = "it's a cat!",
        sprite = love.graphics.newImage("assets/richie-grey.png"),
        spritesheet = getAnimations(love.graphics.newImage("assets/richie-grey.png"),32,32),
        frameDuration = 0.1,
        orientation = 0,
        topSpeed = 8,
        acceleration = 5,
        steering = 150,
        brakes = 10,
      },
      frameCount = 0,
      currentFrame = 0,
      x      = 0,
      y      = 0,
      w = 32,
      h = 32,
      ox     = 16 ,
      oy     = 16 ,
      orientation = 0,
      currentSpeed = 0,
      rotatingLeft = false,
      rotatingRight = false,
      accelerating = false,
      braking = false,
      checkPoints = { false,false,false}
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
                         self.orientation = 0
                         self.rotatingLeft = false
                         self.rotatingRight = false
                         self.accelerating = false
                         self.braking = false
                         self.checkPoints = { false,false,false}
                         --map:removeLayer("Spawn Point")
                         
                    end
player.draw = function (self)
                        love.graphics.draw(
                             self.car.sprite,
                             self.car.spritesheet[self.currentFrame],
                             math.floor(self.x+self.ox),
                             math.floor(self.y+self.oy),	 
                             self.orientation,
                             1,
                             1,
                             self.ox,
                             self.oy
                        )
end
player.update = function (self,dt)
                      local speed = self.car.acceleration * dt
                      local brakes = self.car.brakes * dt
                      --Acceleration
                      if self.braking or self.accelerating and braking then
                        self.currentSpeed = self.currentSpeed - brakes
                      elseif self.accelerating then
                        self.currentSpeed = self.currentSpeed + speed
                        if self.currentSpeed > self.car.topSpeed then
                          self.currentSpeed = self.car.topSpeed
                        end
                      else
                        local braker = self.currentSpeed/16
                        
                        if self.currentSpeed > 0  then
                          self.currentSpeed = self.currentSpeed - braker
                        elseif self.currentSpeed < 0 and self.braking == false then
                          self.currentSpeed = self.currentSpeed - braker
                        end
                      end
                      
                      
                      if self.currentSpeed < self.car.topSpeed * -1 then
                        self.currentSpeed = self.car.topSpeed * -1
                      elseif self.currentSpeed > self.car.topSpeed then
                        self.currentSpeed = self.car.topSpeed
                      end
                      
                    -- ORIENTATION
                    if self.rotatingLeft then
                      self.orientation = self.orientation - (self.car.steering * dt) * math.pi / 180
                    elseif self.rotatingRight then
                      self.orientation = self.orientation + (self.car.steering * dt) * math.pi / 180
                    end
                    
                    --Change position
                    
                    goalX = self.x - math.cos(self.orientation)*self.currentSpeed
                    goalY = self.y - math.sin(self.orientation)*self.currentSpeed
                    local playerFilter = function(item, other)
                      if other.properties.isCheckpoint or other.properties.isFinishLine then return 'cross'
                        else return 'slide'
                        end
                    
                      end
                    local actualX, actualY, cols, len = world:move(self, goalX, goalY, playerFilter)
                    self.x, self.y = actualX, actualY
                    --COLISIONS
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
                    if self.currentSpeed > 0.5 or self.currentSpeed < 0 then
                      self.frameCount = self.frameCount + dt
                    else
                      self.currentFrame = 0  
                    end
                    if self.frameCount > self.car.frameDuration then
                      self.frameCount = 0
                      self.currentFrame = 1 + self.currentFrame
                      if self.currentFrame > #self.car.spritesheet then
                        self.currentFrame = 0
                      end
                    end

end