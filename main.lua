require("animation")
require("player")
require("background")
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
  love.window.setMode(854, 480)
  g_width, g_height = love.window.getDimensions()
  g_playerAnim = Animation.new(love.graphics.newImage("content/shipAnimation.png"),  {x = 100, y = 100}, 115, 69, 8, (1/30), 1, true)
  g_player = Player.new(g_playerAnim, {x = 100, y = 100})
  g_playerMoveSpeed = 8
  g_backgroundOne = Background.new(love.graphics.newImage("content/bgLayer1.png"), 100)
  g_backgroundTwo = Background.new(love.graphics.newImage("content/bgLayer2.png"), 200)
  g_baseBackground = Background.new(love.graphics.newImage("content/mainbackground.png"), 25)
end

function love.update(dt)
  f_updatePlayer()
  g_player:update(dt)
  g_baseBackground:update(dt)
  g_backgroundOne:update(dt)
  g_backgroundTwo:update(dt)
end

function f_updatePlayer()
  g_player.position.x = g_player.position.x + g_gamepad:getGamepadAxis("leftx") * 8
  g_player.position.y = g_player.position.y + g_gamepad:getGamepadAxis("lefty") * 8
  g_player.position.x = funkt.clamp(0, g_player.position.x, g_width - g_player:getWidth())
  g_player.position.y = funkt.clamp(0, g_player.position.y, g_height - g_player:getHeight())
end

function love.draw()
  g_baseBackground:draw()
  g_backgroundOne:draw()
  g_backgroundTwo:draw()
  g_player:draw()
end