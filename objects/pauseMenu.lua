pauseMenu = {  
  bigFont = love.graphics.newFont(30),
  defaultFont = love.graphics.newFont(18),
  currentOption = 1,
  options = {
    [1] = {
      text = "Continue",
      description = "",
      accessible = true,
      changeState = function()
        state = gameStates.gameLoop
      end,
    },
    [2] = {
      text = "Restart",
      description = "",
      accessible = true,
      changeState = function()
        maplist:loadMap()
        race:reset()
        state = gameStates.gameLoop --add yes or no
      end,
    },
    [3] = {
      text = "Music Volume",
      x=100,
      y=300,
      description = "Beat the record on various tracks to unlock new cars",
      accessible = true,
      isAudioControl= true,
      volControl = audioControl(),
      changeVolume = function (increment)
        audiomanager:changeMusicVolume(increment/10)
      end,
      draw = function(self,x,y)
        love.graphics.print(self.text,x,y)
        self.volControl = audioControl()
        self.volControl:draw(audiomanager.musicVolume,x+300,y)
      end
    },
    [4] = {
      text = "SFX Volume",
      x=100,
      y=400,
      description = "Beat the record on various tracks to unlock new cars",
      accessible = true,
      isAudioControl = true,
      volControl = audioControl(),
      changeVolume = function (increment)
        audiomanager:changeSFXVolume(increment/10)
        player:adjustVolume()
        player2:adjustVolume()
      end,
      draw = function(self,x,y)
        love.graphics.print(self.text,x,y)
        self.volControl = audioControl()
        self.volControl:draw(audiomanager.sfxVolume,x+300,y)
      end
    },
    [5] = {
      text = "Exit",
      x=100,
      y=500,
      description = "",
      accessible = true,
      changeState = function ()
        race:exit() --add yes or no before
      end
    }
  }
}
pauseMenu.update = function (self,dt)
  
end
pauseMenu.draw = function (self)
  love.graphics.setColor(0,0,0,0.5)
  local x = love.graphics.getWidth()/4
  local y = love.graphics.getHeight()/4
  love.graphics.rectangle("fill",x,y,love.graphics.getWidth()/2,love.graphics.getHeight()/2)
  love.graphics.setFont(self.bigFont)
  love.graphics.setColor(1,1,1,1)
  love.graphics.print("PAUSE",x+love.graphics.getWidth()/4-50,y+25)
  x = x + 100
  y = y+50
  for k,v in ipairs(self.options) do
    y = y+50
    love.graphics.setColor(0.5,0.5,0.5,1)
    if k == self.currentOption then
      if v.accessible then
        love.graphics.setColor(1,1,1,1)
      end
      love.graphics.print(v.description,(love.graphics.getWidth()/8)*3,(love.graphics.getHeight()/8)*7)
    end
    if v.isAudioControl then
      v:draw(x,y)
    else
      love.graphics.print(v.text,x,y)
    end
  end
  love.graphics.setColor(1,1,1,1)
  love.graphics.setFont(self.defaultFont)
end

pauseMenu.changeOption = function(self, increment)
  self.currentOption = self.currentOption+increment
  if self.currentOption < 1 then
    self.currentOption = #self.options
  elseif self.currentOption > #self.options then
    self.currentOption = 1
  end
  if self.options[self.currentOption].accessible == false then
    self:changeOption(increment)
  end
  audiomanager:playSFX(audiomanager.audios.selectFX)
end
pauseMenu.selectOption = function(self)
  if self.options[self.currentOption].accessible then
    if self.options[self.currentOption].isAudioControl then
      self.options[self.currentOption].changeVolume(1)
    else
      self.options[self.currentOption].changeState()
    end
  end
end
pauseMenu.back = function(self)
  state = gameStates.gameLoop
end
pauseMenu.changeControl = function(self,increment)
  if self.options[self.currentOption].isAudioControl then
    self.options[self.currentOption].changeVolume(increment)
  end
   audiomanager:playSFX(audiomanager.audios.selectFX)
end