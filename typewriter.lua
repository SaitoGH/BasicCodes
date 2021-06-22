local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

--String goes here
str = "awdinhawjdawk"

for i=1,#str do
    local c_s = str:sub(i,i) -- what str:sub does is ex: str:sub(2,2) = w,
    io.write(c_s)
    sleep(0.5)
  end
  
--tbh this easy af
