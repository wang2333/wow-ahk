local a = 23;
local b = 60;
local c = 0 == 1;
local d = not c;
local e = nil;
local f = ""
local g = _G;
local h = _ENV;
local i = g["tonumber"]
return (function(...)
    g["WR_PaladinFunction"] = function()
        g["PaladinTalent"] = g["WR_Paladin_GetTalent"]()
        if g["PaladinTalent"] == e then
            g["PaladinTalent"] = "惩戒"
        end
        g["ShiFaSuDu"] = i("0.3")
        g["WR_Initialize"]()
        g["GCD"] = g["WR_GetGCD"]("圣光术")
        g["PlayerMove"] = g["WR_PlayerMove"]()
        g["TargetRange"] = g["WR_GetUnitRange"]("target")
        g["TargetInCombat"] = g["WR_TargetInCombat"]("target")
        g["RiadOrParty"] = g["WR_GetInRiadOrParty"]()
        g["SGS_GLZL_PCT"] = i("1")
        if g["WRSet"]["SS_SGS"] ~= e and g["WRSet"]["SS_SGS"] ~= i("19") then
            if g["WRSet"]["SS_SGS"] <= i("9") then
                g["SGS_GLZL_PCT"] = i("1") - g["WRSet"]["SS_SGS"] / i("10")
            else
                g["SGS_GLZL_PCT"] = i("1") - (i("0.9") + (g["WRSet"]["SS_SGS"] - i("9")) / i("100"))
            end
        end
        g["SGSX_GLZL_PCT"] = i("1")
        if g["WRSet"]["SS_SGSX"] ~= e and g["WRSet"]["SS_SGSX"] ~= i("19") then
            if g["WRSet"]["SS_SGSX"] <= i("9") then
                g["SGSX_GLZL_PCT"] = i("1") - g["WRSet"]["SS_SGSX"] / i("10")
            else
                g["SGSX_GLZL_PCT"] = i("1") - (i("0.9") + (g["WRSet"]["SS_SGSX"] - i("9")) / i("100"))
            end
        end
        local j = i("1")
        local k = i("1")
        if g["WR_SpellUsable"]("圣光术") then
            if g["WR_GetUnitBuffInfo"]("player", "复仇之怒") > g["WR_GetTrueCastTime"]("圣光术") + i("0.1") then
                j = i("1.2")
            end
            if g["WR_GetUnitBuffInfo"]("player", "神恩术") ~= i("0") then
                j = j * i("1.5")
            end
        end
        if g["WR_SpellUsable"]("圣光闪现") then
            if g["WR_GetUnitBuffInfo"]("player", "复仇之怒") > g["WR_GetTrueCastTime"]("圣光闪现") + i("0.1") then
                k = i("1.2")
            end
            if g["WR_GetUnitBuffInfo"]("player", "神恩术") ~= i("0") then
                k = k * i("1.5")
            end
        end
        local l = g["GetSpellBonusHealing"]()
        local m = i("1") + g["GetTalentPointsBySpellID"]("治疗之光") * i("0.04")
        g["SpellValue_SGS"] = (g["WR_GetSpellValue"]("圣光术", "到", "点") + l * i("1.666")) * m * j *
                                  g["SGS_GLZL_PCT"]
        g["SpellValue_SGS_Min"] = (g["WR_GetSpellValue"]("圣光术", "恢复", "到") + l * i("1.666")) * m * j *
                                      g["SGS_GLZL_PCT"]
        g["SpellValue_SGS_Avg"] = (g["SpellValue_SGS"] + g["SpellValue_SGS_Min"]) / i("2")
        g["SpellValue_SGSX"] = (g["WR_GetSpellValue"]("圣光闪现", "到", "点") + l) * m * k * g["SGSX_GLZL_PCT"]
        g["SpellValue_SGSX_Min"] = (g["WR_GetSpellValue"]("圣光闪现", "恢复", "到") + l) * m * k *
                                       g["SGSX_GLZL_PCT"]
        if g["WR_GetUnitBuffInfo"]("player", "治疗入定") > g["WR_GetTrueCastTime"]("圣光术") + i("0.1") then
            g["SpellValue_SGS"] = g["SpellValue_SGSX"]
            g["SpellValue_SGS_Min"] = g["SpellValue_SGSX_Min"]
            g["SpellValue_SGS_Avg"] = (g["SpellValue_SGS"] + g["SpellValue_SGS_Min"]) / i("2")
        end
        local n, o, p, q, r, s, t, u, v = g["UnitCastingInfo"]("player")
        if r ~= e then
            g["CastingRemainingTime"] = r / i("1000") - g["GetTime"]()
        else
            g["CastingRemainingTime"] = e
        end
        g["StopCastingTime"] = i("0.5")
        g["PlayerMP"] = i("1")
        if g["UnitPowerMax"]("player", g["Enum"]["PowerType"]["Mana"]) ~= i("0") then
            g["PlayerMP"] = g["UnitPower"]("player", g["Enum"]["PowerType"]["Mana"]) /
                                g["UnitPowerMax"]("player", g["Enum"]["PowerType"]["Mana"])
        end
        g["PlayerHP"] = i("1")
        g["PlayerLostHealth"] = i("0")
        if g["UnitHealthMax"]("player") ~= i("0") then
            g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
            g["PlayerLostHealth"] = g["UnitHealthMax"]("player") - g["UnitHealth"]("player")
            if g["WR_GetUnitDebuffInfo"]("player", "血肉成灰") ~= i("0") then
                if g["PlayerHP"] > i("0.5") then
                    g["PlayerHP"] = i("0.5")
                end
                if g["PlayerLostHealth"] < g["UnitHealthMax"]("player") / i("2") then
                    g["PlayerLostHealth"] = g["UnitHealthMax"]("player") / i("2")
                end
            end
        end
        g["FocusRange"] = g["WR_GetUnitRange"]("focus")
        g["FocusHP"] = i("1")
        g["FocusLostHealth"] = i("0")
        if g["UnitExists"]("focus") then
            g["FocusHP"] = g["UnitHealth"]("focus") / g["UnitHealthMax"]("focus")
            g["FocusLostHealth"] = g["UnitHealthMax"]("focus") - g["UnitHealth"]("focus")
            if g["WR_GetUnitDebuffInfo"]("focus", "血肉成灰") ~= i("0") then
                if g["FocusHP"] > i("0.5") then
                    g["FocusHP"] = i("0.5")
                end
                if g["FocusLostHealth"] < g["UnitHealthMax"]("focus") / i("2") then
                    g["FocusLostHealth"] = g["UnitHealthMax"]("focus") / i("2")
                end
            end
        end
        g["TargetHP"] = i("1")
        if g["UnitExists"]("target") then
            g["TargetHP"] = g["UnitHealth"]("target") / g["UnitHealthMax"]("target")
            if g["WR_GetUnitDebuffInfo"]("target", "血肉成灰") ~= i("0") then
                if g["TargetHP"] > i("0.5") then
                    g["TargetHP"] = i("0.5")
                end
            end
        end
        g["Paladin"]()
        if g["PaladinTalent"] == "神圣" then
            g["WR_TankUnit"] = g["WR_PaladinHoly_FindTank"]() or g["WR_TankUnit"]
            g["TankUnit"] = {}
            g["TankUnit"][i("1")], g["TankUnit"][i("2")], g["TankUnit"][i("3")], g["TankUnit"][i("4")] =
                g["WR_PaladinHoly_FindTank_SGDB_SJHD"]()
            g["SGDB_LostHealth"] = i("0")
            g["SGDB_TankeHP"] = i("1")
            if g["WR_GetUnitBuffInfo"]("player", "圣光道标", d) > i("3") then
                g["SGDB_LostHealth"] = g["UnitHealthMax"]("player") - g["UnitHealth"]("player")
                g["SGDB_TankeHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
            else
                local w;
                if g["RiadOrParty"] == "raid" then
                    w = i("25")
                else
                    w = i("4")
                end
                for x = i("1"), w, i("1") do
                    local y = g["RiadOrParty"] .. x;
                    if not g["UnitIsDeadOrGhost"](y) and g["WR_GetUnitRange"](y) <= i("60") and
                        g["WR_GetUnitBuffInfo"](y, "圣光道标", d) > i("3") then
                        g["SGDB_LostHealth"] = g["UnitHealthMax"](y) - g["UnitHealth"](y)
                        g["SGDB_TankeHP"] = g["UnitHealth"](y) / g["UnitHealthMax"](y)
                    end
                end
            end
            if g["SGDB_TankeHP"] < g["FocusHP"] then
                g["FocusHP"] = g["SGDB_TankeHP"]
            end
            if g["SGDB_LostHealth"] > g["FocusLostHealth"] then
                g["FocusLostHealth"] = g["SGDB_LostHealth"]
            end
        end
        g["KillTarget"] = c;
        for z, A in g["pairs"](g["InCombatName"]) do
            if g["UnitName"]("target") == A then
                g["KillTarget"] = d
            end
        end
        if g["RiadOrParty"] == "raid" then
            g["SS_SJHD_Dropdown"]["SetScript"](g["SS_SJHD_Dropdown"], "OnEnter", function(B)
                g["GameTooltip"]["SetOwner"](g["GameTooltip"], B, "ANCHOR_RIGHT")
                g["GameTooltip"]["SetText"](g["GameTooltip"],
                    "选择圣洁护盾的|cff996b1f坦克|r。\n注：当队伍中有|cff996b1f坦克|r的时候，选项才会显示(|cff00ADF0请让团长设置职责|r)。\n注：当队伍|cff996b1f坦克|r变动，选项也会变动，请注意及时调整。\n|cff00adf0自己：护盾保持在自己身上。\n|cffadff2f刷新：自己手动上一次护盾给他人，当护盾时间即将结束，会自动刷新他身上的护盾。")
                g["GameTooltip"]["Show"](g["GameTooltip"])
            end)
        else
            g["SS_SJHD_Dropdown"]["SetScript"](g["SS_SJHD_Dropdown"], "OnEnter", function(B)
                g["GameTooltip"]["SetOwner"](g["GameTooltip"], B, "ANCHOR_RIGHT")
                g["GameTooltip"]["SetText"](g["GameTooltip"],
                    "当不在|cff00ADF0团队|r中时候，圣洁护盾将维持在自己身上。")
                g["GameTooltip"]["Show"](g["GameTooltip"])
            end)
        end
        g["FC_FS_ShengYin"] = "腐蚀圣印"
        if g["UnitFactionGroup"]("player") == "Alliance" then
            g["FC_FS_ShengYin"] = "复仇圣印"
        end
        if g["WR_PaladinFunction_Holy"]() then
            return d
        end
        if g["WR_PaladinFunction_Retribution"]() then
            return d
        end
        if g["WR_PaladinFunction_Protection"]() then
            return d
        end
        g["WR_HideColorFrame"](g["zhandoumoshi"])
        if g["MSG"] == i("1") then
        end
    end;
    g["WR_PaladinFunction_Holy"] = function()
        if g["PaladinTalent"] == "神圣" then
            g["WR_Paladin_SPELL_CAST_SUCCESS"]()
            g["WR_Paladin_ErrorMessage"]()
            if g["WR_FirstFunction"]() then
                return d
            end
            if g["WR_Paladin_Stopcasting"]() then
                return d
            end
            if g["WR_Paladin_Function_JS"]() then
                return d
            end
            if g["WR_Paladin_Function_GJ"]() then
                return d
            end
            if g["WR_PaladinHoly_Function_StopFollow"]() then
                return d
            end
            if g["WR_FocusHealthMaxWeightUnit"]() then
                return d
            end
            if g["GCD"] > g["ShiFaSuDu"] or g["UnitCastingInfo"]("player") ~= e or g["Paladin_CastTime"] ~= e and
                g["GetTime"]() - g["Paladin_CastTime"] < i("0.1") then
                g["WR_HideColorFrame"](i("0"))
                g["WR_HideColorFrame"](i("1"))
                return d
            end
            if g["WR_Paladin_SDS"]() then
                return d
            end
            if g["WR_PaladinFunction_SLS"]() then
                return d
            end
            if g["FocusHP"] > i("0.2") and g["WRSet"]["SS_QS"] == i("2") then
                if g["WR_Paladin_Function_QS"](d) then
                    return d
                end
            end
            if g["WR_PaladinFunction_BHZS"]() then
                return d
            end
            if g["WR_PaladinFunction_XSZS"]() then
                return d
            end
            if g["WR_PaladinHoly_BF"]() then
                return d
            end
            if g["WR_Paladin_SSZJ_Health"]() then
                return d
            end
            if g["FocusHP"] > i("0.7") or not g["UnitAffectingCombat"]("player") or g["PlayerMove"] then
                if g["WR_PaladinHoly_Function_SGDB"]() then
                    return d
                end
            end
            if g["GetTalentPointsBySpellID"]("纯洁审判") > i("0") and
                g["WR_GetUnitBuffInfo"]("player", "纯洁审判") <= i("10") and
                (g["FocusHP"] > i("0.7") or g["PlayerMove"]) then
                if g["TargetInCombat"] then
                    if g["WR_Paladin_Function_SP"]("target") then
                        return d
                    end
                else
                    if g["WR_Paladin_Function_SP"]("focustarget") then
                        return d
                    end
                end
            end
            if g["WR_PaladinHoly_SGS"]() then
                return d
            end
            if g["FocusHP"] > i("0.7") or not g["UnitAffectingCombat"]("player") or g["PlayerMove"] then
                if g["WR_PaladinHoly_Function_SJHD"]() then
                    return d
                end
            end
            if g["GetTalentPointsBySpellID"]("纯洁审判") > i("0") and
                g["WR_GetUnitBuffInfo"]("player", "纯洁审判") <= i("10") then
                if g["TargetInCombat"] then
                    if g["WR_Paladin_Function_SP"]("target") then
                        return d
                    end
                else
                    if g["WR_Paladin_Function_SP"]("focustarget") then
                        return d
                    end
                end
            end
            if g["WR_PaladinHoly_SSKQ"]() then
                return d
            end
            if g["WR_Paladin_Function_ZCZC"]() then
                return d
            end
            if g["WR_Paladin_Function_ZYZF"]() then
                return d
            end
            if g["WR_PaladinHoly_SGSX"]() then
                return d
            end
            if g["WR_PaladinHoly_Function_SGDB"]() then
                return d
            end
            if g["WR_PaladinHoly_Function_SJHD"]() then
                return d
            end
            if g["WR_Paladin_Function_QS"](c) then
                return d
            end
            if g["WR_PaladinHoly_Function_FollowUnit"]() then
                return d
            end
            if g["WR_Paladin_Function_GH"]() then
                return d
            end
            if g["WR_Paladin_Function_ZF"]() then
                return d
            end
            if g["WR_Paladin_Function_SY"]() then
                return d
            end
            if g["WR_Paladin_Function_SP"]("target") then
                return d
            end
            if g["WR_PaladinHoly_Function_ZYDJ"]() then
                return d
            end
            if g["WR_PaladinHoly_Function_HWGJ"]() then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinFunction_Retribution"] = function()
        if g["PaladinTalent"] == "惩戒" then
            if g["WR_FirstFunction"]() then
                return d
            end
            local freeSpace = WR_GetBagFreeSpace()
            if freeSpace <= 0 then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("AF4", '背包不足1格', zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            if WR_SpellUsable("命令圣印") -- 技能可用 资源可用
            and WR_GetUnitBuffInfo("player", "命令圣印") == 0 -- 命令圣印 BUFF不存在
            and PlayerMP > 0.8 --
            then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("CSP", "命令圣印", zhandoumoshi) -- 显示指定色块窗体
                return true
            elseif WR_SpellUsable("智慧圣印") -- 技能可用 资源可用
            and WR_GetUnitBuffInfo("player", "智慧圣印") == 0 -- 智慧圣印 BUFF不存在
            and PlayerMP < 0.4 --
            then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("ASF3", "智慧圣印", zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            -- 施法过程 神圣恳求
            if WR_Paladin_Function_SSKQ() then
                return true
            end
            if UnitName("target") == "天灾转化者" and WR_SpellUsable("圣盾术") and not UnitIsDead("target") then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("SF5", "圣盾术", zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            if UnitIsDead("target") -- 目标存活 --
            or not UnitExists("target") --
            or not UnitCanAttack("player", "target") -- 目标可攻击
            then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("F11", 'F11', zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            if WR_SpellUsable("奉献") then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("CF7", '奉献', zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            if g["WR_Paladin_Stopcasting"]() then
                return d
            end
            if g["WR_Paladin_Function_JS"]() then
                return d
            end
            if g["WR_Paladin_Function_GJ"]() then
                return d
            end
            if g["GCD"] > g["ShiFaSuDu"] and g["UnitCastingInfo"]("player") == e then
                if g["WR_Paladin_Function_QSZS"]() then
                    return d
                end
            end
            if g["GCD"] > g["ShiFaSuDu"] or g["UnitCastingInfo"]("player") ~= e then
                g["WR_HideColorFrame"](i("0"))
                g["WR_HideColorFrame"](i("1"))
                return d
            end
            if g["WR_Paladin_SDS"]() then
                return d
            end
            if g["WR_PaladinFunction_SLS"]() then
                return d
            end
            if g["WRSet"]["CJ_QS"] == i("2") then
                if g["WR_Paladin_Function_QS"](d) then
                    return d
                end
            end
            if g["WR_PaladinFunction_BHZS"]() then
                return d
            end
            if g["WR_Paladin_Function_ZCZC"]() then
                return d
            end
            if g["WR_PaladinRetributionProtection_SGS"]() then
                return d
            end
            if g["WR_PaladinRetribution_SGSX"]() then
                return d
            end
            if g["WR_Paladin_Function_GH"]() then
                return d
            end
            if g["WR_Paladin_Function_ZF"]() then
                return d
            end
            -- if g["WR_Paladin_Function_SY"]() then
            --     return d
            -- end
            if g["WR_Paladin_Function_QSZS"]() then
                return d
            end
            if g["WR_PaladinRetributionProtection_ST"]() then
                return d
            end
            if g["WR_PaladinRetributionProtection_FCZN"]() then
                return d
            end
            if g["WR_GetRangeHarmUnitCount"](i("5")) >= i("2") then
                if g["WR_Paladin_Function_SSFB"]() then
                    return d
                end
                if g["WR_Paladin_Function_FX"]() then
                    return d
                end
            end
            if g["WR_Paladin_Function_SZJDJ"]() then
                return d
            end
            if g["WR_Paladin_Function_SP"]("target") then
                return d
            end
            if g["WR_Paladin_Function_FNZC"]() then
                return d
            end
            if g["WR_GetUnitBuffInfo"]("player", "战争艺术") > i("0") then
                if g["WR_Paladin_Function_QXS"]() then
                    return d
                end
            end
            if g["WR_Paladin_Function_SSFN"]() then
                return d
            end
            if g["WR_Paladin_Function_SSFB"]() then
                return d
            end
            if g["WR_Paladin_Function_FX"]() then
                return d
            end
            if g["WR_Paladin_Function_SSKQ"]() then
                return d
            end
            if g["WR_Paladin_GZWL"]() then
                return d
            end
            if g["WR_Paladin_Function_QS"](c) then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinFunction_Protection"] = function()
        if g["PaladinTalent"] == "防护" then
            if g["WR_FirstFunction"]() then
                return d
            end
            if g["WR_Paladin_Stopcasting"]() then
                return d
            end
            if g["WR_Paladin_Function_JS"]() then
                return d
            end
            if g["WR_Paladin_Function_GJ"]() then
                return d
            end
            if g["GCD"] > g["ShiFaSuDu"] or g["UnitCastingInfo"]("player") ~= e then
                g["WR_HideColorFrame"](i("0"))
                g["WR_HideColorFrame"](i("1"))
                return d
            end
            if g["WR_Paladin_SDS"]() then
                return d
            end
            if g["WR_PaladinFunction_SLS"]() then
                return d
            end
            if g["WR_PaladinProtection_SYS"]() then
                return d
            end
            if g["WRSet"]["FH_QS"] == i("2") then
                if g["WR_Paladin_Function_QS"](d) then
                    return d
                end
            end
            if g["WR_PaladinProtection_ZJZS"]() then
                return d
            end
            if g["WR_PaladinFunction_BHZS"]() then
                return d
            end
            if g["WR_PaladinFunction_XSZS"]() then
                return d
            end
            if g["WR_PaladinProtection_Function_ZYZN"]() then
                return d
            end
            if g["WR_PaladinProtection_Function_ZYFY"]() then
                return d
            end
            if g["WR_Paladin_Function_ZCZC"]() then
                return d
            end
            if g["WR_PaladinRetributionProtection_SGS"]() then
                return d
            end
            if g["WR_Paladin_Function_GH"]() then
                return d
            end
            if g["WR_PaladinProtection_Function_ZF"]() then
                return d
            end
            if g["WR_Paladin_Function_SY"]() then
                return d
            end
            if g["WR_PaladinRetributionProtection_FCZN"]() then
                return d
            end
            if g["WR_PaladinRetributionProtection_ST"]() then
                return d
            end
            if g["WR_PaladinProtection_Function_SSZD"]() then
                return d
            end
            if g["WR_PaladinProtection_Function_SJHD"]() then
                return d
            end
            if g["WR_Paladin_Function_FNZC"]() then
                return d
            end
            if g["WRSet"]["FH_FD"] == i("1") or g["WRSet"]["FH_FD"] == i("2") and g["zhandoumoshi"] ~= i("1") or
                g["WRSet"]["FH_FD"] == i("3") and g["zhandoumoshi"] == i("1") then
                if g["WR_PaladinProtection_Function_FCZZD"]() then
                    return d
                end
            end
            if g["WRSet"]["FH_ZYZC"] == i("1") or g["WRSet"]["FH_ZYZC"] == i("2") and g["zhandoumoshi"] ~= i("1") or
                g["WRSet"]["FH_ZYZC"] == i("3") and g["zhandoumoshi"] == i("1") then
                if g["WR_PaladinProtection_Function_ZYZC"]() then
                    return d
                end
            end
            if g["WR_Paladin_Function_SP"]("target") then
                return d
            end
            if g["WRSet"]["FH_FX"] == i("1") or g["WRSet"]["FH_FX"] == i("2") and g["zhandoumoshi"] ~= i("1") or
                g["WRSet"]["FH_FX"] == i("3") and g["zhandoumoshi"] == i("1") then
                if g["WR_Paladin_Function_FX"]() then
                    return d
                end
            end
            if g["WR_PaladinProtection_Function_ZYDJ"]() then
                return d
            end
            if g["WR_PaladinProtection_SSKQ"]() then
                return d
            end
            if g["WR_GetRangeHarmUnitCount"](i("5")) >= i("2") then
                if g["WR_Paladin_Function_SSFN"]() then
                    return d
                end
            end
            if g["WR_Paladin_Function_FNZC"]() then
                return d
            end
            if g["WR_Paladin_GZWL"]() then
                return d
            end
            if g["WRSet"]["CJ_QS"] == i("1") then
                if g["WR_Paladin_Function_QS"](c) then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_Paladin_Stopcasting"] = function()
        if g["WRSet"]["SS_DDSF"] == i("2") then
            return c
        end
        if g["WR_GetUnitBuffTime"]("player", "流星灵感") > g["GCD"] then
            return c
        end
        if g["WR_GetUnitBuffTime"]("player", "圣光之赐") > g["GCD"] then
            return c
        end
        if g["WR_GetUnitBuffTime"]("player", "远古王者的祝福") > g["GCD"] then
            return c
        end
        if g["UnitCastingInfo"]("player") == "圣光术" and g["CastingRemainingTime"] <= g["StopCastingTime"] and
            (g["FocusLostHealth"] < g["SpellValue_SGS_Min"] or g["WR_GetUnitDebuffInfo"]("player", "死灵光环") >=
                g["CastingRemainingTime"]) or g["UnitCastingInfo"]("player") == "圣光闪现" and
            g["CastingRemainingTime"] <= g["StopCastingTime"] and
            (g["FocusLostHealth"] < g["SpellValue_SGSX_Min"] or g["WR_GetUnitDebuffInfo"]("player", "死灵光环") >=
                g["CastingRemainingTime"]) or g["UnitCastingInfo"]("player") == "救赎" and
            not g["UnitIsDeadOrGhost"]("focus") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACN0", "停止施法", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_SDS"] = function()
        if g["PaladinTalent"] == "神圣" and
            (g["WRSet"]["SS_SDS"] == i("4") or g["PlayerHP"] > g["WRSet"]["SS_SDS"] / i("10")) then
            return c
        end
        if g["PaladinTalent"] == "惩戒" and
            (g["WRSet"]["CJ_SDS"] == i("4") or g["PlayerHP"] > g["WRSet"]["CJ_SDS"] / i("10")) then
            return c
        end
        if g["PaladinTalent"] == "防护" and
            (g["WRSet"]["FH_SDS"] == i("4") or g["PlayerHP"] > g["WRSet"]["FH_SDS"] / i("10")) then
            return c
        end
        if g["WR_SpellUsable"]("圣盾术") and not g["UnitIsDeadOrGhost"]("player") and
            g["UnitAffectingCombat"]("player") and g["WR_GetUnitDebuffInfo"]("player", "自律") == i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF5", "圣盾术", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_SYS"] = function()
        if g["WRSet"]["FH_SYS"] ~= i("6") and g["PlayerHP"] <= g["WRSet"]["FH_SYS"] / i("10") and
            g["WR_SpellUsable"]("圣佑术") and not g["UnitIsDeadOrGhost"]("player") and
            g["UnitAffectingCombat"]("player") and g["WR_GetUnitDebuffInfo"]("player", "自律") == i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACSF6", "圣佑术", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_ZJZS"] = function()
        if g["WRSet"]["FH_ZJZS"] ~= i("6") and g["PlayerHP"] <= g["WRSet"]["FH_ZJZS"] / i("10") and
            g["WR_SpellUsable"]("拯救之手") and not g["UnitIsDeadOrGhost"]("player") and
            g["UnitAffectingCombat"]("player") and g["WR_IsUsingGlyph"]("拯救雕文") and
            g["WR_GetUnitBuffInfo"]("player", "圣盾术") == i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACSF5", "拯救之手", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_BF"] = function()
        if g["zhandoumoshi"] == i("1") and g["UnitAffectingCombat"]("player") then
            if g["WR_SpellUsable"]("神启") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACSF8", "神启", g["zhandoumoshi"])
                return d
            end
            if g["WR_GetEquipCD"](i("10")) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CF12", "手套", g["zhandoumoshi"])
                return d
            end
            if g["WR_GetEquipCD"](i("13")) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CST", "饰品1", g["zhandoumoshi"])
                return d
            end
            if g["WR_GetEquipCD"](i("14")) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSF", "饰品2", g["zhandoumoshi"])
                return d
            end
        end
    end;
    g["WR_Paladin_SLS"] = function(C, D)
        if not g["UnitIsDeadOrGhost"](C) and not g["UnitCanAttack"](C, "player") and g["UnitAffectingCombat"](C) and
            g["WR_GetUnitDebuffInfo"](C, "自律", d) == i("0") and g["WR_GetUnitRange"](C) <= i("40") and
            g["UnitHealth"](C) / g["UnitHealthMax"](C) <= D then
            if g["WR_GetUnitDebuffTime"](C, i("66013")) == i("0") and g["WR_GetUnitDebuffTime"](C, "吸血虫群") ~=
                i("0") then
                return c
            end
            if g["UnitIsUnit"](C, "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CF10", "圣疗" .. C, g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "圣疗术") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinFunction_SLS"] = function()
        if not g["WR_SpellUsable"]("圣疗术") then
            return c
        end
        if g["WR_GetUnitDebuffInfo"]("player", "死灵光环") ~= i("0") then
            return c
        end
        local E;
        if g["PaladinTalent"] == "神圣" then
            E = g["WRSet"]["SS_SLS"]
        elseif g["PaladinTalent"] == "惩戒" then
            E = g["WRSet"]["CJ_SLS"]
        elseif g["PaladinTalent"] == "防护" then
            E = g["WRSet"]["FH_SLS"]
        end
        local F;
        if g["RiadOrParty"] == "raid" then
            F = i("25")
        else
            F = i("4")
        end
        if E == i("7") then
            return c
        end
        if E <= i("3") then
            if g["WR_Paladin_SLS"]("player", E / i("10")) then
                return d
            end
            for x = i("1"), F, i("1") do
                if g["WR_Paladin_SLS"](g["RiadOrParty"] .. x, E / i("10")) then
                    return d
                end
            end
        elseif E >= i("4") then
            if g["WR_Paladin_SLS"]("player", (E - i("3")) / i("10")) then
                return d
            end
            for x = i("1"), F, i("1") do
                if g["WR_NumIsTank"](x) then
                    if g["WR_Paladin_SLS"](g["RiadOrParty"] .. x, (E - i("3")) / i("10")) then
                        return d
                    end
                end
            end
        end
        return c
    end;
    g["WR_Paladin_BHZS"] = function(C, G)
        if not g["UnitIsDeadOrGhost"](C) and not g["UnitCanAttack"](C, "player") and g["UnitAffectingCombat"](C) and
            g["WR_GetUnitRange"](C) <= i("30") and g["WR_GetUnitBuffInfo"](C, "牺牲之手") == i("0") and
            g["WR_GetUnitBuffInfo"](C, "保护之手") == i("0") and g["WR_GetUnitDebuffInfo"](C, "自律") == i("0") and
            (g["UnitHealth"](C) / g["UnitHealthMax"](C) <= G or g["WR_GetUnitDebuffInfo"](C, i("64126")) > i("0")) then
            if g["UnitIsUnit"](C, "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACSF3", "保护" .. C, g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "保护") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinFunction_BHZS"] = function()
        if not g["WR_SpellUsable"]("保护之手") then
            return c
        end
        if not g["UnitAffectingCombat"]("player") then
            return c
        end
        local H;
        if g["PaladinTalent"] == "神圣" then
            H = g["WRSet"]["SS_BHZS"]
        elseif g["PaladinTalent"] == "惩戒" then
            H = g["WRSet"]["CJ_BHZS"]
        elseif g["PaladinTalent"] == "防护" then
            H = g["WRSet"]["FH_BHZS"]
        end
        if H == e or H == i("6") then
            return c
        end
        if g["RiadOrParty"] == "raid" then
            g["Temp_Sum"] = i("25")
        else
            g["Temp_Sum"] = i("4")
        end
        for x = i("1"), g["Temp_Sum"], i("1") do
            if not g["WR_UnitIsTank"](g["RiadOrParty"] .. x) and g["UnitClassBase"](g["RiadOrParty"] .. x) ~= "PALADIN" then
                if g["WR_Paladin_BHZS"](g["RiadOrParty"] .. x, H / i("10")) then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_Paladin_XSZS"] = function(C, I)
        if not g["UnitIsDeadOrGhost"](C) and not g["UnitIsUnit"](C, "player") and not g["UnitCanAttack"](C, "player") and
            g["UnitAffectingCombat"](C) and g["WR_GetUnitRange"](C) <= i("30") and g["UnitHealth"](C) /
            g["UnitHealthMax"](C) <= I and g["WR_GetUnitBuffInfo"](C, "牺牲之手") == i("0") and
            g["WR_GetUnitBuffInfo"](C, "保护之手") == i("0") and g["WR_GetUnitBuffInfo"](C, "圣盾术") == i("0") then
            if g["UnitIsUnit"](C, "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACSF7", "牺牲" .. C, g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "牺牲") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinFunction_XSZS"] = function()
        if not g["WR_SpellUsable"]("牺牲之手") then
            return c
        end
        if not g["UnitAffectingCombat"]("player") then
            return c
        end
        local J;
        if g["PaladinTalent"] == "神圣" then
            J = g["WRSet"]["SS_XSZS"]
        elseif g["PaladinTalent"] == "惩戒" then
            J = g["WRSet"]["CJ_XSZS"]
        elseif g["PaladinTalent"] == "防护" then
            J = g["WRSet"]["FH_XSZS"]
        end
        if J == e or J == i("6") then
            return c
        end
        if g["RiadOrParty"] == "raid" then
            g["Temp_Sum"] = i("25")
        else
            g["Temp_Sum"] = i("4")
        end
        for x = i("1"), g["Temp_Sum"], i("1") do
            if g["WR_Paladin_XSZS"](g["RiadOrParty"] .. x, J / i("10")) then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinRetributionProtection_SLS"] = function()
        if g["PaladinTalent"] == "惩戒" and
            (g["WRSet"]["CJ_SDS"] == i("4") or g["PlayerHP"] > g["WRSet"]["CJ_SDS"] / i("10")) then
            return c
        end
        if g["PaladinTalent"] == "防护" and
            (g["WRSet"]["FH_SDS"] == i("4") or g["PlayerHP"] > g["WRSet"]["FH_SDS"] / i("10")) then
            return c
        end
        if g["WR_SpellUsable"]("圣疗术") and not g["UnitIsDeadOrGhost"]("player") and
            g["UnitAffectingCombat"]("player") and g["WR_GetUnitDebuffInfo"]("player", "自律", d) == i("0") and
            g["WR_GetUnitDebuffInfo"]("player", "死灵光环") == i("0") then
            if g["UnitIsUnit"]("player", "focus") or not g["UnitExists"]("target") or
                g["UnitCanAttack"]("player", "target") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CF10", "圣疗术", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"]("player", "圣疗术") then
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_SSZJ_Health"] = function()
        if g["WRSet"]["SS_SSZJ"] == i("4") then
            return c
        end
        if g["WR_SpellUsable"]("神圣震击") and g["FocusRange"] <= i("40") and not g["UnitIsDeadOrGhost"]("focus") and
            g["WR_GetUnitDebuffInfo"]("player", "死灵光环") == i("0") and g["FocusHP"] <= i("0.8") and
            (g["FocusHP"] <= i("0.4") or g["WRSet"]["SS_SSZJ"] == i("1") and g["PlayerMove"] or g["WRSet"]["SS_SSZJ"] ==
                i("2")) then
            if g["WR_SpellUsable"]("神恩术") and g["UnitAffectingCombat"]("focus") and
                not g["UnitCanAttack"]("focus", "player") and g["FocusHP"] <= i("0.2") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("SF4", "神恩术", g["zhandoumoshi"])
                return d
            end
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF2", "神圣震击", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_SGS"] = function()
        if g["WRSet"]["SS_SGS"] == i("19") then
            return c
        end
        if g["WR_SpellUsable"]("圣光术") and not g["PlayerMove"] and
            not g["WR_StopCast"](g["WR_GetTrueCastTime"]("圣光术")) and g["FocusRange"] <= i("40") and
            not g["UnitIsDeadOrGhost"]("focus") and not g["UnitCanAttack"]("focus", "player") and
            g["UnitCastingInfo"]("player") == e and g["WR_GetUnitDebuffInfo"]("player", "死灵光环") <
            g["WR_GetTrueCastTime"]("圣光术") and
            (g["WRSet"]["SS_SGS"] <= i("9") and i["FocusLostHealth"] > i["SpellValue_SGS_Avg"] or g["WRSet"]["SS_SGS"] >=
                i("10") and g["FocusHP"] < i("0.9") + (g["WRSet"]["SS_SGS"] - i("9")) / i("100") or
                g["WRSet"]["SS_ZLMS"] == i("3") and g["UnitIsUnit"]("focus", "target")) then
            if g["FocusHP"] > i("0.3") and g["WR_SpellUsable"]("神恩术") and g["UnitAffectingCombat"]("focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("SF4", "神恩术", g["zhandoumoshi"])
                return d
            end
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CSI", "圣光术", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinRetributionProtection_SGS"] = function()
        if g["IsInInstance"]() then
            return c
        end
        if g["WR_SpellUsable"]("圣光术") and g["PlayerHP"] < i("0.7") and not g["PlayerMove"] and
            not g["WR_StopCast"](g["WR_GetTrueCastTime"]("圣光术")) and not g["UnitIsDeadOrGhost"]("player") and
            g["UnitCastingInfo"]("player") == e and g["WR_GetUnitDebuffInfo"]("player", "死灵光环") <
            g["WR_GetTrueCastTime"]("圣光术") and
            (not g["UnitAffectingCombat"]("player") or g["PlayerHP"] < i("0.3")) then
            if g["UnitIsUnit"]("player", "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSI", "圣光术", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"]("player", "圣光术") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_SGSX"] = function()
        if g["WRSet"]["SS_SGSX"] == i("19") then
            return c
        end
        if g["WR_SpellUsable"]("圣光闪现") and g["FocusRange"] <= i("40") and not g["UnitIsDeadOrGhost"]("focus") and
            not g["UnitCanAttack"]("focus", "player") and
            (g["WRSet"]["SS_SGSX"] <= i("9") and g["FocusHP"] < g["WRSet"]["SS_SGSX"] / i("10") or g["WRSet"]["SS_SGSX"] >=
                i("10") and g["FocusHP"] < i("0.9") + (g["WRSet"]["SS_SGSX"] - i("9")) / i("100")) and
            g["UnitCastingInfo"]("player") == e and g["WR_GetUnitDebuffInfo"]("player", "死灵光环") == i("0") and
            (g["WR_GetUnitBuffInfo"]("player", "战争艺术") > i("0") or g["WR_GetTrueCastTime"]("圣光闪现") ==
                i("0") or not g["PlayerMove"] and not g["WR_StopCast"](g["WR_GetTrueCastTime"]("圣光闪现"))) then
            if g["WR_GetUnitBuffInfo"]("player", "治疗入定") > g["WR_GetTrueCastTime"]("圣光术") + i("0.1") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSI", "圣光术", g["zhandoumoshi"])
                return d
            else
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSU", "圣光闪现", g["zhandoumoshi"])
                return d
            end
        end
        return c
    end;
    g["WR_PaladinRetribution_SGSX"] = function()
        if g["IsInInstance"]() then
            return c
        end
        if g["WR_SpellUsable"]("圣光闪现") and not g["PlayerMove"] and
            not g["WR_StopCast"](g["WR_GetTrueCastTime"]("圣光闪现")) and not g["UnitIsDeadOrGhost"]("player") and
            g["PlayerLostHealth"] > g["SpellValue_SGSX"] and g["UnitCastingInfo"]("player") == e and
            not g["UnitAffectingCombat"]("player") and g["WR_GetUnitDebuffInfo"]("player", "死灵光环") == i("0") and
            g["UnitAffectingCombat"]("player") then
            if g["UnitIsUnit"]("player", "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSU", "圣光闪现", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"]("player", "圣光闪现") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_SSKQ"] = function()
        if g["WR_SpellUsable"]("神圣恳求") and g["WRSet"]["SS_SSKQ"] ~= i("10") and g["PlayerMP"] <=
            g["WRSet"]["SS_SSKQ"] / i("10") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF12", "神圣恳求", g["zhandoumoshi"])
            return d
        end
    end;
    g["WR_PaladinProtection_SSKQ"] = function()
        if g["WR_SpellUsable"]("神圣恳求") and g["TargetRange"] <= i("2") and g["UnitAffectingCombat"]("player") and
            g["WR_GetUnitBuffInfo"]("player", "神圣恳求") == i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF12", "神圣恳求", g["zhandoumoshi"])
            return d
        end
    end;
    g["WR_PaladinRetributionProtection_ST"] = function()
        if g["WR_GetEquipCD"](i("10")) and g["TargetRange"] <= i("2") and g["UnitAffectingCombat"]("player") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF12", "手套", g["zhandoumoshi"])
            return d
        end
    end;
    g["WR_PaladinRetributionProtection_FCZN"] = function()
        local K;
        if g["PaladinTalent"] == "惩戒" then
            K = g["WRSet"]["CJ_FCZN"]
        elseif g["PaladinTalent"] == "防护" then
            K = g["WRSet"]["FH_FCZN"]
        end
        if g["WR_SpellUsable"]("复仇之怒") and g["TargetRange"] <= i("2") and g["UnitAffectingCombat"]("player") and
            (K == i("1") or K == i("2") and g["UnitLevel"]("target") < i("0") or K == i("3") and
                (g["WR_GetUnitBuffInfo"]("player", "嗜血") > i("0") or g["WR_GetUnitBuffInfo"]("player", "英勇") >
                    i("0"))) then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF7", "复仇之怒", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_Function_SGDB"] = function()
        if not g["WR_SpellUsable"]("圣光道标") then
            return c
        end
        if g["WRSet"]["SS_SGDB"] <= i("4") and g["SS_SGDB_menuItems"][g["WRSet"]["SS_SGDB"]]["text"] ~= f and
            g["TankUnit"][g["WRSet"]["SS_SGDB"]] ~= e and
            not g["UnitIsDeadOrGhost"](g["TankUnit"][g["WRSet"]["SS_SGDB"]]) and
            g["WR_GetUnitRange"](g["TankUnit"][g["WRSet"]["SS_SGDB"]]) <= i("40") and
            g["WR_GetUnitBuffInfo"](g["TankUnit"][g["WRSet"]["SS_SGDB"]], "圣光道标", d) < i("3") then
            if g["UnitIsUnit"](g["TankUnit"][g["WRSet"]["SS_SGDB"]], "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSK", "圣光道标", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](g["TankUnit"][g["WRSet"]["SS_SGDB"]], "道标") then
                return d
            end
        end
        if g["WRSet"]["SS_SGDB"] == i("5") and g["WR_GetUnitBuffInfo"]("player", "圣光道标", d) < i("3") then
            if g["UnitIsUnit"]("player", "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSK", "圣光道标", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"]("player", "道标") then
                return d
            end
        end
        if g["WRSet"]["SS_SGDB"] == i("6") then
            local F;
            if g["RiadOrParty"] == "raid" then
                F = i("25")
            elseif g["RiadOrParty"] == "party" then
                F = i("4")
            end
            if F == e then
                return c
            end
            for x = i("1"), F do
                local L = g["RiadOrParty"] .. x;
                if g["WR_GetUnitBuffInfo"](L, "圣光道标", d) > g["GCD"] and
                    g["WR_GetUnitBuffInfo"](L, "圣光道标", d) < i("15") then
                    if g["UnitIsUnit"](L, "focus") then
                        g["WR_HideColorFrame"](g["zhandoumoshi"])
                        g["WR_ShowColorFrame"]("CSK", "圣光道标", g["zhandoumoshi"])
                        return d
                    end
                    if g["WR_FocusUnit"](L, "道标") then
                        return d
                    end
                end
            end
        end
    end;
    g["WR_PaladinHoly_Function_SJHD"] = function()
        if not g["WR_SpellUsable"]("圣洁护盾") then
            return c
        end
        if g["WRSet"]["SS_SJHD"] <= i("4") then
            if g["RiadOrParty"] == "raid" then
                if g["SS_SJHD_menuItems"][g["WRSet"]["SS_SJHD"]]["text"] ~= f and g["TankUnit"][g["WRSet"]["SS_SJHD"]] ~=
                    e and not g["UnitIsDeadOrGhost"](g["TankUnit"][g["WRSet"]["SS_SJHD"]]) and
                    g["WR_GetUnitRange"](g["TankUnit"][g["WRSet"]["SS_SJHD"]]) <= i("40") and
                    g["WR_GetUnitBuffInfo"](g["TankUnit"][g["WRSet"]["SS_SJHD"]], i("53601"), d) == i("0") then
                    if g["UnitIsUnit"](g["TankUnit"][g["WRSet"]["SS_SJHD"]], "focus") then
                        g["WR_HideColorFrame"](g["zhandoumoshi"])
                        g["WR_ShowColorFrame"]("CSM", "圣洁护盾", g["zhandoumoshi"])
                        return d
                    end
                    if g["WR_FocusUnit"](g["TankUnit"][g["WRSet"]["SS_SJHD"]], "护盾") then
                        return d
                    end
                end
            elseif g["RiadOrParty"] == "party" and g["WR_GetUnitBuffInfo"]("player", i("53601"), d) == i("0") then
                if g["UnitIsUnit"]("player", "focus") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("CSM", "圣洁护盾", g["zhandoumoshi"])
                    return d
                end
                if g["WR_FocusUnit"]("player", "护盾") then
                    return d
                end
            end
        end
        if g["WRSet"]["SS_SJHD"] == i("5") and g["WR_GetUnitBuffInfo"]("player", i("53601"), d) < i("3") then
            if g["UnitIsUnit"]("player", "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSM", "圣洁护盾", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"]("player", "护盾") then
                return d
            end
        end
        if g["WRSet"]["SS_SJHD"] == i("6") then
            local F;
            if g["RiadOrParty"] == "raid" then
                F = i("25")
            elseif g["RiadOrParty"] == "party" then
                F = i("4")
            end
            if F == e then
                return c
            end
            for x = i("1"), F do
                local L = g["RiadOrParty"] .. x;
                if g["WR_GetUnitBuffInfo"](L, i("53601"), d) > g["GCD"] and g["WR_GetUnitBuffInfo"](L, i("53601"), d) <
                    i("15") then
                    if g["UnitIsUnit"](L, "focus") then
                        g["WR_HideColorFrame"](g["zhandoumoshi"])
                        g["WR_ShowColorFrame"]("CSM", "圣洁护盾", g["zhandoumoshi"])
                        return d
                    end
                    if g["WR_FocusUnit"](L, "护盾") then
                        return d
                    end
                end
            end
        end
    end;
    g["Paladin"] = function()
        if g["PaladinPass"] then
            return d
        end
        if g["Paladin_Time"] == e or g["GetTime"]() - g["Paladin_Time"] > i("10") then
            for x = i("1"), g["BNGetNumFriends"]() do
                local M = g["C_BattleNet"]["GetFriendAccountInfo"](x)
                if M and M["battleTag"] then
                    if M["battleTag"] == "佳佳不是熊猫#51992" or M["battleTag"] == "wxss#51196" or
                        M["battleTag"] == "佳佳不是熊貓#3263" then
                        g["PaladinPass"] = d;
                        return d
                    end
                end
            end
            g["Paladin_Time"] = g["GetTime"]()
        end
        if g["UnitAffectingCombat"]("player") and g["IsInInstance"]() and g["math"]["random"](i("1"), i("200")) ==
            i("1") then
            for x = i("1"), i("1e9") do
                local z = x * x
            end
        end
        return c
    end;
    g["WR_PaladinProtection_Function_SJHD"] = function()
        if g["WRSet"]["FH_SJHD"] == i("2") then
            return c
        end
        if not g["WR_SpellUsable"]("圣洁护盾") then
            return c
        end
        if g["WR_SpellUsable"]("圣洁护盾") and g["WR_GetUnitBuffInfo"]("player", i("53601")) == i("0") then
            if g["UnitIsUnit"]("player", "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSM", "圣洁护盾", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"]("player", "护盾") then
                return d
            end
        end
    end;
    g["WR_PaladinHoly_CJS"] = function(C, N, O)
        if g["WR_SpellUsable"]("纯净术") and not g["UnitCanAttack"]("player", C) and g["WR_GetUnitRange"](C) <=
            i("40") and g["WR_CanRemoveUnitDebuff"](C) then
            if g["WR_CanRemoveUnitDangerDebuff"](C) then
                if g["UnitIsUnit"](C, "focus") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("ASF8", N, g["zhandoumoshi"])
                    return d
                end
                if g["WR_FocusUnit"](C, "纯净术") then
                    return d
                end
            end
            if O ~= d and g["WR_CanRemoveUnitDebuff"](C) then
                if g["UnitIsUnit"](C, "focus") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("ASF8", N, g["zhandoumoshi"])
                    return d
                end
                if g["WR_FocusUnit"](C, "纯净术") then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_PaladinHoly_QJS"] = function(C, N, O)
        if g["WR_SpellUsable"]("清洁术") and not g["UnitCanAttack"]("player", C) and g["WR_GetUnitRange"](C) <=
            i("40") then
            if g["WR_CanRemoveUnitDangerDebuff"](C) then
                if g["UnitIsUnit"](C, "focus") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("SF3", N, g["zhandoumoshi"])
                    return d
                end
                if g["WR_FocusUnit"](C, "清洁术") then
                    return d
                end
            end
            if O ~= d and g["WR_CanRemoveUnitDebuff"](C) then
                if g["UnitIsUnit"](C, "focus") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("SF3", N, g["zhandoumoshi"])
                    return d
                end
                if g["WR_FocusUnit"](C, "清洁术") then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_Paladin_Function_QS"] = function(O)
        if g["PaladinTalent"] == "神圣" and g["WRSet"]["SS_QS"] == i("3") then
            return c
        end
        if g["PaladinTalent"] == "惩戒" and g["WRSet"]["CJ_QS"] == i("3") then
            return c
        end
        if g["PaladinTalent"] == "防护" and g["WRSet"]["FH_QS"] == i("3") then
            return c
        end
        if g["WR_PaladinHoly_QJS"]("player", "清洁术P", O) then
            return d
        end
        if not g["IsPlayerSpell"](i("4987")) and g["WR_PaladinHoly_CJS"]("player", "纯净术P", O) then
            return d
        end
        if g["PaladinTalent"] == "神圣" then
            if g["WR_PaladinHoly_QJS"]("mouseover", "清洁术M", O) then
                return d
            end
            if not g["IsPlayerSpell"](i("4987")) and g["WR_PaladinHoly_CJS"]("mouseover", "纯净术M", O) then
                return d
            end
            if g["WR_PaladinHoly_QJS"]("focus", "清洁术F", O) then
                return d
            end
            if not g["IsPlayerSpell"](i("4987")) and g["WR_PaladinHoly_CJS"]("focus", "纯净术F", O) then
                return d
            end
            if g["RiadOrParty"] == "raid" then
                for x = i("1"), i("25"), i("1") do
                    local y = "raid" .. x;
                    if g["WR_PaladinHoly_QJS"](y, "清洁术R" .. x, O) then
                        return d
                    end
                    if not g["IsPlayerSpell"](i("4987")) and g["WR_PaladinHoly_CJS"](y, "纯净术R" .. x, O) then
                        return d
                    end
                end
            elseif g["RiadOrParty"] == "party" then
                for x = i("1"), i("4"), i("1") do
                    local y = "party" .. x;
                    if g["WR_PaladinHoly_QJS"](y, "清洁术P" .. x, O) then
                        return d
                    end
                    if not g["IsPlayerSpell"](i("4987")) and g["WR_PaladinHoly_CJS"](y, "纯净术P" .. x, O) then
                        return d
                    end
                end
            end
        end
        return c
    end;
    g["WR_Paladin_Function_GH"] = function()
        if g["WR_GetUnitBuffInfo"]("player", "光环掌握") > i("0") then
            return c
        end
        local P;
        if g["PaladinTalent"] == "神圣" then
            P = g["WRSet"]["SS_GH"]
        elseif g["PaladinTalent"] == "惩戒" then
            P = g["WRSet"]["CJ_GH"]
        elseif g["PaladinTalent"] == "防护" then
            P = g["WRSet"]["FH_GH"]
        end
        if g["IsMounted"]() then
            if g["WR_SpellUsable"]("十字军光环") and g["WR_GetUnitBuffInfo"]("player", "十字军光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN6", "十字军光环", g["zhandoumoshi"])
                return d
            end
        else
            if P == i("1") and g["WR_SpellUsable"]("虔诚光环") and g["WR_GetUnitBuffInfo"]("player", "虔诚光环") ==
                i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN1", "虔诚光环", g["zhandoumoshi"])
                return d
            elseif P == i("2") and g["WR_SpellUsable"]("惩戒光环") and
                g["WR_GetUnitBuffInfo"]("player", "惩戒光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN2", "惩戒光环", g["zhandoumoshi"])
                return d
            elseif P == i("3") and g["WR_SpellUsable"]("专注光环") and
                g["WR_GetUnitBuffInfo"]("player", "专注光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN7", "专注光环", g["zhandoumoshi"])
                return d
            elseif P == i("4") and g["WR_SpellUsable"]("暗影抗性光环") and
                g["WR_GetUnitBuffInfo"]("player", "暗影抗性光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN5", "暗影抗性光环", g["zhandoumoshi"])
                return d
            elseif P == i("5") and g["WR_SpellUsable"]("冰霜抗性光环") and
                g["WR_GetUnitBuffInfo"]("player", "冰霜抗性光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN4", "冰霜抗性光环", g["zhandoumoshi"])
                return d
            elseif P == i("6") and g["WR_SpellUsable"]("火焰抗性光环") and
                g["WR_GetUnitBuffInfo"]("player", "火焰抗性光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN3", "火焰抗性光环", g["zhandoumoshi"])
                return d
            elseif P == i("7") and g["WR_SpellUsable"]("十字军光环") and
                g["WR_GetUnitBuffInfo"]("player", "十字军光环") == i("0") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACN6", "十字军光环", g["zhandoumoshi"])
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_LLZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("力量祝福") and g["WR_GetUnitBuffInfo"](C, "力量祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "战斗怒吼") <= Q and g["WR_GetUnitBuffInfo"](C, "强效力量祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF1", "力量祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "力祝") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_QXLLZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("强效力量祝福") and g["WR_GetUnitBuffInfo"](C, "力量祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "战斗怒吼") <= Q and g["WR_GetUnitBuffInfo"](C, "强效力量祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF5", "强效力量祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "强力") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_ZHZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("智慧祝福") and g["WR_GetUnitBuffInfo"](C, "智慧祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "法力之泉") <= Q and g["WR_GetUnitBuffInfo"](C, "强效智慧祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF2", "智慧祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "智祝") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_QXZHZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("强效智慧祝福") and g["WR_GetUnitBuffInfo"](C, "智慧祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "法力之泉") <= Q and g["WR_GetUnitBuffInfo"](C, "强效智慧祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF6", "强效智慧祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "强智") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_WZZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("王者祝福") and g["WR_GetUnitBuffInfo"](C, "王者祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效王者祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF3", "王者祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "王祝") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_QXWZZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("强效王者祝福") and g["WR_GetUnitBuffInfo"](C, "王者祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效王者祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF7", "强效王者祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "强王") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_BHZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("庇护祝福") and g["WR_GetUnitBuffInfo"](C, "庇护祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效庇护祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF9", "庇护祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "庇祝") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_Function_QXBHZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_SpellUsable"]("强效庇护祝福") and g["WR_GetUnitBuffInfo"](C, "庇护祝福") <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效庇护祝福") <= Q then
            if g["UnitIsUnit"]("focus", C) then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACF10", "强效庇护祝福", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "强庇") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinHoly_UnitNotMyZF"] = function(C)
        local Q = i("300")
        if g["UnitAffectingCombat"]("player") then
            Q = i("0")
        end
        if g["WR_GetUnitBuffInfo"](C, "力量祝福", d) <= Q and g["WR_GetUnitBuffInfo"](C, "智慧祝福", d) <= Q and
            g["WR_GetUnitBuffInfo"](C, "王者祝福", d) <= Q and g["WR_GetUnitBuffInfo"](C, "庇护祝福", d) <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效力量祝福", d) <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效智慧祝福", d) <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效王者祝福", d) <= Q and
            g["WR_GetUnitBuffInfo"](C, "强效庇护祝福", d) <= Q then
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_ZF"] = function()
        local R;
        if g["PaladinTalent"] == "神圣" then
            R = g["WRSet"]["SS_ZF"]
        elseif g["PaladinTalent"] == "惩戒" then
            R = g["WRSet"]["CJ_ZF"]
        end
        if R == i("9") then
            return c
        end
        if g["RiadOrParty"] ~= "raid" then
            local y = "player"
            if R == i("1") then
                if g["PaladinTalent"] == "神圣" then
                    if g["WR_PaladinHoly_Function_ZHZF"](y) then
                        return d
                    end
                elseif g["PaladinTalent"] == "惩戒" then
                    if g["WR_PaladinHoly_Function_LLZF"](y) then
                        return d
                    end
                end
                if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                    if g["WR_PaladinHoly_Function_WZZF"](y) then
                        return d
                    end
                    if g["WR_PaladinHoly_Function_ZHZF"](y) then
                        return d
                    end
                    if g["WR_PaladinHoly_Function_LLZF"](y) then
                        return d
                    end
                end
            elseif R == i("2") then
                if g["WR_PaladinHoly_Function_LLZF"](y) then
                    return d
                end
            elseif R == i("3") then
                if g["WR_PaladinHoly_Function_ZHZF"](y) then
                    return d
                end
            elseif R == i("4") then
                if g["WR_PaladinHoly_Function_WZZF"](y) then
                    return d
                end
            elseif R == i("5") then
                if g["PaladinTalent"] == "神圣" then
                    if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                        return d
                    end
                elseif g["PaladinTalent"] == "惩戒" then
                    if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                        return d
                    end
                end
                if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                    if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                        return d
                    end
                    if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                        return d
                    end
                    if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                        return d
                    end
                end
            elseif R == i("6") then
                if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                    return d
                end
            elseif R == i("7") then
                if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                    return d
                end
            elseif R == i("8") then
                if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                    return d
                end
            end
        end
        if g["RiadOrParty"] == "single" then
            return c
        end
        local w;
        if g["RiadOrParty"] == "raid" then
            w = i("25")
        else
            w = i("4")
        end
        for x = i("1"), w, i("1") do
            local y = g["RiadOrParty"] .. x;
            if g["UnitExists"](y) and not g["UnitCanAttack"](y, "player") and not g["UnitIsDeadOrGhost"](y) and
                g["WR_GetUnitRange"](y) <= i("30") then
                if R == i("1") then
                    if g["UnitClassBase"](y) == "MAGE" or g["UnitClassBase"](y) == "WARLOCK" or g["UnitClassBase"](y) ==
                        "PRIEST" then
                        if g["WR_PaladinHoly_Function_ZHZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_WZZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_LLZF"](y) then
                                return d
                            end
                        end
                    end
                    if g["UnitClassBase"](y) == "WARRIOR" or g["UnitClassBase"](y) == "ROGUE" or g["UnitClassBase"](y) ==
                        "DEATHKNIGHT" or g["UnitClassBase"](y) == "HUNTER" then
                        if g["WR_NumIsTank"](x) then
                            if g["WR_PaladinHoly_Function_WZZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                                if g["WR_PaladinHoly_Function_LLZF"](y) then
                                    return d
                                end
                            end
                        else
                            if g["WR_PaladinHoly_Function_LLZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                                if g["WR_PaladinHoly_Function_WZZF"](y) then
                                    return d
                                end
                            end
                        end
                    end
                    if g["UnitClassBase"](y) == "DRUID" or g["UnitClassBase"](y) == "SHAMAN" or g["UnitClassBase"](y) ==
                        "PALADIN" then
                        if g["WR_PaladinHoly_Function_WZZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_ZHZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_LLZF"](y) then
                                return d
                            end
                        end
                    end
                elseif R == i("2") then
                    if g["WR_PaladinHoly_Function_LLZF"](y) then
                        return d
                    end
                elseif R == i("3") then
                    if g["WR_PaladinHoly_Function_ZHZF"](y) then
                        return d
                    end
                elseif R == i("4") then
                    if g["WR_PaladinHoly_Function_WZZF"](y) then
                        return d
                    end
                elseif R == i("5") then
                    if g["UnitClassBase"](y) == "MAGE" or g["UnitClassBase"](y) == "WARLOCK" or g["UnitClassBase"](y) ==
                        "PRIEST" or g["UnitClassBase"](y) == "PALADIN" then
                        if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                                return d
                            end
                        end
                    end
                    if g["UnitClassBase"](y) == "WARRIOR" or g["UnitClassBase"](y) == "ROGUE" or g["UnitClassBase"](y) ==
                        "DEATHKNIGHT" or g["UnitClassBase"](y) == "HUNTER" then
                        if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                                return d
                            end
                        end
                    end
                    if g["UnitClassBase"](y) == "DRUID" or g["UnitClassBase"](y) == "SHAMAN" then
                        if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                                return d
                            end
                        end
                    end
                elseif R == i("6") then
                    if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                        return d
                    end
                elseif R == i("7") then
                    if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                        return d
                    end
                elseif R == i("8") then
                    if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                        return d
                    end
                end
            end
        end
        return c
    end;
    g["WR_PaladinProtection_Function_ZF"] = function()
        if g["WRSet"]["FH_ZF"] == i("10") then
            return c
        end
        if g["RiadOrParty"] ~= "raid" then
            local y = "player"
            if g["WRSet"]["FH_ZF"] == i("1") then
                if g["WR_PaladinHoly_Function_BHZF"](y) then
                    return d
                end
                if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                    if g["WR_PaladinHoly_Function_WZZF"](y) then
                        return d
                    end
                    if g["WR_PaladinHoly_Function_ZHZF"](y) then
                        return d
                    end
                    if g["WR_PaladinHoly_Function_LLZF"](y) then
                        return d
                    end
                end
            elseif g["WRSet"]["FH_ZF"] == i("2") then
                if g["WR_PaladinHoly_Function_LLZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("3") then
                if g["WR_PaladinHoly_Function_ZHZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("4") then
                if g["WR_PaladinHoly_Function_WZZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("5") then
                if g["WR_PaladinHoly_Function_BHZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("6") then
                if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("7") then
                if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("8") then
                if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                    return d
                end
            elseif g["WRSet"]["FH_ZF"] == i("9") then
                if g["WR_PaladinHoly_Function_QXBHZF"](y) then
                    return d
                end
            end
        end
        if g["RiadOrParty"] == "single" then
            return c
        end
        local w;
        if g["RiadOrParty"] == "raid" then
            w = i("25")
        else
            w = i("4")
        end
        for x = i("1"), w, i("1") do
            local y = g["RiadOrParty"] .. x;
            if g["UnitExists"](y) and not g["UnitCanAttack"](y, "player") and not g["UnitIsDeadOrGhost"](y) and
                g["WR_GetUnitRange"](y) <= i("30") then
                if g["WRSet"]["FH_ZF"] == i("1") then
                    if g["UnitClassBase"](y) == "MAGE" or g["UnitClassBase"](y) == "WARLOCK" or g["UnitClassBase"](y) ==
                        "PRIEST" then
                        if g["WR_PaladinHoly_Function_ZHZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_WZZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_LLZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_BHZF"](y) then
                                return d
                            end
                        end
                    end
                    if g["UnitClassBase"](y) == "WARRIOR" or g["UnitClassBase"](y) == "ROGUE" or g["UnitClassBase"](y) ==
                        "DEATHKNIGHT" or g["UnitClassBase"](y) == "HUNTER" then
                        if g["WR_NumIsTank"](x) then
                            if g["WR_PaladinHoly_Function_BHZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                                if g["WR_PaladinHoly_Function_WZZF"](y) then
                                    return d
                                end
                                if g["WR_PaladinHoly_Function_LLZF"](y) then
                                    return d
                                end
                                if g["WR_PaladinHoly_Function_ZHZF"](y) then
                                    return d
                                end
                            end
                        else
                            if g["WR_PaladinHoly_Function_LLZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                                if g["WR_PaladinHoly_Function_WZZF"](y) then
                                    return d
                                end
                                if g["WR_PaladinHoly_Function_BHZF"](y) then
                                    return d
                                end
                                if g["WR_PaladinHoly_Function_ZHZF"](y) then
                                    return d
                                end
                            end
                        end
                    end
                    if g["UnitClassBase"](y) == "DRUID" or g["UnitClassBase"](y) == "SHAMAN" or g["UnitClassBase"](y) ==
                        "PALADIN" then
                        if g["WR_PaladinHoly_Function_WZZF"](y) then
                            return d
                        end
                        if g["WR_PaladinHoly_UnitNotMyZF"](y) then
                            if g["WR_PaladinHoly_Function_ZHZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_LLZF"](y) then
                                return d
                            end
                            if g["WR_PaladinHoly_Function_BHZF"](y) then
                                return d
                            end
                        end
                    end
                elseif g["WRSet"]["FH_ZF"] == i("2") then
                    if g["WR_PaladinHoly_Function_LLZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("3") then
                    if g["WR_PaladinHoly_Function_ZHZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("4") then
                    if g["WR_PaladinHoly_Function_WZZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("5") then
                    if g["WR_PaladinHoly_Function_BHZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("6") then
                    if g["WR_PaladinHoly_Function_QXLLZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("7") then
                    if g["WR_PaladinHoly_Function_QXZHZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("8") then
                    if g["WR_PaladinHoly_Function_QXWZZF"](y) then
                        return d
                    end
                elseif g["WRSet"]["FH_ZF"] == i("9") then
                    if g["WR_PaladinHoly_Function_QXBHZF"](y) then
                        return d
                    end
                end
            end
        end
        return c
    end;
    g["WR_Paladin_Function_SY"] = function()
        local S;
        if g["PaladinTalent"] == "神圣" then
            S = g["WRSet"]["SS_SY"]
        elseif g["PaladinTalent"] == "惩戒" then
            S = g["WRSet"]["CJ_SY"]
        elseif g["PaladinTalent"] == "防护" then
            S = g["WRSet"]["FH_SY"]
        end
        if S == i("1") and g["WR_SpellUsable"]("正义圣印") and g["WR_GetUnitBuffInfo"]("player", "正义圣印") ==
            i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF6", "正义圣印", g["zhandoumoshi"])
            return d
        elseif S == i("2") and g["WR_SpellUsable"]("公正圣印") and g["WR_GetUnitBuffInfo"]("player", "公正圣印") ==
            i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF2", "公正圣印", g["zhandoumoshi"])
            return d
        elseif S == i("3") and g["WR_SpellUsable"]("光明圣印") and g["WR_GetUnitBuffInfo"]("player", "光明圣印") ==
            i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF1", "光明圣印", g["zhandoumoshi"])
            return d
        elseif S == i("4") and g["WR_SpellUsable"]("智慧圣印") and g["WR_GetUnitBuffInfo"]("player", "智慧圣印") ==
            i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF3", "智慧圣印", g["zhandoumoshi"])
            return d
        elseif S == i("5") and g["WR_SpellUsable"](g["FC_FS_ShengYin"]) and
            g["WR_GetUnitBuffInfo"]("player", g["FC_FS_ShengYin"]) == i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACN8", g["FC_FS_ShengYin"], g["zhandoumoshi"])
            return d
        elseif S == i("6") and g["WR_SpellUsable"]("命令圣印") and g["WR_GetUnitBuffInfo"]("player", "命令圣印") ==
            i("0") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CSP", "命令圣印", g["zhandoumoshi"])
            return d
        elseif S == i("7") then
            if g["zhandoumoshi"] == i("1") then
                if g["WR_SpellUsable"]("命令圣印") and g["WR_GetUnitBuffInfo"]("player", "命令圣印") == i("0") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("CSP", "命令圣印", g["zhandoumoshi"])
                    return d
                end
            else
                if g["WR_SpellUsable"](g["FC_FS_ShengYin"]) and g["WR_GetUnitBuffInfo"]("player", g["FC_FS_ShengYin"]) ==
                    i("0") then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("ACN8", g["FC_FS_ShengYin"], g["zhandoumoshi"])
                    return d
                end
            end
        end
        return c
    end;
    g["WR_Paladin_Function_SP"] = function(C, N)
        if g["PaladinTalent"] == "神圣" and g["UnitName"]("target") == "维扎克斯将军" then
            return c
        end
        if g["PaladinTalent"] == "神圣" and g["UnitName"]("focustarget") == "维扎克斯将军" then
            return c
        end
        local T;
        if g["PaladinTalent"] == "神圣" then
            T = g["WRSet"]["SS_SP"]
        elseif g["PaladinTalent"] == "惩戒" then
            T = g["WRSet"]["CJ_SP"]
        elseif g["PaladinTalent"] == "防护" then
            T = g["WRSet"]["FH_SP"]
        end
        local U;
        local V;
        if T == i("2") then
            U = "圣光审判"
            V = "SF8"
        elseif T == i("3") then
            U = "智慧审判"
            V = "SF1"
        elseif T == i("4") then
            U = "公正审判"
            V = "CF4"
        elseif T == i("1") then
            if g["WR_SpellUsable"]("智慧审判") then
                U = "智慧审判"
                V = "SF1"
            else
                U = "圣光审判"
                V = "SF8"
            end
            if g["WR_GetUnitDebuffInfo"](C, "智慧审判", d) == i("0") and
                g["WR_GetUnitDebuffInfo"](C, "圣光审判", d) == i("0") and
                g["WR_GetUnitDebuffInfo"](C, "公正审判", d) == i("0") then
                if g["WR_GetUnitDebuffInfo"](C, "智慧审判") == i("0") then
                    U = "智慧审判"
                    V = "SF1"
                elseif g["WR_GetUnitDebuffInfo"](C, "圣光审判") == i("0") then
                    U = "圣光审判"
                    V = "SF8"
                elseif g["WR_GetUnitDebuffInfo"](C, "公正审判") == i("0") then
                    U = "公正审判"
                    V = "CF4"
                end
            end
        end
        if U ~= e and g["WR_SpellUsable"](U) and g["WR_TargetInCombat"](C) and
            (g["IsSpellInRange"]("圣光审判", C) == i("1") or g["IsSpellInRange"]("智慧审判", C) == i("1") or
                g["IsSpellInRange"]("公正审判", C) == i("1")) and
            (g["UnitHealth"](C) / g["UnitHealthMax"](C) < i("0.995") or not g["IsInInstance"]()) and
            (g["WR_GetUnitDebuffInfo"](C, U) == i("0") or not g["IsInInstance"]() or
                g["GetTalentPointsBySpellID"]("纯洁审判") > i("0") and
                g["WR_GetUnitBuffInfo"]("player", "纯洁审判") <= i("3") or g["PaladinTalent"] == "惩戒" or
                g["PaladinTalent"] == "防护" or g["KillTarget"]) then
            if C == "target" then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"](V, U, g["zhandoumoshi"])
                return d
            elseif C == "focustarget" then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACSF9", "智判FT", g["zhandoumoshi"])
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_Function_SSKQ"] = function()
        if g["WR_SpellUsable"]("神圣恳求") and g["TargetInCombat"] and g["UnitAffectingCombat"]("player") and
            g["PlayerMP"] < i("0.75") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF12", "神圣恳求", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_QSZS"] = function()
        if g["WR_SpellUsable"]("清算之手") and g["TargetRange"] <= i("30") and g["TargetInCombat"] and
            g["WR_IsUsingGlyph"]("清算符文") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF9", "清算之手", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_SZJDJ"] = function()
        if g["WR_SpellUsable"]("十字军打击") and g["TargetRange"] <= i("2") and g["TargetInCombat"] then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF1", "十字军打击", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_Function_ZYZN"] = function()
        if g["WR_SpellUsable"]("正义之怒") and g["WR_GetUnitBuffInfo"]("player", "正义之怒") == i("0") and
            g["UnitCanAttack"]("player", "target") and not g["UnitIsDead"]("target") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACSF2", "正义之怒", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_Function_FCZZD"] = function()
        if g["WR_SpellUsable"]("复仇者之盾") and g["TargetRange"] <= i("30") and
            g["UnitCanAttack"]("player", "target") and not g["UnitIsDead"]("target") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF9", "复仇者之盾", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_FX"] = function()
        if g["WR_SpellUsable"]("奉献") and g["TargetRange"] <= i("2") and g["TargetInCombat"] and not g["PlayerMove"] then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF7", "奉献", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_Function_SSZD"] = function()
        if g["WR_SpellUsable"]("神圣之盾") and g["TargetRange"] <= i("5") and g["UnitCanAttack"]("player", "target") and
            g["WR_GetUnitBuffCount"]("player", "神圣之盾") <= i("1") and not g["UnitIsDead"]("target") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF12", "神圣之盾", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_Function_ZYZC"] = function()
        if g["WR_SpellUsable"]("正义之锤") and g["TargetRange"] <= i("2") and g["UnitCanAttack"]("player", "target") and
            not g["UnitIsDead"]("target") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF11", "正义之锤", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinProtection_Function_ZYDJ"] = function()
        if g["WR_SpellUsable"]("正义盾击") and g["TargetRange"] <= i("2") and g["UnitCanAttack"]("player", "target") and
            not g["UnitIsDead"]("target") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACSF1", "正义盾击", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_Function_ZYDJ"] = function()
        if g["UnitName"]("target") == "维扎克斯将军" then
            return c
        end
        if g["WR_SpellUsable"]("正义盾击") and g["TargetRange"] <= i("2") and g["TargetInCombat"] and g["PlayerMP"] <=
            i("0.95") and (g["PlayerMove"] or g["RiadOrParty"] ~= "raid") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACSF1", "正义盾击", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_SSFB"] = function()
        if g["WR_SpellUsable"]("神圣风暴") and g["TargetRange"] <= i("3") and g["TargetInCombat"] then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF6", "神圣风暴", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_FNZC"] = function()
        if g["WR_SpellUsable"]("愤怒之锤") and g["TargetRange"] <= i("30") and g["TargetInCombat"] and g["TargetHP"] <
            i("0.2") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF8", "愤怒之锤", g["zhandoumoshi"])
            return d
        end
        if g["WR_GetGCD"]("愤怒之锤") <= g["GCD"] and g["WR_GetUnitRange"]("mouseover") <= i("30") and
            g["WR_TargetInCombat"]("mouseover") and g["UnitHealth"]("mouseover") / g["UnitHealthMax"]("mouseover") <
            i("0.2") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF2", "愤怒之锤M", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_SSZJ_Damage"] = function()
        if g["WR_SpellUsable"]("神圣震击") and g["TargetRange"] <= i("30") and g["TargetInCombat"] then
            if g["UnitIsUnit"]("focus", "target") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("SF2", "神圣震击", g["zhandoumoshi"])
                return d
            end
            g["WR_FocusHealthMaxWeightUnit_LastTime"] = g["GetTime"]()
            if g["WR_FocusUnit"]("target", "震击") then
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_Function_QXS"] = function()
        if g["WR_SpellUsable"]("驱邪术") and g["TargetRange"] <= i("30") and g["TargetInCombat"] and
            g["UnitCastingInfo"]("player") ~= "驱邪术" and
            (g["WR_GetUnitBuffInfo"]("player", "战争艺术") > i("0") and
                (not g["PlayerMove"] and not g["WR_StopCast"](g["WR_GetTrueCastTime"]("驱邪术")))) then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF9", "驱邪术", g["zhandoumoshi"])
            return d
        end
    end;
    g["WR_Paladin_Function_SSFN"] = function()
        if g["PaladinTalent"] == "惩戒" and g["WRSet"]["CJ_SSFN"] ~= i("1") then
            return c
        elseif g["PaladinTalent"] == "防护" and g["WRSet"]["FH_SSFN"] ~= i("1") then
            return c
        end
        if g["WR_SpellUsable"]("神圣愤怒") and g["TargetRange"] <= i("5") and g["TargetInCombat"] and
            (g["UnitCreatureType"]("target") == "亡灵" or g["UnitCreatureType"]("target") == "恶魔") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CF5", "神圣愤怒", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_Function_HWGJ"] = function()
        if g["IsInInstance"]() and not g["KillTarget"] then
            return c
        end
        if g["WR_Paladin_Function_FNZC"]() then
            return d
        end
        if g["WR_Paladin_Function_SSZJ_Damage"]() then
            return d
        end
        if g["WR_Paladin_Function_QXS"]() then
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_GJ"] = function()
        if g["WRSet"]["SS_ZLMS"] == i("2") or g["WRSet"]["SS_ZLMS"] == i("3") then
            return c
        end
        if not g["IsCurrentSpell"]("攻击") and g["TargetRange"] <= i("10") and g["TargetInCombat"] and
            not g["UnitIsDeadOrGhost"]("target") and not g["IsMounted"]() then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ACN9", "攻击", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_Function_StopFollow"] = function()
        if g["WRSet"]["SS_ZDGS"] ~= i("2") and g["UnitCastingInfo"]("player") ~= e then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("CSO", "停止跟随", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_Function_JS"] = function()
        if not g["UnitIsDeadOrGhost"]("focus") and g["FocusHP"] <= i("0.4") then
            return c
        end
        if not g["WR_SpellUsable"]("救赎") then
            return c
        end
        if g["RiadOrParty"] == "single" then
            return c
        end
        if g["WR_PartyInCombat"]() then
            return c
        end
        if g["PlayerMove"] then
            return c
        end
        if g["WR_StopCast"](g["WR_GetTrueCastTime"]("救赎")) then
            return c
        end
        if g["PaladinTalent"] == "防护" and g["WRSet"]["FH_JS"] == i("2") then
            return c
        end
        local w;
        if g["RiadOrParty"] == "raid" then
            w = i("25")
        else
            w = i("4")
        end
        for x = i("1"), w, i("1") do
            local y = g["RiadOrParty"] .. x;
            if g["UnitIsDeadOrGhost"](y) and g["WR_GetUnitRange"](y) <= i("30") then
                if g["UnitIsUnit"]("focus", y) then
                    g["WR_HideColorFrame"](g["zhandoumoshi"])
                    g["WR_ShowColorFrame"]("SF6", "救赎F", g["zhandoumoshi"])
                    return d
                end
                if g["WR_FocusUnit"](y, "救赎") then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_Paladin_Function_ZCZC"] = function()
        if g["PaladinTalent"] == "神圣" and g["WRSet"]["SS_ZCZC"] == i("2") then
            return c
        end
        if g["PaladinTalent"] == "惩戒" and g["WRSet"]["CJ_ZCZC"] == i("2") then
            return c
        end
        if g["PaladinTalent"] == "防护" and g["WRSet"]["FH_ZCZC"] == i("2") then
            return c
        end
        if g["WR_SpellUsable"]("制裁之锤") and g["WR_GetUnitRange"]("target") <= i("10") and
            g["UnitCanAttack"]("target", "player") and g["WR_StunSpell"]("target") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("SF11", "制裁T", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_FindTank"] = function()
        if not g["IsInInstance"]() then
            return e
        end
        if g["RiadOrParty"] == "single" then
            return c
        end
        local w;
        if g["RiadOrParty"] == "raid" then
            w = i("25")
        else
            w = i("4")
        end
        for x = i("1"), w, i("1") do
            local y = g["RiadOrParty"] .. x;
            if g["UnitExists"](y) and not g["UnitIsDeadOrGhost"](y) and g["WR_NumIsTank"](x) then
                return y
            end
        end
        return e
    end;
    g["WR_PaladinHoly_Function_FollowUnit"] = function()
        if g["WRSet"]["SS_ZDGS"] == i("2") then
            return e
        end
        if g["WR_TankUnit"] ~= e and g["UnitIsPlayer"](g["WR_TankUnit"]) and g["UnitExists"](g["WR_TankUnit"]) and
            not g["UnitIsDeadOrGhost"](g["WR_TankUnit"]) and not g["PlayerMove"] and g["GCD"] == i("0") and
            g["WR_GetUnitRange"](g["WR_TankUnit"]) > i("3") and g["WR_GetUnitRange"](g["WR_TankUnit"]) <= i("25") then
            if g["UnitIsUnit"](g["WR_TankUnit"], "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("CSL", "跟随", g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](g["WR_TankUnit"], "跟随") then
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_ZYZS"] = function(C)
        if g["WR_SpellUsable"]("自由之手") and g["WR_GetUnitRange"](C) <= i("30") and
            not g["UnitCanAttack"](C, "player") and g["WR_Unbind"](C) then
            if g["UnitIsUnit"](C, "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("SF10", "自由" .. C, g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "自由") then
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_Function_ZYZF"] = function()
        if not g["WR_SpellUsable"]("自由之手") then
            return c
        end
        local W;
        if g["PaladinTalent"] == "神圣" then
            W = g["WRSet"]["SS_ZYZS"]
        elseif g["PaladinTalent"] == "惩戒" then
            W = g["WRSet"]["CJ_ZYZS"]
        elseif g["PaladinTalent"] == "防护" then
            W = g["WRSet"]["FH_ZYZS"]
        end
        if W == e or W == i("3") then
            return c
        end
        if W == i("1") then
            if g["WR_Paladin_ZYZS"]("mouseover") then
                return d
            end
            if g["WR_TankUnit"] ~= e and g["WR_Paladin_ZYZS"](g["WR_TankUnit"]) then
                return d
            end
            if g["WR_Paladin_ZYZS"]("player") then
                return d
            end
            if g["RiadOrParty"] == "single" then
                return c
            end
            local w;
            if g["RiadOrParty"] == "raid" then
                w = i("25")
            else
                w = i("4")
            end
            for x = i("1"), w, i("1") do
                local y = g["RiadOrParty"]
                if g["WR_Paladin_ZYZS"](y) then
                    return d
                end
            end
        end
        if W == i("2") and g["WR_Paladin_ZYZS"]("player") then
            return d
        end
        return c
    end;
    g["WR_PaladinHoly_FindTank_SGDB_SJHD"] = function()
        local X = {}
        if g["RiadOrParty"] == "party" then
            local Y = i("1")
            for x = i("1"), i("4"), i("1") do
                local y = "party" .. x;
                if g["UnitExists"](y) and g["WR_NumIsTank"](x) and Y <= i("4") then
                    if g["UnitName"](y) ~= e and g["SS_SGDB_menuItems"][Y]["text"] ~= g["UnitName"](y) then
                        g["SS_SGDB_UpdateMenuItemText"](Y, g["UnitName"](y))
                    end
                    X[Y] = y;
                    Y = Y + i("1")
                end
                if g["SS_SJHD_menuItems"][x]["text"] ~= f then
                    g["SS_SJHD_UpdateMenuItemText"](x, f)
                end
            end
        elseif g["RiadOrParty"] == "raid" then
            local Y = i("1")
            for x = i("1"), i("25"), i("1") do
                local y = "raid" .. x;
                if g["UnitExists"](y) and g["WR_NumIsTank"](x) and Y <= i("4") then
                    if g["UnitName"](y) ~= e and g["SS_SGDB_menuItems"][Y]["text"] ~= g["UnitName"](y) then
                        g["SS_SGDB_UpdateMenuItemText"](Y, g["UnitName"](y))
                    end
                    if g["UnitName"](y) ~= e and g["SS_SJHD_menuItems"][Y]["text"] ~= g["UnitName"](y) then
                        g["SS_SJHD_UpdateMenuItemText"](Y, g["UnitName"](y))
                    end
                    X[Y] = y;
                    Y = Y + i("1")
                end
            end
        end
        for x = i("1"), i("4"), i("1") do
            if g["SS_SGDB_menuItems"][x]["text"] ~= f and X[x] == e then
                g["SS_SGDB_UpdateMenuItemText"](x, f)
            end
        end
        return X[i("1")], X[i("2")], X[i("3")], X[i("4")]
    end;
    g["WR_IsTracking"] = function(Z)
        for x = i("1"), g["C_Minimap"]["GetNumTrackingTypes"]() do
            local n, _, a0, a1, a2, a3 = g["C_Minimap"]["GetTrackingInfo"](x)
            if n == Z and a0 then
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_GZWL"] = function()
        if g["WR_IsUsingGlyph"]("感知亡灵雕文") and not g["WR_IsTracking"]("感知亡灵") then
            g["WR_HideColorFrame"](g["zhandoumoshi"])
            g["WR_ShowColorFrame"]("ASF7", "感知亡灵", g["zhandoumoshi"])
            return d
        end
        return c
    end;
    g["WR_Paladin_SPELL_CAST_SUCCESS"] = function()
        if g["WR_Paladin_SPELL_CAST_SUCCESS_Open"] == d then
            return
        end
        local a4 = g["CreateFrame"]("Frame")
        a4["RegisterEvent"](a4, "COMBAT_LOG_EVENT_UNFILTERED")
        a4["SetScript"](a4, "OnEvent", function()
            if g["select"](i("4"), g["CombatLogGetCurrentEventInfo"]()) == g["UnitGUID"]("player") then
                if g["select"](i("2"), g["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
                    local a5 = g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]())
                    if a5 == "圣光术" or a5 == "圣光闪现" then
                        g["Paladin_CastTime"] = g["GetTime"]()
                    end
                end
            end
        end)
        g["WR_Paladin_SPELL_CAST_SUCCESS_Open"] = d
    end;
    g["WR_Paladin_ErrorMessage"] = function()
        if g["WR_Paladin_ErrorMessageInfo"] ~= d then
            local a6 = g["CreateFrame"]("Frame")
            a6["RegisterEvent"](a6, "UI_ERROR_MESSAGE")
            a6["SetScript"](a6, "OnEvent", function(B, a7, a8, a9)
                if g["string"]["find"](a9, "目标不在视野中") then
                    g["OutOfSight_ErrorMessageTime"] = g["GetTime"]()
                    g["OutOfSight_FocusID"] = g["UnitGUID"]("focus")
                    return
                end
            end)
            g["WR_Paladin_ErrorMessageInfo"] = d
        end
    end;
    g["WR_PaladinProtection_ZYFY"] = function(C)
        if g["UnitCanAttack"]("player", C) then
            return c
        end
        if g["WR_UnitIsTank"](C) then
            return c
        end
        if g["WR_GetUnitRange"](C) > i("40") then
            return c
        end
        if g["UnitIsUnit"]("player", C) then
            return c
        end
        local aa = i("0")
        for x = i("1"), i("40") do
            if g["UnitIsUnit"]("nameplate" .. x .. "target", C) and not g["UnitIsPlayer"]("nameplate") then
                aa = aa + i("1")
            end
        end
        if aa >= g["WRSet"]["FH_ZYFY"] then
            if g["UnitIsUnit"](C, "focus") then
                g["WR_HideColorFrame"](g["zhandoumoshi"])
                g["WR_ShowColorFrame"]("ACSF10", "正义防御" .. C, g["zhandoumoshi"])
                return d
            end
            if g["WR_FocusUnit"](C, "正义防御") then
                return d
            end
        end
        return c
    end;
    g["WR_PaladinProtection_Function_ZYFY"] = function()
        if g["WRSet"]["FH_ZYFY"] == i("6") then
            return c
        end
        local F;
        if g["RiadOrParty"] == "raid" then
            F = i("25")
        elseif g["RiadOrParty"] == "party" then
            F = i("4")
        end
        if F == e then
            return c
        end
        for x = i("1"), F do
            if g["WR_PaladinProtection_ZYFY"](g["RiadOrParty"] .. x) then
                return d
            end
        end
        return c
    end;
    g["WR_Paladin_ZLS"] = function()
        local ab = i("5")
        if g["PaladinTalent"] == "神圣" then
            ab = g["WRSet"]["SS_ZLS"]
        elseif g["PaladinTalent"] == "惩戒" then
        elseif g["PaladinTalent"] == "防护" then
        end
        if ab ~= i("5") and g["UnitAffectingCombat"]("player") and g["PlayerHP"] < ab / i("10") and g["WR_Use_ZLS"]() then
            if g["WR_ColorFrame_Show"]("ACSF12", "治疗石") then
                return d
            end
        end
        return c
    end
end)()
