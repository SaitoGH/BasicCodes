local Chunks = require 'chunks'
local Rooms = require 'rooms'

local Player = {}
restrictMovement = true
restrictTimer = 0.02
local PlayerisInteracting = false
local ChunksRecounter = {}
local DisplayBox = {
		x=160,
		y=0,
		w=80,
		h=160,
		BaseDraw= function()
			love.graphics.print("Room:\n" .. Player1.currentR, 165, 10)
			love.graphics.print("PlayerDir:".."\n".. Player1.dir, 165, 35)
			love.graphics.print("Loadroom:\n" .. tostring(Rooms:loadRoom()), 165, 60)
		end,

		DrawMode = function()

			love.graphics.print("Status:\n".. Player1.currentStatus, 165, 90)
			Player1.currentStatus = "Idle"
		end,
		
	}
DisplayBox.mt = {}
 



--Game Prop
GameWidth = 160
GameHeight = 160
--Player Movements
timeInterval = 0.2
restrictMovement = false
--Font
playerFont = love.graphics.newFont("Pixeboy.ttf", 15)
function Player:load()
Player1 = Player:New(80,80, 200, "MainRoom")

Rooms:ReturnTable(Player1.currentR)

end
local CFPtimer = 0.5
function Player:update(dt)

	Player:Controls(dt)

	if Player:CollideEnter() then
		
	end
	
end

function Player:draw()
love.graphics.setFont(playerFont)

love.graphics.setColor(255,255,255)
--Player
love.graphics.print("P", Player1["x"], Player1["y"])
love.graphics.rectangle("line",DisplayBox.x,DisplayBox.y,DisplayBox.w,DisplayBox.h)
DisplayBox:BaseDraw()
DisplayBox:DrawMode()
--Chunks

end


--Player Related

function Player:New(x, y, speed, room)
	local PlayerProperties = {
		x = x or 0,
		y = y or 0,
		w = 3,
		h = 3,
		dir = "",
		currentStatus = "Idle",
		currentR = room,
		speed = speed or 300,
	}

	setmetatable(PlayerProperties, Player)
	return PlayerProperties
end
--Player Movements Logic
newR,newC = 9,9--Row is Y axis, Column is X
function Player:Controls(dt)
	
	
	--Can change the values but now you have to find a way which chunk it is in
	for i,v in ipairs(Chunks:ChunksRecounter()) do
		Player1.x = Chunks:ChunksRecounter()[newR][newC].x
		Player1.y = Chunks:ChunksRecounter()[newR][newC].y
	end
	--Movements
	if PlayerisInteracting == false then
		if love.keyboard.isDown("w") and newR > 1 then
			--Player1.y = Player1.y - Player1.speed * dt
			newR=newR - 1
			Player1.currentStatus = "Moving"
			Player1.dir = "UP"
		
		elseif love.keyboard.isDown("s") and newR < 18  then
			--Player1.y = Player1.y + Player1.speed * dt
			newR=newR + 1
			Player1.currentStatus = "Moving"
			Player1.dir = "DOWN"
			
		elseif love.keyboard.isDown("a") and newC > 1 then
			--Player1.x = Player1.x - Player1.speed * dt
			newC = newC - 1
			Player1.currentStatus = "Moving"
			Player1.dir = "LEFT"
			
		elseif love.keyboard.isDown("d") and newC < 18 then
			--Player1.x = Player1.x + Player1.speed * dt
			newC = newC + 1
			Player1.currentStatus = "Moving"
			Player1.dir = "RIGHT"
		end
	end

	
	--Extra Controls
	--print(newR, newC)
	--Interact
	if love.keyboard.isDown("space") and PlayerisInteracting == false then
		CheckLocation()
	end
		
end
-- Too bored to do a cleaner implementation
function Player:CollideEnter()
	
end

function CheckLocation()
local x,y = newC, newR
local getChunks
for i,v in ipairs(Chunks:ChunksCounter()) do
	print(Chunks:ChunksCounter()[i].LetterTable[newR][newC].letter)
end

PlayerisInteracting = true
end


function ColLetter(x2,y2)
return Player1.y > y2  and
	Player1.y < y2 + 5  and
	Player1.x > x2 and
	Player1.x < x2 + 5
end

--Useful, Returns what chunk i am in

function ReturnChunk()
local y, x = newR, newC
local isUp,isLeft = false, false
--Calculations
if y < 10 then
	isUp = true
end
if x < 10 then
	isLeft = true
end
---Get Returns by comparing
if isUp and isLeft then
	return 1
elseif isUp and isLeft == false then
	return 2
elseif isUp==false and isLeft then
	return 3
elseif isUp==false and isLeft == false then
	return 4
end

end



return Player