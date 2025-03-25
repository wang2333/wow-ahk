-- 定义与目标相关的全局变量
todeathtime = nil
targetGUID = nil
targetbegintime = nil
targethealth = nil

-- 计算目标死亡时间的函数
function CalculateTargetDeathTime()
    local unit = "target"
    local currentGUID = UnitGUID(unit)
    local currentHealth = UnitHealth(unit)
    local currentTime = GetTime()
    
    if not currentGUID then
        -- 如果当前没有目标，则重置变量
        todeathtime = nil
        targetGUID = nil
        return
    end
    
    if targetGUID ~= currentGUID then
        -- 目标改变时，重置开始时间和开始时的健康值
        targetbegintime, targethealth = currentTime, currentHealth
    elseif targetbegintime and targethealth and targethealth > currentHealth then
        -- 如果目标健康值有所下降，计算死亡时间
        local healthChange = targethealth - currentHealth
        local timeChange = currentTime - targetbegintime
        -- 确保计算的健康值变化是负数（表示损失的健康值），并且时间变化是正数
        if healthChange > 0 and timeChange > 0 then
            -- 根据健康值的变化和时间的变化计算死亡时间
            todeathtime = currentHealth / (healthChange / timeChange)
        end
    end
    
    targetGUID = currentGUID
end

-- 创建一个帧来监听 target 的更新
local targetFrame = CreateFrame("Frame")
targetFrame:SetScript("OnUpdate", function(self, elapsed)
        CalculateTargetDeathTime()
end)



