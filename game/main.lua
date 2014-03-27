
local world
-- Wil spawn time
local delay
-- We cache the images, obviously
local sprites
-- Screen values
local W, H
-- Other constants
local LASER_SPD = 1024

local function dist (entityA, entityB)
  return math.sqrt((entityA.x-entityB.x)^2+(entityA.y-entityB.y)^2)
end

local function length (vec)
  return dist(vec, {x=0,y=0})
end

local function expRand (lambda)
  return math.log(love.math.random())/(-lambda)
end

local function makeEntity (x, y, draw_callback)
  local entity = {
    x = x,
    y = y,
    draw = draw_callback
  }
  return entity
end

local function drawAvatar (avatar)
  love.graphics.setColor(255,255,255,255)
  if avatar.color then
    love.graphics.setColor(avatar.color)
    avatar.color = nil
  end
  love.graphics.draw(
    avatar.sprite, avatar.x, avatar.y,
    0, 1, 1, -- rotation, horizontal scale, vertical scale
    avatar.ox, avatar.oy
  )
end

local function makeAvatar (x, y, sprite)
  local avatar = makeEntity(x, y, drawAvatar)
  avatar.sprite = sprite
  avatar.ox = avatar.sprite:getWidth()/2
  avatar.oy = avatar.sprite:getHeight()/2
  return avatar
end

local function makeGoroba (x, y)
  local goroba = makeAvatar(x, y, sprites.goroba)
  goroba.time = 5.0
  return goroba
end

local function makeWil (x, y)
  return makeAvatar(x, y, sprites.wil)
end

local function drawLaser (laser)
  local x1,y1 = laser.x - laser.dir.x*16, laser.y - laser.dir.y*16
  local x2,y2 = laser.x + laser.dir.x*16, laser.y + laser.dir.y*16
  love.graphics.setLineWidth(3)
  love.graphics.setColor(255,0,0,255)
  love.graphics.line(x1, y1, x2, y2)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setLineWidth(1)
end

local function makeLaser (x1, y1, x2, y2)
  local laser = makeEntity(x1, y1, drawLaser)
  local ray = { x=x2-x1, y=y2-y1 }
  local l = length(ray)
  laser.dir = { x=ray.x/l, y=ray.y/l }
  laser.time = l/LASER_SPD
  return laser
end

function love.load ()
  world = {}
  world.gorobas = {}
  world.wils = {}
  world.lasers = {}
  delay = expRand(0.5)
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

local function updateGorobas (to_be_removed, dt)
  for i,goroba in ipairs(world.gorobas) do
    for j,wil in ipairs(world.wils) do
      if dist(goroba, wil) <= 150 then
        table.insert(to_be_removed, {group='wils',index=j})
        table.insert(world.lasers, makeLaser(goroba.x, goroba.y, wil.x, wil.y))
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
    delay = expRand(0.5)
  end
end

local function updateLasers (to_be_removed, dt)
  for i,laser in ipairs(world.lasers) do
    laser.x = laser.x + LASER_SPD*laser.dir.x*dt
    laser.y = laser.y + LASER_SPD*laser.dir.y*dt
    laser.time = math.max(laser.time - dt, 0)
    if laser.time <= 0 then
      table.insert(to_be_removed, {group='lasers',index=i})
    end
  end
end

function love.update (dt)
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
end
