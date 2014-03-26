
local world
-- We cache the images, obviously
local sprites

local function makeEntity (x, y, sprite)
  local entity = {
    sprite = sprite,
    x = x,
    y = y
  }
  entity.ox = entity.sprite:getWidth()/2
  entity.oy = entity.sprite:getHeight()/2
  return entity
end

local function makeGoroba (x, y)
  local goroba = makeEntity(x, y, sprites.goroba)
  goroba.time = 5.0
  return goroba
end

local function makeWil (x, y)
  return makeEntity(x, y, sprites.wil)
end

function love.load ()
  world = {}
  world.gorobas = {}
  world.wils = {}
  sprites = {
    goroba  = love.graphics.newImage 'assets/sprites/hero_goroba_small.png',
    wil     = love.graphics.newImage 'assets/sprites/hero_wil_small.png'
  }
  for i=1,10 do
    local x = 800+100*love.math.random()
    local y = 100+500*love.math.random()
    table.insert(world.wils, makeWil(x, y))
  end
  love.graphics.setBackgroundColor(100, 100, 100, 255)
end

function love.mousepressed (x, y, button)
  table.insert(world.gorobas, makeGoroba(x, y))
end

function love.keypressed (button)
  if button == 'escape' then
    love.event.push 'quit'
  end
end

function love.update (dt)
  local to_be_removed = {}
  for i,goroba in ipairs(world.gorobas) do
    goroba.time = math.max(goroba.time - dt, 0)
    if goroba.time <= 0 then
      table.insert(to_be_removed, i)
    end
  end
  for _,i in ipairs(to_be_removed) do
    table.remove(world.gorobas, i)
  end
end

function love.draw ()
  for _,group in pairs(world) do
    for _,entity in ipairs(group) do
      love.graphics.draw(
        entity.sprite, entity.x, entity.y,
        0, 1, 1, -- rotation, horizontal scale, vertical scale
        entity.ox, entity.oy
      )
    end
  end
end
