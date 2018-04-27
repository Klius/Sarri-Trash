controllerScreen = {
  bigFont = love.graphics.newFont(30),
  defaultFont = love.graphics.newFont(18),
  contImage = love.graphics.newImage("assets/controller256.png"),
  keyImage = love.graphics.newImage("assets/keyboard256.png"),
  positionY ={
    [1] = 50,
    [0] = love.graphics.getHeight()/2-128,
    [-1] = love.graphics.getHeight() -love.graphics.getHeight()/4
  },
  labels = {
    [1] = "Player 1",
    [0] = "Controllers",
    [-1] = "Player 2",
  },
  gamepads={
    keyboard = 0
  }
}
controllerScreen.update = function (self,dt)

end
controllerScreen.draw = function(self,dt)
  love.graphics.setColor(223/255,113/255,38/255,1)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
  love.graphics.setColor(1,1,1,1)
  local x = 50
  love.graphics.setFont(self.bigFont)
  love.graphics.print("Select your controller",love.graphics.getWidth()/2-150,0)
  for i ,label in pairs(self.labels) do
    love.graphics.print(label,x,self.positionY[i]+64)
  end
  love.graphics.setFont(self.defaultFont)
  x = love.graphics.getWidth()/4
  for i, pad in pairs(self.gamepads) do
    if i =="keyboard" then
      love.graphics.draw(self.keyImage,x,self.positionY[pad])
    else
      love.graphics.draw(self.contImage,x,self.positionY[pad])
    end
    x = x+356
  end
end

controllerScreen.moveController = function (self, inputID, up)
  if self.gamepads[inputID] then
    local gpos = self.gamepads[inputID]
    if up then
      gpos = gpos+1
      if gpos > 1 then gpos = 1 end
    else
      gpos = gpos-1
      if gpos < -1 then gpos = -1 end
    end
    self.gamepads[inputID] = gpos
  end
end
controllerScreen.assignControllers = function (self)
  local p1,p2 = false
  local gpad1,gpad2 = ""
  for i,gpos in pairs(self.gamepads) do
    if gpos == 1 then
      p1 = true
      gpad1 = i
    elseif gpos == -1 then
      p2 = true
      gpad2 = i
    end
  end
  if p1 == true and p2 == true then
    player.gamepad = gpad1
    player2.gamepad = gpad2
    state = gameStates.mapSelect
  end
end
--Returns the gamepad
controllerScreen.gamepadCount = function (self)
  local count = 0
  for _ in pairs(self.gamepads) do
    count = count +1
  end
  return count
end