Object = require("lib.classic")
GameObject = require("objects.GameObject")
Timer = require("lib.Timer")
Camera = require("lib.Camera")
Input = require("lib.input")
Physics = require("lib.windfield")
require("lib.util")
function love.load(  )
    love.window.setMode(gw*sw,gh*sh)
    love.math.setRandomSeed(os.time())
    --aoe = Aoe:new(700,700)
    font = love.graphics.newFont("asset/font/unifont.ttf",16)
    love.graphics.setFont(font)
    tileset_img = love.graphics.newImage("asset/image/tileset1.png", format)
    rooms = {}
    local object_list = {}
    recursiveEnumerate('objects',object_list)
    requireFiles(object_list)
    
    input = Input()
    input:bind("left","left")
    input:bind("right","right")
    camera = Camera()
    
    --input:bind("f1")
    --input:bind("f2")
    --input:bind("f3")
    
    room1 = addRoom("Stage","room1")
    current_room = room1
end

function love.update(dt)
    if current_room then current_room:update(dt) end
end

function love.draw()
    if current_room then current_room:draw() end
end
