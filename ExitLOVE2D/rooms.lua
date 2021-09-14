local Chunks = require 'chunks'

local Rooms = {}
loadRoom = true
GameRooms = {}
GameRoomsInt = {}
local currentRoom = "MainRoom"
---GameFunctions

function Rooms:load()

Rooms:New("MainRoom", 1, 1, 1, 1, "MIDDLE")
Rooms:New("GrassyLands", 1, 1, 1, 1, "UP")
Rooms:New("PoolSide", 1, 2, 1, 2, "RIGHT")
Rooms:New("WinRoom", 1, 2, 1, 2, "LEFT")
Rooms:New("Dungeon", 1, 2, 1, 2, "DOWN")

end

function Rooms:update(dt)
	
	Rooms:RecounterChunks()
		
	ProduceKey()

end	


function Rooms:Generate(dt)
	
	if loadRoom then	
		Rooms:ReturnTable(currentRoom)
		Chunks:StartGeneration() --Where it all begin
	
		loadRoom = false
	end
	

end

function Rooms:New(name, c1, c2,c3, c4, direction)
_G[name] = { {c1,c2},{c3,c4}, dir=direction  }
GameRooms[name] = _G[name]
table.insert(GameRooms[name], _G[name])
table.insert(GameRoomsInt, {name=name, dir=direction})

end


--Change Rooms
function Rooms:EnterRoom(dir, room)

end

--Sumbat what room it is
function Rooms:ReturnTable(current_room)
	for k,v in pairs(Chunks:CounterChunksTable()) do
 	 Chunks:CounterChunksTable()[k] = nil
	end
	
	for i,v in ipairs(GameRoomsInt) do
		if  v.name == current_room then
			table.insert(Chunks:CounterChunksTable(), GameRooms[current_room][1])
			table.insert(Chunks:CounterChunksTable(), GameRooms[current_room][2])
		end
	end
end

function Rooms:RecounterChunks()
	for k,v in pairs(Chunks:ChunksRecounter()) do
 	 Chunks:ChunksRecounter()[k] = nil
	end
	for r=0,17 do	
		table.insert( Chunks:ChunksRecounter(), {})
		for c=0,17 do--Keep in mind this is equal to c=0,perChunks,10, so i have to *10 with c/r
			local newX = (c*10) * sizeMultiplier
			local newY = (r*10) * sizeMultiplier
			local newRecount = {}
			newRecount["letter"] = " "

			for i,v in ipairs(Chunks:ChunksCounter()) do
				for r=0,8 do
					for c=0,8 do
						if newX == Chunks:ChunksCounter()[i].LetterTable[r+1][c+1].x then
							newRecount["letter"] =  Chunks:ChunksCounter()[i].LetterTable[r+1][c+1].letter

						end
					end
				end
			end
		

			newRecount["x"] = newX
			newRecount["y"] = newY
			table.insert( Chunks:ChunksRecounter()[r+1], newRecount)

		end
	end

end	
--Unrelated, Only Spawn Keys
local KeydoOnce = false;
function ProduceKey()
	if KeydoOnce == false then
		getRoom = math.random(1,#GameRoomsInt)
		getChunk = math.random(1,#Chunks:ChunksCounter())
		x,y = math.random(1,9), math.random(1,9)
		KeydoOnce = true
	end
	if Player1.currentR == GameRoomsInt[getRoom].name then
		Chunks:ChunksCounter()[getChunk].LetterTable[y][x].letter = "K"
	end

end
function Rooms:loadRoom()
return loadRoom
end
function Rooms:GetRoomsAv()
return GameRoomsInt
end

return Rooms