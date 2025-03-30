-- 导入必要的游戏API
local ZZ_DK_UnitDamage = UnitDamage
local ZZ_DK_UnitAttackPower = UnitAttackPower
local ZZ_DK_GetMastery = GetMastery
local ZZ_DK_UnitExists, ZZ_DK_UnitGUID = UnitExists, UnitGUID
local ZZ_DK_GetPrimaryTalentTree, ZZ_DK_GetActiveTalentGroup = GetPrimaryTalentTree, GetActiveTalentGroup

-- 声明变量
local ZZ_DK_isFrost, ZZ_DK_isUnholy
ZZ_DK_nameplate = {}
ZZ_DK_JBKZ = {}  -- 修改变量名为ZZ_DK_JBKZ

-- 初始化nameplate数组
for i = 1, 40, 1 do
    ZZ_DK_nameplate[i] = "nameplate" .. i  -- 假设这里创建GUID对应关系，通常需要动态获取
    ZZ_DK_JBKZ[i] = 0  -- 修改变量名为ZZ_DK_JBKZ
end

-- 更新专精状态
local function ZZ_DK_RefreshSpecs()
    local activeGroup = ZZ_DK_GetActiveTalentGroup(false)
    local activeSpec = ZZ_DK_GetPrimaryTalentTree(false, false, activeGroup)
    ZZ_DK_isFrost = activeSpec == 2
    ZZ_DK_isUnholy = activeSpec == 3
end

-- 计算当前DPS
ZZ_DK_totalDPS = 0
function ZZ_DK_quanzhong()
    if not UnitAffectingCombat("player") then
        for i = 1, 40, 1 do
            ZZ_DK_JBKZ[i] = 0  -- 修改变量名为ZZ_DK_JBKZ
        end
    end
    local base, posBuff, negBuff = ZZ_DK_UnitAttackPower('player')
    local AP = base + posBuff - negBuff
    local _, _, _, _, _, _, percentmod = ZZ_DK_UnitDamage('player')
    local masterymod = 1 + ZZ_DK_GetMastery() / 100
    local ff_dmg = (AP * 0.055 * 1.15) * percentmod * (ZZ_DK_isFrost and masterymod or 1)
    local bp_dmg = (AP * 0.055 * 1.15) * percentmod * (ZZ_DK_isUnholy and masterymod or 1)
    ZZ_DK_totalDPS = (ff_dmg + bp_dmg) / 3
    return ZZ_DK_totalDPS
end

local ZZ_DK_TempFrame = CreateFrame("Frame")
ZZ_DK_TempFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
ZZ_DK_TempFrame:SetScript("OnEvent", function(_, event, ...)
        local _, subevent, _, sourceGUID, sourceName, _, _, destGUID, _, _, _, spellId = CombatLogGetCurrentEventInfo()
        if subevent == "SPELL_AURA_APPLIED" and sourceName == UnitName("player") then
            for i = 1, 40 do
                if ZZ_DK_UnitGUID(ZZ_DK_nameplate[i]) == destGUID then
                    ZZ_DK_JBKZ[i] = ZZ_DK_quanzhong()  -- 修改变量名为ZZ_DK_JBKZ
                end
            end
        end
end)

-- 初始化专精状态
ZZ_DK_RefreshSpecs()