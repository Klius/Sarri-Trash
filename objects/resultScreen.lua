resultScreen = {
    bigFont = love.graphics.newFont(30),
    counterFont = love.graphics.newFont(90),
    defaultFont = love.graphics.newFont(18),
    currentPosition = 0,
    winCount = {
      [1] = 0,
      [2] = 0
    },
    screenDesc = "-Results-",
    position = { 
              [1] = "1ST",
              [2] = "2ND",
              [3] = "3RD",
              [0] = "LAST"
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
      [1] = {x = love.graphics.getWidth()/2-love.graphics.getWidth()/40},
      [2] = {x = love.graphics.getWidth()/2-love.graphics.getWidth()/40+30},
      [3] = {x = love.graphics.getWidth()/2-love.graphics.getWidth()/40+60},
      [4] = {x = love.graphics.getWidth()/2-love.graphics.getWidth()/40+90},
    },
    currentLetter = 1,
    currentSpace = 1,
    recordName = {1,1,1},
    letterArrowUp = Arrow(3,love.graphics.getWidth()/2-love.graphics.getWidth()/40,love.graphics.getHeight()/3+180),
    letterArrowDown = Arrow(4,love.graphics.getWidth()/2-love.graphics.getWidth()/40,love.graphics.getHeight()/3+190+50),
    adjustor = 4
}
resultScreen.draw = function (self)
  
  drawMenuBackground()
  love.graphics.print(self.screenDesc,10,10)
  if mode == gameModes.timeAttack then
    self:drawTimeAttackScreen()
  else
    self:drawMultiplayerScreen()
  end
end
resultScreen.Initialize = function(self)
  if mode == gameModes.timeAttack then
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
  else
    if player.cameFirst == true then
      self.winCount[1] = self.winCount[1] + 1
      self.descriptions[gameModes.multiplayer] = "Player 1 Won !!"
      player.cameFirst = false
    else
      self.winCount[2] = self.winCount[2] + 1
      player2.cameFirst = false
      self.descriptions[gameModes.multiplayer] = "Player 2 Won !!"
    end
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
--[[  MULTIPLAYER ]]
resultScreen.drawMultiplayerScreen = function(self)
  love.graphics.setFont(self.bigFont)
  love.graphics.print(self.title[mode]..maplist.selectedMapName,love.graphics.getWidth()/2-love.graphics.getWidth()/6,love.graphics.getHeight()/6)
--Winner Counter
  love.graphics.setFont(self.counterFont)
  love.graphics.print(self.descriptions[gameModes.multiplayer],love.graphics.getWidth()/2-love.graphics.getWidth()/4,love.graphics.getHeight()/3)
  local x,y = love.graphics.getWidth()/2-love.graphics.getWidth()/5,love.graphics.getHeight()/2
  local string = ""
  if self.winCount[1] <= 9 then
    string = "0"..self.winCount[1]
  else
    string = self.winCount[1]
  end
  string = string.."\t-\t"
  if self.winCount[2] <= 9 then
    string = string.."0"..self.winCount[2]
  else
    string = string..self.winCount[2]
  end
  love.graphics.setColor(0,0,0,1)
  love.graphics.print(string,x,y)
  love.graphics.setColor(1,1,1,1)
  love.graphics.print('P1\t \tP2',x,y+100)
  love.graphics.setFont(self.bigFont)
  love.graphics.print('Press any button to continue',x+25,y+love.graphics.getHeight()/3)
  --return font to normal
  love.graphics.setFont(self.defaultFont)
end
--[[  TIME ATTACK ]]
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
  --Update arrows to show as pressed
  if increment > 0 then
    self.letterArrowDown:pressed()
  else
    self.letterArrowUp:pressed()
  end
end
--TODO save permanently the record
resultScreen.confirm = function(self)
  if mode == gameModes.timeAttack then
    if self.currentSpace == 4 then
      local playerName = self.alphabet[self.recordName[1]]..self.alphabet[self.recordName[2]]..self.alphabet[self.recordName[3]]
      maplist.selectedMapRecordsName[self.currentPosition] =  playerName
      state = gameStates.mapSelect
    elseif self.currentSpace < 4 then
      --nextSpace
      self:nextSpace(1)
    end
  else
    state = gameStates.mapSelect
  end
end
--[[ 
  RESETS MULTIPLAYER COUNTER
]]
resultScreen.resetWinnerCount = function(self)
  self.winCount = {
      [1] = 0,
      [2] = 0
    }
end