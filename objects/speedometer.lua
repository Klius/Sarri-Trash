speedometer = { 
                fullSquares = 0,
                squares = 10,
              }
              
speedometer.draw = function (self)
                      local x = love.graphics.getHeight()/2
                      local y = 50
                      for i=0,self.squares do
                        love.graphics.setColor(0,0,0,255)
                        love.graphics.rectangle("line",x,y,16,16)
                        if self.fullSquares > 0 then 
                          love.graphics.setColor(255,255,0,255)
                          love.graphics.rectangle("fill",x,y,16,16)
                          self.fullSquares = self.fullSquares - 1 
                        end
                        
                        x = x+16
                      end
                      love.graphics.setColor(255,255,255,255)
                      love.graphics.print(self.speedDiff,love.graphics.getHeight()/2,30)
                   end
                   
speedometer.update = function (self,dt)
                        self.speedDiff =  player.currentSpeed
                        self.fullSquares = math.floor(self.speedDiff) 
                      end