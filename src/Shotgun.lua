require 'Gun'

Shotgun = Class{__includes = Gun}

NUM_BULLETS = 4

MAX_SPREAD = math.rad(10)

function Shotgun:init(name, owner, bulletsManager, interval, clipSize, reloadSpeed, bulletSpeed, spread, damage, numBullets, roundSpread)
	Gun.init(self, name, owner, bulletsManager, interval, clipSize, reloadSpeed, bulletSpeed, spread, damage)
	self.numBullets = numBullets
	self.roundSpread = roundSpread
end

function Shotgun:spawnShot()
	local i = 1
	for i = 1, NUM_BULLETS do
		self.bulletsManager:add(self.body.x, self.body.y, self.angle + MAX_SPREAD - (MAX_SPREAD * i / (NUM_BULLETS - 1)) + (math.random() - 0.5) * self.spread, self.damage, self.bulletSpeed)
	end
end