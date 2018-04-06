carSelect = {
              bigFont = love.graphics.newFont(30),
              defaultFont = love.graphics.newFont(18),
              leftArrow = Arrow (2,love.graphics.getWidth()/3,love.graphics.getHeight()/7),
              rightArrow= Arrow (1,love.graphics.getWidth()-love.graphics.getWidth()/3,love.graphics.getHeight()/7)
            }
carSelect.draw = function (self)
                    love.graphics.setColor(0.87,0.44,0.14,1)
                    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
                    love.graphics.setColor(251/255,242/255,54/255,1)
                    love.graphics.rectangle("fill",love.graphics.getWidth()/2-66,23,132,132)
                    love.graphics.setColor(0,0,0,1)

                    love.graphics.rectangle("line",love.graphics.getWidth()/2-67,22,134,134)
                    love.graphics.setColor(1,1,1,1)
                    love.graphics.draw(carlist.preview,love.graphics.getWidth()/2-64,25,0,4)
                    love.graphics.setFont(self.bigFont)
                    love.graphics.print(carlist.cars[carlist.selectedCar].name,love.graphics.getWidth()/2-125,25+142)
                    love.graphics.setFont(self.defaultFont)
                    love.graphics.print(carlist.cars[carlist.selectedCar].description,10,love.graphics.getHeight()/2)
                    self.leftArrow:draw()
                    self.rightArrow:draw()
end
carSelect.update = function (self,dt)
  self.leftArrow:update(dt)
  self.rightArrow:update(dt)
end