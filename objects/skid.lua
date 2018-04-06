Skid = Object:extend()

function Skid:new(sprite,x,y,rotation)
  self.timetolive = 2
  self.offset = 16
  self.sprite = love.graphics.newImage("assets/skid-fx.png")
  self.x = x
  self.y = y
  self.rotation = rotation
  self.erase = false
end
function Skid:draw()
  love.graphics.draw(self.sprite,math.floor(self.x+self.offset),
                             math.floor(self.y+self.offset),self.spriteRotation,1,1,self.offset,self.offset)
end
function Skid:update(dt)
  self.timetolive = self.timetolive - 1*dt
  if self.timetolive < 0 then
    self.erase = true
  end
end