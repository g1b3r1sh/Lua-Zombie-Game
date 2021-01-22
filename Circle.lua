-- Responsible for storing position and displaying entity

Circle = Class{}

function Circle:init(x, y, r, color, windowLimit)
	self.x = x
	self.y = y
	self.r = r
	self.color = color
	
	self.dx = 0
	self.dy = 0
	
	-- Limit to how far past the screen allowed to go
	self.windowLimit = windowLimit or -self.r
end

function Circle:update(dt)
	self.x = math.min(math.max(self.x + self.dx * dt, 0 - self.windowLimit), WINDOW_WIDTH + self.windowLimit)
	self.y = math.min(math.max(self.y + self.dy * dt, 0 - self.windowLimit), WINDOW_HEIGHT + self.windowLimit)
end

function Circle:draw()
	love.graphics.setColor(self.color:getValues())
	love.graphics.circle('fill', self.x, self.y, self.r)
	--love.graphics.rectangle('fill', self.x - self.r / 2, self.y - self.r / 2, self.r, self.r)
end

function Circle:setColor(r, g, b)
	self.color.r = r
	self.color.g = g
	self.color.b = b
end

function Circle:getPos()
	return self.x, self.y
end

function Circle:goTo(x, y)
	self.x = x
	self.y = y
end