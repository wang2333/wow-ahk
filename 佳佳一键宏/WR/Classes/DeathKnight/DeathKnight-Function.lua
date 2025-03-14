-- 死亡骑士运行库
function WR_DeathKnightFunction()
    DeathKnightTalent = WR_DeathKnight_GetTalent() -- 获取当前天赋

    WR_DeathKnight_COMBAT_LOG_EVENT_UNFILTERED() -- 触发战斗日志事件
    WR_DeathKnight_PLAYER_REGEN_DISABLED() -- 进入战斗事件
    WR_DeathKnight_PLAYER_REGEN_ENABLED() -- 退出战斗事件
    WR_DeathKnight_PLAYER_TARGET_CHANGED() -- 目标切换事件

    if DeathKnightTalent == nil then
        DeathKnightTalent = "邪恶"
    end

    cd1, cd2, cd3, cd4, cd5, cd6, cd7, cd8 = WR_GetDKRunesCooldown()
    ShiFaSuDu = 0.45 -- 施法速度

    WR_Initialize() -- 初始化

    GCD = WR_GetGCD("凋零缠绕") -- 获得当前公共CD

    PlayerMove = WR_PlayerMove() -- 获得自身是否在移动或者空中
    TargetRange = WR_GetUnitRange("target") -- 获得目标距离
    TargetInCombat = WR_TargetInCombat("target") -- 获得目标可以攻击
    RiadOrParty = WR_GetInRiadOrParty() -- 获得当前是否在团队中
    FocusRange = WR_GetUnitRange("focus") -- 获得焦点距离
    HarmCount_10 = WR_GetRangeHarmUnitCount(10) -- 获得10码目标数量

    TargetHP = 1
    if UnitExists("target") then
        TargetHP = UnitHealth("target") / UnitHealthMax("target") -- 获得目标血量比例
    end

    PlayerMP = 1
    if UnitPowerMax("player", Enum.PowerType.Mana) ~= 0 then
        PlayerMP = UnitPower("player", Enum.PowerType.Mana) / UnitPowerMax("player", Enum.PowerType.Mana)
    end

    PlayerHP = 1 -- 获得自身血量比例
    PlayerLostHealth = 0
    if UnitHealthMax("player") ~= 0 then
        PlayerHP = UnitHealth("player") / UnitHealthMax("player") -- 获得自身血量比例
        PlayerLostHealth = UnitHealthMax("player") - UnitHealth("player") -- 玩家损失血量
    end

    Energy = UnitPower("player", 6) -- 能量

    if WR_FirstFunction() then
        return true
    end

    -- 施法过程 攻击
    if WR_DeathKnight_Function_GJ() then
        return true
    end

    -- 公共冷却 及 施法判断
    if GCD > ShiFaSuDu -- 公共冷却剩余时间>施法速度设定时间
    or UnitCastingInfo("player") ~= nil -- 正在施法
    then
        WR_HideColorFrame(0) -- 隐藏左上色块窗体
        WR_HideColorFrame(1) -- 隐藏右上色块窗体
        return true
    end

    if WRSet.XE_BF == 1 then
        aura_env.config.bfkg = true
    else
        aura_env.config.bfkg = false
    end

    if WRSet.XE_AOE == 1 then
        aura_env.msqh = 'zd'
    elseif WRSet.XE_AOE == 2 then
        aura_env.msqh = 'dt'
    elseif WRSet.XE_AOE == 3 then
        aura_env.msqh = 'qt'
    end

    if WRSet.XE_GJ == 1 then
        local freeSpace = WR_GetBagFreeSpace()
        if freeSpace <= 1 then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("AF4", '背包不足1格', zhandoumoshi) -- 显示指定色块窗体
            return true
        end

        if not WR_IsInUnholyPresence('鲜血灵气') then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("SF12", '鲜血灵气', zhandoumoshi)
            return true
        end

        if UnitIsDead("target") -- 目标存活 --
        or not UnitExists("target") --
        or not UnitCanAttack("player", "target") -- 目标可攻击
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("F11", 'F11', zhandoumoshi) -- 显示指定色块窗体
            return true
        end

        if WR_SpellUsable("死亡之握") --
        and WR_GetUnitRange('target') > 3 --
        and WR_GetUnitRange('target') <= 30 --
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("ASF2", '死亡之握', zhandoumoshi) -- 显示指定色块窗体
            return true
        end

        if PlayerHP <= 0.7 then
            if WR_SpellUsable("反魔法护罩") then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("ASF1", '反魔法护罩', zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            if not UnitExists("pet") --
            and WR_SpellUsable("亡者复生") --
            then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("SF3", '亡者复生', zhandoumoshi) -- 显示指定色块窗体
                return true
            end
            if WR_SpellUsable("天灾契约") then
                WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
                WR_ShowColorFrame("ASF5", '天灾契约', zhandoumoshi) -- 显示指定色块窗体
                return true
            end
        end
    end

    SpellValue = {}

    if DeathKnightTalent == "邪恶" then
        WR_DeathKnight_WA_Trigger2() -- 检测buff状态
        WR_DeathKnight_WA_Trigger7() -- 检测场景
        WR_DeathKnight_WA_Trigger8() -- 检测技能
        WR_DeathKnight_WA_Trigger9() -- 检测技能
        WR_DeathKnight_ScanEvents()
        return true
    end

    if DeathKnightTalent == "冰霜" then
        if WRSet.XE_GJ == 1 then
            WR_DeathKnight_BDK_GJ()
        else
            WR_DeathKnight_BDK()
        end
        return true
    end

    WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体

end

-- 判断SpellValue中是否包含某个数字的函数
function HasValue(value)
    for _, v in ipairs(SpellValue) do
        if v == value then
            return true
        end
    end
    return false
end

function WR_DeathKnight_ScanEvents(status, ...)
    -- 施法过程 亡者复生
    if not UnitExists("pet") --
    and WR_SpellUsable("亡者复生") --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF3", '亡者复生', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if not TargetInCombat -- 单位在战斗
    or not UnitCanAttack("player", "target") -- 目标可攻击
    or UnitIsDead("target") -- 目标存活
    or WR_GetUnitRange('target') > 20 -- 目标距离大于20码
    then
        return true
    end

    -- [1,8,5,18,19,9,12],[2,11,14,16],[3,15,10,13],[4],[7,6]
    -- SPELL_1_READY_XEDK 冰冷触摸
    -- SPELL_2_READY_XEDK 暗影打击
    -- SPELL_3_READY_XEDK 鲜血打击
    -- SPELL_4_READY_XEDK 枯萎凋零
    -- SPELL_5_READY_XEDK 符文武器增效
    -- SPELL_6_READY_XEDK 寒冬号角
    -- SPELL_7_READY_XEDK 凋零缠绕
    -- SPELL_8_READY_XEDK 亡者大军
    -- SPELL_9_READY_XEDK 召唤石像鬼
    -- SPELL_10_READY_XEDK 血液沸腾
    -- SPELL_11_READY_XEDK 食尸鬼狂乱
    -- SPELL_12_READY_XEDK 活力分流
    -- SPELL_13_READY_XEDK 鲜血灵气
    -- SPELL_14_READY_XEDK 白骨之盾
    -- SPELL_15_READY_XEDK 传染
    -- SPELL_16_READY_XEDK 邪恶灵气
    -- SPELL_17_READY_XEDK
    -- SPELL_18_READY_XEDK 黑魔法武器
    -- SPELL_19_READY_XEDK 十字军武器
    -- SPELL_22_READY_XEDK 天灾打击

    WR_HideColorFrame(zhandoumoshi)

    if WRSet.XE_GJ == 1 and HasValue(4) and WR_SpellUsable("枯萎凋零") then
        if WRSet.XE_DL == 1 and WR_GetUnitRange('target') <= 3 then
            WR_ShowColorFrame("CF7", '枯萎凋零', zhandoumoshi)
        elseif WR_GetUnitRange('target') <= 30 then
            WR_ShowColorFrame("CF8", '枯萎凋零', zhandoumoshi)
        end
        return true
    end

    if HasValue(12) then
        WR_ShowColorFrame("SF9", '活力分流', zhandoumoshi)
        return true
    elseif HasValue(9) then
        WR_ShowColorFrame("SF1", '召唤石像鬼', zhandoumoshi)
        return true
    elseif HasValue(19) then
        WR_ShowColorFrame("ASF3", '十字军武器', zhandoumoshi)
        return true
    elseif HasValue(18) then
        WR_ShowColorFrame("ASF4", '黑魔法武器', zhandoumoshi)
        return true
    elseif HasValue(5) then
        WR_ShowColorFrame("SF7", '符文武器增效', zhandoumoshi)
        return true
    elseif HasValue(8) then
        WR_ShowColorFrame("SF2", '亡者大军', zhandoumoshi)
        return true
    elseif HasValue(1) and WR_GetUnitRange('target') <= 20 then
        WR_ShowColorFrame("CF1", '冰冷触摸', zhandoumoshi)
        return true
    elseif HasValue(22) then
        WR_ShowColorFrame("SF4", '天灾打击', zhandoumoshi)
        return true
    end

    if HasValue(16) then
        WR_ShowColorFrame("SF11", '邪恶灵气', zhandoumoshi)
        return true
    elseif HasValue(14) then
        WR_ShowColorFrame("SF5", '白骨之盾', zhandoumoshi)
        return true
    elseif HasValue(2) and WR_GetUnitRange('target') <= 3 then
        WR_ShowColorFrame("CF2", '暗影打击', zhandoumoshi)
        return true
    elseif HasValue(11) then
        WR_ShowColorFrame("CF5", '食尸鬼狂乱', zhandoumoshi)
        return true
    end

    if HasValue(13) then
        WR_ShowColorFrame("SF12", '鲜血灵气', zhandoumoshi)
        return true
    elseif HasValue(15) and WR_GetUnitRange('target') <= 3 then
        WR_ShowColorFrame("SF10", '传染', zhandoumoshi)
        return true
    elseif HasValue(3) and WR_GetUnitRange('target') <= 3 then
        WR_ShowColorFrame("CF3", '鲜血打击', zhandoumoshi)
        return true
    elseif HasValue(10) and WR_GetUnitRange('target') <= 10 then
        WR_ShowColorFrame("CF6", '血液沸腾', zhandoumoshi)
        return true
    end

    if HasValue(4) and WR_SpellUsable("枯萎凋零") then
        if WRSet.XE_DL == 1 and WR_GetUnitRange('target') <= 3 then
            WR_ShowColorFrame("CF7", '枯萎凋零', zhandoumoshi)
        elseif WR_GetUnitRange('target') <= 30 then
            WR_ShowColorFrame("CF8", '枯萎凋零', zhandoumoshi)
        end
        return true
    end

    if HasValue(7) and WR_GetUnitRange('target') <= 30 then
        WR_ShowColorFrame("CF9", '凋零缠绕', zhandoumoshi)
        return true
    elseif HasValue(6) then
        WR_ShowColorFrame("SF6", '寒冬号角', zhandoumoshi)
        return true
    end

    return true
end

-- 施法过程 冰霜DK
function WR_DeathKnight_BDK_GJ()
    if WR_GetUnitBuffInfo("player", "寒冬号角") == 0 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF6", '寒冬号角', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    local flag1 = (cd3 <= 1 or cd4 <= 1) and (cd5 <= 1 or cd6 <= 1) -- 冰邪符文
    local flag2 = cd7 ~= nil and cd8 ~= nil and cd7 == 0 and cd8 == 0 -- 双死亡符文

    if (flag1 or flag2) --
    and TargetRange < 3 --
    then
        if HarmCount_10 >= 2 and WR_SpellUsable("凛风冲击") then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF12", '凛风冲击', zhandoumoshi) -- 显示指定色块窗体
            return true
        else
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF10", '湮没', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    end

    if (cd7 == 0 or cd8 == 0) -- 消耗死亡符文
    and WR_SpellUsable("铜墙铁壁") -- 技能可用 资源可用
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF8", '铜墙铁壁', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if (cd7 ~= nil and cd8 ~= nil and (cd7 == 0 or cd8 == 0)) -- 消耗死亡符文
    and WR_SpellUsable("活力分流") -- 技能可用 资源可用
    and WR_GetUnitBuffInfo("player", "铜墙铁壁") > 0 --  BUFF存在
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF9", '活力分流', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_SpellUsable("符文武器增效") -- 技能可用 资源可用
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF7", '符文武器增效', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_GetUnitBuffInfo("player", "杀戮机器") > 0 --
    and HarmCount_10 == 1 --
    and WR_SpellUsable("冰霜打击") -- 技能可用 资源可用
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF11", '冰霜打击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_GetUnitBuffInfo("player", "冰冻之雾") > 0 --
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF12", '凛风冲击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_SpellUsable("冰霜打击") -- 技能可用 资源可用
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF11", '冰霜打击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if HarmCount_10 == 1 --
    then
        if WR_SpellUsable("鲜血打击") -- 技能可用 资源可用
        and TargetRange < 3 --
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF3", '鲜血打击', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    else
        if WR_SpellUsable("血液沸腾") -- 技能可用 资源可用
        and TargetRange < 3 --
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF6", '血液沸腾', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    end

    if WR_SpellUsable("寒冬号角") -- 技能可用 资源可用
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF6", '寒冬号角', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

end

-- 施法过程 冰霜DK
function WR_DeathKnight_BDK()
    local IsJbLown = WR_GetUnitDebuffInfo("target", "冰霜疫病", true) <= 7 or
                         WR_GetUnitDebuffInfo("target", "血之疫病", true) <= 7

    local IsJbHigh = WR_GetUnitDebuffInfo("target", "冰霜疫病", true) >= 11 and
                         WR_GetUnitDebuffInfo("target", "血之疫病", true) >= 11

    if WRSet.XE_AOE == 1 --
    and WR_GetGCD("枯萎凋零") <= 3 --
    and TargetRange < 30 --
    then
        if (((cd1 ~= nil and cd1 <= 3) or (cd2 ~= nil and cd2 <= 3)) or
            ((cd7 ~= nil and cd7 <= 3) or (cd8 ~= nil and cd8 <= 3))) --
        and (cd3 <= 3 or cd4 <= 3) and (cd5 <= 3 or cd6 <= 3) --
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF8", '枯萎凋零', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    end

    if WR_GetUnitBuffInfo("player", "反魔法护罩") > 0 --
    and WR_GetUnitDebuffInfo("target", "冰霜疫病", true) >= 5 --
    and WR_GetUnitDebuffInfo("target", "血之疫病", true) >= 5 --
    and Energy >= 40 --
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF11", '冰霜打击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_GetUnitDebuffInfo("target", "冰霜疫病", true) == 0 -- 目标 冰霜疫病
    and WR_SpellUsable("冰冷触摸") --
    and TargetRange < 20 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF1", '冰冷触摸', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_GetUnitDebuffInfo("target", "血之疫病", true) == 0 -- 目标 血之疫病
    and WR_SpellUsable("暗影打击") --
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF2", '暗影打击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    local flag1 = (cd3 <= 1 or cd4 <= 1) and (cd5 <= 1 or cd6 <= 1) -- 冰邪符文
    local flag2 = cd7 ~= nil and cd8 ~= nil and cd7 == 0 and cd8 == 0 -- 双死亡符文
    and WR_GetUnitDebuffInfo("target", "冰霜疫病", true) >= 10 --
    and WR_GetUnitDebuffInfo("target", "血之疫病", true) >= 10 --

    if (flag1 or flag2) --
    and TargetRange < 3 --
    and WR_GetUnitDebuffInfo("target", "冰霜疫病", true) >= 0 --
    and WR_GetUnitDebuffInfo("target", "血之疫病", true) >= 0 --
    then
        if HarmCount_10 >= 2 and WR_SpellUsable("凛风冲击") then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF12", '凛风冲击', zhandoumoshi) -- 显示指定色块窗体
            return true
        else
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF10", '湮没', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    end

    if (cd7 == 0 or cd8 == 0) -- 消耗死亡符文
    and WR_SpellUsable("铜墙铁壁") -- 技能可用 资源可用
    and IsJbLown --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF8", '铜墙铁壁', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    local CY_flag = ((cd1 ~= nil or cd2 ~= nil) and WR_GetUnitDebuffInfo("target", "冰霜疫病", true) < 10 and cd7 ~=
                        0 and cd8 ~= 0)
    if (CY_flag or IsJbLown) --
    and WR_SpellUsable("传染") -- 技能可用 资源可用
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF10", '传染', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if (cd7 ~= nil and cd8 ~= nil and (cd7 == 0 or cd8 == 0)) -- 消耗死亡符文
    and WR_SpellUsable("活力分流") -- 技能可用 资源可用
    and WR_GetUnitBuffInfo("player", "铜墙铁壁") > 0 --  BUFF存在
    and IsJbHigh --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF9", '活力分流', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_SpellUsable("符文武器增效") -- 技能可用 资源可用
    and zhandoumoshi == 1 -- 战斗模式
    and cd1 == nil and cd2 == nil and cd3 >= 1 and cd4 >= 1 and cd5 >= 1 and cd6 >= 1 and cd7 >= 0 and cd8 >= 0 --
    and WR_GetUnitDebuffInfo("target", "冰霜疫病", true) >= 11 --
    and WR_GetUnitDebuffInfo("target", "血之疫病", true) >= 11 --
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF7", '符文武器增效', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_GetUnitBuffInfo("player", "杀戮机器") > 0 --
    and HarmCount_10 < 3 --
    and WR_SpellUsable("冰霜打击") -- 技能可用 资源可用
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF11", '冰霜打击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_GetUnitBuffInfo("player", "冰冻之雾") > 0 --
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF12", '凛风冲击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if zhandoumoshi == 1 --
    and WR_SpellUsable("亡者复生") -- 技能可用 资源可用
    and WR_GetUnitBuffInfo("player", "不洁之力") > 0 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF3", '亡者复生', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WR_SpellUsable("冰霜打击") -- 技能可用 资源可用
    and TargetRange < 3 --
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("CF11", '冰霜打击', zhandoumoshi) -- 显示指定色块窗体
        return true
    end

    if WRSet.XE_AOE == 1 --
    and IsJbHigh --
    and TargetRange < 3 --
    then
        if WR_GetUnitBuffInfo("player", "铜墙铁壁") > 0 and WR_SpellUsable("活力分流") then
            return false
        end
        if WR_SpellUsable("血液沸腾") -- 技能可用 资源可用
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF6", '血液沸腾', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    else
        if WR_GetUnitBuffInfo("player", "铜墙铁壁") > 0 and WR_SpellUsable("活力分流") then
            return false
        end
        if WR_SpellUsable("鲜血打击") -- 技能可用 资源可用
        then
            WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
            WR_ShowColorFrame("CF3", '鲜血打击', zhandoumoshi) -- 显示指定色块窗体
            return true
        end
    end

    if WR_SpellUsable("寒冬号角") -- 技能可用 资源可用
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("SF6", '寒冬号角', zhandoumoshi) -- 显示指定色块窗体
        return true
    end
