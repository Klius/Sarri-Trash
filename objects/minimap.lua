Minimap = Object:extend()

function Minimap:new()
  self.minimap = love.graphics.newImage("assets/maps/minimap/F-Ring_256.png")
  self.canvas = love.graphics.newCanvas(256,256)
  self.blipSprite = love.graphics.newImage("assets/maps/minimap/radar-blip.png")
  self.blipSheet = getAnimations(self.blipSprite,8,16)
  self.scale = 12.5
end
function Minimap:update(dt)
  love.graphics.setCanvas(self.canvas)
  love.graphics.clear()
  love.graphics.draw(self.minimap,0,0)
  love.graphics.draw(self.blipSprite,self.blipSheet[0],self:coordinatesToScale(player.x),self:coordinatesToScale(player.y),player.orientation,1,1,4,8)
  if mode == gameModes.multiplayer then
    love.graphics.draw(self.blipSprite,self.blipSheet[1],self:coordinatesToScale(player2.x),self:coordinatesToScale(player2.y),player2.orientation,1,1,4,8)
  end
  love.graphics.setCanvas()
end
function Minimap:draw()
  love.graphics.draw(self.canvas,love.graphics.getWidth()-300,love.graphics.getHeight()-300)
end
function Minimap:coordinatesToScale(coord)
  local scaleCoord = coord/self.scale
  return scaleCoord
end