-- 创建一个框架来监听事件
local frame = CreateFrame("Frame")

-- 初始化变量
buffpanduan = true

-- 定义buff和debuff列表
local playerDebuffsToCheck = {"疯狂嗜血", "麻痹诅咒","萨隆亚的礼物"}
local playerBuffsToCheck = {"Buff1", "Buff2"}
local targetDebuffsToCheck = {"统御心灵", "TargetDebuff2"}
local targetBuffsToCheck = {"玄秘遮蔽", "暗影屏障",}

-- 定义检查函数
local function checkAuras()
    buffpanduan = true  -- 重新设置为true，以便重新检查

    -- 检查玩家的debuff
    for i = 1, 40 do
        local name = UnitDebuff("player", i)
        if name and tContains(playerDebuffsToCheck, name) then
            buffpanduan = false
            break
        end
    end

    -- 检查玩家的buff
    if buffpanduan then
        for i = 1, 40 do
            local name = UnitBuff("player", i)
            if name and tContains(playerBuffsToCheck, name) then
                buffpanduan = false
                break
            end
        end
    end

    -- 检查目标的debuff
    for i = 1, 40 do
        local name = UnitDebuff("target", i)
        if name and tContains(targetDebuffsToCheck, name) then
            buffpanduan = false
            break
        end
    end

    -- 检查目标的buff
    if buffpanduan then
        for i = 1, 40 do
            local name = UnitBuff("target", i)
            if name and tContains(targetBuffsToCheck, name) then
                buffpanduan = false
                break
            end
        end
    end


end

-- 事件处理函数
local function eventHandler(self, event, unit)
    if event == "PLAYER_TARGET_CHANGED" or (unit == "player" or unit == "target") then
        checkAuras()
    end
end

-- 注册事件并设置事件处理函数
frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:SetScript("OnEvent", eventHandler)

-- 首次手动检查
checkAuras()
