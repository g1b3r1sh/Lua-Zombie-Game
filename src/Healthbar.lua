require 'Color'

Healthbar = Class{}

function Healthbar:init(width, offsetY)
	self.padding = 5
	
	self.width = width
	-- For a circle, it would be the radius
	self.offsetY = offsetY
	
	self.healthRatio = 1.0
	self.x = 0
	self.y = 0
end

function Healthbar:draw()
	if self.healthRatio ~= 1 then
		love.graphics.setLineWidth(3)
		
		love.graphics.setColor(Color.terms.red:getValues())
		love.graphics.line(self.x - self.width / 2 + self.width * self.healthRatio, self.y, self.x + self.width / 2, self.y)
		love.graphics.setColor(Color.terms.green:getValues())
		love.graphics.line(self.x - self.width / 2, self.y, self.x - self.width / 2 + self.width * self.healthRatio, self.y)
		
		love.graphics.setLineWidth(1)
	end
end

function Healthbar:updateHealthRatio(health, maxHealth)
	self.healthRatio = math.max(0, math.min(1, health / maxHealth))
end

function Healthbar:updatePos(x, y)
	self.x = x
	self.y = y - self.offsetY - self.padding
end