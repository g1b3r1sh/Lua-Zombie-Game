Enemy = Class{}

function Enemy:init(x, y, target)
	self.maxHealth = 100
	self.health = self.maxHealth
	self.speed = 100
	self.attackDamage = 5
	self.attackRadius = 5
	self.timeUntilAttack = 0.5
	
	self.target = target
	
	self.body = Circle(x, y, 20, COLORS.green, 20)
	self.healthbar = Healthbar(self)
	
	self.attackTimer = self.timeUntilAttack
	self.dead = false
	
end

function Enemy:update(dt)
	self:goTowards(self.target.body:getPos())
	self.body:update(dt)
	
	self.healthbar:update(dt)
	if self:canAttackTarget() then
		if self.attackTimer > 0 then
			self.attackTimer = self.attackTimer - dt
		else
			self:attack(self.target)
		self.attackTimer = self.timeUntilAttack
		end
	elseif self.attackTimer ~= self.timeUntilAttack then
		self.attackTimer = self.timeUntilAttack
	end
end

function Enemy:draw()
	self.body:draw()
	self.healthbar:draw()
end

function Enemy:damage(a)
	self.health = self.health - a
	if self.health <= 0 then
		self.dead = true
	end
end

function Enemy:attack(target)
	target:damage(self.attackDamage)
end

function Enemy:goTowards(x, y)
	local a = getAngle(self.body.x, self.body.y, x, y)
	self.body.dx = self.speed * math.cos(a)
	self.body.dy = self.speed * math.sin(a)
end

function Enemy:canAttackTarget()
	return circleInCircle(self.body, self.target.body)
end