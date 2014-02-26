Animation = {}
Animation.__index = Animation

function Animation.new(image, position, frameWidth, frameHeight, frameCount, frameTime, scale, looping)
  local self = setmetatable({}, Animation)
  self.spriteBatch = love.graphics.newSpriteBatch(image, 1)
  self.spriteTable = {}
  self.x = position.x
  self.y = position.y
  self.frameWidth = frameWidth
  self.frameHeight = frameHeight
  self.frameCount = frameCount
  self.frameTime = frameTime
  self.scale = scale
  self.looping = looping
  
  self.active = true
  self.elapsedTime = 0
  self.currentFrame = 1
  
  for i = 1, self.frameCount do
    self.spriteTable[i] = love.graphics.newQuad((self.frameWidth * (i - 1)), 0, self.frameWidth, self.frameHeight, ({image:getDimensions()})[1], ({image:getDimensions()})[2])
  end
  
  self.spritePointer = self.spriteBatch:add(self.spriteTable[1], self.x, self.y)
  return self
end

function Animation:update(dt)
  if self.active == false then
    self.spriteBatch:set(self.spritePointer, self.spriteTable[self.currentFrame], self.x, self.y)
    return
  end
  self.elapsedTime = self.elapsedTime + dt
  if self.elapsedTime > self.frameTime then
    self.currentFrame = self.currentFrame + 1
    if self.currentFrame == self.frameCount then
      if self.looping == false then
        self.active = false
      else
        self.currentFrame = 1
      end
    end
    self.elapsedTime = 0
  end
  self.spriteBatch:set(self.spritePointer, self.spriteTable[self.currentFrame], self.x, self.y)
end

function Animation:setPosition(position)
  self.x = position.x
  self.y = position.y
end

function Animation:draw()
  love.graphics.draw(self.spriteBatch)
end