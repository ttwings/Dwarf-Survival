
local tile_string = [[
######################
#            #       #
#<====>      #       #
#<====>      #       #
#<====>      ####  ###
#                    #
#                    #
#                    #
#              ### ###
#              #     #
#              #     #
#              #     #
#              #     #
######################
]]

local quad_info = {
	{' ',	0,	0,	"floor"},
	{'#',	32,	0,	"bricks"},
	{'<',	0,	32,	"carpet left"},
	{'=',	32,	32,	"carpet middle"},
	{'>',	64,	32,	"carpet right"}
}

local entity_info = {
	{'rchair',	96,	0,	'chair'},
	{'lchair',	96,	32,	'chair'}
}

local entities = {
	{'rchair',	6,	4},
	{'rchair',	6,	5},
	{'lchair',	9,	4},
	{'lchair',	9,	5},
	{'rchair',	20,	3},
	{'rchair',	20,	4},
	{'lchair',	22,	3},
	{'lchair',	22,	4},
}

newMap(32,32,'resto.png',tile_string,quad_info,entity_info,entities)