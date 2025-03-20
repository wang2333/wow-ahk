function WR_DeathKnight_WA_Trigger9()
    -- local inCombat = UnitAffectingCombat("player")
    -- local hasTarget = UnitExists("target") and UnitCanAttack("player", "target")
    -- local targetHealth = hasTarget and UnitHealth("target") > 0
    -- if aura_env.config.hmf then
    --     WeakAuras.ScanEvents("SPELL_20_READY_XEDK", aura_env.hmfName, aura_env.szjName)
    -- else
    --     WeakAuras.ScanEvents("SPELL_20_CANCEL_XEDK", true)
    -- end
    -- if not targetHealth then
    --     for i = 1, 30 do
    --         WeakAuras.ScanEvents("SPELL_" .. i .. "_CANCEL_XEDK", true)
    --     end
    --     return
    -- end
    local currentTime = GetTime()
    aura_env.hmfName = aura_env.config.hmfName or 0
    aura_env.szjName = aura_env.config.szjName or 0
    local itemName = 0
    local slotId = 17
    local itemLink = GetInventoryItemLink("player", slotId)
    if itemLink then
        itemName = GetItemInfo(itemLink)
        aura_env.itemName = itemName
    end
    aura_env.fwnl = UnitPower("player", 6)
    -- if not aura_env.int then
    --     local ad = WeakAuras.GetData(aura_env.id)
    --     if ad and ad.parent then
    --         local pd = WeakAuras.GetData(ad.parent)
    --         if pd then
    --             aura_env.gn = pd.id
    --             aura_env.int = true
    --         end
    --     end
    -- end
    -- if #aura_env.cct1 > 0 then
    --     aura_env.cct = 2
    -- else
    --     aura_env.cct = nil
    -- end
    -- if string.find(aura_env.gn, aura_env.UnitAffectingC) then
    --     aura_env.mzzqBuffRemaining = 2
    -- elseif not string.find(aura_env.gn, aura_env.UnitAffectingC) then
    --     if bsybDEBuffRemaining > 0 then
    --         for i = 1, 20 do
    --             WeakAuras.ScanEvents("SPELL_" .. i .. "_CANCEL_XEDK", true)
    --             aura_env.cCF("Details", aura_env.tCo)
    --         end
    --         return
    --     end
    -- end
    local _, _, _, _, xelq = GetTalentInfo(3, 18)
    aura_env.targetHealthPercent = UnitHealth("target") / UnitHealthMax("target") * 100
    aura_env.hmfSPCD = aura_env.GetSPCooldownRemaining(59626, 45)
    local bcky = false
    if aura_env.bsxz < aura_env.xz and aura_env.bsxl == true and aura_env.blcmdl == true then
        bcky = true
    end
    local tzdjky = false
    if aura_env.bsxz < aura_env.xz and aura_env.bsxl == true and aura_env.tzdjdl == true then
        tzdjky = true
    end
    local aydjky = false
    if aura_env.xexz < aura_env.xz and aura_env.aydjdl == true and aura_env.xexl == true then
        aydjky = true
    end
    local ssgklky = false
    if aura_env.xexz < aura_env.xz and aura_env.kldl == true and aura_env.xexl == true then
        ssgklky = true
    end
    local xelqky = false
    if aura_env.xexz < aura_env.xz and aura_env.xexl == true then
        xelqky = true
    end
    local xxdjky = false
    if aura_env.xxxz < aura_env.xz and aura_env.xxdjdl == true and aura_env.xxxl == true then
        xxdjky = true
    end
    local xxlqky = false
    if aura_env.xxxz < aura_env.xz and aura_env.xxxl == true then
        xxlqky = true
    end
    local crky = false
    if aura_env.xxxz < aura_env.xz and aura_env.xxxl == true then
        crky = true
    end
    local xyftky = false
    if aura_env.xxxz < aura_env.xz and aura_env.xyftdl == true and aura_env.xxxl == true then
        xyftky = true
    end
    Isxe = aura_env.xe
    Ishy = aura_env.hy
    local isBoss = UnitLevel("target") == -1
    if aura_env.bsfw >= 1 and aura_env.fwnl <= 110 and bcky == true and aura_env.djsfdl == 0 then
        -- WeakAuras.ScanEvents("SPELL_1_READY_XEDK", true)
        table.insert(SpellValue, 1)
    elseif aura_env.djsfdl == 1 and aura_env.bsfw == 2 and aura_env.kwdlCDRemaining > 0 and aura_env.tzdjBuffRemaining >
        0 and aura_env.fwnl <= 110 then
        -- WeakAuras.ScanEvents("SPELL_1_READY_XEDK", true)
        table.insert(SpellValue, 1)
    elseif aura_env.djsfdl == 0 and aura_env.bsfw == 2 and aura_env.fwnl <= 110 and aura_env.kwdlCDRemaining > 0 then
        -- WeakAuras.ScanEvents("SPELL_1_READY_XEDK", true)
        table.insert(SpellValue, 1)
    else
        -- WeakAuras.ScanEvents("SPELL_1_CANCEL_XEDK", true)
    end
    if aura_env.bsfw >= 1 and aura_env.xefw >= 1 and aura_env.fwnl <= 110 and tzdjky == true then
        -- WeakAuras.ScanEvents("SPELL_22_READY_XEDK", true)
        table.insert(SpellValue, 22)
        aura_env.tzdj1 = true
    elseif aura_env.bsfw == 2 and aura_env.xefw == 2 and aura_env.djsfdl == 1 and aura_env.fwnl <= 110 and
        aura_env.tzdjBuffRemaining <= 0 and aura_env.zhsxgCDRemaining <= 0 then
        -- WeakAuras.ScanEvents("SPELL_22_READY_XEDK", true)
        table.insert(SpellValue, 22)
        aura_env.tzdj1 = true
    else
        -- WeakAuras.ScanEvents("SPELL_22_CANCEL_XEDK", true)
        aura_env.tzdj1 = false
    end
    if aura_env.xefw >= 1 and aura_env.djsfdl == 0 and aura_env.fwnl <= 110 and aydjky == true and aura_env.tzdj1 ==
        false then
        -- WeakAuras.ScanEvents("SPELL_2_READY_XEDK", true)
        table.insert(SpellValue, 2)
    elseif aura_env.djsfdl == 1 and aura_env.xefw == 2 and aura_env.fwnl <= 110 and aura_env.kwdlCDRemaining > 0 and
        aura_env.tzdjBuffRemaining > 0 and aura_env.tzdj1 == false then
        -- WeakAuras.ScanEvents("SPELL_2_READY_XEDK", true)
        table.insert(SpellValue, 2)
    elseif aura_env.djsfdl == 0 and aura_env.xefw == 2 and aura_env.fwnl <= 110 and aura_env.tzdj1 == false and
        aura_env.kwdlCDRemaining > 0 then
        -- WeakAuras.ScanEvents("SPELL_2_READY_XEDK", true)
        table.insert(SpellValue, 2)
    else
        -- WeakAuras.ScanEvents("SPELL_2_CANCEL_XEDK", true)
    end
    if aura_env.xefw >= 1 and ssgklky == true and aura_env.djsfdl == 0 then
        -- WeakAuras.ScanEvents("SPELL_11_READY_XEDK", true)
        table.insert(SpellValue, 11)
    elseif aura_env.swfw == 1 and aura_env.xefw == 0 and UnitExists("pet") and aura_env.hlflBuffRemaining > 18 then
        -- WeakAuras.ScanEvents("SPELL_11_READY_XEDK", true)
        table.insert(SpellValue, 11)
    else
        -- WeakAuras.ScanEvents("SPELL_11_CANCEL_XEDK", true)
    end
    if aura_env.xefw >= 1 and aura_env.xelqBuffRemaining == false and (aura_env.zhsxgCDRemaining > 150 or
        (aura_env.zhsxgCDRemaining <= 0 and (aura_env.tgbf1 == true or aura_env.tgbf2 == true))) and xelqky == true then
        -- WeakAuras.ScanEvents("SPELL_16_READY_XEDK", true)
        table.insert(SpellValue, 16)
    else
        -- WeakAuras.ScanEvents("SPELL_16_CANCEL_XEDK", true)
    end
    if (aura_env.msqh == "dt" or (aura_env.msqh ~= "qt" and aura_env.count < 1)) and
        (aura_env.xxfw >= 1 or (aura_env.swfw >= 1 and aura_env.hlflBuffRemaining <= 18)) and aura_env.djsfdl == 0 and
        aura_env.fwnl <= 110 and xxdjky == true then
        -- WeakAuras.ScanEvents("SPELL_3_READY_XEDK", true)
        table.insert(SpellValue, 3)
    elseif (aura_env.msqh == "qt" or (aura_env.msqh ~= "dt" and aura_env.count >= 1)) and
        (aura_env.xxfw >= 1 or (aura_env.swfw >= 1 and aura_env.hlflBuffRemaining <= 18)) and aura_env.djsfdl == 0 and
        aura_env.fwnl <= 110 and aura_env.count2 <= 0 and xxdjky == true then
        -- WeakAuras.ScanEvents("SPELL_3_READY_XEDK", true)
        table.insert(SpellValue, 3)
    elseif aura_env.djsfdl == 1 and (aura_env.xxfw == 2 or ((aura_env.xxfw + aura_env.swfw) == 2)) and
        (aura_env.kwdlCDRemaining > 0 or aura_env.zhsxgCDRemaining <= 0) and aura_env.fwnl <= 110 then
        -- WeakAuras.ScanEvents("SPELL_3_READY_XEDK", true)
        table.insert(SpellValue, 3)
    elseif aura_env.djsfdl == 0 and
        (aura_env.xxfw == 2 or ((aura_env.xxfw + aura_env.swfw) == 2 and aura_env.hlflBuffRemaining <= 18)) and
        aura_env.fwnl <= 110 and aura_env.kwdlCDRemaining > 0 then
        -- WeakAuras.ScanEvents("SPELL_3_READY_XEDK", true)
        table.insert(SpellValue, 3)
    else
        -- WeakAuras.ScanEvents("SPELL_3_CANCEL_XEDK", true)
    end
    if (aura_env.xxfw >= 1 or (aura_env.swfw >= 1 and aura_env.hlflBuffRemaining <= 18)) and aura_env.zhsxgCDRemaining <=
        150 and aura_env.zhsxgCDRemaining > 0 and aura_env.xxlqBuffRemaining == false and aura_env.fwnl <= 110 and
        xxlqky == true and xelq <= 0 then
        -- WeakAuras.ScanEvents("SPELL_13_READY_XEDK", true)
        table.insert(SpellValue, 13)
    else
        -- WeakAuras.ScanEvents("SPELL_13_CANCEL_XEDK", true)
    end
    -- if aura_env.mzzqBuffRemaining > 0 then
    --     WeakAuras.ScanEvents("SPELL_4_READY_XEDK", aura_env.xz, aura_env.cs)
    -- else
    --     WeakAuras.ScanEvents("SPELL_4_CANCEL_XEDK", true)
    -- end
    table.insert(SpellValue, 4)
    if aura_env.hdhjCDRemaining <= 0 and aura_env.fwnl < 100 then
        -- WeakAuras.ScanEvents("SPELL_6_READY_XEDK", true)
        table.insert(SpellValue, 6)
    else
        -- WeakAuras.ScanEvents("SPELL_6_CANCEL_XEDK", true)
    end
    if (aura_env.msqh == "qt" or (aura_env.msqh ~= "dt" and aura_env.count >= 1)) and
        (aura_env.xxfw >= 1 or (aura_env.swfw >= 1 and aura_env.hlflBuffRemaining <= 18)) and aura_env.count2 > 0 and
        (aura_env.bsybDEBuffRemaining > 0 or aura_env.xzybDEBuffRemaining > 0) and crky == true and aura_env.djsfdl == 0 then
        -- WeakAuras.ScanEvents("SPELL_15_READY_XEDK", true)
        table.insert(SpellValue, 15)
    else
        -- WeakAuras.ScanEvents("SPELL_15_CANCEL_XEDK", true)
    end
    if (aura_env.msqh == "dt" or (aura_env.msqh ~= "qt" and aura_env.count < 1)) and
        (aura_env.xxfw >= 1 or (aura_env.swfw >= 1 and aura_env.hlflBuffRemaining <= 18)) and aura_env.djsfdl == 0 and
        xyftky == true and aura_env.fwnl <= 110 then
        -- WeakAuras.ScanEvents("SPELL_10_READY_XEDK", true)
        table.insert(SpellValue, 10)
    else
        -- WeakAuras.ScanEvents("SPELL_10_CANCEL_XEDK", true)
    end
    -- if aura_env.mzzqBuffRemaining > 0 then
    --     WeakAuras.ScanEvents("SPELL_4_READY_XEDK", aura_env.xz, aura_env.xxxz)
    -- else
    --     WeakAuras.ScanEvents("SPELL_4_CANCEL_XEDK", true)
    -- end
    if aura_env.hdhjCDRemaining <= 0 and aura_env.fwnl < 100 then
        -- WeakAuras.ScanEvents("SPELL_6_READY_XEDK", true)
        table.insert(SpellValue, 6)
    else
        -- WeakAuras.ScanEvents("SPELL_6_CANCEL_XEDK", true)
    end
    if aura_env.zhsxgCDRemaining <= 5 and aura_env.fwnl >= 60 then
        -- WeakAuras.ScanEvents("SPELL_7_READY_XEDK", true)
        table.insert(SpellValue, 7)
    elseif aura_env.zhsxgCDRemaining > 5 and aura_env.fwnl >= 40 then
        -- WeakAuras.ScanEvents("SPELL_7_READY_XEDK", true)
        table.insert(SpellValue, 7)
    else
        -- WeakAuras.ScanEvents("SPELL_7_CANCEL_XEDK", true)
    end
    ---------------------------------------------------------------------------------------------------------------
    if (((aura_env.bfqd1 == true or UnitName("target") == "大领主的训练假人") and isBoss) or zhandoumoshi == 1) and
        aura_env.config.bfkg then
        if aura_env.fwwqzxCDRemaining <= 0 and aura_env.fwsl == 0 and aura_env.hlflqd == false then
            -- WeakAuras.ScanEvents("SPELL_5_READY_XEDK", true)
            table.insert(SpellValue, 5)
        else
            -- WeakAuras.ScanEvents("SPELL_5_CANCEL_XEDK", true)
        end
        if aura_env.wzdjCDRemaining <= 0 and
            (aura_env.bsfw == 1 and aura_env.xefw == 1 and ((aura_env.xxfw + aura_env.swfw) == 1)) and aura_env.djsfdl ==
            1 and aura_env.zhsxgCDRemaining > 0 and ((aura_env.hmfBuffRemaining > 0 and aura_env.config.hmf) or
            (aura_env.hmfBuffRemaining <= 0 and aura_env.config.hmf and aura_env.hmfSPCD > 0) or
            (aura_env.hmfBuffRemaining <= 0 and aura_env.config.hmf and aura_env.fwnl < 40 and aura_env.hdhjCDRemaining >
                0) or (aura_env.hmfBuffRemaining <= 0 and aura_env.config.hmf == false)) then
            -- WeakAuras.ScanEvents("SPELL_8_READY_XEDK", true)
            table.insert(SpellValue, 8)
        else
            -- WeakAuras.ScanEvents("SPELL_8_CANCEL_XEDK", true)
        end
        if aura_env.zhsxgCDRemaining <= 0 and
            ((aura_env.bsybDEBuffRemaining > 0 and aura_env.xzybDEBuffRemaining > 0 and aura_env.gjBuffRemaining > 0 and
                aura_env.ssgklBuffRemaining > 0) or aura_env.fwsl == 0) and aura_env.fwnl >= 60 and
            aura_env.tzdjBuffRemaining > 0 and aura_env.dlszjBuffRemaining > 0 then
            -- WeakAuras.ScanEvents("SPELL_9_READY_XEDK", true)
            table.insert(SpellValue, 9)
        elseif aura_env.zhsxgCDRemaining <= 0 and aura_env.bsybDEBuffRemaining > 0 and aura_env.xzybDEBuffRemaining > 0 and
            aura_env.gjBuffRemaining > 0 and aura_env.xefw <= 1 and ((aura_env.xxfw + aura_env.swfw) <= 1) and
            aura_env.bsfw <= 1 and aura_env.fwnl >= 60 and aura_env.fwwqzxCDRemaining > 0 then
            -- WeakAuras.ScanEvents("SPELL_9_READY_XEDK", true)
            table.insert(SpellValue, 9)
        else
            -- WeakAuras.ScanEvents("SPELL_9_CANCEL_XEDK", true)
        end
    end
    ----------------------------------------------------------------------------------------------------------------
    if aura_env.bfqd2 == true and isBoss and aura_env.config.bfkg then
        if aura_env.fwwqzxCDRemaining <= 0 and aura_env.fwsl == 0 and aura_env.hlflqd == false and aura_env.djqd == true then
            -- WeakAuras.ScanEvents("SPELL_5_READY_XEDK", true)
            table.insert(SpellValue, 5)
        else
            -- WeakAuras.ScanEvents("SPELL_5_CANCEL_XEDK", true)
        end
        if aura_env.wzdjCDRemaining <= 0 and
            (aura_env.bsfw == 1 and aura_env.xefw == 1 and ((aura_env.xxfw + aura_env.swfw) == 1)) and aura_env.djsfdl ==
            1 and aura_env.zhsxgCDRemaining > 0 and ((aura_env.hmfBuffRemaining > 0 and aura_env.config.hmf) or
            (aura_env.hmfBuffRemaining <= 0 and aura_env.config.hmf and aura_env.hmfSPCD > 0) or
            (aura_env.hmfBuffRemaining <= 0 and aura_env.config.hmf and aura_env.fwnl < 40 and aura_env.hdhjCDRemaining >
                0) or (aura_env.hmfBuffRemaining <= 0 and aura_env.config.hmf == false)) then
            -- WeakAuras.ScanEvents("SPELL_8_READY_XEDK", true)
            table.insert(SpellValue, 8)
        else
            -- WeakAuras.ScanEvents("SPELL_8_CANCEL_XEDK", true)
        end
        if aura_env.zhsxgCDRemaining <= 0 and
            ((aura_env.bsybDEBuffRemaining > 0 and aura_env.xzybDEBuffRemaining > 0 and aura_env.gjBuffRemaining > 0 and
                aura_env.ssgklBuffRemaining > 0) or aura_env.fwsl == 0) and aura_env.fwnl >= 60 then
            -- WeakAuras.ScanEvents("SPELL_9_READY_XEDK", true)
            table.insert(SpellValue, 9)
        else
            -- WeakAuras.ScanEvents("SPELL_9_CANCEL_XEDK", true)
        end
    end
    ---------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------
    if aura_env.bfqd3 == true and isBoss and aura_env.config.bfkg then
        if aura_env.fwwqzxCDRemaining <= 0 and aura_env.fwsl == 0 and aura_env.hlflqd == false and aura_env.djqd == true then
            -- WeakAuras.ScanEvents("SPELL_5_READY_XEDK", true)
            table.insert(SpellValue, 5)
        else
            -- WeakAuras.ScanEvents("SPELL_5_CANCEL_XEDK", true)
        end
        if aura_env.zhsxgCDRemaining <= 0 and aura_env.fwnl >= 60 then
            -- WeakAuras.ScanEvents("SPELL_9_READY_XEDK", true)
            table.insert(SpellValue, 9)
        else
            -- WeakAuras.ScanEvents("SPELL_9_CANCEL_XEDK", true)
        end
    end
    ---------------------------------------------------------------------------------------------------------------------
    if aura_env.fwsl == 0 and aura_env.minxeCD >= 1.5 and aura_env.minxxCD >= 1.5 and aura_env.minbsCD >= 1.5 and
        aura_env.hlflCDRemaining <= 0 and aura_env.ssgklBuffRemaining <= 0 and UnitExists("pet") and isBoss and
        aura_env.rune1ok then
        -- WeakAuras.ScanEvents("SPELL_12_READY_XEDK", true)
        table.insert(SpellValue, 12)
        aura_env.hlflqd = true
    elseif aura_env.hlflCDRemaining > 0 or aura_env.minxeCD <= 0.2 then
        -- WeakAuras.ScanEvents("SPELL_12_CANCEL_XEDK", true)
        aura_env.hlflqd = false
    end
    if aura_env.zhsxgCDRemaining > 160 and aura_env.hmfBuffRemaining <= 0 and aura_env.itemName == aura_env.szjName and
        aura_env.config.hmf and aura_env.bsxl == true then
        -- WeakAuras.ScanEvents("SPELL_18_READY_XEDK", true)
        table.insert(SpellValue, 18)
    elseif aura_env.zhsxgCDRemaining > 40 and aura_env.zhsxgCDRemaining <= 160 and aura_env.hmfSPCD <= 0 and
        aura_env.hmfBuffRemaining <= 0 and aura_env.itemName == aura_env.szjName and aura_env.config.hmf and
        aura_env.config.hmf1 and aura_env.bsxl == true and isBoss then
        -- WeakAuras.ScanEvents("SPELL_18_READY_XEDK", true)
        table.insert(SpellValue, 18)
    else
        -- WeakAuras.ScanEvents("SPELL_18_CANCEL_XEDK", true)
    end
    if aura_env.itemName == aura_env.hmfName and aura_env.config.hmf and aura_env.bsxl == true and aura_env.hmfSPCD > 0 and
        (aura_env.wzdjCDRemaining > 0 or aura_env.djqd == false) then
        -- WeakAuras.ScanEvents("SPELL_19_READY_XEDK", true)
        table.insert(SpellValue, 19)
    elseif not inCombat and aura_env.itemName == aura_env.hmfName and aura_env.config.hmf then
        -- WeakAuras.ScanEvents("SPELL_19_READY_XEDK", true)
        table.insert(SpellValue, 19)
    else
        -- WeakAuras.ScanEvents("SPELL_19_CANCEL_XEDK", true)
    end
end
