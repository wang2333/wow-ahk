if UnitClassBase("player")~="PRIEST" then
    return
end

lastBaifenbiplus = nil
nameplate={}
NPBaifenbiplus={}
for i=1,40,1
do
    nameplate[i]="nameplate"..i
    NPBaifenbiplus[i]=0
end

function quanzhong()
    if not(UnitAffectingCombat("player")) then
        for i=1,40,1
        do
            NPBaifenbiplus[i]=0
        end
    end
    local currentBaifenbiplus
    local baoji = GetSpellCritChance(6)
    for i = 1, 60 do
        local _, _, _, _, _, _, _, _, _, spellId = UnitDebuff("target", i)
        if not spellId then break end
        if spellId == 22959 or spellId == 17800 then
            baoji = baoji + 5
        end
        if spellId == 54499 then
            baoji = baoji + 3
        end
    end
    local _, _, _, _, _, _, baifenbi = UnitDamage("player")
    for i = 1, 60 do
        local _, _, count, _, _, _, _, _, _, spellId = UnitBuff("player", i)
        if not spellId then break end
        if spellId == 15258 then
            baifenbi = baifenbi + (0.02 * count)
        end
    end
    currentBaifenbiplus = (100 * baifenbi) * (100-baoji)/100+(100*baifenbi*2)*(baoji/100) 
    return currentBaifenbiplus
end

local TempFrame = CreateFrame("Frame")
TempFrame:SetScript("OnEvent", function()
        local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName = CombatLogGetCurrentEventInfo()
        if subevent == "SPELL_MISSED" then
            return false
        end
        if subevent == "SPELL_CAST_SUCCESS" and spellName == "暗言术：痛" and sourceName == UnitName("player") then
            for i=1,40,1
            do
                if UnitGUID(nameplate[i])==destGUID then
                    NPBaifenbiplus[i]=quanzhong()
                end
            end
        end
end)
TempFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

