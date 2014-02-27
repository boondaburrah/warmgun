Background = {}
Background.__index = Background

function Background.new()
  local self = setmetatable({}, Background)
  
  return self
end
