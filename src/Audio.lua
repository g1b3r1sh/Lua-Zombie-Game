Audio = Class{}

-- Sounds for each gun: Shot, reload, dry, switch
-- Other sounds: player hurt, player dead, enemy hurt, enemy dead

function Audio:init()
	self:loadSounds()
	self.sounds['ambient']:setVolume(0.3)
	self.sounds['ambient']:setLooping(true)
	self:play('ambient')
end

function Audio:draw()
end

function Audio:loadSounds()
	-- Gun Sounds and Zombie Crowd Sound Credits: https://www.fesliyanstudios.com
	-- Player Sound Credits: Half Life 2
	self.sounds = {
		-- Gun Sounds
			-- Shooting
			['Pistol Shot'] = love.audio.newSource('/sounds/pistol-shot.mp3', 'static'),
			['Assault Rifle Shot'] = love.audio.newSource('/sounds/rifle-shot.mp3', 'static'),
			['Shotgun Shot'] = love.audio.newSource('/sounds/shotgun-shot.mp3', 'static'),
			['SMG Shot'] = love.audio.newSource('/sounds/smg-shot.wav', 'static'),
			['Sniper Rifle Shot'] = love.audio.newSource('/sounds/sniper-shot.mp3', 'static'),
			['Super Gun Shot'] = love.audio.newSource('/sounds/machine-gun-shot.mp3', 'static'),
			-- Equipping
			['Pistol Equip'] = love.audio.newSource('/sounds/pistol-equip.mp3', 'static'),
			['Assault Rifle Equip'] = love.audio.newSource('/sounds/rifle-equip.mp3', 'static'),
			['Shotgun Equip'] = love.audio.newSource('/sounds/shotgun-equip.mp3', 'static'),
			['SMG Equip'] = love.audio.newSource('/sounds/smg-equip.mp3', 'static'),
			['Sniper Rifle Equip'] = love.audio.newSource('/sounds/sniper-equip.mp3', 'static'),
			['Super Gun Equip'] = love.audio.newSource('/sounds/machine-gun-equip.mp3', 'static'),
		
		['reloadStart'] = love.audio.newSource('/sounds/reload.mp3', 'static'),
		['reloadEnd'] = love.audio.newSource('/sounds/reload-finish.mp3', 'static'),
		['dry'] = love.audio.newSource('/sounds/dry.mp3', 'static'),
		-- Entity Sounds
		['pain1'] = love.audio.newSource('/sounds/pain1.ogg', 'static'),
		['pain2'] = love.audio.newSource('/sounds/pain2.ogg', 'static'),
		['pain3'] = love.audio.newSource('/sounds/pain3.ogg', 'static'),
		['death'] = love.audio.newSource('/sounds/death.ogg', 'static'),
		['ambient'] = love.audio.newSource('/sounds/ambient.mp3', 'static'),
	}
end

function Audio:play(sound)
	self.sounds[sound]:seek(0)
	self.sounds[sound]:play()
end

function Audio:stop(sound)
	self.sounds[sound]:stop()
end

function Audio:isPlaying(sound)
	return self.sounds[sound]:isPlaying()
end

function Audio:pause()
	self.paused = love.audio.pause()
end

function Audio:resume()
	love.audio.play(self.paused)
	self.paused = nil
end