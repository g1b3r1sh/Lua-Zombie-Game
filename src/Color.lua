Color = Class{}

function Color:init(r, g, b)
	self.r = r
	self.g = g or r
	self.b = b or r
end

function Color:getValues()
	return self.r/255, self.g/255, self.b/255
end

Color.terms = {
	lightgray = Color(211),
	gray = Color(128),
	green = Color(0, 128, 0),
	blue = Color(0, 0, 255),
	black = Color(0),
	lightgreen = Color(50, 200, 50),
	red = Color(200, 50, 50)
}