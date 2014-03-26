
local gorobas
-- We cache the image, obviously
local goroba_sprite

local function makeGoroba (x, y)
  local goroba = {
    sprite = goroba_sprite,
    x = x,
    y = y
  }
  goroba.ox = goroba.sprite:getWidth()/2
  goroba.oy = goroba.sprite:getHeight()/2
  return goroba
end

function love.load ()
  gorobas = {}
  goroba_sprite = love.graphics.newImage 'assets/sprites/hero_goroba_small.png'
  love.graphics.setBackgroundColor(100, 100, 100, 255)
end

function love.mousepressed (x, y, button)
  table.insert(gorobas, makeGoroba(x, y))
end

function love.draw ()
  for i,goroba in ipairs(gorobas) do
    love.graphics.draw(
      goroba.sprite, goroba.x, goroba.y,
      0, 1, 1, -- rotation, horizontal scale, vertical scale
      goroba.ox, goroba.oy
    )
  end
end
