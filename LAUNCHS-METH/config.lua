Config = {}

-- Pickup Locations
Config.AcidPickupLocations = {
    vector3(347.47, -2603.74, 6.21),        --- Example Locations
    vector3(719.87, -2144.52, 28.42),
    vector3(2666.00, 1444.72, 20.82)
}

-- Crafting Locations
Config.CraftingStage1 = vector3(-1366.38, -317.63, 39.54) -- METH BASE CRAFT
Config.CraftingStage2 = vector3(-1373.24, -311.14, 39.63) -- METH CRAFT

-- Items
Config.Items = {
    hydrochloric_acid = "hydrochloric_acid",
    sodiumbenz = "sodiumbenz", -- ADD THIS ITEM TO A BLACKMARKET OR SHOP
    meth_base = "meth_base",
    empty_weed_bag = "ls_empty_baggy", --YOUR SERVERS BAGGY ITEM
    meth_bag = "meth_bag"
}

-- Animation dictionary & name for crafting
Config.CraftingAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
Config.CraftingAnimName = "fullcut_cycle_v7_cokecutter"

Config.PickupAnimDict = "amb@world_human_bum_wash@male@low@idle_a"
Config.PickupAnimName = "idle_a"