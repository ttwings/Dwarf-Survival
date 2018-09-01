function p_print(...)
    local info = debug.getinfo(2, "Sl")
    local source = info.source
    local msg = ("%s:%i ->"):format(source, info.currentline)
    print(msg, ...)
end

function resize( s )
	love.window.setMode(s*gw,s*gh)
	sx,sy = s,s
end

function UUID()
	local fn = function ( x )
		local r = love.math.random(16) - 1
		r = (x == 'x') and (r + 1) or (r % 4) + 9
		return ("0123456789abcdef"):sub(r,r)
	end
	return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]",fn))
end

function addRoom( room_type, room_name, ... )
    local room = _G[room_type](room_name, ...)
    rooms[room_name] = room
    return room
end

function gotoRoom( room_type, room_name, ... )
    if current_room and current_room.destroy then current_room:destroy() end
    if current_room and rooms[room_name] then
        if current_room.deactivate then current_room:activate() end
        current_room = rooms[room_name]
        if current_room.activate then current_room:activate() end
    else current_room = addRoom(room_type, room_name, ...) end
end

function recursiveEnumerate( folder,file_list )
    local items = love.filesystem.getDirectoryItems(folder)
    for _,item in ipairs(items) do
        local file = folder .. '/' .. item
        if love.filesystem.isFile(file) then
            table.insert(file_list,file)
        elseif love.filesystem.isDirectory(file) then
            recursiveEnumerate(file,file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1,-5)
        require(file)
    end
end

function random(min,max)
    local min,max = min or 0, max or 1
    return (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)
end

function count_all(f)
    local seen = {}
    local count_table
    count_table = function(t)
        if seen[t] then return end
        f(t)
        seen[t] = true
        for k,v in pairs(t) do
            if type(v) == "table" then
                count_table(v)
            elseif type(v) == "userdata" then
                f(v)
            end
        end
    end
    count_table(_G)
end

function type_count()
    local counts = {}
    local enumerate = function (o)
        local t = type_name(o)
        counts[t] = (counts[t] or 0) + 1
    end
    count_all(enumerate)
    return counts
end

global_type_table = nil
function type_name(o)
    if global_type_table == nil then
        global_type_table = {}
        for k,v in pairs(_G) do
            global_type_table[v] = k
        end
        global_type_table[0] = "table"
    end
    return global_type_table[getmetatable(o) or 0] or "Unknown"
end