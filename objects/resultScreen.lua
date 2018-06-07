resultScreen = {
    bigFont = love.graphics.newFont(30),
    defaultFont = love.graphics.newFont(18),
    currentPosition = 0,
    screenDesc = "-Results-",
    position = { 
              [1] = "1ST",
              [2] = "2ND",
              [3] = "3RD",
              [0] = "Keep on trying you are getting there!"
            },
    title = {
      [gameModes.timeAttack] = "Time Attack on ",
      [gameModes.multiplayer] = "Versus Race on "
    },
    descriptions = {
      [gameModes.timeAttack] = "Please enter a Name",
      [gameModes.multiplayer] = ""
    },
    alphabet = {
                "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5",
                "6","7","8","9","$","@","#","!","?","=","&","*","-","<",">","¬"," "
              },
    arrowPositions = {
      [1] = {x = love.graphics.getWidth()/2-love.graphics.getWidth()/42},
      [2] = {x = love.graphics.getWidth()/2},
      [3] = {x = love.graphics.getWidth()/2+love.graphics.getWidth()/42},
      [4] = {x = love.graphics.getWidth()/2+love.graphics.getWidth()/20},
    },
    currentLetter = 1,
    currentSpace = 1,
    recordName = {1,1,1},
    letterArrowUp = Arrow(3,love.graphics.getWidth()/2-love.graphics.getWidth()/42,love.graphics.getHeight()/2+love.graphics.getHeight()/16),
    letterArrowDown = Arrow(4,love.graphics.getWidth()/2-love.graphics.getWidth()/42,love.graphics.getHeight()/2+love.graphics.getHeight()/8),
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
  local x = love.graphics.getWidth()/2-love.graphics.getWidth()/12
  --print times with names
  for k,time in pairs(maplist.selectedMapRecords) do
    love.graphics.print(race:formatTime(time),x,y)
    if k ~= self.currentPosition then
      love.graphics.print(maplist.selectedMapRecordsName[k],x+150,y)
    else
      
      local playerName = self.alphabet[self.recordName[1]]..self.alphabet[self.recordName[2]]..self.alphabet[self.recordName[3]]
      love.graphics.print(playerName,x+150,y)
    end
    y = y+30
  end
  --Draw name selector
  y = y+50
  love.graphics.print(self.descriptions[mode],x-love.graphics.getWidth()/32,y)
  y = y+50
  x = love.graphics.getWidth()/2-love.graphics.getWidth()/32
  for k,letter in pairs(self.recordName) do
    love.graphics.print(self.alphabet[letter],x,y)
    x= x+30
  end
    love.graphics.draw(love.graphics.newImage("assets/arrow-enter.png"),x-5,y+5)
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
--TODO save permanently the record
resultScreen.confirm = function(self)
  if self.currentSpace == 4 then
    local playerName = self.alphabet[self.recordName[1]]..self.alphabet[self.recordName[2]]..self.alphabet[self.recordName[3]]
    maplist.selectedMapRecordsName[self.currentPosition] =  playerName
    state = gameStates.mapSelect
  elseif self.currentSpace < 4 then
    --nextSpace
    self:nextSpace(1)
  end
end