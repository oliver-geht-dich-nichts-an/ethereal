-- Fire Flower
minetest.register_node("ethereal:fire_flower", {
	description = "Fire Flower",
	drawtype = "plantlike",
	tiles = { "ethereal_fire_flower.png" },
	inventory_image = "ethereal_fire_flower.png",
	wield_image = "ethereal_fire_flower.png",
	paramtype = "light",
	light_source = 5,
	sunlight_propagates = true,
	walkable = false,
	damage_per_second = 2,
	groups = {snappy = 1, oddly_breakable_by_hand = 3, igniter = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_punch = function(pos, node, puncher)

		puncher:punch(puncher, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 2}
		}, nil)
	end,
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:fire_flower",
	burntime = 40,
})

-- Fire Dust
minetest.register_craftitem("ethereal:fire_dust", {
	description = "Fire Dust",
	inventory_image = "fire_dust.png",
})

minetest.register_craft({
	output = "ethereal:fire_dust 2",
	recipe = {
		{'ethereal:fire_flower'},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:fire_dust",
	burntime = 20,
})


-- light strings (glowing vine)
minetest.register_node("ethereal:lightstring", {
	description = "Light String Vine",
	drawtype = "signlike",
	tiles = {"lightstring.png"},
	inventory_image = "lightstring.png",
	wield_image = "lightstring.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 10,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "ethereal:lightstring 8",
	recipe = {
		{"ethereal:vine", "ethereal:vine", "ethereal:vine"},
		{"ethereal:vine", "ethereal:fire_dust", "ethereal:vine"},
		{"ethereal:vine", "ethereal:vine", "ethereal:vine"},
	},
})

-- Fern (boston)
minetest.register_node("ethereal:fern", {
	description = "Fern",
	drawtype = "plantlike",
	visual_scale = 1.2,
	tiles = {"fern.png"},
	inventory_image = "fern.png",
	wield_image = "fern.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = {
		max_items = 1,
		items = {
			{items = {"ethereal:fern_tubers"}, rarity = 6},
			{items = {"ethereal:fern"}}
		}
	},
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
})

-- Boston Ferns sometimes drop edible Tubers (heals 1/2 heart when eaten)
minetest.register_craftitem("ethereal:fern_tubers", {
	description = "Fern Tubers",
	inventory_image = "fern_tubers.png",
	on_use = minetest.item_eat(1),
})

-- Red Shrub (not flammable)
minetest.register_node("ethereal:dry_shrub", {
	description = "Fiery Dry Shrub",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"ethereal_dry_shrub.png"},
	inventory_image = "ethereal_dry_shrub.png",
	wield_image = "ethereal_dry_shrub.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
})

-- Grey Shrub (not Flammable - too cold to burn)
minetest.register_node("ethereal:snowygrass", {
	description = "Snowy Grass",
	drawtype = "plantlike",
	visual_scale = 0.9,
	tiles = {"ethereal_snowygrass.png"},
	inventory_image = "ethereal_snowygrass.png",
	wield_image = "ethereal_snowygrass.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
})

-- Crystal Shrub (not Flammable - too cold to burn)
minetest.register_node("ethereal:crystalgrass", {
	description = "Crystal Grass",
	drawtype = "plantlike",
	visual_scale = 0.9,
	tiles = {"ethereal_crystalgrass.png"},
	inventory_image = "ethereal_crystalgrass.png",
	wield_image = "ethereal_crystalgrass.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
})

-- Define Moss Types (Has grass textures on all sides)
function ethereal.add_moss(typ, descr, texture, receipe_item)

	minetest.register_node("ethereal:" .. typ .. "_moss", {
		description = descr .. " Moss",
		tiles = {texture},
		groups = {crumbly = 3},
		sounds = default.node_sound_dirt_defaults()
	})

	minetest.register_craft({
		output = "ethereal:"..typ.."_moss",
		recipe = {{"default:dirt", receipe_item }} 
	})
end

ethereal.add_moss( "crystal", "Crystal", "ethereal_grass_crystal_top.png", "ethereal:frost_leaves")
ethereal.add_moss( "mushroom", "Mushroom", "ethereal_grass_mushroom_top.png", "ethereal:mushroom")
ethereal.add_moss( "fiery", "Fiery", "ethereal_grass_fiery_top.png", "ethereal:dry_shrub")
ethereal.add_moss( "gray", "Gray", "ethereal_grass_gray_top.png", "ethereal:snowygrass")
ethereal.add_moss( "green", "Green", "default_grass.png", "default:jungleleaves")

