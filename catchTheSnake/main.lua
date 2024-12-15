-- debugger
if arg[2] == "debug" then
    require("lldebugger").start()
end




-- declare local vars
local listOfCharacters ---@type (Player | Enemy)[]
local screenWidth = love.graphics.getWidth()
local player --- @type Player
local enemy --- @type Enemy
local score  --- @type integer
local enemyHitSpeedModifier = 50

function love.load()
    -- init classes
    local Player = require "player"
    local Enemy = require "enemy"

    -- init local objs
    player = Player()
    enemy = Enemy()

    -- init vars
    listOfCharacters = {player, enemy}
    score = 0

    -- init globals
    ListOfBullets = {} ---@type Projectile[]
end

function love.update(dt)
    -- Update characters positions
    for _,character in ipairs(listOfCharacters) do
        character:update(dt)
    end

    -- Update bullet positions, check for collision with enemy or top of screen
    for i,bullet in ipairs(ListOfBullets) do
        bullet:update(dt)

        if bullet:didCollide(enemy) then
            table.remove(ListOfBullets, i)
            enemy:incrementSpeed(enemyHitSpeedModifier)
            score = score + 1
        end

        if bullet:wentOffScreen() then
            love.load()
        end
    end
end

function love.draw()
    -- Update projectile
    for _,v in ipairs(ListOfBullets) do
        v:draw()
    end

    -- Update enemy and player
    for _,character in ipairs(listOfCharacters) do
        character:draw()
    end

    love.graphics.print(score, screenWidth-20, 0, 0, 2, 2)
end

function love.keypressed(key)
    player:keyPress(key)
end



-- make error handling nice
local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end
