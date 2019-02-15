audioControl = Object:extend()

function audioControl:new()
  self.maxVolume = 10
end
function audioControl:draw(actualVolume,x,y)
  local currentVolume = 10*actualVolume
  for i = 1, self.maxVolume do
    if i <= currentVolume then
      love.graphics.rectangle("fill",x,y,16,32)
    end  
    love.graphics.rectangle("line",x,y,16,32)
    x = x+20
  end
end