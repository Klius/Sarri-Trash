Audio = Object:extend()

function Audio:new()
  self.audios = {
    menu = "assets/audio/downtheway-menu.mp3",
    race = {
      [1] = "assets/audio/copafeel.mp3",
      [2] = "assets/audio/feelgoodrock.mp3",
      [3] = "assets/audio/smoothjazznight.mp3",
      [4] = "assets/audio/sunsetstrip.mp3",
    },
    gamaovar = "assets/audio/okeydokeysmokey.mp3",
    selectFX = love.audio.newSource("assets/audio/sfx/select.wav","static")
  }
  self.musicVolume = 0.5
  self.sfxVolume = 0.4
  self.currentsrc = love.audio.newSource(self.audios.menu,"stream")
  self.currentsrc:setLooping(true)
  self.currentsrc:setVolume(self.musicVolume)
  self.volControl = audioControl()
  love.audio.play(self.currentsrc)
end

function Audio:changeTrack(src)
  love.audio.stop(self.currentsrc)
  self.currentsrc = love.audio.newSource(src,"stream")
  self.currentsrc:setLooping(true)
  self.currentsrc:setVolume(self.musicVolume)
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
