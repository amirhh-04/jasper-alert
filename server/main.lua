
local ESX = nil
local QBCore = nil

local frameWork = Config.FrameWork
local allowedJobsData = Config.allowedJobsData
local CommandName = Config.CommandName

local checkOnDuty = Config.checkOnDuty
local checkPhoneOn = Config.checkPhoneOn
local checkDivision = Config.checkDivision

if frameWork == "QBCORE" then
	QBCore = exports["qb-core"]:GetCoreObject()
elseif frameWork == "ESX" then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterCommand(CommandName, function(source, args)
	local source = source
	local message = table.concat(args, " ", 1)
	if args[1] == nil then sendNotify(source, Config.Message.no_message) return end
	if frameWork == "QBCORE" then
		local player = QBCore.Functions.GetPlayer(source)
		if not player then return end
		local jobData = allowedJobsData[player.PlayerData.job.name]
		if jobData and player.PlayerData.job.grade.level >= jobData.grade then
			if checkPhoneOn then
			    if not Config.getPhoneStatus(player, source) then
					return sendNotify(source, Config.Message.phone_off)
				end
			end
			if checkDivision then
			    if not Config.getDivisionStatus(player, source) then
					return sendNotify(source, Config.Message.no_division)
				end
			end
			if checkOnDuty then
				if player.PlayerData.job.onduty then
					TriggerClientEvent("jasper-alert:sendAlert", -1, {title = jobData.title, img = jobData.img, message = '<div class="message"> <div class="officer"><span class="name"></span>' .. message ..'</div></div>'})
				else
					return sendNotify(source, Config.Message.offDuty)
				end
			else
				TriggerClientEvent("jasper-alert:sendAlert", -1, {title = jobData.title, img = jobData.img, message = '<div class="message"> <div class="officer"><span class="name"></span>' .. message ..'</div></div>'})
			end
		else
			sendNotify(source, Config.Message.not_perm)
		end
	elseif frameWork == "ESX" then
		local xPlayer = ESX.GetPlayerFromId(source)
		if not xPlayer then return end
		if checkPhoneOn then
			if not Config.getPhoneStatus(xPlayer, source) then
				return sendNotify(source, Config.Message.phone_off)
			end
		end
		if checkDivision then
			if not Config.getDivisionStatus(xPlayer, source) then
				return sendNotify(source, Config.Message.no_division)
			end
		end
		local jobData = allowedJobsData[xPlayer.job.name]
		if jobData and xPlayer.job.grade >= jobData.grade then
			TriggerClientEvent("jasper-alert:sendAlert", -1, {title = jobData.title, img = jobData.img, message = '<div class="message">' .. message ..'</div>'})
		else
			sendNotify(source, Config.Message.not_perm)
		end
	end
end)

function sendNotify(source, message)
	if frameWork == 'ESX' then
		TriggerClientEvent('esx:showNotification', source, message)
	elseif frameWork == 'QBCORE' then
		QBCore.Functions.Notify(source, message, "primary")
	end
end