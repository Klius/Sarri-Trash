carSelect = {
              bigFont = love.graphics.newFont(30),
              defaultFont = love.graphics.newFont(18)
            }
carSelect.draw = function (self)
                    love.graphics.setColor(223,113,38,255)
                    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
                    love.graphics.setColor(69,40,60,255)
                    love.graphics.rectangle("fill",love.graphics.getWidth()/2-66,23,132,132)
                    love.graphics.setColor(255,255,255,255)

                    love.graphics.rectangle("line",love.graphics.getWidth()/2-67,22,134,134)
                    love.graphics.draw(carlist.preview,love.graphics.getWidth()/2-64,25,0,4)
                    love.graphics.setFont(self.bigFont)
                    love.graphics.print(carlist.cars[carlist.selectedCar].name,love.graphics.getWidth()/2-66,25+142)
                    love.graphics.setFont(self.defaultFont)
                    love.graphics.print(carlist.cars[carlist.selectedCar].description,10,love.graphics.getHeight()/2)


                  end