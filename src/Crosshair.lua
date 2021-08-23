Crosshair = Class{}

function Crosshair:init(mouse)
	self.r = 5
	self.lineWidth = 1
	self.color = COLORS.black
	self.colorClick = COLORS.lightgreen
	
	self.mouse = mouse
	self.x = self.mouse.x
	self.y = self.mouse.y
end

function Crosshair:update(dt)
	self.x = self.mouse.x
	self.y = self.mouse.y
end

function Crosshair:draw()
	love.graphics.setLineWidth(self.lineWidth)
	if self.mouse.isDown() then
		love.graphics.setColor(self.colorClick:getValues())
	else
		love.graphics.setColor(self.color:getValues())
	end
	love.graphics.circle('line', self.x, self.y, self.r)
end