-- fix apples hanging in sky when no tree around
minetest.override_item("default:apple", {
	drop = "default:apple",
})

-- Banana (Heals one heart when eaten)
minetest.register_node("ethereal:banana", {
	description = "Banana",
	drawtype = "torchlike",
	visual_scale = 1.0,
	tiles = {"banana_single.png"},
	inventory_image = "banana_single.png",
	wield_image = "banana_single.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.2, 0.2}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1
	},
	drop = "ethereal:banana",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "ethereal:banana", param2 = 1})
		end
	end,
})

-- Banana Dough
minetest.register_craftitem("ethereal:banana_dough", {
	description = "Banana Dough",
	inventory_image = "banana_dough.png",
})

minetest.register_craft({
	type = "shapeless",
	output = "ethereal:banana_dough",
	recipe = {"farming:flour", "ethereal:banana"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 14,
	output = "ethereal:banana_bread",
	recipe = "ethereal:banana_dough"
})

-- Orange (Heals 2 hearts when eaten)
minetest.register_node("ethereal:orange", {
	description = "Orange",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"farming_orange.png"},
	inventory_image = "farming_orange.png",
	wield_image = "farming_orange.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.3, -0.2, 0.2, 0.2, 0.2}
	},
	groups = {
		fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1
	},
	drop = "ethereal:orange",
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "ethereal:orange", param2 = 1})
		end
	end,
})

-- Pine Nuts (Heals 1/2 heart when eaten)
minetest.register_craftitem("ethereal:pine_nuts", {
	description = "Pine Nuts",
	inventory_image = "pine_nuts.png",
	wield_image = "pine_nuts.png",
	on_use = minetest.item_eat(1),
})

-- Banana Loaf (Heals 3 hearts when eaten)
minetest.register_craftitem("ethereal:banana_bread", {
	description = "Banana Loaf",
	inventory_image = "banana_bread.png",
	wield_image = "banana_bread.png",
	on_use = minetest.item_eat(6),
})

-- Coconut (Gives 4 coconut slices, each heal 1/2 heart)
minetest.register_node("ethereal:coconut", {
	description = "Coconut",
	drawtype = "plantlike",
	walkable = false,
	paramtype = "light",
	sunlight_propagates = true,
	tiles = {"moretrees_coconut.png"},
	inventory_image = "moretrees_coconut.png",
	wield_image = "moretrees_coconut.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.35, -0.35, 0.35, 0.35, 0.35}
	},
	groups = {
		snappy = 1, oddly_breakable_by_hand = 1, cracky = 1,
		choppy = 1, flammable = 1, leafdecay = 3, leafdecay_drop = 1
	},
	drop = "ethereal:coconut_slice 4",
	sounds = default.node_sound_wood_defaults(),
})

-- Coconut Slice (Heals half heart when eaten)
minetest.register_craftitem("ethereal:coconut_slice", {
	description = "Coconut Slice",
	inventory_image = "moretrees_coconut_slice.png",
	wield_image = "moretrees_coconut_slice.png",
	on_use = minetest.item_eat(1),
})

-- Golden Apple (Found on Healing Tree, heals all 10 hearts)
minetest.register_node("ethereal:golden_apple", {
	description = "Golden Apple",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_apple_gold.png"},
	inventory_image = "default_apple_gold.png",
	wield_image = "default_apple_gold.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.3, -0.2, 0.2, 0.2, 0.2}
	},
	groups = {
		fleshy = 3, dig_immediate = 3,
		leafdecay = 3,leafdecay_drop = 1
	},
	drop = "ethereal:golden_apple",
	on_use = minetest.item_eat(20),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "ethereal:golden_apple", param2 = 1})
		end
	end,
})

-- Bamboo (thanks to Nelo-slay on DeviantArt for the free Bamboo base image)
minetest.register_node("ethereal:bamboo", {
	description = "bamboo",
	drawtype = "plantlike",
	tiles = {"bamboo.png"},
	inventory_image = "bamboo.png",
	wield_image = "bamboo.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2, tree = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_craft({
	type = "fuel",
	recipe = "ethereal:bamboo",
	burntime = 1,
})

-- Bamboo Sprout
minetest.register_node("ethereal:bamboo_sprout", {
	description = "Bamboo Sprout",
	drawtype = "plantlike",
	tiles = {"bamboo_sprout.png"},
	inventory_image = "bamboo_sprout.png",
	wield_image = "bamboo_sprout.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {
		snappy = 3, attached_node = 1, flammable = 2,
		dig_immediate = 3, ethereal_sapling = 1
	},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_use = minetest.item_eat(-2),
})

