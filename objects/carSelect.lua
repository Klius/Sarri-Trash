carSelect = {
              bigFont = love.graphics.newFont(30),
              defaultFont = love.graphics.newFont(18),
              leftArrow = Arrow (2,love.graphics.getWidth()/3,love.graphics.getHeight()/7),
              rightArrow= Arrow (1,love.graphics.getWidth()-love.graphics.getWidth()/3,love.graphics.getHeight()/7),
              player = 1,
              speed = StatBar(300,300,12,15,"Top Speed",{r=172,g=50,b=50}),
              acceleration = StatBar(300,332,10,30,"Acceleration",{r=34,g=32,b=52})
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
                    love.graphics.print("Player "..self.player,0,0)
                    love.graphics.setFont(self.defaultFont)
                    love.graphics.print(carlist.cars[carlist.selectedCar].description,10,love.graphics.getHeight()/2)
                    self.leftArrow:draw()
                    self.rightArrow:draw()
                    self.speed:draw()
                    self.acceleration:draw()
end
carSelect.update = function (self,dt)
  self.leftArrow:update(dt)
  self.rightArrow:update(dt)
  --statusbars!
  self.speed.stat = carlist.cars[carlist.selectedCar].topSpeed
  self.acceleration.stat = carlist.cars[carlist.selectedCar].acceleration
end
carSelect.confirm = function(self,id)
  if defTransition.endTransition == true then
    if mode == gameModes.multiplayer and carSelect.player == 1 and id ==player.gamepad then
        player.car = carlist.cars[carlist.selectedCar]
        self.player = 2
        defTransition:start()
    elseif mode == gameModes.multiplayer and carSelect.player == 2 and id == player2.gamepad then
      player2.car = carlist.cars[carlist.selectedCar]
      self.player = 1
      defTransition:start()
      maplist:loadMap()
      race:reset()
      state = gameStates.gameLoop
  --SINGLEPLAYER
    elseif mode ~= gameModes.multiplayer  then
      self.player = 1
      player.car = carlist.cars[carlist.selectedCar]
      maplist:loadMap()
      defTransition:start()
      race:reset()
      state = gameStates.gameLoop
    end
  end
end