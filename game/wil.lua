
-- Wil spawn time
local delay

function loadWil ()
  delay = expRand(0.5)
end

function makeWil (x, y)
  local wil = makeAvatar(x, y, sprites.wil)
  wil.hp = 3
  return wil
end

function updateWils (to_be_removed, dt)
  for i,wil in ipairs(world.wils) do
    if wil.hp <= 0 then
      table.insert(to_be_removed, {group='wils',index=i})
      money = money + 1
    else
      wil.x = wil.x - 50*dt
      if wil.x < 0 then
        -- YOU LOSE
        local font = love.graphics.newFont(42)
        love.update = nil
        love.draw = function ()
          local old = love.graphics.getFont()
          love.graphics.setFont(font)
          love.graphics.print("YOU LOSE", W/2+50, H-200)
          love.graphics.setFont(old)
        end
      end
    end
  end
  delay = math.max(delay - dt, 0)
  if delay <= 0 then
    table.insert(world.wils, makeWil(W+100, H/4+H/2*love.math.random()))
    delay = expRand(0.5)
  end
end
