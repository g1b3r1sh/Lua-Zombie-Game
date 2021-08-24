require 'Player'
require 'Color'
require 'Gun'
require 'Circle'

Hud = Class{}

function Hud:init(player)
	self.fonts = {
		-- Roboto by Google Android Design 
		normal = love.graphics.newFont('Roboto-Condensed.ttf', 20),
		big = love.graphics.newFont('Roboto-Condensed.ttf', 30),
		small = love.graphics.newFont('Roboto-Condensed.ttf', 15)
	}
	
	self.player = player
	
	self.currentFont = self.fonts.normal
	self.padding = 5
	self.playerPadding = -3
end

function Hud:draw()
	if gameState == 'play' or gameState == 'pause' then
		love.graphics.setColor(COLORS.black:getValues())
		self:setFont(self.fonts.normal)
		love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 5, 5)
		
		self:drawStationary()
		
		if self.player.currentGun.state == 'reload' and self.player.currentGun.reloadTimer > 0 then
			self:setFont(self.fonts.small)
			love.graphics.printf(string.format('%.1f', self.player.currentGun.reloadTimer), self.player.body.x - self.player.body.r + self.playerPadding, self.player.body.y + self.player.body.r + 3, self.player.body.r * 2 - self.playerPadding * 2, 'center')
		end
	elseif gameState == 'gameover' then
		love.graphics.setColor(COLORS.black:getValues())
		self:setFont(self.fonts.big)
		
		love.graphics.printf("Game Over", 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
		love.graphics.printf("Final Kills: " .. player.kills, 0, WINDOW_HEIGHT / 2 + self.currentFont:getHeight() + self.padding, WINDOW_WIDTH, 'center')
	end
end

function Hud:setFont(font)
	self.currentFont = font
	love.graphics.setFont(self.currentFont)
end

function Hud:drawStationary()
	love.graphics.setColor(COLORS.black:getValues())
	self:setFont(self.fonts.big)
	
	love.graphics.printf(self.player.currentGun.name, self.padding, WINDOW_HEIGHT - self.currentFont:getHeight() - self.padding, WINDOW_WIDTH - self.padding * 2, 'right')
	love.graphics.printf(tostring(self.player.currentGun.clip) .. '/' .. tostring(self.player.currentGun.clipSize), self.padding, WINDOW_HEIGHT - 2 * (self.currentFont:getHeight() + self.padding), WINDOW_WIDTH - self.padding * 2, 'right')
	
	love.graphics.printf(tostring(self.player.health) .. '/' .. tostring(self.player.maxHealth), self.padding, WINDOW_HEIGHT - self.currentFont:getHeight() - self.padding, WINDOW_WIDTH - self.padding, 'left')
	love.graphics.printf('Health:', self.padding, WINDOW_HEIGHT - 2 * (self.currentFont:getHeight() + self.padding), WINDOW_WIDTH - self.padding * 2, 'left')
	
	love.graphics.printf('Kills: ' .. self.player.kills, self.padding, self.padding, WINDOW_WIDTH - self.padding * 2, 'right')
	
	if gameState == 'pause' then
		love.graphics.printf("Pause", 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
	end
end

function Hud:debugText(text)
	-- Printf to view internal values
	love.graphics.setColor(COLORS.black:getValues())
	love.graphics.printf(text, 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
end