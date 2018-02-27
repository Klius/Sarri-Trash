fs = {
  
}
fs.saveRecord = function (self,map)
  local directory = love.filesystem.getSaveDirectory().."/records"
  love.filesystem.createDirectory(directory)
  
end