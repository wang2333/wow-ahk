function WR_DeathKnight_WA_Trigger2()
    local gcd = 1.5
    local currentTime = GetTime()
    aura_env.HasBuff = function(unit, aura_id)
        local hasBuff = false
        if WR_GetUnitBuffInfo(unit, aura_id, true) then
            hasBuff = true
        end
        return hasBuff
    end
    aura_env.xxlqBuffRemaining = false
    if WR_IsInUnholyPresence(aura_env.xxlq) then
        aura_env.xxlqBuffRemaining = true
    end
    aura_env.xelqBuffRemaining = false
    if WR_IsInUnholyPresence(aura_env.xelq) then
        aura_env.xelqBuffRemaining = true
    end
    -- aura_env.xxlqBuffRemaining = aura_env.HasBuff("player", aura_env.xxlq)
    -- aura_env.xelqBuffRemaining = aura_env.HasBuff("player", aura_env.xelq)
    aura_env.GetBuffRemaining = function(unit, aura_id)
        local buffRemaining = 0
        if WR_GetUnitBuffInfo(unit, aura_id, true) then
            buffRemaining = WR_GetUnitBuffInfo(unit, aura_id, true)
        end
        return buffRemaining
    end
    aura_env.ssgklBuffRemaining = aura_env.GetBuffRemaining("pet", aura_env.ssgkl)
    aura_env.bgzdBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.bgzd)
    aura_env.dlszjBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.dlszj)
    aura_env.hmfBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.hmf)
    aura_env.sxBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.sx)
    aura_env.yyBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.yy)
    aura_env.lmBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.lm)
    aura_env.gjBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.gj)
    aura_env.zdnhBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.zdnh)
    aura_env.nhzsBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.nhzs)
    aura_env.hlflBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.hlfl)
    aura_env.xzqxBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.xzqx)
    aura_env.embxBuffRemaining = aura_env.GetBuffRemaining("player", aura_env.embx)
    aura_env.tzdjBuffRemaining = aura_env.GetBuffRemaining("player", 67383)
    aura_env.GetBuffCount = function(unit, aura_id)
        local buffCount = 0
        local buff, bCount, bSum = WR_GetUnitBuffInfo(unit, aura_id, true)
        if buff then
            buffCount = bCount
        end
        return buffCount
    end
    aura_env.sszczBuffCs = aura_env.GetBuffCount("player", aura_env.sszcz)
    aura_env.aygzBuffCs = aura_env.GetBuffCount("pet", aura_env.aygz)
    aura_env.GetDebuffRemaining = function(unit, aura_id)
        local DebuffRemaining = 0
        if WR_GetUnitDebuffInfo(unit, aura_id, true) then
            DebuffRemaining = WR_GetUnitDebuffInfo(unit, aura_id, true)
        end
        return DebuffRemaining
    end
    aura_env.bsybDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.bsyb)
    aura_env.xzybDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.xzyb)
    aura_env.zmgyDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.zmgy)
    aura_env.lryjDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.lryj)
    aura_env.fssDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.fss)
    aura_env.tkzhDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.tkzh)
    aura_env.mrzhDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.mrzh)
    aura_env.yszzDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.yszz)
    aura_env.xrzzDEBuffRemaining = aura_env.GetDebuffRemaining("target", aura_env.xrzz)
    aura_env.GetCooldownRemaining = function(spell_id)
        local start, duration = GetSpellCooldown(spell_id)
        if duration and duration > gcd then
            return max(start + duration - currentTime, 0)
        else
            return 0
        end
    end
    aura_env.zhsxgCDRemaining = aura_env.GetCooldownRemaining(aura_env.zhsxg)
    aura_env.bgzdCDRemaining = aura_env.GetCooldownRemaining(aura_env.bgzd)
    aura_env.kwdlCDRemaining1 = aura_env.GetCooldownRemaining(aura_env.kwdl)
    aura_env.fwwqzxCDRemaining = aura_env.GetCooldownRemaining(aura_env.fwwqzx)
    aura_env.ssgklCDRemaining = aura_env.GetCooldownRemaining(aura_env.ssgkl)
    aura_env.hlflCDRemaining = aura_env.GetCooldownRemaining(aura_env.hlfl)
    aura_env.hdhjCDRemaining = aura_env.GetCooldownRemaining(aura_env.hdhj)
    local wzdjStart = 0
    local wzdjDuration = 0
    local wzdjCDRemaining = 0
    if aura_env.wzdj then
        wzdjStart, wzdjDuration = GetSpellCooldown(aura_env.wzdj)
        if wzdjDuration and wzdjDuration > 30 then
            wzdjCDRemaining = max(wzdjStart + wzdjDuration - currentTime, 0)
            if not (wzdjDuration > gcd) then
                wzdjCDRemaining = 0
            end
        end
    end
    aura_env.wzdjCDRemaining = wzdjCDRemaining
    local kwdlStart = 0
    local kwdlDuration = 0
    local kwdlCDRemaining = 0
    if aura_env.kwdl then
        kwdlStart, kwdlDuration = GetSpellCooldown(aura_env.kwdl)
        if kwdlDuration and kwdlDuration == 15 then
            aura_env.fixedStart = kwdlStart
            aura_env.fixedDuration = kwdlDuration
        end
        if aura_env.fixedStart and currentTime < aura_env.fixedStart + aura_env.fixedDuration then
            kwdlCDRemaining = max(aura_env.fixedStart + aura_env.fixedDuration - currentTime, 0)
        else
            aura_env.fixedStart = nil
        end
    end
    aura_env.kwdlCDRemaining = kwdlCDRemaining
    local hmfName = aura_env.config.hmfName or 0
    local szjName = aura_env.config.szjName or 0
    local itemName = 0
    local slotId = 17
    local itemLink = GetInventoryItemLink("player", slotId)
    if itemLink then
        itemName = GetItemInfo(itemLink)
    end
    aura_env.GetRuneCooldownRemaining = function(runeIndex)
        local runeStart, runeDuration, runeReady = GetRuneCooldown(runeIndex)
        local runeCDRemaining = 0
        if runeDuration and runeStart then
            runeCDRemaining = max(runeStart + runeDuration - currentTime, 0)
        end
        return runeCDRemaining
    end
    aura_env.rune1CDRemaining = aura_env.GetRuneCooldownRemaining(1)
    aura_env.rune2CDRemaining = aura_env.GetRuneCooldownRemaining(2)
    aura_env.rune3CDRemaining = aura_env.GetRuneCooldownRemaining(3)
    aura_env.rune4CDRemaining = aura_env.GetRuneCooldownRemaining(4)
    aura_env.rune5CDRemaining = aura_env.GetRuneCooldownRemaining(5)
    aura_env.rune6CDRemaining = aura_env.GetRuneCooldownRemaining(6)
    aura_env.rune1ok = false
    if aura_env.rune1CDRemaining and aura_env.rune2CDRemaining and
        (aura_env.rune1CDRemaining - aura_env.rune2CDRemaining >= -2) then
        aura_env.rune1ok = true
    end
    aura_env.GetRuneTypeCount = function(runeType)
        local count = 0
        for i = 1, 6 do
            local runeTypeOfRune = GetRuneType(i)
            local _, _, runeReady = GetRuneCooldown(i)
            if runeTypeOfRune == runeType and runeReady then
                count = count + 1
            end
        end
        return count
    end
    aura_env.swfw = aura_env.GetRuneTypeCount(4)
    aura_env.bsfw = aura_env.GetRuneTypeCount(2)
    aura_env.xxfw = aura_env.GetRuneTypeCount(1)
    aura_env.xefw = aura_env.GetRuneTypeCount(3)
    aura_env.fwsl = aura_env.swfw + aura_env.bsfw + aura_env.xxfw + aura_env.xefw
    aura_env.fwnl = UnitPower("player")
    local petType = nil
    if UnitExists("pet") then
        petType = UnitCreatureFamily("pet")
    end
    aura_env.maxbsCD = aura_env.getMaxRuneCooldown(5, 6)
    aura_env.maxxeCD = aura_env.getMaxRuneCooldown(3, 4)
    aura_env.maxxxCD = aura_env.getMaxRuneCooldown(1, 2)
    aura_env.minbsCD = aura_env.getMinRuneCooldown(5, 6)
    aura_env.minxeCD = aura_env.getMinRuneCooldown(3, 4)
    aura_env.minxxCD = aura_env.getMinRuneCooldown(1, 2)
    aura_env.count = 0
    for i = 1, 40 do
        local unit = "nameplate" .. i
        if not UnitIsDead(unit) and UnitCanAttack("player", unit) and not UnitIsUnit("target", unit) then
            local unitName = UnitName(unit)
            local isExcluded = false
            for _, excludedName in ipairs(aura_env.excludeTargets) do
                if unitName == excludedName then
                    isExcluded = true
                    break
                end
            end
            if not isExcluded and WR_GetUnitRange(unit) <= 10 then
                aura_env.count = aura_env.count + 1
            end
        end
    end
    aura_env.count2 = 0
    for i = 1, 40 do
        local unit = "nameplate" .. i
        if not UnitIsDead(unit) and UnitCanAttack("player", unit) and not UnitIsUnit(unit, "target") then
            local unitName = UnitName(unit)
            local isExcluded = false
            for _, excludedName in ipairs(aura_env.excludeTargets) do
                if unitName == excludedName then
                    isExcluded = true
                    break
                end
            end
            if not isExcluded and WR_GetUnitRange(unit) <= 10 then
                local bsyb2DEBuffRemaining = 0
                if WR_GetUnitDebuffInfo(unit, aura_env.bsyb, true) then
                    bsyb2DEBuffRemaining = WR_GetUnitDebuffInfo(unit, aura_env.bsyb, true)
                end
                if bsyb2DEBuffRemaining <= 5 then
                    aura_env.count2 = aura_env.count2 + 1
                end
            end
        end
    end
end
