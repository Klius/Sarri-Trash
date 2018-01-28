phoneUI = {
            sprite = love.graphics.newImage("assets/touch-butt.png"),
            spritesheet = getAnimations(love.graphics.newImage("assets/touch-butt.png"),128,128),
            buttons= {  {x = love.graphics.getWidth()-128, y=love.graphics.getHeight()-192, width = 128, height = 128, key = "a"},--a button
                        {x = love.graphics.getWidth()-256, y=love.graphics.getHeight()-192, width = 128, height = 128, key = "x"},
                        {x = 64, y=love.graphics.getHeight()-192, width = 128, height = 128, key = "dpleft"},
                        {x = 192, y=love.graphics.getHeight()-192, width = 128, height = 128, key = "dpright"}
                      }
          }
phoneUI.draw = function(self)
                  if love.system.getOS() == "Android" then
                    love.graphics.draw(self.sprite,self.spritesheet[0],self.buttons[1]["x"],self.buttons[1]["y"])
                    love.graphics.draw(self.sprite,self.spritesheet[1],self.buttons[2]["x"],self.buttons[2]["y"])
                    love.graphics.draw(self.sprite,self.spritesheet[2],self.buttons[3]["x"],self.buttons[3]["y"])
                    love.graphics.draw(self.sprite,self.spritesheet[3],self.buttons[4]["x"],self.buttons[4]["y"])
                    --DEBUG
                    --love.graphics.points(self.buttons[1].x+self.buttons[1].width,self.buttons[1].y+self.buttons[1].height)
                    love.graphics.rectangle("line",touchdebug.x,touchdebug.y,touchdebug.dx,touchdebug.dy)
                  end
                end
phoneUI.checkButtonTouched = function(self,touchX,touchY,touchWidth,touchHeight)
                                for k in pairs(self.buttons) do
                                  local rx = self.buttons[k].x + self.buttons[k].width
                                  local ry = self.buttons[k].y + self.buttons[k].height
                                  if (touchX < self.buttons[k].x+self.buttons[k].width and
                                       self.buttons[k].x < touchX+touchWidth and
                                       touchY < self.buttons[k].y+self.buttons[k].height and
                                       self.buttons[k].y < touchY+touchHeight) then
                                        return self.buttons[k]["key"]
                                  end
                                end
                              end