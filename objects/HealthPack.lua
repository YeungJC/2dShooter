HealthPack = GameObject:extend()

function HealthPack:new(area, x, y, opts)
    HealthPack.super.new(self, area, x, y, opts)

    local direction = table.random({-1, 1})
    self.x = gw/2 + direction*(gw/2 + 48)
    self.y = random(48, gh - 48)

    self.w, self.h = 12, 12
    self.collider = self.area.world:newRectangleCollider(self.x, self.y, self.w, self.h)
    self.collider:setObject(self)
    self.collider:setCollisionClass('Collectable')
    self.collider:setFixedRotation(false)
    self.v = -direction*random(20, 40)
    self.collider:setLinearVelocity(self.v, 0)
    self.collider:applyAngularImpulse(random(-24, 24))
end

function HealthPack:update(dt)
    HealthPack.super.update(self, dt)

    self.collider:setLinearVelocity(self.v, 0) 
end

function HealthPack:draw()
    love.graphics.setColor(healthpack_color)
    pushRotate(self.x, self.y, self.collider:getAngle())
    draft:star(self.x, self.y, 1.5 * self.w, 0.75 * self.w, 5, 0, 'line')
    draft:star(self.x, self.y, 0.5 * self.w, 0.25 * self.w, 5, 0, 'fill')



    love.graphics.pop()
    love.graphics.setColor(default_color)
end

function HealthPack:destroy()
    HealthPack.super.destroy(self)
end

function HealthPack:die()
    self.dead = true
    self.area:addGameObject('HealthPackEffect', self.x, self.y, {color = healthpack_color, w = self.w, h = self.h})
    self.area:addGameObject('InfoText', self.x + table.random({-1, 1})*self.w, self.y + table.random({-1, 1})*self.h, {color = healthpack_color, text = '+HP'})
end
