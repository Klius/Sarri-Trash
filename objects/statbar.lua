--self is the file that 
StatBar = Object:extend()

function StatBar:new(x,y,stat,maxStat,label,color)
  self.x = x
  self.y = y
  self.maxStat = maxStat
  self:changeStat(stat)
  self.label = label
  self.barWidth = 200
  self.color = color
end
function StatBar:changeStat(stat)
  if stat >= self.maxStat then
    self.stat = self.maxStat
  elseif stat < 0 then 
    self.stat = 0
  else
    self.stat = stat
  end
end
function StatBar:draw()
  percent = self.stat/self.maxStat
  love.graphics.print(self.label,self.x,self.y)
  x = self.x+125
  love.graphics.setColor(self.color.r/256,self.color.g/256,self.color.b/256,1)
  love.graphics.rectangle("fill",x,self.y,self.barWidth*percent,16)
  love.graphics.setColor(1,1,1,1)--Reset color
  love.graphics.rectangle("line",x,self.y,self.barWidth,16)
end