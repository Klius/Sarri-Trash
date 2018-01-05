-- Include Simple Tiled Implementation into project
local sti = require "libs/sti"
local shine = require "libs/shine"
Object = require "libs/classic"
require "objects/music"
Moan = require('libs/moan')
function love.load()
   -- Load map file
   map = sti("assets/testmap.lua")
   bloom = shine.godsray()
   audiomanager = MusicManager()
   Moan.speak("Title", {"Hello World!--Möan.lua!"})
   --Spawn player
   spawnPlayer()
end

function love.update(dt)
   -- Update world
   map:update(dt)
   audiomanager:PlayMusic()
   Moan.update(dt)
end

function love.draw()
   -- Scale world
   local scale = 2
   local screen_width = love.graphics.getWidth() / scale
   local screen_height = love.graphics.getHeight() / scale

   -- Translate world so that player is always centred
   local player = map.layers["Sprites"].player
   local tx = math.floor(player.x - screen_width / 2)
   local ty = math.floor(player.y - screen_height / 2)

   -- Translate world
   -- love.graphics.scale(scale)
   -- love.graphics.translate(-tx, -ty)

   -- Draw world
   bloom:draw(function()
   map:draw(-tx, -ty, scale,scale)
  end)
  Moan.draw()
   --map:draw(-tx, -ty, scale,scale)
end

function love.keyreleased(key)
    Moan.keyreleased(key) -- or Moan.keypressed(key)
end

function spawnPlayer()
  ---- Create new dynamic data layer called "Sprites" as the 4th layer
  local layer = map:addCustomLayer("Sprites", 3)

   -- Get player spawn object
   local player
   for k, object in pairs(map.objects) do
      if object.name == "Player" then
	 player = object
	 break
      end
   end

   -- Create player object
   local sprite = love.graphics.newImage("assets/walking-man.png")
   local spritesheet = getAnimations(sprite,32,32)
   layer.player = {
      sprite = sprite,
      frames = spritesheet,
      frameDuration = 0.1,
      frameCount = 0,
      currentFrame = 0,
      x      = player.x,
      y      = player.y,
      width = 32,
      height = 32,
      ox     = 32 / 2,
      oy     = 32 / 1.35
      
   }

   -- Add controls to player
   layer.update = function(self, dt)
      -- 150 pixels per second
      local speed = 150
      local moving = false
      -- Move player up
      if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
      self.player.y = self.player.y - speed * dt
      moving = true
      end

      -- Move player down
      if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
	 self.player.y = self.player.y + speed * dt
   moving = true
      end

      -- Move player left
      if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
	 self.player.x = self.player.x - speed * dt
   moving = true
      end

      -- Move player right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
     self.player.x = self.player.x + speed * dt
     moving = true
    end
    --change frame of animation
    if moving then
      self.player.frameCount = self.player.frameCount + dt
    else
      self.player.currentFrame = 1  
    end
    if self.player.frameCount > self.player.frameDuration then
      self.player.frameCount = 0
      self.player.currentFrame = 1 + self.player.currentFrame
      if self.player.currentFrame > 3 then
        self.player.currentFrame = 0
      end
    end
   end
   
   -- Draw player
   layer.draw = function(self)
      love.graphics.draw(
                         self.player.sprite,
                         self.player.frames[self.player.currentFrame],
                         math.floor(self.player.x),
                         math.floor(self.player.y),	 
                         0,
                         1,
                         1,
                         self.player.ox,
                         self.player.oy
                            )

      -- Temporarily draw a point at our location so we know
      -- that our sprite is offset properly
      love.graphics.setPointSize(5)
      love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
   end

   map:removeLayer("Spawn Point")
end



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
