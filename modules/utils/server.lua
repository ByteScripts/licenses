local utils = {}

function utils.notifyGroup(group, data)
    for _, xTarget in pairs(ESX.GetExtendedPlayers('job', group)) do
        utils.notify(xTarget.source, data)
    end
end

function utils.notify(src, data)
    TriggerClientEvent('ox_lib:notify', src, data)
end

return utils