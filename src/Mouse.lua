Mouse = Class{}

function Mouse:init()
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
end

function Mouse:update(dt)
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
end

function Mouse:getPos()
	return self.x, self.y
end

function Mouse:isDown()
	return love.mouse.isDown(1)
end