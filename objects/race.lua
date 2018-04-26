race = {
          endRace = false,
          sprite = love.graphics.newImage("assets/lap-counter.png"),
          spritesheet = getAnimations(love.graphics.newImage("assets/lap-counter.png"),32,32),
        }
race.nextLap = function (self, player)
                  local race = player.race
                  race.currentLap = race.currentLap+1
                  if race.currentLap >= race.lapsTotal then
                    self.endRace = true
                    race.currentLap = race.lapsTotal -1
                    race.totalTime = race.lapTimes[1]+race.lapTimes[2]+race.lapTimes[3]
                    player.race = race
                    resultScreen:Initialize()
                  else
                    race.lapTimes[race.currentLap] = race.currentTime
                    race.timer = love.timer.getTime()
                    player.race = race
                  end
                end
race.reset = function (self)
                self.endRace = false
                local race = {
                  lapsTotal = 3,
                  currentLap = 0,
                  lapTimes = {0,0,0},
                  currentTime = 0,
                  isTiming = false,
                  timer = 0,
                  totalTime = 0
                }
                player.race = race
                player2.race = race
             end
race.update = function (self,dt)
                if player.race.isTiming then
                  player.race.currentTime = love.timer.getTime() - player.race.timer
                  player.race.lapTimes[player.race.currentLap+1] = player.race.currentTime
                end
                player.speedometer:update(dt,player)
                if mode == gameModes.multiplayer then
                  player2.speedometer:update(dt,player2)
                end
              end
race.draw = function (self)
              love.graphics.draw(self.sprite,self.spritesheet[player.race.currentLap],80,50,0,1,1)
              if (player.race.currentLap == 2) then
                love.graphics.draw(self.sprite,self.spritesheet[3],80-32,50,0,1,1)
              end
              love.graphics.print("TIME",love.graphics.getWidth()-100,25)
              love.graphics.print("1:"..self:formatTime(player.race.lapTimes[1]),love.graphics.getWidth()-150,40)
              love.graphics.print("2:"..self:formatTime(player.race.lapTimes[2]),love.graphics.getWidth()-150,60)
              love.graphics.print("3:"..self:formatTime(player.race.lapTimes[3]),love.graphics.getWidth()-150,80)
              player.speedometer:draw()
              if mode == gameModes.multiplayer then
                player2.speedometer:draw(love.graphics.getHeight()/2+50)
              end
            end
race.timerStart = function (self,player)
                    player.race.isTiming = true
                    player.race.timer = love.timer.getTime()
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