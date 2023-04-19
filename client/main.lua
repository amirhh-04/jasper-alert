
local ESX = nil
local QBCore = nil

local PlayerData = {}
local PlayerJob = {}

local frameWork = Config.FrameWork
local allowedJobsData = Config.allowedJobsData
local checkPhoneOn = Config.checkPhoneOn
local checkDivision = Config.checkDivision

local checkOnDuty = Config.checkOnDuty

if frameWork == 'ESX' then
    Citizen.CreateThread(function()
        while not ESX do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end

        while not ESX.GetPlayerData().job do
            Citizen.Wait(10)
        end
        PlayerData = ESX.GetPlayerData()
    end)
elseif frameWork == 'QBCORE' then
    QBCore = exports['qb-core']:GetCoreObject()
    PlayerData = QBCore.Functions.GetPlayerData()
end
if frameWork == 'ESX' then
    RegisterNetEvent("esx:setJob")
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)
elseif frameWork == 'QBCORE' then
    RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
        PlayerData = data
        PlayerJob = data.job
    end)
    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = nil
        PlayerJob = nil
    end)
    RegisterNetEvent('QBCore:Client:OnJobUpdate')
    AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerJob = JobInfo
    end)
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = Core.Functions.GetPlayerData()
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end)
end

RegisterNetEvent("jasper-alert:sendAlert")
AddEventHandler("jasper-alert:sendAlert", function(data)
    if frameWork == "QBCORE" then
        if allowedJobsData[PlayerData.job.name] and PlayerData.job.grade.level >= allowedJobsData[PlayerData.job.name].grade then
            if checkPhoneOn then
			    if not Config.getPhoneStatus(PlayerData) then return end
			end
			if checkDivision then
			    if not Config.getDivisionStatus(PlayerData) then return end
			end
            if checkOnDuty then
                if PlayerData.job.onduty then
                    showAlert(data)
                end
            else
                showAlert(data)
            end
        end
    elseif frameWork == "ESX" then
        if allowedJobsData[PlayerData.job.name] and PlayerData.job.grade >= allowedJobsData[PlayerData.job.name].grade then
            if checkPhoneOn then
			    if not Config.getPhoneStatus(PlayerData) then return end
			end
			if checkDivision then
			    if not Config.getDivisionStatus(PlayerData) then return end
			end
            showAlert(data)
        end
    end
end)

function showAlert(data)
    SendNUIMessage({type = 'show-alert', data = data, time = Config.alertTime, volume = Config.alertVolume})
end

function sendNotify(message)
    if frameWork == 'ESX' then
        ESX.ShowNotification(message)
    elseif frameWork == 'QBCORE' then
        QBCore.Functions.Notify(message, "primary")
    end
end