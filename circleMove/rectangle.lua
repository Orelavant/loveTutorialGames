local Point = require "point"

---@class Rectangle:Point
local Rectangle = Point:extend()
local goRight = true

--- Construct a new rectangle
--- @param x number
--- @param y number
--- @param image love.Image
--- @param speed number
function Rectangle:new(x, y, image, speed)
    Rectangle.super.new(self, x, y, speed)
    self.image = image
    self.width = image:getWidth()
    self.height = image:getHeight()
end

--- Draw rectangle
function Rectangle:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Rectangle