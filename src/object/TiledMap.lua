local grasses = require("asset.data.grass")

local TiledMap = Class("TiledMap",GameObject)

local tileset_img = love.graphics.newImage("asset/image/tileset.png", format)
tileset_img:setFilter("nearest","linear")
local tile_size = 32
local mw,mh = 25,20
local floorBatch = love.graphics.newSpriteBatch(tileset_img,mw*mh)
local objBatch = love.graphics.newSpriteBatch(tileset_img,mw*mh)

function tile(pid)
    local pid = pid or 0
    local width,height = tileset_img:getWidth(),tileset_img:getHeight()
    local w,h = width/tile_size, height/tile_size
    local x,y = math.floor(pid%w)*32,math.floor(pid/w)*32
    local quad = love.graphics.newQuad(x, y, 32,32,width, height)
    return quad
end

local function initMap()
    local map = {}
    for x=1,mw do
        map[x] = {}
        for y=1,mh do
            local opid = 5
            if math.random(1,10) > 5 then
                opid = 6
            end
            map[x][y] = {floor = grasses["grass"],obj = opid,wall = 7}
        end
    end
    return map
end

function TiledMap:init(x,y,opts)
	GameObject.init(self,x,y,opts)
	-- updateTilesetBatch()
    self.map = initMap()
    self:update()
end

function TiledMap:update(dt)
    floorBatch:clear()
    for x=1,mw do
        for y=1,mh do
            local floor_id = self.map[x][y].floor.pid
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