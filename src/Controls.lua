Controls = Class{}

require 'Mouse'

function Controls:init(player)
	self.player = player
	
	self.mouse = Mouse()
end

function Controls:update(dt)
	self:mouseControls(dt)
	self:keyboardControls(dt)
end

function Controls:mouseControls(dt)
	self.mouse:update(dt)
	
	self.player.currentGun.pointX = self.mouse.x
	self.player.currentGun.pointY = self.mouse.y
	
	if self.mouse:isDown() then
		self.player.currentGun:shoot(self.mouse:getPos())
	end
end

function Controls:keyboardControls(dt)
	if love.keyboard.isDown('w') then
		self.player.body.dy = -self.player.speed
	elseif love.keyboard.isDown('s') then
		self.player.body.dy = self.player.speed
	else
		self.player.body.dy = 0
	end
	
	if love.keyboard.isDown('a') then
		self.player.body.dx = -self.player.speed
	elseif love.keyboard.isDown('d') then
		self.player.body.dx = self.player.speed
	else
		self.player.body.dx = 0
	end
end