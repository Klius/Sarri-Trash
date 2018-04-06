SkidPool = Object:extend()

function SkidPool:update(dt)
  if player.braking and player.accelerating then
    self:add()
  end
  for i, v in ipairs(self.skids) do
    v:update(dt)
    if v.erase then
      table.remove(self.skids,i)
    end
  end
end
function SkidPool:draw()
    for i, v in ipairs(self.skids) do
    v:draw()
  end
end
function SkidPool:new()
  self.limit = 50
  self.skidSprite = "assets/skid-fx.png"
  self.skids = {}
end
function SkidPool:add()
  skid = Skid(self.skidSprite,player.x,player.y,player.rotation)
  table.insert(self.skids,skid)
end