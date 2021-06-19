
local ks = require 'keyboardshortcut'
local grv = require 'gravitals'

function love.load()
	--Load UI Properties
	FastHandFont = love.graphics.newFont('FastHand-lgBMV.ttf', 15)
	love.graphics.setFont(FastHandFont)

	box = ks:newObj(love.graphics.getWidth()/2 - 50, 300, 100, 20)

	--Load Gravitals.Lua Properties
	grv:load()
	grv_laser = grv.getLaser() 
	--Player Properties
 	player = ks:newObj(love.graphics.getWidth()/2-15, love.graphics.getHeight()/2 -15, 30, 30 )
 	player.health = 100
 	player.speed = 150 

 	--Go Untouch Mode
 	untouch_cd = 0.5
 	isUntouchable = false
 	untouchable_duration = 1.25
end

function  love.update(dt)
	--Updates gravitals
	grv:update(dt)

	untouch_cd = untouch_cd - dt
	--Player Controls
	if love.keyboard.isDown('w') and player.y > 0 then
		player.y = player.y - player.speed * dt
	elseif love.keyboard.isDown('s') and player.y < love.graphics.getHeight()- player.h then
		player.y = player.y + player.speed * dt
	elseif love.keyboard.isDown('a') and player.x > 0 then
		player.x = player.x - player.speed * dt
		elseif love.keyboard.isDown('d') and player.x < love.graphics.getWidth() - player.w then
		player.x = player.x + player.speed * dt
	end
	--Player Untouchable Controls
	if love.keyboard.isDown('space') and untouch_cd < 0 then
		isUntouchable = true
	end

	--Check if user is not invisible
	if (isUntouchable == false) then
		for i=1,#grv_laser do
			if CheckCollision(player.x, player.y, player.w, player.h, grv_laser[i].x,  grv_laser[i].y, grv_laser[i].w, grv_laser[i].h ) then
				love.event.quit()
			end
		end
	end
	--Duration of being untouchable
	if (isUntouchable) then
		untouchable_duration = untouchable_duration - dt
		if (untouchable_duration < 0) then		
			untouchable_duration = 1.25
			untouch_cd = 0.5
			isUntouchable = false
		end
	end
end

function  love.draw( )
	--Draws Boxes
	love.graphics.rectangle('line', box.x, box.y, box.w,box.h)	
	love.graphics.print("Untouchable?",box.x- 5 , box.y - 20)
	love.graphics.print(tostring(isUntouchable), box.x + 30, box.y)

	if (isUntouchable) then

		love.graphics.print(tostring(round(untouchable_duration, 2)), 225, 240)
	end
	grv:draw()
	love.graphics.setColor(255, 255, 255)
	ks:draw(player, 'r')

end
--Other Functions
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end