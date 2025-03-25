if UnitClassBase("player")~="MAGE" then
    return
end

-- 初始化变量
lianji = 0
lianjichufa = false
local timerActive = false -- 新增一个标志，用于跟踪计时器是否已经激活

-- 技能名称定义
local spellNames = {
    ["灼烧"] = true,
    ["火球术"] = true,
    ["火焰冲击"] = true,
    ["炎爆术"] = true,
    ["霜火之箭"] = true,
}

-- 技能ID定义
local spellIDs = {
    [55362] = true, -- 活动炸弹的法术ID
}

-- 检查技能是否触发连击
local function checkSpell(spellId, spellName, isCritical)
    if spellNames[spellName] or spellIDs[spellId] then
        if isCritical then
            -- 如果是暴击，增加连击次数
            lianji = lianji + 1
            if lianji >= 2 and not lianjichufa then
                lianjichufa = true
                lianji = 0
                -- 如果计时器未激活，启动10秒计时器
                if not timerActive then
                    timerActive = true
                    C_Timer.After(9.9, function()
                            if lianjichufa then
                                lianjichufa = false
                            end
                            timerActive = false -- 计时器结束，重置标志
                    end)
                end
            end
        else
            -- 如果不是暴击，重置连击次数
            lianji = 0
        end
    end
end

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subEvent, _, sourceGUID, _, _, _, _, _, _, _, spellId, spellName, _, _, _, _, _, _, _,isCritical = CombatLogGetCurrentEventInfo()
        
        -- 检查事件是否是技能伤害事件并且来源是玩家
        if subEvent == "SPELL_DAMAGE" and sourceGUID == UnitGUID("player") then
            checkSpell(spellId, spellName, isCritical)
        elseif subEvent == "SPELL_CAST_SUCCESS" and spellName == "炎爆术" and sourceGUID == UnitGUID("player") then
            -- 如果是成功施放炎爆术，重置连击触发状态和连击次数
            lianjichufa = false
            lianji = 0
        end
    end
end

-- 创建一个框架用于注册和处理事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")  -- 注册战斗日志事件
frame:SetScript("OnEvent", OnCombatEvent)  -- 设置事件处理函数


