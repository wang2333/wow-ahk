if UnitClassBase("player") ~= "HUNTER" then
    return
end

-- 初始化一个全局标志变量
baozhakaiguan = true
local debuffCheckDelay = 0.1 -- 等待0.1秒后再检查debuff
local castTimer -- 用于追踪施法计时器的变量

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, destRaidFlags, _, _, spellName = CombatLogGetCurrentEventInfo()
        
        -- 检查事件是否是开始施放献祭
        if subEvent == "SPELL_CAST_SUCCESS" and spellName == "爆炸射击" and sourceName == UnitName("player") then
            baozhakaiguan = false
            
            -- 如果存在先前的计时器，取消它
            if castTimer then
                castTimer:Cancel()
            end
            
            -- 启动一个新的计时器，如果在1.6秒后施法还未成功，则设置xjkaiguan为true
            castTimer = C_Timer.NewTimer(1.5, function()
                    baozhakaiguan= true
            end)
        end
        
        
        
    elseif event == "PLAYER_TARGET_CHANGED" or UnitIsDead("target") then
        -- 当玩家改变目标或目标死亡时，重置 xjkaiguan，并取消任何正在进行的计时器
        if castTimer then
            castTimer:Cancel()
        end
        baozhakaiguan = true
    end
end

-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
eventFrame:SetScript("OnEvent", OnCombatEvent)

