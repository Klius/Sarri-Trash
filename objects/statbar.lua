--self is the file that 
StatBar = Object:extend()

function StatBar:new(x,y,stat,maxStat,label,color)
  self.x = x
  self.y = y
  self.stat = stat
  self.maxStat = maxStat
  self.label = label
  self.barWidth = 200
  self.color = color
end

function StatBar:draw()
  percent = self.stat/self.maxStat
  love.graphics.print(self.label,self.x,self.y)
  x = self.x+(#self.label*16)
  love.graphics.setColor(self.color.r/256,self.color.g/256,self.color.b/256,1)
  love.graphics.rectangle("fill",x,self.y,self.barWidth*percent,16)
  love.graphics.setColor(1,1,1,1)--Reset color
  love.graphics.rectangle("line",x,self.y,self.barWidth,16)
end
