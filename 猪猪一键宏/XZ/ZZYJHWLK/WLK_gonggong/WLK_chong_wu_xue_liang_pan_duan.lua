-- 定义 pettarget 相关的全局变量
petTodeathtime = nil
pettargetGUID = nil
pettargetbegintime = nil
pettargethealth = nil
UnitHealthProportion = 0.9
-- 计算 pettarget 死亡时间的函数
function CalculatePetTargetDeathTime()
    local unit = "pettarget"
    local currentGUID = UnitGUID(unit)
    local currentHealth = UnitHealth(unit)
    local currentHealthMax = UnitHealthMax(unit)
    local currentTime = GetTime()
    
    if not currentGUID then
        petTodeathtime = nil
        pettargetGUID = nil
        return
    end
    
    if pettargetGUID ~= currentGUID or currentHealth >= currentHealthMax * UnitHealthProportion then
        pettargetbegintime, pettargethealth = currentTime, currentHealth
    elseif pettargetbegintime and pettargethealth and pettargethealth > currentHealth then
        local healthChange = pettargethealth - currentHealth
        local timeChange = currentTime - pettargetbegintime
        petTodeathtime = currentHealth / (healthChange / timeChange)
    end
    
    pettargetGUID = currentGUID
end

-- 创建一个帧来监听 pettarget 的更新
local pettargetFrame = CreateFrame("Frame")
pettargetFrame:SetScript("OnUpdate", function(self, elapsed)
        CalculatePetTargetDeathTime()
end)


