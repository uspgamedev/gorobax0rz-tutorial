
local gorobas
-- We cache the image, obviously
local goroba_sprite

local function makeGoroba (x, y)
  local goroba = {
    sprite = goroba_sprite,
    x = x,
    y = y,
    time = 5.0
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

function love.keypressed (button)
  if button == 'escape' then
    love.event.push 'quit'
  end
end

function love.update (dt)
  local to_be_removed = {}
  for i,goroba in ipairs(gorobas) do
    goroba.time = math.max(goroba.time - dt, 0)
    if goroba.time <= 0 then
      table.insert(to_be_removed, i)
    end
  end
  for _,i in ipairs(to_be_removed) do
    table.remove(gorobas, i)
  end
end

function love.draw ()
  for _,goroba in ipairs(gorobas) do
    love.graphics.draw(
      goroba.sprite, goroba.x, goroba.y,
      0, 1, 1, -- rotation, horizontal scale, vertical scale
      goroba.ox, goroba.oy
    )
  end
end
