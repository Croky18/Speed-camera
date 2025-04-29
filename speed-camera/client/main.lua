local QBCore = exports['qb-core']:GetCoreObject()
local spawnedCameras = {}

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
    if Config.SpeedUnit == "mph" then
        return speed * 0.621371
    else
        return speed
    end
end

RegisterNetEvent("speedcamera:FlashEffect", function()
    StartScreenEffect("SwitchHUDIn", 0, false)
    Wait(300)
    StopScreenEffect("SwitchHUDIn")
end)

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
                DrawMarker(1, cam.coords.x, cam.coords.y, cam.coords.z - 0.5, 0.0, 0.0, 0.0, cam.detectionRadius, cam.detectionRadius, 3.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)
            end

            if distance < cam.detectionRadius and speed > cam.speedLimit then
                local PlayerData = QBCore.Functions.GetPlayerData()
                local jobName = "unemployed"
                if PlayerData and PlayerData.job and PlayerData.job.name then
                    jobName = PlayerData.job.name
                end

                local isExempt = false
                if Config.ExemptJobs and type(Config.ExemptJobs) == "table" then
                    isExempt = Config.ExemptJobs[jobName] == true
                end

                if not isExempt then
                    TriggerServerEvent("speedcamera:FinePlayer", math.floor(convertedSpeed), cam.speedLimit, cam.fineAmount)
                    TriggerEvent("speedcamera:FlashEffect")

                    local lang = Config.Languages[Config.Language]
                    if not lang then
                        print("Fout: Taal niet gevonden: " .. tostring(Config.Language))
                        lang = Config.Languages["en"]
                    end

                    if lang and lang.notificationSpeeding then
                        local msg = string.format(lang.notificationSpeeding, math.floor(convertedSpeed), Config.SpeedUnit, cam.speedLimit, Config.SpeedUnit)
                        QBCore.Functions.Notify(msg, "error")
                    end
                end

                Wait(5000)
                break
            end
        end
    end
end)
