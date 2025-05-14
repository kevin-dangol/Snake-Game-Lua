_G.love = require"love"

SFX = require"components/SFX"

function sleep (a)
    local sec = tonumber(os.clock() + a);
    while (os.clock() < sec) do
    end
end

function love.load()

    --background color
    --love.graphics.setBackgroundColor(89/255, 125/255, 53/255)

    --tables
    _G.screen = {}
    _G.snake = {}
    _G.food = {}
    _G.letter = {}
    _G.images = {}
    _G.score = 0
    _G.sfx = SFX()


    --images
    images.snake = love.graphics.newImage("images/snake.png")
    images.food = love.graphics.newImage("images/apple.png")
    images.background = love.graphics.newImage("images/background.png")

    --key
    letter.pressed = ""

    --screen
    screen.minX = 0
    screen.minY = 0
    screen.maxX = 1200
    screen.maxY = 700

    --snake
    snake.headX = 600
    snake.headY = 450
    snake.directionX = 600
    snake.directionY = 350
    snake.bodyX = 550
    snake.bodyY = 350
    snake.speed = 0.5

    --food
    food.x = math.random(100, 1200-40)
    food.y = math.random(40, 700-40)
    food.eaten = false

    --fonts
    font = love.graphics.newFont(30)

end

function love.keypressed(key)

    --snake movement
    if key == "w" then

        letter.pressed = "w"

    end

    if key == "a" then

        letter.pressed = "a"

    end

    if key == "s" then

        letter.pressed = "s"

    end

    if key == "d" then

        letter.pressed = "d"

    end

    if key == "escape" then

        letter.pressed = "esc"
        love.event.quit()

    end

end

function love.update(_dt)

    --direction change
    if letter.pressed == "w" or "s" then
        snake.headY = snake.directionY
    end
    if letter.pressed == "a" or "d" then
        snake.headX = snake.directionX
    end

    --snake movement
    if letter.pressed == "w" then
        snake.directionY = snake.headY - snake.speed
        snake.rotate = 3.15
    end
    if letter.pressed == "a" then
        snake.directionX = snake.headX - snake.speed
        snake.rotate = 1.6
    end
    if letter.pressed == "s" then
        snake.directionY = snake.headY + snake.speed
        snake.rotate = 0
    end
    if letter.pressed == "d" then
        snake.directionX = snake.headX + snake.speed
        snake.rotate = 4.7
    end


    --eat condition
    if (snake.headX <= food.x + 20 and snake.headX >= food.x - 20) and (snake.headY <= food.y + 20 and snake.headY >= food.y - 20)  then

        --remove the food
        food.eaten = true

        --respawn food
        food.respawn = true

        --increase the score and speed
        score = score + 1
        snake.speed = snake.speed + 0.05

        --play sound
        sfx:playFX("eat")


    end

    --respawn
    if food.respawn then

        --randomize location
        food.x = math.random(40, 1200-40)
        food.y = math.random(40, 700-40)

        --place the food
        food.eaten = false
        food.respawn = false

    end


    --death condition
    if snake.headX >= screen.maxX+1 or snake.headY >= screen.maxY+1 or snake.headX <= screen.minX-1 or snake.headY <= screen.minY-1 then

        --quit the game
        sfx:playFX("death", "single")
        sfx:stopFX("bgs")
        sleep(4)
        love.event.quit()

    --elseif snake.headX == snake.bodyX+25 or snake.headY == snake.bodyY+25 then
    --
    --        --quit the game
    --        sfx:playFX("death", "single")
    --        love.event.quit()

    end

end

function love.draw()

    --background
    love.graphics.draw(images.background)

    --score
    love.graphics.setFont( font )
    love.graphics.printf("Score: "..score, 0, 0, 150)

    --food
    if not food.eaten then

        love.graphics.push()
        local scale = 0.08
        love.graphics.draw(images.food, food.x, food.y, 0, scale, scale, images.food:getWidth()/2, images.food:getHeight()/2)
        love.graphics.pop()

    end

    --snake
    local scale = 0.15
    --love.graphics.circle("fill", snake.bodyX, snake.bodyY, 25)
    love.graphics.draw(images.snake, snake.headX, snake.headY, snake.rotate, scale, scale, images.snake:getWidth()/2, images.snake:getHeight()/2)

end