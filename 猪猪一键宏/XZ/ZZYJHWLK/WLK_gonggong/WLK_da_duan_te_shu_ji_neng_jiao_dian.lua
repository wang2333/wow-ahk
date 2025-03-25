-- 初始化变量和技能列表
jiaoduankaiguan = true
local jiaoduanliebiao = {
    ["治疗波"] = true,   
    ["强效治疗术"] = true,
    ["奥术风暴"] = true,
    -- 在此添加更多技能
}

-- 特定怪物名称列表，针对焦点
local focusNames = {
    ["纳兹夏尔愈灵者"] = true,
    ["神殿助祭"] = true,
    ["马洛拉克"] = true,
    -- 在此添加更多焦点目标
}

-- 创建框架用于注册和处理事件
local focusFrame = CreateFrame("Frame")

-- 事件处理函数
local function OnEvent(self, event, ...)
    if event == "PLAYER_FOCUS_CHANGED" then
        -- 当玩家改变焦点时，立即更新状态
        local name = UnitName("focus")
        if focusNames[name] then
            jiaoduankaiguan = false  -- 如果焦点是特定怪物，设置为false
        else
            jiaoduankaiguan = true   -- 如果焦点不是特定怪物，设置为true
        end
    elseif event == "UNIT_SPELLCAST_START" then
        -- 施法开始事件
        local unit, spellName = ..., UnitCastingInfo("focus")
        if unit == "focus" and focusNames[UnitName("focus")] and jiaoduanliebiao[spellName] then
            jiaoduankaiguan = true  -- 如果是特定怪物且施放列表中的技能，则设置为true
        end
    elseif event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" then
        -- 施法结束、失败或中断事件
        local unit = ...
        if unit == "focus" and focusNames[UnitName("focus")] then
            jiaoduankaiguan = false  -- 如果焦点是特定怪物，重置为false
        end
    end
end

-- 注册事件
focusFrame:RegisterEvent("UNIT_SPELLCAST_START")
focusFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
focusFrame:RegisterEvent("UNIT_SPELLCAST_FAILED")
focusFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
focusFrame:RegisterEvent("PLAYER_FOCUS_CHANGED")
focusFrame:SetScript("OnEvent", OnEvent)
