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
	for _, value in ipairs(settings.licenses) do
		---@type ContextMenuItem
		local element = {
			title = value.title,
			description = value.description,
			icon = value.icon,
			onSelect = function (_)
				
			end
		}
		for _, jobname in ipairs(value.jobs) do
			if not data.licenses[jobname] then
				data.licenses[jobname] = {}
			end
			table.insert(data.licenses[jobname], element)
		end
	end
	for jobname, menuElements in pairs(data.licenses) do
		lib.registerContext({
			id = 'job_menu_' ..jobname,
			title = settings.locales['givelic_menu_title'],
			options = menuElements
		})
	end
	shared.ready = true
end
initialize()

local function requestMenu()
	if not ESX.PlayerLoaded then return false end
	local jobname = ESX.PlayerData.job.name
	if not data.licenses[jobname] then return false end
	lib.showContext('job_menu_' ..jobname)
end

local utils = require 'modules.utils.client'
RegisterCommand(settings.givelic.command, function (source, args, raw)
	if not shared.ready then
		return lib.print.warn(("'%s' is not ready yet!"):format(shared.resource))
	end

	if #args ~= 1 then
		return utils.notify({
			title = settings.locales['givelic_notify_title'],
			description = settings.locales['givelic_command_usage'],
			type = 'error',
		})
	end

	requestMenu()

end, false)
