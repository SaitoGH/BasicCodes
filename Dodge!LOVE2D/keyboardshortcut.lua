local ks = {}
ks.mt = {}
setmetatable(ks, ks.mt)

function ks:newObj(x, y, w, h)
	local o = o or {}
	o.x = x or 0
	o.y = y or 0
	o.w = w or 0
	o.h = h or 0
	return o
end




function ks:draw(self, t, a)
	if t == 'r' then
		love.graphics.setColor(255, 255, 255, a)
		love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
	end
end
function ks:print(str, x, y)
	love.graphics.print(str, x, y)
end
return ks
