Audio = Object:extend()

function Audio:new()
  self.audios = {
    menu = "assets/audio/downtheway-menu.mp3",
    race = {
      [1] = "assets/audio/copafeel.mp3",
      [2] = "assets/audio/feelgoodrock.mp3",
      [3] = "assets/audio/smoothjazznight.mp3",
      [4] = "assets/audio/sunsetstrip.mp3",
      [5] = "assets/audio/2014.ogg",
      [6] = "assets/audio/billy.ogg",
      [7] = "assets/audio/danidrumsblues.ogg",
      [8] = "assets/audio/eneroconjeff.ogg",
      [9] = "assets/audio/gordoymellao.ogg",
      [10] = "assets/audio/kintorsaw.ogg"
    },
    songInfo = {
      [1] = {name = "Cop a Feel",author = "Audionautix"},
      [2] = {name = "Feel Good Rock",author = "Audionautix"},
      [3] = {name = "Smoth Jazz Night",author = "Audionautix"},
      [4] = {name = "Sunset Strip",author = "Audionautix"},
      [5] = {name = "2014",author = "Pedro Botella Merighi"},
      [6] = {name = "Billy",author = "Pedro Botella Merighi"},
      [7] = {name = "Dani Drums Blues",author = "Pedro Botella Merighi"},
      [8] = {name = "Enero Con Jeff",author = "Pedro Botella Merighi"},
      [9] = {name = "Gordo y Mellao",author = "APAC"},
      [10] = {name = "Kin Tor Saw",author = "APAC"}
    },
    gamaovar = "assets/audio/okeydokeysmokey.mp3",
    selectFX = love.audio.newSource("assets/audio/sfx/select.wav","static")
  }
  self.musicVolume = 0.5
  self.sfxVolume = 0.4
  self.currentsrc = love.audio.newSource(self.audios.menu,"stream")
  self.currentsrcfilename = self.audios.menu
  self.currentsrc:setLooping(true)
  self.currentsrc:setVolume(self.musicVolume)
  love.audio.play(self.currentsrc)
end

function Audio:getCurrentTrackInfo()
  info = {name="?",author="¿?"}
  for i,src in ipairs(self.audios.race) do
    if self.currentsrcfilename == src then
      info = self.audios.songInfo[i]
    end
  end
return info
end

function Audio:nextTrack(increment)
  index = 1
  for i,src in ipairs(self.audios.race) do
    if self.currentsrcfilename == src then
      index = i
    end
  end
  index = index+increment
  if index < 1 then
    index = #self.audios.race
  elseif index > #self.audios.race then
    index = 1
  end
  self:changeTrack(self.audios.race[index])
end

function Audio:changeTrack(src)
  love.audio.stop(self.currentsrc)
  self.currentsrc = love.audio.newSource(src,"stream")
  self.currentsrc:setLooping(true)
  self.currentsrc:setVolume(self.musicVolume)
  self.currentsrcfilename = src
  love.audio.play(self.currentsrc)
end
function Audio:changeVolume(volume,increment)
  local newVolume = volume +increment
  if newVolume < 0 then
    newVolume = 0
  elseif newVolume > 1 then
    newVolume = 1
  end
  return newVolume
end
function Audio:changeMusicVolume(increment)
  self.musicVolume = self:changeVolume(self.musicVolume,increment)
  self.currentsrc:setVolume(self.musicVolume)
end
function Audio:changeSFXVolume(increment)
  self.sfxVolume = self:changeVolume(self.sfxVolume,increment)
  
  --self.currentsrc:setVolume(self.musicVolume)
end
function Audio:playSFX(sfx)
  sfx:setVolume(self.sfxVolume)
  love.audio.play(sfx)
end
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Functions for the settings screen
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
]]
