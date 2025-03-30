if UnitClassBase("player")~="SHAMAN" then
   return
end

yszw = true  -- 元素掌握初始可用
local daojishi = 0  -- 初始化倒计时
local frame = CreateFrame("Frame")

frame:SetScript("OnEvent", function(self, event, ...)
        local timestamp, subevent, _, _, sourceName, _, _, _, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
        
        if subevent == "SPELL_CAST_SUCCESS" and sourceName == UnitName("player") then
            if spellName == "元素掌握" then
                yszw = false
                daojishi = 180  -- 设置倒计时180秒
                
            elseif spellName == "闪电箭" or spellName == "闪电链" then
                daojishi = max(daojishi - 1, 0)  -- 减少3秒冷却时间，不小于0
                
                if daojishi == 0 then
                    yszw = true
                    
                end
            end
        end
end)

frame:SetScript("OnUpdate", function(self, elapsed)
        if not yszw and daojishi > 0 then
            daojishi = max(daojishi - elapsed, 0)  -- 根据经过的时间减少冷却时间
            if daojishi <= 0 then
                yszw = true
                
            end
        end
end)

frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")



