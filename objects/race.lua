race = {
          endRace = false,
          sprite = love.graphics.newImage("assets/lap-counter.png"),
          spritesheet = getAnimations(love.graphics.newImage("assets/lap-counter.png"),32,32),
          minimap = Minimap()
        }
race.nextLap = function ( self,player)
                  local race = player.race
                  race.currentLap = race.currentLap+1
                  if race.currentLap >= race.lapsTotal then
                    self.endRace = true
                    race.currentLap = race.lapsTotal -1
                    race.totalTime = race.lapTimes[1]+race.lapTimes[2]+race.lapTimes[3]
                    player.race = race
                    player.cameFirst = true
                    resultScreen:Initialize()
                  else
                    race.lapTimes[race.currentLap] = race.currentTime
                    race.timer = love.timer.getTime()
                    player.race = race
                  end
                end
race.reset = function (self)
                self.endRace = false
                player:raceReset()
                player2:raceReset()
                self:changeBackgroundAudio()
             end
race.changeBackgroundAudio = function(self)
  math.randomseed(os.time())
  local numberoftracks = table.getn(audiomanager.audios.race)
  local randomTrack = math.random(1,numberoftracks)
  audiomanager:changeTrack(audiomanager.audios.race[randomTrack])
end
race.update = function (self,dt)
                if player.race.isTiming then
                  player.race.currentTime = love.timer.getTime() - player.race.timer
                  player.race.lapTimes[player.race.currentLap+1] = player.race.currentTime
                end
                
                player.speedometer:update(dt,player)
                if mode == gameModes.multiplayer then
                  if player2.race.isTiming then
                    player2.race.currentTime = love.timer.getTime() - player2.race.timer
                    player2.race.lapTimes[player2.race.currentLap+1] = player2.race.currentTime
                  end
                  player2.speedometer:update(dt,player2)
                end
                self.minimap:update(dt)
              end
race.draw = function (self)
              love.graphics.draw(self.sprite,self.spritesheet[player.race.currentLap],80,50,0,1,1)
              if (player.race.currentLap == 2) then
                love.graphics.draw(self.sprite,self.spritesheet[3],80-32,50,0,1,1)
              end
              self:drawTime(player,love.graphics.getWidth(),25)
              player.speedometer:draw()
              if mode == gameModes.multiplayer then
                self:drawTime(player2,love.graphics.getWidth(),love.graphics.getHeight()/2+25)
                player2.speedometer:draw(love.graphics.getHeight()/2+50)
                love.graphics.draw(self.sprite,self.spritesheet[player2.race.currentLap],80,love.graphics.getHeight()/2+50,0,1,1)
                if (player2.race.currentLap == 2) then
                  love.graphics.draw(self.sprite,self.spritesheet[3],80-32,love.graphics.getHeight()/2+50,0,1,1)
                end
              end
              self.minimap:draw()
            end
race.drawTime = function (self,player,x,y)
  love.graphics.print("TIME",x-100,y)
  local numbo = 1
  for k,time in pairs(player.race.lapTimes) do
    y = y +20
    love.graphics.print(numbo..":"..self:formatTime(time),
      x-150,y)
    numbo = numbo +1
  end
end
race.initMinimap = function (mapName)
  
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