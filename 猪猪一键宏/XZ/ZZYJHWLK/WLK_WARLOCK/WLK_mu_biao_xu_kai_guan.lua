if UnitClassBase("player")~="WARLOCK" then
    
    return
end

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName = CombatLogGetCurrentEventInfo()
    
    -- 检查事件是否是暗影箭施法成功
    if subEvent == "SPELL_CAST_SUCCESS" and spellId == 47809 and sourceName == UnitName("player") then
        -- 检查目标是否是宠物的目标
        if destGUID == UnitGUID("pettarget") then
            petkaiguan = true
        end
        -- 检查目标是否是焦点目标
        if destGUID == UnitGUID("focus") then
            focuskaiguan = true
        end
        -- 检查目标是否是当前目标
        if destGUID == UnitGUID("target") then
            -- 设置 petkaiguan 和 focuskaiguan 为 true
            petkaiguan = true
            focuskaiguan = true
            lianfakaiguan=false
        end
    end
end

-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", OnCombatEvent)



