ScrollingString = Object:extend()

function ScrollingString:new(text,x,y)
  self.text = text
  self.dtext = ""
  self.length = text:len()
  self.index = 1
  self.maxchar = 30
  self.x = x or 0
  self.y = y or 0
  self.time = 0
  self.delay = 0.15
end

function ScrollingString:draw()
  love.graphics.print(self.dtext,self.x,self.y)
end

function ScrollingString:update(dt)
  if self.length < self.maxchar then
    self.dtext = self.text
  else  
    if self.time > self.delay then
      chars = self.index + self.maxchar
      rchars = chars - self.length 
      print(rchars)
      self.dtext = string.sub(self.text, self.index, self.index+self.maxchar)
      if rchars > 0 then
        self.dtext = self.dtext.." "..string.sub(self.text,1,rchars)
      end
      self.index = self.index +1
      if self.index > self.length then
        self.index = 1
      end
      self.time = 0
    else
      self.time = self.time + dt
    end
  end
end

function ScrollingString:setDelay(delay)
  self.delay = delay
end

function ScrollingString:setCharRate(rate)
  self.maxchar = rate
end
function ScrollingString:setString(str,update)
  self.text = str
  self.length = str:len()
  if update then
    self.index = 1
  end
end