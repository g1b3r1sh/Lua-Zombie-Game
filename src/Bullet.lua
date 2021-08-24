require 'Color'
require 'Circle'

Bullet = Class{}

-- If damage decreases over time, change in update loop
	-- Alternative is to save origin and calculate real damage at point of impact
-- Additionally, damage should be calculated in Bullet class
-- TODO: Use Circle class as body
function Bullet:init(x, y, a, damage, speed)
	self.r = 3
	self.body = Circle(x, y, self.r, COLORS.black, self.r)
	
	self.a = a
	self.damage = damage
	self.speed = speed
	
	self.body:setVel(self.speed * math.cos(a), self.speed * math.sin(a))
	
	self.remove = false
end

function Bullet:update(dt)
	self.body:update(dt)
	
	if self.body.x < BOUNDARY_LEFT or self.body.x > BOUNDARY_RIGHT or self.body.y < BOUNDARY_TOP or self.body.y > BOUNDARY_BOTTOM then
		self.remove = true
	end
end

function Bullet:draw()
	self.body:draw()
end