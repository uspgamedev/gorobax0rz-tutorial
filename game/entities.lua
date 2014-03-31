
require 'goroba'
require 'wil'
require 'laser'

function loadEntities ()
  loadGoroba()
  loadWil()
end

function makeEntity (x, y, draw_callback)
  local entity = {
    x = x,
    y = y,
    draw = draw_callback
  }
  return entity
end

function drawAvatar (avatar)
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

function makeAvatar (x, y, sprite)
  local avatar = makeEntity(x, y, drawAvatar)
  avatar.sprite = sprite
  avatar.ox = avatar.sprite:getWidth()/2
  avatar.oy = avatar.sprite:getHeight()/2
  return avatar
end
