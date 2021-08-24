function getAngle(x1, y1, x2, y2)
	return math.atan2(y2 - y1, x2 - x1)
end

function squared(n)
	return n * n
end

--Collision Math Functions

function aabb(side1Min, side1Max, vertical1Min, vertical1Max, side2Min, side2Max, vertical2Min, vertical2Max)
	return side1Min < side2Max and side1Max > side2Min and vertical1Min < vertical2Max and vertical1Max > vertical2Min
end

function pointInBox(pointX, pointY, sideMin, sideMax, verticalMin, verticalMax)
	return pointX > sideMin and pointX < sideMax and pointY > verticalMin and pointY < verticalMax
end

function pointInCircle(pointX, pointY, circleX, circleY, circleR)
	return (pointX - circleX) * (pointX - circleX) + (pointY - circleY) * (pointY - circleY) <= circleR * circleR
end

function circleAABB(c1, c2)
	return c1.x - c1.r < c2.x + c2.r and c1.x + c1.r > c2.x - c2.r and c1.y - c1.r < c2.y + c2.r and c1.y + c1.r > c2.y - c2.r
end

function circleInCircle(c1, c2)
	return (c1.x - c2.x) * (c1.x - c2.x) + (c1.y - c2.y) * (c1.y - c2.y) <= (c1.r + c2.r) * (c1.r + c2.r)
end