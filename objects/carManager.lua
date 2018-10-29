carlist = {
            cars = {},
            selectedCar = 1,
            preview = love.graphics.newCanvas(32, 32),
            currentFrame = 1,
            frameDuration = 5,
            frameCount = 0
          }
carlist.loadCars = function (self)
                        local dir = "assets/cars"
                        local files = love.filesystem.getDirectoryItems(dir)
                       -- print("Loading map list")
                        for k, file in ipairs(files) do
                          if string.find(file, ".lua") then
                          --outputs something like "1. main.lua"
                            --print(k .. ". " .. file)
                            local ok,chunk = pcall( love.filesystem.load, dir.."/"..file )
                            local car = chunk()
                            table.insert(self.cars,car)
                            --print(car.name.."-"..car.description)
                          end
                        end
                        self:updatePreview()
                       end
carlist.updatePreview = function (self)
                        local car = self.cars[self.selectedCar]
                        love.graphics.setCanvas(self.preview)
                        love.graphics.clear( )
                        self.frameCount = self.frameCount + 1
                        if self.frameCount > self.frameDuration then
                          self.frameCount = 0
                          self.currentFrame = 1 + self.currentFrame
                          if self.currentFrame > #car.spritesheet then
                            self.currentFrame = 1
                          end
                        end
                        love.graphics.draw(car.sprite,car.spritesheet[self.currentFrame],0,0,0,car.previewScale)
                        love.graphics.setCanvas()
                       end
carlist.changeSelectedCar = function (self,increment)
                                  self.selectedCar = self.selectedCar + increment
                                  if self.selectedCar > #self.cars then
                                    self.selectedCar = 1
                                  elseif self.selectedCar <= 0 then
                                    self.selectedCar = #self.cars
                                  end
                                  self:updatePreview()
                                end