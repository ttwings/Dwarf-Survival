local grasses = require("asset.data.grass")

local TiledMap = Object:extend()

local tileset_img = love.graphics.newImage("asset/image/tileset1.png", format)
tileset_img:setFilter("nearest","linear")
local tile_size = 32
local mw,mh = 25,20
local floorBatch = love.graphics.newSpriteBatch(tileset_img,mw*mh)
local objBatch = love.graphics.newSpriteBatch(tileset_img,mw*mh)



local function randomPid(pid_table)
    if type(pid_table) == "table" then
        return pid_table[love.math.random(1,#pid_table)]
    end
    return pid_table
end

--- TODO 生成高度图
--- TODO 生成温度图

function TiledMap:initElevation()
    local elevation = {}
    local w,h,e = self.w,self.h,self.e
    local noise = love.math.noise
    for x=1,w do
        elevation[x] = {}
        for y=1,h do
            local nx = x/w
            local ny = y/h
            local n1,n2,n3,n4,n5,n6 = 1,2,4,8,16,32
            local e = noise(nx,ny)
            elevation[x][y] = noise(nx,ny)
        end
    end
end

local function initMap()
    local map = {}
    for x=1,mw do
        map[x] = {}
        for y=1,mh do
            --local opid = 129
            --if math.random(1,10) > 5 then
            --    opid = 23
            --end
            map[x][y] = {floor = randomPid(grasses[love.math.random(1,8)].pid),obj = 0,wall = 7}
        end
    end
    return map
end

function TiledMap:init(x,y,opts)
	GameObject.init(self,x,y,opts)
	-- updateTilesetBatch()
    self.w = 256
    self.h = 256
    self.e = 256
    self.elevation = self:initElevation()
    self.map = initMap()
    self.biome = "Mountain"
    -- self:update()
end



function TiledMap:update(dt)
    floorBatch:clear()
    for x=1,mw do
        for y=1,mh do
            local floor_id = self.map[x][y].floor
            local f_quad = tile(floor_id)
            if f_quad then
                floorBatch:add(f_quad,x*32,y*32)
            end
        end
    end
    floorBatch:flush()

    objBatch:clear()
    for x=1,mw do
        for y=1,mh do
            local obj_id = self.map[x][y].obj
            local o_quad = tile(obj_id)
            if o_quad then
                objBatch:add(o_quad,x*32,y*32)
            end
        end
    end
    objBatch:flush()
end


function TiledMap:draw()
	love.graphics.draw(floorBatch)
    love.graphics.draw(objBatch)
end

return TiledMap