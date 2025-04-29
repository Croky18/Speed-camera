local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("speedcamera:FinePlayer", function(speed, limit, fine)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local bank = Player.Functions.GetMoney("bank")
    local cash = Player.Functions.GetMoney("cash")

    local language = Config.Language or "en"
    local lang = Config.Languages[language] or Config.Languages["en"]

    if bank >= fine then
        Player.Functions.RemoveMoney("bank", fine, "speedcamera-fine")
        TriggerClientEvent("QBCore:Notify", src, 
            string.format(lang.fineMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")

    elseif cash >= fine then
        Player.Functions.RemoveMoney("cash", fine, "speedcamera-fine")
        TriggerClientEvent("QBCore:Notify", src, 
            string.format(lang.fineCashMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")

    else
        local tekort = fine - (bank + cash)
        Player.Functions.RemoveMoney("bank", bank, "speedcamera-fine")
        Player.Functions.RemoveMoney("cash", cash, "speedcamera-fine")

        local bankBalance = Player.Functions.GetMoney("bank")
        Player.Functions.AddMoney("bank", -tekort, "speedcamera-schuld")

        TriggerClientEvent("QBCore:Notify", src, 
            string.format(lang.notEnoughMoneyMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")
    end
end)

RegisterNetEvent("speedcamera:FinePlayer", function(currentSpeed, limit, fine)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local job = Player.PlayerData.job.name
    if Config.ExemptJobs and Config.ExemptJobs[job] then
        return
    end

    Player.Functions.RemoveMoney("bank", fine, "Speedcamera fine")
end)
