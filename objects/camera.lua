Camera = Object:extend()

function Camera:new(player)
  self.scale = 2
  self.screen_width = love.graphics.getWidth() / 2
  self.screen_height = love.graphics.getHeight() / 2
  self.scene = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())
   -- Translate world so that player is always centred
  self.tx = math.floor(player.x - (love.graphics.getWidth() / 2))
  self.ty = math.floor(player.y - (love.graphics.getHeight() / 2))
  self.scaleIntervals = 0.5
  self.zoomIn = 2
  self.zoomOut = 1.5
  self.offsetX = 2
  self.offsetY = 2
  self.currentox = 2
  self.currentoy = 2
  self.intervalY = 1
  self.intervalX = 1
  self.speed = 1
end
function Camera:update(dt,player) 
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
                local goalX = (player.x-player.car.width/2) --math.cos(player.orientation)--*self.offset
                local goalY = (player.y-player.car.height/2) --math.sin(player.orientation)--*self.offset
                if config.dinamic_cam then
                  self:getCurrentOffset(dt,player)
                  self.tx = self.tx - (self.tx - (math.floor(goalX - (self.screen_width -self.screen_width/self.currentox) )))--*dt*self.speed
                  self.ty = self.ty - (self.ty - (math.floor(goalY - (self.screen_height -self.screen_height/self.currentoy) )))--*dt * self.speed      
                else
                  self.tx = math.floor(goalX - self.screen_width /2)
                  self.ty = math.floor(goalY - self.screen_height /2)
                end
                --Scene
             
                
end
function Camera:getCurrentOffset (dt,player)
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