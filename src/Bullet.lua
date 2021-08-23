Bullet = Class{}

function Bullet:init(x, y, a, damage, speed)
	self.x = x
	self.y = y
	self.a = a
	-- If damage decreases over time, change in update loop
		-- Alternative is to save origin and calculate real damage at point of impact in collision object
	self.damage = damage
	self.speed = speed
	
	self.r = 3
	self.color = colors.black
	
	self.dx = self.speed * math.cos(a)
	self.dy = self.speed * math.sin(a)
	
	self.remove = false
end

function Bullet:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
	
	if self.x < BOUNDARY_LEFT or self.x > BOUNDARY_RIGHT or self.y < BOUNDARY_TOP or self.y > BOUNDARY_BOTTOM then
		self.remove = true
	end
end

function Bullet:draw()
	love.graphics.setColor(self.color:getValues())
	love.graphics.circle('fill', self.x, self.y, self.r)
end