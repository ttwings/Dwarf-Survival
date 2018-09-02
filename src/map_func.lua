local tile_w,tile_h,tileset,quads,tile_table,entity_info,entities

function loadMap( path )
	love.filesystem.load(path)()
end

function newMap(tile_width,tile_height,tileset_path,tile_string,quad_info,
	ent_info,ent_list)

	tile_w = tile_width
	tile_h = tile_height
	tileset = love.graphics.newImage(tileset_path)
	entities = ent_list
	entity_info = ent_info

	local tileset_w,tileset_h = tileset:getWidth(),tileset:getHeight()

	quads = {}

	for _,info in ipairs(quad_info) do
		-- info[1] = the character ;info[2] = x ;info[3] = y
		quads[info[1]] = love.graphics.newQuad(info[2],info[3],tile_w,tile_h,
			tileset_w,tileset_h)
	end

	for _,info in ipairs(entity_info) do
		-- info[1] = the character ;info[2] = x ;info[3] = y
		quads[info[1]] = love.graphics.newQuad(info[2],info[3],tile_w,tile_h,
			tileset_w,tileset_h)
	end

--
	tile_table = {}

	local width = #(tile_string:match("[^\n]+"))
	for x =1,width,1 do tile_table[x] = {} end

	local row_index,column_index = 1,1
	 for row in tile_string:gmatch("[^\n]+") do
	 	assert(#row == width,'Map is not aligned: width of row' .. tostring(row_index) .. ' should be' .. tostring(width) ..' but it is ' .. tostring(#row))
	 	column_index = 1
	 	for character in row:gmatch(".") do
	 		tile_table[column_index][row_index] = character
	 		column_index = column_index + 1
	 	end
	 	row_index = row_index + 1
	 end
end


function map2world(mx,my)
	return (mx - 1)*tile_w,(my - 1)*tile_h
end

function drawMap()
	for column_index,column in ipairs(tile_table) do
		for row_index,char in ipairs(column) do
			local x,y = map2world(column_index,row_index)
			love.graphics.draw(tileset,quads[char],x,y)
		end
	end

	-- draw entities
	for i,entity in ipairs(entities) do
		local name,x,y = entity[1],map2world(entity[2],entity[3])
		love.graphics.draw(tileset,quads[name],x,y)
	end
end