Healthbar = Class{}

-- Health info should've been stored in this class

function Healthbar:init(parent)
	self.parent = parent
	
	self.padding = 5
	self.width = self.parent.body.r * 2
	
	self.healthRatio = 1.0
	self.startX = 0
	self.endX = 0
	self.y = 0
end

function Healthbar:update(dt)
	self.healthRatio = math.max(0, math.min(1, self.parent.health / self.parent.maxHealth))
	
	self.startX = self.parent.body.x + self.width / 2
	self.endX = self.parent.body.x + self.width / 2
	self.y = self.parent.body.y - self.parent.body.r - self.padding
end

function Healthbar:draw()
	if self.healthRatio ~= 1 then
		love.graphics.setLineWidth(3)
		
		love.graphics.setColor(red:getValues())
		love.graphics.line(self.parent.body.x - self.width / 2 + self.width * self.healthRatio, self.y, self.endX, self.y)
		love.graphics.setColor(green:getValues())
		love.graphics.line(self.parent.body.x - self.width / 2, self.y, self.parent.body.x - self.width / 2 + self.width * self.healthRatio, self.y)
		
		love.graphics.setLineWidth(1)
	end
end