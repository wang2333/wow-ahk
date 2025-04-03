-- 初始化职业宏
function WR_DeathKnightCreateMacroButton()
    WR_CreateMacroButton("CSF1", "CTRL-SHIFT-F1", "/focus party1") -- 焦点 队友1
    WR_CreateMacroButton("CSF2", "CTRL-SHIFT-F2", "/focus party2") -- 焦点 队友2
    WR_CreateMacroButton("CSF3", "CTRL-SHIFT-F3", "/focus party3") -- 焦点 队友3
    WR_CreateMacroButton("CSF4", "CTRL-SHIFT-F4", "/focus party4") -- 焦点 队友4
    WR_CreateMacroButton("CSF5", "CTRL-SHIFT-F5", "/focus player") -- 焦点 自己
    WR_CreateMacroButton("CSF6", "CTRL-SHIFT-F6", "/focus raid21") -- 焦点 团队21
    WR_CreateMacroButton("CSF7", "CTRL-SHIFT-F7", "/focus raid22") -- 焦点 团队22
    WR_CreateMacroButton("CSF8", "CTRL-SHIFT-F8", "/focus raid23") -- 焦点 团队23
    WR_CreateMacroButton("CSF9", "CTRL-SHIFT-F9", "/focus raid24") -- 焦点 团队24	--哔哩哔哩直播姬
    WR_CreateMacroButton("CSF10", "CTRL-SHIFT-F10", "/focus raid25") -- 焦点 团队25	--哔哩哔哩直播姬
    WR_CreateMacroButton("CSF11", "CTRL-SHIFT-F11", "/focus mouseover") -- 焦点 指向
    WR_CreateMacroButton("CSF12", "CTRL-SHIFT-F12", "/focus target") -- 焦点 目标

    WR_CreateMacroButton("AF1", "ALT-F1", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF2", "ALT-F2", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF3", "ALT-F3", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF5", "ALT-F5", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF6", "ALT-F6", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF7", "ALT-F7", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF8", "ALT-F8", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF9", "ALT-F9", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF10", "ALT-F10", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF11", "ALT-F11", "") -- Nvidia内覆盖
    WR_CreateMacroButton("AF12", "ALT-F12", "") -- Nvidia内覆盖

    WR_CreateMacroButton("AN1", "ALT-NUMPAD1", "/focus raid1") -- 焦点 团队1
    WR_CreateMacroButton("AN2", "ALT-NUMPAD2", "/focus raid2") -- 焦点 团队2
    WR_CreateMacroButton("AN3", "ALT-NUMPAD3", "/focus raid3") -- 焦点 团队3
    WR_CreateMacroButton("AN4", "ALT-NUMPAD4", "/focus raid4") -- 焦点 团队4
    WR_CreateMacroButton("AN5", "ALT-NUMPAD5", "/focus raid5") -- 焦点 团队5
    WR_CreateMacroButton("AN6", "ALT-NUMPAD6", "/focus raid6") -- 焦点 团队6
    WR_CreateMacroButton("AN7", "ALT-NUMPAD7", "/focus raid7") -- 焦点 团队7
    WR_CreateMacroButton("AN8", "ALT-NUMPAD8", "/focus raid8") -- 焦点 团队8
    WR_CreateMacroButton("AN9", "ALT-NUMPAD9", "/focus raid9") -- 焦点 团队9
    WR_CreateMacroButton("AN0", "ALT-NUMPAD0", "/focus raid10") -- 焦点 团队10
    WR_CreateMacroButton("CN1", "CTRL-NUMPAD1", "/focus raid11") -- 焦点 团队11
    WR_CreateMacroButton("CN2", "CTRL-NUMPAD2", "/focus raid12") -- 焦点 团队12
    WR_CreateMacroButton("CN3", "CTRL-NUMPAD3", "/focus raid13") -- 焦点 团队13
    WR_CreateMacroButton("CN4", "CTRL-NUMPAD4", "/focus raid14") -- 焦点 团队14
    WR_CreateMacroButton("CN5", "CTRL-NUMPAD5", "/focus raid15") -- 焦点 团队15
    WR_CreateMacroButton("CN6", "CTRL-NUMPAD6", "/focus raid16") -- 焦点 团队16
    WR_CreateMacroButton("CN7", "CTRL-NUMPAD7", "/focus raid17") -- 焦点 团队17
    WR_CreateMacroButton("CN8", "CTRL-NUMPAD8", "/focus raid18") -- 焦点 团队18
    WR_CreateMacroButton("CN9", "CTRL-NUMPAD9", "/focus raid19") -- 焦点 团队19
    WR_CreateMacroButton("CN0", "CTRL-NUMPAD0", "/focus raid20") -- 焦点 团队20

    WR_CreateMacroButton("CF1", "CTRL-F1",
        "/cast 冰冷触摸\n/petattack [target=镜像]\n/petattack [target=裹体之网]")
    WR_CreateMacroButton("CF2", "CTRL-F2", "/cast 暗影打击")
    WR_CreateMacroButton("CF3", "CTRL-F3", "/cast 鲜血打击")
    -- WR_CreateMacroButton("CF4", "CTRL-F4", "/cast 传染")
    WR_CreateMacroButton("CF5", "CTRL-F5", "/cast 食尸鬼狂乱")
    WR_CreateMacroButton("CF6", "CTRL-F6", "/cast 血液沸腾")
    WR_CreateMacroButton("CF7", "CTRL-F7", "/cast [@player]枯萎凋零")
    WR_CreateMacroButton("CF8", "CTRL-F8", "/cast [@cursor]枯萎凋零")
    WR_CreateMacroButton("CF9", "CTRL-F9", "/cast 凋零缠绕")
    WR_CreateMacroButton("CF10", "CTRL-F10", "/cast 湮没")
    WR_CreateMacroButton("CF11", "CTRL-F11", "/cast 冰霜打击")
    WR_CreateMacroButton("CF12", "CTRL-F12", "/cast 凛风冲击")

    WR_CreateMacroButton("SF1", "SHIFT-F1", "/use 13\n/use 14\n/cast 召唤石像鬼")
    WR_CreateMacroButton("SF2", "SHIFT-F2", "/use 13\n/use 14\n/cast 亡者大军")
    WR_CreateMacroButton("SF3", "SHIFT-F3", "/cast 亡者复生")
    WR_CreateMacroButton("SF4", "SHIFT-F4", "/cast 天灾打击")
    WR_CreateMacroButton("SF5", "SHIFT-F5", "/cast 白骨之盾")
    WR_CreateMacroButton("SF6", "SHIFT-F6", "/cast 寒冬号角")
    WR_CreateMacroButton("SF7", "SHIFT-F7", "/cast 符文武器增效")
    WR_CreateMacroButton("SF8", "SHIFT-F8", "/use 13\n/use 14\n/cast 铜墙铁壁")
    WR_CreateMacroButton("SF9", "SHIFT-F9", "/cast 活力分流")
    WR_CreateMacroButton("SF10", "SHIFT-F10", "/cast 传染")
    WR_CreateMacroButton("SF11", "SHIFT-F11", "/cast 邪恶灵气")
    WR_CreateMacroButton("SF12", "SHIFT-F12", "/cast 鲜血灵气")

    WR_CreateMacroButton("ACN1", "ALT-CTRL-NUMPAD1", "")
    WR_CreateMacroButton("ACN2", "ALT-CTRL-NUMPAD2", "")
    WR_CreateMacroButton("ACN3", "ALT-CTRL-NUMPAD3", "")
    WR_CreateMacroButton("ACN4", "ALT-CTRL-NUMPAD4", "")
    WR_CreateMacroButton("ACN5", "ALT-CTRL-NUMPAD5", "")
    WR_CreateMacroButton("ACN6", "ALT-CTRL-NUMPAD6", "")
    WR_CreateMacroButton("ACN7", "ALT-CTRL-NUMPAD7", "")
    WR_CreateMacroButton("ACN8", "ALT-CTRL-NUMPAD8", "")
    WR_CreateMacroButton("ACN9", "ALT-CTRL-NUMPAD9", "/startattack")
    WR_CreateMacroButton("ACN0", "ALT-CTRL-NUMPAD0", "/stopcasting")

    WR_CreateMacroButton("CSP", "CTRL-SHIFT-P", "") -- 会在非战斗中改变坦克单位
    WR_CreateMacroButton("CSL", "CTRL-SHIFT-L", "")
    WR_CreateMacroButton("CSO", "CTRL-SHIFT-O", "")
    WR_CreateMacroButton("CSK", "CTRL-SHIFT-K", "")
    WR_CreateMacroButton("CSM", "CTRL-SHIFT-M", "")
    WR_CreateMacroButton("CSI", "CTRL-SHIFT-I", "")
    WR_CreateMacroButton("CSJ", "CTRL-SHIFT-J", "")
    WR_CreateMacroButton("CSN", "CTRL-SHIFT-N", "")
    WR_CreateMacroButton("CSU", "CTRL-SHIFT-U", "")
    WR_CreateMacroButton("CSH", "CTRL-SHIFT-H", "")
    WR_CreateMacroButton("CSB", "CTRL-SHIFT-B", "")
    WR_CreateMacroButton("CSY", "CTRL-SHIFT-Y", "")
    WR_CreateMacroButton("CSG", "CTRL-SHIFT-G", "")
    WR_CreateMacroButton("CSV", "CTRL-SHIFT-V",
        "/run zhandoumoshi=0\n/console findYourselfAnywhere 1\n/console findYourselfAnywhereOnlyInCombat 0\n/console secureAbilityToggle 1\n/console SpellQueueWindow 400\n/console doNotFlashLowHealthWarning 1")
    WR_CreateMacroButton("CST", "CTRL-SHIFT-T", "")
    WR_CreateMacroButton("CSF", "CTRL-SHIFT-F", "")
    WR_CreateMacroButton("CSC", "CTRL-SHIFT-C",
        "/run zhandoumoshi=1\n/console findYourselfAnywhere 1\n/console findYourselfAnywhereOnlyInCombat 0\n/console secureAbilityToggle 1\n/console SpellQueueWindow 400\n/console doNotFlashLowHealthWarning 1")
    WR_CreateMacroButton("CSX", "CTRL-SHIFT-X", "")
    WR_CreateMacroButton("CSZ", "CTRL-SHIFT-Z", "")

    WR_CreateMacroButton("ASF1", "ALT-SHIFT-F1", "/cast 反魔法护罩")
    WR_CreateMacroButton("ASF2", "ALT-SHIFT-F2", "/cast 死亡之握")
    WR_CreateMacroButton("ASF3", "ALT-SHIFT-F3", "/equip 乌米尔，北地的风暴")
    WR_CreateMacroButton("ASF4", "ALT-SHIFT-F3", "/equip 恐怖酒杯")
    WR_CreateMacroButton("ASF5", "ALT-SHIFT-F5", "/cast 天灾契约")
    WR_CreateMacroButton("ASF6", "ALT-SHIFT-F6", "")
    WR_CreateMacroButton("ASF7", "ALT-SHIFT-F7", "")
    WR_CreateMacroButton("ASF8", "ALT-SHIFT-F8", "")
    WR_CreateMacroButton("ASF9", "ALT-SHIFT-F9", "")
    WR_CreateMacroButton("ASF10", "ALT-SHIFT-F10", "") -- Nvidia内覆盖
    WR_CreateMacroButton("ASF11", "ALT-SHIFT-F11", "") -- 网吧问题
    WR_CreateMacroButton("ASF12", "ALT-SHIFT-F12", "")

    WR_CreateMacroButton("ACF1", "ALT-CTRL-F1", "")
    WR_CreateMacroButton("ACF2", "ALT-CTRL-F2", "")
    WR_CreateMacroButton("ACF3", "ALT-CTRL-F3", "")
    WR_CreateMacroButton("ACF5", "ALT-CTRL-F5", "")
    WR_CreateMacroButton("ACF6", "ALT-CTRL-F6", "")
    WR_CreateMacroButton("ACF7", "ALT-CTRL-F7", "")
    WR_CreateMacroButton("ACF8", "ALT-CTRL-F8", "") -- intel核心显卡的驱动程序软件
    WR_CreateMacroButton("ACF9", "ALT-CTRL-F9", "")
    WR_CreateMacroButton("ACF10", "ALT-CTRL-F10", "")
    WR_CreateMacroButton("ACF11", "ALT-CTRL-F11", "") -- intel核心显卡的驱动程序软件
    WR_CreateMacroButton("ACF12", "ALT-CTRL-F12", "") -- intel核心显卡的驱动程序软件

    WR_CreateMacroButton("ACSF1", "ALT-CTRL-SHIFT-F1", "")
    WR_CreateMacroButton("ACSF2", "ALT-CTRL-SHIFT-F2", "")
    WR_CreateMacroButton("ACSF3", "ALT-CTRL-SHIFT-F3", "")
    WR_CreateMacroButton("ACSF5", "ALT-CTRL-SHIFT-F5", "")
    WR_CreateMacroButton("ACSF6", "ALT-CTRL-SHIFT-F6", "")
    WR_CreateMacroButton("ACSF7", "ALT-CTRL-SHIFT-F7", "")
    WR_CreateMacroButton("ACSF8", "ALT-CTRL-SHIFT-F8", "")
    WR_CreateMacroButton("ACSF9", "ALT-CTRL-SHIFT-F9", "")
    WR_CreateMacroButton("ACSF10", "ALT-CTRL-SHIFT-F10", "")
    WR_CreateMacroButton("ACSF11", "ALT-CTRL-SHIFT-F11", "") -- 网吧问题
    WR_CreateMacroButton("ACSF12", "ALT-CTRL-SHIFT-F12", "")

    WR_CreateMacroButton("F5", "F5", "")
    WR_CreateMacroButton("F6", "F6", "")
    WR_CreateMacroButton("F7", "F7", "")
    WR_CreateMacroButton("F8", "F8", "")
    WR_CreateMacroButton("F9", "F9", "/cleartarget\n/target 废物贩卖机器人\n/use 废物贩卖机器人制造器")
    WR_CreateMacroButton("F10", "F10", "")
    WR_CreateMacroButton("F11", "F11", "/cleartarget\n/targetenemy\n/startattack\n/run Pig_DelItem()")
    WR_CreateMacroButton("F12", "F12", "/cleartarget\n/targetenemy\n/cast 死亡之握")

    if not WR_CreateMacroButtonInfo then
        print("|cff00ff00----------------------------------------")
        print(WR_CreateMacroButtonIsOK)
        print("当前职业：|cff00adf0死亡骑士")
        print("|cff00ff00----------------------------------------")
        WR_CreateMacroButtonInfo = true
    end
end

if UnitClassBase("player") == "DEATHKNIGHT"  then
    WR_DeathKnightCreateMacroButton() -- 初始化
end
