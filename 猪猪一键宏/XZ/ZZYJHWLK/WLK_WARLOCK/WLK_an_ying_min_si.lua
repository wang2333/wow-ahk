if UnitClassBase("player") ~= "WARLOCK" then
    return
end

-- 全局变量存储暗影箭的正常施法时间
ayjcast = nil or 0
-- 暗影冥思增益的法术ID
local SHADOW_TRANCE_SPELL_ID = 17941
-- 暗影箭的法术名称
local SHADOW_BOLT_SPELL_NAME = "暗影箭"

-- 检查玩家是否有暗影冥思的增益效果
function HasShadowTranceBuff()
    for i = 1, 40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", i)
        if spellId == SHADOW_TRANCE_SPELL_ID then
            return true
        elseif not name then
            break
        end
    end
    return false
end

-- 更新暗影箭的施法速度
function UpdateShadowBoltCastTime()
    if not HasShadowTranceBuff() then
        local name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(SHADOW_BOLT_SPELL_NAME)
        if castTime ~= nil then
            ayjcast = castTime / 1000
        end
    end
end

-- 事件处理函数
local function OnEvent(self, event, ...)
    if event == "UNIT_SPELLCAST_START" or event == "UNIT_AURA" then
        local unit = ...
        if unit == "player" then
            UpdateShadowBoltCastTime()
        end
    end
end

-- 设置事件处理器
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_START")
frame:RegisterEvent("UNIT_AURA")
frame:SetScript("OnEvent", OnEvent)

-- 初始化时更新施法时间
UpdateShadowBoltCastTime()
