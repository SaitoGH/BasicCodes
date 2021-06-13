
math.randomseed(os.time())
local obstacles = {}

--Val 
val_pos = 0
val_neg = 0
--Instantiate new Obstacles
function obstacles:new()
val_pos = math.random(250,450)
val_neg = math.random(-270,-100)

table.insert(obstacles, {x=480, y=val_pos, w=50, h=300, speed = 75})
table.insert(obstacles, {x=480, y=val_neg, w=50, h=300, speed = 75})


end
--Draws the Obstacles
function obstacles:draw()

for i,v in ipairs(obstacles) do
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('line', v.x, v.y, v.w, v.h)
end


end
--Debug/Calculates the gap size
function obstacles.gapCalculator()
equation = 480 - (val_neg + 300) -(480-val_pos)
return equation 
end

function obstacles.returnVal_neg()
return val_neg
end

--Updates Obstacles
function obstacles:update(dt)
--Moves Obstacles to the left
 for _,v in ipairs(obstacles) do
 	v.x = v.x - v.speed * dt
 end
--If obstacles leaves the screen its deleted
 for k,v in ipairs(obstacles) do
 	if (v.x < -300) then
 		table.remove(obstacles, k)
	 end
 end


end

return obstacles
