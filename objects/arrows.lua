Arrow = Object:extend()


function Arrow:update(dt)
  self.frameCount = self.frameCount + dt
  if self.frameCount > self.frameDuration then
    self.frameCount = 0
    self.currentFrame = 1 + self.currentFrame
    if self.currentFrame > #self.spritesheet then
      self.currentFrame = 0
    end
  end
end
function Arrow:draw()
  love.graphics.draw(self.sprites[self.type],self.spritesheet[self.currentFrame],self.x,self.y,0,2)
end
function Arrow:new(type,x,y)
  self.sprites = {
                      [1] = love.graphics.newImage("assets/arrow-right.png"),
                      [2] = love.graphics.newImage("assets/arrow-left.png")
                  } 
  self.type = type or 1
  self.spritesheet = getAnimations(self.sprites[self.type],64,64)
  self.x = x or 0
  self.y = y or 0
  self.frameDuration = 0.05
  self.frameCount = 0
  self.currentFrame = 0
end