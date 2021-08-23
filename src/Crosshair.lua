Crosshair = Class{}

function Crosshair:init(mouse)
	self.mouse = mouse
	self.x = self.mouse.x
	self.y = self.mouse.y
	
	self.r = 5
	self.lineWidth = 1
	self.color = colors.black
	self.colorClick = colors.lightgreen
end

function Crosshair:update(dt)
	self.x = self.mouse.x
	self.y = self.mouse.y
end

function Crosshair:draw()
	love.graphics.setLineWidth(self.lineWidth)
	if self.mouse.isDown() then
		love.graphics.setColor(self.colorClick:getValues())
		love.graphics.circle('line', self.x, self.y, self.r)
	else
		love.graphics.setColor(self.color:getValues())
		love.graphics.circle('line', self.x, self.y, self.r)
	end
end