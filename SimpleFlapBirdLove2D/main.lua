local obs = require 'obstacles'
local det = require 'detectors'
math.randomseed(os.time())

function love.load()
newFont = love.graphics.newFont('FastHand-lgBMV.ttf', 25)
love.graphics.setFont(newFont)
gravity = 0


--Player Characteristic
player = {
	x=50,
	y=230,
	w=20,
	h=20,
	isjumping= false,
	jumpCooldown = 0.1,
	score= 0
}
--Score Cool
detectorCooldown = 2
--Obstacles Properties
_obs = {}
obsSpawnRate = 2 
end

function love.update(dt)
--Check if player is out of the map
if (player.y < 0) or (player.y > love.graphics.getHeight() - player.h) then
	love.event.quit()

end
--For Each Second Gravity acts upon the player and moves it down by 200
gravity = gravity + 200 * dt
--For each second player.y will change and so the block goes down 
player.y = player.y + gravity * dt
player.jumpCooldown = player.jumpCooldown - dt
--Player Flap
if player.isjumping == true and player.jumpCooldown < 0 then
	--By changing it to negative we are bouncing it back and so the block goes up again :)
	gravity = -150
	player.jumpCooldown = 0.5
	player.isjumping = false
end
--Updates Obstacles
obs:update(dt)
--Updates detectors
det:update(dt)
--If Player hits obstacles
for i=1,#obs do
 if (CheckCollision(player.x, player.y, player.w, player.h, obs[i].x, obs[i].y, obs[i].w, obs[i].h)) then
 	love.event.quit()
 end
end
--If Player hits detectors
detectorCooldown = detectorCooldown - dt
if detectorCooldown <= 0 then
	for i=1,#det do
	 if (CheckCollision(player.x, player.y, player.w, player.h, det[i].x, det[i].y, det[i].w, det[i].h)) then
	 	player.score = player.score + 0.5
	 end
	end
	detectorCooldown = 2
end
--Obstacles Spawn
obsSpawnRate = obsSpawnRate - dt
if (obsSpawnRate < 0) then
 	--Draws 2 Obstacles Up and down

	for i=1,2 do
		newObs = obs:new()	
		det:new()
		--inserts into table
		table.insert(_obs, newObs)
	end
	obsSpawnRate = 2
end
	

end


function  love.draw()
love.graphics.setBackgroundColor(37/255,80/255,122/255)
--Prints Player
love.graphics.setColor(255, 255, 255)
love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
--Prints score
love.graphics.print(player.score, 240, 10 )
--Prints Obstacles
obs:draw()
det:draw()
end


--Player Input
function  love.keypressed(key)
	if key == 'space' and player.isjumping == false then
		player.isjumping = true
	end
end

--Dont matter
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
