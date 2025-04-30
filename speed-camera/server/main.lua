local QBCore, ESX
if Config.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    ESX = exports['es_extended']:getSharedObject()
end

RegisterNetEvent("speedcamera:FinePlayer", function(speed, limit, fine)
    local src = source
    local lang = Config.Languages[Config.Language] or Config.Languages["en"]

    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end

        local bank = Player.Functions.GetMoney("bank")
        local cash = Player.Functions.GetMoney("cash")

        if bank >= fine then
            Player.Functions.RemoveMoney("bank", fine, "speedcamera-fine")
            TriggerClientEvent("QBCore:Notify", src, string.format(lang.fineMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")
        elseif cash >= fine then
            Player.Functions.RemoveMoney("cash", fine, "speedcamera-fine")
            TriggerClientEvent("QBCore:Notify", src, string.format(lang.fineCashMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")
        else
            Player.Functions.RemoveMoney("bank", bank, "speedcamera-fine")
            Player.Functions.RemoveMoney("cash", cash, "speedcamera-fine")
            local tekort = fine - (bank + cash)
            Player.Functions.AddMoney("bank", -tekort, "speedcamera-schuld")
            TriggerClientEvent("QBCore:Notify", src, string.format(lang.notEnoughMoneyMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")
        end

    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then return end
    
        local bank = xPlayer.getAccount("bank").money
        local money = xPlayer.getMoney()
    
        if bank >= fine then
            xPlayer.removeAccountMoney("bank", fine)
            TriggerClientEvent("esx:showNotification", src,
                string.format(lang.fineMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine))
        elseif money >= fine then
            xPlayer.removeMoney(fine)
            TriggerClientEvent("esx:showNotification", src,
                string.format(lang.fineMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine))
        else
            TriggerClientEvent("esx:showNotification", src, lang.noMoney)
        end
    end
end)
