Enemy = {}
Enemy.__index = Enemy

function Enemy.new(anim, position)
	local self = setmetatable({}, Enemy)
	self.animation = anim
	self.position = position
	self.health = 10
	self.damage = 10
	self.active = true
	self.moveSpeed = 75
	self.value = 100
	return self
end

function Enemy:update( dt )
	if self.active == false then return end
	self.position.x = self.position.x - (self.moveSpeed * dt)
	if self.position.x < 0 or self.health <= 0 then 
		self.active = false
		return
	end

	self.animation:setPosition(self.position)
	self.animation:update(dt)
end

function Enemy:draw()
	self.animation:draw()
end