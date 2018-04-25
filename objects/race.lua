race = {
          lapsTotal = 3,
          currentLap = 0,
          endRace = false,
          sprite = love.graphics.newImage("assets/lap-counter.png"),
          spritesheet = getAnimations(love.graphics.newImage("assets/lap-counter.png"),32,32),
          currentTime = 0,
          timer = 0,
          isTiming = false,
          lapTimes = {0,0,0},
          totalTime = 0
        }
race.nextLap = function (self) 
                  self.currentLap = self.currentLap+1
                  if self.currentLap == self.lapsTotal then
                    self.endRace = true
                    self.currentLap = self.lapsTotal -1
                    self.totalTime = self.lapTimes[1]+self.lapTimes[2]+self.lapTimes[3]
                    resultScreen:Initialize()
                  else
                    self.lapTimes[self.currentLap] = self.currentTime
                    self.timer = love.timer.getTime()
                  end
                end
race.reset = function (self)
                self.currentLap = 0
                self.endRace = false
                self.times = {0,0,0}
                self.currentTime = 0
                self.isTiming = false
                self.timer = 0
             end
race.update = function (self,dt)
                if self.isTiming then
                  self.currentTime = love.timer.getTime() - self.timer
                  self.times[self.currentLap+1] = self.currentTime
                end
                player.speedometer:update(dt,player)
                if mode == gameModes.multiplayer then
                  player2.speedometer:update(dt,player2)
                end
              end
race.draw = function (self)
              love.graphics.draw(self.sprite,self.spritesheet[self.currentLap],80,50,0,1,1)
              if (self.currentLap == 2) then
                love.graphics.draw(self.sprite,self.spritesheet[3],80-32,50,0,1,1)
              end
              love.graphics.print("TIME",love.graphics.getWidth()-100,25)
              love.graphics.print("1:"..self:formatTime(self.times[1]),love.graphics.getWidth()-150,40)
              love.graphics.print("2:"..self:formatTime(self.times[2]),love.graphics.getWidth()-150,60)
              love.graphics.print("3:"..self:formatTime(self.times[3]),love.graphics.getWidth()-150,80)
              player.speedometer:draw()
              if mode == gameModes.multiplayer then
                player2.speedometer:draw(love.graphics.getHeight()/2+50)
              end
            end
race.timerStart = function (self)
                    self.isTiming = true
                    self.timer = love.timer.getTime()
                  end
                  
race.formatTime = function (self,time)
                    if time <= 0 then
                      return "0'00\"000"
                    else
                      mins = string.format("%01.f", math.floor(time/60))
                      secs = string.format("%02.f", math.floor(time - mins *60))
                      millis = string.format("%03.f",math.floor(time*1000 - mins *60000 - secs *1000))
                      return mins .."'"..secs.."\""..millis
                    end
                  end