
number_of_lines =5
for r=1,number_of_lines do
    for j=number_of_lines,r,-1 do  
    io.write(' ')  
    end
  for c=1,r do

    io.write(' ')
    io.write('*')
    if (c==r) then
      print('\n')      
    end
    
  end
end
