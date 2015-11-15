-- override default dirt (to stop caves cutting away dirt)
minetest.override_item("default:dirt", {is_ground_content = false})

-- green dirt
minetest.register_node("ethereal:green_dirt", {
	description = "Green Dirt",
	tiles = {
		"default_grass.png",
		"default_dirt.png",
		"default_dirt.png^default_grass_side.png"
	},
	is_ground_content = false,
	groups = {crumbly = 3, soil = 1, ethereal_grass = 1},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults()
})

-- dry dirt
minetest.register_node("ethereal:dry_dirt", {
	description = "Dried Dirt",
	tiles = {"ethereal_dry_dirt.png"},
	is_ground_content = false,
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	type = "cooking",
	output = "ethereal:dry_dirt",
	recipe = "default:dirt",
	cooktime = 3,
})

local dirt = {}
dirt.type = {
	{"Bamboo"}, {"Jungle"}, {"Grove"}, {"Prairie"}, {"Cold"},
	{"Crystal"}, {"Mushroom"}, {"Fiery"}, {"Gray"},
}

for _, row in ipairs(dirt.type) do

	local desc = row[1]
	local name = desc:lower()

	minetest.register_node("ethereal:"..name.."_dirt", {
		description = desc.." Dirt",
		tiles = {
			"ethereal_grass_"..name.."_top.png",
			"default_dirt.png",
			"default_dirt.png^ethereal_grass_"..name.."_side.png"
		},
		is_ground_content = false,
		groups = {crumbly = 3, soil = 1, ethereal_grass = 1},
		drop = "default:dirt",
		sounds = default.node_sound_dirt_defaults()
	})

end

-- Compatibility with old maps
minetest.register_alias("ethereal:crystal_topped_dirt", "ethereal:crystal_dirt")
minetest.register_alias("ethereal:fiery_dirt_top", "ethereal:fiery_dirt")
minetest.register_alias("ethereal:gray_dirt_top", "ethereal:gray_dirt")
minetest.register_alias("ethereal:green_dirt_top", "ethereal:green_dirt")

-- check surrounding grass and change dirt to same colour (by Sokomine)
minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		local count_grasses = {}
		local curr_max  = 0
		local curr_type = "ethereal:green_dirt" -- fallback
		local positions = minetest.find_nodes_in_area_under_air(
			{x = (pos.x - 2), y = (pos.y - 1), z = (pos.z - 2)},
			{x = (pos.x + 2), y = (pos.y + 1), z = (pos.z + 2)},
			"group:ethereal_grass")
		local n
		-- count new grass nodes
		for _,p in ipairs(positions) do
			n = minetest.get_node_or_nil(p)
			if n and n.name then
				count_grasses[n.name] = (count_grasses[n.name] or 0) + 1
				-- we found a grass type with more than current max
				if count_grasses[n.name] > curr_max then
					curr_max = count_grasses[n.name]
					curr_type = n.name
				end
			end
		end
		minetest.set_node(pos, {name = curr_type})
	end
})

-- make dirt with dry grass spreads like ethereal grasses
minetest.override_item("default:dirt_with_dry_grass", {
	groups = {crumbly = 3, soil = 1, ethereal_grass = 1},
})

-- if grass devoid of light, change to dirt
minetest.register_abm({
	nodenames = {"group:ethereal_grass"},
	interval = 2,
	chance = 20,
	catch_up = false,
	action = function(pos, node)
		local name = minetest.get_node({
			x = pos.x,
			y = pos.y + 1,
			z = pos.z
		}).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
				nodedef.paramtype == "light") and
				nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})

-- If Baked Clay mod not active, make Red and Orange nodes
if not minetest.get_modpath("bakedclay") then

	minetest.register_node(":bakedclay:red", {
		description = "Red Baked Clay",
		tiles = {"baked_clay_red.png"},
		groups = {cracky = 3},
		is_ground_content = false,
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(":bakedclay:orange", {
		description = "Orange Baked Clay",
		tiles = {"baked_clay_orange.png"},
		groups = {cracky = 3},
		is_ground_content = false,
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node(":bakedclay:grey", {
		description = "Grey Baked Clay",
		tiles = {"baked_clay_grey.png"},
		groups = {cracky = 3},
		is_ground_content = false,
		sounds = default.node_sound_stone_defaults(),
	})

end