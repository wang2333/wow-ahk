if UnitClassBase("player") ~= "PRIEST" then
    return
end

jingshenbianchikg = true
bian_ci_count = 0

local frame = CreateFrame("Frame")

frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

local function Resetbianchi()
    jingshenbianchikg = false
end

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, subEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellname = CombatLogGetCurrentEventInfo()
        
        if subEvent == "SPELL_DAMAGE" and spellname == "精神鞭笞" and sourceGUID == UnitGUID("player") then
            jingshenbianchikg = false
            -- 在精神鞭笞法术造成伤害时进行计数
            bian_ci_count = bian_ci_count + 1
            
            if bian_ci_count >= 2 then
                -- 如果计数达到2或更多，重置计数并将 jingshenbianchikg 设置为 true
                bian_ci_count = 0
                jingshenbianchikg = true
                C_Timer.After(0.2, Resetbianchi)
            end
        end
        
        -- 检查当前是否正在施法中精神鞭笞法术
        local isyindao = UnitChannelInfo("player")
        local isputong = UnitCastingInfo("player")
        
        if not isyindao and not isputong then
            -- 如果不在施法中，将 jingshenbianchikg 设置为 true
            jingshenbianchikg = true
        end
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellId = ...
        local spellname = GetSpellInfo(spellId) -- 获取法术名称
        if unit == "player" and spellname == "精神鞭笞" then
            -- 当法术精神鞭笞成功施放时，将 jingshenbianchikg 设置为 false
            bian_ci_count = 0
            jingshenbianchikg = false
        end
    end
end)
