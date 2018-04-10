mainMenuScreen = {  
  bigFont = love.graphics.newFont(30),
  defaultFont = love.graphics.newFont(18),
  currentOption = 1,
  options = {
    [1] = { 
      text = "Time Attack",
      description = "Beat the record on various tracks to unlock new cars",
      accessible = true,
      x = love.graphics.getWidth()/2-60,
      y = love.graphics.getHeight()/2,
      state = gameStates.mapSelect
    },
    [2] = {
      text = "Multiplayer",
      description = "Race against a friend",
      accessible = false,
      x = love.graphics.getWidth()/2-60,
      y = love.graphics.getHeight()/2+30
    },
    [3] = {
      text = "Settings",
      description = "Adjust the game to your liking",
      accessible = true,
      x = love.graphics.getWidth()/2-60,
      y = love.graphics.getHeight()/2+60,
      state = gameStates.mainMenu
    }
  }
}
mainMenuScreen.update = function (self,dt)
  
end
mainMenuScreen.draw = function (self)
  love.graphics.setColor(223/255,113/255,38/255,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(1,1,1,1)
  for k,v in ipairs(self.options) do
    love.graphics.setColor(0.5,0.5,0.5,1)
    if k == self.currentOption then
      if v.accessible then
        love.graphics.setColor(1,1,1,1)
      end
      love.graphics.print(v.description,(love.graphics.getWidth()/8)*3,(love.graphics.getHeight()/8)*7)
    end
    love.graphics.setFont(self.bigFont)
    love.graphics.print(v.text,v.x,v.y)
    love.graphics.setFont(self.defaultFont)
  end
  love.graphics.setColor(1,1,1,1)
end

mainMenuScreen.changeOption = function(self, increment)
  self.currentOption = self.currentOption+increment
  if self.currentOption < 1 then
    self.currentOption = #self.options
  elseif self.currentOption > #self.options then
    self.currentOption = 1
  end
  if self.options[self.currentOption].accessible == false then
    self:changeOption(increment)
  end
end
mainMenuScreen.selectOption = function(self)
  if self.options[self.currentOption].accessible then
    state = self.options[self.currentOption].state
  end
end