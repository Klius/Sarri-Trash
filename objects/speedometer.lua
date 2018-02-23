speedometer = { 
                fullSquares = 0,
                squares = 9,
                colors = { 
                            [0]={r=255,b=255,g=255,o=255},
                            [1]={r=255,b=255,g=255,o=255},
                            [2]={r=255,b=255,g=255,o=255},
                            [3]={r=255,b=255,g=255,o=255},
                            [4]={r=255,b=255,g=255,o=255},
                            [5]={r=255,b=255,g=255,o=255},
                            [6]={r=255,b=255,g=255,o=255},
                            [7]={r=255,b=255,g=255,o=255},
                            [8]={r=253,b=50,g=50,o=255},
                            [9]={r=255,b=0,g=0,o=255},
                            [10] = {r=255,b=0,g=0,o=255}
                          },
                uiSpeed = 0
              }
              
speedometer.draw = function (self)
                      local x = love.graphics.getHeight()/2
                      local y = 50
                      for i=0,self.squares do
                        love.graphics.setColor(0,0,0,255)
                        love.graphics.rectangle("line",x,y,16,16)
                        if self.fullSquares > 0 then 
                          love.graphics.setColor(self.colors[i].r,self.colors[i].b,self.colors[i].g,self.colors[i].o)
                          love.graphics.rectangle("fill",x,y,16,16)
                          self.fullSquares = self.fullSquares - 1 
                        end
                        
                        x = x+16
                      end
                      love.graphics.setColor(0,0,0,255)
                      love.graphics.rectangle("line",x,y-8,48,32)
                      love.graphics.rectangle("fill",x,y-8,48,32)
                      love.graphics.setColor(255,255,255,255)
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