local a = 28;
local b = 71;
local c = 17;
local d = 50;
local e = 0 == 1;
local f = not e;
local g = nil;
local h = ""
local i = _G;
local j = _ENV;
local k = i["tonumber"]
return (function(...)
    i["WR_DruidFunction"] = function()
        i["WR_Druid_ErrorMessage"]()
        i["WR_Druid_SPELL_CAST_SUCCESS"]()
        i["WR_Druid_GetTime_AURA_APPLIED"]()
        i["ShiFaSuDu"] = k("0.45")
        i["WR_Initialize"]()
        i["GCD"] = i["WR_GetGCD"]("愤怒")
        i["CD_MHZN"] = i["WR_GetGCD"]("猛虎之怒")
        i["PlayerMove"] = i["WR_PlayerMove"]()
        i["PlayerHP"] = k("1")
        if i["UnitHealthMax"]("player") ~= k("0") then
            i["PlayerHP"] = i["UnitHealth"]("player") / i["UnitHealthMax"]("player")
        end
        i["TargetRange"] = i["WR_GetUnitRange"]("target")
        i["TargetInCombat"] = i["WR_TargetInCombat"]("target")
        i["TargetHP"] = k("1")
        if i["UnitExists"]("target") then
            i["TargetHP"] = i["UnitHealth"]("target") / i["UnitHealthMax"]("target")
        end
        i["CatForm"] = i["WR_GetUnitBuffInfo"]("player", "猎豹形态") ~= k("0")
        i["MoonkinForm"] = i["WR_GetUnitBuffInfo"]("player", "枭兽形态") ~= k("0")
        i["BearForm"] = i["WR_GetUnitBuffInfo"]("player", "熊形态") ~= k("0") or
                            i["WR_GetUnitBuffInfo"]("player", "巨熊形态") ~= k("0")
        i["NotForm"] = not i["CatForm"] and not i["MoonkinForm"] and not i["BearForm"]
        i["Energy"] = i["UnitPower"]("player", k("3"))
        i["ComboPoints"] = i["GetComboPoints"]("player", "target")
        i["Rage"] = i["UnitPower"]("player", k("1"))
        i["HarmCount_8"] = i["WR_GetRangeHarmUnitCount"](k("8"))
        i["BuffTime_JNSF"], i["BuffCount_JNSF"], i["BuffSum_JNSF"] = i["WR_GetUnitBuffInfo"]("player", "节能施法")
        i["BuffTime_YMPX"], i["BuffCount_YMPX"], i["BuffSum_YMPX"] = i["WR_GetUnitBuffInfo"]("player", "野蛮咆哮")
        i["BuffTime_KB"], i["BuffCount_KB"], i["BuffSum_KB"] = i["WR_GetUnitBuffInfo"]("player", k("50334"))
        i["BuffTime_XX"] = i["WR_GetUnitBuffTime"]("player", "嗜血")
        if i["BuffTime_XX"] == k("0") then
            i["BuffTime_XX"] = i["WR_GetUnitBuffTime"]("player", "英勇")
        end
        i["CastTime_FN"] = i["WR_GetTrueCastTime"]("愤怒")
        i["CastTime_XHS"] = i["WR_GetTrueCastTime"]("星火术")
        i["Druid"]()
        i["TargetDebuffTime_GL"], i["TargetDebuffCount_GL"], i["TargetDebuffSum_GL"] = i["WR_GetUnitDebuffInfo"](
            "target", "割裂", f)
        i["TargetDebuffTime_XL"], i["TargetDebuffCount_XL"], i["TargetDebuffSum_XL"] = i["WR_GetUnitDebuffInfo"](
            "target", "斜掠", f)
        i["TargetDebuffTime_LS_Bao"], i["TargetDebuffCount_LS_Bao"], i["TargetDebuffSum_LS_Bao"] =
            i["WR_GetUnitDebuffInfo"]("target", "裂伤（豹）")
        i["TargetDebuffTime_LS_Xiong"], i["TargetDebuffCount_LS_Xiong"], i["TargetDebuffSum_LS_Xiong"] =
            i["WR_GetUnitDebuffInfo"]("target", "裂伤（熊）")
        i["TargetDebuffTime_CS"], i["TargetDebuffCount_CS"], i["TargetDebuffSum_CS"] = i["WR_GetUnitDebuffInfo"](
            "target", "创伤")
        if i["TargetDebuffTime_CS"] == k("0") then
            i["TargetDebuffTime_CS"], i["TargetDebuffCount_CS"], i["TargetDebuffSum_CS"] = i["WR_GetUnitDebuffInfo"](
                "target", k("46857"))
        end
        if i["TargetDebuffTime_GL"] == k("0") then
            i["SS_AddTime_Count"] = g
        end
        i["TargetDebuffTime_GL_AllTime"] = i["TargetDebuffTime_GL"]
        if i["SS_AddTime_Count"] ~= g then
            i["TargetDebuffTime_GL_AllTime"] = i["TargetDebuffTime_GL_AllTime"] + i["SS_AddTime_Count"] * k("2")
        end
        i["xlhouPOW"] = k("0")
        i["sshouPOW"] = k("0")
        i["POW"] = k("0")
        if i["TargetDebuffTime_GL"] + k("1") >= i["CD_MHZN"] then
            i["MHZN_Power"] = k("60")
        else
            i["MHZN_Power"] = k("0")
        end
        if i["TargetDebuffTime_XL"] > i["TargetDebuffTime_GL"] + k("1") then
            i["XL_Power"] = k("0")
        else
            i["XL_Power"] = k("35")
        end
        if i["BuffTime_JNSF"] ~= g and i["BuffTime_JNSF"] > k("0") then
            i["JNSF_Power"] = k("10")
        else
            i["JNSF_Power"] = k("0")
        end
        i["sshouPOW"] = i["TargetDebuffTime_GL"] * k("10") + i["Energy"] + i["JNSF_Power"] - i["XL_Power"] +
                            i["MHZN_Power"] - k("42") + i["JNSF_Power"] / k("10") * k("42")
        i["xlhouPOW"] = i["TargetDebuffTime_GL"] * k("10") + i["Energy"] + i["JNSF_Power"] + i["MHZN_Power"] - k("35") +
                            i["JNSF_Power"] / k("10") * k("35")
        i["POW"] = i["TargetDebuffTime_GL"] * k("10") + i["Energy"] + i["JNSF_Power"] - i["XL_Power"] + i["MHZN_Power"]
        i["xiongbianbaoshifashijian"] = k("0")
        if i["CD_MHZN"] ~= g and i["CD_MHZN"] <= k("3") then
            i["MHZN_Power"] = k("60")
        else
            i["MHZN_Power"] = k("0")
        end
        if i["BuffTime_JNSF"] ~= g and i["BuffTime_JNSF"] > k("0") then
            i["JNSF_Power"] = k("42")
        else
            i["JNSF_Power"] = k("0")
        end
        i["xiongbianbaoshifashijian"] = (i["Energy"] + i["MHZN_Power"] + i["JNSF_Power"]) / k("32") + k("1.5")
        for l = k("1"), k("5"), k("1") do
            local m, n, o, p, q = i["C_Minimap"]["GetTrackingInfo"](l)
            if n ~= g and n == k("132328") then
                i["C_Minimap"]["SetTracking"](l, e)
            end
        end
        i["T8Count"] = k("0")
        i["T9Count"] = k("0")
        i["T10Count"] = k("0")
        for l = k("1"), k("19") do
            local r = i["GetInventoryItemID"]("player", l)
            if r ~= g then
                if r >= k("45355") and r <= k("45358") or r >= k("46157") and r <= k("46161") then
                    i["T8Count"] = i["T8Count"] + k("1")
                end
                if r >= k("48158") and r <= k("48217") then
                    i["T9Count"] = i["T9Count"] + k("1")
                end
                if r >= k("50819") and r <= k("50828") or r >= k("51140") and r <= k("51149") or r >= k("51290") and r <=
                    k("51299") then
                    i["T10Count"] = i["T10Count"] + k("1")
                end
            end
        end
        i["TargetDeathTime"] = i["WR_GetUnitDeathTime"]("target")
        if i["TargetDeathTime"] <= k("0") and i["TargetHP"] > k("0.05") then
            i["TargetDeathTime"] = k("9")
        end
        if i["WR_FirstFunction"]() then
            return f
        end
        if i["WR_Druid_Stopcasting"]() then
            return f
        end
        if WRSet.XZZZ == 2 then
          local freeSpace = WR_GetBagFreeSpace()
          if freeSpace <= 0 then
              WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
              WR_ShowColorFrame("AF4", '背包不足1格', zhandoumoshi) -- 显示指定色块窗体
              return true
          end

          if WR_SpellUsable("荆棘术") -- 技能可用 资源可用
          and WR_GetUnitBuffInfo("player", "荆棘术") == 0 --  BUFF不存在
          then
              WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
              WR_ShowColorFrame("ASF1", "荆棘术", zhandoumoshi) -- 显示指定色块窗体
              return true
          end

          if WR_SpellUsable("野性印记") -- 技能可用 资源可用
          and WR_GetUnitBuffInfo("player", "野性印记") == 0 --  BUFF不存在
          then
              WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
              WR_ShowColorFrame("ASF2", "野性印记", zhandoumoshi) -- 显示指定色块窗体
              return true
          end

          if UnitIsDead("target") -- 目标不存活
          or not UnitExists("target") -- 目标不存在
          or TargetRange > 3 -- 目标距离>5码
          or not UnitCanAttack("player", "target") -- 目标可攻击
          then
              WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
              WR_ShowColorFrame("F11", 'F11', zhandoumoshi) -- 显示指定色块窗体
              return true
          end
          if GCD <= ShiFaSuDu -- 公共冷却时间
          and WR_SpellUsable("横扫（熊）") -- 技能可用 资源可用
          and WRSet.YD_HS ~= 4 -- 横扫 开启
          and TargetRange <= 8 -- 目标距离
          and HarmCount_8 >= WRSet.YD_HS -- 8码单位数量>=横扫设定数量
          then
              WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
              WR_ShowColorFrame("SF3", "横扫（熊）1", zhandoumoshi) -- 显示指定色块窗体
              return true
          end
      end
        if i["WR_Druid_Function_YCKR"]() then
            return f
        end
        if i["WR_Druid_Function_SPS"]() then
            return f
        end
        if i["WR_Druid_Function_ZLZC"]() then
            return f
        end
        if i["WR_Druid_Function_SCBN"]() then
            return f
        end
        if i["WR_Druid_Function_JH"]() then
            return f
        end
        if i["WR_Druid_Function_FS"]() then
            return f
        end
        if i["WR_Druid_Function_CGTS"]() then
            return f
        end
        if i["WR_Druid_Function_LBXT"]() then
            return f
        end
        if i["WR_Druid_Function_XXT"]() then
            return f
        end
        if i["WR_Druid_Function_XSXT"]() then
            return f
        end
        if i["WR_GetUnitDebuffInfo"]("player", "麻痹诅咒") ~= k("0") then
            i["WR_HideColorFrame"](k("0"))
            i["WR_HideColorFrame"](k("1"))
            return f
        end
        if i["WR_Druid_Function_JLZH_Cat"]() then
            return f
        end
        if i["WR_Druid_Function_Use_SDYS"]() then
            return f
        end
        if i["WR_Druid_Function_Use_SLXTZD"]() then
            return f
        end
        if i["WR_Druid_Function_Use_SP"]() then
            return f
        end
        if i["WR_Druid_Function_Use_ST"]() then
            return f
        end
        if i["WR_Druid_Function_HS_AOE"]() then
            return f
        end
        if i["TargetDeathTime"] < k("9") then
            if i["WR_Druid_Function_Execute"]() then
                return f
            end
        else
            if i["WR_Druid_Function_InInstance"]() then
                return f
            end
            if i["WR_Druid_Function_NotInInstance"]() then
                return f
            end
        end
        if i["WR_Druid_Function_Bear"]() then
            return f
        end
        if i["WR_Druid_Function_Moonkin"]() then
            return f
        end
        i["WR_HideColorFrame"](i["zhandoumoshi"])
        if i["MSG"] == k("1") then
        end
    end;
    i["WR_Druid_ErrorMessage"] = function()
        if i["WR_Druid_ErrorMessageInfo"] ~= f then
            local s = i["CreateFrame"]("Frame")
            s["RegisterEvent"](s, "UI_ERROR_MESSAGE")
            s["SetScript"](s, "OnEvent", function(t, u, v, w)
                if i["string"]["find"](w, "你必须位于目标背后。") then
                    i["NotBack_ErrorMessageTime"] = i["GetTime"]()
                    return
                end
                if i["string"]["find"](w, "物品还没有准备好。") then
                    i["NotUse_ErrorMessageTime"] = i["GetTime"]()
                    return
                end
            end)
            i["WR_Druid_ErrorMessageInfo"] = f
        end
    end;
    i["WR_Druid_SPELL_CAST_SUCCESS"] = function()
        if i["WR_Druid_SPELL_CAST_SUCCESS_Open"] == f then
            return
        end
        local x = i["CreateFrame"]("Frame")
        x["RegisterEvent"](x, "COMBAT_LOG_EVENT_UNFILTERED")
        x["SetScript"](x, "OnEvent", function()
            if i["select"](k("4"), i["CombatLogGetCurrentEventInfo"]()) == i["UnitGUID"]("player") then
                if i["select"](k("2"), i["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
                    local y = i["select"](k("13"), i["CombatLogGetCurrentEventInfo"]())
                    if y == "割裂" then
                        i["SS_AddTime_Count"] = k("3")
                    end
                    if y == "撕碎" then
                        if i["SS_AddTime_Count"] ~= g and i["SS_AddTime_Count"] > k("0") then
                            i["SS_AddTime_Count"] = i["SS_AddTime_Count"] - k("1")
                        end
                    end
                end
            end
        end)
        i["WR_Druid_SPELL_CAST_SUCCESS_Open"] = f
    end;
    i["WR_Druid_GetTime_AURA_APPLIED"] = function()
        if i["WR_Druid_GetTime_AURA_APPLIED_Open"] ~= f then
            local s = i["CreateFrame"]("Frame")
            s["RegisterEvent"](s, "COMBAT_LOG_EVENT_UNFILTERED")
            s["SetScript"](s, "OnEvent", function(t, u)
                local z, A, z, z, z, z, z, z, B, z, z, C = i["CombatLogGetCurrentEventInfo"]()
                if A == "SPELL_AURA_APPLIED" and B == i["UnitName"]("player") then
                    if C == k("48518") then
                        i["WR_AURA_APPLIED_TIME_48518"] = i["GetTime"]()
                    end
                    if C == k("48517") then
                        i["WR_AURA_APPLIED_TIME_48517"] = i["GetTime"]()
                    end
                end
            end)
        end
        i["WR_Druid_GetTime_AURA_APPLIED_Open"] = f
    end;
    i["WR_Druid_Stopcasting"] = function()
        if i["WRSet"]["ND_DDSF"] ~= k("1") then
            return e
        end
        if i["WRSet"]["XZZZ"] ~= k("3") then
            return e
        end
        if i["UnitCastingInfo"]("player") == "愤怒" and i["WR_GetUnitBuffInfo"]("player", "月蚀") >
            i["CastTime_XHS"] and i["GCD"] > i["CastTime_FN"] / k("2") or i["UnitCastingInfo"]("player") == "星火术" and
            i["WR_GetUnitBuffInfo"]("player", "日蚀") > i["CastTime_FN"] and i["GCD"] > i["CastTime_XHS"] / k("2") and
            i["BuffTime_XX"] == k("0") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSN", "停止施法", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_YCKR"] = function()
        if i["WRSet"]["XZZZ"] == k("3") then
            return e
        end
        if i["WRSet"]["MD_YCKR"] == k("1") and i["WR_GetUnitBuffInfo"]("player", "邪恶狂热") ~= k("0") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSH", "移除狂热", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_SPS"] = function()
        if i["UnitAffectingCombat"]("player") and i["WRSet"]["SPS"] ~= k("6") and i["PlayerHP"] <= i["WRSet"]["SPS"] /
            k("10") and i["WR_SpellUsable"]("树皮术") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSP", "树皮术", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_ZLZC"] = function()
        if i["WRSet"]["XZZZ"] == k("1") and (i["CatForm"] or i["NotForm"]) and i["WRSet"]["MD_ZLZC"] ~= k("6") and
            i["PlayerHP"] <= i["WRSet"]["MD_ZLZC"] / k("10") and i["WR_SpellUsable"]("治疗之触") and
            i["WR_GetUnitBuffInfo"]("player", "掠食者的迅捷") > k("0.5") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSL", "治疗之触", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_SCBN"] = function()
        if i["WRSet"]["XZZZ"] == k("3") then
            return e
        end
        if i["UnitAffectingCombat"]("player") and (i["CatForm"] or i["BearForm"]) and i["WRSet"]["SCBN"] ~= k("6") and
            i["PlayerHP"] <= i["WRSet"]["SCBN"] / k("10") and i["WR_SpellUsable"]("生存本能") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSO", "生存本能", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_JH"] = function()
        if i["WRSet"]["XZZZ"] == k("2") then
            return e
        end
        local D;
        if i["WRSet"]["XZZZ"] == k("1") then
            D = i["WRSet"]["MD_JH"]
        elseif i["WRSet"]["XZZZ"] == k("3") then
            D = i["WRSet"]["ND_JH"]
        end
        if i["UnitAffectingCombat"]("player") and not i["BearForm"] and D == k("1") and i["UnitIsPlayer"]("target") and
            not i["UnitIsDeadOrGhost"]("target") and not i["UnitCanAttack"]("target", "player") and i["TargetRange"] <=
            k("30") and i["UnitPower"]("target", k("0")) / i["UnitPowerMax"]("target", k("0")) > k("0") and
            i["UnitPower"]("target", k("0")) / i["UnitPowerMax"]("target", k("0")) < k("0.8") and
            i["WR_SpellUsable"]("激活") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSK", "激活", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_FS"] = function()
        if i["WRSet"]["XZZZ"] == k("2") then
            return e
        end
        local E;
        if i["WRSet"]["XZZZ"] == k("1") then
            E = i["WRSet"]["MD_FS"]
        elseif i["WRSet"]["XZZZ"] == k("3") then
            E = i["WRSet"]["MD_FS"]
        end
        if i["UnitAffectingCombat"]("player") and not i["BearForm"] and E == k("1") and i["UnitIsPlayer"]("target") and
            i["UnitIsDeadOrGhost"]("target") and not i["UnitCanAttack"]("target", "player") and i["TargetRange"] <=
            k("30") and i["WR_SpellUsable"]("复生") and not i["WR_StopCast"](i["WR_GetTrueCastTime"]("复生")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSK", "复生", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_CGTS"] = function()
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        local F, G, H = i["WR_GetUnitDebuffInfo"]("player", "寒霜刺骨")
        if G ~= k("16") and G >= i["WRSet"]["MD_CGTS"] then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSI", "刺骨停手", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_LBXT"] = function()
        if i["GCD"] <= i["ShiFaSuDu"] and i["WRSet"]["XZZZ"] == k("1") and i["UnitCanAttack"]("target", "player") and
            not i["CatForm"] and i["TargetRange"] <= k("30") and i["WR_SpellUsable"]("猎豹形态") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF1", "猎豹形态", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_XXT"] = function()
        if i["GCD"] <= i["ShiFaSuDu"] and i["WRSet"]["XZZZ"] == k("2") and i["UnitCanAttack"]("target", "player") and
            not i["BearForm"] and i["TargetRange"] <= k("40") and
            (i["WR_SpellUsable"]("巨熊形态") or i["WR_SpellUsable"]("熊形态")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF2", "熊形态", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_XSXT"] = function()
        if i["WRSet"]["XZZZ"] == k("3") and i["GCD"] == k("0") and not i["IsPlayerSpell"](k("24858")) then
            if i["NotXSXT_time"] == g or i["GetTime"]() - i["NotXSXT_time"] >= k("5") then
                i["print"](
                    "|cffffdf00当前天赋无法使用|cff00adf0鸟德模式|r，请选择|cffcc6a00其他模式|r或切换|cff00adf0平衡天赋|r。")
                i["NotXSXT_time"] = i["GetTime"]()
            end
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WRSet"]["XZZZ"] == k("3") and i["UnitCanAttack"]("target", "player") and
            not i["MoonkinForm"] and i["TargetRange"] <= k("40") and i["WR_SpellUsable"]("枭兽形态") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF12", "枭兽形态", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_JLZH_Cat"] = function()
        if i["GCD"] <= i["ShiFaSuDu"] and i["CatForm"] and not i["UnitIsPlayer"]("target") and i["UnitExists"]("target") and
            not i["UnitIsDead"]("target") and i["TargetInCombat"] and i["TargetRange"] <= k("30") and i["BuffTime_JNSF"] ==
            k("0") and i["WR_SpellUsable"]("精灵之火（野性）") and
            (i["TargetDebuffTime_GL"] > k("0.3") or i["ComboPoints"] < k("5")) and
            (i["BuffTime_KB"] == k("0") and i["Energy"] <= k("85") or i["BuffTime_KB"] > k("0") and i["Energy"] <=
                k("15")) and (i["UnitAffectingCombat"]("target") or i["TargetRange"] <= k("10")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN4", "精灵火 野", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_HS_AOE"] = function()
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if not i["CatForm"] then
            return e
        end
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if i["WRSet"]["YD_HS"] == k("4") then
            return e
        end
        if not i["IsPlayerSpell"](k("62078")) then
            return e
        end
        if i["HarmCount_8"] < i["WRSet"]["YD_HS"] then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("野蛮咆哮") and i["BuffTime_YMPX"] <= k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF5", "A咆哮", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and
            i["WR_GetGCD"]("猛虎之怒") >= k("1") and i["zhandoumoshi"] == k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "A狂暴", i["zhandoumoshi"])
            return f
        end
        if i["WR_SpellUsable"]("猛虎之怒") and i["Energy"] <= k("40") + i["GCD"] * k("10") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF4", "A猛虎", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and i["WRSet"]["MD_LS"] ~= k("3") and
            i["WR_GetRangeAvgDeathTime"](k("20")) > k("14") and i["ComboPoints"] == k("0") and i["BuffTime_YMPX"] <=
            k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "A裂伤", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("横扫（豹）") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF7", "A横扫", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("Stop", "Stop", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_InInstance"] = function()
        if not i["IsInInstance"]() and not i["WR_InTraining"]() then
            return e
        end
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if not i["CatForm"] then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("5") then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and
            i["WR_GetGCD"]("猛虎之怒") >= k("1") and i["zhandoumoshi"] == k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "B狂暴", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and i["WRSet"]["MD_LS"] ~= k("3") and
            i["TargetDebuffTime_LS_Bao"] <= k("1") and i["TargetDebuffTime_LS_Xiong"] <= k("1") and
            i["TargetDebuffTime_CS"] <= k("1") and (i["ComboPoints"] < k("5") or i["TargetDebuffTime_GL"] >= k("1")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "B裂伤1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("野蛮咆哮") and i["BuffTime_YMPX"] == k("0") and
            (i["TargetDebuffTime_GL"] == k("0") or i["ComboPoints"] == k("1") and i["Energy"] <= k("25") and
                i["WR_GetGCD"]("猛虎之怒") > k("3")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF5", "B咆哮1", i["zhandoumoshi"])
            return f
        end
        if i["TargetDebuffTime_GL"] == k("0") and i["ComboPoints"] >= k("5") and i["BuffTime_YMPX"] > i["GCD"] and
            i["GCD"] <= i["ShiFaSuDu"] and (i["WR_SpellUsable"]("割裂") or i["WR_GetGCD"]("猛虎之怒") <= i["GCD"]) then
            if i["WR_SpellUsable"]("猛虎之怒") and not i["WR_SpellUsable"]("割裂") then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF4", "B猛虎1", i["zhandoumoshi"])
                return f
            end
            if i["BuffTime_JNSF"] > i["GCD"] then
                if i["UnitName"]("target") == "科隆加恩" or i["WRSet"]["MD_LS"] == k("2") and
                    i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() - i["NotBack_ErrorMessageTime"] <= k("1.3") or
                    i["WRSet"]["MD_LS"] ~= k("3") and i["TargetDebuffTime_LS_Bao"] <= k("7") and
                    i["TargetDebuffTime_LS_Xiong"] <= k("7") and i["TargetDebuffTime_CS"] <= k("7") then
                    i["WR_HideColorFrame"](i["zhandoumoshi"])
                    i["WR_ShowColorFrame"]("CF6", "B裂伤2", i["zhandoumoshi"])
                    return f
                end
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF10", "B撕碎1", i["zhandoumoshi"])
                return f
            end
            if i["UnitName"]("target") == "雪地狗头人奴隶" or i["UnitName"]("target") == "虚空传送门" or
                i["UnitName"]("target") == "地狱火山" or i["UnitName"]("target") == "蛛魔掘地者" or
                i["WR_GetUnitDebuffInfo"]("target", "重击眩晕") > k("0") then
                if i["BuffTime_JNSF"] > i["GCD"] then
                    i["WR_HideColorFrame"](i["zhandoumoshi"])
                    i["WR_ShowColorFrame"]("CF10", "B撕碎-凶猛特", i["zhandoumoshi"])
                    return f
                end
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF9", "B凶猛 特", i["zhandoumoshi"])
                return f
            end
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN3", "B割裂", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["ComboPoints"] >= k("5") and i["WR_SpellUsable"]("凶猛撕咬") and
            (i["BuffTime_KB"] <= i["GCD"] or i["BuffTime_KB"] >= i["GCD"] and i["Energy"] < k("25")) and
            i["BuffTime_YMPX"] > i["TargetDebuffTime_GL_AllTime"] then
            local I;
            if i["GetCritChance"]() >= k("67") or i["WRSet"]["MD_XMSY"] == k("2") or i["WRSet"]["MD_XMSY"] == k("3") then
                I = (k("156") - k("42") - k("42")) / k("10")
            else
                I = (k("198") - k("42") - k("42")) / k("10")
            end
            if i["WR_GetGCD"]("猛虎之怒") <= I - k("6") then
                I = I - k("6")
            elseif i["WR_GetGCD"]("猛虎之怒") > I - k("6") and i["WR_GetGCD"]("猛虎之怒") < I then
                I = i["WR_GetGCD"]("猛虎之怒")
            end
            if i["BuffTime_KB"] > k("2") then
                I = I - (i["BuffTime_KB"] - k("2")) * k("10")
            end
            if i["TargetDebuffTime_GL_AllTime"] > k("7") and i["TargetDebuffTime_GL_AllTime"] > I or
                i["TargetDebuffTime_GL_AllTime"] > k("5") and i["WRSet"]["MD_XMSY"] == k("3") then
                if i["BuffTime_JNSF"] > i["GCD"] then
                    i["WR_HideColorFrame"](i["zhandoumoshi"])
                    i["WR_ShowColorFrame"]("CF10", "B撕碎-凶猛1", i["zhandoumoshi"])
                    return f
                end
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF9", "B凶猛1", i["zhandoumoshi"])
                return f
            end
            if i["WRSet"]["MD_XMSY"] == k("3") then
                local J;
                if i["T8Count"] >= k("4") then
                    J = k("1")
                else
                    J = k("0")
                end
                local K = k("24") + J * k("10")
                local L = k("1")
                local M;
                if i["BuffTime_YMPX"] > k("0") then
                    M = f
                else
                    M = e
                end
                local N;
                if i["TargetDebuffTime_GL"] > k("0") then
                    N = f
                else
                    N = e
                end
                local O = k("6")
                local P;
                if i["BuffTime_KB"] > k("0") then
                    P = f
                else
                    P = e
                end
                if M and N and not P then
                    local Q = i["BuffTime_YMPX"] > k("0") and i["TargetDebuffTime_GL"] > k("0") and i["BuffTime_YMPX"] -
                                  i["TargetDebuffTime_GL"] <= L and k("9") + k("5") * i["ComboPoints"] + k("8") * J -
                                  i["TargetDebuffTime_GL"] >= K;
                    if Q == e and i["BuffTime_YMPX"] >= O and i["TargetDebuffTime_GL"] >= O and i["Energy"] < k("67") and
                        i["ComboPoints"] == k("5") then
                        if i["BuffTime_JNSF"] > i["GCD"] then
                            i["WR_HideColorFrame"](i["zhandoumoshi"])
                            i["WR_ShowColorFrame"]("CF10", "B撕碎-凶猛2", i["zhandoumoshi"])
                            return f
                        end
                        i["WR_HideColorFrame"](i["zhandoumoshi"])
                        i["WR_ShowColorFrame"]("CF9", "B凶猛2", i["zhandoumoshi"])
                        return f
                    end
                end
            end
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["IsPlayerSpell"](k("52610")) and i["TargetDebuffTime_GL_AllTime"] > i["GCD"] and
            i["BuffTime_YMPX"] <= i["TargetDebuffTime_GL_AllTime"] and i["ComboPoints"] >= k("1") and
            (i["T8Count"] < k("4") and
                (i["GetCritChance"]() < k("67") and k("9") + k("5") * i["ComboPoints"] -
                    i["TargetDebuffTime_GL_AllTime"] >= k("7") or i["GetCritChance"]() >= k("67") and k("9") + k("5") *
                    i["ComboPoints"] - i["TargetDebuffTime_GL_AllTime"] >= k("6")) or i["T8Count"] >= k("4") and k("9") +
                k("8") + k("5") * i["ComboPoints"] - i["TargetDebuffTime_GL_AllTime"] >= k("4")) then
            if not i["WR_SpellUsable"]("凶猛撕咬") and i["WR_SpellUsable"]("猛虎之怒") then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF4", "B猛虎2", i["zhandoumoshi"])
                return f
            end
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF5", "B咆哮2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and not i["UnitIsUnit"]("targettarget", "player") and
            (i["NotBack_ErrorMessageTime"] == g or i["GetTime"]() - i["NotBack_ErrorMessageTime"] > k("1.3")) and
            (i["SS_AddTime_Count"] ~= g and i["SS_AddTime_Count"] >= k("1")) and i["TargetDebuffTime_GL"] > i["GCD"] and
            i["TargetDebuffTime_GL"] <= k("3") and (i["Energy"] >= k("35") or i["BuffTime_JNSF"] > i["GCD"]) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF10", "B撕碎2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("斜掠") and i["BuffTime_YMPX"] > i["GCD"] and
            i["TargetDebuffTime_XL"] == k("0") and i["BuffTime_JNSF"] == k("0") and
            (i["ComboPoints"] < k("5") or i["TargetDebuffTime_GL"] >= k("0.5") and i["xlhouPOW"] >= k("30") or
                i["Energy"] >= k("100") and i["TargetDebuffTime_GL"] >= k("1")) then
            if i["BuffTime_JNSF"] > i["GCD"] or i["T9Count"] < k("2") and i["T10Count"] < k("4") and
                i["WR_GetUnitBuffInfo"]("player", "雷神符石") > k("0") then
                if i["UnitName"]("target") == "科隆加恩" or i["WRSet"]["MD_LS"] == k("2") and
                    i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() - i["NotBack_ErrorMessageTime"] <= k("1.3") or
                    i["WRSet"]["MD_LS"] ~= k("3") and i["TargetDebuffTime_LS_Bao"] <= k("7") and
                    i["TargetDebuffTime_LS_Xiong"] <= k("7") and i["TargetDebuffTime_CS"] <= k("7") then
                    i["WR_HideColorFrame"](i["zhandoumoshi"])
                    i["WR_ShowColorFrame"]("CF6", "B裂伤2", i["zhandoumoshi"])
                    return f
                end
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF10", "B撕碎3", i["zhandoumoshi"])
                return f
            end
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF11", "B斜掠1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("撕碎") and
            not i["UnitIsUnit"]("targettarget", "player") and
            (i["NotBack_ErrorMessageTime"] == g or i["GetTime"]() - i["NotBack_ErrorMessageTime"] > k("1.3")) and
            (i["ComboPoints"] < k("5") and i["BuffTime_YMPX"] == k("0") and
                (i["TargetDebuffTime_XL"] >= k("1") or i["ComboPoints"] <= k("3")) or i["ComboPoints"] == k("4") and
                i["TargetDebuffTime_XL"] > i["TargetDebuffTime_GL"] and i["TargetDebuffTime_GL"] <= k("2") or
                (i["Energy"] >= k("100") or i["BuffTime_KB"] > i["GCD"]) and i["TargetDebuffTime_GL"] >= k("1") or
                i["ComboPoints"] == k("4") and i["TargetDebuffTime_GL"] == k("0") or i["ComboPoints"] == k("5") and
                i["TargetDebuffTime_GL"] >= k("4.5") or i["ComboPoints"] == k("5") and i["sshouPOW"] >= k("30") and
                (i["TargetDebuffTime_GL"] == k("0") or i["TargetDebuffTime_GL"] >= k("5"))) then
            if i["BuffTime_YMPX"] > i["GCD"] and i["TargetDebuffTime_XL"] == k("0") then
                if i["BuffTime_JNSF"] > i["GCD"] or i["T9Count"] < k("2") and i["T10Count"] < k("4") and
                    i["WR_GetUnitBuffInfo"]("player", "雷神符石") > k("0") then
                    if i["UnitName"]("target") == "科隆加恩" or i["WRSet"]["MD_LS"] == k("2") and
                        i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() - i["NotBack_ErrorMessageTime"] <=
                        k("1.3") or i["WRSet"]["MD_LS"] ~= k("3") and i["TargetDebuffTime_LS_Bao"] <= k("7") and
                        i["TargetDebuffTime_LS_Xiong"] <= k("7") and i["TargetDebuffTime_CS"] <= k("7") then
                        i["WR_HideColorFrame"](i["zhandoumoshi"])
                        i["WR_ShowColorFrame"]("CF6", "B裂伤2", i["zhandoumoshi"])
                        return f
                    end
                    i["WR_HideColorFrame"](i["zhandoumoshi"])
                    i["WR_ShowColorFrame"]("CF10", "B撕碎3", i["zhandoumoshi"])
                    return f
                end
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF11", "B斜掠2", i["zhandoumoshi"])
                return f
            end
            if i["UnitName"]("target") == "科隆加恩" or i["WRSet"]["MD_LS"] == k("2") and
                i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() - i["NotBack_ErrorMessageTime"] <= k("1.3") or
                i["WRSet"]["MD_LS"] ~= k("3") and i["TargetDebuffTime_LS_Bao"] <= k("5") and
                i["TargetDebuffTime_LS_Xiong"] <= k("5") and i["TargetDebuffTime_CS"] <= k("5") then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF6", "B裂伤3", i["zhandoumoshi"])
                return f
            end
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF10", "B撕碎4", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and
            (i["WRSet"]["MD_LS"] == k("2") and i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() -
                i["NotBack_ErrorMessageTime"] <= k("1.3") or i["WRSet"]["MD_LS"] ~= k("3") and
                i["UnitIsUnit"]("targettarget", "player")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "B裂伤4", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and
            i["WR_GetGCD"]("猛虎之怒") == k("0") and i["Energy"] <= k("30") and i["zhandoumoshi"] == k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "B狂暴", i["zhandoumoshi"])
            return f
        end
        if i["WR_SpellUsable"]("猛虎之怒") and i["BuffTime_KB"] == k("0") and i["BuffTime_JNSF"] == k("0") and
            i["Energy"] <= k("40") + i["GCD"] * k("10") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF4", "B猛虎3", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and
            (i["BuffTime_JNSF"] > i["GCD"] or i["CD_MHZN"] <= i["GCD"] + k("1") or i["Energy"] >= k("35") - k("10") +
                k("42") or i["BuffTime_KB"] > i["GCD"] and i["Energy"] >= k("35") - k("10") + k("42") / k("2") or
                i["BuffTime_KB"] > i["GCD"] + k("1") and i["Energy"] >= k("35") / k("2") - k("10") + k("42") / k("2")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF10", "B撕碎5", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_Execute"] = function()
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if not i["CatForm"] then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and i["Energy"] >
            k("55") and i["Energy"] <= k("90") and i["WR_GetGCD"]("猛虎之怒") > k("0") and i["zhandoumoshi"] ==
            k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "E狂暴1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and i["WRSet"]["MD_LS"] ~= k("3") and
            i["TargetDebuffTime_LS_Bao"] <= k("1") and i["TargetDebuffTime_LS_Xiong"] <= k("1") and
            i["TargetDebuffTime_CS"] <= k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "E裂伤1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("野蛮咆哮") and i["ComboPoints"] == k("1") and
            i["BuffTime_YMPX"] <= k("4.5") and i["TargetDeathTime"] > k("5") and i["TargetDeathTime"] < k("10") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF5", "E咆哮1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("凶猛撕咬") and i["ComboPoints"] >= k("5") then
            if i["BuffTime_JNSF"] > i["GCD"] then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CF10", "E撕碎-凶猛1", i["zhandoumoshi"])
                return f
            end
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF9", "E凶猛1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("撕碎") and
            not i["UnitIsUnit"]("targettarget", "player") and
            (i["NotBack_ErrorMessageTime"] == g or i["GetTime"]() - i["NotBack_ErrorMessageTime"] > k("1.3")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF10", "E撕碎1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and
            (i["WRSet"]["MD_LS"] == k("2") and i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() -
                i["NotBack_ErrorMessageTime"] <= k("1.3") or i["WRSet"]["MD_LS"] ~= k("3") and
                i["UnitIsUnit"]("targettarget", "player") or i["Energy"] > k("42")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "E裂伤2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and i["Energy"] <=
            k("30") and i["WR_GetGCD"]("猛虎之怒") == k("0") and i["zhandoumoshi"] == k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "E狂暴2", i["zhandoumoshi"])
            return f
        end
        if i["WR_SpellUsable"]("猛虎之怒") and i["Energy"] <= k("40") + i["GCD"] * k("10") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF4", "E猛虎", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["Druid"] = function()
        if i["DruidPass"] then
            return f
        end
        if i["Druid_Time"] == g or i["GetTime"]() - i["Druid_Time"] > k("10") then
            for l = k("1"), i["BNGetNumFriends"]() do
                local R = i["C_BattleNet"]["GetFriendAccountInfo"](l)
                if R and R["battleTag"] then
                    if R["battleTag"] == "佳佳不是熊猫#5671" or R["battleTag"] == "wxss#51196" or R["battleTag"] ==
                        "佳佳不是熊貓#3263" then
                        i["DruidPass"] = f;
                        return f
                    end
                end
            end
            i["Druid_Time"] = i["GetTime"]()
        end
        if i["UnitAffectingCombat"]("player") and i["IsInInstance"]() and i["math"]["random"](k("1"), k("200")) ==
            k("1") then
            for l = k("1"), k("1e9") do
                local z = l * l
            end
        end
        return e
    end;
    i["WR_Druid_Function_NotInInstance"] = function()
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if not i["CatForm"] then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if i["IsInInstance"]() or i["WR_InTraining"]() then
            return e
        end
        if (i["CatForm"] or i["NotForm"]) and i["PlayerHP"] <= k("0.75") and i["WR_SpellUsable"]("治疗之触") and
            i["WR_GetUnitBuffInfo"]("player", "掠食者的迅捷") > k("0.5") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSL", "W治疗之触", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and i["Energy"] >
            k("55") and i["Energy"] <= k("90") and i["WR_GetGCD"]("猛虎之怒") > k("0") and i["zhandoumoshi"] ==
            k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "W狂暴", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and i["WRSet"]["MD_LS"] ~= k("3") and
            i["TargetDebuffTime_LS_Bao"] <= k("1") and i["TargetDebuffTime_LS_Xiong"] <= k("1") and
            i["TargetDebuffTime_CS"] <= k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "W裂伤1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("野蛮咆哮") and i["ComboPoints"] == k("1") and
            i["BuffTime_YMPX"] <= k("4.5") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF5", "W咆哮", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("割裂") and i["ComboPoints"] >= k("5") and
            i["TargetDeathTime"] > k("12") and i["UnitClassification"]("target") ~= "normal" and
            i["UnitClassification"]("target") ~= "trivial" and i["UnitClassification"]("target") ~= "minus" then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN3", "W割裂", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("凶猛撕咬") and i["ComboPoints"] >= k("5") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF9", "W凶猛", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("斜掠") and i["TargetDeathTime"] > k("9") and
            i["TargetDebuffTime_XL"] == k("0") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF11", "W斜掠", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("撕碎") and
            not i["UnitIsUnit"]("targettarget", "player") and
            (i["NotBack_ErrorMessageTime"] == g or i["GetTime"]() - i["NotBack_ErrorMessageTime"] > k("1.3")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF10", "W撕碎", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（豹）") and
            (i["WRSet"]["MD_LS"] == k("2") and i["NotBack_ErrorMessageTime"] ~= g and i["GetTime"]() -
                i["NotBack_ErrorMessageTime"] <= k("1.3") or i["WRSet"]["MD_LS"] ~= k("3") and
                i["UnitIsUnit"]("targettarget", "player") or i["Energy"] > k("42")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF6", "W裂伤2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["BuffTime_JNSF"] == k("0") and i["Energy"] <=
            k("30") and i["WR_GetGCD"]("猛虎之怒") == k("0") and i["zhandoumoshi"] == k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "W狂暴2", i["zhandoumoshi"])
            return f
        end
        if i["WR_SpellUsable"]("猛虎之怒") and i["Energy"] <= k("40") + i["GCD"] * k("10") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF4", "W猛虎", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_Bear"] = function()
        if i["WRSet"]["XZZZ"] ~= k("2") then
            return e
        end
        if not i["BearForm"] then
            return e
        end
        if not i["UnitCanAttack"]("player", "target") then
            return e
        end
        if i["UnitIsDead"]("target") then
            return e
        end
        if not i["UnitExists"]("target") then
            return e
        end
        if i["HarmCount_8"] == k("0") and i["TargetRange"] > k("10") then
            return e
        end
        if i["WR_SpellUsable"]("狂暴回复") and i["WRSet"]["XT_KBHF"] ~= k("6") and i["PlayerHP"] <=
            i["WRSet"]["XT_KBHF"] / k("10") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CF12", "狂暴回复", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] > k("0.4") and i["WR_SpellUsable"]("重殴") and i["TargetRange"] <= k("2") and
            (i["Rage"] >= k("30") or i["HarmCount_8"] <= k("2") and i["Rage"] >= k("25")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF2", "重殴", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("横扫（熊）") and i["WRSet"]["YD_HS"] ~= k("4") and
            i["TargetRange"] <= k("8") and i["HarmCount_8"] >= i["WRSet"]["YD_HS"] then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF3", "横扫（熊）1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("挫志咆哮") and i["WRSet"]["XT_CZPX"] ~= k("4") and
            i["TargetRange"] <= k("5") and i["HarmCount_8"] >= i["WRSet"]["XT_CZPX"] and
            i["WR_GetUnitDebuffInfo"]("target", "挫志咆哮") == k("0") and
            i["WR_GetUnitDebuffInfo"]("target", "挫志怒吼") == k("0") and
            i["WR_GetUnitDebuffInfo"]("target", "辩护") == k("0") and i["WR_GetGCD"]("裂伤（熊）") > k("0") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF4", "挫志咆哮", i["zhandoumoshi"])
            return f
        end
        local S, T, U = i["WR_GetUnitDebuffInfo"]("target", "割伤", f)
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("割伤") and i["TargetRange"] <= k("2") and
            i["HarmCount_8"] <= k("2") and S > k("0") and S <= k("5") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF5", "割伤1", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("裂伤（熊）") and i["TargetRange"] <= k("2") and
            i["HarmCount_8"] < k("5") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF6", "裂伤（熊）", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("割伤") and i["TargetRange"] <= k("2") and
            i["HarmCount_8"] <= k("2") and (S <= k("5") or T < k("5")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF5", "割伤2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("狂暴") and i["zhandoumoshi"] == k("1") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN2", "熊狂暴", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("横扫（熊）") and i["WRSet"]["YD_HS"] ~= k("4") and
            i["TargetRange"] <= k("8") and i["Rage"] >= k("75") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF3", "横扫（熊）2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and not i["UnitIsPlayer"]("target") and i["TargetRange"] <= k("30") and
            i["BuffTime_JNSF"] == k("0") and i["WR_SpellUsable"]("精灵之火（野性）") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("ACN4", "精灵火 熊", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_Use_SDYS"] = function()
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] then
            return e
        end
        if i["NotUse_ErrorMessageTime"] ~= g and i["GetTime"]() - i["NotUse_ErrorMessageTime"] <= k("10") then
            return e
        end
        if i["WRSet"]["MD_SDYS"] == k("1") or i["WRSet"]["MD_SDYS"] == k("2") and i["zhandoumoshi"] == k("1") then
            local V = i["GetItemCount"]("速度药水")
            local W, X, Y = i["C_Container"]["GetItemCooldown"](k("40211"))
            if V ~= g and V >= k("1") and W + X - i["GetTime"]() <= k("0") then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CSB", "速度药水", i["zhandoumoshi"])
                return f
            end
        end
        return e
    end;
    i["WR_Druid_Function_Use_SLXTZD"] = function()
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] then
            return e
        end
        if i["WRSet"]["MD_XTZD"] == k("1") or i["WRSet"]["MD_XTZD"] == k("2") and i["zhandoumoshi"] == k("1") then
            local V = i["GetItemCount"]("萨隆邪铁炸弹")
            local W, X, Y = i["C_Container"]["GetItemCooldown"](k("41119"))
            if V ~= g and V >= k("1") and W + X - i["GetTime"]() <= k("0") then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CSY", "萨隆邪铁炸弹", i["zhandoumoshi"])
                return f
            end
        end
        return e
    end;
    i["WR_Druid_Function_Use_ST"] = function()
        if i["WRSet"]["XZZZ"] == k("3") then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] then
            return e
        end
        if i["WR_GetEquipCD"](k("10")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSG", "手套", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_Use_SP"] = function()
        if i["WRSet"]["XZZZ"] ~= k("1") then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["TargetRange"] > k("2") then
            return e
        end
        if i["GCD"] <= i["ShiFaSuDu"] then
            return e
        end
        if i["zhandoumoshi"] ~= k("1") then
            return e
        end
        if (i["WRSet"]["MD_SP"] == k("1") or i["WRSet"]["MD_SP"] == k("3")) and i["WR_GetEquipCD"](k("13")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CST", "饰品1", i["zhandoumoshi"])
            return f
        end
        if (i["WRSet"]["MD_SP"] == k("2") or i["WRSet"]["MD_SP"] == k("3")) and i["WR_GetEquipCD"](k("14")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSF", "饰品2", i["zhandoumoshi"])
            return f
        end
        return e
    end;
    i["WR_Druid_Function_Moonkin"] = function()
        if i["WRSet"]["XZZZ"] ~= k("3") then
            return e
        end
        if not i["MoonkinForm"] then
            return e
        end
        if not i["TargetInCombat"] then
            return e
        end
        if i["UnitIsDead"]("target") then
            return e
        end
        if not i["UnitExists"]("target") then
            return e
        end
        if i["TargetRange"] > k("36") then
            return e
        end
        if i["zhandoumoshi"] == k("1") and i["WRSet"]["ND_KYYS"] == k("1") and
            (i["NotUse_ErrorMessageTime"] == g or i["GetTime"]() - i["NotUse_ErrorMessageTime"] > k("10")) then
            local V = i["GetItemCount"]("狂野魔法药水")
            local W, X, Y = i["C_Container"]["GetItemCooldown"](k("40212"))
            if V ~= g and V >= k("1") and W + X - i["GetTime"]() <= k("0") then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CSM", "狂野魔法药水", i["zhandoumoshi"])
                return f
            end
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WRSet"]["ND_JLZH"] == k("1") and i["WR_SpellUsable"]("精灵之火") and
            i["WR_GetUnitDebuffInfo"]("target", "精灵之火") == k("0") and
            i["WR_GetUnitDebuffInfo"]("target", "精灵之火（野性）") == k("0") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSJ", "精灵火", i["zhandoumoshi"])
            return f
        end
        if i["zhandoumoshi"] == k("1") and (i["WRSet"]["ND_SP"] == k("1") or i["WRSet"]["ND_SP"] == k("3")) and
            i["WR_GetEquipCD"](k("13")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CST", "饰品1", i["zhandoumoshi"])
            return f
        end
        if i["zhandoumoshi"] == k("1") and (i["WRSet"]["ND_SP"] == k("2") or i["WRSet"]["ND_SP"] == k("3")) and
            i["WR_GetEquipCD"](k("14")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSF", "饰品2", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["zhandoumoshi"] == k("1") and i["WRSet"]["ND_ZRZL"] == k("1") and
            i["WR_SpellUsable"]("自然之力") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSU", "自然之力", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["zhandoumoshi"] == k("1") and i["WRSet"]["ND_XCYL"] == k("1") and
            i["WR_SpellUsable"]("星辰坠落") then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF11", "星辰坠落", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("星火术") and
            i["WR_GetUnitBuffTime"]("player", k("64823")) > i["GCD"] then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF8", "星火术", i["zhandoumoshi"])
            return f
        end
        if i["WRSet"]["ND_CQ"] ~= k("4") and i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("虫群") and
            (i["PlayerMove"] or i["WRSet"]["ND_CQ"] == k("1") and i["WR_GetUnitBuffInfo"]("player", "日蚀") == k("0") and
                i["WR_GetUnitBuffInfo"]("player", "月蚀") == k("0") and i["CanTrigger_RiShi"]() or i["WRSet"]["ND_CQ"] ==
                k("2")) then
            if i["UnitName"]("target") ~= "强化钢铁根须" and i["UnitName"]("target") ~= "艾欧娜尔的礼物" and
                i["TargetDeathTime"] >= k("9") and i["WR_GetUnitDebuffInfo"]("target", "虫群", f) <= i["GCD"] then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("SF9", "虫群", i["zhandoumoshi"])
                return f
            end
            if i["WRSet"]["ND_ZXDOT"] == k("1") and i["UnitName"]("mouseover") ~= "强化钢铁根须" and
                i["UnitName"]("mouseover") ~= "艾欧娜尔的礼物" and i["WR_GetUnitDeathTime"]("mouseover") >=
                k("9") and i["WR_GetUnitDebuffInfo"]("mouseover", "虫群", f) <= i["GCD"] then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("ACN1", "虫群", i["zhandoumoshi"])
                return f
            end
        end
        if i["WRSet"]["ND_YHS"] ~= k("4") and i["GCD"] <= i["ShiFaSuDu"] and i["WR_SpellUsable"]("月火术") and
            (i["PlayerMove"] or i["WRSet"]["ND_YHS"] == k("1") and i["WR_GetUnitBuffInfo"]("player", "日蚀") == k("0") and
                i["WR_GetUnitBuffInfo"]("player", "月蚀") == k("0") and i["CanTrigger_YueShi"]() or
                i["WRSet"]["ND_YHS"] == k("2")) then
            if i["UnitName"]("target") ~= "强化钢铁根须" and i["UnitName"]("target") ~= "艾欧娜尔的礼物" and
                i["TargetDeathTime"] >= k("9") and i["WR_GetUnitDebuffInfo"]("target", "月火术", f) <= i["GCD"] then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("SF10", "月火术", i["zhandoumoshi"])
                return f
            end
            if i["WRSet"]["ND_ZXDOT"] == k("1") and i["UnitName"]("mouseover") ~= "强化钢铁根须" and
                i["UnitName"]("mouseover") ~= "艾欧娜尔的礼物" and i["WR_GetUnitDeathTime"]("mouseover") >=
                k("9") and i["WR_GetUnitDebuffInfo"]("mouseover", "月火术", f) <= i["GCD"] then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("SF1", "月火术", i["zhandoumoshi"])
                return f
            end
        end
        if i["GCD"] <= i["ShiFaSuDu"] and not i["PlayerMove"] and i["WR_SpellUsable"]("星火术") and
            not i["WR_StopCast"](i["CastTime_XHS"]) and i["BuffTime_XX"] > i["GCD"] + i["CastTime_XHS"] and
            not i["CanTrigger_YueShi"]() then
            if i["WR_GetEquipCD"](k("10")) then
                i["WR_HideColorFrame"](i["zhandoumoshi"])
                i["WR_ShowColorFrame"]("CSG", "手套", i["zhandoumoshi"])
                return f
            end
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF8", "星火术", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and not i["PlayerMove"] and i["WR_SpellUsable"]("愤怒") and
            not i["WR_StopCast"](i["CastTime_FN"]) and
            (i["CanTrigger_YueShi"]() or i["WR_GetUnitBuffInfo"]("player", "日蚀") > i["GCD"] + i["CastTime_FN"]) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF7", "愤怒", i["zhandoumoshi"])
            return f
        end
        if i["WR_GetUnitBuffInfo"]("player", "月蚀") > k("0") and i["WR_GetEquipCD"](k("10")) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("CSG", "手套", i["zhandoumoshi"])
            return f
        end
        if i["GCD"] <= i["ShiFaSuDu"] and not i["PlayerMove"] and i["WR_SpellUsable"]("星火术") and
            not i["WR_StopCast"](i["CastTime_XHS"]) and
            (i["CanTrigger_RiShi"]() or i["WR_GetUnitBuffInfo"]("player", "月蚀") > i["GCD"] + i["CastTime_XHS"]) then
            i["WR_HideColorFrame"](i["zhandoumoshi"])
            i["WR_ShowColorFrame"]("SF8", "星火术", i["zhandoumoshi"])
            return f
        end
    end;
    i["CanTrigger_YueShi"] = function()
        if i["WR_AURA_APPLIED_TIME_48518"] == g or i["WR_AURA_APPLIED_TIME_48518"] ~= g and i["GetTime"]() -
            i["WR_AURA_APPLIED_TIME_48518"] + i["GCD"] + i["CastTime_FN"] > k("30") then
            return f
        end
        return e
    end;
    i["CanTrigger_RiShi"] = function()
        if i["WR_AURA_APPLIED_TIME_48517"] == g or i["WR_AURA_APPLIED_TIME_48517"] ~= g and i["GetTime"]() -
            i["WR_AURA_APPLIED_TIME_48517"] + i["GCD"] + i["CastTime_XHS"] > k("30") then
            return f
        end
        return e
    end
end)()
