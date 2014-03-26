
local goroba

function love.load ()
  goroba = {
    sprite = love.graphics.newImage 'assets/sprites/hero_goroba_small.png',
    x = 200,
    y = 200
  }
  love.graphics.setBackgroundColor(100, 100, 100, 255)
end

function love.mousepressed (x, y, button)
  goroba.x = x
  goroba.y = y
end

function love.draw ()
  love.graphics.draw(goroba.sprite, goroba.x, goroba.y)
end
