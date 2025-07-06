HealthPackEffect = GameObject:extend()

function HealthPackEffect:new(area, x, y, opts)
    HealthPackEffect.super.new(self, area, x, y, opts)
    self.depth = 75

    self.x, self.y = math.floor(self.x), math.floor(self.y)

    self.current_color = default_color
    self.timer:after(0.2, function() 
        self.current_color = self.color 
        self.timer:after(0.35, function()
            self.dead = true
        end)
    end)

    self.visible = true
    self.timer:after(0.2, function()
        self.timer:every(0.05, function() self.visible = not self.visible end, 6)
        self.timer:after(0.35, function() self.visible = true end)
    end)

    self.sx, self.sy = 1, 1
    self.timer:tween(0.35, self, {sx = 2, sy = 2}, 'in-out-cubic')
end

function HealthPackEffect:update(dt)
    HealthPackEffect.super.update(self, dt)
end

function HealthPackEffect:draw()
    if not self.visible then return end

    love.graphics.setColor(self.current_color)
    local innerRadius = 0.67 * self.w  
    draft:star(self.x, self.y, innerRadius, innerRadius / 2, 5, 0, 'fill')

    local outerRadius = self.sx * self.w  
    draft:star(self.x, self.y, outerRadius, outerRadius / 2, 5, 0, 'line')


    love.graphics.setColor(default_color)
end

function HealthPackEffect:destroy()
    HealthPackEffect.super.destroy(self)
end
