local mouseFunc={}

function mouseFunc:update()
	mouse = {
		x = love.mouse.getX(),
		y = love.mouse.getY(),
		w=3,
		h=3

	}
end
function mouseFunc:CheckIfHover(x,y,w, h)
	return  mouse.x + mouse.w > x and 
			mouse.x < x + w and 
			mouse.y + mouse.h > y and 
			mouse.y < y + h
end

return mouseFunc