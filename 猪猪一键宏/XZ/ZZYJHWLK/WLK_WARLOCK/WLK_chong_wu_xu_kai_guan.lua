if UnitClassBase("player") ~= "WARLOCK" then

    return
end

-- 初始化全局标志变量
petkaiguan = true
lianfakaiguan = false

-- 检查暗影箭施放条件
local function checkShadowBoltConditionspet()
    -- 直接访问全局变量
    if pfss ~= nil and ayjcast ~= nil and pgycsfly ~= nil then


        if (payzy ~= nil and pfss < ayjcast * 2 + pgycsfly + 1.5) or
           (payzy ~= nil and payzy < ayjcast * 2 + pgycsfly + 1.5) or
           (payzy == nil and pfss < ayjcast * 2 + pgycsfly + 1.5) then
           
            return true
        end
    end
  
    return false
end

-- 重置 petkaiguan 变量
local function resetFocusSwitchpet()
    petkaiguan = true

end

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, destRaidFlags, spellId, spellName = CombatLogGetCurrentEventInfo()
    
    -- 检查事件是否是开始施放暗影箭
    if subEvent == "SPELL_CAST_START" and spellName == "暗影箭" and sourceName == UnitName("player") then
       
        if lianfakaiguan then
            -- 如果连发开关已开启，立刻关闭它
            lianfakaiguan = false

        elseif checkShadowBoltConditionspet() then
            petkaiguan = false
            lianfakaiguan = true

            -- 2.5秒后重置 petkaiguan
            C_Timer.After(5, resetFocusSwitchpet)
        end
    end
end

-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", OnCombatEvent)


