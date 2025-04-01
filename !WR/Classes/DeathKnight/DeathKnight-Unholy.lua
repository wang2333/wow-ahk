local a = 64;
local b = 13;
local c = 46;
local d = 83;
local e = 44;
local f = 0 == 1;
local g = not f;
local h = nil;
local i = ""
local j = _G;
local k = _ENV;
local l = j["tonumber"]
return (function(...)
    j["WR_DeathKnightUnholy"] = function()
        if j["GetSpecialization"]() ~= l("3") then
            return
        end
        j["ShiFaSuDu"] = l("0.3")
        local m = {
            [l("1")] = l("207198"),
            [l("2")] = l("207199"),
            [l("3")] = l("207200"),
            [l("4")] = l("207201"),
            [l("5")] = l("207203")
        }
        j["T31Count"] = j["WR_GetSuit"](m)
        local n = {
            [l("1")] = l("217221"),
            [l("2")] = l("217222"),
            [l("3")] = l("217223"),
            [l("4")] = l("217224"),
            [l("5")] = l("217225")
        }
        j["T32Count"] = j["WR_GetSuit"](n)
        j["GCD"] = j["WR_GetGCD"]("灵界打击")
        j["GCD_Max"] = j["WR_GetMaxGCD"](l("1.5"))
        j["CD_KWDL"] = j["WR_GetGCD"]("枯萎凋零")
        j["CD_ZHSSG"] = j["WR_GetGCD"]("召唤石像鬼")
        j["CD_TQ"] = j["WR_GetGCD"]("天启")
        j["CD_XECQ"] = j["WR_GetGCD"]("邪恶虫群")
        j["CD_XETX"] = j["WR_GetGCD"]("邪恶突袭")
        j["Runes"] = j["WR_GetRuneCount"]()
        j["RunicPower"] = j["UnitPower"]("player", l("6"))
        j["PlayerHP"] = j["UnitHealth"]("player") / j["UnitHealthMax"]("player")
        j["TargetRange"] = j["WR_GetUnitRange"]("target")
        j["HUCountRange5"] = j["WR_GetRangeHarmUnitCount"](l("5"), f)
        j["HUCountRange8"] = j["WR_GetRangeHarmUnitCount"](l("8"), f)
        j["HUCountRange30"] = j["WR_GetRangeHarmUnitCount"](l("30"), g)
        j["AvgDeathTime"] = j["WR_GetRangeAvgDeathTime"](l("40"))
        j["TargetDeathTime"] = j["WR_GetUnitDeathTime"]("target")
        j["SXG_Sum"] = l("0")
        j["SXG_Time"] = h;
        for o = l("1"), l("5"), l("1") do
            local p, q, r, s, p = j["GetTotemInfo"](o)
            if q == "黑锋石像鬼" then
                j["SXG_Sum"] = l("1")
                j["SXG_Time"] = r + s - j["GetTime"]()
                break
            end
        end
        j["BuffTime_KLZL"], j["BuffCount_KLZL"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "溃烂之力")
        j["BuffTime_KWDL"], j["BuffCount_KWDL"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "枯萎凋零")
        j["BuffTime_FMFHZ"], j["BuffCount_FMFHZ"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "反魔法护罩")
        j["BuffTime_XD"], j["BuffCount_XD"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "亵渎")
        j["BuffTime_WZZHG"], j["BuffCount_WZZHG"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "亡者指挥官")
        j["BuffTime_WYSZ"], j["BuffCount_WYSZ"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "瘟疫使者")
        j["BuffTime_MRTJ"], j["BuffCount_MRTJ"], j["_"] = j["WR_GetUnitBuffInfo"]("player", "末日突降")
        j["BuffTime_HATB"], j["BuffCount_HATB"], j["_"] = j["WR_GetUnitBuffInfo"]("pet", "黑暗突变")
        j["DebuffTime_KLZS"], j["DebuffCount_KLZS"], j["_"] = j["WR_GetUnitDebuffInfo"]("target", "溃烂之伤", g)
        j["DebuffTime_EXWY"], j["DebuffCount_EXWY"], j["_"] = j["WR_GetUnitDebuffInfo"]("target", "恶性瘟疫", g)
        j["DebuffTime_SWXL"], j["DebuffCount_SWXL"], j["_"] = j["WR_GetUnitDebuffInfo"]("target", "死亡朽烂", g)
        j["WR_DeathKnightUnholy_LastSpellTime"]()
        if j["WR_CreateMacroButtonInfo"] ~= g and not j["UnitAffectingCombat"]("player") and
            j["WR_CreateMacroButtonPass"]() ~= h then
            j["WR_CreateMacroButtonInfo"] = g;
            j["WR_DeathKnightCreateMacroButton"]()
        end
        if j["MSG"] == l("1") then
            j["print"]("----------")
        end
        if j["IsFlying"]() or j["UnitIsDead"]("player") or j["SpellIsTargeting"]() or j["UnitChannelInfo"]("player") ~=
            h then
            j["WR_HideColorFrame"](l("0"))
            j["WR_HideColorFrame"](l("1"))
            return
        end
        if not j["UnitIsDead"]("player") and (j["UnitAffectingCombat"]("player") or j["WR_InTraining"]()) then
            j["WR_CombatFrame"]["Show"](j["WR_CombatFrame"])
        else
            j["WR_CombatFrame"]["Hide"](j["WR_CombatFrame"])
        end
        if j["zhandoumoshi"] ~= l("1") then
            j["WR_HideColorFrame"](l("1"))
            j["WR_ShowColorFrame"]("SF10", "爆发", l("1"))
        end
        if j["zhandoumoshi"] == l("1") then
            j["WR_HideColorFrame"](l("0"))
            j["WR_ShowColorFrame"]("SF12", "平伤", l("0"))
        end
        if j["WRSet"]["XE_WYZQ"] ~= l("6") and j["WR_SpellUsable"]("巫妖之躯") and j["PlayerHP"] <
            j["WRSet"]["XE_WYZQ"] / l("10") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF8", "巫妖之躯", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_BFZR"] ~= l("6") and j["WR_SpellUsable"]("冰封之韧") and j["PlayerHP"] <
            j["WRSet"]["XE_BFZR"] / l("10") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF2", "冰封之韧", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_ZLS"] ~= l("5") and j["PlayerHP"] < j["WRSet"]["XE_ZLS"] / l("10") then
            local t = j["GetItemCount"]("治疗石")
            local u, s, v = j["GetItemCooldown"]("治疗石")
            if t ~= h and t >= l("1") and u + s - j["GetTime"]() <= l("0") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF6", "治疗石", j["zhandoumoshi"])
                return
            end
        end
        if j["WRSet"]["XE_ZLYS"] ~= l("5") and j["PlayerHP"] < j["WRSet"]["XE_ZLYS"] / l("10") then
            local w = {
                [l("1")] = "振奋治疗药水",
                [l("2")] = "梦行者治疗药水",
                [l("3")] = "凋零梦境药水"
            }
            for p, x in j["ipairs"](w) do
                local t = j["GetItemCount"](x)
                local u, s, v = j["GetItemCooldown"](x)
                if t ~= h and t >= l("1") and u + s - j["GetTime"]() <= l("0") then
                    j["WR_HideColorFrame"](j["zhandoumoshi"])
                    j["WR_ShowColorFrame"]("CF10", "治疗药水", j["zhandoumoshi"])
                    return
                end
            end
        end
        if j["WRSet"]["XE_FMFHZ"] == l("1") and j["WR_DeathKnightUnholy_FMFHZ"]() then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF11", "反魔法护罩", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_XLBD"] ~= l("3") and j["WR_DeathKnightFrost_XLBD"]("target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF2", "心灵冰冻T", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_XLBD"] == l("1") and j["WR_DeathKnightFrost_XLBD"]("mouseover") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF3", "心灵冰冻M", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightFrost_FHMY"]("mouseover") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF3", "复活盟友M", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightFrost_KZWL"]() then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF1", "控制亡灵", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_ZMBY"] == l("1") and j["WR_DeathKnightFrost_ZMBY"]() then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF6", "致盲冰雨", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_ZX"] == l("1") and j["WR_DeathKnightFrost_ZX"]("target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF7", "窒息T", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_ZX"] == l("1") and j["WR_DeathKnightFrost_ZX"]("mouseover") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF9", "窒息M", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_ZNMB"] == l("1") and j["HUCountRange5"] >= l("1") and j["UnitAffectingCombat"]("player") and
            (not j["WR_TargetInCombat"]("target") or j["WR_GetUnitRange"]("target") > l("5")) then
            j["WR_ZNMB"] = g;
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF5", "智能目标", j["zhandoumoshi"])
            return
        end
        if j["WR_SpellUsable"]("亡者复生") and (not j["UnitExists"]("pet") or j["UnitIsDead"]("pet")) and
            not j["UnitExists"]("pet") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF1", "亡者复生", j["zhandoumoshi"])
            return
        end
        if not j["WR_TargetInCombat"]("target") or j["GCD"] > j["ShiFaSuDu"] then
            j["WR_HideColorFrame"](l("0"))
            j["WR_HideColorFrame"](l("1"))
            return
        end
        if j["WR_DeathKnightUnholy_LJDJ"]() then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF7", "灵界打击", j["zhandoumoshi"])
            return
        end
        if j["WRSet"]["XE_WZDJ"] == l("1") and j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("亡者大军") and
            j["TargetRange"] <= l("30") and
            (j["IsPlayerSpell"](l("49206")) and j["CD_ZHSSG"] < j["GCD"] + l("3") * j["GCD_Max"] or
                not j["IsPlayerSpell"](l("49206"))) then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF1", "亡者大军", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_KWDL"]() and j["BuffTime_XD"] <= j["GCD"] + j["GCD_Max"] + l("1") and
            j["HUCountRange8"] >= l("2") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF9", "枯萎凋零", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_TZDJ"]() and j["IsPlayerSpell"](l("390175")) and j["BuffTime_WYSZ"] < j["GCD"] +
            j["GCD_Max"] and (j["CD_XETX"] <= j["GCD"] or j["HUCountRange8"] >= l("3")) then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF5", "天灾加速", j["zhandoumoshi"])
            return
        end
        if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("邪恶虫群") and j["TargetRange"] <= l("5") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF1", "邪恶虫群", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_BF"]("target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF4", "爆发t", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_BF"]("mouseover") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF7", "爆发m", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_BF"]("party1target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF8", "爆发P1", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_BF"]("party2target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF9", "爆发P2", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_BF"]("party3target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF10", "爆发P3", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_BF"]("party4target") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF1", "爆发P4", j["zhandoumoshi"])
            return
        end
        if j["WR_SpellUsable"]("灵魂收割") and j["TargetRange"] <= l("5") and j["HUCountRange8"] == l("1") and
            j["UnitHealth"]("target") / j["UnitHealthMax"]("target") <= l("0.36") and j["TargetDeathTime"] > l("5") +
            l("3") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF6", "灵魂收割", j["zhandoumoshi"])
            return
        end
        if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("黑暗突变") and j["CD_KWDL"] < l("10") then
            if j["IsPlayerSpell"](l("390259")) and j["CD_TQ"] <= j["GCD"] + j["GCD_Max"] * l("2") and j["TargetRange"] <=
                l("5") and j["Runes"] >= l("2") and j["DebuffCount_KLZS"] <= l("3") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF8", "脓疮补溃", j["zhandoumoshi"])
                return
            end
            if not j["IsPlayerSpell"](l("390259")) or j["DebuffCount_KLZS"] >= l("4") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF7", "黑暗突变", j["zhandoumoshi"])
                return
            end
        end
        if j["IsPlayerSpell"](l("390259")) then
            if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("天启") and j["BuffTime_WZZHG"] > j["GCD"] then
                if j["DebuffCount_KLZS"] >= l("4") then
                    j["WR_HideColorFrame"](j["zhandoumoshi"])
                    j["WR_ShowColorFrame"]("CF3", "满天启", j["zhandoumoshi"])
                    return
                end
            end
            if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("召唤石像鬼") and j["BuffTime_WZZHG"] > j["GCD"] then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("ACSF5", "召唤石像鬼", j["zhandoumoshi"])
                return
            end
        end
        if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("符文武器增效") and j["BuffTime_HATB"] > j["GCD"] then
            if j["WRSet"]["XE_BFYS"] == l("1") then
                local y = {
                    [l("1")] = "飞逝元素究极强能药水",
                    [l("2")] = "元素究极强能药水",
                    [l("3")] = "元素强能药水"
                }
                local z;
                for p, A in j["ipairs"](y) do
                    local t = j["GetItemCount"](A)
                    local u, s, v = j["GetItemCooldown"](A)
                    if t ~= h and t >= l("1") and u + s - j["GetTime"]() <= l("0") then
                        j["WR_HideColorFrame"](j["zhandoumoshi"])
                        j["WR_ShowColorFrame"]("ACSF3", "爆发药水", j["zhandoumoshi"])
                        return
                    end
                end
            end
            if (j["WRSet"]["XE_SP"] == l("1") or j["WRSet"]["XE_SP"] == l("3")) and j["WR_GetEquipCD"](l("13")) then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("ASF5", "饰品1", j["zhandoumoshi"])
                return
            end
            if (j["WRSet"]["XE_SP"] == l("2") or j["WRSet"]["XE_SP"] == l("3")) and j["WR_GetEquipCD"](l("14")) then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("ASF6", "饰品2", j["zhandoumoshi"])
                return
            end
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF2", "符文武器增效", j["zhandoumoshi"])
            return
        end
        if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("邪恶突袭") and j["BuffTime_HATB"] > j["GCD"] then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF4", "邪恶突袭", j["zhandoumoshi"])
            return
        end
        if not j["IsPlayerSpell"](l("390259")) then
            if j["zhandoumoshi"] == l("1") and j["CD_TQ"] <= j["GCD"] + j["GCD_Max"] * l("2") and j["TargetRange"] <=
                l("5") and j["Runes"] >= l("2") and
                (j["DebuffCount_KLZS"] == l("0") or j["DebuffCount_KLZS"] <= l("3") and j["T31Count"] < l("2") and
                    j["T32Count"] < l("2")) then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF8", "脓疮补溃", j["zhandoumoshi"])
                return
            end
            if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("天启") and j["DebuffCount_KLZS"] >= l("1") and
                (j["DebuffCount_KLZS"] >= l("4") or j["T31Count"] >= l("2") or j["T32Count"] >= l("2")) then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF3", "天启", j["zhandoumoshi"])
                return
            end
        end
        if j["WRSet"]["XE_ZEFZ"] == l("1") and j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("憎恶附肢") and
            (j["Runes"] < l("2") or j["BuffCount_KLZL"] > l("10") or not j["IsPlayerSpell"](l("377590")) or
                j["BuffTime_KLZL"] > j["GCD"] and j["BuffTime_KLZL"] < l("12")) then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ASF12", "憎恶附肢", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_CR"]() and j["RunicPower"] >= l("85") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF3", "满传染", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_DLCR"]() and j["RunicPower"] >= l("85") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF2", "满缠绕", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_KWDL"]() and j["BuffTime_XD"] <= j["GCD"] + j["GCD_Max"] + l("1") and
            j["HUCountRange8"] == l("1") and
            (j["BuffTime_HATB"] > l("8") or j["TQ_Time"] ~= h and l("25") - (j["GetTime"]() - j["TQ_Time"]) > l("8") or
                j["TQ_Time"] ~= h and l("20") - (j["GetTime"]() - j["TQ_Time"]) > l("8") or j["WZDJ_Time"] ~= h and
                l("30") - (j["GetTime"]() - j["WZDJ_Time"]) > l("8") or j["IsPlayerSpell"](l("152280")) and
                (j["SXG_Sum"] >= l("1") or j["TQ_Time"] ~= h and j["GetTime"]() - j["TQ_Time"] < l("20") or
                    j["WZDJ_Time"] ~= h and j["GetTime"]() - j["WZDJ_Time"] < l("30") or j["BuffTime_HATB"] > j["GCD"])) then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF9", "单体凋零", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_TZDJ"]() and j["BuffCount_KLZL"] < l("20") and
            (j["BuffTime_KWDL"] > j["GCD"] + l("0.2") or j["HUCountRange8"] == l("1")) and j["Runes"] == l("6") then
            if j["WR_DeathKnightUnholy_NCDJ"]() and j["HUCountRange8"] == l("1") and j["DebuffCount_KLZS"] == l("0") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF8", "满脓疮", j["zhandoumoshi"])
                return
            end
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF5", "满天灾", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_CR"]() and j["BuffTime_MRTJ"] > j["GCD"] then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF3", "免费传染", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_DLCR"]() and j["BuffTime_MRTJ"] > j["GCD"] then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF2", "免费缠绕", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_CR"]() and j["RunicPower"] >= l("70") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF3", "高能传染", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_DLCR"]() and j["RunicPower"] >= l("70") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF2", "高能缠绕", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_CR"]() and j["BuffTime_HATB"] > j["GCD"] and j["BuffTime_HATB"] < j["GCD"] +
            j["GCD_Max"] * l("3") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF3", "续时传染", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_DLCR"]() and j["BuffTime_HATB"] > j["GCD"] and j["BuffTime_HATB"] < j["GCD"] +
            j["GCD_Max"] * l("3") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF2", "续时缠绕", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_TZDJ"]() and j["BuffCount_KLZL"] < l("20") and j["Runes"] >= l("2") and
            (j["BuffTime_KWDL"] > j["GCD"] + l("0.2") or j["HUCountRange8"] == l("1")) then
            if j["WR_DeathKnightUnholy_NCDJ"]() and j["HUCountRange8"] == l("1") and j["DebuffCount_KLZS"] == l("0") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF8", "溃烂脓疮", j["zhandoumoshi"])
                return
            end
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF5", "溃烂天灾", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_CR"]() then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACF3", "传染", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_DLCR"]() then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("ACSF2", "凋零缠绕", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_TZDJ"]() and j["Runes"] >= l("2") and
            (j["BuffTime_KWDL"] > j["GCD"] + l("0.2") or j["HUCountRange8"] == l("1")) then
            if j["WR_DeathKnightUnholy_NCDJ"]() and j["HUCountRange8"] == l("1") and j["DebuffCount_KLZS"] == l("0") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF8", "脓疮打击", j["zhandoumoshi"])
                return
            end
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("SF5", "天灾打击", j["zhandoumoshi"])
            return
        end
        if j["WR_DeathKnightUnholy_KWDL"]() and j["HUCountRange8"] >= l("2") then
            j["WR_HideColorFrame"](j["zhandoumoshi"])
            j["WR_ShowColorFrame"]("CF9", "补凋零", j["zhandoumoshi"])
            return
        end
        if (j["zhandoumoshi"] ~= l("1") or j["BuffTime_KWDL"] <= j["GCD"] and j["GetSpellCharges"]("枯萎凋零") ==
            l("0") or j["HUCountRange8"] == l("1")) and (j["CD_KWDL"] > l("5") or j["Runes"] >= l("5")) then
            if j["WR_DeathKnightUnholy_NCDJ"]() and (j["HUCountRange8"] >= l("2") or j["DebuffCount_KLZS"] == l("0")) then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("CF8", "脓疮填充", j["zhandoumoshi"])
                return
            end
            if j["WR_DeathKnightUnholy_TZDJ"]() and j["Runes"] >= l("2") then
                j["WR_HideColorFrame"](j["zhandoumoshi"])
                j["WR_ShowColorFrame"]("SF5", "天灾填充", j["zhandoumoshi"])
                return
            end
        end
        j["WR_HideColorFrame"](j["zhandoumoshi"])
        if j["MSG"] == l("1") then
        end
    end;
    j["WR_DeathKnightUnholy_CR"] = function()
        if j["WR_SpellUsable"]("传染") and j["DebuffTime_EXWY"] > j["GCD"] and j["TargetRange"] <= l("30") and
            j["HUCountRange8"] >= l("2") then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_DLCR"] = function()
        if j["WR_SpellUsable"]("凋零缠绕") and j["TargetRange"] <= l("30") and
            (j["HUCountRange8"] == l("1") or not j["IsPlayerSpell"](l("207317"))) then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_TZDJ"] = function()
        if not j["IsPlayerSpell"](l("207311")) and j["WR_SpellUsable"]("天灾打击") and j["TargetRange"] <= l("5") or
            j["IsPlayerSpell"](l("207311")) and j["WR_SpellUsable"]("暗影之爪") and j["TargetRange"] <= l("30") then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_NCDJ"] = function()
        if j["WR_SpellUsable"]("脓疮打击") and j["TargetRange"] <= l("5") and j["DebuffCount_KLZS"] <= l("3") then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_BF"] = function(B)
        if j["WR_SpellUsable"]("爆发") and j["WR_GetUnitRange"](B) <= l("30") and j["WR_TargetInCombat"](B) and
            j["WR_GetUnitDeathTime"](B) > j["WR_GetUnitDebuffInfo"](B, "恶性瘟疫", g) and
            (not j["IsPlayerSpell"](l("390175")) and j["WR_GetUnitDebuffInfo"](B, "恶性瘟疫", g) <= l("27") *
                l("0.3") or j["WR_GetUnitDebuffInfo"](B, "恶性瘟疫", g) <= l("27") * l("0.3") / l("2")) and
            (j["zhandoumoshi"] ~= l("1") or not j["IsPlayerSpell"](l("115989")) or j["CD_XECQ"] > j["GCD"] +
                j["GCD_Max"] * l("2")) then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_KWDL"] = function()
        if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("枯萎凋零") and j["TargetRange"] <= l("5") and
            j["BuffTime_KWDL"] <= j["GCD"] + l("0.2") then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_LJDJ"] = function()
        if j["WRSet"]["XE_LJDJ"] ~= l("6") and j["WR_SpellUsable"]("灵界打击") and j["TargetRange"] <= l("5") and
            j["PlayerHP"] <= j["WRSet"]["XE_LJDJ"] / l("10") then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_FMFHZ"] = function()
        if j["WR_SpellUsable"]("反魔法护罩") and j["IsPlayerSpell"](l("48707")) and j["WR_SpellReflection"](l("1")) then
            return g
        end
        return f
    end;
    j["WR_DeathKnightUnholy_LastSpellTime"] = function()
        if j["LastSpellIsOpen"] == g then
            return
        end
        local C = j["CreateFrame"]("Frame")
        C["RegisterEvent"](C, "COMBAT_LOG_EVENT_UNFILTERED")
        C["SetScript"](C, "OnEvent", function()
            if j["select"](l("4"), j["CombatLogGetCurrentEventInfo"]()) == j["UnitGUID"]("player") then
                if j["select"](l("2"), j["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
                    local D = j["select"](l("13"), j["CombatLogGetCurrentEventInfo"]())
                    if D == "亡者大军" then
                        j["WZDJ_Time"] = j["GetTime"]()
                    end
                    if D == "天启" then
                        j["TQ_Time"] = j["GetTime"]()
                    end
                    if D == "召唤石像鬼" then
                        j["ZHSXG_Time"] = j["GetTime"]()
                    end
                end
            end
        end)
        j["LastSpellIsOpen"] = g
    end;
    if j["zhandoumoshi"] == l("1") and j["WR_SpellUsable"]("黑暗突变") and j["CD_KWDL"] < l("10") then
        j["WR_HideColorFrame"](j["zhandoumoshi"])
        j["WR_ShowColorFrame"]("CF7", "黑暗突变", j["zhandoumoshi"])
        return
    end
end)()
