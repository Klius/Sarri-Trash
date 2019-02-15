Skid = Object:extend()

function Skid:new(sprite,x,y,rotation,offset)
  self.timetolive = 2
  self.offset = offset
  self.sprite = love.graphics.newImage(sprite)
  self.x = x
  self.y = y
  self.rotation = rotation
  self.erase = false
  self.opacity = 1
end
function Skid:draw()
  love.graphics.setColor(1,1,1,self.opacity)
  love.graphics.draw(self.sprite,math.floor(self.x+self.offset),
                             math.floor(self.y+self.offset),self.rotation,1,1,self.offset,self.offset)
  love.graphics.setColor(1,1,1,1)
end
function Skid:update(dt)
  self.timetolive = self.timetolive - 1*dt
  if self.timetolive < 0 then
    self.opacity = self.opacity - dt
    if self.opacity < 0 then
      self.erase = true
    end
  end
end