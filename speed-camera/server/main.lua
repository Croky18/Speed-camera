local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("speedcamera:FinePlayer", function(speed, limit, fine)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local bank = Player.Functions.GetMoney("bank")
    local cash = Player.Functions.GetMoney("cash")

    -- Haal de taal op uit de configuratie, met fallback
    local language = Config.Language or "en"  -- Standaard naar Engels als Config.Language niet bestaat
    local lang = Config.Languages[language] or Config.Languages["en"]  -- Fallback naar Engels

    -- Controleer of er genoeg geld op de bank is
    if bank >= fine then
        Player.Functions.RemoveMoney("bank", fine, "speedcamera-fine")
        TriggerClientEvent("QBCore:Notify", src, 
            string.format(lang.fineMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")

    -- Als er niet genoeg op de bank is, kijk of er contant geld is
    elseif cash >= fine then
        Player.Functions.RemoveMoney("cash", fine, "speedcamera-fine")
        TriggerClientEvent("QBCore:Notify", src, 
            string.format(lang.fineCashMessage, speed, Config.SpeedUnit, limit, Config.SpeedUnit, fine), "error")

    -- Als er niet genoeg geld is, zet de bank in de negatieve balans en het resterende bedrag op de bank
    else
        -- Niet genoeg geld, dus trek alles van bank en cash af
        local tekort = fine - (bank + cash) -- Resterend tekort na het aftrekken van cash en bankbedrag
        Player.Functions.RemoveMoney("bank", bank, "speedcamera-fine") -- Haal alles van bank
        Player.Functions.RemoveMoney("cash", cash, "speedcamera-fine") -- Haal alles van cash

        -- Voeg het resterende bedrag toe als negatieve balans op de bank
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
        return -- job is vrijgesteld van boetes
    end

    Player.Functions.RemoveMoney("bank", fine, "Speedcamera fine")
end)
