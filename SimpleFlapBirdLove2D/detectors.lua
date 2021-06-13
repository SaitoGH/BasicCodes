local obs = require 'obstacles'
local detectors = {}


function detectors:new() 

--Detectors
table.insert(detectors, {x=480, y=obs.returnVal_neg() + 300 , w=50, h=obs.gapCalculator(), speed=75 })

end
function detectors:draw()

for i,v in ipairs(detectors) do
	love.graphics.setColor(255, 255, 255, 0.3)
	love.graphics.rectangle('fill', v.x, v.y, v.w, v.h)
end
end

function detectors:update(dt)
--Moves Obstacles to the left
 for _,v in ipairs(detectors) do
 	v.x = v.x - v.speed * dt
 end
  for k,v in ipairs(detectors) do
 	if (v.x < -300) then
 		table.remove(detectors, k)
	 end
 end

end

return detectors