RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local data = {
	licenses = {}
}
local function initialize()
	for key, value in ipairs(settings.licenses) do
		---@type ContextMenuItem
		local element = {
			title = value.title,
			description = value.description,
			icon = value.icon,
		}
		for _, jobname in ipairs(value.jobs) do
			if not data.licenses[jobname] then
				data.licenses[jobname] = {}
			end
			table.insert(data.licenses[jobname], element)
		end
	end
	shared.ready = true
end
initialize()

local utils = require 'modules.utils.client'
RegisterCommand(settings.givelic.command, function (source, args, raw)
	if not shared.ready then
		return lib.print.warn(("'%s' is not ready yet!"):format(shared.resource))
	end

end, false)
