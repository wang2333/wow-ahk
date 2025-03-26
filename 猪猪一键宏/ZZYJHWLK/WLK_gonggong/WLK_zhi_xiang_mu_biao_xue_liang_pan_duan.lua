

-- 定义 mouseover 相关的全局变量
mouseoverTodeathtime = nil
mouseoverGUID = nil
mouseoverbegintime = nil
mouseoverhealth = nil
UnitHealthProportion = 0.9
-- 计算 mouseover 死亡时间的函数
function CalculateMouseOverDeathTime()
    local unit = "mouseover"
    local currentGUID = UnitGUID(unit)
    local currentHealth = UnitHealth(unit)
    local currentHealthMax = UnitHealthMax(unit)
    local currentTime = GetTime()
    
    if not currentGUID then
        mouseoverTodeathtime = nil
        mouseoverGUID = nil
        return
    end
    
    if mouseoverGUID ~= currentGUID or currentHealth >= currentHealthMax * UnitHealthProportion then
        mouseoverbegintime, mouseoverhealth = currentTime, currentHealth
    elseif mouseoverbegintime and mouseoverhealth and mouseoverhealth > currentHealth then
        local healthChange = mouseoverhealth - currentHealth
        local timeChange = currentTime - mouseoverbegintime
        mouseoverTodeathtime = currentHealth / (healthChange / timeChange)
    end
    
    mouseoverGUID = currentGUID
end

-- 创建一个帧来监听 mouseover 的更新
local mouseoverFrame = CreateFrame("Frame")
mouseoverFrame:SetScript("OnUpdate", function(self, elapsed)
        CalculateMouseOverDeathTime()
end)


