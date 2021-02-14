local score = 0
local image  
local distance 
local bodyCount = 1
local lolipopX = 100
local lolipopY = 100
local randomGenerator
local speed = 60
local gameover = 0

local turns = {}
local directions = {}
local direction = {}

local turnIndex = 1

function love.load() 
 randomGenerator = love.math.newRandomGenerator()
image = love.graphics.newImage("lollipop20.png")
print (image)
direction = {dirX = 0, dirY = 1, circleX = 200, circleY = 100}
directions[1] = direction 
end

function love.draw()
    for i = 1, bodyCount, 1 do 
        print (directions[i].dirX, directions[i].dirY, directions[i].circleX, directions[i].circleY )
    end     
    local position = 1
    local tempcount = bodyCount
    if gameover == 1 then
        love.graphics.setColor( 255, 255, 255)
        love.graphics.print("Score: " .. score, 20, 425, 0, 2, 2)
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("GameOver", 50, 100, 0, 8, 8)
        love.graphics.setColor(255, 300, 0)
        love.graphics.rectangle("line", 5, 5, 590, 390)
    else
        love.graphics.setColor( 255, 255, 255)
        love.graphics.print("Score: " .. score, 20, 425, 0, 2, 2)
        love.graphics.setColor(255, 300, 0)
        love.graphics.rectangle("line", 5, 5, 590, 390)
        love.graphics.circle("fill",directions[1].circleX,directions[1].circleY, 20)
        love.graphics.setColor(20, 20, 20)    
        love.graphics.draw(image, lolipopX, lolipopY)
        while tempcount > 1 do 
            if directions[1].dirX == 1 then
                love.graphics.circle("fill", directions[1].circleX - 30 - 25 *(position - 1), directions[1].circleY, 15)
            elseif directions[1].dirX == -1 then
                love.graphics.circle("fill", directions[1].circleX + 30 + 25 *(position - 1), directions[1].circleY, 15)
             elseif directions[1].dirY == 1 then
                love.graphics.circle("fill", directions[1].circleX , directions[1].circleY - 30 - 25 *(position - 1), 15)
            elseif directions[1].dirY == -1 then
                love.graphics.circle("fill", directions[1].circleX , directions[1].circleY + 30 + 25 *(position - 1), 15)
            end
            position = position + 1
            tempcount = tempcount - 1
        end
    end

end

function love.keypressed(key, scancode, isrepeat) 
    local turn = {}
    if key == "right" then 
        directions[1].dirX = 1
        directions[1].dirY = 0
            turn = { 
            posX = 1,
            posY = 0,
            cirX = directions[1].circleX,
            cirY = directions[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    elseif key == "left" then
        directions[1].dirX = -1
        directions[1].dirY = 0
        turn = { 
            posX = -1,
            posY = 0,
            cirX = directions[1].circleX,
            cirY = directions[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    elseif key == "down" then 
        directions[1].dirX = 0
        directions[1].dirY = 1
        turn = { 
            posX = 0,
            posY = 1,
            cirX = directions[1].circleX,
            cirY = directions[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    elseif key == "up" then
        directions[1].dirX = 0
        directions[1].dirY = -1
        turn = { 
            posX = 0,
            posY = -1,
            cirX = directions[1].circleX,
            cirY = directions[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    end
end

 function love.update(dt)
    if directions[1].circleX < 575 and directions[1].dirX == 1 then
        directions[1].circleX = directions[1].circleX + speed * dt
   elseif directions[1].circleX > 575 and directions[1].dirX == 1 then
    directions[1].circleX = directions[1].circleX - speed * dt
       gameover = 1
   elseif directions[1].circleX > 25 and directions[1].dirX == -1 then
    directions[1].circleX = directions[1].circleX - speed * dt
   elseif directions[1].circleX < 25 and directions[1].dirX == -1 then 
        directions[1].circleX = directions[1].circleX + speed * dt
       gameover = 1
   end 
   if directions[1].circleY < 375 and directions[1].dirY == 1 then
        directions[1].circleY = directions[1].circleY + speed * dt
    elseif directions[1].circleY > 375 and directions[1].dirY == 1 then
        directions[1].circleY = directions[1].circleY - speed * dt
        gameover = 1
    elseif directions[1].circleY > 25 and directions[1].dirY == -1 then
        directions[1].circleY = directions[1].circleY - speed * dt
    elseif directions[1].circleY < 25 and directions[1].dirY == -1 then 
        directions[1].circleY = directions[1].circleY + speed * dt
        gameover = 1
    end
    
    distance = ((directions[1].circleX - lolipopX)^2 + (directions[1].circleY - lolipopY)^2)^0.5
    if distance < 30  then 
        score = score + 10 
        bodyCount = bodyCount + 1
        directions[bodyCount] = directions[bodyCount - 1]
        lolipopX = randomGenerator:random(25, 575)
        lolipopY = randomGenerator:random(25, 375)
        speed = speed + 10

    end
end 
 



