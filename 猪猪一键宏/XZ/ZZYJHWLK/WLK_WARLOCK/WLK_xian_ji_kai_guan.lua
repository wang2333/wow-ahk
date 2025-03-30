if UnitClassBase("player")~="WARLOCK" then
    
    return
end
-- 初始化一个全局标志变量
xjkaiguan = true


-- 重置 petkaiguan 变量
local function resetFocusSwitch()
    xjkaiguan = true
end

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, destRaidFlags, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    
    -- 检查事件是否是开始施放暗影箭
    if subEvent == "SPELL_CAST_START" and spellName == "献祭" and sourceName == UnitName("player") then
        
        xjkaiguan = false
        -- 5秒后重置 petkaiguan
        C_Timer.After(1.5, resetFocusSwitch)
    end
end


-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", OnCombatEvent)

