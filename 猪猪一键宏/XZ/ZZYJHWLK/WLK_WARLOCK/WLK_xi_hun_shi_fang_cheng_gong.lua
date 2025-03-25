if UnitClassBase("player")~="WARLOCK" then
    
    return
end
local spellID_DrainSoul = "吸取灵魂"  -- 吸取灵魂的法术ID

-- 创建一个帧来监听事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- 事件处理函数
frame:SetScript("OnEvent", function(self, event)
        -- 从战斗日志获取事件信息
        local timestamp, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId,spellname = CombatLogGetCurrentEventInfo()
        
        
        
        -- 检查事件是否是“SPELL_CAST_SUCCESS”，法术ID是否匹配“吸取灵魂”，并且是玩家释放的
        if subEvent == "SPELL_CAST_SUCCESS" and spellname == spellID_DrainSoul and sourceGUID == UnitGUID("player") then
            
            
            savexqlh = calculateLive()
            
        end
end)





