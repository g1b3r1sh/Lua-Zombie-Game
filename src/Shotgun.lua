require 'Gun'
require 'EntManager'

Shotgun = Class{__includes = Gun}

function Shotgun:init(name, owner, bulletsManager, interval, clipSize, reloadSpeed, bulletSpeed, spread, damage, numBullets, roundSpread)
	Gun.init(self, name, owner, bulletsManager, interval, clipSize, reloadSpeed, bulletSpeed, spread, damage)
	self.numBullets = numBullets
	self.roundSpread = roundSpread
end

function Shotgun:spawnShot()
	local i = 1
	for i = 1, self.numBullets do
		self.bulletsManager:emplace(self.body.x, self.body.y, self.angle + self.roundSpread - (self.roundSpread * i / (self.numBullets - 1)) + (math.random() - 0.5) * self.spread, self.damage, self.bulletSpeed)
	end
end