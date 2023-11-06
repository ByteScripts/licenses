local inventory = {}

function inventory.canCarryItem(src, item, count, metadata)
    return exports.ox_inventory:CanCarryItem(src, item, count, metadata)
end

function inventory.addInventoryItem(src, item, count, metadata)
    exports.ox_inventory:AddItem(src, item, count, metadata)
end

return inventory