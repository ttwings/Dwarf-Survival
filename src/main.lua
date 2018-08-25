--local aoe = require( "object.Aoe" )
Class = require("lib.middleclass")
GameObject = require("object.GameObject")
Aoe = require("object.Aoe")
TiledMap = require("object.TiledMap")
Dwarf = require("object.Dwarf")
Area = {}

function createGameObject(type,x,y,opts)
    local obj = _G[type](x,y,opts)
    table.insert(Area,obj)
end

function love.load(  )
    --aoe = Aoe:new(700,700)
    tileset_img = love.graphics.newImage("asset/image/tileset.png", format)
    love.keyboard.setKeyRepeat(true)
    --table.insert(Area,aoe)
    createGameObject("TiledMap",0,0)
    createGameObject("Aoe",200,500)
    createGameObject("Dwarf",1000,300)
end

function love.update(dt)
    for i = #Area, 1,-1 do
        Area[i]:update(dt)
        if Area[i].dead == true then
            table.remove(Area,i)
        end
    end
end

function love.draw()
    for _, v in ipairs(Area) do
        v:draw()
    end
end

function love.keypressed(key, isrepeat)
    ox,oy = aoe:keypressed(key,isrepeat,ox,oy)
end