Stage = Object:extend()

function Stage:new()
	self.area = Area(self)
	self.area:addPhysicsWorld()
	self.main_canvas = love.graphics.newCanvas(gw*sw,gh*sh)
	self.map = self.area:addObject("TiledMap",0,0)
	self.player = self.area:addObject("Dwarf",gw/2,gh/2)
	self.player.map = self.map
	input:bind('f4',function () self.player.die() end )
end

function Stage:update(dt)
	if self.area then self.area:update(dt) end
end

function Stage:draw()
	love.graphics.setCanvas(self.main_canvas)
	love.graphics.clear()
		camera:attach(0,0,gw,gh)
		--love.graphics.circle("line",gw/2,gh/2,50)

		if self.area then self.area:draw() end
		camera:detach()
	love.graphics.setCanvas()

	love.graphics.setColor(255,255,255,255)
	love.graphics.setBlendMode('alpha','premultiplied')
	love.graphics.draw(self.main_canvas,0,0,0,sx,sy)
	love.graphics.setBlendMode('alpha')
end

function Stage:destroy()
	self.area:destroy()
	self.area = nil
end

return Stage