mapSelect = {
              positions = {"1ST","2ND", "3RD"},
              bigFont = love.graphics.newFont(30),
              defaultFont = love.graphics.newFont(18)
            }
mapSelect.draw = function (self)
  
                    --selectedMapRecords = { 99999,99999,99999 },
                    --selectedMapRecordsName = {"AAA","BBB","CCC"},
                    --selectedMapLapRecord = 999999
                    love.graphics.setColor(223,113,38,255)
                    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
                    love.graphics.setColor(255,255,255,255)
                    love.graphics.rectangle("line",199,24,402,277)
                    love.graphics.draw(maplist.preview,200,25)
                    love.graphics.setFont(self.bigFont)
                    love.graphics.print(maplist.selectedMapName,love.graphics.getWidth()/2-200,love.graphics.getHeight()/2+10)
                    love.graphics.setFont(self.defaultFont)
                    local times = "" 
                    for i=1,3 do
                      times = times..self.positions[i].."  ".."/  "..race:formatTime(maplist.selectedMapRecords[i]).."  /  "..maplist.selectedMapRecordsName[i] .."\n"
                    end
                    love.graphics.print(times,love.graphics.getWidth()/2-150,love.graphics.getHeight()/2+60)
                    --love.graphics.print("Key pressed:"..keydebug)
                    --love.graphics.print("Pulsa [Espacio] para empezar",love.graphics.getWidth()/2,love.graphics.getHeight()/2+25)
                    --love.graphics.print("Pulsa [<-] para mover el coche a la izquierda",125,love.graphics.getHeight()/2+20)
                    --love.graphics.print("Pulsa [->] para mover el coche a la derecha",125,love.graphics.getHeight()/2+40)
                    --love.graphics.print("Pulsa [x] para frenar/marcha atras el coche",125,love.graphics.getHeight()/2+60)
                    --love.graphics.print("Pulsa [espacio] para acelerar el coche",125,love.graphics.getHeight()/2+80)
                  end