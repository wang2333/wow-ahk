local a = 48;
local b = 40;
local c = 47;
local d = 0 == 1;
local e = not d;
local f = nil;
local g = ""
local h = _G;
local i = _ENV;
local j = h["tonumber"]
return (function(...)
    h["WR_DeathKnightUnholy"] = function()
        if h["GetSpecialization"]() ~= j("3") then
            return
        end
        h["ShiFaSuDu"] = j("0.3")
        local k = {
            [j("1")] = j("207198"),
            [j("2")] = j("207199"),
            [j("3")] = j("207200"),
            [j("4")] = j("207201"),
            [j("5")] = j("207203")
        }
        h["T31Count"] = h["WR_GetSuit"](k)
        local l = {
            [j("1")] = j("217221"),
            [j("2")] = j("217222"),
            [j("3")] = j("217223"),
            [j("4")] = j("217224"),
            [j("5")] = j("217225")
        }
        h["T32Count"] = h["WR_GetSuit"](l)
        h["GCD"] = h["WR_GetGCD"]("灵界打击")
        h["GCD_Max"] = h["WR_GetMaxGCD"](j("1.5"))
        h["CD_KWDL"] = h["WR_GetGCD"]("枯萎凋零")
        h["CD_ZHSSG"] = h["WR_GetGCD"]("召唤石像鬼")
        h["CD_TQ"] = h["WR_GetGCD"]("天启")
        h["CD_XECQ"] = h["WR_GetGCD"]("邪恶虫群")
        h["CD_XETX"] = h["WR_GetGCD"]("邪恶突袭")
        h["Runes"] = h["WR_GetRuneCount"]()
        h["RunicPower"] = h["UnitPower"]("player", j("6"))
        h["PlayerHP"] = h["UnitHealth"]("player") / h["UnitHealthMax"]("player")
        h["TargetRange"] = h["WR_GetUnitRange"]("target")
        h["HUCountRange5"] = h["WR_GetRangeHarmUnitCount"](j("5"), d)
        h["HUCountRange8"] = h["WR_GetRangeHarmUnitCount"](j("8"), d)
        h["HUCountRange30"] = h["WR_GetRangeHarmUnitCount"](j("30"), e)
        h["AvgDeathTime"] = h["WR_GetRangeAvgDeathTime"](j("40"))
        h["TargetDeathTime"] = h["WR_GetUnitDeathTime"]("target")
        h["SXG_Sum"] = j("0")
        h["SXG_Time"] = f;
        for m = j("1"), j("5"), j("1") do
            local n, o, p, q, n = h["GetTotemInfo"](m)
            if o == "黑锋石像鬼" then
                h["SXG_Sum"] = j("1")
                h["SXG_Time"] = p + q - h["GetTime"]()
                break
            end
        end
        h["BuffTime_KLZL"], h["BuffCount_KLZL"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "溃烂之力")
        h["BuffTime_KWDL"], h["BuffCount_KWDL"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "枯萎凋零")
        h["BuffTime_FMFHZ"], h["BuffCount_FMFHZ"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "反魔法护罩")
        h["BuffTime_XD"], h["BuffCount_XD"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "亵渎")
        h["BuffTime_WZZHG"], h["BuffCount_WZZHG"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "亡者指挥官")
        h["BuffTime_WYSZ"], h["BuffCount_WYSZ"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "瘟疫使者")
        h["BuffTime_MRTJ"], h["BuffCount_MRTJ"], h["_"] = h["WR_GetUnitBuffInfo"]("player", "末日突降")
        h["BuffTime_HATB"], h["BuffCount_HATB"], h["_"] = h["WR_GetUnitBuffInfo"]("pet", "黑暗突变")
        h["DebuffTime_KLZS"], h["DebuffCount_KLZS"], h["_"] = h["WR_GetUnitDebuffInfo"]("target", "溃烂之伤", e)
        h["DebuffTime_EXWY"], h["DebuffCount_EXWY"], h["_"] = h["WR_GetUnitDebuffInfo"]("target", "恶性瘟疫", e)
        h["DebuffTime_SWXL"], h["DebuffCount_SWXL"], h["_"] = h["WR_GetUnitDebuffInfo"]("target", "死亡朽烂", e)
        h["WR_DeathKnightUnholy_LastSpellTime"]()
        if h["WR_CreateMacroButtonInfo"] ~= e and not h["UnitAffectingCombat"]("player") and
            h["WR_CreateMacroButtonPass"]() ~= f then
            h["WR_CreateMacroButtonInfo"] = e;
            h["WR_DeathKnightCreateMacroButton"]()
        end
        if h["MSG"] == j("1") then
            h["print"]("----------")
        end
        if h["IsFlying"]() or h["UnitIsDead"]("player") or h["SpellIsTargeting"]() or h["UnitChannelInfo"]("player") ~=
            f then
            h["WR_HideColorFrame"](j("0"))
            h["WR_HideColorFrame"](j("1"))
            return
        end
        if not h["UnitIsDead"]("player") and (h["UnitAffectingCombat"]("player") or h["WR_InTraining"]()) then
            h["WR_CombatFrame"]["Show"](h["WR_CombatFrame"])
        else
            h["WR_CombatFrame"]["Hide"](h["WR_CombatFrame"])
        end
        if h["zhandoumoshi"] ~= j("1") then
            h["WR_HideColorFrame"](j("1"))
            h["WR_ShowColorFrame"]("SF10", "爆发", j("1"))
        end
        if h["zhandoumoshi"] == j("1") then
            h["WR_HideColorFrame"](j("0"))
            h["WR_ShowColorFrame"]("SF12", "平伤", j("0"))
        end
        if h["WRSet"]["XE_WYZQ"] ~= j("6") and h["WR_SpellUsable"]("巫妖之躯") and h["PlayerHP"] <
            h["WRSet"]["XE_WYZQ"] / j("10") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF8", "巫妖之躯", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_BFZR"] ~= j("6") and h["WR_SpellUsable"]("冰封之韧") and h["PlayerHP"] <
            h["WRSet"]["XE_BFZR"] / j("10") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF2", "冰封之韧", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_ZLS"] ~= j("5") and h["PlayerHP"] < h["WRSet"]["XE_ZLS"] / j("10") then
            local r = h["GetItemCount"]("治疗石")
            local s, q, t = h["GetItemCooldown"]("治疗石")
            if r ~= f and r >= j("1") and s + q - h["GetTime"]() <= j("0") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF6", "治疗石", h["zhandoumoshi"])
                return
            end
        end
        if h["WRSet"]["XE_ZLYS"] ~= j("5") and h["PlayerHP"] < h["WRSet"]["XE_ZLYS"] / j("10") then
            local u = {
                [j("1")] = "振奋治疗药水",
                [j("2")] = "梦行者治疗药水",
                [j("3")] = "凋零梦境药水"
            }
            for n, v in h["ipairs"](u) do
                local r = h["GetItemCount"](v)
                local s, q, t = h["GetItemCooldown"](v)
                if r ~= f and r >= j("1") and s + q - h["GetTime"]() <= j("0") then
                    h["WR_HideColorFrame"](h["zhandoumoshi"])
                    h["WR_ShowColorFrame"]("CF10", "治疗药水", h["zhandoumoshi"])
                    return
                end
            end
        end
        if h["WRSet"]["XE_FMFHZ"] == j("1") and h["WR_DeathKnightUnholy_FMFHZ"]() then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF11", "反魔法护罩", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_XLBD"] ~= j("3") and h["WR_DeathKnightFrost_XLBD"]("target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF2", "心灵冰冻T", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_XLBD"] == j("1") and h["WR_DeathKnightFrost_XLBD"]("mouseover") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF3", "心灵冰冻M", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightFrost_FHMY"]("mouseover") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF3", "复活盟友M", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightFrost_KZWL"]() then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF1", "控制亡灵", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_ZMBY"] == j("1") and h["WR_DeathKnightFrost_ZMBY"]() then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF6", "致盲冰雨", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_ZX"] == j("1") and h["WR_DeathKnightFrost_ZX"]("target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF7", "窒息T", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_ZX"] == j("1") and h["WR_DeathKnightFrost_ZX"]("mouseover") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF9", "窒息M", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_ZNMB"] == j("1") and h["HUCountRange5"] >= j("1") and h["UnitAffectingCombat"]("player") and
            (not h["WR_TargetInCombat"]("target") or h["WR_GetUnitRange"]("target") > j("5")) then
            h["WR_ZNMB"] = e;
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF5", "智能目标", h["zhandoumoshi"])
            return
        end
        if h["WR_SpellUsable"]("亡者复生") and (not h["UnitExists"]("pet") or h["UnitIsDead"]("pet")) and
            not h["UnitExists"]("pet") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF1", "亡者复生", h["zhandoumoshi"])
            return
        end
        if not h["WR_TargetInCombat"]("target") or h["GCD"] > h["ShiFaSuDu"] then
            h["WR_HideColorFrame"](j("0"))
            h["WR_HideColorFrame"](j("1"))
            return
        end
        if h["WR_DeathKnightUnholy_LJDJ"]() then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF7", "灵界打击", h["zhandoumoshi"])
            return
        end
        if h["WRSet"]["XE_WZDJ"] == j("1") and h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("亡者大军") and
            h["TargetRange"] <= j("30") and
            (h["IsPlayerSpell"](j("49206")) and h["CD_ZHSSG"] < h["GCD"] + j("3") * h["GCD_Max"] or
                not h["IsPlayerSpell"](j("49206"))) then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF1", "亡者大军", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_KWDL"]() and h["BuffTime_XD"] <= h["GCD"] + h["GCD_Max"] + j("1") and
            h["HUCountRange8"] >= j("2") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF9", "枯萎凋零", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_TZDJ"]() and h["IsPlayerSpell"](j("390175")) and h["BuffTime_WYSZ"] < h["GCD"] +
            h["GCD_Max"] and (h["CD_XETX"] <= h["GCD"] or h["HUCountRange8"] >= j("3")) then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF5", "天灾加速", h["zhandoumoshi"])
            return
        end
        if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("邪恶虫群") and h["TargetRange"] <= j("5") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF1", "邪恶虫群", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_BF"]("target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF4", "爆发t", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_BF"]("mouseover") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF7", "爆发m", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_BF"]("party1target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF8", "爆发P1", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_BF"]("party2target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF9", "爆发P2", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_BF"]("party3target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF10", "爆发P3", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_BF"]("party4target") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF1", "爆发P4", h["zhandoumoshi"])
            return
        end
        if h["WR_SpellUsable"]("灵魂收割") and h["TargetRange"] <= j("5") and h["HUCountRange8"] == j("1") and
            h["UnitHealth"]("target") / h["UnitHealthMax"]("target") <= j("0.36") and h["TargetDeathTime"] > j("5") +
            j("3") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF6", "灵魂收割", h["zhandoumoshi"])
            return
        end
        if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("黑暗突变") and h["CD_KWDL"] < j("10") then
            if h["IsPlayerSpell"](j("390259")) and h["CD_TQ"] <= h["GCD"] + h["GCD_Max"] * j("2") and h["TargetRange"] <=
                j("5") and h["Runes"] >= j("2") and h["DebuffCount_KLZS"] <= j("3") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF8", "脓疮补溃", h["zhandoumoshi"])
                return
            end
            if not h["IsPlayerSpell"](j("390259")) or h["DebuffCount_KLZS"] >= j("4") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF7", "黑暗突变", h["zhandoumoshi"])
                return
            end
        end
        if h["IsPlayerSpell"](j("390259")) then
            if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("天启") and h["BuffTime_WZZHG"] > h["GCD"] then
                if h["DebuffCount_KLZS"] >= j("4") then
                    h["WR_HideColorFrame"](h["zhandoumoshi"])
                    h["WR_ShowColorFrame"]("CF3", "满天启", h["zhandoumoshi"])
                    return
                end
            end
            if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("召唤石像鬼") and h["BuffTime_WZZHG"] > h["GCD"] then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("ACSF5", "召唤石像鬼", h["zhandoumoshi"])
                return
            end
        end
        if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("符文武器增效") and h["BuffTime_HATB"] > h["GCD"] then
            if h["WRSet"]["XE_BFYS"] == j("1") then
                local w = {
                    [j("1")] = "飞逝元素究极强能药水",
                    [j("2")] = "元素究极强能药水",
                    [j("3")] = "元素强能药水"
                }
                local x;
                for n, y in h["ipairs"](w) do
                    local r = h["GetItemCount"](y)
                    local s, q, t = h["GetItemCooldown"](y)
                    if r ~= f and r >= j("1") and s + q - h["GetTime"]() <= j("0") then
                        h["WR_HideColorFrame"](h["zhandoumoshi"])
                        h["WR_ShowColorFrame"]("ACSF3", "爆发药水", h["zhandoumoshi"])
                        return
                    end
                end
            end
            if (h["WRSet"]["XE_SP"] == j("1") or h["WRSet"]["XE_SP"] == j("3")) and h["WR_GetEquipCD"](j("13")) then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("ASF5", "饰品1", h["zhandoumoshi"])
                return
            end
            if (h["WRSet"]["XE_SP"] == j("2") or h["WRSet"]["XE_SP"] == j("3")) and h["WR_GetEquipCD"](j("14")) then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("ASF6", "饰品2", h["zhandoumoshi"])
                return
            end
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF2", "符文武器增效", h["zhandoumoshi"])
            return
        end
        if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("邪恶突袭") and h["BuffTime_HATB"] > h["GCD"] then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF4", "邪恶突袭", h["zhandoumoshi"])
            return
        end
        if not h["IsPlayerSpell"](j("390259")) then
            if h["zhandoumoshi"] == j("1") and h["CD_TQ"] <= h["GCD"] + h["GCD_Max"] * j("2") and h["TargetRange"] <=
                j("5") and h["Runes"] >= j("2") and
                (h["DebuffCount_KLZS"] == j("0") or h["DebuffCount_KLZS"] <= j("3") and h["T31Count"] < j("2") and
                    h["T32Count"] < j("2")) then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF8", "脓疮补溃", h["zhandoumoshi"])
                return
            end
            if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("天启") and h["DebuffCount_KLZS"] >= j("1") and
                (h["DebuffCount_KLZS"] >= j("4") or h["T31Count"] >= j("2") or h["T32Count"] >= j("2")) then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF3", "天启", h["zhandoumoshi"])
                return
            end
        end
        if h["WRSet"]["XE_ZEFZ"] == j("1") and h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("憎恶附肢") and
            (h["Runes"] < j("2") or h["BuffCount_KLZL"] > j("10") or not h["IsPlayerSpell"](j("377590")) or
                h["BuffTime_KLZL"] > h["GCD"] and h["BuffTime_KLZL"] < j("12")) then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ASF12", "憎恶附肢", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_CR"]() and h["RunicPower"] >= j("85") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF3", "满传染", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_DLCR"]() and h["RunicPower"] >= j("85") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF2", "满缠绕", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_KWDL"]() and h["BuffTime_XD"] <= h["GCD"] + h["GCD_Max"] + j("1") and
            h["HUCountRange8"] == j("1") and
            (h["BuffTime_HATB"] > j("8") or h["TQ_Time"] ~= f and j("25") - (h["GetTime"]() - h["TQ_Time"]) > j("8") or
                h["TQ_Time"] ~= f and j("20") - (h["GetTime"]() - h["TQ_Time"]) > j("8") or h["WZDJ_Time"] ~= f and
                j("30") - (h["GetTime"]() - h["WZDJ_Time"]) > j("8") or h["IsPlayerSpell"](j("152280")) and
                (h["SXG_Sum"] >= j("1") or h["TQ_Time"] ~= f and h["GetTime"]() - h["TQ_Time"] < j("20") or
                    h["WZDJ_Time"] ~= f and h["GetTime"]() - h["WZDJ_Time"] < j("30") or h["BuffTime_HATB"] > h["GCD"])) then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF9", "单体凋零", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_TZDJ"]() and h["BuffCount_KLZL"] < j("20") and
            (h["BuffTime_KWDL"] > h["GCD"] + j("0.2") or h["HUCountRange8"] == j("1")) and h["Runes"] == j("6") then
            if h["WR_DeathKnightUnholy_NCDJ"]() and h["HUCountRange8"] == j("1") and h["DebuffCount_KLZS"] == j("0") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF8", "满脓疮", h["zhandoumoshi"])
                return
            end
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF5", "满天灾", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_CR"]() and h["BuffTime_MRTJ"] > h["GCD"] then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF3", "免费传染", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_DLCR"]() and h["BuffTime_MRTJ"] > h["GCD"] then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF2", "免费缠绕", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_CR"]() and h["RunicPower"] >= j("70") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF3", "高能传染", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_DLCR"]() and h["RunicPower"] >= j("70") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF2", "高能缠绕", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_CR"]() and h["BuffTime_HATB"] > h["GCD"] and h["BuffTime_HATB"] < h["GCD"] +
            h["GCD_Max"] * j("3") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF3", "续时传染", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_DLCR"]() and h["BuffTime_HATB"] > h["GCD"] and h["BuffTime_HATB"] < h["GCD"] +
            h["GCD_Max"] * j("3") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF2", "续时缠绕", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_TZDJ"]() and h["BuffCount_KLZL"] < j("20") and h["Runes"] >= j("2") and
            (h["BuffTime_KWDL"] > h["GCD"] + j("0.2") or h["HUCountRange8"] == j("1")) then
            if h["WR_DeathKnightUnholy_NCDJ"]() and h["HUCountRange8"] == j("1") and h["DebuffCount_KLZS"] == j("0") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF8", "溃烂脓疮", h["zhandoumoshi"])
                return
            end
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF5", "溃烂天灾", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_CR"]() then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACF3", "传染", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_DLCR"]() then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("ACSF2", "凋零缠绕", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_TZDJ"]() and h["Runes"] >= j("2") and
            (h["BuffTime_KWDL"] > h["GCD"] + j("0.2") or h["HUCountRange8"] == j("1")) then
            if h["WR_DeathKnightUnholy_NCDJ"]() and h["HUCountRange8"] == j("1") and h["DebuffCount_KLZS"] == j("0") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF8", "脓疮打击", h["zhandoumoshi"])
                return
            end
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("SF5", "天灾打击", h["zhandoumoshi"])
            return
        end
        if h["WR_DeathKnightUnholy_KWDL"]() and h["HUCountRange8"] >= j("2") then
            h["WR_HideColorFrame"](h["zhandoumoshi"])
            h["WR_ShowColorFrame"]("CF9", "补凋零", h["zhandoumoshi"])
            return
        end
        if (h["zhandoumoshi"] ~= j("1") or h["BuffTime_KWDL"] <= h["GCD"] and h["GetSpellCharges"]("枯萎凋零") ==
            j("0") or h["HUCountRange8"] == j("1")) and (h["CD_KWDL"] > j("5") or h["Runes"] >= j("5")) then
            if h["WR_DeathKnightUnholy_NCDJ"]() and (h["HUCountRange8"] >= j("2") or h["DebuffCount_KLZS"] == j("0")) then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("CF8", "脓疮填充", h["zhandoumoshi"])
                return
            end
            if h["WR_DeathKnightUnholy_TZDJ"]() and h["Runes"] >= j("2") then
                h["WR_HideColorFrame"](h["zhandoumoshi"])
                h["WR_ShowColorFrame"]("SF5", "天灾填充", h["zhandoumoshi"])
                return
            end
        end
        h["WR_HideColorFrame"](h["zhandoumoshi"])
        if h["MSG"] == j("1") then
        end
    end;
    h["WR_DeathKnightUnholy_CR"] = function()
        if h["WR_SpellUsable"]("传染") and h["DebuffTime_EXWY"] > h["GCD"] and h["TargetRange"] <= j("30") and
            h["HUCountRange8"] >= j("2") then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_DLCR"] = function()
        if h["WR_SpellUsable"]("凋零缠绕") and h["TargetRange"] <= j("30") and
            (h["HUCountRange8"] == j("1") or not h["IsPlayerSpell"](j("207317"))) then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_TZDJ"] = function()
        if not h["IsPlayerSpell"](j("207311")) and h["WR_SpellUsable"]("天灾打击") and h["TargetRange"] <= j("5") or
            h["IsPlayerSpell"](j("207311")) and h["WR_SpellUsable"]("暗影之爪") and h["TargetRange"] <= j("30") then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_NCDJ"] = function()
        if h["WR_SpellUsable"]("脓疮打击") and h["TargetRange"] <= j("5") and h["DebuffCount_KLZS"] <= j("3") then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_BF"] = function(z)
        if h["WR_SpellUsable"]("爆发") and h["WR_GetUnitRange"](z) <= j("30") and h["WR_TargetInCombat"](z) and
            h["WR_GetUnitDeathTime"](z) > h["WR_GetUnitDebuffInfo"](z, "恶性瘟疫", e) and
            (not h["IsPlayerSpell"](j("390175")) and h["WR_GetUnitDebuffInfo"](z, "恶性瘟疫", e) <= j("27") *
                j("0.3") or h["WR_GetUnitDebuffInfo"](z, "恶性瘟疫", e) <= j("27") * j("0.3") / j("2")) and
            (h["zhandoumoshi"] ~= j("1") or not h["IsPlayerSpell"](j("115989")) or h["CD_XECQ"] > h["GCD"] +
                h["GCD_Max"] * j("2")) then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_KWDL"] = function()
        if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("枯萎凋零") and h["TargetRange"] <= j("5") and
            h["BuffTime_KWDL"] <= h["GCD"] + j("0.2") then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_LJDJ"] = function()
        if h["WRSet"]["XE_LJDJ"] ~= j("6") and h["WR_SpellUsable"]("灵界打击") and h["TargetRange"] <= j("5") and
            h["PlayerHP"] <= h["WRSet"]["XE_LJDJ"] / j("10") then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_FMFHZ"] = function()
        if h["WR_SpellUsable"]("反魔法护罩") and h["IsPlayerSpell"](j("48707")) and h["WR_SpellReflection"](j("1")) then
            return e
        end
        return d
    end;
    h["WR_DeathKnightUnholy_LastSpellTime"] = function()
        if h["LastSpellIsOpen"] == e then
            return
        end
        local A = h["CreateFrame"]("Frame")
        A["RegisterEvent"](A, "COMBAT_LOG_EVENT_UNFILTERED")
        A["SetScript"](A, "OnEvent", function()
            if h["select"](j("4"), h["CombatLogGetCurrentEventInfo"]()) == h["UnitGUID"]("player") then
                if h["select"](j("2"), h["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
                    local B = h["select"](j("13"), h["CombatLogGetCurrentEventInfo"]())
                    if B == "亡者大军" then
                        h["WZDJ_Time"] = h["GetTime"]()
                    end
                    if B == "天启" then
                        h["TQ_Time"] = h["GetTime"]()
                    end
                    if B == "召唤石像鬼" then
                        h["ZHSXG_Time"] = h["GetTime"]()
                    end
                end
            end
        end)
        h["LastSpellIsOpen"] = e
    end;
    if h["zhandoumoshi"] == j("1") and h["WR_SpellUsable"]("黑暗突变") and h["CD_KWDL"] < j("10") then
        h["WR_HideColorFrame"](h["zhandoumoshi"])
        h["WR_ShowColorFrame"]("CF7", "黑暗突变", h["zhandoumoshi"])
        return
    end
end)()
