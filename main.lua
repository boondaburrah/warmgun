require("animation")
require("player")
require("enemy")
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
  g_enemyAnim = Animation.new(love.graphics.newImage("content/mineAnimation.png"), {x = 0, y = 0}, 47, 61, 8, (1/30), 1, true)
  g_enemyList = nil
  f_addEnemy()
end

function love.update(dt)
  f_updatePlayer(dt)
  g_player:update(dt)
  g_baseBackground:update(dt)
  g_backgroundOne:update(dt)
  g_backgroundTwo:update(dt)
  g_enemyAnim:update(dt)
  f_updateList(g_enemyList, dt)
end

function f_updatePlayer(dt)
  assert(g_gamepad, "YA DUNN'T PLUG IN A GAMEPAD YA GOOB.")
  g_player.position.x = g_player.position.x + g_gamepad:getGamepadAxis("leftx") * 180 * dt
  g_player.position.y = g_player.position.y + g_gamepad:getGamepadAxis("lefty") * 180 * dt
  g_player.position.x = funkt.clamp(0, g_player.position.x, g_width - g_player:getWidth())
  g_player.position.y = funkt.clamp(0, g_player.position.y, g_height - g_player:getHeight())
end

function f_addEnemy()
  g_enemyList = {next = g_enemyList, value = Enemy.new(g_enemyAnim, {x = 800, y = 100})}
end

function f_drawList(list)
  if list == nil then return end
  list.value:draw()
  f_drawList(list.next)
end

function f_updateList(list, dt)
  if list == nil then return end
  list.value:update(dt)
  f_updateList(list.next, dt)
end

function love.draw()
  g_baseBackground:draw()
  g_backgroundOne:draw()
  g_backgroundTwo:draw()
  g_player:draw()

  -- g_enemyAnim:draw()
  f_drawList(g_enemyList)
end