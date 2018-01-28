carlist = {
            cars = {},
            selectedCar = 1,
            preview = love.graphics.newCanvas(32, 32)
          }
carlist.loadCars = function (self)
                        local dir = "assets/cars"
                        local files = love.filesystem.getDirectoryItems(dir)
                       -- print("Loading map list")
                        for k, file in ipairs(files) do
                          if string.find(file, ".lua") then
                          --outputs something like "1. main.lua"
                            print(k .. ". " .. file)
                            local ok,chunk = pcall( love.filesystem.load, dir.."/"..file )
                            local car = chunk()
                            table.insert(self.cars,car)
                            print(car.name.."-"..car.description)
                          end
                        end
                        self:loadPreview()
                       end
carlist.loadPreview = function (self)
                        local car = self.cars[self.selectedCar]
                        love.graphics.setCanvas(self.preview)
                        love.graphics.clear( )
                        love.graphics.draw(car.sprite,car.spritesheet[0],0,0)
                        love.graphics.setCanvas()
                       end
carlist.changeSelectedCar = function (self,increment)
                                  self.selectedCar = self.selectedCar + increment
                                  if self.selectedCar > #self.cars then
                                    self.selectedCar = 1
                                  elseif self.selectedCar <= 0 then
                                    self.selectedCar = #self.cars
                                  end
                                  self:loadPreview()
                                end