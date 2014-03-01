Background = {}
Background.__index = Background

function Background.new(image, speed)
  local self = setmetatable({}, Background)
  self.texture = image
  self.textureWidth, self.textureHeight = image:getDimensions()
  self.textureRepeats = (g_width / self.textureWidth) + 1
  self.spriteBatch = love.graphics.newSpriteBatch(image, self.textureRepeats)
  self.spriteBatchTable = {}
  self.fullQuad = love.graphics.newQuad(0, 0, self.textureWidth, self.textureHeight, self.texture:getDimensions())
  self.xoffset = 0
  self.speed = speed
  
  self.spriteBatch:bind()
  for i = 0, self.textureRepeats do
    self.spriteBatchTable[i+1] = self.spriteBatch:add(self.fullQuad, self.textureWidth * i, 0)
  end
  self.spriteBatch:unbind()
  return self
end

function Background:update(dt)
  if self.xoffset >= self.textureWidth then
    self.xoffset = self.xoffset - self.textureWidth
  end
  self.xoffset = self.xoffset + (dt * self.speed)
  
  local count = 0
  self.spriteBatch:bind()
  for i,v in pairs(self.spriteBatchTable) do
    self.spriteBatch:set(v, self.fullQuad, (self.textureWidth * count) - self.xoffset, 0)
    count = count + 1
  end
  self.spriteBatch:unbind()
end

function Background:draw()
  love.graphics.draw(self.spriteBatch)
end
