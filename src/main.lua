-- Game where you shoot stuff

--[[
	Ideas for future development:
	Bullets lose damage over range, sprint meter, visual indicator if zombies about to do damage, ammo, grenade, sniper is piercing, better spawning mechanics
	What to do next time:
	More classes (game object, map object, hud object, etc), use ECS, code around game states
]]--

Class = require 'class'

require 'Audio'

require 'util'
require 'Color'
require 'Circle'
require 'EntManager'

require 'Controls'
require 'Crosshair'

require 'Healthbar'
require 'Player'
require 'Enemy'

require 'Bullet'
require 'Gun'
require 'Shotgun'

require 'Collision'
require 'Spawning'

require 'Hud'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

BOUNDARY_LEFT = 0 - 100
BOUNDARY_RIGHT = WINDOW_WIDTH + 100
BOUNDARY_TOP = 0 - 100
BOUNDARY_BOTTOM = WINDOW_HEIGHT + 100


math.randomseed(os.time())

colors = {
	lightgray = Color(211),
	gray = Color(128),
	green = Color(0, 128, 0),
	blue = Color(0, 0, 255),
	black = Color(0, 0, 0),
	lightgreen = Color(50, 200, 50),
	red = Color(200, 50, 50)
}

function love.load()
	
	-- Window Setup
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
	love.window.setTitle('Zombie Sandbox Survival')
	
	-- Setup Fonts
	-- Roboto by Google Android Design 
	hudFont = love.graphics.newFont('Roboto-Condensed.ttf', 20)
	hudFontBig = love.graphics.newFont('Roboto-Condensed.ttf', 30)
	hudFontSmall = love.graphics.newFont('Roboto-Condensed.ttf', 15)
	
	-- Setup Objects
	audio = Audio()
	player = Player()
	controls = Controls(player)
	crosshair = Crosshair(controls.mouse)
	enemiesManager = EntManager(Enemy, function(enemy)
		if enemy.dead then
			player.kills = player.kills + 1
		end
		return enemy.dead == false
	end)
	collision = Collision()
	spawning = Spawning(enemiesManager)
	hud = Hud(player)
	
	gameState = 'play'
	gamemode = 'survival'
	
	konami = {'up', 'up', 'down', 'down', 'left', 'right', 'left', 'right', 'b', 'a'}
	konamiState = 1
	-- Test Objects
	--enemiesManager:add(100, WINDOW_HEIGHT / 2, player)
end

function love.update(dt)
	crosshair:update(dt)
	if gameState == 'play' then
		controls:update(dt)
		
		player:update(dt)
		enemiesManager:update(dt)
		
		collision:iterateBulletCollision(player.bullets, enemiesManager)
		collision:iterateCircleCollision(player, enemiesManager)
		collision:selfIterateCircleCollision(enemiesManager)
		hud:update(dt)
		
		if gamemode == 'survival' then
			spawning:update(dt)
		end
	elseif gameState == 'gameover' then
		enemiesManager:update(dt)
		collision:selfIterateCircleCollision(enemiesManager)
	end
end

function love.draw()
	love.graphics.clear(colors.lightgray:getValues())
	
	player:draw()
	enemiesManager:draw()
	
	hud:draw()
	crosshair:draw()
	-- Printf to view internal values
	--love.graphics.setColor(colors.black:getValues())
	--love.graphics.printf(konamiState, 0, WINDOW_HEIGHT / 2, WINDOW_WIDTH, 'center')
end

function gameOver()
	gameState = 'gameover'
end

function togglePause()
	if gameState == 'play' then
		gameState = 'pause'
		audio:pause()
	elseif gameState == 'pause' then
		gameState = 'play'
		audio:resume()
	end
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	elseif key == 'g' then
		togglePause()
	end
	if gameState == 'play' then
		-- Sandbox controls
		if gamemode == 'sandbox' then
			if key == 'f' then
				enemiesManager:add(controls.mouse.x, controls.mouse.y, player)
			elseif key == 'v' then
				player.maxHealth = 9999
				player.health = 9999
			elseif key == 'b' then
				if audio:isPlaying('ambient') then
					audio:stop('ambient')
				else
					audio:play('ambient')
				end
			elseif key == 'c' then
				player.currentGun = Gun('Super Gun', player.body, player.bullets, 0.05, 999, 0.5, 1500, 0, 25)
				audio:play('Super Gun Equip')
			end
		end
		-- Normal controls
		if key == 'r' then
			player.currentGun:reload()
		-- Weapon switching
		elseif key == '1' then
			player:switchGun('pistol')
		elseif key == '2' then
			player:switchGun('rifle')
		elseif key == '3' then
			player:switchGun('shotgun')
		elseif key == '4' then
			player:switchGun('smg')
		elseif key == '5' then
			player:switchGun('sniper')
		end
		-- Konami
		if key == konami[konamiState] then
			konamiState = konamiState + 1
			if konamiState == 11 then
				gamemode = 'sandbox'
				audio:play('Super Gun Equip')
			end
		end
	end
end