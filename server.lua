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