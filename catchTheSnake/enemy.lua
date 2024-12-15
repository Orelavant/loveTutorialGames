local Rectangle = require "rectangle"

---@class Enemy:Rectangle
local Enemy = Rectangle:extend()
local goRight = true
local x = 5 
local y = 5
local image = love.graphics.newImage("snake.png")
local speed = 200

--- Construct a new rectangle
function Enemy:new()
    Enemy.super.new(self, x, y, image, speed)
end

--- Automatically update position of Rectangle
---@param dt number
function Enemy:update(dt)
    local leftEdge = self.x
    local rightEdge = self.x + self.width

    -- Check if screenEdge was hit
    if rightEdge >= self.screenWidth then
        goRight = false
    elseif leftEdge <= 0 then
        goRight = true
    end

    -- Update
    if goRight then
        self.x = self.x + self.speed * dt
    else
        self.x = self.x - self.speed * dt
    end
end

--- Increase the speed of self by speedModifer
---@param speedModifier integer
function Enemy:incrementSpeed(speedModifier)
    self.speed = self.speed + speedModifier
end

return Enemy