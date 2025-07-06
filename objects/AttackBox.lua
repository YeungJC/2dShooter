AttackBox = GameObject:extend()

function AttackBox:new(area, x, y, opts)
    AttackBox.super.new(self, area, x, y, opts)

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
    self.attack_name = attack_keys[math.random(1, #attack_keys)]
    self.attack_color = attacks[self.attack_name].box_color

end

function AttackBox:update(dt)
    AttackBox.super.update(self, dt)

    self.collider:setLinearVelocity(self.v, 0) 
end

function AttackBox:draw()
    love.graphics.setColor(self.attack_color)
    pushRotate(self.x, self.y, self.collider:getAngle())
    draft:rhombus(self.x, self.y, 1.7 * self.w, 1.7 * self.h, 'line')  -- larger outer
    draft:rhombus(self.x, self.y, 1.3 * self.w, 1.3 * self.h, 'line')  -- larger inner

    -- set text and get its size
    local text = attacks[self.attack_name].abbreviation
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()

    love.graphics.print(text,self.x - (textWidth) / 2,self.y - (textHeight) / 2,0)
    love.graphics.pop()
    love.graphics.setColor(self.attack_color)
end

function AttackBox:destroy()
    AttackBox.super.destroy(self)
end

function AttackBox:die()
    self.dead = true
    self.area:addGameObject('AttackBoxEffect', self.x, self.y, {color = self.attack_color, w = self.w, h = self.h})
    self.area:addGameObject('InfoText', self.x + table.random({-1, 1})*self.w, self.y + table.random({-1, 1})*self.h, {color = boost_color, text = self.attack_name})
    return self.attack_name
end
