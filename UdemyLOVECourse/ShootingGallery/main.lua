-- common pattern 
-- load
-- update 
-- draw 

function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 10
    gameState = 1

    gameFont = love.graphics.newFont(40)
    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

    love.mouse.setVisible(false)
end


-- dt => delta time
-- amount of time since last frame 
function love.update(dt)
    if gameState == 2 then
        if timer > 0 then
            timer = timer - dt
        end
        if timer < 0 then  
            timer = 0
            gameState = 1
            score = 0   
        end
    end
end


function love.draw()

    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print('score: ' .. score, 0, 0)
    love.graphics.print('time: ' .. math.ceil(timer), 300, 0)

    if gameState == 1 then
        love.graphics.printf('Click anywhere to begin!', 0, 250, love.graphics.getWidth(), 'center' )
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
        love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
end


function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1 
            target.x = math.random(target.radius, love.graphics.getWidth())
            target.y = math.random(target.radius, love.graphics.getHeight())
        end
    

    elseif button == 1 and gameState == 1 then 
        gameState = 2
    end

end


function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end