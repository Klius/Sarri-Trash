resultScreen = {
    bigFont = love.graphics.newFont(30),
    defaultFont = love.graphics.newFont(18),
    currentPosition = 0,
    texts = { [1] = "Awesome!! You got the best time!!",
              [2] = "Phenomenal!! You are a step closer to being the Best",
              [3] = "Congratulations!! With more effort you can do it better!",
              [0] = "Keep on trying you are getting there!"
            },
    alphabet = {
                "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5",
                "6","7","8","9","$","@","#","!","?","=","&","*","-","<",">","¬"
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
  love.graphics.setColor(223,113,38,255)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(255,255,255,255)
  local y = 100
  local x = 200
  --print race times
  for k,time in pairs(race.times) do
    love.graphics.print(k.."-"..race:formatTime(time),100,y)
    y = y+20
  end
  --print total time just below
  love.graphics.line(100,y,200,y)
  y=y+10
  love.graphics.print("Total-"..race:formatTime(race.totalTime),100,y)
  love.graphics.print(self.texts[self.currentPosition],200,400)
  for k,letter in pairs(self.recordName) do
    love.graphics.print(self.alphabet[letter],x,300)
    x= x+20
  end
    love.graphics.draw(love.graphics.newImage("assets/arrow-enter.png"),x-5,300)
    --love.graphics.print(self.alphabet[self.recordName[1]]..self.alphabet[self.recordName[2]]..self.alphabet[self.recordName[3]],200,300)
    self.letterArrowUp:draw()
    self.letterArrowDown:draw()
end
resultScreen.Initialize = function(self)
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
  if self.currentSpace == 4 and self.enteringName then
  
  end
end