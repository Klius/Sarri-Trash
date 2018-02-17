resultScreen = {
    bigFont = love.graphics.newFont(30),
    defaultFont = love.graphics.newFont(18),
    currentPosition = 0,
    texts = { [1] = "Awesome!! You got the best time!!",
              [2] = "Phenomenal!! You are a step closer to being the Best",
              [3] = "Congratulations!! With more effort you can do it better!",
              [0] = "Keep on trying you are getting there!"
            },
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
                      love.graphics.print(self.texts[self.currentPosition],200,400)
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