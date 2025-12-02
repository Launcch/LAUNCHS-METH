--CLIENT.lua
local QBCore = exports['qb-core']:GetCoreObject()


local function V3(x, y, z)
    if vec3 then return vec3(x, y, z) end
    return vector3(x, y, z)
end

-- ACID Pickup Targets (ox_target)
CreateThread(function()
    for i, loc in ipairs(Config.AcidPickupLocations) do
        exports.ox_target:addBoxZone({
            coords = V3(loc.x, loc.y, loc.z),
            size = V3(1.5, 1.5, 2.0),
            rotation = 0,
            debug = false,
            options = {
                {
                    
                    name = ("acid_pickup_%s"):format(i),
                    label = "Collect Hydrochloric Acid",
                    icon = "fa-solid fa-vial",
                    distance = 2.5,
                    onSelect = function()
                        QBCore.Functions.Progressbar("pickup_acid", "Collecting Hydrochloric Acid...", 10000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        }, {
                            animDict = Config.PickupAnimDict,
                            anim = Config.PickupAnimName,
                            flags = 49
                        }, {}, {}, function() -- Done
                            TriggerServerEvent("methjob:pickupAcid")
                        end)
                    end
                }
            }
        })
    end
end)

-- Crafting Stage 1 (ox_target)
CreateThread(function()
    local c = Config.CraftingStage1
    exports.ox_target:addBoxZone({
        coords = V3(c.x, c.y, c.z),
        size = V3(1.5, 1.5, 2.0),
        rotation = 0,
        debug = false,
        options = {
            {
                name = "craft_meth_base",
                label = "Make Meth Base",
                icon = "fa-solid fa-flask",
                distance = 2.5,
                onSelect = function()
                    local menu = {
                        {
                            header = "Craft Meth Base",
                            txt = "Requires: 12x Hydrochloric Acid, 4x Sodium Benz", -- change to match what values you set in server.lua
                            params = {
                                event = "methjob:attemptCraft",
                                args = { craftType = "meth_base" }
                            }
                        },
                        { header = "Close", params = { event = "qb-menu:client:closeMenu" } }
                    }
                    exports['qb-menu']:openMenu(menu)
                end
            }
        }
    })
end)

-- Crafting Stage 2 (ox_target)
CreateThread(function()
    local c = Config.CraftingStage2
    exports.ox_target:addBoxZone({
        coords = V3(c.x, c.y, c.z),
        size = V3(1.5, 1.5, 2.0),
        rotation = 0,
        debug = false,
        options = {
            {
                name = "craft_meth",
                label = "Make Meth",
                icon = "fa-solid fa-capsules",
                distance = 2.5,
                onSelect = function()
                    local menu = {
                        {
                            header = "Craft Meth",
                            txt = "Requires: 1x Meth Base, 1x Empty Baggy", -- change to match what values you set in server.lua
                            params = {
                                event = "methjob:attemptCraft",
                                args = { craftType = "meth" }
                            }
                        },
                        { header = "Close", params = { event = "qb-menu:client:closeMenu" } }
                    }
                    exports['qb-menu']:openMenu(menu)
                end
            }
        }
    })
end)

-- Event triggered from qb-menu (unchanged)
RegisterNetEvent("methjob:attemptCraft", function(data)
    QBCore.Functions.TriggerCallback("methjob:checkItems", function(hasItems)
        if hasItems then
            if data.craftType == "meth_base" then                                   --can change the time for progressbar
                QBCore.Functions.Progressbar("craft_meth_base", "Mixing Meth Base...", 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {
                    animDict = Config.CraftingAnimDict,
                    anim = Config.CraftingAnimName,
                    flags = 49
                }, {}, {}, function()
                    TriggerServerEvent("methjob:craftMethBase")
                end)
            elseif data.craftType == "meth" then                       --can change the time for progressbar
                QBCore.Functions.Progressbar("craft_meth", "Processing Meth...", 10000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {
                    animDict = Config.CraftingAnimDict,
                    anim = Config.CraftingAnimName,
                    flags = 49
                }, {}, {}, function()
                    TriggerServerEvent("methjob:craftMeth")
                end)
            end
        else
            QBCore.Functions.Notify("You don’t have the required ingredients!", "error")
        end
    end, data.craftType)
end)
