
local goroba

function love.load ()
  goroba = {
    sprite = love.graphics.newImage 'assets/sprites/hero_goroba_small.png',
    x = 200,
    y = 200
  }
  goroba.ox = goroba.sprite:getWidth()/2
  goroba.oy = goroba.sprite:getHeight()/2
  love.graphics.setBackgroundColor(100, 100, 100, 255)
end

function love.mousepressed (x, y, button)
  goroba.x = x
  goroba.y = y
end

function love.draw ()
  love.graphics.draw(
    goroba.sprite, goroba.x, goroba.y,
    0, 1, 1, -- rotation, horizontal scale, vertical scale
    goroba.ox, goroba.oy
  )
end
