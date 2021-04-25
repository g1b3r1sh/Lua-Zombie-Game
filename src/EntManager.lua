EntManager = Class{}

function EntManager:init(Object, rmFunction)
	self.objects = {}
	
	self.Object = Object
	self.rmFunction = rmFunction
end

function EntManager:update(dt)
	-- Modified Algorithm By Mitch McMabers from https://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
	local j, n = 1, #self.objects;
	
	for i=1,n do
		self.objects[i]:update(dt)
		
        if self.rmFunction(self.objects[i]) then
            -- Move i's kept value to j's position, if it's not already there.
            if i ~= j then
                self.objects[j] = self.objects[i]
                self.objects[i] = nil
            end
            j = j + 1 -- Increment position of where we'll place the next kept value.
        else
            self.objects[i] = nil
        end
    end
end

function EntManager:draw()
	for _, v in ipairs(self.objects) do
		v:draw()
	end
end

function EntManager:add(...)
	self.objects[#(self.objects) + 1] = self.Object(...)
end