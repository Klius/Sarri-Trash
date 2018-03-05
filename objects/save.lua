fs = {
  
}

fs.saveRecord = function (self,map)
  local directory = "records"
  local mapstring = ""
  for i=1,3 do
    if i == 3 then
      mapstring = mapstring..maplist.selectedMapRecords[i]..","..maplist.selectedMapRecordsName[i]
    else
      mapstring = mapstring..maplist.selectedMapRecords[i]..","..maplist.selectedMapRecordsName[i].."\n"
    end
  end
  love.filesystem.createDirectory(directory)
  love.filesystem.write(directory..'/'..map, mapstring)
end