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
    font = love.graphics.newFont("asset/font/unifont.ttf",16)
    love.graphics.setFont(font)
    tileset_img = love.graphics.newImage("asset/image/tileset1.png", format)

    rooms = {}
    local object_list = {}
    recursiveEnumerate('objects',object_list)
    requireFiles(object_list)
    
    input = Input()
    timer = Timer()
---- gc info
    input:bind("f1",function ()
        print("Before collection : " .. collectgarbage("count")/1024)
        collectgarbage()
        print("After collection : ".. collectgarbage("count")/1024)
        print("object count : " )
        local counts = type_count()
        for k , v in pairs(counts) do print(k,v) end
        print("------------------------------")
    end)

    input:bind("left","left")
    input:bind("right","right")
    input:bind("up","up")
    input:bind("down","down")
    input:bind("j","d_left")
    input:bind("k","d_down")
    input:bind("i","d_up")
    input:bind("l","d_right")
    input:bind("g","start")
    input:bind("h","back")

    camera = Camera()

    room1 = addRoom("Stage","room1")
    current_room = room1
end

function love.update(dt)
    if timer then timer:update(dt) end
    if current_room then current_room:update(dt) end
end

function love.draw()
    if current_room then current_room:draw() end
end