end

-- 施法过程 攻击
function WR_DeathKnight_Function_GJ()
    if not IsCurrentSpell("攻击") -- 没在 攻击
    and TargetRange <= 5 -- 单位距离
    and TargetInCombat -- 目标可攻击
    and not UnitIsDeadOrGhost("target") -- 单位没有死亡
    and not IsMounted() -- 不在坐骑上
    then
        WR_HideColorFrame(zhandoumoshi) -- 隐藏指定色块窗体
        WR_ShowColorFrame("ACN9", "攻击", zhandoumoshi) -- 显示指定色块窗体
        return true
    end
    return false
end

-- 战斗日志事件
function WR_DeathKnight_COMBAT_LOG_EVENT_UNFILTERED()
    if WR_DeathKnight_COMBAT_LOG_EVENT_UNFILTERED_OPEN == true then
        return
    end
    local TempFrame = CreateFrame("Frame")
    TempFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    TempFrame:SetScript("OnEvent", function()
        WR_DeathKnight_WA_Trigger5()
        WR_DeathKnight_WA_Trigger6_1()
    end)
    WR_DeathKnight_COMBAT_LOG_EVENT_UNFILTERED_OPEN = true
end

-- 进入战斗事件
function WR_DeathKnight_PLAYER_REGEN_DISABLED()
    if WR_DeathKnight_PLAYER_REGEN_DISABLED_OPEN == true then
        return
    end
    local TempFrame = CreateFrame("Frame")
    TempFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    TempFrame:SetScript("OnEvent", function()
        WR_DeathKnight_WA_Trigger6_2()
    end)
    WR_DeathKnight_PLAYER_REGEN_DISABLED_OPEN = true
end

-- 退出战斗事件
function WR_DeathKnight_PLAYER_REGEN_ENABLED()
    if WR_DeathKnight_PLAYER_REGEN_ENABLED_OPEN == true then
        return
    end
    local TempFrame = CreateFrame("Frame")
    TempFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    TempFrame:SetScript("OnEvent", function()
        WR_DeathKnight_WA_Trigger6_3()
    end)
    WR_DeathKnight_PLAYER_REGEN_ENABLED_OPEN = true

end

-- 目标切换事件
function WR_DeathKnight_PLAYER_TARGET_CHANGED()
    if WR_DeathKnight_PLAYER_TARGET_CHANGED_OPEN == true then
        return
    end
    local TempFrame = CreateFrame("Frame")
    TempFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
    TempFrame:SetScript("OnEvent", function()
        WR_DeathKnight_WA_Trigger6_4()
    end)
    WR_DeathKnight_PLAYER_TARGET_CHANGED_OPEN = true
end
