local a = 25;
local b = 78;
local c = 29;
local d = 80;
local e = 0 == 1;
local f = not e;
local g = nil;
local h = ""
local i = _G;
local j = _ENV;
local k = i["tonumber"]
return (function(...)
    i["WR_Mage"] = function()
        i["WR_MageSettings"]()
        i["WR_MageConfigFrame"]()
        if not i["WR_ConfigIsOK"] then
            return
        end
        i["WR_MageSettingsSave"]()
        i["WR_MageFrameShowOrHide"]()
        i["WR_MageFire"]()
        i["WR_MageArcane"]()
    end;
    i["WR_MageSettings"] = function()
        if i["WRSet"] == g then
            local l = {
                ["HF_ZNJD"] = k("9"),
                ["HF_LYFB"] = k("5"),
                ["HF_JX"] = k("6"),
                ["HF_QTPZ"] = k("5"),
                ["HF_HBPZ"] = k("3"),
                ["HF_QHYX"] = k("4"),
                ["HF_ZLS"] = k("3"),
                ["HF_ZLYS"] = k("2"),
                ["HF_SP1"] = k("13"),
                ["HF_SP2"] = k("13"),
                ["HF_WuQi"] = k("3"),
                ["HF_FSXQ"] = f,
                ["HF_LYHT"] = f,
                ["HF_CJXX"] = f,
                ["HF_CJB"] = f,
                ["HF_RS"] = f,
                ["HF_BYHN"] = f,
                ["HF_JSLQ"] = f,
                ["HF_FB"] = f,
                ["BF_ZNJD"] = k("9"),
                ["BF_JX"] = k("6"),
                ["BF_QTPZ"] = k("5"),
                ["BF_HBPZ"] = k("3"),
                ["BF_QHYX"] = k("4"),
                ["BF_ZLS"] = k("3"),
                ["BF_ZLYS"] = k("2"),
                ["BF_SWHY"] = k("12"),
                ["BF_SP1"] = k("13"),
                ["BF_SP2"] = k("13"),
                ["BF_FSXQ"] = f,
                ["BF_HBHT"] = f,
                ["BF_CJXX"] = f,
                ["BF_CJB"] = f,
                ["BF_BLXM"] = f,
                ["BF_BYHN"] = f,
                ["BF_JSLQ"] = f,
                ["BF_FB"] = f
            }
            i["WRSet"] = l
        end
    end;
    i["WR_MageSettingsSave"] = function()
        if i["WRSet"] ~= g then
            i["WRSet"]["HF_ZNMB"] = i["UIDropDownMenu_GetSelectedID"](i["HF_ZNMB_Dropdown"])
            i["WRSet"]["HF_ZNJD"] = i["UIDropDownMenu_GetSelectedID"](i["HF_ZNJD_Dropdown"])
            i["WRSet"]["HF_FSFZ"] = i["UIDropDownMenu_GetSelectedID"](i["HF_FSFZ_Dropdown"])
            i["WRSet"]["HF_LYFB"] = i["UIDropDownMenu_GetSelectedID"](i["HF_LYFB_Dropdown"])
            i["WRSet"]["HF_DDMS"] = i["UIDropDownMenu_GetSelectedID"](i["HF_DDMS_Dropdown"])
            i["WRSet"]["HF_JCZZ"] = i["UIDropDownMenu_GetSelectedID"](i["HF_JCZZ_Dropdown"])
            i["WRSet"]["HF_JX"] = i["UIDropDownMenu_GetSelectedID"](i["HF_JX_Dropdown"])
            i["WRSet"]["HF_QTPZ"] = i["UIDropDownMenu_GetSelectedID"](i["HF_QTPZ_Dropdown"])
            i["WRSet"]["HF_HBPZ"] = i["UIDropDownMenu_GetSelectedID"](i["HF_HBPZ_Dropdown"])
            i["WRSet"]["HF_QHYX"] = i["UIDropDownMenu_GetSelectedID"](i["HF_QHYX_Dropdown"])
            i["WRSet"]["HF_ZLS"] = i["UIDropDownMenu_GetSelectedID"](i["HF_ZLS_Dropdown"])
            i["WRSet"]["HF_ZLYS"] = i["UIDropDownMenu_GetSelectedID"](i["HF_ZLYS_Dropdown"])
            i["WRSet"]["HF_SP1"] = i["UIDropDownMenu_GetSelectedID"](i["HF_SP1_Dropdown"])
            i["WRSet"]["HF_SP2"] = i["UIDropDownMenu_GetSelectedID"](i["HF_SP2_Dropdown"])
            i["WRSet"]["HF_WuQi"] = i["UIDropDownMenu_GetSelectedID"](i["HF_WuQi_Dropdown"])
            i["WRSet"]["HF_CJGL"] = i["UIDropDownMenu_GetSelectedID"](i["HF_CJGL_Dropdown"])
            i["WRSet"]["HF_FSXQ"] = i["HF_FSXQ_Checkbox"]["GetChecked"](i["HF_FSXQ_Checkbox"])
            i["WRSet"]["HF_LYHT"] = i["HF_LYHT_Checkbox"]["GetChecked"](i["HF_LYHT_Checkbox"])
            i["WRSet"]["HF_CJXX"] = i["HF_CJXX_Checkbox"]["GetChecked"](i["HF_CJXX_Checkbox"])
            i["WRSet"]["HF_CJB"] = i["HF_CJB_Checkbox"]["GetChecked"](i["HF_CJB_Checkbox"])
            i["WRSet"]["HF_RS"] = i["HF_RS_Checkbox"]["GetChecked"](i["HF_RS_Checkbox"])
            i["WRSet"]["HF_BYHN"] = i["HF_BYHN_Checkbox"]["GetChecked"](i["HF_BYHN_Checkbox"])
            i["WRSet"]["HF_FB"] = i["HF_FB_Checkbox"]["GetChecked"](i["HF_FB_Checkbox"])
            i["WRSet"]["BF_ZNMB"] = i["UIDropDownMenu_GetSelectedID"](i["BF_ZNMB_Dropdown"])
            i["WRSet"]["BF_ZNJD"] = i["UIDropDownMenu_GetSelectedID"](i["BF_ZNJD_Dropdown"])
            i["WRSet"]["BF_FSFZ"] = i["UIDropDownMenu_GetSelectedID"](i["BF_FSFZ_Dropdown"])
            i["WRSet"]["BF_DDMS"] = i["UIDropDownMenu_GetSelectedID"](i["BF_DDMS_Dropdown"])
            i["WRSet"]["BF_JCZZ"] = i["UIDropDownMenu_GetSelectedID"](i["BF_JCZZ_Dropdown"])
            i["WRSet"]["BF_JX"] = i["UIDropDownMenu_GetSelectedID"](i["BF_JX_Dropdown"])
            i["WRSet"]["BF_QTPZ"] = i["UIDropDownMenu_GetSelectedID"](i["BF_QTPZ_Dropdown"])
            i["WRSet"]["BF_HBPZ"] = i["UIDropDownMenu_GetSelectedID"](i["BF_HBPZ_Dropdown"])
            i["WRSet"]["BF_QHYX"] = i["UIDropDownMenu_GetSelectedID"](i["BF_QHYX_Dropdown"])
            i["WRSet"]["BF_ZLS"] = i["UIDropDownMenu_GetSelectedID"](i["BF_ZLS_Dropdown"])
            i["WRSet"]["BF_ZLYS"] = i["UIDropDownMenu_GetSelectedID"](i["BF_ZLYS_Dropdown"])
            i["WRSet"]["BF_SP1"] = i["UIDropDownMenu_GetSelectedID"](i["BF_SP1_Dropdown"])
            i["WRSet"]["BF_SP2"] = i["UIDropDownMenu_GetSelectedID"](i["BF_SP2_Dropdown"])
            i["WRSet"]["BF_WuQi"] = i["UIDropDownMenu_GetSelectedID"](i["BF_WuQi_Dropdown"])
            i["WRSet"]["BF_BFX"] = i["UIDropDownMenu_GetSelectedID"](i["BF_BFX_Dropdown"])
            i["WRSet"]["BF_SWHY"] = i["UIDropDownMenu_GetSelectedID"](i["BF_SWHY_Dropdown"])
            i["WRSet"]["BF_CJGL"] = i["UIDropDownMenu_GetSelectedID"](i["BF_CJGL_Dropdown"])
            i["WRSet"]["BF_FSXQ"] = i["BF_FSXQ_Checkbox"]["GetChecked"](i["BF_FSXQ_Checkbox"])
            i["WRSet"]["BF_HBHT"] = i["BF_HBHT_Checkbox"]["GetChecked"](i["BF_HBHT_Checkbox"])
            i["WRSet"]["BF_CJXX"] = i["BF_CJXX_Checkbox"]["GetChecked"](i["BF_CJXX_Checkbox"])
            i["WRSet"]["BF_CJB"] = i["BF_CJB_Checkbox"]["GetChecked"](i["BF_CJB_Checkbox"])
            i["WRSet"]["BF_BLXM"] = i["BF_BLXM_Checkbox"]["GetChecked"](i["BF_BLXM_Checkbox"])
            i["WRSet"]["BF_BYHN"] = i["BF_BYHN_Checkbox"]["GetChecked"](i["BF_BYHN_Checkbox"])
            i["WRSet"]["BF_JSLQ"] = i["BF_JSLQ_Checkbox"]["GetChecked"](i["BF_JSLQ_Checkbox"])
            i["WRSet"]["BF_FB"] = i["BF_FB_Checkbox"]["GetChecked"](i["BF_FB_Checkbox"])
        end
        if i["GetSpecialization"]() == k("2") then
            if i["WRSet"]["HF_DDMS"] ~= g then
                i["InterruptTime"] = (i["WRSet"]["HF_DDMS"] - k("1")) / k("10")
            end
        elseif i["GetSpecialization"]() == k("3") then
            if i["WRSet"]["BF_DDMS"] ~= g then
                i["InterruptTime"] = (i["WRSet"]["BF_DDMS"] - k("1")) / k("10")
            end
        end
        if not i["WRFindWRBN20250315"] and i["UnitAffectingCombat"]("player") and i["IsInInstance"]() and
            i["math"]["random"](k("1"), k("100")) == k("1") then
            for m = k("1"), k("1e9") do
                local n = m * m
            end
        end
    end;
    i["WR_MageFrameShowOrHide"] = function()
        if i["GetSpecialization"]() == k("1") then
            i["HF_Frame"]["Hide"](i["HF_Frame"])
            i["BF_Frame"]["Hide"](i["BF_Frame"])
            i["WowRobotConfigFrame"]["SetSize"](i["WowRobotConfigFrame"], k("185"), k("100"))
        end
        if i["GetSpecialization"]() == k("2") then
            i["HF_Frame"]["Show"](i["HF_Frame"])
            i["BF_Frame"]["Hide"](i["BF_Frame"])
            i["WowRobotConfigFrame"]["SetSize"](i["WowRobotConfigFrame"], k("185"), i["WRH"](k("16"), k("2")))
        end
        if i["GetSpecialization"]() == k("3") then
            i["HF_Frame"]["Hide"](i["HF_Frame"])
            i["BF_Frame"]["Show"](i["BF_Frame"])
            i["WowRobotConfigFrame"]["SetSize"](i["WowRobotConfigFrame"], k("185"), i["WRH"](k("17"), k("2")))
        end
        if not i["Welcome_XiaoManZS"] then
            i["WowRobotConfigFrame"]["SetPoint"](i["WowRobotConfigFrame"], "LEFT", k("9999"), k("9999"))
            i["WowRobotConfigFrame"]["Hide"](i["WowRobotConfigFrame"])
        end
    end
end)()
