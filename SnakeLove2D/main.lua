math.randomseed(os.time())


function love.load()

snakeSegments = {
	{x=3,y=0},
	{x=2,y=0},
	{x=1,y=0}
}

applesTab = { }


size = 20
direction = {'right'}
timer = 0.1
newApples()
end


function love.update(dt)
	timer = timer - dt
	--Wall Hit
	if snakeSegments[1].x > 23 then
		love.event.quit()
	elseif snakeSegments[1].x < 0 then
		love.event.quit()
	elseif snakeSegments[1].y < 0 then
		love.event.quit()
	elseif snakeSegments[1].y > 23 then
		love.event.quit()
	end
	--Apple Hit

	
	-- To make sure the direction goes where its supposed to	
	if #direction > 1 then
		table.remove(direction, 1)
	end

	newPositionX = snakeSegments[1].x
	newPositionY = snakeSegments[1].y
	--Movements
	if (timer < 0) then

		if direction[1] == 'right' then
			newPositionX = newPositionX + 1
		elseif direction[1] == 'left' then
			newPositionX = newPositionX - 1
		elseif direction[1] == 'up' then
			newPositionY = newPositionY - 1
		elseif direction[1] == 'down' then
			newPositionY = newPositionY + 1
		end
		--Body Hit
		for i,v in ipairs(snakeSegments) do
			if newPositionX == v.x and newPositionY == v.y then
				love.event.quit()
			end
		end
		
		timer = 0.1
		--Basically This adds a new segment at the head and remove the one from the back, making it look like its movig
		--forward 
		table.insert(snakeSegments, 1, {x=newPositionX, y=newPositionY})
		--Removes the one at the back so that it doesnt look like theres more than what there is
		table.remove(snakeSegments)
	end
	if snakeSegments[1].x == applesTab[#applesTab].x and snakeSegments[1].y == applesTab[#applesTab].y  then
		    applesTab[1].x = math.random(0,23) 
		    applesTab[1].y = math.random(0,23)
			newSegment()
	end

end

function  love.draw()
	
	love.graphics.setBackgroundColor(37/255,80/255,122/255)
	--Draws the Thing
	for i,v in ipairs(snakeSegments) do
			love.graphics.setColor(255, 255, 255, 255)
		love.graphics.rectangle('line', v.x * size, v.y * size	, size - 1, size -1)
	end
	--Draw Apple
	for i,v in ipairs(applesTab) do
		love.graphics.setColor(255, 0, 0, 0.7)
		love.graphics.rectangle('fill', v.x * size - 1, v.y * size - 1, size -1, size)
	end

end

function  love.keypressed(key )
	if key == 'right' and direction[#direction] ~= 'left' and direction[#direction] ~= 'right' then
		table.insert(direction, 'right')
	elseif key == 'left' and direction[#direction] ~= 'right' and direction[#direction] ~= 'left' then
		table.insert(direction, 'left')
	elseif key == 'up' and direction[#direction] ~= 'up' and direction[#direction] ~= 'down' then
		table.insert(direction, 'up')
	elseif key == 'down' and direction[#direction] ~= 'down' and direction[#direction] ~= 'up' then
		table.insert(direction, 'down')
	end
	
end

function  newSegment()
table.insert(snakeSegments, {x=snakeSegments[#snakeSegments].x -1, y=snakeSegments[#snakeSegments].y-1})
end
function newApples()

table.insert(applesTab, {x=math.random(0,23),y=math.random(0,23),w=size,h=size})

end
