
local world
-- Wil spawn time
local delay
-- We cache the images, obviously
local sprites
-- Screen values
local W, H

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

local function expRand (lambda)
  return math.log(love.math.random())/(-lambda)
end

function love.load ()
  world = {}
  world.gorobas = {}
  world.wils = {}
  delay = 1+expRand(0.5)
  sprites = {
    goroba  = love.graphics.newImage 'assets/sprites/hero_goroba_small.png',
    wil     = love.graphics.newImage 'assets/sprites/hero_wil_small.png'
  }
  love.graphics.setBackgroundColor(100, 100, 100, 255)
  W = love.window.getWidth()
  H = love.window.getHeight()
end

function love.mousepressed (x, y, button)
  table.insert(world.gorobas, makeGoroba(x, y))
end

function love.keypressed (button)
  if button == 'escape' then
    love.event.push 'quit'
  end
end

local function dist (entityA, entityB)
  return math.sqrt((entityA.x-entityB.x)^2+(entityA.y-entityB.y)^2)
end

local function updateGorobas (to_be_removed, dt)
  for i,goroba in ipairs(world.gorobas) do
    for j,wil in ipairs(world.wils) do
      if dist(goroba, wil) <= 150 then
        table.insert(to_be_removed, {group='wils',index=j})
      end
    end
    goroba.time = math.max(goroba.time - dt, 0)
    if goroba.time <= 0 then
      table.insert(to_be_removed, {group='gorobas',index=i})
    end
  end
end

local function updateWils (to_be_removed, dt)
  for _,wil in ipairs(world.wils) do
    wil.x = wil.x - 50*dt
  end
  delay = math.max(delay - dt, 0)
  if delay <= 0 then
    table.insert(world.wils, makeWil(W+100, H/4+H/2*love.math.random()))
    delay = 1+expRand(0.5)
  end
end

function love.update (dt)
  local to_be_removed = {}
  updateGorobas(to_be_removed, dt)
  updateWils(to_be_removed, dt)
  for _,removal in ipairs(to_be_removed) do
    table.remove(world[removal.group], removal.index)
  end
end

function love.draw ()
  for _,group in pairs(world) do
    for _,entity in ipairs(group) do
      love.graphics.setColor(255,255,255,255)
      if entity.color then
        love.graphics.setColor(entity.color)
        entity.color = nil
      end
      love.graphics.draw(
        entity.sprite, entity.x, entity.y,
        0, 1, 1, -- rotation, horizontal scale, vertical scale
        entity.ox, entity.oy
      )
    end
  end
end
