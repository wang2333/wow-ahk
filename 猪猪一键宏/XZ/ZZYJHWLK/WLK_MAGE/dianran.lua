if UnitClassBase("player")~="MAGE" then
    return
end

-- 初始化变量
local igniteValue = {}
local igniteSpells = {
    [2136] = true,   -- 火焰冲击
    [133] = true,    -- 火球术
    [44614] = true,  -- 霜火键
    [2948] = true,   -- 灼烧
    [92315] = true,  -- 炎爆术
    [11366] = true,  -- 炎爆术
    [31661] = true,  -- long xi
    [2120]   = true, --lie yan feng bao
    [11113]  = true, --chong ji bo
    
}
local igniteDebuffId = 413841  -- 假设点燃的debuff法术ID是12654
dianranzhi = 0  -- 全局变量存储点燃总伤害

-- 创建帧用于事件监听
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- 计算点燃伤害的函数
local function calculateIgnite(guid, amount)
    local igniteAmount = amount * 0.4  -- 点燃伤害是造成伤害的40%
    igniteValue[guid] = (igniteValue[guid] or 0) + igniteAmount
    dianranzhi = igniteValue[guid]  -- 更新全局点燃伤害变量
end

-- 事件处理函数
frame:SetScript("OnEvent", function(_, event, ...)
        local timestamp, subEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId, _, _, amount, _, _, _, _, _, critical = CombatLogGetCurrentEventInfo()
        
        -- 确保事件源是玩家，并且事件是造成了法术伤害
        if sourceGUID == UnitGUID("player") then
            if subEvent == "SPELL_DAMAGE" and igniteSpells[spellId] and critical then
                calculateIgnite(destGUID, amount)
            elseif subEvent == "SPELL_AURA_REMOVED" and spellId == igniteDebuffId then
                igniteValue[destGUID] = 0  -- 点燃debuff移除时重置点燃伤害
                if destGUID == UnitGUID("target") then
                    dianranzhi = 0  -- 如果当前目标的点燃debuff被移除，重置全局变量
                end
            end
        end
end)

-- 可选：创建一个简单的命令来查看当前目标的点燃总伤害
SLASH_IGNITECHECK1 = '/ignitecheck'
function SlashCmdList.IGNITECHECK(msg, editbox)
    local guid = UnitGUID("target")
    if guid and igniteValue[guid] then
        print("Current Ignite Damage on Target:", igniteValue[guid])
    else
        print("No Ignite Damage on Current Target.")
    end
end

