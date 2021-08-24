require 'Player'
require 'Crosshair'
require 'Mouse'

Controls = Class{}

function Controls:init(player, crosshair)
	self.player = player
	self.crosshair = crosshair
	
	self.mouse = Mouse()
end

function Controls:update(dt)
	self:mouseControls(dt)
	self:movementControls(dt)
end

function Controls:mouseControls(dt)
	self.mouse:update(dt)
	self.crosshair:setPos(self.mouse:getPos())
	if self.mouse:isDown() then
		self.crosshair:setClicking(true)
	else
		self.crosshair:setClicking(false)
	end
	
	if gameState == "play" then
		self.player:pointAt(self.mouse:getPos())
		
		if self.mouse:isDown() then
			self.player:shoot()
		end
	end
end

-- TODO: Separate velocity functionality from controls
function Controls:movementControls(dt)
	local dx, dy = self.player:getVel()
	if love.keyboard.isDown('w') then
		dy = -self.player.maxSpeed
	elseif love.keyboard.isDown('s') then
		dy = self.player.maxSpeed
	else
		dy = 0
	end
	
	if love.keyboard.isDown('a') then
		dx = -self.player.maxSpeed
	elseif love.keyboard.isDown('d') then
		dx = self.player.maxSpeed
	else
		dx = 0
	end
	self.player:setVel(dx, dy)
end