math.randomseed(os.time())

local mouseFunc = require'mousefunc'
chunksFont = love.graphics.newFont("Pixeboy.ttf", 15)
--Game Prop
GameWidth = 160
GameHeight = 160
--CHUNKS AND SETCHUNKS ARE TOTALLY DIFFERENT FROM ONE ANOTHER

--CHUNKS ARE FOR GENERATION AND LOAD
local Chunks = {}
--BITCHUNKS ARE FOR NEW CHUNKS TO BE MADE + METATABLES TO GIVE FUNCTIONS TO THESE CHUNKS
local BitChunks={}

--MetaTable For BitChunks
SetChunksMT = {
	__call = function(self)--Mainly For seeing what is happening
		love.graphics.print("x:" .. self.x, (self.x + self.w) /2, self.y + 10)
		love.graphics.print("y:" .. self.y, (self.x + self.w) /2, self.y + 20)
		love.graphics.print("type:" .. self.type_of_chunk,(self.x + self.w) /2, self.y + 30)
	end,

}

--Save Chunks Data And THe amount there is
ChunksCounter = {}

ChunksRecounter = {}
--How the chunk is going to generate Given that we have  2X2 chunks
ChunksTable = {}
ChunksLetters = {}
--Hows the size going to go change(AFFECTS ALOT)
perChunks = math.sqrt(GameWidth/10) * 10 * 2--[2 indicates the amount of boxes we want in a horizontal line]
sizeMultiplier = 0.9
function Chunks:load()

end

function Chunks:update()


end

function Chunks:draw()
	love.graphics.setFont(chunksFont) --Sets the new font

	Chunks:DrawLetterGeneration()--Draw the Letters for each chunks
		
end

--Spawn new chunks
function BitChunks:New(t_c)
local properties =
{
	x=x or 0,
	y=y or 0,
	type_of_chunk=t_c or 1,
	w=perChunks or 0,
	h=perChunks or 0,
	LetterTable = {},
	custom_type_chunk=0
	
}
	--Generate letters and put them in a table
	--[[
	ie:
	a={ {{"A", x, y}} }--Works now
	]]--
	properties.GenerateLetters = function()
		for r=0,perChunks/10 do
			table.insert(properties.LetterTable, {})
			for c=0,perChunks/10 do
				table.insert(properties.LetterTable[r+1], {})
				properties.LetterTable[r+1][c+1]["letter"] = properties.ReturnTypeOfChunk()
			end
		end
	end
	properties.ReturnTypeOfChunk = function()
		local randomZeroBit = math.random(0,100)
		if randomZeroBit >25 then
			if properties.type_of_chunk == 1 then
				return "G"--rass
			elseif properties.type_of_chunk == 2 then
				return "W"--ater
			end
		else
			return " "
		end
	end
	setmetatable(properties, SetChunksMT)
	return properties
end
--Draw The letters in the chunk[Does not create the chunk itself]
function Chunks:DrawLetterGeneration()

	
	for i,v in ipairs(ChunksCounter) do
		if ChunksCounter[i].type_of_chunk == 1 then --if grass
			love.graphics.setColor(0,100,0, 0.5)--Turns to Green
		elseif ChunksCounter[i].type_of_chunk == 2 then -- if water
			love.graphics.setColor(0,100,100, 0.5)--Turns to blue
		end
		for r=0,#ChunksCounter[i].LetterTable-1 do		
			for c=0,#ChunksCounter[i].LetterTable[i] - 1 do--Keep in mind this is equal to c=0,perChunks,10, so i have to *10 with c/r
				local newX = v.x + (c*10) * sizeMultiplier
				local newY = v.y + (r*10) * sizeMultiplier
				love.graphics.print(ChunksCounter[i].LetterTable[r+1][c+1].letter,newX,newY)-- { {{letter="A",x,y}}}
				ChunksCounter[i].LetterTable[r+1][c+1]["x"] = newX
				ChunksCounter[i].LetterTable[r+1][c+1]["y"] = newY
				
			end
			love.graphics.print("\n")
		end
	end	
	
end

--Create all the chunks [one by one]
function Chunks:Generate()
	
	countChunkPerHorizontalLine = GameWidth / perChunks
	countChunkPerVerticalLine = GameHeight / perChunks
	--Gives Chunks Its own properties

	--Where it will spawn 
	for r=0,#ChunksTable-1 do	
		for c=0,#ChunksTable[r+1]-1 do
			newChunk = BitChunks:New(ChunksTable[r+1][c+1])
			newChunk.x = perChunks * c
			newChunk.y = perChunks * r
			table.insert(ChunksCounter, newChunk)
		end
	end
end
	
--Return Table for all chunk properties
function Chunks:ChunksCounter()
return ChunksCounter
end

function Chunks:CounterChunksTable()
return ChunksTable
end
function Chunks:ChunksRecounter()
return ChunksRecounter
end
function Chunks:StartGeneration()
	ChunksCounter = {}
	ChunksLetters = {}
	--Generate Square Chunks ONCE
		Chunks:Generate()
	--XX
	--Load Letter Table For Each Chunks
	for i,v in ipairs(ChunksCounter) do
		ChunksCounter[i].GenerateLetters()
	end
	--XX

end
return Chunks