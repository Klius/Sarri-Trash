resultScreen = {
    bigFont = love.graphics.newFont(30),
    defaultFont = love.graphics.newFont(18),
    currentPosition = 0,
    screenDesc = "-Results-",
    position = { [1] = "1ST",
              [2] = "2ND",
              [3] = "3RD",
              [0] = "Keep on trying you are getting there!"
            },
    title = {
      [gameModes.timeAttack] = "Time Attack on ",
      [gameModes.multiplayer] = "Versus Race on "
    },
    alphabet = {
                "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5",
                "6","7","8","9","$","@","#","!","?","=","&","*","-","<",">","¬"," "
              },
    arrowPositions = {
      [1] = {x = 208,y = 292},
      [2] = {x = 228,y = 292},
      [3] = {x = 248,y = 292},
      [4] = {x = 268,y = 292},
    },
    currentLetter = 1,
    currentSpace = 1,
    recordName = {1,1,1},
    letterArrowUp = Arrow(3,208,292),
    letterArrowDown = Arrow(4,208,328),
}
resultScreen.draw = function (self)
  
  drawMenuBackground()
  love.graphics.print(self.screenDesc,10,10)
  if mode == gameModes.timeAttack then
    self:drawTimeAttackScreen()
  end
end
resultScreen.Initialize = function(self)
  local race = player.race
  if race.totalTime < maplist.selectedMapRecords[1] then
    self.currentPosition = 1
    maplist.selectedMapRecords[3] = maplist.selectedMapRecords[2]
    maplist.selectedMapRecords[2] = maplist.selectedMapRecords[1]
    maplist.selectedMapRecords[1] = race.totalTime
  elseif race.totalTime < maplist.selectedMapRecords[2] then
    self.currentPosition = 2
    maplist.selectedMapRecords[3] = maplist.selectedMapRecords[2]
    maplist.selectedMapRecords[2] = race.totalTime
  elseif race.totalTime < maplist.selectedMapRecords[3] then
    self.currentPosition = 3
    maplist.selectedMapRecords[3] = race.totalTime
  else
    self.currentPosition = 0 
  end
end
resultScreen.update = function (self,dt)
  self.letterArrowUp:update(dt)
  self.letterArrowDown:update(dt)
end
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Drawing functions
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
]]
resultScreen.drawTimeAttackScreen = function(self)
  
  --Print Title
  love.graphics.setFont(self.bigFont)
  love.graphics.print(self.title[mode]..maplist.selectedMapName,love.graphics.getWidth()/2-love.graphics.getWidth()/6,love.graphics.getHeight()/6)
  love.graphics.print(self.position[self.currentPosition],love.graphics.getWidth()/2-love.graphics.getWidth()/32,love.graphics.getHeight()/4)
  --print race times
  local p1race = player.race
  local y = love.graphics.getHeight()/3
  local x = love.graphics.getWidth()/2-love.graphics.getWidth()/16
  for k,time in pairs(maplist.selectedMapRecords) do
    love.graphics.print(race:formatTime(time),x,y)
    y = y+30
  end
  
  
  for k,letter in pairs(self.recordName) do
    love.graphics.print(self.alphabet[letter],x,300)
    x= x+20
  end
    love.graphics.draw(love.graphics.newImage("assets/arrow-enter.png"),x-5,300)
    --love.graphics.print(self.alphabet[self.recordName[1]]..self.alphabet[self.recordName[2]]..self.alphabet[self.recordName[3]],200,300)
    self.letterArrowUp:draw()
    self.letterArrowDown:draw()
    love.graphics.setFont(self.defaultFont)
end
  --TODO: PRogram name entry
resultScreen.nextSpace = function(self,increment)
  newSpace = self.currentSpace + increment
  if newSpace < 1 then
    newSpace = 1
  elseif newSpace > 4 then
    newSpace = 4
  end
  self.currentSpace = newSpace
  self.currentLetter = self.recordName[self.currentSpace] 
  self.letterArrowUp.x = self.arrowPositions[self.currentSpace].x
  self.letterArrowDown.x = self.arrowPositions[self.currentSpace].x
end
--Changes Letters
resultScreen.nextLetter = function(self,increment)
  if self.currentSpace < 4 then
  newLetter = self.currentLetter + increment
  if newLetter < 1 then
    newLetter = #self.alphabet
  elseif newLetter > #self.alphabet then
    newLetter = 1
  end
  
    self.currentLetter = newLetter
    self.recordName[self.currentSpace] = newLetter
  --Notify that the user has pressed something
  end
  if increment > 0 then
    self.letterArrowUp:pressed()
  else
    self.letterArrowDown:pressed()
  end
end
--Confirm
resultScreen.confirm = function(self)
  if self.currentSpace == 4 then
    state = gameStates.mapSelect
  elseif self.currentSpace < 4 then
    --nextSpace
    self:nextSpace(1)
  end
end