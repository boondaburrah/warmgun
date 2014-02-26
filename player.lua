Player = {}
Player.__index = Player

function Player.new(animation, position)
	local self = setmetatable({}, Player)
  self.animation = animation
  self.position = position
  self.active = true
  self.health = 100
	return self
end

function Player:update(dt)
  self.animation:update(dt)
  self.animation:setPosition(self.position)
end

function Player:draw()
  self.animation:draw()
end

function Player:getWidth()
  return self.animation:getWidth()
end

function Player:getHeight()
  return self.animation:getHeight()
end
