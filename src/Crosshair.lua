require 'Color'

Crosshair = Class{}

function Crosshair:init(x, y)
	self.r = 5
	self.lineWidth = 1
	self.color = COLORS.black
	self.colorClick = COLORS.lightgreen
	
	self.x = x
	self.y = y
	self.isClicking = false
end

function Crosshair:update(dt)
end

function Crosshair:draw()
	love.graphics.setLineWidth(self.lineWidth)
	if self.isClicking then
		love.graphics.setColor(self.colorClick:getValues())
	else
		love.graphics.setColor(self.color:getValues())
	end
	love.graphics.circle('line', self.x, self.y, self.r)
end

function Crosshair:setPos(x, y)
	self.x = x
	self.y = y
end

function Crosshair:setClicking(isClicking)
	self.isClicking = isClicking
end