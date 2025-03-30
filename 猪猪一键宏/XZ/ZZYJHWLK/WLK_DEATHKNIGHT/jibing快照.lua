-- 基本库函数，用于获取游戏相关数据
local UnitAttackPower = UnitAttackPower
local UnitDamage = UnitDamage
local GetMastery = GetMastery

-- 伤害计算变量
local ff_dmg, bp_dmg
local isFrost, isUnholy

-- 全局变量，用于外部访问和对比
_G.totalDPS = 0

-- 刷新玩家专精状态
local function RefreshSpecs()
    local activeGroup = 2  -- 假定玩家当前是冰霜专精
    isFrost = activeGroup == 2
    isUnholy = activeGroup == 3
end

-- 计算并更新疾病的DPS总和
local function RefreshDiseaseDamage()
    local base, posBuff, negBuff = UnitAttackPower('player')  -- 获取玩家攻击力
    local AP = base + posBuff - negBuff
    local _,_,_,_,_,_, percentmod = UnitDamage('player')  -- 获取伤害百分比加成
    local masterymod = 1 + GetMastery()/100  -- 获取精通加成

    ff_dmg = AP * 0.055 * 1.15 * percentmod * (isFrost and masterymod or 1)
    bp_dmg = AP * 0.055 * 1.15 * percentmod * (isUnholy and masterymod or 1)
    _G.totalDPS = (ff_dmg + bp_dmg) / 3
end

-- 事件处理框架
local frame = CreateFrame("Frame")

-- 注册事件处理器
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:RegisterEvent("UNIT_STATS")
frame:RegisterEvent("UNIT_AURA")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("UNIT_ATTACK_POWER")
frame:RegisterEvent("UNIT_DAMAGE")

-- 事件处理函数
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_TALENT_UPDATE" or event == "UNIT_STATS" or event == "UNIT_ATTACK_POWER" or
       event == "UNIT_DAMAGE" or event == "UNIT_AURA" or event == "PLAYER_TARGET_CHANGED" then
        RefreshSpecs()
        RefreshDiseaseDamage()
    end
end)

-- 初始化
RefreshSpecs()
RefreshDiseaseDamage()
