if UnitClassBase("player")~="WARLOCK" then
    
    return
end
-- 全局变量，用于存储是否应该提示施放法术
zhi_xiang_xian_ji = false

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

frame:SetScript("OnEvent", function(self, event, ...)
        if event == "UNIT_SPELLCAST_START" then
            local unit, _, spellId = ...
            if unit == "player" and spellId == 47811 then
                zhi_xiang_xian_ji = false
            end
        elseif event == "UPDATE_MOUSEOVER_UNIT" then
            local mouseoverGUID = UnitGUID("mouseover")
            if mouseoverGUID then
                zhi_xiang_xian_ji = true
            end
        end
end)



