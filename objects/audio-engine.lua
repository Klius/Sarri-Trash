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
    gamaovar = "assets/audio/okeydokeysmokey.mp3"
  }
  self.musicVolume = 1
  self.sfxVolume = 0.5
  self.currentsrc = love.audio.newSource(self.audios.menu,"static")
  self.currentsrc:setLooping(true)
  self.currentsrc:setVolume(self.musicVolume)
  love.audio.play(self.currentsrc)
end

function Audio:changeTrack(src)
  love.audio.stop(self.currentsrc)
  self.currentsrc = love.audio.newSource(src,"static")
  self.currentsrc:setLooping(true)
  self.currentsrc:setVolume(self.musicVolume)
  love.audio.play(self.currentsrc)
end
