Transition = Object:extend()
function Transition:new()
  self.duration = 0.3 --duration in seconds
  self.increment = 1/(self.duration)
  self.opacity = 1
  self.endTransition = true
  self.started = false
end
function Transition:update(dt)
  if self.started == true then
    self.opacity = self.opacity - self.increment*dt
    if self.opacity <= 0 then
      self.opacity = 0
      self.endTransition = true
      self.started = false
    end
  end
end
function Transition:draw()
  if self.endTransition == false then
    love.graphics.setColor(0,0,0,self.opacity)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(1,1,1,1)
    --love.graphics.print("opacity:"..self.opacity.."# increment= "..self.increment)
  end
end
function Transition:start()
  self.started = true
  self.endTransition = false
  self.opacity = 1
end