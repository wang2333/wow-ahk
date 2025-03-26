-- 假设zhuoshaocount和zhuoshaotime在脚本的其他地方已经被实时更新
aoshu2 = false
aoshu3 = false
aoshu4 = false
if not aoshucount then aoshucount = 0 end
if not aoshutime then aoshutime = 0 end

-- 事件处理函数
local function OnCombatEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subEvent, _, sourceGUID, sourceName, _, destGUID, destName, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()

        -- 检查事件是否是玩家开始施放“奥术冲击”
        if subEvent == "SPELL_CAST_START" and spellName == "奥术冲击" and sourceName == UnitName("player") then
            C_Timer.After(0.3, function()
                aoshucount = aoshucount + 1  -- 增加奥术冲击的计数
                -- 从最高的条件开始向下检查
                if aoshucount >= 4 then
                    aoshu4 = true
                elseif aoshucount >= 3 then
                    aoshu3 = true
                elseif aoshucount >= 2 then
                    aoshu2 = true
                end
            end)
        end

        -- 检查事件是否是玩家开始施放“奥术飞弹”或“奥术弹幕”
        if subEvent == "SPELL_CAST_SUCCESS" and (spellName == "奥术飞弹" or spellName == "奥术弹幕") and sourceName == UnitName("player") then
            aoshu2 = false
            aoshu3 = false
            aoshu4 = false
           
        end
    end
end

-- 创建一个框架用于注册和处理事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- 设置框架的事件处理脚本
frame:SetScript("OnEvent", OnCombatEvent)
