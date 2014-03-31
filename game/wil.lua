
-- Wil spawn time
local delay

function loadWil ()
  delay = expRand(0.5)
end

function makeWil (x, y)
  return makeAvatar(x, y, sprites.wil)
end

function updateWils (to_be_removed, dt)
  for _,wil in ipairs(world.wils) do
    wil.x = wil.x - 50*dt
  end
  delay = math.max(delay - dt, 0)
  if delay <= 0 then
    table.insert(world.wils, makeWil(W+100, H/4+H/2*love.math.random()))
    delay = expRand(0.5)
  end
end
