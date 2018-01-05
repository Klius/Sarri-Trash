MusicManager = Object:extend()

function MusicManager:new()
  self.backgroundMusic = love.audio.newSource("assets/sfx/music/back.ogg")
  self.backgroundMusic:setLooping(true)
  self.backgroundMusic:setVolume(1)
  self.sea = love.audio.newSource("assets/sfx/sea.ogg")
  self.sea:setVolume(0.5)
  self.sea:setLooping(true)
  self.currentMusic = self.backgroundMusic
end

function MusicManager:PlayMusic()
      self.currentMusic:play()
      self.sea:play()
end
function MusicManager:StopMusic()
  self.currentMusic:stop()
end

function MusicManager:PlayChime()
  self.chime:stop()
  self.chime:play()
end