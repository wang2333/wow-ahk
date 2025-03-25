local f = CreateFrame("Frame")
 ranshaocishu = 0 -- 燃烧计数器初始化
local SPELL_BURNING = 11129     -- 燃烧的法术ID（需要确认）
local SPELL_FIREBALL = 42833        -- 火球术ID（需要确认）
local SPELL_LIVING_BOMB = 55362   -- 活体炸弹ID（需要确认）
local SPELL_PYROBLAST = 42891     -- 炎爆术ID（需要确认）

-- 事件处理函数
f:SetScript("OnEvent", function(_, event, ...)
    -- 当获得燃烧BUFF时重置计数器
    if event == "SPELL_AURA_APPLIED" then
        local _, sourceGUID, _, _, _, destGUID, _, _, spellID = ...
        if destGUID == UnitGUID("player") and spellID == SPELL_BURNING then
            ranshaocishu = 0
            print("|cFFFF0000燃烧触发！|r 法术计数器已重置")
        end
    
    -- 当成功施放法术时增加计数器
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unitTarget, _, spellID = ...
        if unitTarget == "player" and ranshaocishu ~= nil then
            if spellID == SPELL_FIREBALL or 
               spellID == SPELL_LIVING_BOMB or 
               spellID == SPELL_PYROBLAST then
                ranshaocishu = ranshaocishu + 1
                print(format("燃烧后法术计数：|cFF00FF00%d|r", ranshaocishu))
            end
        end
    end
end)

-- 注册事件监听
f:RegisterEvent("SPELL_AURA_APPLIED")          -- 光环获取事件
f:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")    -- 施法成功事件