
local goroba
local goroba_x, goroba_y

function love.load ()
  goroba = love.graphics.newImage 'assets/sprites/hero_goroba_small.png'
  goroba_x, goroba_y = 200, 200
  love.graphics.setBackgroundColor(100, 100, 100, 255)
end

function love.mousepressed (x, y, button)
  goroba_x = x
  goroba_y = y
end

function love.draw ()
  love.graphics.draw(goroba, goroba_x, goroba_y)
end
