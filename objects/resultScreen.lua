resultScreen = {
    bigFont = love.graphics.newFont(30),
    defaultFont = love.graphics.newFont(18),
    currentPosition = 0
}
resultScreen.draw = function (self)
                      local y = 100
                      for k,time in pairs(race.times) do
                        love.graphics.print(race:formatTime(time),100,y)
                        if debug then
                          love.graphics.print(time,200,y)
                        end
                        y = y+20
                        
                      end
                      love.graphics.print(race:formatTime(race.totalTime),200,y)
                      
                    end
resultScreen.Initialize = function(self)
                            if race.totalTime < maplist.selectedMapRecords[1] then
                              self.currentPosition = 1
                              maplist.selectedMapRecords[3] = maplist.selectedMapRecords[2]
                              maplist.selectedMapRecords[2] = maplist.selectedMapRecords[1]
                              maplist.selectedMapRecords[1] = race.totalTime
                            elseif race.totalTime < maplist.selectedMapRecords[2] then
                              self.currentPosition = 2
                            elseif race.totalTime < maplist.selectedMapRecords[3] then
                              self.currentPosition = 3
                            else
                             self.currentPosition = 0 
                            end
                          end