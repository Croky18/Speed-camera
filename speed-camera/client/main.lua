local QBCore, ESX
local spawnedCameras = {}

if Config.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports['es_extended']:getSharedObject()
end

CreateThread(function()
    for _, cam in pairs(Config.CameraSpots) do
        if Config.ShowBlips then
            local blip = AddBlipForCoord(cam.coords)
            SetBlipSprite(blip, 184)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 1)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Flitspaal")
            EndTextCommandSetBlipName(blip)
        end
        cam.detectionRadius = cam.detectionRadius or 15.0
    end
end)

local function ConvertSpeed(speed)
    return (Config.SpeedUnit == "mph") and speed * 0.621371 or speed
end

RegisterNetEvent("speedcamera:FlashEffect", function()
    StartScreenEffect("SwitchHUDIn", 0, false)
    Wait(300)
    StopScreenEffect("SwitchHUDIn")
end)

local function Notify(msg)
    if Config.Framework == "qb" then
        QBCore.Functions.Notify(msg, "error")
    else
        ESX.ShowNotification(msg)
    end
end

local function GetPlayerJob()
    if Config.Framework == "qb" then
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData and PlayerData.job and PlayerData.job.name then
            return PlayerData.job.name
        end
    elseif Config.Framework == "esx" then
        local PlayerData = ESX.GetPlayerData()
        if PlayerData and PlayerData.job and PlayerData.job.name then
            return PlayerData.job.name
        end
    end
    return "unemployed"
end

CreateThread(function()
    while true do
        Wait(1500)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local speed = GetEntitySpeed(ped) * 3.6
        local convertedSpeed = ConvertSpeed(speed)

        for _, cam in pairs(Config.CameraSpots) do
            local distance = #(coords - cam.coords)

            if Config.DebugMode and distance < cam.detectionRadius then
                DrawMarker(1, cam.coords.x, cam.coords.y, cam.coords.z - 0.5, 0, 0, 0, 0, 0, 0, cam.detectionRadius, cam.detectionRadius, 3.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
            end

            if distance < cam.detectionRadius and speed > cam.speedLimit then
                local jobName = GetPlayerJob()
                local isExempt = Config.ExemptJobs and Config.ExemptJobs[jobName]

                if not isExempt then
                    TriggerServerEvent("speedcamera:FinePlayer", math.floor(convertedSpeed), cam.speedLimit, cam.fineAmount)
                    TriggerEvent("speedcamera:FlashEffect")

                    local lang = Config.Languages[Config.Language] or Config.Languages["en"]
                    if lang.notificationSpeeding then
                        local msg = string.format(lang.notificationSpeeding, math.floor(convertedSpeed), Config.SpeedUnit, cam.speedLimit, Config.SpeedUnit)
                        Notify(msg)
                    end
                end

                Wait(5000)
                break
            end
        end
    end
end)
