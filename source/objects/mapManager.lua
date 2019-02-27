maplist = { 
            maps = {},
            selectedMap = 1,
            preview = love.graphics.newCanvas(400, 275), --400,275
            selectedMapName = "Under Construction",
            selectedMapRecords = { 99999,99999,99999 },
            selectedMapRecordsName = {"AAA","BBB","CCC"},
            selectedMapLapRecord = 999999,
            previewPoints = {{x=800,y=800},{x=800,y=800},{x=1600,y=800}},
            currentPreviewPoint = 1,
            mp = null
          }
maplist.loadMaps = function (self)
                        local dir = "assets/maps"
                        local files = love.filesystem.getDirectoryItems(dir)
                        print("Loading map list")
                        for k, file in ipairs(files) do
                          if string.find(file, ".lua") then
                            table.insert(self.maps,dir.."/"..file)
                          end
                        end
                        self:loadPreview()
                       end
                       
maplist.changeSelectedMap = function (self,increment)
                                  self.selectedMap = self.selectedMap + increment
                                  if self.selectedMap > #self.maps then
                                    self.selectedMap = 1
                                  elseif self.selectedMap <= 0 then
                                    self.selectedMap = #self.maps
                                  end
                                  self:loadPreview()
                                end
maplist.loadMap = function (self)
                    map = sti(self.maps[self.selectedMap],{"bump"})
                    world = bump.newWorld()
                    map:bump_init(world)
                    player:spawnPlayer()
                    if mode == gameModes.multiplayer then
                      player2:spawnPlayer("player2")
                    end
                  end
maplist.loadPreview = function (self)
                        self.mp = sti(self.maps[self.selectedMap])
                        local spawn
                        self:resetDefaults()
                         
                         for k, layer in pairs(self.mp.layers) do
                            if layer.properties.circuitName then
                              self.selectedMapName = layer.properties.circuitName
                            end
                            if layer.properties.first then
                              self.selectedMapRecords[1] = layer.properties.first
                            end
                            if layer.properties.second then
                              self.selectedMapRecords[2] = layer.properties.second
                            end
                            if layer.properties.third then
                              self.selectedMapRecords[3] = layer.properties.third
                            end
                            if layer.properties.firstName then
                              self.selectedMapRecordsName[1] = layer.properties.firstName
                            end
                            if layer.properties.secondName then
                              self.selectedMapRecordsName[2] = layer.properties.secondName
                            end
                            if layer.properties.thirdName then
                              self.selectedMapRecordsName[3] = layer.properties.thirdName
                            end
                            if layer.name == "preview" then
                              self.previewPoints = {}
                              for k, object in pairs(layer.objects) do
                                local point = {x=object.x,y=object.y}
                                self.previewPoints[tonumber(object.name)] = point
                                
                              end
                            end
                         end
                         self:loadRecords()
                        love.graphics.setCanvas(self.preview)
                        local tx = 800 -- math.floor(1600 - 400 / 2)
                        local ty = 800 --math.floor(1600 - 275 / 2)
                        self.mp:draw(-self.previewPoints[1].x,-self.previewPoints[1].y, 0.5)
                        
                        love.graphics.setCanvas()
                      end
maplist.drawPreview = function (self,tx,ty)
                        self.mp = sti(self.maps[self.selectedMap])
                        love.graphics.setCanvas(self.preview)
                        self.mp:draw(-tx,-ty, 0.5)
                                             
                        love.graphics.setCanvas()
                      end
maplist.loadRecords = function(self)
  local savTimes = 0
  local savNames = 0 
  savTimes,savNames = loadRecords(self.selectedMap)
  if savTimes ~= 0 and savNames ~= 0 then
    self.selectedMapRecords = savTimes
    self.selectedMapRecordsName = savNames
  end
end
maplist.resetDefaults = function (self)
                        self.selectedMapName = "Under Construction"
                        self.selectedMapRecords = { 99999,99999,99999 }
                        self.selectedMapRecordsName = {"AAA","BBB","CCC"}
                        self.selectedMapLapRecord = 999999
                        self.previewPoints = {{x=800,y=800},{x=800,y=800},{x=1600,y=800},{x=1600,y=1600},{x=800,y=1600}}
                        self.currentPreviewPoint = 1
                      end
                      