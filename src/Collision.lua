require 'Enemy'
require 'Player'
require 'Circle'
require 'util'

Collision = {}

-- TODO: Seperate bullet interaction behavior with collision behavior

function Collision:iterateBulletCollision(bulletsManager, targetsManager)
	for _, t in ipairs(targetsManager.objects) do
		for _, b in ipairs(bulletsManager.objects) do
			self:doBulletCollision(b, t)
		end
	end
end

function Collision:doBulletCollision(bullet, target)
	if self:checkCircleCollision(bullet.body, target.body) then
		target:damage(bullet.damage)
		bullet.remove = true
	end
end

function Collision:iterateCircleCollision(manager1, manager2)
	for _, v1 in ipairs(manager1.objects) do
		for _, v2 in ipairs(manager2.objects) do
			self:correctCircleCollision(v1.body, v2.body)
		end
	end
end

function Collision:selfIterateCircleCollision(manager)
	for k, v in ipairs(manager.objects) do
		for i = k + 1, #manager.objects do
			self:correctCircleCollision(v.body, manager.objects[i].body)
		end
	end
end

function Collision:checkCircleCollision(c1, c2)
	return circleAABB(c1, c2) and circleInCircle(c1, c2)
end

function Collision:correctCircleCollision(c1, c2)
	if self:checkCircleCollision(c1, c2) then
		local midX = (c1.x + c2.x) / 2
		local midY = (c1.y + c2.y) / 2
		local dist = math.sqrt(squared(c1.x - c2.x) + squared(c1.y - c2.y)) or 1
		c1:setPos(midX + c1.r * (c1.x - c2.x) / dist, midY + c1.r * (c1.y - c2.y) / dist)
		c2:setPos(midX + c2.r * (c2.x - c1.x) / dist, midY + c2.r * (c2.y - c1.y) / dist)
	end
end