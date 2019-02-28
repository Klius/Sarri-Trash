selectorControl = Object:extend()

function selectorControl:new(options,default)
  self.options = options or { [1]={text="true",value=true} , [2]={text="false",value=false}}
  if default ~= nil then
    for i in ipairs(self.options) do
      if self.options[i].value == default then
        self.selected = i
      end
    end
  else
    self.selected = 1
  end
  
end
function selectorControl:draw(x,y)
  x= x + 32
  for i in ipairs(self.options) do
    if i == self.selected then
      love.graphics.setColor(1,1,1,1)
      love.graphics.rectangle("fill",x-16,y+10,16,16)
    else
      love.graphics.setColor(0.5,0.5,0.5,1)
    end  
    love.graphics.print(self.options[i].text,x,y)
    x = x + 32*#self.options[i].text
  end
  love.graphics.setColor(1,1,1,1)
end
function selectorControl:changeOption(increment)
  local newSelected = self.selected +increment
  if newSelected <= 0 then
    newSelected = #self.options
  elseif newSelected > #self.options then
    newSelected = 1
  end
  self.selected = newSelected
end
function selectorControl:getValue()
  return self.options[self.selected].value
end