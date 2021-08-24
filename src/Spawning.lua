require 'EntManager'

Spawning = Class{}

function Spawning:init(enemiesManager)
	self.enemiesManager = enemiesManager
	
	self.spawnTimer = 0
	self.spawnInterval = 4
	
	self.enemyRadius = 10
end

function Spawning:update(dt)
	self.spawnTimer = self.spawnTimer + dt
	if self.spawnTimer > self.spawnInterval then
		self:spawnEdge()
		self.spawnTimer = 0
		if self.spawnInterval > 1 then
			self.spawnInterval = self.spawnInterval - 0.1
		end
	end
end

function Spawning:draw()
end

function Spawning:spawnEdge()
	local side = math.random(4)
	if side == 0 then
		self.enemiesManager:emplace(0 - self.enemyRadius, math.random(100, WINDOW_HEIGHT - 100), player)
	elseif side == 1 then
		self.enemiesManager:emplace(math.random(100, WINDOW_WIDTH - 100), 0 - self.enemyRadius, player)
	elseif side == 2 then
		self.enemiesManager:emplace(WINDOW_WIDTH + self.enemyRadius, math.random(100, WINDOW_HEIGHT - 100), player)
	else
		self.enemiesManager:emplace(math.random(100, WINDOW_WIDTH - 100), WINDOW_HEIGHT + self.enemyRadius, player)
	end
end