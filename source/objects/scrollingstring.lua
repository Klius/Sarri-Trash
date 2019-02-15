ScrollingString = Object:extend()

function ScrollingString:new(text,x,y)
  self.text = text
  self.dtext = ""
  self.length = text:len()
  self.index = 1
  self.maxchar = 15
  self.x = x or 0
  self.y = y or 0
  self.time = 0
  self.delay = 0.15
end

function ScrollingString:draw()
  love.graphics.print(self.dtext,self.x,self.y)
end

function ScrollingString:update(dt)
  if self.time > self.delay then
    self.dtext = string.sub(self.text, self.index, self.index+self.maxchar)
    self.index = self.index +1
    if self.index > self.length then
      self.index = 1
    end
    self.time = 0
  else
    self.time = self.time + dt
  end
end

function ScrollingString:setDelay(delay)
  self.delay = delay
end

function ScrollingString:setCharRate(rate)
  self.maxchar = rate
end