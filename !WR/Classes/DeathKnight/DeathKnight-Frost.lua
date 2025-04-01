local a = 42;
local b = 36;
local c = 0 == 1;
local d = not c;
local e = nil;
local f = ""
local g = _G;
local h = _ENV;
local i = g["tonumber"]
return (function(...)
    g["WR_DeathKnightFrost"] = function()
        if g["GetSpecialization"]() ~= i("2") then
            return
        end
        g["ShiFaSuDu"] = i("0.05") + g["WRSet"]["BS_SFSD"] * i("0.05")
        g["GCD"] = g["WR_GetGCD"]("灵界打击")
        g["MaxGCD"] = g["WR_GetMaxGCD"](i("1.5"))
        g["Runes"] = g["WR_GetRuneCount"]()
        g["RunicPower"] = g["UnitPower"]("player", i("6"))
        g["TargetCloseRange"] = g["C_Spell"]["IsSpellInRange"]("冰霜打击", "target") or
                                    g["C_Spell"]["IsSpellInRange"]("灵界打击", "target")
        g["TargetRange"] = g["WR_GetUnitRange"]("target")
        g["TargetInCombat"] = g["WR_TargetInCombat"]("target")
        g["RaidOrParty"] = g["WR_GetInRaidOrParty"]()
        g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
        g["HUCountRange5"] = g["WR_GetRangeHarmUnitCount"](i("5"), c)
        g["BuffTime_BSZZ"] = g["WR_GetUnitBuffTime"]("player", "冰霜之柱")
        g["BuffTime_SLJQ"], g["BuffCount_SLJQ"] = g["WR_GetUnitBuffInfo"]("player", "杀戮机器")
        g["WR_DeathKnightFrost_LastSpellTime"]()
        if g["MSG"] == i("1") then
            g["print"]("----------")
        end
        if g["WR_PriorityCheck"]() then
            return
        end
        if g["WR_ZNJD"](g["WRSet"]["BS_ZNJD"]) then
            return
        end
        if g["WR_DeathKnightFrost_Function_WYZQ"]() then
            return
        end
        if g["WR_DeathKnightFrost_Function_BFZR"]() then
            return
        end
        if g["WR_ZLS"](g["WRSet"]["BS_ZLS"]) then
            return d
        end
        if g["WR_ZLYS"](g["WRSet"]["BS_ZLYS"]) then
            return d
        end
        if g["WR_ZLYS2"](g["WRSet"]["BS_ZLYS"]) then
            return d
        end
        if g["WR_DeathKnightFrost_ShiPin"]("自保/协助") then
            return c
        end
        if g["WR_DeathKnight_Function_FMFHZ"]() then
            return
        end
        if g["WR_DeathKnight_Function_ZN"]() then
            return
        end
        if g["WR_DeathKnight_Function_FHMY"]() then
            return
        end
        if g["WR_DeathKnight_Function_ZMBY"]() then
            return
        end
        if g["WR_DeathKnight_Function_ZX"]() then
            return
        end
        if g["WR_DeathKnight_Function_KZWL"]() then
            return
        end
        if g["WR_DeathKnightFrost_Function_Combat"]() then
            return
        end
        if g["WR_DeathKnight_Function_ZNMB"]() then
            return
        end
        g["WR_HideColorFrame"](g["zhandoumoshi"])
    end;
    g["WR_DeathKnightFrost_Function_Combat"] = function()
        if not g["TargetInCombat"] then
            return c
        end
        if g["WR_GetUnitBuffTime"]("player", "冰龙吐息") > g["GCD"] then
            if g["WR_DeathKnightFrost_FWWQZX"]() then
                return d
            end
            if g["WR_DeathKnightFrost_HDHJ"]() then
                return d
            end
            if g["WR_DeathKnightFrost_LKYD"]() then
                return d
            end
            if g["WR_DeathKnightFrost_KWDL"]("AOE") then
                return d
            end
            if g["WR_DeathKnightFrost_SSYJ"]() then
                return d
            end
            if g["WR_DeathKnightFrost_BSZZ"]() then
                return d
            end
            if g["WR_InBossCombat"]() then
                if g["WR_DeathKnightFrost_YM"]("吐2") then
                    return d
                end
                if g["WR_DeathKnightFrost_LFCJ"]("吐1") then
                    return d
                end
            else
                if g["WR_DeathKnightFrost_YM"]("吐1") then
                    return d
                end
                if g["WR_DeathKnightFrost_LFCJ"]("吐1") then
                    return d
                end
                if g["WR_DeathKnightFrost_YM"]("吐2") then
                    return d
                end
                if g["WR_DeathKnightFrost_LFCJ"]("吐2") then
                    return d
                end
            end
            return c
        end
        if g["WR_DeathKnightFrost_ShiPin"]("常驻") then
            return d
        end
        if g["WR_WuQi"](i("3"), g["WRSet"]["BS_WuQi"]) then
            return d
        end
        if g["WR_DeathKnightFrost_LJDJ"]() then
            return d
        end
        if g["WR_DeathKnightFrost_ZEFZ"]() then
            return d
        end
        if g["WR_DeathKnightFrost_LKYD"]() then
            return d
        end
        if g["WR_DeathKnightFrost_KWDL"]("AOE") then
            return d
        end
        if g["WR_DeathKnightFrost_WZFS"]() then
            return d
        end
        if g["WR_DeathKnightFrost_BSJLZN"]() then
            return d
        end
        if g["WR_DeathKnightFrost_HBLJ"]() then
            return d
        end
        if g["WR_DeathKnightFrost_SSYJ"]() then
            return d
        end
        if g["WR_DeathKnightFrost_YM"]("存能") then
            return d
        end
        if g["WR_DeathKnightFrost_KWDL"]("急速") then
            return d
        end
        if g["WR_DeathKnightFrost_FWWQZX"]() then
            return d
        end
        if g["WR_DeathKnightFrost_BSZZ"]() then
            return d
        end
        if g["WR_DeathKnightFrost_BLTX"]() then
            return d
        end
        if g["WR_DeathKnightFrost_LHSG"]() then
            return d
        end
        if g["WR_DeathKnightFrost_YM"]("2杀戮") then
            return d
        end
        if g["WR_DeathKnightFrost_BSDJ_FRZS5"]() then
            return d
        end
        if g["WR_DeathKnightFrost_YM"]("杀戮") then
            return d
        end
        if g["WR_DeathKnightFrost_LFCJ"]("白霜") then
            return d
        end
        if g["WR_DeathKnightFrost_BSDJ"]("target") then
            return d
        end
        if g["WR_DeathKnightFrost_YM"]("填充") then
            return d
        end
        if g["WR_DeathKnightFrost_LFCJ"]("疫病") then
            return d
        end
        if g["WR_DeathKnightFrost_HDHJ"]() then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_ShiPin"] = function(j)
        if j == "常驻" then
            if g["TargetCloseRange"] and g["TargetInCombat"] then
                if g["WRSet"]["BS_SP1"] == i("1") then
                    if g["WR_ShiPin"](i("1"), g["WRSet"]["BS_SP1"]) then
                        return d
                    end
                end
                if g["WRSet"]["BS_SP2"] == i("1") then
                    if g["WR_ShiPin"](i("2"), g["WRSet"]["BS_SP2"]) then
                        return d
                    end
                end
            end
        elseif j == "自保/协助" then
            if g["WRSet"]["BS_SP1"] >= i("3") then
                if g["WR_ShiPin"](i("1"), g["WRSet"]["BS_SP1"]) then
                    return d
                end
            end
            if g["WRSet"]["BS_SP2"] >= i("3") then
                if g["WR_ShiPin"](i("2"), g["WRSet"]["BS_SP2"]) then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_XLBD"] = function(k)
        if g["WR_SpellUsable"]("心灵冰冻") and g["WR_GetUnitRange"](k) <= i("15") and
            g["UnitCanAttack"]("player", k) and not g["UnitIsDead"](k) and
            g["WR_GetCastInterruptible"](k, g["InterruptTime"]) then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_FHMY"] = function(k)
        if g["WR_SpellUsable"]("复活盟友") and
            (g["IsSpellInRange"]("复活盟友", k) == i("1") or g["WR_GetUnitRange"](k) <= i("40")) and
            g["UnitIsDead"](k) and not g["UnitCanAttack"]("player", k) and g["UnitIsPlayer"](k) then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_ZMBY"] = function()
        if g["WR_SpellUsable"]("致盲冰雨") and g["WR_StunUnit"](i("10")) then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_ZX"] = function(k)
        if g["WR_SpellUsable"]("窒息") and g["WR_GetUnitRange"](k) <= i("20") and g["WR_StunSpell"](k) then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_BSJLZN"] = function()
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        local l = g["WR_GetUnitBuffTime"]("player", i("377103"))
        local m = g["WR_GetUnitBuffTime"]("player", "不洁之力")
        if g["WRSet"]["BS_BSJL"] ~= i("4") and g["zhandoumoshi"] == i("1") and g["WR_SpellUsable"]("冰霜巨龙之怒") and
            g["TargetCloseRange"] and g["BuffTime_BSZZ"] > g["GCD"] and
            (g["BuffTime_BSZZ"] < i("2") or g["WRSet"]["BS_BSJL"] == i("1") or g["WRSet"]["BS_BSJL"] == i("2") and
                (l > i("0") or m > i("0")) or g["WRSet"]["BS_BSJL"] == i("3") and
                (l > i("0") and l < i("2") or m > i("0") and m < i("2") or l > i("0") and m > i("0"))) then
            if g["WR_ColorFrame_Show"]("CSK", "冰霜巨龙") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_BCTJ"] = function()
        if g["WR_SpellUsable"]("冰川突进") and g["TargetCloseRange"] and g["IsPlayerSpell"](i("194913")) and
            g["HUCountRange5"] >= i("2") then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_Function_WYZQ"] = function()
        if g["WRSet"]["BS_WYZQ"] ~= i("6") and g["WR_SpellUsable"]("巫妖之躯") and g["PlayerHP"] <
            g["WRSet"]["BS_WYZQ"] / i("10") and g["UnitAffectingCombat"]("player") then
            if g["WR_ColorFrame_Show"]("CF2", "巫妖之躯") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_Function_BFZR"] = function()
        if g["WRSet"]["BS_BFZR"] ~= i("6") and g["WR_SpellUsable"]("冰封之韧") and g["PlayerHP"] <
            g["WRSet"]["BS_BFZR"] / i("10") and g["UnitAffectingCombat"]("player") then
            if g["WR_ColorFrame_Show"]("CF1", "冰封之韧") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_ZEFZ"] = function()
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["WRSet"]["BS_ZEFZ"] and g["zhandoumoshi"] == i("1") and g["WR_SpellUsable"]("憎恶附肢") and
            g["TargetRange"] <= i("10") and g["WR_GetGCD"]("冰霜之柱") <= i("1") and g["UnitName"]("target") ~=
            "原始海啸" and g["UnitName"]("target") ~= "哈兰·斯威提" then
            if g["WR_ColorFrame_Show"]("CSL", "憎恶附肢") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_LKYD"] = function()
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["WR_SpellUsable"]("冷酷严冬") and g["TargetRange"] <= i("7") and g["BuffTime_BSZZ"] <= g["GCD"] and
            g["WR_GetUnitBuffTime"]("player", "冷酷严冬") <= g["GCD"] and
            (g["WR_GetGCD"]("冰霜之柱") > i("20") or g["zhandoumoshi"] == i("1") and g["WR_GetGCD"]("冰霜之柱") <=
                g["GCD"]) then
            if g["WR_ColorFrame_Show"]("CSO", "冷酷严冬") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_HBLJ"] = function()
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["WR_SpellUsable"]("寒冰联结") and g["TargetCloseRange"] and
            g["WR_GetUnitBuffTime"]("player", "冰霜之柱") == i("0") then
            if g["WR_ColorFrame_Show"]("SF1", "寒冰联结") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_KWDL"] = function(j)
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["WR_SpellUsable"]("枯萎凋零") and g["TargetCloseRange"] and
            g["WR_GetUnitBuffTime"]("player", "枯萎凋零") == i("0") and g["WR_GetSpellNextCharge"]("枯萎凋零") <=
            g["WR_GetGCD"]("冰霜之柱") and (not g["WR_PlayerMove"]() or g["zhandoumoshi"] == i("1")) and
            (g["WR_GetRangeAvgDeathTime"](i("40")) > i("10") or g["WR_InTraining"]()) and
            (j == "AOE" and g["HUCountRange5"] >= i("2") and g["WRSet"]["BS_KWDL"] ~= i("3") or j == "急速" and
                g["IsPlayerSpell"](i("374265")) and g["zhandoumoshi"] == i("1") and g["IsPlayerSpell"](i("152279")) and
                g["WR_GetGCD"]("冰龙吐息") <= g["GCD"] + g["MaxGCD"] and g["WR_GetGCD"]("冰霜之柱") <= g["GCD"] +
                g["MaxGCD"] and g["WRSet"]["BS_BLTX"] and g["WRSet"]["BS_KWDL"] ~= i("3")) then
            if g["WR_ColorFrame_Show"]("SF12", "枯萎凋零") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_WZFS"] = function()
        if g["GCD"] <= g["ShiFaSuDu"] and g["WRSet"]["BS_WZFS"] and g["zhandoumoshi"] == i("1") and
            g["WR_SpellUsable"]("亡者复生") and g["TargetRange"] <= i("30") and not g["UnitExists"]("pet") then
            if g["WR_ColorFrame_Show"]("CF9", "亡者复生") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_FWWQZX"] = function()
        if g["zhandoumoshi"] == i("1") and g["WRSet"]["BS_FWWQ"] and g["TargetCloseRange"] and
            g["WR_GetUnitBuffTime"]("player", "符文武器增效") == i("0") and
            g["WR_SpellUsable"]("符文武器增效") and
            (g["IsPlayerSpell"](i("49020")) and not g["IsPlayerSpell"](i("152279")) and g["BuffTime_BSZZ"] > g["GCD"] or
                g["WR_GetUnitBuffTime"]("player", "冰龙吐息") > i("0") and g["Runes"] <= i("2") and g["RunicPower"] <=
                i("70")) then
            if g["WR_ColorFrame_Show"]("CF3", "符文武器") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_BSZZ"] = function()
        if g["zhandoumoshi"] == i("1") and g["WR_SpellUsable"]("冰霜之柱") and g["TargetCloseRange"] then
            if g["IsPlayerSpell"](i("439843")) and g["SSYJ_CastTime"] ~= e and g["GetTime"]() - g["SSYJ_CastTime"] <=
                i("12") or not g["IsPlayerSpell"](i("439843")) then
                if g["WRSet"]["BS_KWDL"] == i("1") and g["WR_GetUnitBuffTime"]("player", "枯萎凋零") == i("0") and
                    g["WR_GetGCD"]("枯萎凋零") <= g["MaxGCD"] and g["WR_GetSpellCharges"]("枯萎凋零") >= i("1") then
                    if g["WR_ColorFrame_Show"]("SF12", "冰柱凋零") then
                        return d
                    end
                end
                if g["WR_DeathKnightFrost_FWWQZX"]() then
                    return d
                end
                if g["WRSet"]["BS_SP1"] == i("2") then
                    if g["WR_ShiPin"](i("1"), g["WRSet"]["BS_SP1"]) then
                        return d
                    end
                end
                if g["WRSet"]["BS_SP2"] == i("2") then
                    if g["WR_ShiPin"](i("2"), g["WRSet"]["BS_SP2"]) then
                        return d
                    end
                end
                if g["WR_ColorFrame_Show"]("SF7", "冰霜之柱") then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_LJDJ"] = function()
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["WRSet"]["BS_LJDJ"] ~= i("6") and g["WR_SpellUsable"]("灵界打击") and g["TargetCloseRange"] then
            if g["PlayerHP"] <= g["WRSet"]["BS_LJDJ"] / i("10") then
                if g["WR_ColorFrame_Show"]("CF10", "灵界打击") then
                    return d
                end
            elseif g["PlayerHP"] <= i("0.7") and g["WR_GetUnitBuffTime"]("player", "黑暗援助") > g["GCD"] then
                if g["WR_ColorFrame_Show"]("CF10", "黑暗援助") then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_YM"] = function(j)
        if g["GCD"] <= g["ShiFaSuDu"] and g["WR_SpellUsable"]("湮灭") and g["TargetCloseRange"] and
            (g["zhandoumoshi"] == i("1") or g["Runes"] >= i("4") or g["WR_GetGCD"]("冰霜之柱") > i("10")) then
            if j == "2杀戮" and g["BuffCount_SLJQ"] >= i("2") or j == "杀戮" and g["BuffTime_SLJQ"] > g["GCD"] or j ==
                "填充" and (g["Runes"] > i("4") or g["WR_GetUnitBuffTime"]("player", "破灭") > g["GCD"] or
                g["WR_GetUnitBuffTime"]("player", "枯萎凋零") > g["GCD"]) or j == "存能" and g["RunicPower"] <=
                i("60") and g["zhandoumoshi"] == i("1") and g["IsPlayerSpell"](i("152279")) and
                g["WR_GetGCD"]("冰龙吐息") <= g["GCD"] + g["MaxGCD"] and g["WRSet"]["BS_BLTX"] or j == "吐1" and
                (g["BuffTime_SLJQ"] > g["GCD"] or g["Runes"] > i("3")) or j == "吐2" and g["RunicPower"] <= i("75") then
                if g["WR_ColorFrame_Show"]("CSU", "湮灭" .. (j or f)) then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_LFCJ"] = function(j)
        if g["GCD"] <= g["ShiFaSuDu"] and g["WR_SpellUsable"]("凛风冲击") and g["TargetRange"] <= i("30") then
            if j == "白霜" and g["WR_GetUnitBuffTime"]("player", "白霜") > g["GCD"] or j == "疫病" and
                g["WR_GetUnitDebuffInfo"]("target", "冰霜疫病", d) < g["GCD"] or j == "吐1" and
                g["WR_GetUnitBuffTime"]("player", "白霜") > g["GCD"] and g["RunicPower"] >= i("75") or j == "吐2" and
                g["WR_GetUnitBuffTime"]("player", "白霜") > g["GCD"] then
                if g["WR_ColorFrame_Show"]("CSJ", "凛风" .. (j or f)) then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_BSDJ"] = function(k, j)
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["IsPlayerSpell"](i("152279")) and g["WR_GetGCD"]("冰龙吐息") <= g["GCD"] + g["MaxGCD"] * i("5") and
            g["RunicPower"] < i("80") then
            return c
        end
        local n;
        if j ~= e then
            n = j
        else
            n = "冰霜打击"
        end
        if g["WR_SpellUsable"]("冰霜打击") and g["C_Spell"]["IsSpellInRange"]("冰霜打击", k) and
            (j ~= "锋霜" or j == "锋霜" and g["WR_GetUnitDebuffCount"](k, "锋锐之霜", d) >= i("5")) then
            if k == "target" then
                if g["WR_ColorFrame_Show"]("CF11", n .. "T") then
                    return d
                end
            elseif k == "mouseover" then
                if g["WR_ColorFrame_Show"]("SF2", n .. "M") then
                    return d
                end
            elseif k == "focus" then
                if g["WR_ColorFrame_Show"]("SF3", n .. "F") then
                    return d
                end
            elseif k == "party1target" then
                if g["WR_ColorFrame_Show"]("SF5", n .. "P1T") then
                    return d
                end
            elseif k == "party2target" then
                if g["WR_ColorFrame_Show"]("SF8", n .. "P2T") then
                    return d
                end
            elseif k == "party3target" then
                if g["WR_ColorFrame_Show"]("CSF7", n .. "P3T") then
                    return d
                end
            elseif k == "party4target" then
                if g["WR_ColorFrame_Show"]("CSF8", n .. "P4T") then
                    return d
                end
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_BSDJ_FRZS5"] = function()
        if not g["IsPlayerSpell"](i("455993")) then
            return c
        end
        if g["WR_DeathKnightFrost_BSDJ"]("mouseover", "锋霜") then
            return d
        end
        if g["WR_DeathKnightFrost_BSDJ"]("focus", "锋霜") then
            return d
        end
        for o = i("1"), i("4") do
            if g["WR_DeathKnightFrost_BSDJ"]("party" .. o .. "targer", "锋霜") then
                return d
            end
        end
        if g["WR_DeathKnightFrost_BSDJ"]("target", "锋霜") then
            return d
        end
        return c
    end;
    g["WR_DeathKnightFrost_LHSG"] = function()
        if g["HUCountRange5"] <= i("1") and g["GCD"] <= g["ShiFaSuDu"] and g["TargetCloseRange"] and
            g["UnitHealth"]("target") / g["UnitHealthMax"]("target") <= i("0.35") and
            g["WR_SpellUsable"]("灵魂收割") and g["WR_GetUnitDeathTime"]("target") > i("7") and
            (g["BuffTime_BSZZ"] <= g["GCD"] or g["BuffTime_BSZZ"] > g["GCD"] and g["BuffTime_SLJQ"] <= g["GCD"] and
                g["Runes"] > i("2")) then
            if g["WR_ColorFrame_Show"]("SF4", "灵魂收割") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_HDHJ"] = function()
        if g["GCD"] > g["ShiFaSuDu"] then
            return c
        end
        if g["RunicPower"] < i("70") and g["WR_SpellUsable"]("寒冬号角") and
            (g["BuffTime_BSZZ"] > g["GCD"] and g["WR_GetUnitBuffTime"]("player", "冰龙吐息") == i("0") and
                g["Runes"] < i("3") or g["WR_GetUnitBuffTime"]("player", "冰龙吐息") > i("0") and g["Runes"] <
                i("2") and
                (g["WR_GetUnitBuffTime"]("player", "符文武器增效") == i("0") or g["RunicPower"] < i("17") * i("2")) or
                not g["IsPlayerSpell"](i("152279")) and g["Runes"] < i("3") and g["WR_GetGCD"]("寒冬号角") <
                g["WR_GetGCD"]("冰霜之柱") + i("15")) then
            if g["WR_ColorFrame_Show"]("CF12", "寒冬号角") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_SSYJ"] = function()
        if g["zhandoumoshi"] == i("1") and g["GCD"] <= g["ShiFaSuDu"] and g["IsPlayerSpell"](i("439843")) and
            g["WR_GetGCD"]("死神印记") <= g["GCD"] and g["WR_GetGCD"]("冰霜之柱") <= g["GCD"] and
            g["TargetCloseRange"] then
            if g["WRSet"]["BS_SP1"] == i("2") then
                if g["WR_ShiPin"](i("1"), g["WRSet"]["BS_SP1"]) then
                    return d
                end
            end
            if g["WRSet"]["BS_SP2"] == i("2") then
                if g["WR_ShiPin"](i("2"), g["WRSet"]["BS_SP2"]) then
                    return d
                end
            end
            if g["WR_ColorFrame_Show"]("SF6", "死神印记") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_BLTX"] = function()
        if g["WRSet"]["BS_BLTX"] and g["zhandoumoshi"] == i("1") and g["TargetCloseRange"] and
            g["WR_SpellUsable"]("冰龙吐息") and g["RunicPower"] > i("60") and g["BuffTime_BSZZ"] > g["GCD"] and
            g["WR_GetUnitBuffTime"]("player", "冰龙吐息") == i("0") then
            if g["WR_ColorFrame_Show"]("F8", "冰龙吐息") then
                return d
            end
        end
        return c
    end;
    g["WR_DeathKnightFrost_LastSpellTime"] = function()
        if g["DeathKnightFrostLastSpellIsOpen"] == d then
            return
        end
        local p = g["CreateFrame"]("Frame")
        p["RegisterEvent"](p, "COMBAT_LOG_EVENT_UNFILTERED")
        p["SetScript"](p, "OnEvent", function()
            if g["select"](i("4"), g["CombatLogGetCurrentEventInfo"]()) == g["UnitGUID"]("player") then
                if g["select"](i("2"), g["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
                    local q = g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]())
                    if q == "死神印记" then
                        g["SSYJ_CastTime"] = g["GetTime"]()
                    end
                end
            end
        end)
        g["DeathKnightFrostLastSpellIsOpen"] = d
    end
end)()
