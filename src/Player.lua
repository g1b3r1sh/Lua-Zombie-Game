require 'Circle'
require 'Color'
require 'EntManager'
require 'Healthbar'
require 'Gun'
require 'Shotgun'
require 'Audio'
require 'Bullet'

Player = Class{}

-- TODO: Player and Enemy class should inherit from same class
function Player:init()
	self.maxSpeed = 150
	
	self.body = Circle(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 20, Color.terms.blue)
	
	self.bullets = EntManager(Bullet, function(bullet)
		return bullet.remove
	end)
	self.healthbar = Healthbar(self.body.r * 2, self.body.r)
	
	-- Format of guns: name, owner, bulletsManager, interval, clipSize, reloadSpeed, bulletSpeed, spread, damage, Shotguns:[numBullets, roundSpread])
	self.guns = {
		pistol = Gun('Pistol', self.body, self.bullets, 0.3, 20, 0.5, 500, 0.05, 12),
		rifle = Gun('Assault Rifle', self.body, self.bullets, 0.1, 30, 1.5, 800, 0.1, 10),
		shotgun = Shotgun('Shotgun', self.body, self.bullets, 0.7, 5, 2, 800, 0.3, 15, 4, math.rad(5)),
		smg = Gun('SMG', self.body, self.bullets, 0.05, 50, 0.8, 300, 1, 7),
		sniper = Gun('Sniper Rifle', self.body, self.bullets, 1, 5, 3, 1500, 0.01, 99)
	}
	
	self.currentGun = self.guns['pistol']
	self.switchSpeed = 0.5
	
	self.kills = 0
	
	self.maxHealth = 100
	self.health = self.maxHealth
	
	self.healTimer = 0
	self.healDamageTime = 5
	self.healInterval = 1
	self.healIntervalAmount = 5
	
	self.dead = false
	
	-- Used for Collision iterations, since they expect a table of objects
	self.objects = {self}
end

function Player:update(dt)
	self.body:update(dt)
	self.currentGun:update(dt)
	self.bullets:update(dt)
	if self.health > 0 then
		if self.healTimer > 0 then
			self.healTimer = self.healTimer - dt
		else
			if self.health < self.maxHealth then
				self.health = self.health + self.healIntervalAmount
				self.healTimer = self.healInterval
			end
		end
	end
	self:updateHealthbar()
end

function Player:draw()
	self.body:draw()
	if not self.dead then
		self.bullets:draw()
		self.currentGun:draw()
		self.healthbar:draw()
	end
end

function Player:switchGun(gun)
	if self.guns[gun].name ~= self.currentGun.name then
		self.currentGun.state = 'shoot'
		if audio:isPlaying('reloadStart') then
			audio:stop('reloadStart')
		end
		self.currentGun = self.guns[gun]
		audio:play(self.currentGun.name .. ' Equip')
		if self.currentGun.cooldown < self.switchSpeed then
			self.currentGun.cooldown = self.switchSpeed
		end
		self.currentGun:update(0)
	end
end

function Player:pointAt(x, y)
	self.currentGun:pointAt(x, y)
end

function Player:shoot()
	self.currentGun:shoot()
end

function Player:damage(a)
	if gameState =='play' then
		self.health = self.health - a
		self.healTimer = self.healDamageTime
		if self.health <= 0 then
			audio:play('death')
			self.dead = true
			gameOver()
		else
			audio:play('pain' .. math.random(1, 3))
		end
	end
end

function Player:getPos(x, y)
	return self.body:getPos()
end

function Player:setVel(dx, dy)
	self.body:setVel(dx, dy)
end

function Player:getVel()
	return self.body:getVel()
end

function Player:updateHealthbar()
	self.healthbar:updateHealthRatio(self.health, self.maxHealth)
	self.healthbar:updatePos(self.body:getPos())
end