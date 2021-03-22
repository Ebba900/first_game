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
local player = {}
local direction = {}

local turnIndex = 1

function love.load() 
    randomGenerator = love.math.newRandomGenerator()
    image = love.graphics.newImage("lollipop20.png")
    print (image)
    direction = {dirX = 0, dirY = 1, circleX = 200, circleY = 100}
    player[1] = direction 
end

function love.draw()
    for i = 1, bodyCount, 1 do 
        print (player[i].dirX, player[i].dirY, player[i].circleX, player[i].circleY )
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
        love.graphics.circle("fill",player[1].circleX,player[1].circleY, 20)
        love.graphics.setColor(20, 20, 20)    
        love.graphics.draw(image, lolipopX, lolipopY)

        -- draw new circle snake
        while tempcount > 1 do 
            if player[1].dirX == 1 then
                love.graphics.circle("fill", player[1].circleX - 30 - 25 *(position - 1), player[1].circleY, 15)
            elseif player[1].dirX == -1 then
                love.graphics.circle("fill", player[1].circleX + 30 + 25 *(position - 1), player[1].circleY, 15)
             elseif player[1].dirY == 1 then
                love.graphics.circle("fill", player[1].circleX , player[1].circleY - 30 - 25 *(position - 1), 15)
            elseif player[1].dirY == -1 then
                love.graphics.circle("fill", player[1].circleX , player[1].circleY + 30 + 25 *(position - 1), 15)
            end
            position = position + 1
            tempcount = tempcount - 1
        end
    end

end

function drawSnake()
    testSnake = {
        {
            x = 20, y = 30
        },
        {
            x = 60, y = 30
        },
        {
            x = 30, y = 30
        },
        {
            x = 50, y = 30
        }  
    }
    
end

function love.keypressed(key, scancode, isrepeat) 
    local turn = {}
    if key == "right" then 
        player[1].dirX = 1
        player[1].dirY = 0
            turn = { 
            posX = 1,
            posY = 0,
            cirX = player[1].circleX,
            cirY = player[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    elseif key == "left" then
        player[1].dirX = -1
        player[1].dirY = 0
        turn = { 
            posX = -1,
            posY = 0,
            cirX = player[1].circleX,
            cirY = player[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    elseif key == "down" then 
        player[1].dirX = 0
        player[1].dirY = 1
        turn = { 
            posX = 0,
            posY = 1,
            cirX = player[1].circleX,
            cirY = player[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    elseif key == "up" then
        player[1].dirX = 0
        player[1].dirY = -1
        turn = { 
            posX = 0,
            posY = -1,
            cirX = player[1].circleX,
            cirY = player[1].circleY,
            pos1 = 1}
        turns[turnIndex] = turn
        print (turns[turnIndex].posX, turns[turnIndex].posY)
        turnIndex = turnIndex + 1
    end
end

 function love.update(dt)
    if player[1].circleX < 575 and player[1].dirX == 1 then
        player[1].circleX = player[1].circleX + speed * dt
   elseif player[1].circleX > 575 and player[1].dirX == 1 then
    player[1].circleX = player[1].circleX - speed * dt
       gameover = 1
   elseif player[1].circleX > 25 and player[1].dirX == -1 then
    player[1].circleX = player[1].circleX - speed * dt
   elseif player[1].circleX < 25 and player[1].dirX == -1 then 
        player[1].circleX = player[1].circleX + speed * dt
       gameover = 1
   end 
   if player[1].circleY < 375 and player[1].dirY == 1 then
        player[1].circleY = player[1].circleY + speed * dt
    elseif player[1].circleY > 375 and player[1].dirY == 1 then
        player[1].circleY = player[1].circleY - speed * dt
        gameover = 1
    elseif player[1].circleY > 25 and player[1].dirY == -1 then
        player[1].circleY = player[1].circleY - speed * dt
    elseif player[1].circleY < 25 and player[1].dirY == -1 then 
        player[1].circleY = player[1].circleY + speed * dt
        gameover = 1
    end
    
    distance = ((player[1].circleX - lolipopX)^2 + (player[1].circleY - lolipopY)^2)^0.5
    if distance < 30  then 
        score = score + 10 
        bodyCount = bodyCount + 1
        player[bodyCount] = player[bodyCount - 1]
        lolipopX = randomGenerator:random(25, 575)
        lolipopY = randomGenerator:random(25, 375)
        speed = speed + 10

    end
end 
 



