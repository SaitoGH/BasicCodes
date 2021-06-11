function love.load()
--Font
newFont = love.graphics.newFont('FastHand-lgBMV.ttf', 20)
love.graphics.setFont(newFont)
--Player 1 Character
player_1 = {}
player_1.score = 0
player_1.speed = 250
player_1.x = 10
player_1.y = 240
player_1.h = 100
player_1.w = 10
--Player 2 Character
player_2 = {}
player_2.score = 0
player_2.speed = 250
player_2.x = 460
player_2.y = 240
player_2.h = 100
player_2.w = 10

--Ball Properties
ball = {}
ball.x_vel = 200
ball.y_vel = 200
ball.x = 240
ball.y = 240
ball.w = 5
ball.h = 5
--NewRound
newRound = false
end

function gameReset()

ball.x_vel = numberRandomizer()
ball.y_vel = numberRandomizer()
ball.x = 240
ball.y = 240
ball.w = 5
ball.h = 5
newRound = false

end
--Too lazy to think :P
--[[ 
  To simplify, 
  1)if Player 1  X is less than Ball X + Ball Width 
  2) if Ball X is less than Player 1 X + Player 1 Width
  3)if Player 1  Y is less than Ball Y + Ball Height 
  4)if Ball Y is less than Player 1 Y + Player 1 Height
  Pretty Simple if you imagine it visually
]]
function numberRandomizer()
value_pos = math.random(100, 300)
value_neg = math.random(-100, -300)
if (math.random(1,2) == 1) then
  return value_pos
else 
  return value_neg
end

end
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
function love.update(dt)

--Player Controls
if love.keyboard.isDown('w') and  player_1.y > 0 then
  player_1.y = player_1.y - player_1.speed * dt
elseif love.keyboard.isDown('s') and  player_1.y < love.graphics.getHeight() - player_1.h  then
   player_1.y = player_1.y + player_1.speed * dt
end

if love.keyboard.isDown('up') and  player_2.y > 0 then
  player_2.y = player_2.y - player_2.speed * dt
elseif love.keyboard.isDown('down') and  player_2.y < love.graphics.getHeight() - player_2.h  then
   player_2.y = player_2.y + player_2.speed * dt
end

--Ball Wall Bounce
if (ball.x + ball.w) > love.graphics.getWidth()  then
    player_1.score = player_1.score + 1
    newRound = true
elseif ball.x < 0 then
   player_2.score = player_2.score + 1
    newRound = true
elseif ball.y < 0 then
    ball.y_vel = math.abs(ball.y_vel)
elseif (ball.y + ball.h) > love.graphics.getHeight() then
    ball.y_vel = -math.abs(ball.y_vel)
end


--Ball Player Bounce
if CheckCollision(player_1.x, player_1.y, player_1.w, player_1.h, ball.x, ball.y, ball.w, ball.h) then
 ball.x_vel = math.abs(ball.x_vel)
elseif  CheckCollision(player_2.x, player_2.y, player_2.w, player_2.h, ball.x, ball.y, ball.w, ball.h) then
  ball.x_vel = -math.abs(ball.x_vel)
end
--Ball Move
ball.x = ball.x + (ball.x_vel)* dt
ball.y = ball.y + (ball.y_vel)* dt

--Check New Round 
if newRound then
  ball.x = 240
  ball.y = 240
  ball.y_vel = 0
  ball.x_vel = 0
  if (love.keyboard.isDown('space')) then
    gameReset()
  end
end

end



function love.draw()


love.graphics.setBackgroundColor(37/255,80/255,122/255)
love.graphics.rectangle('fill', ball.x, ball.y, ball.w, ball.h)
love.graphics.rectangle('line', player_1.x, player_1.y, player_1.w, player_1.h)
love.graphics.rectangle('line', player_2.x, player_2.y, player_2.w, player_2.h)

--Scores
love.graphics.print(player_1.score, 215, 10 )
love.graphics.print(player_2.score, 250, 10 )

--Continue Game 
if (newRound) then
  love.graphics.setColor(255, 255, 255)
  love.graphics.print('Press Space To Continue!', 100, 220)
end


counter = 40
for i=1, 10 do
love.graphics.setColor(255, 255, 255, 0.5)
love.graphics.rectangle('fill', 230, counter, 20,20 )


counter = counter + 40
end


end