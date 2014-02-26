require("animation")

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  playerAnim = Animation.new(love.graphics.newImage("content/shipAnimation.png"), 100, 100, 115, 69, 8, (1/30), 1, true)
end
function love.update(dt)
  playerAnim:update(dt)
end
function love.draw()
  playerAnim:draw()
end
