
math.randomseed(os.time())
local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
--Space Generation
updateGen = true
space = {}
currentGen=1

--Space Functions

math.randomseed(os.time())
local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
--Space Generation
updateGen = true
space = {}
currentGen=1

--Space Functions
function checkType(t)
  if t == 1 then
    io.write(' ' .. ' ')
  elseif t == 2 then
     io.write('*'.. ' ')
  end
end

function checkLives(gen)

for i=1, 10 do
	for j=1, 10 do
		if gen > space[i][j].l then
        space[i][j].t = 1
    end
	end
end

end

-- l= lives, t=type(1 is void, 2 is sun)
-- give values to a star 
for i=1, 10 do
	table.insert(space,  {})
	for j=1, 10 do
		table.insert(space[i], {l=math.random(1,100), t=math.random(1,2)})
	end
end


--Print Space
repeat  
  
  for i=1, #space do	
      io.write('\n')
      for j=1, #space[i] do
            checkType(space[i][j].t)
      end
  end

  print(' \nCurrent Gen: ' .. currentGen )
  sleep(0.1)
  os.execute("cls")
  currentGen = currentGen + 1
  checkLives(currentGen)
  
until(updateGen == false)


