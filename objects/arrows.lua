Arrow = Object:extend()


function Arrow:update(dt)
  self.frameCount = self.frameCount + dt
  self.isPressed = self.isPressed - dt
  if self.isPressed > 0 then
    self.currentFrame = 0
  elseif self.frameCount > self.frameDuration then
    self.frameCount = 0
    self.currentFrame = 1 + self.currentFrame
    if self.currentFrame > #self.spritesheet then
      self.currentFrame = 1
    end
  end
end
function Arrow:draw()
  love.graphics.draw(self.sprites[self.type],self.spritesheet[self.currentFrame],self.x,self.y, self.orientation,self.scale, self.scale, self.widths[self.type]/2,self.widths[self.type]/2)
end
function Arrow:new(type,x,y,scale)
  self.sprites = {
                      [1] = love.graphics.newImage("assets/arrow-right.png"),
                      [2] = love.graphics.newImage("assets/arrow-left.png"),
                      [3] = love.graphics.newImage("assets/arrow-name.png"),
                      [4] = love.graphics.newImage("assets/arrow-name.png")
                  } 
  self.orientations = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = 3.14159
  }
  self.widths = {
    [1] = 64,
    [2] = 64,
    [3] = 16,
    [4] = 16,
  }
  self.type = type or 1
  self.spritesheet = getAnimations(self.sprites[self.type],self.widths[type],self.widths[type])
  self.orientation = self.orientations [type] or 0 
  self.x = x or 0
  self.y = y or 0
  self.frameDuration = 0.05
  self.frameCount = 0
  self.currentFrame = 0
  self.scale = scale or 1
  self.isPressed = 0
end

function Arrow:pressed()
  self.isPressed = 0.2
end