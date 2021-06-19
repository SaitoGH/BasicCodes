local ks = require'keyboardshortcut'
math.randomseed(os.time())
local gravitals = {}
grv = {}
grv_laser = {}
cutter_speed = 75
laserCooldown = 2
function gravitals:load()
	--Event Properties
	typesofevents = {'Cutter', 'Pole', 'MovingPole', 'Lasa'}
	current_event = 0
	event_queue = {}
	spawn_event = false
	clear_cd = 1
end

function gravitals:update(dt)

	
	if current_event == typesofevents[2] then
		clear_cd = clear_cd - dt
		if (clear_cd < 0) then
			for i=1,#grv do
				if (grv[i].type == 'p') then
					grv[i] = nil
				end
			end
			for i=1,#grv_laser do
				if (grv_laser[i].type == 'p') then
					grv_laser[i] = nil
				end
			end
			clear_cd = 1
		end
	end

	--Spawn Things after 2 seconds
	laserCooldown = laserCooldown - dt
	if laserCooldown < 0 then
		randomEvents()
		spawnevent()
		if #event_queue > 1 then
			table.remove(event_queue, 1)
		end
		laserCooldown = 2
	end
	--Makes Cutter Move Up and Down
	for i=1,#grv do	
		--Makes Cutter[1]Move Up and down
		if grv[i].ctype == 0 then
			grv[i].y = grv[i].y + cutter_speed * dt
			grv_laser[i].y = grv[i].y
		elseif grv[i].ctype == 1 then
			grv[i].y = grv[i].y - cutter_speed * dt
			grv_laser[i].y = grv[i].y
		end
		--Makes Moving Poles Moves right or left
		if grv[i].r == 1 then
			grv[i].x = grv[i].x + cutter_speed * dt
			grv_laser[i].x = grv[i].x
		elseif grv[i].r == 2 then
			grv[i].x = grv[i].x - cutter_speed * dt 
			grv_laser[i].x = grv[i].x 
		end
		--Makes Lasa moves left or right
		if grv[i].d == 1 then
			grv[i].x = grv[i].x + 200 * dt
			grv_laser[i].x = grv[i].x
		elseif grv[i].d == 2 then
			grv[i].x = grv[i].x - 200 * dt
			grv_laser[i].x = grv[i].x 
		end
	end
	
end

function gravitals:draw()
	--Draws Rectangles Base
	for i=1,#grv do
		ks:draw(grv[i], 'r')
	end	
	--Draws the Rectangle Lasers
	for i=1,#grv_laser do
		love.graphics.setColor(255, 255, 255, 0.5)
		ks:draw(grv_laser[i], 'r', 0.5)
	end	

end
--Get table for grv_laser
function gravitals.getLaser()
	return grv_laser
end
--Get what event is next
function randomEvents()
	local getNumb = math.random(1,4)
	current_event = typesofevents[getNumb]
	table.insert(event_queue, current_event)

end

function spawnevent()
	--Generation For Cutter
	if current_event == typesofevents[1] then
		for i=0,1 do
			cutters = ks:newObj(i * 450, i * 450, 30, 30)
			cutters.ctype = i

			if i == 0 then
				cutters_laser = ks:newObj(cutters.x + 30, cutters.y, 450, 30)
			elseif i == 1 then
				cutters_laser =  ks:newObj(cutters.x - 450, cutters.y, 450, 30)
			end
			table.insert(grv, cutters)
			table.insert(grv_laser, cutters_laser)
		end
	--Generation For Pole
	elseif current_event == typesofevents[2] then
		pole = ks:newObj(math.random(0,450) , 0, 30, 30)
		pole.type = 'p'
		pole_laser = ks:newObj(pole.x, pole.y + 30, 30, 450)
		pole_laser.type = 'p'

		table.insert(grv, pole)
		table.insert(grv_laser, pole_laser)
	--Generation For Moving Pole
	elseif current_event == typesofevents[3] then
		local r = math.random(1,2)
		if r ==1 then posX = -30  else posX = 480 end
		Mpole = ks:newObj(posX, 0, 30, 30)
		Mpole.r = r
		Mpole_laser = ks:newObj(Mpole.x, Mpole.y + 30, 30, 450)

		table.insert(grv, Mpole)
		table.insert(grv_laser, Mpole_laser)
	--Generation for LASA
	elseif current_event == typesofevents[4] then
		local r = math.random(1,2)
		if r ==1 then posX = -480  else posX = 480 end
		lasa = ks:newObj(posX, math.random(0, 450), 30, 30)
		lasa_laser = ks:newObj(lasa.x,lasa.y, 450, 30)
		lasa.d = r
		table.insert(grv, lasa)
		table.insert(grv_laser, lasa_laser)
	end
end

	



return gravitals