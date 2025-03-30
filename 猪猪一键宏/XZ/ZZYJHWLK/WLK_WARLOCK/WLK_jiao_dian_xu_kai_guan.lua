if UnitClassBase("player") ~= "WARLOCK" then
    return
end

-- 初始化一个全局标志变量
focuskaiguan = true

-- 检查暗影箭施放条件
local function checkShadowBoltConditions()
    -- 直接访问全局变量
    if ffss ~= nil and ayjcast ~= nil and fgycsfly ~= nil then
        if (fayzy ~= nil and ffss < ayjcast * 2 + fgycsfly + 1 ) or
           (fayzy ~= nil and fayzy < ayjcast * 2 + fgycsfly + 1 ) or
           (fayzy == nil and ffss < ayjcast * 2 + fgycsfly + 1 ) then
            return true
        end
    end
    return false
end

-- 重置 focus 变量
local function resetFocusSwitch2()
    focuskaiguan = true
end

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, destRaidFlags, spellId, spellName = CombatLogGetCurrentEventInfo()
    
    -- 检查事件是否是开始施放暗影箭
    if subEvent == "SPELL_CAST_START" and spellName == "暗影箭" and sourceName == UnitName("player") then
        if checkShadowBoltConditions() then
            focuskaiguan = false
            -- 2.5秒后重置 focus
            C_Timer.After(2.5, resetFocusSwitch2)
        end
    end
end

-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", OnCombatEvent)
