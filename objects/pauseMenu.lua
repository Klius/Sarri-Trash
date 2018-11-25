pauseMenu = {  
  bigFont = love.graphics.newFont(30),
  defaultFont = love.graphics.newFont(18),
  currentOption = 1,
  pauseTime = 0,
  options = {
    [1] = {
      text = "Continue",
      description = "",
      accessible = true,
      changeState = function()
        --Reset the player direction
        state = gameStates.gameLoop --return to race
        gameStates.checkInputs(player)
        gameStates.checkInputs(player2)
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
      description = "",
      accessible = true,
      isCustomControl= true,
      volControl = audioControl(),
      changeControl = function (increment)
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
      description = "",
      accessible = true,
      isCustomControl = true,
      volControl = audioControl(),
      changeControl = function (increment)
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
      text = "Song: ",
      x = 100,
      y = 500,
      description = "",
      accessible = true,
      isCustomControl = true,
      info = {name="?",author="¿?"},
      changeControl = function(increment)
        audiomanager:nextTrack(increment)
      end,
      draw = function(self,x,y)
        love.graphics.print(self.text,x,y)
        self.info = audiomanager:getCurrentTrackInfo()
        love.graphics.print(info.name.." - "..info.author,x+100,y)
      end
    },
    [6] = {
      text = "Exit",
      x=100,
      y=600,
      description = "",
      accessible = true,
      changeState = function ()
        race:exit() --add yes or no before
      end
    }
  }
}
pauseMenu.update = function (self,dt)
  if player.race.isTiming then
    player.race.pauseTime = player.race.pauseTime +dt
  end
  if player.race.isTiming then
    player2.race.pauseTime = player2.race.pauseTime +dt
  end
end
pauseMenu.draw = function (self)
  love.graphics.setColor(0,0,0,0.8)
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
    if v.isCustomControl then
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
    if self.options[self.currentOption].isCustomControl then
      self.options[self.currentOption].changeControl(1)
    else
      self.options[self.currentOption].changeState()
    end
  end
end
pauseMenu.back = function(self)
  state = gameStates.gameLoop
end
pauseMenu.changeControl = function(self,increment)
  if self.options[self.currentOption].isCustomControl then
    self.options[self.currentOption].changeControl(increment)
  end
   audiomanager:playSFX(audiomanager.audios.selectFX)
end