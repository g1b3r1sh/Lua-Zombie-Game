Color = Class{}

function Color:init(r, g, b)
	if g == nil and b == nil then
		self.r = r
		self.g = r
		self.b = r
	else
		self.r = r
		self.g = g
		self.b = b
	end
end

function Color:getValues()
	return self.r/255, self.g/255, self.b/255
end