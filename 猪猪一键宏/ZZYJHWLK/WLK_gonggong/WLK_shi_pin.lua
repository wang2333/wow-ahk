local trinketData = {
    { trinketName = "无名巫妖的护符匣", buffName = "虹吸能量", cooldown = 100, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "被摘除的外物", buffName = "能量涌动", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "岩幔的恩惠", buffName = "恩惠", cooldown = 120, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "哈里森的炫目徽章", buffName = "硬化之壳", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "死亡的选择", buffName = "杰出", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "死亡的裁决", buffName = "杰出", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "暗月卡片：伟大", buffName = "伟大", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "密语尖牙颅骨", buffName = "寒怒", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "死神的意志", buffName = {"牦牛人的锋芒", "维库人的迅捷", "铁矮人的精准", "铁矮人的专注", "维库人的急速", "牦牛人的蛮力"}, cooldown = 105, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "锐锋暮光龙鳞", buffName = "光影穿刺", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "焦黑暮光龙鳞", buffName = "暮光烈焰", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "兽魂狂暴之石", buffName = "大师之能", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "兽魂狂暴雕像", buffName = "虎豹之敏", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "消逝的诅咒", buffName = "濒死诅咒", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "彗星之痕", buffName = "彗星之痕", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "安努尔之书", buffName = "圣歌之力", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "海洋之力", buffName = "台风", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "卡德罗斯的印记", buffName = "非凡战力", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "磁力之镜", buffName = "极化", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "巫术沙漏", buffName = "巫术时刻", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "黑暗潜藏卷须", buffName = "黑暗卷须", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "土灵领主徽记", buffName = "土灵怒火", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "装备探测器", buffName = "侦测到装备！", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "司克诺兹的统御奖章", buffName = "硬化之壳", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "抚慰之心", buffName = "振奋", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "磁力之镜", buffName = "极化", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "海洋之力", buffName = "台风", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "提亚的优雅", buffName = "恩赐", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "拉夏的右眼", buffName = "末日之眼", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "无尽密室之匙", buffName = "终极密钥", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "邪恶命令护符", buffName = "硬化之壳", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "暗月卡片：火山", buffName = "火山毁灭", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "杀戮执照", buffName = "斩杀者", cooldown = 45, lastTrigger = -math.huge, stacks = 10 },
    { trinketName = "青春的躁动", buffName = "胜利之悦", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "穿流之亡", buffName = "死亡之河", cooldown = 45, lastTrigger = -math.huge, stacks = 10 },
    { trinketName = "脓血莓嗅盐", buffName = "精神充沛", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "狂怒之心", buffName = "狂怒之心", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "压顶之力", buffName = "生死极速", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "普瑞斯托的诡计护符", buffName = "邪恶意图", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "雕像 - 野猪之王", buffName = "野猪之王", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "怒炉之怒", buffName = "铸炼怒火", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "缚魂之匣", buffName = "灵魂之力", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "气旋精华", buffName = "扭曲", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "灵魂之恸", buffName = "台风", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "赞达拉英雄护符", buffName = "能量无常", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "消逝的诅咒", buffName = "濒死诅咒", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "蜘蛛的拥抱", buffName = "蜘蛛之拥", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "流放者的日晷", buffName = "就是现在！", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "真实之镜", buffName = "痛苦反射", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "死亡之钟", buffName = "死亡之钟", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "命运之鳞", buffName = "命运之鳞", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "古神之血", buffName = "古神之血", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "蓝铁灌注器", buffName = "蓝铁灌注", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "龙母之眼", buffName = "龙母之眼", cooldown = 45, lastTrigger = -math.huge, stacks = 5 },
    { trinketName = "天堂之焰", buffName = "天堂之焰", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "黑暗物质", buffName = "内爆", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "龙魂图典", buffName = "巨龙之魂", cooldown = 45, lastTrigger = -math.huge, stacks = 10 },
    { trinketName = "天谴之石", buffName = "天谴之石", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "雷神符石", buffName = "雷神符石", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "潘多拉的恳求", buffName = "潘多拉的恳求", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "科林的铬银杯垫", buffName = "痛苦反射", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "秘银怀表", buffName = "就是现在！", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
    { trinketName = "远古卤蛋", buffName = "生命精华", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
        { trinketName = "深渊符文", buffName = "能量动荡", cooldown = 45, lastTrigger = -math.huge, stacks = 0 },
}



-- 初始化变量
shipin13 = 0 -- 饰品槽13的Buff剩余时间
shipin14 = 0 -- 饰品槽14的Buff剩余时间
shipincd13 = 0 -- 饰品槽13的CD剩余时间
shipincd14 = 0 -- 饰品槽14的CD剩余时间
baofa10 = false -- 爆发开关状态<10秒
baofa3 = false -- 爆发开关状态<3秒
baofamax = false -- 爆发直接开
baofa15 = false
-- 创建帧用于事件监听和更新
local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_AURA") -- 监听单位的Buff变化

local lastUpdate = 0
local updateInterval = 0.1  -- 每帧更新的间隔时间
-- 检查饰品是否触发和更新CD
local function checkTrinketActivation(slot)
    local itemLink = GetInventoryItemLink("player", slot)
    if itemLink then
        local itemName = GetItemInfo(itemLink)
        for _, trinket in ipairs(trinketData) do
            if itemName == trinket.trinketName then
                local buffFound = false
                for j = 1, 40 do
                    local buffName, _, count, _, _, expirationTime = UnitBuff("player", j)
                    if type(trinket.buffName) == "table" then
                        for _, name in ipairs(trinket.buffName) do
                            if buffName == name and (trinket.stacks == nil or count >= trinket.stacks) then
                                local currentTime = GetTime()
                                local remainingTime = expirationTime - currentTime
                                if slot == 13 then
                                    shipin13 = remainingTime
                                elseif slot == 14 then
                                    shipin14 = remainingTime
                                end
                                if (currentTime - trinket.lastTrigger) > trinket.cooldown then
                                    trinket.lastTrigger = currentTime
                                end
                                buffFound = true
                                break
                            end
                        end
                    elseif buffName == trinket.buffName and (trinket.stacks == nil or count >= trinket.stacks) then
                        local currentTime = GetTime()
                        local remainingTime = expirationTime - currentTime
                        if slot == 13 then
                            shipin13 = remainingTime
                        elseif slot == 14 then
                            shipin14 = remainingTime
                        end
                        if (currentTime - trinket.lastTrigger) > trinket.cooldown then
                            trinket.lastTrigger = currentTime
                        end
                        buffFound = true
                        break
                    end
                end
                if not buffFound then
                    if slot == 13 then
                        shipin13 = 0
                    elseif slot == 14 then
                        shipin14 = 0
                    end
                end
                local timeSinceLastTrigger = GetTime() - trinket.lastTrigger
                local cooldownRemaining = trinket.cooldown - timeSinceLastTrigger
                if slot == 13 then
                    shipincd13 = max(0, cooldownRemaining)
                elseif slot == 14 then
                    shipincd14 = max(0, cooldownRemaining)
                end
                return -- 找到匹配的饰品后就退出循环
            end
        end
    else
        if slot == 13 then
            shipin13 = 0
            shipincd13 = 0
        elseif slot == 14 then
            shipin14 = 0
            shipincd14 = 0
        end
    end
end


-- 检查饰品状态并决定是否触发爆发
local function checkTrinketsAndTriggerBurst()
    -- 检查是否满足任一饰品触发且剩余时间<=10秒的条件
    baofa10 = (shipin13 > 0 and shipin14 > 0) or (shipin13 > 0 and shipin13 <= 10.5) or (shipin14 > 0 and shipin14 <= 10.5)
    
    -- 检查是否满足任一饰品触发且剩余时间<=3秒的条件
    baofa3 = (shipin13 > 0 and shipin14 > 0) or (shipin13 > 0 and shipin13 <= 3) or (shipin14 > 0 and shipin14 <= 3) or (shipin13>0 and shipincd14>shipin13) or (shipin14>0 and shipincd13>shipin14)
    
    -- 检查是否满足任一饰品触发且剩余时间>10秒的条件
    baofamax = (shipin13 > 0 and shipin14 > 0) or (shipin13 > 7) or (shipin14 > 7 )


    -- 检查是否满足任一饰品触发且剩余时间>15秒的条件
    baofa15 = (shipin13 > 0 and shipin14 > 0) or (shipin13 > 0 and shipin13 <= 15) or (shipin14 > 0 and shipin14 <= 15)
end

-- 使用OnUpdate事件处理函数
frame:SetScript("OnUpdate", function(self, elapsed)
        lastUpdate = lastUpdate + elapsed
        if lastUpdate >= updateInterval then
            checkTrinketActivation(13) -- 检查13号槽
            checkTrinketActivation(14) -- 检查14号槽
            checkTrinketsAndTriggerBurst()
            lastUpdate = 0
        end
end)



