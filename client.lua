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
	currentPlayer = {
		source = 0,
		name = '',
	},
	licenses = {}
}

local utils = require 'modules.utils.client'
local function initialize()
	for _, value in ipairs(settings.licenses) do
		---@type ContextMenuItem
		local element = {
			title = value.title,
			description = value.description,
			icon = value.icon,
			onSelect = function (_)
				if data.currentPlayer == 0 then
					return utils.notify({
						title = settings.locales['givelic_notify_title'],
						description = settings.locales['givelic_player_not_found']:format(settings.currentPlayer.name),
						type = 'error'
					})
				end

				local playerCoords = GetEntityCoords(cache.ped)
				local targetCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(data.currentPlayer.source)))
				local distance = #(playerCoords - targetCoords)
				if settings.distanceCheck and distance >= settings.distanceCheck then
					return utils.notify({
						title = settings.locales['givelic_notify_title'],
						description = settings.locales['givelic_player_distance'],
						type = 'error'
					})
				end
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

	local name = args[1]
	local isPlayerValid, playerData = lib.callback.await('licenses:server:checkPlayerValidity', false, name)
	if not isPlayerValid then
		return utils.notify({
			title = settings.locales['givelic_notify_title'],
			description = settings.locales['givelic_player_not_found']:format(name),
			type = 'error'
		})
	end
	data.currentPlayer = playerData
	
	requestMenu()

end, false)
