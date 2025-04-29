Config = {}

-- Snelheidsunit instellen (km/h of mph)
Config.SpeedUnit = "km/h"  -- Of "mph"

-- De standaardtaal instellen (bijv. "nl" of "en")
Config.Language = "nl"

-- Toon de blips voor camera's
Config.ShowBlips = true

Config.ExemptJobs = { --[Jobs dat niet worden geflitst]
    ["police"] = true,
    ["ambulance"] = true,
    ["mechanic"] = true
}

-- Camera spots configureren
Config.CameraSpots = {
    {
        coords = vector3(256.87, -1034.33, 29.3),  -- Vervang door je eigen coördinaten
        speedLimit = 50,  -- Snelheidslimiet in km/h of mph
        fineAmount = 150,  -- Boetebedrag
        detectionRadius = 35.0,  -- Radius van de detectiezone
    },
    -- Voeg meer camera's toe zoals nodig
}

Config.Languages = {
    en = {
        fineMessage = "📸 You were speeding at %s %s (limit: %s %s). Fine: $%s has been deducted from your bank account.",
        fineCashMessage = "📸 You were speeding at %s %s (limit: %s %s). Fine: $%s has been deducted from your cash.",
        notEnoughMoneyMessage = "📸 You were speeding at %s %s (limit: %s %s). You didn't have enough money. Fine: $%s. Your bank balance is now negative.",
    },
    nl = {
        fineMessage = "📸 Je reed %s %s (limiet: %s %s). Boete: €%s is van je bankrekening afgeschreven.",
        fineCashMessage = "📸 Je reed %s %s (limiet: %s %s). Boete: €%s is contant afgeschreven.",
        notEnoughMoneyMessage = "📸 Je reed %s %s (limiet: %s %s). Je had niet genoeg geld. Boete: €%s. Je bank staat nu negatief.",
    },
    jp = {
        fineMessage = "📸 あなたは %s %s でスピード違反をしました (制限: %s %s)。罰金: ¥%s があなたの銀行口座から差し引かれました。",
        fineCashMessage = "📸 あなたは %s %s でスピード違反をしました (制限: %s %s)。罰金: ¥%s が現金から差し引かれました。",
        notEnoughMoneyMessage = "📸 あなたは %s %s でスピード違反をしました (制限: %s %s)。十分なお金がありませんでした。罰金: ¥%s。銀行口座は現在マイナスです。",
    },
    de = {
        fineMessage = "📸 Du hast mit %s %s (Limit: %s %s) die Geschwindigkeitsbegrenzung überschritten. Strafe: €%s wurde von deinem Bankkonto abgezogen.",
        fineCashMessage = "📸 Du hast mit %s %s (Limit: %s %s) die Geschwindigkeitsbegrenzung überschritten. Strafe: €%s wurde von deinem Bargeld abgezogen.",
        notEnoughMoneyMessage = "📸 Du hast mit %s %s (Limit: %s %s) die Geschwindigkeitsbegrenzung überschritten. Du hattest nicht genug Geld. Strafe: €%s. Dein Bankkonto ist jetzt negativ.",
    },
    zh = {
        fineMessage = "📸 你以 %s %s 超速行驶 (限速: %s %s)。罚款: ¥%s 已从你的银行账户扣除。",
        fineCashMessage = "📸 你以 %s %s 超速行驶 (限速: %s %s)。罚款: ¥%s 已从你的现金中扣除。",
        notEnoughMoneyMessage = "📸 你以 %s %s 超速行驶 (限速: %s %s)。你没有足够的钱。罚款: ¥%s。你的银行账户现在是负数。",
    },
}
