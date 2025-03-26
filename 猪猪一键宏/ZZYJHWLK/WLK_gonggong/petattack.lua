-- 创建一个框架用于注册和处理战斗事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- 注册脱离战斗事件
frame:RegisterEvent("UNIT_TARGET")            -- 注册单位目标变更事件

-- 宠物是否攻击到怪物的标志变量
petattack = false

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        -- 从战斗日志中获取事件详情
        local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = CombatLogGetCurrentEventInfo()
        
        -- 检查事件是否是宠物的攻击事件
        if sourceGUID == UnitGUID("pet") then  -- 确保事件来源是玩家的宠物
            if subEvent == "SPELL_DAMAGE" or subEvent == "RANGE_DAMAGE" or subEvent == "SWING_DAMAGE" then
                -- 宠物已经攻击到目标
                petattack = true
                
                -- 设置一个计时器，1.5秒后重置 petattack 变量
               -- C_Timer.After(1.5, function()
                --    petattack = false
                --end)
            end
        end
    elseif event == "PLAYER_REGEN_ENABLED" or event == "UNIT_TARGET" then
        local unit = ...
        if event == "UNIT_TARGET" and unit == "pet" then
            -- 仅当宠物的目标发生变更时重置
            petattack = false
        elseif event == "PLAYER_REGEN_ENABLED" then
            -- 脱离战斗时重置
            petattack = false
        end
    end
end)
