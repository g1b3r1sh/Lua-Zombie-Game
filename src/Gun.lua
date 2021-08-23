Gun = Class{}

-- Next time, split this into types of bullets and independant clips instead of one huge blob
-- Also, have an identifyer for each gun
function Gun:init(name, owner, bulletsManager, interval, clipSize, reloadSpeed, bulletSpeed, spread, damage)
	self.name = name
	self.owner = owner
	self.bulletsManager = bulletsManager
	
	self.interval = interval
	self.clipSize = clipSize
	self.reloadSpeed = reloadSpeed
	
	self.bulletSpeed = bulletSpeed
	self.spread = spread
	self.damage = damage
	
	self.body = Circle(owner.x, owner.y, 7, colors.gray)
	self.angle = 0
	
	self.state = 'shoot'
	self.reloadTimer = reloadSpeed
	self.cooldown = 0
	self.clip = self.clipSize
	
	self.pointX = 0
	self.pointY = 0
end

function Gun:update(dt)
	self:pointAt(self.pointX, self.pointY)
	
	if self.cooldown > 0 then
		self.cooldown = self.cooldown - dt
	end
	
	if self.state == 'reload' then
		if self.reloadTimer > 0 then
			self.reloadTimer = self.reloadTimer - dt
		else
			self.state = 'shoot'
			self.clip = self.clipSize
			audio:stop('reloadStart')
			audio:play('reloadEnd')
		end
	end
end

function Gun:draw()
	self.body:draw()
end

function Gun:pointAt(x, y)
	self.angle = getAngle(self.owner.x, self.owner.y, x, y)
	self.body:goTo(self.owner.x + self.owner.r * math.cos(self.angle), self.owner.y + self.owner.r * math.sin(self.angle))
end

function Gun:shoot()
	if self.cooldown <= 0 and self.state == 'shoot' then
		if self.clip > 0 then
			self:spawnShot()
			self.cooldown = self.interval
			self.clip = self.clip - 1
			audio:play(self.name .. ' Shot')
		else
			self.cooldown = self.interval
			audio:play('dry')
		end
	end
end

function Gun:spawnShot()
	self.bulletsManager:add(self.body.x, self.body.y, self.angle + (math.random() - 0.5) * self.spread, self.damage, self.bulletSpeed)
end

function Gun:reload()
	if self.state ~= 'reload' and self.clip < self.clipSize	then
		self.reloadTimer = self.reloadSpeed
		self.state = 'reload'
		audio:play('reloadStart')
	end
end