yaoshuicd = true
local inCombat = false

-- 常用战斗药水的物品ID列表
local potionItemIDs = {
    43185, -- 符文治疗药水
    43186, -- 符文法力药水
    67489, -- 符文治疗注射器
    67490, -- 符文法力注射器
    53836, -- 奥术药水
    53908, -- 速度药水
    53909, -- 狂暴药水
    53910, -- 力量药水
    53911, -- 恢复药水
    53762, -- 不灭药水
    -- 添加其他药水的物品ID
}

-- 注册事件处理函数
local function EventFrame_OnEvent(self, event, ...)
    if event == "PLAYER_REGEN_ENABLED" then
        -- 玩家脱离战斗
        inCombat = false
        yaoshuicd = true
    elseif event == "PLAYER_REGEN_DISABLED" then
        -- 玩家进入战斗
        inCombat = true
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        -- 监视物品使用事件
        local unit, _, spellId = ...
        if unit == "player" then
            for _, id in ipairs(potionItemIDs) do
                if spellId == id and inCombat then
                    yaoshuicd = false
                    return
                end
            end
        end
    end
end

-- 创建框架并注册事件
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
EventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
EventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
EventFrame:SetScript("OnEvent", EventFrame_OnEvent)
