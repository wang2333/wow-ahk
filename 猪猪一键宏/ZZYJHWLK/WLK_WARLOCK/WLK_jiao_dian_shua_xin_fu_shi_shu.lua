if UnitClassBase("player")~="WARLOCK" then
    
    return
end

lastBaifenbiplus2 = nil
nameplate2 = {}
lastSpellPower2 = {}
for i = 1, 40 do
    lastSpellPower2[i] = 0
end
NPBaifenbiplus2 = {}
for i = 1, 40 do
    nameplate2[i] = "nameplate" .. i
    NPBaifenbiplus2[i] = 0
end

function quanzhong2()
    if not UnitAffectingCombat("player") then
        for i = 1, 40 do
            NPBaifenbiplus2[i] = 0
        end
    end
    local currentBaifenbiplus
    local baoji = GetSpellCritChance(6)
    for i = 1, 60 do
        local _, _, _, _, _, _, _, _, _, spellId = UnitDebuff("focus", i)
        if not spellId then break end
        if spellId == 22959 or spellId == 17800 then
            baoji = baoji + 5
        end
        if spellId == 54499 then
            baoji = baoji + 3
        end
    end
    local _, _, _, _, _, _, varmodapplied = UnitDamage("player")
    local mod = varmodapplied
    local maxHP = UnitHealthMax("focus")
    local curHP = UnitHealth("focus")
    local perHP = 0
    if maxHP and maxHP > 0 then
        perHP = curHP * 100 / maxHP
    end
    if perHP <= 35 then mod = mod + 0.12 end
    currentBaifenbiplus = (100 * mod) * (100 - baoji) / 100 + (100 * mod * 2) * (baoji / 100)
    return currentBaifenbiplus
end

local TempFrame = CreateFrame("Frame")
TempFrame:SetScript("OnEvent", function()
        local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName = CombatLogGetCurrentEventInfo()
        if subevent == "SPELL_MISSED" then
            return false
        end
        if subevent == "SPELL_CAST_SUCCESS" and spellName == "腐蚀术" and sourceName == UnitName("player") then
            for i = 1, 40 do
                if UnitGUID(nameplate2[i]) == destGUID then
                    NPBaifenbiplus2[i] = quanzhong2()
                    lastSpellPower2[i] = GetSpellBonusDamage(6)
                end
            end
        end
        if subevent == "SPELL_DAMAGE" and (spellName == "暗影箭" or spellName == "鬼影缠身" or spellName == "吸取生命" or spellName == "吸取灵魂") and sourceName == UnitName("player") then
            for i = 1, 40 do
                if UnitGUID(nameplate2[i]) == destGUID then
                    lastSpellPower2[i] = GetSpellBonusDamage(6)
                    break
                end
            end
        end
end)
TempFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")


