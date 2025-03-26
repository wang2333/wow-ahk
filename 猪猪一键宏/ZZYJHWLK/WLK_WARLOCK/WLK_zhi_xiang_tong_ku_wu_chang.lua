if UnitClassBase("player")~="WARLOCK" then
    
    return
end
-- 全局变量，用于存储是否应该提示施放法术
ShouldCastSpellOnMouseover = false

local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

frame:SetScript("OnEvent", function(self, event, ...)
        if event == "UNIT_SPELLCAST_START" then
            local unit, _, spellId = ...
            if unit == "player" and spellId == 47843 then
                ShouldCastSpellOnMouseover = false
            end
        elseif event == "UPDATE_MOUSEOVER_UNIT" then
            local mouseoverGUID = UnitGUID("mouseover")
            if mouseoverGUID then
                ShouldCastSpellOnMouseover = true
            end
        end
end)



