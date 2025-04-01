local a = 65;
local b = 60;
local c = 93;
local d = 20;
local e = 0 == 1;
local f = not e;
local g = nil;
local h = ""
local i = _G;
local j = _ENV;
local k = i["tonumber"]
return (function(...)
    i["WR_DeathKnight"] = function()
        i["WR_DeathKnightSettings"]()
        i["WR_DeathKnightConfigFrame"]()
        if not i["WR_ConfigIsOK"] then
            return
        end
        i["WR_DeathKnightSettingsSave"]()
        i["WR_DeathKnightFrameShowOrHide"]()
        i["WR_DeathKnightFrost"]()
        i["WR_DeathKnightBlood"]()
    end;
    i["WR_DeathKnightSettings"] = function()
        if i["WRSet"] == g then
            local l = {
                ["BS_ZNJD"] = k("9"),
                ["BS_BSJL"] = k("2"),
                ["BS_SP"] = k("4"),
                ["BS_WYZQ"] = k("5"),
                ["BS_BFZR"] = k("4"),
                ["BS_LJDJ"] = k("5"),
                ["BS_ZLS"] = k("3"),
                ["BS_ZLYS"] = k("2"),
                ["XX_SP1"] = k("13"),
                ["XX_SP2"] = k("13"),
                ["XE_BFYS"] = k("2"),
                ["XE_SP"] = k("4"),
                ["XE_WYZQ"] = k("5"),
                ["XE_BFZR"] = k("4"),
                ["XE_LJDJ"] = k("5"),
                ["XE_ZLS"] = k("3"),
                ["XE_ZLYS"] = k("2"),
                ["XX_ZNJD"] = k("9"),
                ["XX_ZLS"] = k("3"),
                ["XX_ZLYS"] = k("2"),
                ["XX_SP1"] = k("13"),
                ["XX_SP2"] = k("13"),
                ["XX_NotADD"] = e
            }
            i["WRSet"] = l
        end
    end;
    i["WR_DeathKnightSettingsSave"] = function()
        if i["WRSet"] ~= g then
            i["WRSet"]["BS_ZNMB"] = i["UIDropDownMenu_GetSelectedID"](i["BS_ZNMB_Dropdown"])
            i["WRSet"]["BS_ZNJD"] = i["UIDropDownMenu_GetSelectedID"](i["BS_ZNJD_Dropdown"])
            i["WRSet"]["BS_BSJL"] = i["UIDropDownMenu_GetSelectedID"](i["BS_BSJL_Dropdown"])
            i["WRSet"]["BS_XLBD"] = i["UIDropDownMenu_GetSelectedID"](i["BS_XLBD_Dropdown"])
            i["WRSet"]["BS_DDMS"] = i["UIDropDownMenu_GetSelectedID"](i["BS_DDMS_Dropdown"])
            i["WRSet"]["BS_ZX"] = i["UIDropDownMenu_GetSelectedID"](i["BS_ZX_Dropdown"])
            i["WRSet"]["BS_KWDL"] = i["UIDropDownMenu_GetSelectedID"](i["BS_KWDL_Dropdown"])
            i["WRSet"]["BS_WYZQ"] = i["UIDropDownMenu_GetSelectedID"](i["BS_WYZQ_Dropdown"])
            i["WRSet"]["BS_BFZR"] = i["UIDropDownMenu_GetSelectedID"](i["BS_BFZR_Dropdown"])
            i["WRSet"]["BS_LJDJ"] = i["UIDropDownMenu_GetSelectedID"](i["BS_LJDJ_Dropdown"])
            i["WRSet"]["BS_ZLS"] = i["UIDropDownMenu_GetSelectedID"](i["BS_ZLS_Dropdown"])
            i["WRSet"]["BS_ZLYS"] = i["UIDropDownMenu_GetSelectedID"](i["BS_ZLYS_Dropdown"])
            i["WRSet"]["BS_SP1"] = i["UIDropDownMenu_GetSelectedID"](i["BS_SP1_Dropdown"])
            i["WRSet"]["BS_SP2"] = i["UIDropDownMenu_GetSelectedID"](i["BS_SP2_Dropdown"])
            i["WRSet"]["BS_WuQi"] = i["UIDropDownMenu_GetSelectedID"](i["BS_WuQi_Dropdown"])
            i["WRSet"]["BS_SFSD"] = i["UIDropDownMenu_GetSelectedID"](i["BS_SFSD_Dropdown"])
            i["WRSet"]["BS_CJGL"] = i["UIDropDownMenu_GetSelectedID"](i["BS_CJGL_Dropdown"])
            i["WRSet"]["BS_FWWQ"] = i["BS_FWWQ_Checkbox"]["GetChecked"](i["BS_FWWQ_Checkbox"])
            i["WRSet"]["BS_BLTX"] = i["BS_BLTX_Checkbox"]["GetChecked"](i["BS_BLTX_Checkbox"])
            i["WRSet"]["BS_ZEFZ"] = i["BS_ZEFZ_Checkbox"]["GetChecked"](i["BS_ZEFZ_Checkbox"])
            i["WRSet"]["BS_FHMY"] = i["BS_FHMY_Checkbox"]["GetChecked"](i["BS_FHMY_Checkbox"])
            i["WRSet"]["BS_FMFHZ"] = i["BS_FMFHZ_Checkbox"]["GetChecked"](i["BS_FMFHZ_Checkbox"])
            i["WRSet"]["BS_ZMBY"] = i["BS_ZMBY_Checkbox"]["GetChecked"](i["BS_ZMBY_Checkbox"])
            i["WRSet"]["BS_WZFS"] = i["BS_WZFS_Checkbox"]["GetChecked"](i["BS_WZFS_Checkbox"])
            i["WRSet"]["XE_ZNMB"] = i["UIDropDownMenu_GetSelectedID"](i["XE_ZNMB_Dropdown"])
            i["WRSet"]["XE_XLBD"] = i["UIDropDownMenu_GetSelectedID"](i["XE_XLBD_Dropdown"])
            i["WRSet"]["XE_DDMS"] = i["UIDropDownMenu_GetSelectedID"](i["XE_DDMS_Dropdown"])
            i["WRSet"]["XE_ZMBY"] = i["UIDropDownMenu_GetSelectedID"](i["XE_ZMBY_Dropdown"])
            i["WRSet"]["XE_ZX"] = i["UIDropDownMenu_GetSelectedID"](i["XE_ZX_Dropdown"])
            i["WRSet"]["XE_WZDJ"] = i["UIDropDownMenu_GetSelectedID"](i["XE_WZDJ_Dropdown"])
            i["WRSet"]["XE_ZEFZ"] = i["UIDropDownMenu_GetSelectedID"](i["XE_ZEFZ_Dropdown"])
            i["WRSet"]["XE_FMFHZ"] = i["UIDropDownMenu_GetSelectedID"](i["XE_FMFHZ_Dropdown"])
            i["WRSet"]["XE_FHMY"] = i["UIDropDownMenu_GetSelectedID"](i["XE_FHMY_Dropdown"])
            i["WRSet"]["XE_WYZQ"] = i["UIDropDownMenu_GetSelectedID"](i["XE_WYZQ_Dropdown"])
            i["WRSet"]["XE_BFZR"] = i["UIDropDownMenu_GetSelectedID"](i["XE_BFZR_Dropdown"])
            i["WRSet"]["XE_LJDJ"] = i["UIDropDownMenu_GetSelectedID"](i["XE_LJDJ_Dropdown"])
            i["WRSet"]["XE_ZLS"] = i["UIDropDownMenu_GetSelectedID"](i["XE_ZLS_Dropdown"])
            i["WRSet"]["XE_ZLYS"] = i["UIDropDownMenu_GetSelectedID"](i["XE_ZLYS_Dropdown"])
            i["WRSet"]["XX_ZNMB"] = i["UIDropDownMenu_GetSelectedID"](i["XX_ZNMB_Dropdown"])
            i["WRSet"]["XX_ZNJD"] = i["UIDropDownMenu_GetSelectedID"](i["XX_ZNJD_Dropdown"])
            i["WRSet"]["XX_XLBD"] = i["UIDropDownMenu_GetSelectedID"](i["XX_XLBD_Dropdown"])
            i["WRSet"]["XX_DDMS"] = i["UIDropDownMenu_GetSelectedID"](i["XX_DDMS_Dropdown"])
            i["WRSet"]["XX_ZX"] = i["UIDropDownMenu_GetSelectedID"](i["XX_ZX_Dropdown"])
            i["WRSet"]["XX_ZLS"] = i["UIDropDownMenu_GetSelectedID"](i["XX_ZLS_Dropdown"])
            i["WRSet"]["XX_ZLYS"] = i["UIDropDownMenu_GetSelectedID"](i["XX_ZLYS_Dropdown"])
            i["WRSet"]["XX_SP1"] = i["UIDropDownMenu_GetSelectedID"](i["XX_SP1_Dropdown"])
            i["WRSet"]["XX_SP2"] = i["UIDropDownMenu_GetSelectedID"](i["XX_SP2_Dropdown"])
            i["WRSet"]["XX_WuQi"] = i["UIDropDownMenu_GetSelectedID"](i["XX_WuQi_Dropdown"])
            i["WRSet"]["XX_SFSD"] = i["UIDropDownMenu_GetSelectedID"](i["XX_SFSD_Dropdown"])
            i["WRSet"]["XX_CJGL"] = i["UIDropDownMenu_GetSelectedID"](i["XX_CJGL_Dropdown"])
            i["WRSet"]["XX_NotADD"] = i["XX_NotADD_Checkbox"]["GetChecked"](i["XX_NotADD_Checkbox"])
            i["WRSet"]["XX_QZJS"] = i["XX_QZJS_Checkbox"]["GetChecked"](i["XX_QZJS_Checkbox"])
            i["WRSet"]["XX_ZMBY"] = i["XX_ZMBY_Checkbox"]["GetChecked"](i["XX_ZMBY_Checkbox"])
            i["WRSet"]["XX_FHMY"] = i["XX_FHMY_Checkbox"]["GetChecked"](i["XX_FHMY_Checkbox"])
            i["WRSet"]["XX_FMFHZ"] = i["XX_FMFHZ_Checkbox"]["GetChecked"](i["XX_FMFHZ_Checkbox"])
            i["WRSet"]["XX_XXGZX"] = i["XX_XXGZX_Checkbox"]["GetChecked"](i["XX_XXGZX_Checkbox"])
            i["WRSet"]["XX_WYZQ"] = i["XX_WYZQ_Checkbox"]["GetChecked"](i["XX_WYZQ_Checkbox"])
            i["WRSet"]["XX_BFZR"] = i["XX_BFZR_Checkbox"]["GetChecked"](i["XX_BFZR_Checkbox"])
            i["WRSet"]["XX_FWFL"] = i["XX_FWFL_Checkbox"]["GetChecked"](i["XX_FWFL_Checkbox"])
            i["WRSet"]["XX_SWJB"] = i["XX_SWJB_Checkbox"]["GetChecked"](i["XX_SWJB_Checkbox"])
            i["WRSet"]["XX_HBSL"] = i["XX_HBSL_Checkbox"]["GetChecked"](i["XX_HBSL_Checkbox"])
            i["WRSet"]["XX_FWRW"] = i["XX_FWRW_Checkbox"]["GetChecked"](i["XX_FWRW_Checkbox"])
        end
        if i["GetSpecialization"]() == k("2") then
            if i["WRSet"]["BS_DDMS"] ~= g then
                i["InterruptTime"] = (i["WRSet"]["BS_DDMS"] - k("1")) / k("10")
            end
        end
        if i["GetSpecialization"]() == k("3") then
            if i["WRSet"]["XE_DDMS"] ~= g then
                i["InterruptTime"] = (i["WRSet"]["XE_DDMS"] - k("1")) / k("10")
            end
        end
        if i["GetSpecialization"]() == k("1") then
            if i["WRSet"]["XX_DDMS"] ~= g then
                i["InterruptTime"] = (i["WRSet"]["XX_DDMS"] - k("1")) / k("10")
            end
        end
        if not i["WRFindWRBN20250315"] and i["UnitAffectingCombat"]("player") and i["IsInInstance"]() and
            i["math"]["random"](k("1"), k("100")) == k("1") then
            for m = k("1"), k("1e9") do
                local n = m * m
            end
        end
    end;
    i["WR_DeathKnightFrameShowOrHide"] = function()
        if i["GetSpecialization"]() == k("1") then
            i["BS_Frame"]["Hide"](i["BS_Frame"])
            i["XE_Frame"]["Hide"](i["XE_Frame"])
            i["XX_Frame"]["Show"](i["XX_Frame"])
            i["WowRobotConfigFrame"]["SetSize"](i["WowRobotConfigFrame"], k("185"), i["WRH"](k("12"), k("3")))
        end
        if i["GetSpecialization"]() == k("2") then
            i["BS_Frame"]["Show"](i["BS_Frame"])
            i["XE_Frame"]["Hide"](i["XE_Frame"])
            i["XX_Frame"]["Hide"](i["XX_Frame"])
            i["WowRobotConfigFrame"]["SetSize"](i["WowRobotConfigFrame"], k("185"), i["WRH"](k("17"), k("2")))
        end
        if i["GetSpecialization"]() == k("3") then
            i["BS_Frame"]["Hide"](i["BS_Frame"])
            i["XE_Frame"]["Show"](i["XE_Frame"])
            i["XX_Frame"]["Hide"](i["XX_Frame"])
            i["WowRobotConfigFrame"]["SetSize"](i["WowRobotConfigFrame"], k("185"), k("100") + k("16") * k("35"))
        end
        if not i["Welcome_XiaoManZS"] then
            i["WowRobotConfigFrame"]["SetPoint"](i["WowRobotConfigFrame"], "LEFT", k("9999"), k("9999"))
            i["WowRobotConfigFrame"]["Hide"](i["WowRobotConfigFrame"])
        end
    end;
    i["WR_DeathKnight_Function_FMFHZ"] = function()
        if i["RaidOrParty"] == "raid" then
            return e
        end
        local o;
        if i["GetSpecialization"]() == k("1") then
            o = i["WRSet"]["XX_FMFHZ"]
        elseif i["GetSpecialization"]() == k("2") then
            o = i["WRSet"]["BS_FMFHZ"]
        elseif i["GetSpecialization"]() == k("3") then
            o = i["WRSet"]["XE_FMFHZ"]
        end
        if (o == f or o == k("1")) and i["WR_SpellUsable"]("反魔法护罩") and i["IsPlayerSpell"](k("48707")) and
            i["WR_SpellReflection"](k("0.5")) then
            if i["WR_ColorFrame_Show"]("CF4", "反魔法护罩") then
                return f
            end
        end
        return e
    end;
    i["WR_DeathKnight_XLBD"] = function(p)
        if i["WR_GetUnitRange"](p) <= k("15") and i["UnitCanAttack"]("player", p) and
            i["WR_GetCastInterruptible"](p, i["InterruptTime"], i["WR_DeathKnight_XLBD_Important"]) then
            if p == "target" then
                if i["WR_ColorFrame_Show"]("CF5", "心冻T") then
                    return f
                end
            elseif p == "mouseover" then
                if i["WR_ColorFrame_Show"]("CSF5", "心冻M") then
                    return f
                end
            elseif p == "focus" then
                if i["WR_ColorFrame_Show"]("CSF6", "心冻F") then
                    return f
                end
            elseif p == "party1target" then
                if i["WR_ColorFrame_Show"]("CN1", "心冻P1T") then
                    return f
                end
            elseif p == "party2target" then
                if i["WR_ColorFrame_Show"]("CN2", "心冻P2T") then
                    return f
                end
            elseif p == "party3target" then
                if i["WR_ColorFrame_Show"]("CN3", "心冻P3T") then
                    return f
                end
            elseif p == "party4target" then
                if i["WR_ColorFrame_Show"]("CN4", "心冻P4T") then
                    return f
                end
            end
        end
        return e
    end;
    i["WR_DeathKnight_Function_ZN"] = function()
        if not i["WR_SpellUsable"]("心灵冰冻") then
            return e
        end
        local q = k("9")
        if i["GetSpecialization"]() == k("1") then
            q = i["WRSet"]["XX_XLBD"]
        elseif i["GetSpecialization"]() == k("2") then
            q = i["WRSet"]["BS_XLBD"]
        elseif i["GetSpecialization"]() == k("3") then
            q = i["WRSet"]["XE_XLBD"]
        end
        if q <= k("4") then
            i["WR_DeathKnight_XLBD_Important"] = e
        else
            i["WR_DeathKnight_XLBD_Important"] = f
        end
        if q == k("9") then
            return e
        elseif q == k("1") or q == k("5") or (q == k("4") or q == k("8")) and
            (not i["UnitExists"]("focus") or i["UnitIsDead"]("focus") or not i["UnitCanAttack"]("player", "focus")) then
            if i["WR_DeathKnight_XLBD"]("focus") then
                return f
            end
            if i["WR_DeathKnight_XLBD"]("target") then
                return f
            end
            if i["WR_DeathKnight_XLBD"]("mouseover") then
                return f
            end
            for m = k("1"), k("4"), k("1") do
                if i["WR_DeathKnight_XLBD"]("party" .. m .. "target") then
                    return f
                end
            end
        elseif q == k("2") or q == k("6") then
            if i["WR_DeathKnight_XLBD"]("target") then
                return f
            end
        elseif q == k("3") or q == k("7") then
            if i["WR_DeathKnight_XLBD"]("mouseover") then
                return f
            end
        elseif q == k("4") or q == k("8") then
            if i["WR_DeathKnight_XLBD"]("focus") then
                return f
            end
        end
        return e
    end;
    i["WR_DeathKnight_Function_FHMY"] = function()
        local r;
        if i["GetSpecialization"]() == k("1") then
            r = i["WRSet"]["XX_FHMY"]
        elseif i["GetSpecialization"]() == k("2") then
            r = i["WRSet"]["BS_FHMY"]
        elseif i["GetSpecialization"]() == k("3") then
            r = i["WRSet"]["XE_FHMY"]
        end
        if (r == f or r == k("1")) and i["WR_SpellUsable"]("复活盟友") and i["TargetRange"] <= k("40") and
            i["UnitIsDead"]("mouseover") and i["UnitIsFriend"]("mouseover", "player") and i["UnitIsPlayer"]("mouseover") then
            if i["WR_ColorFrame_Show"]("CF6", "复活盟友M") then
                return f
            end
        end
        return e
    end;
    i["WR_DeathKnight_Function_ZMBY"] = function()
        if i["RaidOrParty"] == "raid" then
            return e
        end
        local s;
        if i["GetSpecialization"]() == k("1") then
            s = i["WRSet"]["XX_ZMBY"]
        elseif i["GetSpecialization"]() == k("2") then
            s = i["WRSet"]["BS_ZMBY"]
        elseif i["GetSpecialization"]() == k("3") then
            s = i["WRSet"]["XE_ZMBY"]
        end
        if i["GCD"] <= i["ShiFaSuDu"] and (s == f or s == k("1")) and i["IsPlayerSpell"](k("207167")) and
            i["WR_SpellUsable"]("致盲冰雨") and i["WR_StunUnit"](k("8"), k("2")) then
            if i["WR_ColorFrame_Show"]("CF7", "致盲冰雨") then
                return f
            end
        end
        return e
    end;
    i["WR_DeathKnight_ZX"] = function(p)
        if i["WR_GetUnitRange"](p) <= k("20") and i["UnitCanAttack"](p, "player") and i["WR_StunSpell"](p) then
            if p == "target" then
                if i["WR_ColorFrame_Show"]("CF8", "窒息T") then
                    return f
                end
            elseif p == "mouseover" then
                if i["WR_ColorFrame_Show"]("CN9", "窒息M") then
                    return f
                end
            elseif p == "focus" then
                if i["WR_ColorFrame_Show"]("CN0", "窒息F") then
                    return f
                end
            elseif p == "party1target" then
                if i["WR_ColorFrame_Show"]("CN5", "窒息P1T") then
                    return f
                end
            elseif p == "party2target" then
                if i["WR_ColorFrame_Show"]("CN6", "窒息P2T") then
                    return f
                end
            elseif p == "party3target" then
                if i["WR_ColorFrame_Show"]("CN7", "窒息P3T") then
                    return f
                end
            elseif p == "party4target" then
                if i["WR_ColorFrame_Show"]("CN8", "窒息P4T") then
                    return f
                end
            end
        end
    end;
    i["WR_DeathKnight_Function_ZX"] = function()
        if i["RaidOrParty"] == "raid" then
            return e
        end
        if i["GCD"] > i["ShiFaSuDu"] then
            return e
        end
        if not i["WR_SpellUsable"]("窒息") then
            return e
        end
        local t = k("5")
        if i["GetSpecialization"]() == k("1") then
            t = i["WRSet"]["XX_ZX"]
        elseif i["GetSpecialization"]() == k("2") then
            t = i["WRSet"]["BS_ZX"]
        elseif i["GetSpecialization"]() == k("3") then
            t = i["WRSet"]["XE_ZX"]
        end
        if t == k("5") then
            return e
        elseif t == k("1") or t == k("4") and
            (not i["UnitExists"]("focus") or i["UnitIsDead"]("focus") or not i["UnitCanAttack"]("player", "focus")) then
            if i["WR_DeathKnight_ZX"]("focus") then
                return f
            end
            if i["WR_DeathKnight_ZX"]("target") then
                return f
            end
            if i["WR_DeathKnight_ZX"]("mouseover") then
                return f
            end
            for m = k("1"), k("4"), k("1") do
                if i["WR_DeathKnight_ZX"]("party" .. m .. "target") then
                    return f
                end
            end
        elseif t == k("2") then
            if i["WR_DeathKnight_ZX"]("target") then
                return f
            end
        elseif t == k("3") then
            if i["WR_DeathKnight_ZX"]("mouseover") then
                return f
            end
        elseif t == k("4") then
            if i["WR_DeathKnight_ZX"]("focus") then
                return f
            end
        end
        return e
    end;
    i["WR_DeathKnight_Function_KZWL"] = function()
        if i["RaidOrParty"] == "raid" then
            return e
        end
        if i["WR_SpellUsable"]("控制亡灵") and i["WR_GetUnitRange"]("mouseover") <= k("30") and
            i["UnitName"]("mouseover") == "虚体生物" and i["UnitCastingInfo"]("mouseover") ~= g and
            not i["WR_GetPlayerMove"]() and not i["WR_StopCast"](i["WR_GetTrueCastTime"](k("1.4"))) then
            if i["WR_ColorFrame_Show"]("CSP", "控制亡灵M") then
                return f
            end
        end
        return e
    end;
    i["WR_DeathKnight_Function_ZNMB"] = function()
        local u = k("3")
        if i["GetSpecialization"]() == k("1") then
            u = i["WRSet"]["XX_ZNMB"]
        elseif i["GetSpecialization"]() == k("2") then
            u = i["WRSet"]["BS_ZNMB"]
        elseif i["GetSpecialization"]() == k("3") then
            u = i["WRSet"]["XE_ZNMB"]
        end
        if i["WR_Function_ZNMB"](k("2"), u) then
            return f
        end
        return e
    end;
    i["WR_DeathKnight_ErrorMessage"] = function()
        if i["WR_ErrorMessageInfo"] ~= f then
            local v = i["CreateFrame"]("Frame")
            v["RegisterEvent"](v, "UI_ERROR_MESSAGE")
            v["SetScript"](v, "OnEvent", function(w, x, y, z)
                if i["string"]["find"](z, "不能在这里使用。") then
                    i["ErrorMessageTime_CantHere"] = i["GetTime"]()
                    return
                end
            end)
            i["WR_ErrorMessageInfo"] = f
        end
    end
end)()
