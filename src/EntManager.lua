EntManager = Class{}

function EntManager:init(objectClass, rmFunction)
	self.objects = {}
	
	self.objectClass = objectClass
	self.rmFunction = rmFunction
end

function EntManager:update(dt)
	-- Modified Algorithm By Mitch McMabers from https://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
	-- Removes objects by shifting all forward objects up to keep the table as an array
	local j = 1;
	
	for i = 1,#self.objects do
		self.objects[i]:update(dt)
		
        if self.rmFunction(self.objects[i]) then
            self.objects[i] = nil
        else
            -- Move i's kept value to j's position, if it's not already there.
            if i ~= j then
                self.objects[j] = self.objects[i]
                self.objects[i] = nil
            end
            j = j + 1 -- Increment position of where we'll place the next kept value.
        end
    end
end

function EntManager:draw()
	for _, v in ipairs(self.objects) do
		v:draw()
	end
end

function EntManager:emplace(...)
	self.objects[#(self.objects) + 1] = self.objectClass(...)
end