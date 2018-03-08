mapSelect = {
              positions = {"1ST","2ND", "3RD"},
              bigFont = love.graphics.newFont(30),
              defaultFont = love.graphics.newFont(18),
              currentPoint = {x=0,y=0},
              time = 0.5,
              leftArrow = Arrow (2,love.graphics.getWidth()/12,love.graphics.getHeight()/6,2),
              rightArrow= Arrow (1,love.graphics.getWidth()-194,love.graphics.getHeight()/6,2)
            }
mapSelect.draw = function (self)
  
                    love.graphics.setColor(223,113,38,255)
                    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
                    love.graphics.setColor(255,255,255,255)
                    love.graphics.rectangle("line",love.graphics.getWidth()/2-201,24,402,277)
                    love.graphics.draw(maplist.preview,love.graphics.getWidth()/2-200,25)
                    love.graphics.setFont(self.bigFont)
                    love.graphics.print(maplist.selectedMapName,love.graphics.getWidth()/2-200,love.graphics.getHeight()/2+10)
                    love.graphics.setFont(self.defaultFont)
                    local times = "" 
                    for i=1,3 do
                      times = times..self.positions[i].."  ".."/  "..race:formatTime(maplist.selectedMapRecords[i]).."  /  "..maplist.selectedMapRecordsName[i] .."\n"
                    end
                    love.graphics.print(times,love.graphics.getWidth()/2-150,love.graphics.getHeight()/2+60)
                    love.graphics.print(" Select a circuit",0,0)
                    self.leftArrow:draw()
                    self.rightArrow:draw()
end
                  
mapSelect.update = function (self,dt)
                      local origin = maplist.previewPoints[1]
                      local destiny = origin
                      local nextPoint = maplist.currentPreviewPoint+1
                      if nextPoint > #maplist.previewPoints then
                          maplist.currentPreviewPoint = 1
                          nextPoint = 2
                      end
                      if #maplist.previewPoints > 1 then
                        destiny = maplist.previewPoints[nextPoint]
                      end
                      if self.currentPoint.x == 0 and self.currentPoint.y == 0 then
                        self.currentPoint = origin
                      end
                      local l = math.sqrt((self.currentPoint.x - destiny.x)^2 + (self.currentPoint.y - destiny.y)^2)
                      local v = 200*dt
                      local t = l/v
                      local dx = ((destiny.x - self.currentPoint.x) / t)
                      local dy = ((destiny.y - self.currentPoint.y) / t)
                      self.currentPoint.x = self.currentPoint.x + dx
                      self.currentPoint.y = self.currentPoint.y  + dy
                      if dx < 0 and math.floor(self.currentPoint.x) < destiny.x
                        or dx > 0 and math.floor(self.currentPoint.x) > destiny.x
                        or dy < 0 and math.floor(self.currentPoint.y) < destiny.y 
                        or dy > 0 and math.floor(self.currentPoint.y) > destiny.y then
                        maplist.currentPreviewPoint = nextPoint
                        --self.currentPoint = destiny
                      end
                      --print("currentPoint:X->"..math.floor(self.currentPoint.x).." Y->"..math.floor(self.currentPoint.y))
                      maplist:drawPreview(self.currentPoint.x,self.currentPoint.y)
                      self.leftArrow:update(dt)
                      self.rightArrow:update(dt)
                    end