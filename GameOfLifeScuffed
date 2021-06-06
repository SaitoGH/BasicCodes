grid = {{'', '', '', '', '', '', '','' ,'', '', '', '', '', '',''}, 
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'',0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,''},
        {'', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,'',},
        {'', '', '', '', '', '', '','', '', '', '', '', '', '',''}}
--REMINDER THAT 0 IS DEAD CELL AND 1 IS ALIVE AAAAAAAAAA
update = true
local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
--functions 
function checkfornumbers()
--a dead cell update blablablablal
for i=1,#grid do
  for j=1,#grid[i] do
   if grid[i][j] == 0 then

     AliveCellCounter = 0

     --hard part, detect all 3x3 position if its alive or dead

     -- this part is for when theres 3 cells near dead cell
    if grid[i+1][j] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i-1][j] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i][j+1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i][j-1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i+1][j+1] == 1 then
       AliveCellCounter = AliveCellCounter + 1
     end
      if grid[i-1][j+1] == 1 then
       AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i+1][j-1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i-1][j-1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
    
      
     if AliveCellCounter == 3 then
        grid[i][j] = 1
     elseif  AliveCellCounter < 3 then
        grid[i][j] = 0
    elseif  AliveCellCounter > 3 then
        grid[i][j] = 0
     end

   end
  end
end

--Live Cells update
for i=1,#grid do
  for j=1,#grid[i] do
   if grid[i][j] == 1 then
     AliveCellCounter = 0
    if grid[i+1][j] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i-1][j] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i][j+1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i][j-1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i+1][j+1] == 1 then
       AliveCellCounter = AliveCellCounter + 1
     end
      if grid[i-1][j+1] == 1 then
       AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i+1][j-1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
     if grid[i-1][j-1] == 1 then
      AliveCellCounter = AliveCellCounter + 1
     end
    
    --a live cell with zero or one live neighbours will die.
     if AliveCellCounter < 2 then
        grid[i][j] = 0
     end
     if  AliveCellCounter >= 4 then
        grid[i][j] = 0
     end
     if  AliveCellCounter == 2 or AliveCellCounter == 3  then
        grid[i][j] = 1
     end

   end
  end
end

end


repeat
 
  for i=1,#grid do
    io.write('\n' .. '\n')
    for j=1,#grid[i] do
   
      io.write(grid[i][j] .. ' ')
    end

  end
   checkfornumbers() 
   sleep(0.6)
  os.execute("clear")
  
until(update == false)
