-- 仅限猎人职业使用
if UnitClassBase("player") ~= "HUNTER" then
    return
end

-- 初始化变量
local LastRangedTime = 0

zdsj = 0

-- 创建框架
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")


-- 事件处理
frame:SetScript("OnEvent", function(self, event, ...)
    
    -- 解析战斗日志
    local _, subevent, _, sourceGUID, _, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
    
    -- 检测远程攻击
    if sourceGUID == UnitGUID("player") 
        and spellID == 75  -- 自动射击ID
        and (subevent == "SPELL_CAST_SUCCESS") 
    then
        LastRangedTime = GetTime()
        zzrangedSpeed = select(1, UnitRangedDamage("player")) 
    end
end)

-- 计时更新
frame:SetScript("OnUpdate", function(self, elapsed)

    
    if LastRangedTime ~= 0 and zzrangedSpeed then
        local elapsedTime = GetTime() - LastRangedTime
        zdsj = math.max(0, zzrangedSpeed - elapsedTime)
    else
        zdsj = 0
    end
end)
        
