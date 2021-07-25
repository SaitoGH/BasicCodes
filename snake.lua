math.randomseed(os.time())

screen_width = 30
screen_height = 30
snake_x,snake_y = screen_width/2, screen_height/2
snake_dir = 'u'
food_x, food_y = math.random(0, screen_width), math.random(0, screen_height)
isRunning = true
foodEaten = 10
snakeSegmentX = {}
snakeSegmentY = {}
function Main()

while isRunning do
    os.execute("cls")
    Load()
    Update()
    Draw()
end

end

function Load()


end

function Update()
    snakeXPrev = snake_x
    snakeYPrev = snake_y
    table.insert(snakeSegmentX, snakeXPrev)
    table.insert(snakeSegmentY, snakeYPrev)
    newSegX, newSegY = 0, 0
    for i=1,foodEaten do
        newSegX = snakeSegmentX[i+1]
        newSegY = snakeSegmentY[i+1]
        snakeSegmentX[i+1] = snakeXPrev
        snakeSegmentY[i+1] = snakeYPrev
        snakeXPrev = newSegX
        snakeYPrev = newSegY

    end
    if (snake_dir=="u") then
        snake_y = snake_y - 1
    elseif (snake_dir=="d") then
        snake_y = snake_y + 1
    elseif (snake_dir=="l") then
        snake_x = snake_x - 1
    elseif (snake_dir=="r") then
        snake_x = snake_x + 1
    end

end

function Draw()

   
for r=0,screen_width do
  io.write("#")
end

for r=0,screen_height do
    io.write("\n")
  for c=0,screen_width do
        if c == 0 or c == screen_width then
            io.write("#")
             
        elseif (c==snake_x and r== snake_y) then
            io.write("0")       
        elseif (c==food_x and r==food_y) then
            io.write("P")
        else
            io.write(" ")                  
        end          
        
        for i=1,foodEaten do
            if (c==snakeSegmentX[k] and r==snakeSegmentY[k]) then
                io.write("o")
            end
        end
        
  end
end
    io.write("\n")
    for r=0,screen_width do
        io.write("#")
    end
end

Main()