
-- Other constants
local LASER_SPD = 1024

function makeLaser (x1, y1, x2, y2)
  local laser = makeEntity(x1, y1, drawLaser)
  local ray = { x=x2-x1, y=y2-y1 }
  local l = length(ray)
  laser.dir = { x=ray.x/l, y=ray.y/l }
  laser.time = l/LASER_SPD
  return laser
end

function updateLasers (to_be_removed, dt)
  for i,laser in ipairs(world.lasers) do
    laser.x = laser.x + LASER_SPD*laser.dir.x*dt
    laser.y = laser.y + LASER_SPD*laser.dir.y*dt
    laser.time = math.max(laser.time - dt, 0)
    if laser.time <= 0 then
      table.insert(to_be_removed, {group='lasers',index=i})
    end
  end
end

function drawLaser (laser)
  local x1,y1 = laser.x - laser.dir.x*16, laser.y - laser.dir.y*16
  local x2,y2 = laser.x + laser.dir.x*16, laser.y + laser.dir.y*16
  love.graphics.setLineWidth(3)
  love.graphics.setColor(255,0,0,255)
  love.graphics.line(x1, y1, x2, y2)
  love.graphics.setColor(255,255,255,255)
  love.graphics.setLineWidth(1)
end
