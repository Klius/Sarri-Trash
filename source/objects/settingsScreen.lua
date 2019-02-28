settingsScreen = {  
  bigFont = love.graphics.newFont(30),
  defaultFont = love.graphics.newFont(18),
  currentOption = 1,
  options = {
    [1] = {
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
      draw = function(self)
        love.graphics.print(self.text,self.x,self.y)
        self.volControl = audioControl()
        self.volControl:draw(audiomanager.musicVolume,self.x,self.y+30)
      end
    },
    [2] = {
      text = "SFX Volume",
      x=100,
      y=400,
      description = "Beat the record on various tracks to unlock new cars",
      accessible = true,
      isAudioControl = true,
      volControl = audioControl(),
      changeVolume = function (increment)
        audiomanager:changeSFXVolume(increment/10)
      end,
      draw = function(self)
        love.graphics.print(self.text,self.x,self.y)
        self.volControl = audioControl()
        self.volControl:draw(audiomanager.sfxVolume,self.x,self.y+30)
      end
    },
    [3] = {
      text = "Camera",
      x=100,
      y=500,
      description = "Changes Camera behaviour",
      accessible = true,
      isSelectorControl = true,
      control = selectorControl({ [1]={text="Dinamic",value=1} , [2]={text="Static",value=0}},config.dinamic_cam),
      changeOption = function (control,increment)
        control:changeOption(increment)
        config.dinamic_cam = control:getValue()
      end,
      draw = function(self)
        love.graphics.print(self.text,self.x,self.y)
        self.control:draw(self.x+120,self.y)
      end
    },
    [4] = {
      text = "Back",
      x=100,
      y=600,
      description = "Beat the record on various tracks to unlock new cars",
      accessible = true,
      changeState = function ()
        saveConf(config)
        defTransition:start()
        state = gameStates.mainMenu
      end
    }
  }
}
settingsScreen.update = function (self,dt)
  
end
settingsScreen.draw = function (self)
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
    if v.isAudioControl or v.isSelectorControl then
      v:draw()
    else
      love.graphics.print(v.text,v.x,v.y)
    end
    love.graphics.setFont(self.defaultFont)
  end
  love.graphics.setColor(1,1,1,1)
end

settingsScreen.changeOption = function(self, increment)
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
settingsScreen.selectOption = function(self)
  if self.options[self.currentOption].accessible then
    if self.options[self.currentOption].isAudioControl then
      self.options[self.currentOption].changeVolume(1)
    else
      self.options[self.currentOption].changeState()
    end
  end
end
settingsScreen.back = function(self)
  saveConf(config)
  state = gameStates.mainMenu
  defTransition:start()
end
settingsScreen.changeControl = function(self,increment)
  if self.options[self.currentOption].isAudioControl then
    self.options[self.currentOption].changeVolume(increment)
  elseif self.options[self.currentOption].isSelectorControl then
    self.options[self.currentOption].changeOption(self.options[self.currentOption].control,increment)
  end
   audiomanager:playSFX(audiomanager.audios.selectFX)
end