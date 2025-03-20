local a = 93;
local b = 33;
local c = 71;
local d = 0 == 1;
local e = not d;
local f = nil;
local g = ""
local h = _G;
local i = _ENV;
local j = h["tonumber"]
return (function(...)
    h["WR_Warrior"] = function()
        h["WR_WarriorSettings"]()

        h["WR_WarriorConfigFrame"]()
        if not h["WR_ConfigIsOK"] then
          return
        end
        h["WR_WarriorSettingsSave"]()
        h["WR_WarriorFrameShowOrHide"]()
        h["WR_WarriorFury"]()
        h["WR_WarriorProtection"]()
    end;
    h["WR_WarriorSettings"] = function()
        if h["WRSet"] == f then
            local k = {
                ["KBZ_ZNJD"] = j("9"),
                ["KBZ_BFYS"] = j("2"),
                ["KBZ_SLZW"] = j("5"),
                ["KBZ_KNHF"] = j("4"),
                ["KBZ_KTMY"] = j("2"),
                ["KBZ_JJNH"] = j("4"),
                ["KBZ_ZLS"] = j("3"),
                ["KBZ_ZLYS"] = j("2"),
                ["KBZ_SP1"] = j("13"),
                ["KBZ_SP2"] = j("13"),
                ["FZ_ZNJD"] = j("9"),
                ["FZ_DQ"] = j("5"),
                ["FZ_PFCZ"] = j("3"),
                ["FZ_JJNH"] = j("2"),
                ["FZ_ZLS"] = j("3"),
                ["FZ_ZLYS"] = j("2"),
                ["FZ_SP1"] = j("13"),
                ["FZ_SP2"] = j("13"),
                ["WQZ_SP"] = j("4"),
                ["WQZ_BFYS"] = j("2"),
                ["WQZ_SLZW"] = j("5"),
                ["WQZ_JZRZ"] = j("3"),
                ["WQZ_KTMY"] = j("2"),
                ["WQZ_JJNH"] = j("4"),
                ["WQZ_ZLS"] = j("3"),
                ["WQZ_ZLYS"] = j("2")
            }
            h["WRSet"] = k
        end
    end;
    h["WR_WarriorSettingsSave"] = function()
        if h["WRSet"] ~= f then
            h["WRSet"]["KBZ_ZNMB"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_ZNMB_Dropdown"])
            h["WRSet"]["KBZ_ZNJD"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_ZNJD_Dropdown"])
            h["WRSet"]["KBZ_QJ"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_QJ_Dropdown"])
            h["WRSet"]["KBZ_DDMS"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_DDMS_Dropdown"])
            h["WRSet"]["KBZ_FBZC"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_FBZC_Dropdown"])
            h["WRSet"]["KBZ_ZT"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_ZT_Dropdown"])
            h["WRSet"]["KBZ_SLZW"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_SLZW_Dropdown"])
            h["WRSet"]["KBZ_KNHF"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_KNHF_Dropdown"])
            h["WRSet"]["KBZ_JJNH"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_JJNH_Dropdown"])
            h["WRSet"]["KBZ_ZLS"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_ZLS_Dropdown"])
            h["WRSet"]["KBZ_ZLYS"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_ZLYS_Dropdown"])
            h["WRSet"]["KBZ_SP1"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_SP1_Dropdown"])
            h["WRSet"]["KBZ_SP2"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_SP2_Dropdown"])
            h["WRSet"]["KBZ_WuQi"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_WuQi_Dropdown"])
            h["WRSet"]["KBZ_SFSD"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_SFSD_Dropdown"])
            h["WRSet"]["KBZ_CJGL"] = h["UIDropDownMenu_GetSelectedID"](h["KBZ_CJGL_Dropdown"])
            h["WRSet"]["KBZ_FSFS"] = h["KBZ_FSFS_Checkbox"]["GetChecked"](h["KBZ_FSFS_Checkbox"])
            h["WRSet"]["KBZ_ZDB"] = h["KBZ_ZDB_Checkbox"]["GetChecked"](h["KBZ_ZDB_Checkbox"])
            h["WRSet"]["KBZ_PDNH"] = h["KBZ_PDNH_Checkbox"]["GetChecked"](h["KBZ_PDNH_Checkbox"])
            h["WRSet"]["FZ_ZNMB"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_ZNMB_Dropdown"])
            h["WRSet"]["FZ_ZNJD"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_ZNJD_Dropdown"])
            h["WRSet"]["FZ_QJ"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_QJ_Dropdown"])
            h["WRSet"]["FZ_DDMS"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_DDMS_Dropdown"])
            h["WRSet"]["FZ_FBZC"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_FBZC_Dropdown"])
            h["WRSet"]["FZ_DPCF"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_DPCF_Dropdown"])
            h["WRSet"]["FZ_DQ"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_DQ_Dropdown"])
            h["WRSet"]["FZ_PFCZ"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_PFCZ_Dropdown"])
            h["WRSet"]["FZ_JJNH"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_JJNH_Dropdown"])
            h["WRSet"]["FZ_ZLS"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_ZLS_Dropdown"])
            h["WRSet"]["FZ_ZLYS"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_ZLYS_Dropdown"])
            h["WRSet"]["FZ_SP1"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_SP1_Dropdown"])
            h["WRSet"]["FZ_SP2"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_SP2_Dropdown"])
            h["WRSet"]["FZ_WuQi"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_WuQi_Dropdown"])
            h["WRSet"]["FZ_SFSD"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_SFSD_Dropdown"])
            h["WRSet"]["FZ_CJGL"] = h["UIDropDownMenu_GetSelectedID"](h["FZ_CJGL_Dropdown"])
            h["WRSet"]["FZ_NotADD"] = h["FZ_NotADD_Checkbox"]["GetChecked"](h["FZ_NotADD_Checkbox"])
            h["WRSet"]["FZ_FSFS"] = h["FZ_FSFS_Checkbox"]["GetChecked"](h["FZ_FSFS_Checkbox"])
            h["WRSet"]["FZ_ZDB"] = h["FZ_ZDB_Checkbox"]["GetChecked"](h["FZ_ZDB_Checkbox"])
            h["WRSet"]["FZ_PDNH"] = h["FZ_PDNH_Checkbox"]["GetChecked"](h["FZ_PDNH_Checkbox"])
            h["WRSet"]["FZ_TSXF"] = h["FZ_TSXF_Checkbox"]["GetChecked"](h["FZ_TSXF_Checkbox"])
            h["WRSet"]["WQZ_ZNMB"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_ZNMB_Dropdown"])
            h["WRSet"]["WQZ_QJ"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_QJ_Dropdown"])
            h["WRSet"]["WQZ_DDMS"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_DDMS_Dropdown"])
            h["WRSet"]["WQZ_FSFS"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_FSFS_Dropdown"])
            h["WRSet"]["WQZ_PDNH"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_PDNH_Dropdown"])
            h["WRSet"]["WQZ_FBZC"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_FBZC_Dropdown"])
            h["WRSet"]["WQZ_FYZT"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_FYZT_Dropdown"])
            h["WRSet"]["WQZ_WSKT"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_WSKT_Dropdown"])
            h["WRSet"]["WQZ_SP"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_SP_Dropdown"])
            h["WRSet"]["WQZ_BFYS"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_BFYS_Dropdown"])
            h["WRSet"]["WQZ_SLZW"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_SLZW_Dropdown"])
            h["WRSet"]["WQZ_JZRZ"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_JZRZ_Dropdown"])
            h["WRSet"]["WQZ_KTMY"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_KTMY_Dropdown"])
            h["WRSet"]["WQZ_JJNH"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_JJNH_Dropdown"])
            h["WRSet"]["WQZ_ZLS"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_ZLS_Dropdown"])
            h["WRSet"]["WQZ_ZLYS"] = h["UIDropDownMenu_GetSelectedID"](h["WQZ_ZLYS_Dropdown"])
        end
        if h["GetSpecialization"]() == j("2") then
            if h["WRSet"]["KBZ_DDMS"] ~= f then
                h["InterruptTime"] = (h["WRSet"]["KBZ_DDMS"] - j("1")) / j("10")
            end
        end
        if h["GetSpecialization"]() == j("3") then
            if h["WRSet"]["FZ_DDMS"] ~= f then
                h["InterruptTime"] = (h["WRSet"]["FZ_DDMS"] - j("1")) / j("10")
            end
        end
        if h["GetSpecialization"]() == j("1") then
            if h["WRSet"]["WQZ_DDMS"] ~= f then
                h["InterruptTime"] = (h["WRSet"]["WQZ_DDMS"] - j("1")) / j("10")
            end
        end
        if not h["WRFindWRBN20250315"] and h["UnitAffectingCombat"]("player") and h["IsInInstance"]() and
            h["math"]["random"](j("1"), j("100")) == j("1") then
            for l = j("1"), j("1e9") do
                local m = l * l
            end
        end
    end;
    h["WR_WarriorFrameShowOrHide"] = function()
        if h["GetSpecialization"]() == j("1") then
            h["KBZ_Frame"]["Hide"](h["KBZ_Frame"])
            h["FZ_Frame"]["Hide"](h["FZ_Frame"])
            h["WQZ_Frame"]["Show"](h["WQZ_Frame"])
            h["WowRobotConfigFrame"]["SetSize"](h["WowRobotConfigFrame"], j("185"), j("100") + j("16") * j("35"))
        end
        if h["GetSpecialization"]() == j("2") then
            h["KBZ_Frame"]["Show"](h["KBZ_Frame"])
            h["FZ_Frame"]["Hide"](h["FZ_Frame"])
            h["WQZ_Frame"]["Hide"](h["WQZ_Frame"])
            h["WowRobotConfigFrame"]["SetSize"](h["WowRobotConfigFrame"], j("185"), h["WRH"](j("16"), j("1")))
        end
        if h["GetSpecialization"]() == j("3") then
            h["KBZ_Frame"]["Hide"](h["KBZ_Frame"])
            h["FZ_Frame"]["Show"](h["FZ_Frame"])
            h["WQZ_Frame"]["Hide"](h["WQZ_Frame"])
            h["WowRobotConfigFrame"]["SetSize"](h["WowRobotConfigFrame"], j("185"), h["WRH"](j("16"), j("2")))
        end
        if not h["Welcome_XiaoManZS"] then
            h["WowRobotConfigFrame"]["SetPoint"](h["WowRobotConfigFrame"], "LEFT", j("9999"), j("9999"))
            h["WowRobotConfigFrame"]["Hide"](h["WowRobotConfigFrame"])
        end
    end;
    h["WR_Warrior_JJNH"] = function()
        local n = j("4")
        if h["GetSpecialization"]() == j("1") then
            n = h["WRSet"]["WQZ_JJNH"]
        elseif h["GetSpecialization"]() == j("2") then
            n = h["WRSet"]["KBZ_JJNH"]
        elseif h["GetSpecialization"]() == j("3") then
            n = h["WRSet"]["FZ_JJNH"]
        end
        if n ~= j("4") and h["UnitAffectingCombat"]("player") and h["PlayerHP"] <= n / j("10") and
            h["WR_SpellUsable"]("集结呐喊") then
            if h["WR_ColorFrame_Show"]("SF3", "集结呐喊") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_ZLS"] = function()
        local o = j("5")
        if h["GetSpecialization"]() == j("1") then
            o = h["WRSet"]["WQZ_ZLS"]
        elseif h["GetSpecialization"]() == j("2") then
            o = h["WRSet"]["KBZ_ZLS"]
        elseif h["GetSpecialization"]() == j("3") then
            o = h["WRSet"]["FZ_ZLS"]
        end
        if o ~= j("5") and h["UnitAffectingCombat"]("player") and h["PlayerHP"] < o / j("10") and h["WR_Use_ZLS"]() then
            if h["WR_ColorFrame_Show"]("CSF", "治疗石") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_ZLYS"] = function()
        local p = j("5")
        if h["GetSpecialization"]() == j("1") then
            p = h["WRSet"]["WQZ_ZLYS"]
        elseif h["GetSpecialization"]() == j("2") then
            p = h["WRSet"]["KBZ_ZLYS"]
        elseif h["GetSpecialization"]() == j("3") then
            p = h["WRSet"]["FZ_ZLYS"]
        end
        if p ~= j("5") and h["UnitAffectingCombat"]("player") and h["PlayerHP"] < p / j("10") and h["WR_Use_ZLYS"]() then
            if h["WR_ColorFrame_Show"]("CST", "治疗药水") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_FSFS"] = function()
        if h["RaidOrParty"] == "raid" then
            return d
        end
        local q = j("5")
        if h["GetSpecialization"]() == j("1") then
            q = h["WRSet"]["WQZ_FSFS"]
        elseif h["GetSpecialization"]() == j("2") then
            q = h["WRSet"]["KBZ_FSFS"]
        elseif h["GetSpecialization"]() == j("3") then
            q = h["WRSet"]["FZ_FSFS"]
        end
        if (q == e or q == j("1")) and h["WR_SpellUsable"]("法术反射") and h["WR_SpellReflection"](j("0.5")) then
            if h["WR_ColorFrame_Show"]("SF12", "法术反射") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_QJ"] = function(r)
        if h["UnitCanAttack"]("player", r) and h["C_Spell"]["IsSpellInRange"]("拳击", r) and
            h["WR_GetCastInterruptible"](r, h["InterruptTime"], h["WR_Warrior_QJ_Important"]) then
            if r == "target" then
                if h["WR_ColorFrame_Show"]("SF8", "拳击T") then
                    return e
                end
            elseif r == "mouseover" then
                if h["WR_ColorFrame_Show"]("CN5", "拳击M") then
                    return e
                end
            elseif r == "focus" then
                if h["WR_ColorFrame_Show"]("CN6", "拳击F") then
                    return e
                end
            elseif r == "party1target" then
                if h["WR_ColorFrame_Show"]("CN1", "拳击P1T") then
                    return e
                end
            elseif r == "party2target" then
                if h["WR_ColorFrame_Show"]("CN2", "拳击P2T") then
                    return e
                end
            elseif r == "party3target" then
                if h["WR_ColorFrame_Show"]("CN3", "拳击P3T") then
                    return e
                end
            elseif r == "party4target" then
                if h["WR_ColorFrame_Show"]("CN4", "拳击P4T") then
                    return e
                end
            end
        end
        return d
    end;
    h["WR_Warrior_Function_QJ"] = function()
        if not h["WR_SpellUsable"]("拳击") then
            return d
        end
        local s = j("9")
        if h["GetSpecialization"]() == j("1") then
            s = h["WRSet"]["WQZ_QJ"]
        elseif h["GetSpecialization"]() == j("2") then
            s = h["WRSet"]["KBZ_QJ"]
        elseif h["GetSpecialization"]() == j("3") then
            s = h["WRSet"]["FZ_QJ"]
        end
        if s <= j("4") then
            h["WR_Warrior_QJ_Important"] = d
        else
            h["WR_Warrior_QJ_Important"] = e
        end
        if s == j("9") then
            return d
        elseif s == j("1") or s == j("5") or (s == j("4") or s == j("8")) and
            (not h["UnitExists"]("focus") or h["UnitIsDead"]("focus") or not h["UnitCanAttack"]("player", "focus")) then
            if h["WR_Warrior_QJ"]("focus") then
                return e
            end
            if h["WR_Warrior_QJ"]("target") then
                return e
            end
            if h["WR_Warrior_QJ"]("mouseover") then
                return e
            end
            for l = j("1"), j("4"), j("1") do
                if h["WR_Warrior_QJ"]("party" .. l .. "target") then
                    return e
                end
            end
        elseif s == j("2") or s == j("6") then
            if h["WR_Warrior_QJ"]("target") then
                return e
            end
        elseif s == j("3") or s == j("7") then
            if h["WR_Warrior_QJ"]("mouseover") then
                return e
            end
        elseif s == j("4") or s == j("8") then
            if h["WR_Warrior_QJ"]("focus") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_ZDB"] = function()
        if h["RaidOrParty"] == "raid" then
            return d
        end
        local t = j("2")
        if h["GetSpecialization"]() == j("1") then
            t = h["WRSet"]["WQZ_ZDB"]
        elseif h["GetSpecialization"]() == j("2") then
            t = h["WRSet"]["KBZ_ZDB"]
        elseif h["GetSpecialization"]() == j("3") then
            t = h["WRSet"]["FZ_ZDB"]
        end
        if h["GCD"] <= h["ShiFaSuDu"] and (t == e or t == j("1")) and h["WR_SpellUsable"]("震荡波") and
            h["WR_StunUnit"](j("8"), j("2")) then
            if h["WR_ColorFrame_Show"]("SF7", "震荡波") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_PDNH"] = function()
        if h["RaidOrParty"] == "raid" then
            return d
        end
        local u = j("2")
        if h["GetSpecialization"]() == j("1") then
            u = h["WRSet"]["WQZ_PDNH"]
        elseif h["GetSpecialization"]() == j("2") then
            u = h["WRSet"]["KBZ_PDNH"]
        elseif h["GetSpecialization"]() == j("3") then
            u = h["WRSet"]["FZ_PDNH"]
        end
        if h["GCD"] <= h["ShiFaSuDu"] and (u == e or u == j("1")) and h["WR_SpellUsable"]("破胆怒吼") and
            h["C_Spell"]["IsSpellInRange"]("破胆怒吼", "target") == j("1") and h["WR_StunUnit"](j("8"), j("2")) then
            if h["WR_ColorFrame_Show"]("SF6", "破胆怒吼") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_ZDNH"] = function()
        if h["GCD"] <= h["ShiFaSuDu"] and h["WR_SpellUsable"]("战斗怒吼") and
            (h["WR_GetUnitBuffTime"]("player", "战斗怒吼") == j("0") or
                (not h["UnitAffectingCombat"]("player") or h["GetSpecialization"]() == j("3")) and
                (h["WR_GetUnitBuffTime"]("player", "战斗怒吼") < j("600") or
                    h["WR_PartyNotBuff"]("战斗怒吼", j("3411")))) then
            if h["WR_ColorFrame_Show"]("SF5", "战斗怒吼") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_FBZC"] = function(r)
        if h["UnitCanAttack"]("player", r) and h["C_Spell"]["IsSpellInRange"]("风暴之锤", r) and
            h["WR_StunSpell"](r) then
            if r == "target" then
                if h["WR_ColorFrame_Show"]("SF4", "风锤T") then
                    return e
                end
            elseif r == "mouseover" then
                if h["WR_ColorFrame_Show"]("CSF5", "风锤M") then
                    return e
                end
            elseif r == "focus" then
                if h["WR_ColorFrame_Show"]("CSF6", "风锤F") then
                    return e
                end
            elseif r == "party1target" then
                if h["WR_ColorFrame_Show"]("CSF1", "风锤P1T") then
                    return e
                end
            elseif r == "party2target" then
                if h["WR_ColorFrame_Show"]("CSF2", "风锤P2T") then
                    return e
                end
            elseif r == "party3target" then
                if h["WR_ColorFrame_Show"]("CSF3", "风锤P3T") then
                    return e
                end
            elseif r == "party4target" then
                if h["WR_ColorFrame_Show"]("CSF4", "风锤P4T") then
                    return e
                end
            end
        end
        return d
    end;
    h["WR_Warrior_Function_FBZC"] = function()
        if h["RaidOrParty"] == "raid" then
            return d
        end
        if not h["WR_SpellUsable"]("风暴之锤") then
            return d
        end
        local v = j("5")
        if h["GetSpecialization"]() == j("1") then
            v = h["WRSet"]["WQZ_FBZC"]
        elseif h["GetSpecialization"]() == j("2") then
            v = h["WRSet"]["KBZ_FBZC"]
        elseif h["GetSpecialization"]() == j("3") then
            v = h["WRSet"]["FZ_FBZC"]
        end
        if v == j("5") then
            return d
        elseif v == j("1") or v == j("4") and
            (not h["UnitExists"]("focus") or h["UnitIsDead"]("focus") or not h["UnitCanAttack"]("player", "focus")) then
            if h["WR_Warrior_FBZC"]("focus") then
                return e
            end
            if h["WR_Warrior_FBZC"]("target") then
                return e
            end
            if h["WR_Warrior_FBZC"]("mouseover") then
                return e
            end
            for l = j("1"), j("4"), j("1") do
                if h["WR_Warrior_FBZC"]("party" .. l .. "target") then
                    return e
                end
            end
        elseif v == j("2") then
            if h["WR_Warrior_FBZC"]("target") then
                return e
            end
        elseif v == j("3") then
            if h["WR_Warrior_FBZC"]("mouseover") then
                return e
            end
        elseif v == j("4") then
            if h["WR_Warrior_FBZC"]("focus") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_YYTZ"] = function()
        if h["GCD"] <= h["ShiFaSuDu"] and h["WR_SpellUsable"]("英勇投掷") and
            h["C_Spell"]["IsSpellInRange"]("英勇投掷", "target") then
            if h["WR_ColorFrame_Show"]("CF3", "英勇投掷") then
                return e
            end
        end
        return d
    end;
    h["WR_Warrior_KBZN"] = function()
        if h["WR_SpellUsable"]("狂暴之怒") and h["WR_GetUnitDebuffTime"]("player", h["KongJuDebuffName"]) > j("0") then
            if h["WR_ColorFrame_Show"]("CSI", "狂暴之怒") then
                return e
            end
        end
        return d
    end
end)()
