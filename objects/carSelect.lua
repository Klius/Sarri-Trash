carSelect = {}
carSelect.draw = function (self)
                    love.graphics.setColor(223,113,38,255)
                    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
                    love.graphics.setColor(255,255,255,255)
                    love.graphics.draw(carlist.preview,love.graphics.getWidth()/2-16,25)
                    love.graphics.print(carlist.cars[carlist.selectedCar].name,love.graphics.getWidth()/2-32,25+32)
                    
                  end