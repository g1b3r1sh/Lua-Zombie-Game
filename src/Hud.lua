Hud = Class{}

require 'Healthbar'

function Hud:init(player)
	self.player = player
	self.healthbar = Healthbar(self.player)
	
	self.currentFont = nil
	self.padding = 5
	self.playerPadding = -3
end

function Hud:update(dt)
	self.healthbar:update(dt)
end

function Hud:draw()
	if gameState == 'play' or gameState == 'pause' then
		love.graphics.setColor(colors.black:getValues())
		self:changeFont(hudFont)
		love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5)
		
		self.healthbar:draw()
		self:drawStationary()
		
		if self.player.currentGun.state == 'reload' and self.player.currentGun.reloadTimer > 0 then
			self:changeFont(hudFontSmall)
			love.graphics.printf(string.format('%.1f', self.player.currentGun.reloadTimer), self.player.body.x - self.player.body.r + self.playerPadding, self.player.body.y + self.player.body.r + 3, self.player.body.r * 2 - self.playerPadding * 2, 'center')
		end
	elseif gameState == 'gameover' then
		love.graphics.setColor(colors.black:getValues())
		self:changeFont(hudFontBig)
		
		love.graphics.printf("Game Over", 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
		love.graphics.printf("Final Kills: " .. player.kills, 0, WINDOW_HEIGHT / 2 + self.currentFont:getHeight() + self.padding, WINDOW_WIDTH, 'center')
	end
end

function Hud:changeFont(font)
	self.currentFont = font
	love.graphics.setFont(self.currentFont)
end

function Hud:drawStationary()
	love.graphics.setColor(colors.black:getValues())
	self:changeFont(hudFontBig)
	
	love.graphics.printf(self.player.currentGun.name, self.padding, WINDOW_HEIGHT - self.currentFont:getHeight() - self.padding, WINDOW_WIDTH - self.padding * 2, 'right')
	love.graphics.printf(tostring(self.player.currentGun.clip) .. '/' .. tostring(self.player.currentGun.clipSize), self.padding, WINDOW_HEIGHT - 2 * (self.currentFont:getHeight() + self.padding), WINDOW_WIDTH - self.padding * 2, 'right')
	
	love.graphics.printf(tostring(self.player.health) .. '/' .. tostring(self.player.maxHealth), self.padding, WINDOW_HEIGHT - self.currentFont:getHeight() - self.padding, WINDOW_WIDTH - self.padding, 'left')
	love.graphics.printf('Health:', self.padding, WINDOW_HEIGHT - 2 * (self.currentFont:getHeight() + self.padding), WINDOW_WIDTH - self.padding * 2, 'left')
	
	love.graphics.printf('Kills: ' .. self.player.kills, self.padding, self.padding, WINDOW_WIDTH - self.padding * 2, 'right')
	
	if gameState == 'pause' then
		love.graphics.printf("Pause", 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
	end
end