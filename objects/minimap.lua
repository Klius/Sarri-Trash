Minimap = Object:extend()

function Minimap:new()
  self.minimap = love.graphics.newImage("assets/maps/minimap/F-Ring_256.png")
  self.canvas = love.graphics.newCanvas(256,256)
end
function Minimap:update(dt)
  love.graphics.setCanvas(self.canvas)
  love.graphics.draw(self.minimap,0,0)
  love.graphics.setCanvas()
end
function Minimap:draw()
  love.graphics.draw(self.canvas,love.graphics.getWidth()-300,love.graphics.getHeight()-300)
end