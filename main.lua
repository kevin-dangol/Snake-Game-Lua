_G.love = require"love"

--_G.SFX = require"components/SFX"


function love.load()

    --background color
    love.graphics.setBackgroundColor(89/255, 125/255, 53/255)

    --tables
    _G.screen = {}
    _G.snake = {}
    _G.food = {}
    _G.letter = {}
    _G.images = {}
    _G.score = 0


    --images
    images.food = love.graphics.newImage("images/apple.png")
    images.background = love.graphics.newImage("images/background.png")

    --key
    letter.pressed = "w"

    --screen
    screen.minX = 0
    screen.minY = 0
    screen.maxX = 1200
    screen.maxY = 700

    --snake
    snake.headX = 100
    snake.headY = 450
    snake.directionX = 100
    snake.directionY = 450
    snake.speed = 0.5

    --food
    food.x = math.random(40, 1200-40)
    food.y = math.random(100, 700-40)
    food.eaten = false

    --fonts
    font = love.graphics.newFont(35)

end

function love.keypressed(key, scancode, isrepeat)

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
    end
    if letter.pressed == "a" then
        snake.directionX = snake.headX - snake.speed
    end
    if letter.pressed == "s" then
        snake.directionY = snake.headY + snake.speed
    end
    if letter.pressed == "d" then
        snake.directionX = snake.headX + snake.speed
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
        --SFX:playFX("eat", "single")

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

        --SFX:playFX("death", "single")
        love.event.quit()

    end

end

function love.draw()

    --score
    love.graphics.setColor(0/255, 0/255, 0/255)
    love.graphics.setFont( font )
    love.graphics.printf(score, 0, 0, 60)

    --background
    --love.graphics.draw(images.background)

    --food
    if not food.eaten then

        love.graphics.setColor(66/255, 17/255, 30/255)
        love.graphics.circle("fill", food.x, food.y, 15)
        --love.graphics.draw(images.food)

    end

    --snake
    love.graphics.setColor(71/255, 55/255, 82/255)
    love.graphics.circle("fill", snake.headX, snake.headY, 25)

end