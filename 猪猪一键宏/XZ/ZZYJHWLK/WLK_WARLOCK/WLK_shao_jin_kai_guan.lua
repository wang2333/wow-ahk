if UnitClassBase("player") ~= "WARLOCK" then
    return
end

-- 初始化一个全局标志变量
sjkaiguan = true

-- 初始化 rhzxcs 变量，防止为 nil
if rhzxcs == nil then
    rhzxcs = 0
end

-- 战斗事件处理函数
local function OnCombatEvent(self, event, ...)
    local timestamp, subEvent, _, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, destRaidFlags, _, spellId, spellName = CombatLogGetCurrentEventInfo()

    -- 检查事件是否是当前玩家开始施放"烧尽"
    if subEvent == "SPELL_CAST_START" and spellName == "烧尽" and sourceName == UnitName("player") then
        C_Timer.After(0.2, function()
            -- 这里先检查 rhzxcs 是否为 nil，然后再进行比较
            if rhzxcs ~= nil and (rhzxcs <= 1 or rhzxcs == nil) then
                -- 设置 sjkaiguan 为 false
                sjkaiguan = false
            end
        end)
    end

    -- 处理施法失败的情况
    if subEvent == "SPELL_CAST_FAILED" and spellName == "烧尽" and sourceName == UnitName("player") then
        sjkaiguan = true
    end

    -- 检查 rhzxcs 的值，并在特定情况下设置 sjkaiguan 为 true
    if rhzxcs ~= nil and rhzxcs == 3 then
        sjkaiguan = true
    end
end

-- 创建一个框架用于注册和处理事件
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
eventFrame:SetScript("OnEvent", OnCombatEvent)
