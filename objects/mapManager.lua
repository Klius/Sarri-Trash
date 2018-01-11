maplist = { 
            maps = {},
            selectedMap = 1,
            preview = love.graphics.newCanvas(3200, 3200)
          }
maplist.loadMaps = function (self)
                        local dir = "assets/maps"
                        local files = love.filesystem.getDirectoryItems(dir)
                        print("Loading map list")
                        for k, file in ipairs(files) do
                          if string.find(file, ".lua") then
                          --outputs something like "1. main.lua"
                            print(k .. ". " .. file)
                            table.insert(self.maps,dir.."/"..file)
                          end
                        end
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
                    spawnPlayer()
                  end
maplist.loadPreview = function (self)
                        local mp = sti(maplist.maps[maplist.selectedMap])
                        local spawn
                         for k, object in pairs(mp.objects) do
                            if object.name == "Player" then
                              spawn = object
                              break
                            end
                         end
                        love.graphics.setCanvas(self.preview)
                        local tx = math.floor(1600 - 500 / 2)
                        local ty = math.floor(1600 - 400 / 2)
                        mp:draw(-1600,-1600, 0.5)
                                             
                        love.graphics.setCanvas()
                      end