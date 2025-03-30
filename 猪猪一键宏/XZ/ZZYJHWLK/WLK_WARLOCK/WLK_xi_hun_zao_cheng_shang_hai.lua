if UnitClassBase("player")~="WARLOCK" then
    
    return
end

xihun = false

local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local function ResetXihun()
    xihun = false
end

frame:SetScript("OnEvent", function(self, event)
        local timestamp, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId,spellname = CombatLogGetCurrentEventInfo()
        
        if subEvent == "SPELL_PERIODIC_DAMAGE" and spellname == "吸取灵魂" and sourceGUID == UnitGUID("player") then
            xihun = true
            
            -- 在0.3秒后重置 xihun 为 false
            C_Timer.After(0.3, ResetXihun)
        end
end)

