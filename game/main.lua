
local goroba

function love.load ()
  goroba = love.graphics.newImage 'assets/sprites/hero_goroba_small.png'
  love.graphics.setBackgroundColor(100, 100, 100, 255)
end

function love.draw ()
  love.graphics.draw(goroba, 200, 200)
end
