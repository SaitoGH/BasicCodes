
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
StarsDied = 0




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
  
    deathGenDate = space[i][j].GenerationBorned + space[i][j].l
		if  gen >= deathGenDate then
        space[i][j].t = 1
        space[i][j].hasDied = true      
    end
	end
end

end

function dwarfStar()

for i=1, 10 do
	for j=1, 10 do
        if space[i][j].hasDied == true then
            starChanceOfSurviving = 0.1
            starChance = math.random(0.01, 200)
            if (starChance < starChanceOfSurviving) then
                 space[i][j].t =2
                 space[i][j].l = math.random(1, 100)
                 space[i][j].GenerationBorned = currentGen
                 space[i][j].hasDied = false   
            end
        end
    end
	end
end

-- l= lives, t=type(1 is void, 2 is sun)
-- give values to a star 
for i=1, 10 do
	table.insert(space,  {})
	for j=1, 10 do
		table.insert(space[i], {l=math.random(1,10), t=math.random(1,2), hasDied=false, GenerationBorned= 0})
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

  print(' \nCurrent Gen: ' .. currentGen)
  sleep(0.05)
  os.execute("clear")
  currentGen = currentGen + 1
  checkLives(currentGen)
  dwarfStar()
until(updateGen == false)



