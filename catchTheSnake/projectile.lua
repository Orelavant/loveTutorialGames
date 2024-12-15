local Rectangle = require "rectangle"

---@class Projectile:Rectangle
local Projectile = Rectangle:extend()
local speed = 600

--- Construct a new rectangle
--- @param x number
--- @param y number
function Projectile:new(x, y, image)
    Projectile.super.new(self, x, y, image, speed)
end

--- Update position of projectile
---@param dt number
function Projectile:update(dt)
    self.y = self.y - self.speed * dt
end

--- Check for collision between self and another object
---@param obj Rectangle
---@return boolean
function Projectile:didCollide(obj)
    local top = self.y
    local bottom = self.y + self.height
    local left = self.x
    local right = self.x + self.width

    local objTop = obj.y
    local objBottom = obj.y + obj.height
    local objLeft  = obj.x
    local objRight = obj.x + obj.width

    return
    (top <= objBottom and top >= objTop or bottom >= objTop and bottom <= objBottom)
    and
    (left <= objRight and left >= objLeft or right >= objLeft and right <= objRight)
end

function Projectile:wentOffScreen()
    if self.y <= 0 then
        return true
    end
end

return Projectile