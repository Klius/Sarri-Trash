speedometer = { 
                fullSquares = 0,
                squares = 9,
                colors = { 
                            [0]={r=1,b=1,g=1,o=1},
                            [1]={r=1,b=1,g=1,o=1},
                            [2]={r=1,b=1,g=1,o=1},
                            [3]={r=1,b=1,g=1,o=1},
                            [4]={r=1,b=1,g=1,o=1},
                            [5]={r=1,b=1,g=1,o=1},
                            [6]={r=1,b=1,g=1,o=1},
                            [7]={r=1,b=1,g=1,o=1},
                            [8]={r=0.99,b=0.19,g=0.19,o=1},
                            [9]={r=1,b=0,g=0,o=1},
                            [10] = {r=1,b=0,g=0,o=1}
                          },
                uiSpeed = 0
              }
              
speedometer.draw = function (self)
                      local x = love.graphics.getHeight()/2
                      local y = 50
                      for i=0,self.squares do
                        love.graphics.setColor(0,0,0,1)
                        love.graphics.rectangle("line",x,y,16,16)
                        if self.fullSquares > 0 then 
                          love.graphics.setColor(self.colors[i].r,self.colors[i].b,self.colors[i].g,self.colors[i].o)
                          love.graphics.rectangle("fill",x,y,16,16)
                          self.fullSquares = self.fullSquares - 1 
                        end
                        
                        x = x+16
                      end
                      love.graphics.setColor(0,0,0,1)
                      love.graphics.rectangle("line",x,y-8,48,32)
                      love.graphics.rectangle("fill",x,y-8,48,32)
                      love.graphics.setColor(1,1,1,1)
                      love.graphics.print(self.uiSpeed,x+5,y-4,0)
                   end
                   
speedometer.update = function (self,dt)
                        self.speedDiff =  player.currentSpeed
                        if player.currentSpeed == player.car.topSpeed then
                          self.speedDiff = 10
                        end
                        if player.currentSpeed <0 then
                          self.uiSpeed = 'R'
                        else
                          self.uiSpeed = math.floor(player.currentSpeed*5)
                        end
                        
                        self.fullSquares = math.floor(self.speedDiff) 
                      end