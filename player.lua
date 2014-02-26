Player = {}
Player.__index = Player

function Player.new( ... )
	local self = setmetatable({}, Player)

	return self
end