-- Wooden Bowl (for Mushroom Soup)
minetest.register_craftitem("ethereal:bowl", {
	description = "Bowl",
	inventory_image = "bowl.png",
})

minetest.register_craft({
	output = "ethereal:bowl",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"", "group:wood", ""},
		{"", "", ""},
	}
})

-- Hearty Stew (Heals 5 hearts - thanks to ZonerDarkRevention for his DokuCraft DeviantArt bowl texture)
minetest.register_craftitem("ethereal:hearty_stew", {
	description = "Hearty Stew",
	inventory_image = "hearty_stew.png",
	wield_image = "hearty_stew.png",
	on_use = minetest.item_eat(10, "ethereal:bowl"),
})

minetest.register_alias("ethereal:hearty_stew_cooked", "ethereal:hearty_stew")

minetest.register_craft({
	output = "ethereal:hearty_stew",
	recipe = {
		{"ethereal:wild_onion_plant","ethereal:mushroom_plant", "ethereal:fern_tubers"},
		{"","ethereal:mushroom_plant", ""},
		{"","ethereal:bowl", ""},
	}
})

-- Bamboo Flooring
minetest.register_node("ethereal:bamboo_floor", {
	description = ("Bamboo Floor"),
	drawtype = 'nodebox',
	tiles = { "bamboo_floor.png" },
	wield_image = "bamboo_floor.png",
	inventory_image = "bamboo_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
	},
	selection_box = {type = "wallmounted"},
	groups = {snappy = 3, choppy = 3 , flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

-- Craft Bamboo into Bamboo Flooring
minetest.register_craft({
	output = "ethereal:bamboo_floor 2",
	recipe = {
		{"ethereal:bamboo", "ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo", "ethereal:bamboo"},
	}
})

-- Craft Bamboo into Paper
minetest.register_craft({
	output = "default:paper 6",
	recipe = {
		{"ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo"},
		{"ethereal:bamboo", "ethereal:bamboo"},
	}
})

-- X pattern craft recipes (5x a in X pattern gives 5 b)
for _,items in pairs({
	{"default:cobble", "default:gravel"},
	{"default:gravel", "default:dirt"},
	{"default:dirt", "default:sand"},
	{"default:ice", "default:snow"},
	{"ethereal:dry_dirt", "default:desert_sand"},
}) do
	local a, b = unpack(items)
	minetest.register_craft({
		output = b.." 5",
		recipe = {
			{a, "", a},
			{"", a, ""},
			{a, "", a},
		}
	})
end

-- Paper (2x3 string = 4 paper)
minetest.register_craft({
	output = "default:paper 4",
	recipe = {
		{"farming:string", "farming:string", ""},
		{"farming:string", "farming:string", ""},
		{"farming:string", "farming:string", ""},
	}
})

-- Bucket of Cactus Pulp
minetest.register_craftitem("ethereal:bucket_cactus", {
	description = "Bucket of Cactus Pulp",
	inventory_image = "bucket_cactus.png",
	wield_image = "bucket_cactus.png",
	stack_max = 1,
	on_use = minetest.item_eat(2, "bucket:bucket_empty"),
})

minetest.register_craft({
	output = "ethereal:bucket_cactus",
	recipe = {
		{"bucket:bucket_empty","default:cactus"},
	}
})

-- Palm Wax
minetest.register_craftitem("ethereal:palm_wax", {
	description = "Palm Wax",
	inventory_image = "palm_wax.png",
	wield_image = "palm_wax.png",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "ethereal:palm_wax",
	recipe = "ethereal:palmleaves"
})

-- Candle from Wax and String/Cotton
minetest.register_node("ethereal:candle", {
	description = "Candle",
	drawtype = "plantlike",
	inventory_image = "candle_static.png",
	wield_image = "candle_static.png",
	tiles = {
		{
			name = "candle.png",
			animation={
				type="vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 1.0
			}
		},
	},	
	paramtype = "light",
	light_source = 11,
	sunlight_propagates = true,
	walkable = false,
	groups = {dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 }
	},
})

minetest.register_craft({
	output = "ethereal:candle 4",
	recipe = {
		{"","farming:cotton"},
		{"","ethereal:palm_wax"},
		{"","ethereal:palm_wax"},
	}
})
