-- 初始化变量
zxfangadd = false
jdfangadd = false
fangadd = false

-- 特定目标列表
local specificTargets = {
    "精兵的训练假人", "黑锋骑士的训练假人", "新兵的训练假人", 
    "学徒的训练假人", "大领主的复仇之神训练假人", "骨刺", "破天号巫师", 
    "库卡隆战斗法师", "镇压者", "团队副本训练假人", "训练假人", 
    "裹体之网", "无面者工兵", "厄祖玛特", "被俘获的狮鹫", "水泡", 
    "詹姆斯·哈林顿", "黑曜石火翼龙","混沌传送门","陈猪猪","岩孔虫",
    "逃跑的金加塔尔深水猎手","被遗弃的攻城坦克","熔吼","熔喉暴露的头部",
    "暮光哨兵","暮光恶魔","火元素","暗影领主","脉动的暮光之卵","艾卓曼德斯",
    "专家的训练假人","大师的训练假人","英雄训练假人","宗师的训练假人",
    "大领主的训练假人","黑锋骑士的训练假人","能量火花",
    "冰冻核心","拆解者之心","尤格-萨隆的大脑","冰冻废土的士兵","织魂者",
    "快速冻结","生命火花","圣所警卫","野性防御者","强化钢铁根须","爆炸鞭笞者","艾欧娜尔的礼物","巨兽防御炮台","充能之球",
    "紧急灭火机器人","感应触须","冰喉","雪地狗头人奴隶","穿刺者戈莫克","冰吼","酸喉","恐鳞","加拉克苏斯大王","暮光志愿者","冰霜之球",
    "地狱火山","虚空传送门",

}

-- 检查指向目标是否为特定目标
local function updateZxfangaddForMouseover()
    local targetName = UnitName("mouseover")
    zxfangadd = false  -- 默认设置为 false
    if targetName then
        for _, name in ipairs(specificTargets) do
            if targetName == name then
                zxfangadd = true  -- 如果目标在列表中，设置为 true
                break
            end
        end
    end
end

-- 检查焦点目标是否为特定目标
local function updateJdfangaddForFocus()
    local targetName = UnitName("focus")
    jdfangadd = false  -- 默认设置为 false
    if targetName then
        for _, name in ipairs(specificTargets) do
            if targetName == name then
                jdfangadd = true  -- 如果目标在列表中，设置为 true
                break
            end
        end
    end
end

-- 检查当前目标是否为特定目标
local function updateFangadd()
    local targetName = UnitName("target")
    fangadd = false  -- 默认设置为 false
    if targetName then
        for _, name in ipairs(specificTargets) do
            if targetName == name then
                fangadd = true  -- 如果目标在列表中，设置为 true
                break
            end
        end
    end
end

-- 创建一个框架用于监听事件
local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")  -- 指向目标变更事件
frame:RegisterEvent("PLAYER_FOCUS_CHANGED")  -- 焦点目标变更事件
frame:RegisterEvent("PLAYER_TARGET_CHANGED")  -- 目标变更事件
frame:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_MOUSEOVER_UNIT" then
            updateZxfangaddForMouseover()  -- 调用函数更新 zxfangadd
        elseif event == "PLAYER_FOCUS_CHANGED" then
            updateJdfangaddForFocus()  -- 调用函数更新 jdfangadd
        elseif event == "PLAYER_TARGET_CHANGED" then
            updateFangadd()  -- 调用函数更新 fangadd
        end
end)
