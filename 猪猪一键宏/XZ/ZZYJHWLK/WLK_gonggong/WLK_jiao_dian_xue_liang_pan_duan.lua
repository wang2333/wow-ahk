
-- 定义 focus 相关的全局变量
JDtodeathtime = nil
focusGUID = nil
focusbegintime = nil
focushealth = nil
UnitHealthProportion = 0.9
-- 计算 focus 死亡时间的函数
function CalculateFocusDeathTime()
    local unit = "focus"
    local currentGUID = UnitGUID(unit)
    local currentHealth = UnitHealth(unit)
    local currentHealthMax = UnitHealthMax(unit)
    local currentTime = GetTime()
    
    if not currentGUID then
        JDtodeathtime = nil
        focusGUID = nil
        return
    end
    
    if focusGUID ~= currentGUID or currentHealth >= currentHealthMax * UnitHealthProportion then
        focusbegintime, focushealth = currentTime, currentHealth
    elseif focusbegintime and focushealth and focushealth > currentHealth then
        local healthChange = focushealth - currentHealth
        local timeChange = currentTime - focusbegintime
        JDtodeathtime = currentHealth / (healthChange / timeChange)
    end
    
    focusGUID = currentGUID
end

-- 创建一个帧来监听 focus 的更新
local focusFrame = CreateFrame("Frame")
focusFrame:SetScript("OnUpdate", function(self, elapsed)
        CalculateFocusDeathTime()
end)

