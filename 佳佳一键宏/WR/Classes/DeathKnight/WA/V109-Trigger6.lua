-- COMBAT_LOG_EVENT_UNFILTERED
function WR_DeathKnight_WA_Trigger6_1()
    local inCombat = UnitAffectingCombat("player")
    local _, _, _, _, xelq = GetTalentInfo(3, 18)
    local _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    local _, subevent, _, sourceGUID, _, _, _, destGUID, destName, _, _, spellID, spellname, _, amount =
        CombatLogGetCurrentEventInfo()
    if subevent == "SPELL_CAST_START" and spellname == "重型撞击" then
        aura_env.bhys = true
    end
    if subevent == "SPELL_AURA_REMOVED" and spellname == "重击眩晕" then
        aura_env.bhys = false
    end
    if (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and sourceGUID == UnitGUID("player") and spellName ==
        aura_env.blcm then
        aura_env.bsxz = aura_env.bsxz + 1
        aura_env.xexl = true
        aura_env.bsxl = false
        aura_env.xxxl = true
    end
    if (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and sourceGUID == UnitGUID("player") and spellName ==
        aura_env.tzdj then
        aura_env.bsxz = aura_env.bsxz + 1
        aura_env.xexz = aura_env.xexz + 1
        aura_env.xexl = false
        aura_env.bsxl = false
        aura_env.xxxl = true
    end
    if sourceGUID == UnitGUID("player") then
        if subEvent == "SPELL_CAST_SUCCESS" and spellName == aura_env.wzdj and aura_env.djsfdl == 1 then
            aura_env.bsxz = aura_env.bsxz + 1
            aura_env.xexz = aura_env.xexz + 1
            aura_env.xxxz = aura_env.xxxz + 1
        end
    end
    if sourceGUID == UnitGUID("player") and (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and spellName ==
        aura_env.aydj and aura_env.hlflBuffRemaining <= 17 then
        aura_env.xexz = aura_env.xexz + 1
        aura_env.xxxl = true
        aura_env.xexl = false
        aura_env.bsxl = false
    end
    if sourceGUID == UnitGUID("player") and subEvent == "SPELL_CAST_SUCCESS" and spellName == aura_env.ssgkl and
        aura_env.hlflBuffRemaining <= 17 then
        aura_env.xexz = aura_env.xexz + 1
        aura_env.xxxl = true
        aura_env.xexl = false
        aura_env.bsxl = false
    end
    if sourceGUID == UnitGUID("player") and subEvent == "SPELL_CAST_SUCCESS" and spellName == aura_env.xelq and
        aura_env.hlflBuffRemaining <= 17 then
        aura_env.xexz = aura_env.xexz + 1
        aura_env.xxxl = true
        aura_env.xexl = false
        aura_env.bsxl = false
    end
    if sourceGUID == UnitGUID("player") and (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and spellName ==
        aura_env.xxdj then
        aura_env.xxxz = aura_env.xxxz + 1
        aura_env.bsxl = true
        aura_env.xxxl = false
        aura_env.xexl = false
    end
    if sourceGUID == UnitGUID("player") and subEvent == "SPELL_CAST_SUCCESS" and spellName == aura_env.xyft then
        aura_env.xxxz = aura_env.xxxz + 1
        aura_env.bsxl = true
        aura_env.xxxl = false
        aura_env.xexl = false
        Isxe = aura_env.xe
        Ishy = aura_env.hy
        if Ishy and Isxe then
            aura_env.getspellcd(Isxe, Ishy)
        end
    end
    if sourceGUID == UnitGUID("player") and subEvent == "SPELL_CAST_SUCCESS" and spellName == aura_env.cr then
        aura_env.xxxz = aura_env.xxxz + 1
        aura_env.bsxl = true
        aura_env.xxxl = false
        aura_env.xexl = false
    end
    if sourceGUID == UnitGUID("player") and subEvent == "SPELL_CAST_SUCCESS" and spellName == aura_env.xxlq then
        aura_env.xxxz = aura_env.xxxz + 1
        aura_env.bsxl = true
        aura_env.xxxl = false
        aura_env.xexl = false
    end
    if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and spellName == aura_env.kwdl and xelq > 0 then
        if (aura_env.xxxz + aura_env.xexz + aura_env.bsxz) > 4 and (aura_env.xxxz + aura_env.xexz + aura_env.bsxz) <= 6 then
            aura_env.xz = 3
            aura_env.bsxz = 0
            aura_env.xexz = 0
            aura_env.xxxz = 0
        elseif (aura_env.xxxz + aura_env.xexz + aura_env.bsxz) > 6 then
            aura_env.xz = 2
            aura_env.bsxz = 0
            aura_env.xexz = 0
            aura_env.xxxz = 0
        end
        aura_env.bsxl = true
    end
    if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and spellName == aura_env.kwdl and xelq <=
        0 then
        aura_env.xz = 2
        aura_env.bsxz = 0
        aura_env.xexz = 0
        aura_env.xxxz = 0
        aura_env.bsxl = true
    end
    if (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and sourceGUID == UnitGUID("player") and
        (spellName == aura_env.blcm or spellName == aura_env.tzdj) and inCombat then
        if aura_env.xxxz == 0 and aura_env.gjBuffRemaining < 5 then
            aura_env.xxdjdl = true
            aura_env.xyftdl = false
        elseif aura_env.xxxz == 1 and aura_env.gjBuffRemaining < 9 then
            aura_env.xxdjdl = true
            aura_env.xyftdl = false
        else
            aura_env.xxdjdl = false
            aura_env.xyftdl = true
        end
    end
    if (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and sourceGUID == UnitGUID("player") and spellName ==
        aura_env.blcm and inCombat then
        if aura_env.xzybDEBuffRemaining > (aura_env.ssgklBuffRemaining + 5) and
            (aura_env.msqh == "dt" or (aura_env.msqh ~= "qt" and aura_env.count < 1)) and UnitExists("pet") then
            aura_env.aydjdl = false
            aura_env.kldl = true
        else
            aura_env.aydjdl = true
            aura_env.kldl = false
        end
    end
    if (subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_ABSORBED") and sourceGUID == UnitGUID("player") and
        (spellName == aura_env.xxdj or spellName == aura_env.xyft) and inCombat then
        local jbmin = math.min(aura_env.bsybDEBuffRemaining, aura_env.xzybDEBuffRemaining)
        if jbmin >= 9 and (aura_env.tzdjBuffRemaining < jbmin) and
            (aura_env.ssgklBuffRemaining > 5 or aura_env.hlflCDRemaining <= 25 or
                (aura_env.msqh == "qt" or (aura_env.msqh ~= "dt" and aura_env.count >= 1))) then
            aura_env.blcmdl = false
            aura_env.tzdjdl = true
        else
            aura_env.blcmdl = true
            aura_env.tzdjdl = false
        end
    end
    if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and
        (spellName == aura_env.cr or spellName == aura_env.xxlq) and inCombat then
        local jbmin = math.min(aura_env.bsybDEBuffRemaining, aura_env.xzybDEBuffRemaining)
        if jbmin >= 9 and (aura_env.tzdjBuffRemaining < jbmin) and
            (aura_env.ssgklBuffRemaining > 5 or aura_env.hlflCDRemaining <= 25 or
                (aura_env.msqh == "qt" or (aura_env.msqh ~= "dt" and aura_env.count >= 1))) then
            aura_env.blcmdl = false
            aura_env.tzdjdl = true
        else
            aura_env.blcmdl = true
            aura_env.tzdjdl = false
        end
    end
    if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and spellName == aura_env.kwdl and inCombat then
        local jbmin = math.min(aura_env.bsybDEBuffRemaining, aura_env.xzybDEBuffRemaining)
        if jbmin >= 7 and (aura_env.tzdjBuffRemaining < jbmin) and
            (aura_env.ssgklBuffRemaining > 5 or aura_env.hlflCDRemaining <= 20) then
            aura_env.blcmdl = false
            aura_env.tzdjdl = true
        else
            aura_env.blcmdl = true
            aura_env.tzdjdl = false
        end
    end
    if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and spellName == aura_env.fwwqzx and
        inCombat then
        aura_env.bsxz = aura_env.bsxz - 1
        aura_env.xexz = aura_env.xexz - 1
        aura_env.xxxz = aura_env.xxxz - 1
        aura_env.xexl = true
        aura_env.bsxl = true
        aura_env.xxxl = true
    end
end
-- PLAYER_REGEN_DISABLED
function WR_DeathKnight_WA_Trigger6_2()
    aura_env.xexz = 0
    aura_env.xxxz = 0
    aura_env.xz = 2
    aura_env.xexl = true
    -- aura_env.bsxl = true
    aura_env.xxxl = true
    aura_env.xxdjdl = true
    aura_env.xyftdl = true
    aura_env.crdl = true
    aura_env.aydjdl = true
    aura_env.kldl = true
    aura_env.xldl = true
    aura_env.aydjsl = 0
    aura_env.swbj = 0
    aura_env.tzdjdl = false
end
-- PLAYER_REGEN_ENABLED
function WR_DeathKnight_WA_Trigger6_3()
    aura_env.xexz = 0
    aura_env.bsxz = 0
    aura_env.xxxz = 0
    aura_env.xz = 2
    aura_env.xexl = true
    aura_env.bsxl = true
    aura_env.xxxl = true
    aura_env.xxdjdl = true
    aura_env.xyftdl = true
    aura_env.crdl = true
    aura_env.aydjdl = true
    aura_env.kldl = true
    aura_env.xldl = true
    aura_env.aydjsl = 0
    aura_env.swbj = 0
    aura_env.tzdjdl = false
end
-- PLAYER_TARGET_CHANGED
function WR_DeathKnight_WA_Trigger6_4()
    aura_env.xexl = true
    aura_env.bsxl = true
    aura_env.xxxl = true
    aura_env.xxdjdl = true
    aura_env.xyftdl = true
    aura_env.crdl = true
    aura_env.aydjdl = true
    aura_env.kldl = true
    aura_env.xldl = true
    aura_env.aydjsl = 0
end
