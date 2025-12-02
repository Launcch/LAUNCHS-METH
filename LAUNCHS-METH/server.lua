local QBCore = exports['qb-core']:GetCoreObject()

-- Print startup banner to server console when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("[       script:meth] [   ||               ___ ______  _   _")
        print("[       script:meth] [   ||     _   _    |  _|__  __|| |_| |")
        print("[       script:meth] [   ||    | | | |   | |_   | |  |  __ |")
        print("[       script:meth] [   ||   |   |   |  | __|  | |  | | | |")
        print("[       script:meth] [   ||  |         | |___|  |_|  |_| |_|")
        print("[       script:meth] [   ||                                   ")
        print("[       script:meth] [   || LAUNCHS METH: Meth resource is running! v1.0.0")
    end
end)

-- Check if player has items before starting craft
QBCore.Functions.CreateCallback("methjob:checkItems", function(source, cb, craftType)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb(false) return end

    if craftType == "meth_base" then
        local acid = Player.Functions.GetItemByName(Config.Items.hydrochloric_acid)
        local sodiumbenz = Player.Functions.GetItemByName(Config.Items.sodiumbenz)
        if acid and acid.amount >= 12 and sodiumbenz and sodiumbenz.amount >= 4 then
            cb(true)
        else
            cb(false)
        end
    elseif craftType == "meth" then
        local base = Player.Functions.GetItemByName(Config.Items.meth_base)
        local bag = Player.Functions.GetItemByName(Config.Items.empty_weed_bag)
        if base and base.amount >= 1 and bag and bag.amount >= 1 then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

-- Pickup Acid
RegisterNetEvent("methjob:pickupAcid", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local amount = math.random(1, 3)
        Player.Functions.AddItem(Config.Items.hydrochloric_acid, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.hydrochloric_acid], 'add')
        TriggerClientEvent('QBCore:Notify', src, "You collected " .. amount .. " Hydrochloric Acid ", "success")
    end
end)

-- Craft Meth Base
RegisterNetEvent("methjob:craftMethBase", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)       -- CHANGE VALUES HERE TO INCREASE/DECREASE INGREDIENTS -- MAKE SURE TO CHANGE CLIENT.LUA TOO MATCH
    if Player.Functions.RemoveItem(Config.Items.hydrochloric_acid, 12) and Player.Functions.RemoveItem(Config.Items.sodiumbenz, 4) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.hydrochloric_acid], 'remove')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.sodiumbenz], 'remove')
        Player.Functions.AddItem(Config.Items.meth_base, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.meth_base], 'add')
        TriggerClientEvent('QBCore:Notify', src, "You Made Meth Base", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Missing ingredients!", "error")
    end
end)

-- Craft Meth
RegisterNetEvent("methjob:craftMeth", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)            -- CHANGE VALUES HERE TO INCREASE/DECREASE INGREDIENTS  -- MAKE SURE TO CHANGE CLIENT.LUA TOO MATCH
    if Player.Functions.RemoveItem(Config.Items.meth_base, 1) and Player.Functions.RemoveItem(Config.Items.empty_weed_bag, 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.meth_base], 'remove')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.empty_weed_bag], 'remove')
        Player.Functions.AddItem(Config.Items.meth_bag, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.meth_bag], 'add')
        TriggerClientEvent('QBCore:Notify', src, "You Made Meth", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Missing ingredients!", "error")
    end
end)
