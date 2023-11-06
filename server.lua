lib.callback.register('licenses:server:checkPlayerValidity', function (source, targetName)
    if not targetName or not tostring(targetName) then return false, 0 end
    targetName = string.gsub(targetName, '_', ' ')
    local xPlayers = ESX.GetExtendedPlayers('name', targetName)
    if #xPlayers < 1 then return false, 0 end
    return true, {
        source = xPlayers[1].source,
        name = xPlayers[1].getName()
    }
end)

local inventory = require 'modules.inventory.server'
local logger = require 'modules.logger.server'
local utils = require 'modules.utils.server'
lib.callback.register('licenses:server:tryAddItem', function (source, targetId, itemName, itemMetadata)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xTarget = ESX.GetPlayerFromId(targetId)
    if not inventory.canCarryItem(xTarget.source, itemName, 1, itemMetadata) then
        return false, settings.locales['not_enough_space']
    end

    inventory.addInventoryItem(xTarget.source, itemName, 1, itemMetadata)
    logger.log(xPlayer.getName(), itemMetadata.lic, xTarget.getName())
    utils.notifyGroup(xPlayer.getJob().name, {
        title = settings.locales['givelic_notify_title'],
        description = settings.locales['logger_desc']:format(xPlayer.getName(), itemMetadata.lic, xTarget.getName())
    } --[[@as NotifyProps]])
    return true, settings.locales['item_added']
end)