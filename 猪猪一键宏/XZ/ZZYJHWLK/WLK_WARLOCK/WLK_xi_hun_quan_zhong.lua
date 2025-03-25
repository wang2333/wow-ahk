if UnitClassBase("player")~="WARLOCK" then

    return
end

local spellCoefficient = 0.429 -- 吸取灵魂的系数
local coefficientTotal = 2.145 -- 总系数（可能是考虑所有相关效果的总和）
local shadowMastery = 1.15 -- 暗影掌握的伤害提高百分比
local deathsEmbrace = 1.12 -- 死亡的拥抱的伤害提高百分比
local drainSoulModifier = 4 -- 吸取灵魂的伤害修正值（如目标生命低于25%时）
local baseDS = 840 -- 吸取灵魂的基础伤害值

-- 计算当前值的函数
function getCurrentValues()
    local spellPower = GetSpellBonusDamage(6) -- 获取玩家当前的法术强度
    local _,_,_,_,_,_,varmodapplied = UnitDamage("player") -- 获取玩家的伤害加成
    local mod = varmodapplied
    local _,_,_,sbCastTime = GetSpellInfo(6215) -- 获取“恐惧”技能的施放时间
    local dsChannel = (sbCastTime / 1000) * 10 -- 计算吸取灵魂的持续时间
    
    return spellPower, mod, dsChannel
end

-- 计算实时伤害值的函数
function calculateLive()
    local spellPower, mod, dsChannel = getCurrentValues() -- 获取当前值
    
    local spellDamage = spellPower * coefficientTotal -- 计算法术伤害
    local snappedDamage = (baseDS + spellDamage) * shadowMastery * deathsEmbrace * drainSoulModifier * mod -- 计算最终伤害值
    local total = snappedDamage / dsChannel -- 计算每次吸取灵魂的平均伤害
    
    return math.floor(total) -- 返回计算结果
end

