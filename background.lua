Background = {}
Background.__index = Background

function Background.new(image, speed)
  local self = setmetatable({}, Background)
  self.texture = image
  self.speed = speed
  return self
end
