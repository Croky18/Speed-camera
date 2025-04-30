Config = {}

-- Choose your framework: "esx" or "qb"
Config.Framework = "esx"

-- Set speed unit (km/h or mph)
Config.SpeedUnit = "km/h"  -- Of "mph"

-- Choose your language
Config.Language = "en"

-- Show the blips for cameras
Config.ShowBlips = true

Config.ExemptJobs = { --[Jobs that are not flashed]
    ["police"] = true,
    ["ambulance"] = true,
    ["mechanic"] = true
}

--Configure camera spots
Config.CameraSpots = {
    {
        coords = vector3(256.87, -1034.33, 29.3),  -- Replace with your own coordinates
        speedLimit = 50,  -- Speed ​​limit in km/h or mph
        fineAmount = 100,  -- Fine amount
        detectionRadius = 35.0,  -- Radius of the detection zone
    },
    -- Add more cameras as needed
}

Config.Languages = {
    en = {
        fineMessage = "📸 You were speeding at %s %s (limit: %s %s). Fine: $%s has been deducted from your bank account.",
        fineCashMessage = "📸 You were speeding at %s %s (limit: %s %s). Fine: $%s has been deducted from your cash.",
        notEnoughMoneyMessage = "📸 You were speeding at %s %s (limit: %s %s). You didn't have enough money. Fine: $%s. Your bank balance is now negative.",
        notificationSpeeding = "📸 You were caught speeding! %s %s in a %s %s zone.",
        noMoney = "📸 You don't have enough money to pay the fine."
    },
    nl = {
        fineMessage = "📸 Je reed %s %s (limiet: %s %s). Boete: €%s is van je bankrekening afgeschreven.",
        fineCashMessage = "📸 Je reed %s %s (limiet: %s %s). Boete: €%s is contant afgeschreven.",
        notEnoughMoneyMessage = "📸 Je reed %s %s (limiet: %s %s). Je had niet genoeg geld. Boete: €%s. Je bank staat nu negatief.",
        notificationSpeeding = "📸 Je bent geflitst! %s %s in een %s %s zone.",
        noMoney = "📸 Je hebt niet genoeg geld om de boete te betalen."
    },
    de = {
        fineMessage = "📸 Du hast mit %s %s (Limit: %s %s) die Geschwindigkeitsbegrenzung überschritten. Strafe: €%s wurde von deinem Bankkonto abgezogen.",
        fineCashMessage = "📸 Du hast mit %s %s (Limit: %s %s) die Geschwindigkeitsbegrenzung überschritten. Strafe: €%s wurde von deinem Bargeld abgezogen.",
        notEnoughMoneyMessage = "📸 Du hast mit %s %s (Limit: %s %s) die Geschwindigkeitsbegrenzung überschritten. Du hattest nicht genug Geld. Strafe: €%s. Dein Bankkonto ist jetzt negativ.",
        notificationSpeeding = "📸 Du wurdest geblitzt! %s %s in einer %s %s Zone.",
        noMoney = "📸 Sie haben nicht genug Geld, um die Strafe zu bezahlen."
    },
    jp = {
        fineMessage = "📸 あなたは %s %s でスピード違反をしました (制限: %s %s)。罰金: ¥%s があなたの銀行口座から差し引かれました。",
        fineCashMessage = "📸 あなたは %s %s でスピード違反をしました (制限: %s %s)。罰金: ¥%s が現金から差し引かれました。",
        notEnoughMoneyMessage = "📸 あなたは %s %s でスピード違反をしました (制限: %s %s)。十分なお金がありませんでした。罰金: ¥%s。銀行口座は現在マイナスです。",
        notificationSpeeding = "📸 スピード違反で捕まりました！ %s %s (制限: %s %s)",
        noMoney = "📸 罰金を支払うのに十分なお金がありません。"
    },
    zh = {
        fineMessage = "📸 你以 %s %s 超速行驶 (限速: %s %s)。罚款: ¥%s 已从你的银行账户扣除。",
        fineCashMessage = "📸 你以 %s %s 超速行驶 (限速: %s %s)。罚款: ¥%s 已从你的现金中扣除。",
        notEnoughMoneyMessage = "📸 你以 %s %s 超速行驶 (限速: %s %s)。你没有足够的钱。罚款: ¥%s。你的银行账户现在是负数。",
        notificationSpeeding = "📸 你被拍到了！%s %s，限速 %s %s。",
        noMoney = "📸 您沒有足夠的錢來支付罰款。"
    },
}
