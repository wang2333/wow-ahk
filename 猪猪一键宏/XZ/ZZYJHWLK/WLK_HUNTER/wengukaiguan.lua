if UnitClassBase("player") ~= "HUNTER" then
    return
end

wengukaiguan = true
wengujishuqi = 0

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, destRaidFlags, _, _, spellName = CombatLogGetCurrentEventInfo()
        
        -- 检查事件是否是开始施放稳固射击
        if subEvent == "SPELL_CAST_START" and spellName == "稳固射击" and sourceName == UnitName("player") then
            wengujishuqi = wengujishuqi + 1
            if wengujishuqi == 1 then
                wengukaiguan = false  -- 第一次施放，关闭开关，预备下一次
            elseif wengujishuqi == 2 then
                wengukaiguan = true   -- 第二次施放，打开开关，提示用户
                wengujishuqi = 0      -- 重置计数器，为下一组操作做准备
            end
        end
        
        -- 如果稳固射击施法失败
        if subEvent == "SPELL_CAST_FAILED" and spellName == "稳固射击" and sourceName == UnitName("player") then
            if wengujishuqi == 1 then
                wengukaiguan = true  -- 如果是第一次射击失败，打开开关，提示用户可以进行其他操作
                wengujishuqi = 0     -- 重置计数器
            elseif wengujishuqi == 2 then
                wengukaiguan = false  -- 如果是第二次射击失败，保持开关关闭，等待用户再次尝试
                wengujishuqi = 1      -- 将计数器减1，等待下一次射击
            end
        end
        
        -- 如果施法成功（包括稳固射击和其他技能）
        if subEvent == "SPELL_CAST_SUCCESS" and sourceName == UnitName("player") then
            if spellName == "稳固射击" and wengujishuqi == 2 then
                wengukaiguan = true
                wengujishuqi = 0
            elseif spellName == "瞄准射击" or spellName == "多重射击" or spellName == "毒蛇钉刺" or spellName == "奇美拉射击" or spellName == "杀戮射击" then
                wengujishuqi = 0  -- 其他关键技能施法成功时也重置计数器
            end
        end
    end
end

-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", OnCombatEvent)
