funkt = {}

function funkt.clamp( low, val, high )
	assert(low and val and high, "You used clamp wrong")
	if low > high then low, high = high, low end
	return math.max(low, math.min(high, val))
end