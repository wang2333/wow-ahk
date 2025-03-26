-- 初始化变量和技能列表
daduankaiguan = true
local daduanliebiao = {
    ["治疗波"] = true,   
    ["强效治疗术"] = true,
    ["奥术风暴"] = true,
}

-- 特定怪物名称列表
local targetNames = {
    ["纳兹夏尔愈灵者"] = true,
    ["神殿助祭"] = true,
    ["马洛拉克"] = true,
    ["维扎克斯将军"] = true,
    
    -- 在此添加更多目标
}

-- 创建框架用于注册和处理事件
local frame = CreateFrame("Frame")

-- 事件处理函数
local function OnEvent(self, event, ...)
    if event == "PLAYER_TARGET_CHANGED" then
        -- 当玩家改变目标时，立即更新状态
        local name = UnitName("target")
        if targetNames[name] then
            daduankaiguan = false  -- 如果目标是特定怪物，设置为false
        else
            daduankaiguan = true   -- 如果目标不是特定怪物，设置为true
        end
    elseif event == "UNIT_SPELLCAST_START" then
        -- 施法开始事件
        local unit, spellName = ..., UnitCastingInfo("target")
        if unit == "target" and targetNames[UnitName("target")] and daduanliebiao[spellName] then
            daduankaiguan = true  -- 如果是特定怪物且施放列表中的技能，则设置为true
        end
    elseif event == "UNIT_CAST_SUCCESS" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" then
        -- 施法结束、失败或中断事件
        local unit = ...
        if unit == "target" and targetNames[UnitName("target")] then
            daduankaiguan = false  -- 如果目标是特定怪物，重置为false
        end
    end
end

-- 注册事件
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:RegisterEvent("UNIT_SPELLCAST_STOP")
frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", OnEvent)

