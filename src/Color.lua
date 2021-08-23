Color = Class{}

function Color:init(r, g, b)
	self.r = r
	self.g = g or r
	self.b = b or r
end

function Color:getValues()
	return self.r/255, self.g/255, self.b/255
end