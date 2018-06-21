Transition = Object:extend()
function Transition:new()
  self.duration = 3 --duration in seconds
  self.increment = 1/(self.duration/2)
  self.opacity = 0
  self.transitionEnd = false
  self.introed = false
end
function Transition:update(dt)
  if self.inntroed == true then
    self.opacity = self.opacity - self.increment*dt
    if self.opacity <= 0 then
      self.opacity = 0
      self.transitionEnd = true
    end
  else
    self.opacity = self.opacity + self.increment*dt
    if self.opacity >= 1 then
      self.opacity = 1
      self.introed = true
    end
  end
end
function Transition:draw()
  if self.transitionEnd == false then 
    love.graphics.setColor(1,1,1,self.opacity)
    love.graphics.rectangle(fill,0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(0,0,0,1)
  end
end