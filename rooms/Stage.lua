Stage = Object:extend()

function Stage:new()
    self.area = Area(self)
    self.area:addPhysicsWorld()
    self.area.world:addCollisionClass('Enemy')
    self.area.world:addCollisionClass('Player')
    self.area.world:addCollisionClass('Projectile', {ignores = {'Projectile', 'Player'}})
    self.area.world:addCollisionClass('Collectable', {ignores = {'Collectable', 'Projectile'}})
    self.area.world:addCollisionClass('EnemyProjectile', {ignores = {'EnemyProjectile', 'Projectile', 'Enemy'}})

    self.director = Director(self)
    

    self.main_canvas = love.graphics.newCanvas(gw, gh)
    self.player = self.area:addGameObject('Player', gw/2, gh/2)

    self.score = 0
    self.font = fonts.m5x7_16

    input:bind('n', function() self.area:addGameObject('Boost', 0, 0) end)

    input:bind('p', function() 
        self.area:addGameObject('Ammo', random(0, gw), random(0, gh)) 
    end)

    input:bind('c', function() self.area:addGameObject('HealthPack', 0, 0) end)

    input:bind('q', function() self.area:addGameObject('SP', 0, 0) end)

    input:bind('w', function() self.area:addGameObject('Rock', 0, 0) end)

    input:bind('e', function() self.area:addGameObject('Shooter', 0, 0) end)

    
end

function Stage:update(dt)
    self.director:update(dt)
    camera.smoother = Camera.smooth.damped(5)
    camera:lockPosition(dt, gw/2, gh/2)

    self.area:update(dt)
end

function Stage:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
    camera:attach(0, 0, gw, gh)
    self.area:draw()
    camera:detach()

    love.graphics.setColor(255, 198, 93)
    love.graphics.print(self.player.sp,  20, 10, 0, 1, 1,
    math.floor(self.font:getWidth(self.player.sp)/2), self.font:getHeight()/2)
    love.graphics.setColor(255, 198, 93)

    love.graphics.setFont(self.font)
    love.graphics.setColor(default_color)
    love.graphics.print(self.score, gw - 20, 10, 0, 1, 1,
    math.floor(self.font:getWidth(self.score)/2), self.font:getHeight()/2)
    love.graphics.setColor(255, 255, 255)

    local r, g, b = unpack(ammo_color)
    local ammo, max_ammo = self.player.ammo, self.player.max_ammo
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('fill', gw/2 - 52, 16, 48*(ammo/max_ammo), 4)
    love.graphics.setColor(r - 32, g - 32, b - 32)
    love.graphics.rectangle('line', gw/2 - 52, 16, 48, 4)
    love.graphics.print('AMMO', gw/2 - 52 + 24, 8, 0, 1, 1,
    math.floor(self.font:getWidth('AMMO')/2), math.floor(self.font:getHeight()/2))

    local r, g, b = unpack(hp_color)
    local hp, max_hp = self.player.hp, self.player.max_hp
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('fill', gw/2 - 52, gh - 16, 48*(hp/max_hp), 4)
    love.graphics.setColor(r - 32, g - 32, b - 32)
    love.graphics.rectangle('line', gw/2 - 52, gh - 16, 48, 4)
    love.graphics.print('HP', gw/2 - 52 + 24, gh - 24, 0, 1, 1,
    math.floor(self.font:getWidth('HP')/2), math.floor(self.font:getHeight()/2))

    local r, g, b = unpack(boost_color)
    local boost, max_boost = self.player.boost, self.player.max_boost
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('fill', gw/2 + 4, 16, 48*(boost/max_boost), 4)
    love.graphics.setColor(r - 32, g - 32, b - 32)
    love.graphics.rectangle('line', gw/2 + 4, 16, 48, 4)
    love.graphics.print('BOOST', gw/2 + 28, 8, 0, 1, 1,
    math.floor(self.font:getWidth('BOOST')/2), math.floor(self.font:getHeight()/2))

    local r, g, b = unpack(default_color)
    local cycle = self.player.cycle_time
    love.graphics.setColor(r, g, b)
    love.graphics.rectangle('fill', gw/2 + 4, gh - 16, 48*(cycle/5), 4)
    love.graphics.setColor(r - 32, g - 32, b - 32)
    love.graphics.rectangle('line', gw/2 + 4, gh - 16, 48, 4)
    love.graphics.print('CYCLE', gw/2 + 28, gh - 24, 0, 1, 1,
    math.floor(self.font:getWidth('CYCLE')/2), math.floor(self.font:getHeight()/2))

    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')

    
end

function Stage:destroy()
    self.area:destroy()
    self.area = nil
end

function Stage:finish()
    timer:after(1, function()
        gotoRoom('Stage')
    end)
end