resultScreen = {
    bigFont = love.graphics.newFont(30),
    defaultFont = love.graphics.newFont(18)
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
                      
                    end