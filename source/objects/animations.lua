function getAnimations(sprite,width,height)
  local spritesheet = {}
  local i = 0
  local y = 0
  local x = 0
  while x < sprite:getWidth() do
    spritesheet[i] = love.graphics.newQuad(x,y,width,height,sprite:getDimensions())
    x = x+width
    i = i+1
  end
  return spritesheet
  
end