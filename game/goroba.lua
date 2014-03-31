
function loadGoroba ()
  -- nothing
end

function makeGoroba (x, y)
  local goroba = makeAvatar(x, y, sprites.goroba)
  goroba.time = 5.0
  return goroba
end

function updateGorobas (to_be_removed, dt)
  for i,goroba in ipairs(world.gorobas) do
    for j,wil in ipairs(world.wils) do
      if dist(goroba, wil) <= 150 then
        table.insert(to_be_removed, {group='wils',index=j})
        table.insert(world.lasers, makeLaser(goroba.x, goroba.y, wil.x, wil.y))
        sounds.laser:play()
      end
    end
    goroba.time = math.max(goroba.time - dt, 0)
    if goroba.time <= 0 then
      table.insert(to_be_removed, {group='gorobas',index=i})
    end
  end
end
