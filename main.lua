-- Include Simple Tiled Implementation into project
local sti = require "libs/sti"
local shine = require "libs/shine"
bump = require "libs/bump"
bump_debug = require "libs/bump_debug"
Object = require "libs/classic"
require "objects/music"

function love.load()
   -- Load map file
   map = sti("assets/testmap.lua",{"bump"})
   bloom = shine.glowsimple()
   audiomanager = MusicManager()
   world = bump.newWorld()
   map:bump_init(world)
   --Spawn player
   spawnPlayer()
end

function love.update(dt)
   -- Update world
   updatePlayer(dt)
   map:update(dt)
   audiomanager:PlayMusic()
end

function love.draw()
   -- Scale world
   local scale = 2
   local screen_width = love.graphics.getWidth() / scale
   local screen_height = love.graphics.getHeight() / scale

   -- Translate world so that player is always centred
   local tx = math.floor(player.x - screen_width / 2)
   local ty = math.floor(player.y - screen_height / 2)

   -- Translate world
   -- love.graphics.scale(scale)
   -- love.graphics.translate(-tx, -ty)
    love.graphics.scale(scale)
    love.graphics.translate(-tx, -ty)
   -- Draw world
   bloom:draw(function()
   map:draw(-tx, -ty, scale,scale)
   drawPlayer()
   
  end)
map:bump_draw(world)
--bump_debug.draw(world)
  -- map:draw(-tx, -ty, scale,scale)
end
function spawnPlayer()
 local sprite = love.graphics.newImage("assets/car-test.png")
   local spritesheet = getAnimations(sprite,32,32)
   local spawn
   for k, object in pairs(map.objects) do
      if object.name == "Player" then
	 spawn = object
	 break
      end
   end
   player = {
      sprite = sprite,
      frames = spritesheet,
      frameDuration = 0.5,
      frameCount = 0,
      currentFrame = 0,
      x      = spawn.x,
      y      = spawn.y,
      w = 32,
      h = 32,
      ox     = 16 ,
      oy     = 16 ,
      orientation = 0,
      currentSpeed = 0,
      topSpeed = 8,
      acceleration = 5,
      steering = 150,
      braking = 10
   }
   world:add(player,player.x,player.y,player.w,player.h)
   map:removeLayer("Spawn Point")
   
end
function drawPlayer()
  love.graphics.draw(
                         player.sprite,
                         player.frames[player.currentFrame],
                         math.floor(player.x+player.ox),
                         math.floor(player.y+player.oy),	 
                         player.orientation,
                         1,
                         1,
                         player.ox,
                         player.oy
                            )

      -- Temporarily draw a point at our location so we know
      -- that our sprite is offset properly
      love.graphics.setPointSize(1)
      love.graphics.rectangle('line', world:getRect(player))
      love.graphics.print(player.currentSpeed,player.x,player.y)
end
function updatePlayer(dt)
  local speed = player.acceleration * dt
      local brakes = player.braking * dt
      --Acceleration
      if love.keyboard.isDown("space") then
        player.currentSpeed = player.currentSpeed + speed
        if player.currentSpeed > player.topSpeed then
          player.currentSpeed = player.topSpeed
        end
      else
        player.currentSpeed = player.currentSpeed - speed
        if player.currentSpeed < 0 then
          player.currentSpeed = 0
        end
      end
      if love.keyboard.isDown("s") then
        player.currentSpeed = player.currentSpeed - brakes
        if player.currentSpeed < -2 then
          player.currentSpeed = -2
        end
      end

    -- ORIENTATION
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
      player.orientation = player.orientation - (player.steering * dt) * math.pi / 180
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
      player.orientation = player.orientation + (player.steering * dt) * math.pi / 180
    end
    
    --Change position
    
    goalX = player.x - math.cos(player.orientation)*player.currentSpeed
    goalY = player.y - math.sin(player.orientation)*player.currentSpeed
    player.x, player.y = world:move(player, goalX, goalY)
    --ANIMATION
    if player.currentSpeed > 0 then
      player.frameCount = player.frameCount + dt
    else
      player.currentFrame = 0  
    end
    if player.frameCount > player.frameDuration then
      player.frameCount = 0
      player.currentFrame = 1 + player.currentFrame
      if player.currentFrame > 3 then
        player.currentFrame = 0
      end
    end

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