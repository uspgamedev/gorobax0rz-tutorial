
require 'common'
require 'entities'

function love.load ()
  loadEntities()
  -- global variables
  world = {}
  world.gorobas = {}
  world.wils = {}
  world.lasers = {}
  money = 10
  -- We cache the media, obviously
  sprites = {
    goroba  = love.graphics.newImage 'assets/sprites/hero_goroba_small.png',
    wil     = love.graphics.newImage 'assets/sprites/hero_wil_small.png'
  }
  sounds = {
    laser = love.audio.newSource('assets/sounds/laser.ogg', 'static')
  }
  love.graphics.setBackgroundColor(100, 100, 100, 255)
  -- Screen values
  W = love.window.getWidth()
  H = love.window.getHeight()
end

function love.mousepressed (x, y, button)
  if money > 2 then
    table.insert(world.gorobas, makeGoroba(x, y))
    money = money - 2
  end
end

function love.keypressed (button)
  if button == 'escape' then
    love.event.push 'quit'
  end
end

function love.update (dt)
  if love.keyboard.isDown 'tab' then
    dt = dt*3
  end
  local to_be_removed = {}
  updateGorobas(to_be_removed, dt)
  updateWils(to_be_removed, dt)
  updateLasers(to_be_removed, dt)
  for _,removal in ipairs(to_be_removed) do
    table.remove(world[removal.group], removal.index)
  end
end

function love.draw ()
  for _,group in pairs(world) do
    for _,entity in ipairs(group) do
      entity:draw() -- same as entity.draw(entity)
    end
  end
  love.graphics.print(tostring(money), 0, 0)
end
