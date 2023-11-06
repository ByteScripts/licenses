lib.callback.register('licenses:server:checkPlayerValidity', function (source, targetName)
    if not targetName or not tostring(targetName) then return false, 0 end
    local xPlayers = ESX.GetExtendedPlayers('name', targetName)
    if #xPlayers < 1 then return false, 0 end
    return true, xPlayers[1].source
end)