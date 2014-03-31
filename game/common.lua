
function dist (entityA, entityB)
  return math.sqrt((entityA.x-entityB.x)^2+(entityA.y-entityB.y)^2)
end

function length (vec)
  return dist(vec, {x=0,y=0})
end

function expRand (lambda)
  return math.log(love.math.random())/(-lambda)
end
