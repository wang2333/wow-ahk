-- 建议放在你的 addon 主文件或一个独立的 .lua 文件中

-- 创建一个 Frame 来注册/监听游戏事件
local f = CreateFrame("Frame")

-- 声明我们需要用到的变量
local zhandoutime = 0       -- 记录本次战斗的累计时间
local combatStartTime = 0   -- 记录进入战斗时的时间戳

-- 注册进入/离开战斗事件
f:RegisterEvent("PLAYER_REGEN_DISABLED")  -- 进入战斗
f:RegisterEvent("PLAYER_REGEN_ENABLED")   -- 离开战斗

-- 设置事件脚本
f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        -- 进入战斗时，重置并记录当前时间
        combatStartTime = GetTime()
        zhandoutime = 0
        
        -- 在 OnUpdate 中每帧更新 zhandoutime
        self:SetScript("OnUpdate", function()
            zhandoutime = GetTime() - combatStartTime
        end)

    elseif event == "PLAYER_REGEN_ENABLED" then
        -- 离开战斗时，停止计时，并将 zhandoutime 归零
        self:SetScript("OnUpdate", nil)
        zhandoutime = 0
    end
end)
