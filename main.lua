require("animation")
require("player")
require("funkt")

function love.joystickadded(jstick)
  if g_gamepad == nil then g_gamepad = jstick end
end

function love.resize(w, h)
  g_width = w
  g_height = h
end

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  g_playerAnim = Animation.new(love.graphics.newImage("content/shipAnimation.png"),  {x = 100, y = 100}, 115, 69, 8, (1/30), 1, true)
  g_player = Player.new(g_playerAnim, {x = 100, y = 100})
  g_playerMoveSpeed = 8
end
function love.update(dt)
  f_updatePlayer()
  g_player:update(dt)
end

function f_updatePlayer()
  g_player.position.x = g_player.position.x + g_gamepad:getGamepadAxis("leftx") * 8
  g_player.position.y = g_player.position.y + g_gamepad:getGamepadAxis("lefty") * 8
end

function love.draw()
  g_player:draw()
end