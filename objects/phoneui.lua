phoneUI = {
            sprite = love.graphics.newImage("assets/touch-butt.png"),
            spritesheet = getAnimations(love.graphics.newImage("assets/touch-butt.png"),256,256),
            buttons= {  {x = love.graphics.getWidth()-256, y=love.graphics.getHeight()-192, width = 256, height = 256, key = "a",isdown = false},--a button
                        {x = love.graphics.getWidth()-384, y=love.graphics.getHeight()-192, width = 256, height = 256, key = "x",isdown = false},
                        {x = 12, y=love.graphics.getHeight()-256, width = 256, height = 256, key = "dpleft",isdown = false},
                        {x = 256, y=love.graphics.getHeight()-256, width = 256, height = 256, key = "dpright",isdown = false}
                      },
          }
phoneUI.draw = function(self)
                  if love.system.getOS() == "Android" then
                    love.graphics.draw(self.sprite,self.spritesheet[4],self.buttons[1]["x"],self.buttons[1]["y"])
                    love.graphics.draw(self.sprite,self.spritesheet[5],self.buttons[2]["x"],self.buttons[2]["y"])
                    love.graphics.draw(self.sprite,self.spritesheet[3],self.buttons[3]["x"],self.buttons[3]["y"])
                    love.graphics.draw(self.sprite,self.spritesheet[2],self.buttons[4]["x"],self.buttons[4]["y"])
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