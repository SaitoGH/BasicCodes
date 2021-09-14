
local chunks = require 'chunks'
local mouseFunc = require'mousefunc'
local player = require'player'
local rooms = require'rooms'
mainFont = love.graphics.newFont("Pixeboy.ttf", 20)



function love.load()
	
	chunks:load()
	rooms:load()
	player:load()
end

function love.update(dt)
	chunks:update(dt)
	mouseFunc:update(dt)
	player:update(dt)
	rooms:Generate(dt)
	rooms:update(dt)
	
end

function love.draw()
	chunks:draw()
	player:draw()
	rooms:draw()
	love.graphics.setFont(mainFont)

end

