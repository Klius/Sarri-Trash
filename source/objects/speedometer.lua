--[[http://www.workwithcolor.com/green-color-hue-range-01.htm
172	225	175-> celadon
244	194	194		#F4C2C2		Baby Pink
255	92	92		#FF5C5C		Indian Red
0	128	0 -> green
]]
Speedometer = Object:extend()
function Speedometer:new()
  self.fullSquares = 0
  self.squares = 19
  self.colors = { 
    [0]={r=255/255,g=250/255,b=250/255,o=1},
    [1]={r=255/255,g=250/255,b=250/255,o=1},
    [2]={r=255/255,g=250/255,b=250/255,o=1},
    [3]={r=255/255,g=250/255,b=250/255,o=1},
    [4]={r=255/255,g=250/255,b=250/255,o=1},
    [5]={r=255/255,g=250/255,b=250/255,o=1},
    [6]={r=255/255,g=250/255,b=250/255,o=1},
    [7]={r=255/255,g=250/255,b=250/255,o=1},
    [8]={r=255/255,g=250/255,b=250/255,o=1},
    [9]={r=255/255,g=250/255,b=250/255,o=1},
    [10]={r=255/255,g=250/255,b=250/255,o=1},
    [11]={r=255/255,g=250/255,b=250/255,o=1},
    [12]={r=255/255,g=250/255,b=250/255,o=1},
    [13]={r=255/255,g=250/255,b=250/255,o=1},
    [14]={r=255/255,g=250/255,b=250/255,o=1},
    [15]={r=255/255,g=250/255,b=250/255,o=1},
    [16]={r=255/255,g=250/255,b=250/255,o=1},
    [17]={r=255/255,g=250/255,b=250/255,o=1},
    [18]={r=1,g=0,b=0,o=1},
    [19]={r=1,g=0,b=0,o=1},
  }
  self.uiSpeed = 0
  self.width = 8
end
              
function Speedometer:draw(y)
  local x = love.graphics.getWidth()/2-66
  local y = y or 50
  for i=0,self.squares do
    if self.fullSquares > 0 then 
      love.graphics.setColor(self.colors[i].r,self.colors[i].g,self.colors[i].b,self.colors[i].o)
      love.graphics.rectangle("fill",x,y,8,16)
      self.fullSquares = self.fullSquares - 1 
    end
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle("line",x,y,8,16)
    x = x+self.width
  end
  love.graphics.setColor(0,0,0,1)
  love.graphics.rectangle("line",x,y-8,48,32)
  love.graphics.rectangle("fill",x,y-8,48,32)
  love.graphics.setColor(1,1,1,1)
  love.graphics.print(self.uiSpeed,x+5,y-4,0)
end
                   
function Speedometer:update (dt,player)
    self.speedDiff =  player.currentSpeed / player.car.topSpeed
    if player.currentSpeed == player.car.topSpeed then
      self.speedDiff = self.squares
    end
    if player.currentSpeed <0 then
      self.speedDiff = math.abs(player.currentSpeed) /player.car.topSpeed
      self.uiSpeed = 'Rev'
    else
    self.uiSpeed = math.floor(player.currentSpeed*5)
  end
                        
  self.fullSquares = self.squares * self.speedDiff 
end