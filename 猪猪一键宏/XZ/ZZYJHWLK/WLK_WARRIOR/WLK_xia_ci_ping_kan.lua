if UnitClassBase("player") ~= "WARRIOR" then
    return
end

-- 初始化变量存储最后一次攻击时间和下次攻击时间
local LastMainHandTime = 0
local LastOffHandTime = 0
NextMainHandTime = 0
NextOffHandTime = 0

-- 创建框架用于注册事件和定时更新
local TempFrame = CreateFrame("Frame")
TempFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- 事件处理函数
TempFrame:SetScript("OnEvent", function(self, event, ...)
        local _, subevent, _, sourceGUID, _, _, _, _, _, _, _, spellID, spellName, _, _, isOffHandMiss, _, _, _, _, isOffHand = CombatLogGetCurrentEventInfo()
        
        -- 检查事件源是否为玩家
        if sourceGUID == UnitGUID("player") then
            if subevent == "SWING_DAMAGE" or subevent == "SWING_MISSED" then
                -- 对于普通攻击
                if subevent == "SWING_DAMAGE" then
                    isOffHand = select(21, CombatLogGetCurrentEventInfo())
                elseif subevent == "SWING_MISSED" then
                    isOffHand = select(13, CombatLogGetCurrentEventInfo())
                end
                
                if isOffHand then
                    LastOffHandTime = GetTime()  -- 更新副手最后攻击时间
                else
                    LastMainHandTime = GetTime()  -- 更新主手最后攻击时间
                end
            elseif (subevent == "SPELL_DAMAGE" or subevent == "SPELL_MISSED") and (spellName == "英勇打击" or spellName == "顺劈斩") then
                -- 对于特定技能
                LastMainHandTime = GetTime()  -- 更新主手最后攻击时间
            end
        end
end)

-- 设置OnUpdate处理函数来周期性更新下一次攻击时间
TempFrame:SetScript("OnUpdate", function(self, elapsed)
        local mainSpeed, offSpeed = UnitAttackSpeed("player")
        
        -- 计算下次主手攻击时间
        if LastMainHandTime ~= 0 and mainSpeed then
            NextMainHandTime = LastMainHandTime + mainSpeed - GetTime()
            if NextMainHandTime < 0 then
                NextMainHandTime = 0
            end
        end
        
        -- 计算下次副手攻击时间
        if LastOffHandTime ~= 0 and offSpeed then
            NextOffHandTime = LastOffHandTime + offSpeed - GetTime()
            if NextOffHandTime < 0 then
                NextOffHandTime = 0
            end
        end
end)

