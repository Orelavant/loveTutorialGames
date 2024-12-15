local Rectangle = require "rectangle"
local Projectile = require "projectile"

---@class Player:Rectangle
local Player = Rectangle:extend()
local x = -1
local y = -1
local image = love.graphics.newImage("panda.png")
local playerCenter = image:getWidth() / 2
local yOffset = 110
local speed = 400

local bulletImage = love.graphics.newImage("bullet.png")
local bulletWidthCenter = bulletImage:getWidth() / 2
local bulletYOffset = 25

--- Construct a new rectangle
function Player:new()
    Player.super.new(self, x, y, image, speed)
    self.y = self.screenHeight-yOffset
    self.x = self.screenWidth / 2 - playerCenter
end

--- Update position of Rectangle by the x and y speeds if player is inputting
---@param dt number
function Player:update(dt)
    local rightEdge = self.x + self.width

    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    end

    if rightEdge > self.screenWidth then
       self.x = self.screenWidth - self.width
    elseif self.x < 0 then
        self.x = 0
    end
end

function Player:keyPress(key)
    if key == "space" then
        -- Get center of player, and subtract half of the bullet's width
        local bulletX = self.x + playerCenter - bulletWidthCenter
        local bulletY = self.y - bulletYOffset

        table.insert(ListOfBullets, Projectile(bulletX, bulletY, bulletImage))
    end
end

return Player