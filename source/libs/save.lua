function saveRecord(level,record)
  file = love.filesystem.newFile("record_"..level..".sav")
  file:open("w")
  file:write(record)
  file:close()
end
function loadRecords(level)
  file = love.filesystem.newFile("record_"..level..".sav")
  file:open("r")
  data = file:read()
  file:close()
  local times = 0
  local names = 0
  if data ~= nil then
    times = {}
    names = {}
    local recs = strSplit(",",data)
    for i=1,3 do
      sep = strSplit("/",recs[i])
      table.insert(times,tonumber(sep[1]))
      table.insert(names,sep[2])
    end
  end
  return times, names
end

function strSplit(delim,str)
    local t = {}

    for substr in string.gmatch(str, "[^".. delim.. "]*") do
        if substr ~= nil and string.len(substr) > 0 then
            table.insert(t,substr)
        end
    end

    return t
end
