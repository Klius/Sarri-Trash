maplist = { 
            maps = {},
            selectedMap = 1,
            preview = love.graphics.newCanvas(400, 275),
            selectedMapName = "Undisclosed Location",
            selectedMapRecords = { 99999,99999,99999 },
            selectedMapRecordsName = {"AAA","BBB","CCC"},
            selectedMapLapRecord = 999999
          }
maplist.loadMaps = function (self)
                        local dir = "assets/maps"
                        local files = love.filesystem.getDirectoryItems(dir)
                        print("Loading map list")
                        for k, file in ipairs(files) do
                          if string.find(file, ".lua") then
                          --outputs something like "1. main.lua"
                            --print(k .. ". " .. file)
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
                  end
maplist.loadPreview = function (self)
                        local mp = sti(self.maps[self.selectedMap])
                        local spawn
                        self:resetDefaults()
                         for k, object in pairs(mp.objects) do
                            if object.name == "Player" then
                              spawn = object
                              break
                            end
                         end
                         for k, layer in pairs(mp.layers) do
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
                         end
                        love.graphics.setCanvas(self.preview)
                        local tx = math.floor(1600 - 500 / 2)
                        local ty = math.floor(1600 - 400 / 2)
                        mp:draw(-1600,-1600, 0.5)
                                             
                        love.graphics.setCanvas()
                      end
maplist.resetDefaults = function (self)
                        self.selectedMapName = "Undisclosed Location"
                        self.selectedMapRecords = { 99999,99999,99999 }
                        self.selectedMapRecordsName = {"AAA","BBB","CCC"}
                        self.selectedMapLapRecord = 999999
                      end