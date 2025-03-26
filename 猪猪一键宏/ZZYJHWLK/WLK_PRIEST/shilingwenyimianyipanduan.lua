if UnitClassBase("player")~="PRIEST" then
    return
end

-- 创建全局变量并初始化为 true
MS_mianyi = true
local debuffCheckDelay = 0.1 -- 等待0.3秒后再检查debuff

-- 注册游戏事件监听函数
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED") -- 注册目标改变事件

-- 定义事件处理函数
frame:SetScript("OnEvent", function(self, event, ...)
        if event == "COMBAT_LOG_EVENT_UNFILTERED" then
            local _, eventType, _, _, _, _, _, destGUID, _, _, _, _, spellName, _, missType = CombatLogGetCurrentEventInfo()
            
            -- 检查技能未命中事件
            if eventType == "SPELL_MISSED" and destGUID == UnitGUID("target") and spellName == "噬灵疫病" and missType == "IMMUNE" then
                MS_mianyi = false
            end
            
            
            
        end
        
        -- 检查目标是否死亡
        if UnitIsDead("target") then
            MS_mianyi = true -- 根据需要设置目标死亡时的 MS_mianyi 状态
        end
        if event == "PLAYER_TARGET_CHANGED" then
            -- 在目标改变时将 MS_mianyi 设置为 true
            MS_mianyi = true
        end
end)

