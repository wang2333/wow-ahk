local bit = bit32
raidMemberTargetUnitStr = {}
for i = 1, 25 do
    raidMemberTargetUnitStr[i] = "raid" .. i .. "target";
end
raidMemberTargetUnitStr[26] = "party1target";
raidMemberTargetUnitStr[27] = "party2target";
raidMemberTargetUnitStr[28] = "party3target";
raidMemberTargetUnitStr[29] = "party4target";
eventName1 = "onListChange";
eventName2 = "onMapChange";
actInner = "acti";
myweapon = "00c7"
seed = "blade00c7"

local baseColor = 0
function getColor()
    local color = {}
    local r = bit.band(baseColor, 0x000000FF)
    local g = bit.band(baseColor, 0x0000FF00)
    g = bit.rshift(g, 8)
    local b = bit.band(baseColor, 0x00FF0000)
    b = bit.rshift(b, 16)
    baseColor = baseColor + 10
    color.r = r / 255
    color.g = g / 255
    color.b = b / 255
    return color
end
actionList = {{"na", false}, {"cd", false}, {"casting", false}, {"stopCasting", false}, {"burst1", false},
              {"burst2", false}, {"burst3", false}, {"sapper", false}, {"saronite", false}, {"healthStone", false},
              {"startMove", false}, {"tab", false}, {"turn", false}, {"rocketBoot", false}, {"shoot", false},
              {"cancelStormPower", false}, {"eqSetSp", false}, {"willToSurvive", false}, {"cancelHealthBuff", false},
              {"tarBoss1", false}, {"tarBoss2", false}, {"tarBoss3", false}, {"clearMirror", true}, {"tarEnemy", false},
              {"clearFocus", false}, {"focusBoneSpike", false}, {"focusLivingEmber", false}, {"focusValkyr", false},
              {"tarFlyGhost", false}, {"focusXe321", false}, {"kologarnTarget3", false}, {"tarLight", false},
              {"tarDark", false}, {"sb", true}, {"haunt", true}, {"corruption", true}, {"unAff", true}, {"agony", true},
              {"drainSoul", true}, {"lifeTap", true}, {"seed", true}, {"doom", true}, {"immo", true},
              {"soulFire", true}, {"incinerate", true}, {"conflagrate", true}, {"chaosBolt", true}, {"sear", true},
              {"shadowfury", true}, {"demonicEmpowerment", false}, {"shatter", true}, {"teleport", true},
              {"inferno", true}, {"immoAura", true}, {"gate", true}, {"feedPet", false}, {"seedmouseover", false},
              {"seedfocus", false}, {"doommouseover", false}, {"doomfocus", false}, {"burst1sb", true},
              {"burst1corruption", true}, {"burst1unAff", true}, {"burst1haunt", true}, {"burst1agony", true},
              {"burst1lifeTap", true}, {"burst1drainSoul", true}, {"burst2sb", true}, {"burst2corruption", true},
              {"burst2unAff", true}, {"burst2haunt", true}, {"burst2agony", true}, {"burst2lifeTap", true},
              {"burst2drainSoul", true}, {"burst3sb", true}, {"burst3corruption", true}, {"burst3unAff", true},
              {"burst3haunt", true}, {"burst3agony", true}, {"burst3lifeTap", true}, {"burst3drainSoul", true},
              {"shadowBite", false}, {"shadowWard", true}, {"searL8", true}, {"deathCoil", true}, {"shadowFlame", true},
              {"corruptionL9", true}, {"burst2Critical", true}, {"cancelToT", true}, {"lifeTapL4", true}}
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "corruption" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"corruptionfocus", true})
table.insert(actionList, {"corruptionmouseover", true})
table.insert(actionList, {"corruptionpettarget", true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "unAff" .. v
    local skillTarget2 = "immo" .. v
    table.insert(actionList, {{skillTarget, skillTarget2}, true})
end
table.insert(actionList, {{"unAfffocus", "immofocus"}, true})
table.insert(actionList, {{"unAffmouseover", "immomouseover"}, true})
table.insert(actionList, {{"unAffpettarget", "immopettarget"}, true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "agony" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"agonyfocus", true})
table.insert(actionList, {"agonymouseover", true})
table.insert(actionList, {"agonypettarget", true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "drainSoul" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"drainSoulfocus", true})
table.insert(actionList, {"drainSoulmouseover", true})
table.insert(actionList, {"drainSoulpettarget", true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "sb" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"sbfocus", true})
table.insert(actionList, {"sbmouseover", true})
table.insert(actionList, {"sbpettarget", true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "sbL1" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"sbL1focus", true})
table.insert(actionList, {"sbL1mouseover", true})
table.insert(actionList, {"sbL1pettarget", true})
actionMap = {}
for _, v in ipairs(actionList) do
    local actionName = v[1]
    if type(actionName) == "string" then
        actionMap[actionName] = {}
        actionMap[actionName].color = getColor()
        actionMap[actionName].gcd = v[2]
    else
        local actionName1 = actionName[1]
        local actionName2 = actionName[2]
        local color = getColor()
        actionMap[actionName1] = {}
        actionMap[actionName1].color = color
        actionMap[actionName1].gcd = v[2]
        actionMap[actionName2] = {}
        actionMap[actionName2].color = color
        actionMap[actionName2].gcd = v[2]
    end
end

local innerList = actInner .. string.sub(eventName1, 1, 6)
local innerMap = actInner .. string.sub(eventName2, 1, 5)

local seedLength = #seed
local seedIndex = 1
local eventList = _G[innerList]
local eventMap = _G[innerMap]
local function getStep()
    local mychar = string.sub(seed, seedIndex, seedIndex)
    local step = string.byte(mychar)
    seedIndex = seedIndex + 1
    if seedIndex > seedLength then
        seedIndex = 1
    end
    step = step % 14 + 3
    return step
end
local function shuffleInner(step)
    local first = 4
    local second = first + step
    while (second <= #eventList) do
        local tmp = eventList[first]
        eventList[first] = eventList[second]
        eventList[second] = tmp
        first = second
        second = first + step
    end
end
local function shuffle()
    local myindex = 1
    while (myindex <= seedLength) do
        local mychar = string.sub(seed, myindex, myindex)
        local step = string.byte(mychar)
        myindex = myindex + 1
        step = step % 7 + 1
        shuffleInner(step)
    end
end
local weaponType = 0
function getType2(i)
    local type = {}
    local head = bit.band(weaponType, 255)
    local shoulder = bit.band(weaponType, 65280)
    shoulder = bit.rshift(shoulder, 8)
    local shoes = bit.band(weaponType, 16711680)
    shoes = bit.rshift(shoes, 16)
    type.r = head / 255
    type.g = shoulder / 255
    type.b = shoes / 255
    if i <= 2 then
        weaponType = weaponType + 10
    else
        weaponType = weaponType + getStep()
    end
    return type
end
shuffle()
for i, v in ipairs(eventList) do
    local eventName = v[1]
    if type(eventName) == "string" then
        eventMap[eventName] = {}
        eventMap[eventName].color = getType2(i)
        eventMap[eventName].gcd = v[2]
    else
        local eventName1 = eventName[1]
        local eventName2 = eventName[2]
        local color = getType2(i)
        eventMap[eventName1] = {}
        eventMap[eventName1].color = color
        eventMap[eventName1].gcd = v[2]
        eventMap[eventName2] = {}
        eventMap[eventName2].color = color
        eventMap[eventName2].gcd = v[2]
    end
end
function getLength(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

function tableToJson(t)
    local function serializeValue(v)
        if type(v) == "table" and v.color then
            -- 将rgb值转为整数并用逗号连接
            local r = math.floor(v.color.r * 255)
            local g = math.floor(v.color.g * 255)
            local b = math.floor(v.color.b * 255)
            return string.format('"%d,%d,%d"', r, g, b)
        else
            return '"0,0,0"' -- 默认值
        end
    end

    local parts = {}
    for k, v in pairs(t) do
        -- 如果k的前缀不是doom、seed
        if not k:match("^doom") and not k:match("^seed") then
            -- 处理特殊目标后缀，将mouseover、pettarget替换为mouse、pet
            k = k:gsub("mouseover$", "mouse"):gsub("pettarget$", "pet"):gsub("L8$", "LL8"):gsub("L9$", "LL9")
        end
        table.insert(parts, string.format('"%s":%s', k, serializeValue(v)))
    end

    return "{" .. table.concat(parts, ",") .. "}"
end

myKeybind = {}
function mybind(key, value)
    -- local ret = SetBinding(key, value)
    myKeybind[key] = value
    -- if not ret and antiSpam("antiMyBind", 2) then
    --     pi("binding failed, key: " .. key .. " value: " .. value)
    --     schd:ScheduleTimer(createMacro, 5)
    -- end
end
function createMacro()
    -- if UnitAffectingCombat("player") then
    --     pidebug("try to bind key in combat, return and re-schedule ")
    --     schd:ScheduleTimer(createMacro, 5)
    --     return
    -- end
    -- local button = nil
    -- button = CreateFrame("Button", "mouseFocus", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/focus [@mouseover,harm,nodead] [harm]")
    -- button = CreateFrame("Button", "clearFocus", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/clearfocus")
    -- button = CreateFrame("Button", "shadowfury", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast [@cursor] 暗影之怒")
    -- button = CreateFrame("Button", "inferno", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast [@cursor] 地狱火")
    -- button = CreateFrame("Button", "feedPet", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 香辣猛犸小吃")
    -- button = CreateFrame("Button", "seedmouseover", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "腐蚀之种")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "seedfocus", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "腐蚀之种")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "doommouseover", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "厄运诅咒")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "doomfocus", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "厄运诅咒")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "sear", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "灼热之痛")
    -- button:SetAttribute("unit", "target")
    mybind("CTRL-MOUSEWHEELUP", "CLICK mouseFocus:LeftButton")
    mybind("CTRL-MOUSEWHEELDOWN", "CLICK clearFocus:LeftButton")
    mybind("UP", "MOVEFORWARD")
    mybind("DOWN", "MOVEBACKWARD")
    mybind("LEFT", "STRAFELEFT")
    mybind("RIGHT", "STRAFERIGHT")
    mybind("NUMLOCK", "COMBATLOGPAGEDOWN")
    mybind("CTRL-F1", "SPELL 暗影箭")
    mybind("ALT-F1", "SPELL 鬼影缠身")
    mybind("SHIFT-F1", "SPELL 腐蚀术")
    mybind("CTRL-SHIFT-F1", "SPELL 痛苦无常")
    mybind("ALT-CTRL-F1", "SPELL 痛苦诅咒")
    mybind("ALT-SHIFT-F1", "SPELL 吸取灵魂")
    mybind("ALT-CTRL-SHIFT-F1", "SPELL 生命分流")
    mybind("CTRL-F2", "SPELL 腐蚀之种")
    mybind("ALT-F2", "SPELL 厄运诅咒")
    mybind("SHIFT-F2", "SPELL 献祭")
    mybind("CTRL-SHIFT-F2", "SPELL 灵魂之火")
    mybind("ALT-CTRL-F2", "SPELL 烧尽")
    mybind("ALT-SHIFT-F2", "SPELL 燃烧")
    mybind("ALT-CTRL-SHIFT-F2", "SPELL 混乱之箭")
    mybind("CTRL-F3", "CLICK sear:LeftButton")
    mybind("ALT-F3", "CLICK shadowfury:LeftButton")
    mybind("SHIFT-F3", "SPELL 恶魔增效")
    mybind("CTRL-SHIFT-F3", "SPELL 灵魂碎裂")
    mybind("ALT-CTRL-F3", "SPELL 恶魔法阵：传送")
    mybind("ALT-SHIFT-F3", "CLICK inferno:LeftButton")
    mybind("ALT-CTRL-SHIFT-F3", "SPELL 献祭光环")
    mybind("CTRL-F4", "SPELL 恶魔法阵：召唤")
    mybind("SHIFT-F4", "CLICK feedPet:LeftButton")
    mybind("CTRL-SHIFT-F4", "CLICK seedmouseover:LeftButton")
    mybind("ALT-CTRL-F4", "CLICK seedfocus:LeftButton")
    mybind("ALT-CTRL-SHIFT-F4", "CLICK doommouseover:LeftButton")
    -- button = CreateFrame("Button", "burst1sb", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 暗影箭")
    -- button = CreateFrame("Button", "burst1corruption", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 腐蚀术")
    -- button = CreateFrame("Button", "burst1unAff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 痛苦无常")
    -- button = CreateFrame("Button", "burst1haunt", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 鬼影缠身")
    -- button = CreateFrame("Button", "burst1agony", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 痛苦诅咒")
    -- button = CreateFrame("Button", "burst1lifeTap", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 生命分流")
    -- button = CreateFrame("Button", "burst1drainSoul", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形\n/cast 吸取灵魂")
    mybind("CTRL-F5", "CLICK burst1sb:LeftButton")
    mybind("ALT-F5", "CLICK burst1corruption:LeftButton")
    mybind("SHIFT-F5", "CLICK burst1unAff:LeftButton")
    mybind("CTRL-SHIFT-F5", "CLICK burst1haunt:LeftButton")
    mybind("ALT-CTRL-F5", "CLICK burst1agony:LeftButton")
    mybind("ALT-SHIFT-F5", "CLICK burst1lifeTap:LeftButton")
    mybind("ALT-CTRL-SHIFT-F5", "CLICK burst1drainSoul:LeftButton")
    -- button = CreateFrame("Button", "burst2sb", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 暗影箭")
    -- button = CreateFrame("Button", "burst2corruption", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 腐蚀术")
    -- button = CreateFrame("Button", "burst2unAff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 痛苦无常")
    -- button = CreateFrame("Button", "burst2haunt", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 鬼影缠身")
    -- button = CreateFrame("Button", "burst2agony", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 痛苦诅咒")
    -- button = CreateFrame("Button", "burst2lifeTap", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 生命分流")
    -- button = CreateFrame("Button", "burst2drainSoul", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形\n/cast 吸取灵魂")
    mybind("CTRL-F6", "CLICK burst2sb:LeftButton")
    mybind("ALT-F6", "CLICK burst2corruption:LeftButton")
    mybind("SHIFT-F6", "CLICK burst2unAff:LeftButton")
    mybind("CTRL-SHIFT-F6", "CLICK burst2haunt:LeftButton")
    mybind("ALT-CTRL-F6", "CLICK burst2agony:LeftButton")
    mybind("ALT-SHIFT-F6", "CLICK burst2lifeTap:LeftButton")
    mybind("ALT-CTRL-SHIFT-F6", "CLICK burst2drainSoul:LeftButton")
    -- button = CreateFrame("Button", "burst3sb", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 暗影箭")
    -- button = CreateFrame("Button", "burst3corruption", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 腐蚀术")
    -- button = CreateFrame("Button", "burst3unAff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 痛苦无常")
    -- button = CreateFrame("Button", "burst3haunt", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 鬼影缠身")
    -- button = CreateFrame("Button", "burst3agony", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 痛苦诅咒")
    -- button = CreateFrame("Button", "burst3lifeTap", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 生命分流")
    -- button = CreateFrame("Button", "burst3drainSoul", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10\n/cast 吸取灵魂")
    mybind("CTRL-F7", "CLICK burst3sb:LeftButton")
    mybind("ALT-F7", "CLICK burst3corruption:LeftButton")
    mybind("SHIFT-F7", "CLICK burst3unAff:LeftButton")
    mybind("CTRL-SHIFT-F7", "CLICK burst3haunt:LeftButton")
    mybind("ALT-CTRL-F7", "CLICK burst3agony:LeftButton")
    mybind("ALT-SHIFT-F7", "CLICK burst3lifeTap:LeftButton")
    mybind("ALT-CTRL-SHIFT-F7", "CLICK burst3drainSoul:LeftButton")
    -- button = CreateFrame("Button", "shadowBitePetTarget", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影撕咬")
    -- button:SetAttribute("unit", "pettarget")
    -- button = CreateFrame("Button", "searLL8", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "灼热之痛(等级 7)")
    -- button:SetAttribute("unit", "target")
    -- button = CreateFrame("Button", "corruptionLL9", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "腐蚀术(等级 9)")
    -- button:SetAttribute("unit", "target")
    mybind("CTRL-F8", "CLICK doomfocus:LeftButton")
    mybind("ALT-F8", "CLICK shadowBitePetTarget:LeftButton")
    mybind("SHIFT-F8", "SPELL 暗影防护结界")
    mybind("CTRL-SHIFT-F8", "CLICK searLL8:LeftButton")
    mybind("ALT-CTRL-F8", "SPELL 死亡缠绕")
    mybind("ALT-SHIFT-F8", "SPELL 暗影烈焰")
    mybind("ALT-CTRL-SHIFT-F8", "CLICK corruptionLL9:LeftButton")
    -- button = CreateFrame("Button", "burst2Critical", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 狂野魔法药水\n/cast 恶魔变形")
    -- button = CreateFrame("Button", "cancelToT", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cancelaura 嫁祸诀窍")
    -- button = CreateFrame("Button", "lifeTapL4", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "生命分流(等级 4)")
    mybind("CTRL-K", "CLICK burst2Critical:LeftButton")
    mybind("ALT-K", "CLICK cancelToT:LeftButton")
    mybind("SHIFT-K", "CLICK lifeTapL4:LeftButton")
    -- button = CreateFrame("Button", "burst1", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/cast 恶魔变形")
    -- button = CreateFrame("Button", "burst2", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/use 碎裂的能量核心\n/cast 恶魔变形")
    -- button = CreateFrame("Button", "burst3", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10")
    -- button = CreateFrame("Button", "sapper", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 通用热力工程炸药")
    -- button = CreateFrame("Button", "saronite", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast [@cursor] 萨隆邪铁炸弹")
    -- button = CreateFrame("Button", "healthStone", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/use 邪能治疗石")
    -- button = CreateFrame("Button", "rocketBoot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/use 8")
    -- button = CreateFrame("Button", "turn", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/run SetView(1) \n/run MouselookStart() \n/run MouselookStop()")
    -- button = CreateFrame("Button", "cancelStorm", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cancelaura 风暴之力")
    -- button = CreateFrame("Button", "eqSetSp", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 冰霜巨龙合剂\n/equipset 法伤")
    -- button = CreateFrame("Button", "cancelHealthBuff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cancelaura 命令怒吼\n/cancelaura 坚韧祷言\n/cancelaura 真言术：韧")
    mybind("CTRL-F9", "STOPCASTING")
    mybind("ALT-F9", "CLICK burst1:LeftButton")
    mybind("SHIFT-F9", "CLICK burst2:LeftButton")
    mybind("CTRL-SHIFT-F9", "CLICK burst3:LeftButton")
    mybind("ALT-CTRL-F9", "CLICK sapper:LeftButton")
    mybind("ALT-SHIFT-F9", "CLICK saronite:LeftButton")
    mybind("ALT-CTRL-SHIFT-F9", "CLICK healthStone:LeftButton")
    mybind("CTRL-F10", "CLICK rocketBoot:LeftButton")
    mybind("ALT-F10", "CLICK turn:LeftButton")
    mybind("SHIFT-F10", "SPELL 射击")
    mybind("CTRL-SHIFT-F10", "CLICK cancelStorm:LeftButton")
    mybind("ALT-CTRL-F10", "CLICK eqSetSp:LeftButton")
    mybind("ALT-SHIFT-F10", "SPELL 生存意志")
    mybind("ALT-CTRL-SHIFT-F10", "CLICK cancelHealthBuff:LeftButton")
    mybind("CTRL-F11", "insertburst1")
    mybind("ALT-F11", "insertburst2")
    mybind("SHIFT-F11", "insertburst3")
    mybind("CTRL-SHIFT-F11", "insertsapper")
    mybind("ALT-CTRL-F11", "insertsaronite")
    mybind("ALT-SHIFT-F11", "modemain")
    mybind("ALT-CTRL-SHIFT-F11", "modeaoe")
    mybind("CTRL-F12", "insertshatter")
    mybind("ALT-F12", "insertteleport")
    mybind("SHIFT-F12", "insertlifeTap")
    mybind("CTRL-SHIFT-F12", "insertinferno")
    mybind("ALT-CTRL-F12", "insertimmoAura")
    mybind("ALT-SHIFT-F12", "insertgate")
    mybind("ALT-CTRL-SHIFT-F12", "modeseed")
    mybind("ALT-P", "insertdoomfocus")
    -- button = CreateFrame("Button", "tarBoss1", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/tar boss1\n/petattack boss1")
    -- button = CreateFrame("Button", "tarBoss2", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/tar boss2\n/petattack boss2")
    -- button = CreateFrame("Button", "tarBoss3", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/tar boss3\n/petattack boss3")
    -- button = CreateFrame("Button", "clearMirror", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 镜像 \n/tar 裹体之网 \n/cast 吸取生命")
    -- button = CreateFrame("Button", "tarEnemy", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/targetenemy [noharm] [dead]")
    -- button = CreateFrame("Button", "focusBoneSpike", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 骨针\n/focus\n/tar 玛洛加尔领主")
    -- button = CreateFrame("Button", "focusLivingEmber", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 活体余烬\n/focus\n/tar boss1")
    -- button = CreateFrame("Button", "focusValkyr", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 瓦格里暗影戒卫者\n/focus\n/tar 巫妖王")
    -- button = CreateFrame("Button", "tarFlyGhost", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 卑劣的灵魂")
    -- button = CreateFrame("Button", "focusXe321", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar XE-321爆破机器人\n/focus\n/tar XT-002拆解者")
    -- button = CreateFrame("Button", "ktarget3", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 右臂\n/focus\n/petattack 左臂\n/tar 科隆加恩")
    -- button = CreateFrame("Button", "tarLight", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/tar 黑暗邪使艾蒂丝\n/focus\n/tar 光明邪使菲奥拉\n/petattack 光明邪使菲奥拉")
    -- button = CreateFrame("Button", "tarDark", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/tar 光明邪使菲奥拉\n/focus\n/tar 黑暗邪使艾蒂丝\n/petattack 黑暗邪使艾蒂丝")
    mybind("CTRL-NUMPAD0", "CLICK tarBoss1:LeftButton")
    mybind("ALT-NUMPAD0", "CLICK tarBoss2:LeftButton")
    mybind("SHIFT-NUMPAD0", "CLICK tarBoss3:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD0", "CLICK clearMirror:LeftButton")
    mybind("ALT-CTRL-NUMPAD0", "CLICK tarEnemy:LeftButton")
    mybind("ALT-SHIFT-NUMPAD0", "CLICK focusBoneSpike:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD0", "CLICK focusLivingEmber:LeftButton")
    mybind("CTRL-NUMPAD1", "CLICK focusValkyr:LeftButton")
    mybind("ALT-NUMPAD1", "CLICK tarFlyGhost:LeftButton")
    mybind("SHIFT-NUMPAD1", "CLICK focusXe321:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD1", "CLICK ktarget3:LeftButton")
    mybind("ALT-CTRL-NUMPAD1", "CLICK tarLight:LeftButton")
    mybind("ALT-SHIFT-NUMPAD1", "CLICK tarDark:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "Corruption", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "腐蚀术")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusCorruption", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "腐蚀术")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseCorruption", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "腐蚀术")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petCorruption", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "腐蚀术")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-INSERT", "CLICK raid1targetCorruption:LeftButton")
    mybind("ALT-INSERT", "CLICK raid2targetCorruption:LeftButton")
    mybind("SHIFT-INSERT", "CLICK raid3targetCorruption:LeftButton")
    mybind("CTRL-SHIFT-INSERT", "CLICK raid4targetCorruption:LeftButton")
    mybind("ALT-CTRL-INSERT", "CLICK raid5targetCorruption:LeftButton")
    mybind("ALT-SHIFT-INSERT", "CLICK raid6targetCorruption:LeftButton")
    mybind("ALT-CTRL-SHIFT-INSERT", "CLICK raid7targetCorruption:LeftButton")
    mybind("CTRL-DELETE", "CLICK raid8targetCorruption:LeftButton")
    mybind("ALT-DELETE", "CLICK raid9targetCorruption:LeftButton")
    mybind("SHIFT-DELETE", "CLICK raid10targetCorruption:LeftButton")
    mybind("CTRL-SHIFT-DELETE", "CLICK raid11targetCorruption:LeftButton")
    mybind("ALT-CTRL-DELETE", "CLICK raid12targetCorruption:LeftButton")
    mybind("ALT-SHIFT-DELETE", "CLICK raid13targetCorruption:LeftButton")
    mybind("ALT-CTRL-SHIFT-DELETE", "CLICK raid14targetCorruption:LeftButton")
    mybind("CTRL-HOME", "CLICK raid15targetCorruption:LeftButton")
    mybind("ALT-HOME", "CLICK raid16targetCorruption:LeftButton")
    mybind("SHIFT-HOME", "CLICK raid17targetCorruption:LeftButton")
    mybind("CTRL-SHIFT-HOME", "CLICK raid18targetCorruption:LeftButton")
    mybind("ALT-CTRL-HOME", "CLICK raid19targetCorruption:LeftButton")
    mybind("ALT-SHIFT-HOME", "CLICK raid20targetCorruption:LeftButton")
    mybind("ALT-CTRL-SHIFT-HOME", "CLICK raid21targetCorruption:LeftButton")
    mybind("CTRL-END", "CLICK raid22targetCorruption:LeftButton")
    mybind("ALT-END", "CLICK raid23targetCorruption:LeftButton")
    mybind("SHIFT-END", "CLICK raid24targetCorruption:LeftButton")
    mybind("CTRL-SHIFT-END", "CLICK raid25targetCorruption:LeftButton")
    mybind("ALT-CTRL-END", "CLICK focusCorruption:LeftButton")
    mybind("ALT-SHIFT-END", "CLICK mouseCorruption:LeftButton")
    mybind("ALT-CTRL-SHIFT-END", "CLICK petCorruption:LeftButton")
    mybind("CTRL-N", "CLICK party1targetCorruption:LeftButton")
    mybind("ALT-N", "CLICK party2targetCorruption:LeftButton")
    mybind("SHIFT-N", "CLICK party3targetCorruption:LeftButton")
    mybind("CTRL-SHIFT-N", "CLICK party4targetCorruption:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "UnAff", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "痛苦无常")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusUnAff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "痛苦无常")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseUnAff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "痛苦无常")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petUnAff", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "痛苦无常")
    -- button:SetAttribute("unit", "pettarget")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "Immo", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "献祭")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusImmo", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "献祭")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseImmo", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "献祭")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petImmo", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "献祭")
    -- button:SetAttribute("unit", "pettarget")
    -- if talent == EnumTalent.Aff then
    mybind("CTRL-PAGEUP", "CLICK raid1targetUnAff:LeftButton")
    mybind("ALT-PAGEUP", "CLICK raid2targetUnAff:LeftButton")
    mybind("SHIFT-PAGEUP", "CLICK raid3targetUnAff:LeftButton")
    mybind("CTRL-SHIFT-PAGEUP", "CLICK raid4targetUnAff:LeftButton")
    mybind("ALT-CTRL-PAGEUP", "CLICK raid5targetUnAff:LeftButton")
    mybind("ALT-SHIFT-PAGEUP", "CLICK raid6targetUnAff:LeftButton")
    mybind("ALT-CTRL-SHIFT-PAGEUP", "CLICK raid7targetUnAff:LeftButton")
    mybind("CTRL-PAGEDOWN", "CLICK raid8targetUnAff:LeftButton")
    mybind("ALT-PAGEDOWN", "CLICK raid9targetUnAff:LeftButton")
    mybind("SHIFT-PAGEDOWN", "CLICK raid10targetUnAff:LeftButton")
    mybind("CTRL-SHIFT-PAGEDOWN", "CLICK raid11targetUnAff:LeftButton")
    mybind("ALT-CTRL-PAGEDOWN", "CLICK raid12targetUnAff:LeftButton")
    mybind("ALT-SHIFT-PAGEDOWN", "CLICK raid13targetUnAff:LeftButton")
    mybind("ALT-CTRL-SHIFT-PAGEDOWN", "CLICK raid14targetUnAff:LeftButton")
    mybind("CTRL-[", "CLICK raid15targetUnAff:LeftButton")
    mybind("ALT-[", "CLICK raid16targetUnAff:LeftButton")
    mybind("SHIFT-[", "CLICK raid17targetUnAff:LeftButton")
    mybind("CTRL-SHIFT-[", "CLICK raid18targetUnAff:LeftButton")
    mybind("ALT-CTRL-[", "CLICK raid19targetUnAff:LeftButton")
    mybind("ALT-SHIFT-NUMPAD5", "CLICK raid20targetUnAff:LeftButton")
    mybind("ALT-CTRL-SHIFT-[", "CLICK raid21targetUnAff:LeftButton")
    mybind("CTRL-]", "CLICK raid22targetUnAff:LeftButton")
    mybind("ALT-]", "CLICK raid23targetUnAff:LeftButton")
    mybind("SHIFT-]", "CLICK raid24targetUnAff:LeftButton")
    mybind("CTRL-SHIFT-]", "CLICK raid25targetUnAff:LeftButton")
    mybind("ALT-CTRL-]", "CLICK focusUnAff:LeftButton")
    mybind("ALT-SHIFT-]", "CLICK mouseUnAff:LeftButton")
    mybind("ALT-CTRL-SHIFT-]", "CLICK petUnAff:LeftButton")
    mybind("ALT-CTRL-N", "CLICK party1targetUnAff:LeftButton")
    mybind("ALT-SHIFT-N", "CLICK party2targetUnAff:LeftButton")
    mybind("ALT-CTRL-SHIFT-N", "CLICK party3targetUnAff:LeftButton")
    mybind("CTRL-L", "CLICK party4targetUnAff:LeftButton")
    -- end
    -- if talent == EnumTalent.Demo then
    --     mybind("CTRL-PAGEUP", "CLICK raid1targetImmo:LeftButton")
    --     mybind("ALT-PAGEUP", "CLICK raid2targetImmo:LeftButton")
    --     mybind("SHIFT-PAGEUP", "CLICK raid3targetImmo:LeftButton")
    --     mybind("CTRL-SHIFT-PAGEUP", "CLICK raid4targetImmo:LeftButton")
    --     mybind("ALT-CTRL-PAGEUP", "CLICK raid5targetImmo:LeftButton")
    --     mybind("ALT-SHIFT-PAGEUP", "CLICK raid6targetImmo:LeftButton")
    --     mybind("ALT-CTRL-SHIFT-PAGEUP", "CLICK raid7targetImmo:LeftButton")
    --     mybind("CTRL-PAGEDOWN", "CLICK raid8targetImmo:LeftButton")
    --     mybind("ALT-PAGEDOWN", "CLICK raid9targetImmo:LeftButton")
    --     mybind("SHIFT-PAGEDOWN", "CLICK raid10targetImmo:LeftButton")
    --     mybind("CTRL-SHIFT-PAGEDOWN", "CLICK raid11targetImmo:LeftButton")
    --     mybind("ALT-CTRL-PAGEDOWN", "CLICK raid12targetImmo:LeftButton")
    --     mybind("ALT-SHIFT-PAGEDOWN", "CLICK raid13targetImmo:LeftButton")
    --     mybind("ALT-CTRL-SHIFT-PAGEDOWN", "CLICK raid14targetImmo:LeftButton")
    --     mybind("CTRL-[", "CLICK raid15targetImmo:LeftButton")
    --     mybind("ALT-[", "CLICK raid16targetImmo:LeftButton")
    --     mybind("SHIFT-[", "CLICK raid17targetImmo:LeftButton")
    --     mybind("CTRL-SHIFT-[", "CLICK raid18targetImmo:LeftButton")
    --     mybind("ALT-CTRL-[", "CLICK raid19targetImmo:LeftButton")
    --     mybind("ALT-SHIFT-NUMPAD5", "CLICK raid20targetImmo:LeftButton")
    --     mybind("ALT-CTRL-SHIFT-[", "CLICK raid21targetImmo:LeftButton")
    --     mybind("CTRL-]", "CLICK raid22targetImmo:LeftButton")
    --     mybind("ALT-]", "CLICK raid23targetImmo:LeftButton")
    --     mybind("SHIFT-]", "CLICK raid24targetImmo:LeftButton")
    --     mybind("CTRL-SHIFT-]", "CLICK raid25targetImmo:LeftButton")
    --     mybind("ALT-CTRL-]", "CLICK focusImmo:LeftButton")
    --     mybind("ALT-SHIFT-]", "CLICK mouseImmo:LeftButton")
    --     mybind("ALT-CTRL-SHIFT-]", "CLICK petImmo:LeftButton")
    --     mybind("ALT-CTRL-N", "CLICK party1targetImmo:LeftButton")
    --     mybind("ALT-SHIFT-N", "CLICK party2targetImmo:LeftButton")
    --     mybind("ALT-CTRL-SHIFT-N", "CLICK party3targetImmo:LeftButton")
    --     mybind("CTRL-L", "CLICK party4targetImmo:LeftButton")
    -- end
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "Agony", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "痛苦诅咒")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusAgony", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "痛苦诅咒")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseAgony", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "痛苦诅咒")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petAgony", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "痛苦诅咒")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-NUMPAD6", "CLICK raid1targetAgony:LeftButton")
    mybind("ALT-NUMPAD6", "CLICK raid2targetAgony:LeftButton")
    mybind("SHIFT-NUMPAD6", "CLICK raid3targetAgony:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD6", "CLICK raid4targetAgony:LeftButton")
    mybind("ALT-CTRL-NUMPAD6", "CLICK raid5targetAgony:LeftButton")
    mybind("ALT-SHIFT-NUMPAD6", "CLICK raid6targetAgony:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD6", "CLICK raid7targetAgony:LeftButton")
    mybind("CTRL-NUMPAD7", "CLICK raid8targetAgony:LeftButton")
    mybind("ALT-NUMPAD7", "CLICK raid9targetAgony:LeftButton")
    mybind("SHIFT-NUMPAD7", "CLICK raid10targetAgony:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD7", "CLICK raid11targetAgony:LeftButton")
    mybind("ALT-CTRL-NUMPAD7", "CLICK raid12targetAgony:LeftButton")
    mybind("ALT-SHIFT-NUMPAD7", "CLICK raid13targetAgony:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD7", "CLICK raid14targetAgony:LeftButton")
    mybind("CTRL-NUMPAD8", "CLICK raid15targetAgony:LeftButton")
    mybind("ALT-NUMPAD8", "CLICK raid16targetAgony:LeftButton")
    mybind("SHIFT-NUMPAD8", "CLICK raid17targetAgony:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD8", "CLICK raid18targetAgony:LeftButton")
    mybind("ALT-CTRL-NUMPAD8", "CLICK raid19targetAgony:LeftButton")
    mybind("ALT-SHIFT-NUMPAD8", "CLICK raid20targetAgony:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD8", "CLICK raid21targetAgony:LeftButton")
    mybind("CTRL-NUMPAD9", "CLICK raid22targetAgony:LeftButton")
    mybind("ALT-NUMPAD9", "CLICK raid23targetAgony:LeftButton")
    mybind("SHIFT-NUMPAD9", "CLICK raid24targetAgony:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD9", "CLICK raid25targetAgony:LeftButton")
    mybind("ALT-CTRL-NUMPAD9", "CLICK focusAgony:LeftButton")
    mybind("ALT-SHIFT-NUMPAD9", "CLICK mouseAgony:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD9", "CLICK petAgony:LeftButton")
    mybind("CTRL-M", "CLICK party1targetAgony:LeftButton")
    mybind("ALT-M", "CLICK party2targetAgony:LeftButton")
    mybind("SHIFT-M", "CLICK party3targetAgony:LeftButton")
    mybind("CTRL-SHIFT-M", "CLICK party4targetAgony:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "DrainSoul", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "吸取灵魂")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusDrainSoul", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "吸取灵魂")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseDrainSoul", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "吸取灵魂")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petDrainSoul", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "吸取灵魂")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-NUMPADPLUS", "CLICK raid1targetDrainSoul:LeftButton")
    mybind("ALT-NUMPADPLUS", "CLICK raid2targetDrainSoul:LeftButton")
    mybind("SHIFT-NUMPADPLUS", "CLICK raid3targetDrainSoul:LeftButton")
    mybind("CTRL-SHIFT-NUMPADPLUS", "CLICK raid4targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-NUMPADPLUS", "CLICK raid5targetDrainSoul:LeftButton")
    mybind("ALT-SHIFT-NUMPADPLUS", "CLICK raid6targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPADPLUS", "CLICK raid7targetDrainSoul:LeftButton")
    mybind("CTRL-NUMPADMINUS", "CLICK raid8targetDrainSoul:LeftButton")
    mybind("ALT-NUMPADMINUS", "CLICK raid9targetDrainSoul:LeftButton")
    mybind("SHIFT-NUMPADMINUS", "CLICK raid10targetDrainSoul:LeftButton")
    mybind("CTRL-SHIFT-NUMPADMINUS", "CLICK raid11targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-NUMPADMINUS", "CLICK raid12targetDrainSoul:LeftButton")
    mybind("ALT-SHIFT-NUMPADMINUS", "CLICK raid13targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPADMINUS", "CLICK raid14targetDrainSoul:LeftButton")
    mybind("CTRL-NUMPADMULTIPLY", "CLICK raid15targetDrainSoul:LeftButton")
    mybind("ALT-NUMPADMULTIPLY", "CLICK raid16targetDrainSoul:LeftButton")
    mybind("SHIFT-NUMPADMULTIPLY", "CLICK raid17targetDrainSoul:LeftButton")
    mybind("CTRL-SHIFT-NUMPADMULTIPLY", "CLICK raid18targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-NUMPADMULTIPLY", "CLICK raid19targetDrainSoul:LeftButton")
    mybind("ALT-SHIFT-NUMPADMULTIPLY", "CLICK raid20targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPADMULTIPLY", "CLICK raid21targetDrainSoul:LeftButton")
    mybind("CTRL-NUMPADDIVIDE", "CLICK raid22targetDrainSoul:LeftButton")
    mybind("ALT-NUMPADDIVIDE", "CLICK raid23targetDrainSoul:LeftButton")
    mybind("SHIFT-NUMPADDIVIDE", "CLICK raid24targetDrainSoul:LeftButton")
    mybind("CTRL-SHIFT-NUMPADDIVIDE", "CLICK raid25targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-NUMPADDIVIDE", "CLICK focusDrainSoul:LeftButton")
    mybind("ALT-SHIFT-NUMPADDIVIDE", "CLICK mouseDrainSoul:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPADDIVIDE", "CLICK petDrainSoul:LeftButton")
    mybind("ALT-CTRL-M", "CLICK party1targetDrainSoul:LeftButton")
    mybind("ALT-SHIFT-M", "CLICK party2targetDrainSoul:LeftButton")
    mybind("ALT-CTRL-SHIFT-M", "CLICK party3targetDrainSoul:LeftButton")
    mybind("ALT-L", "CLICK party4targetDrainSoul:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "Sb", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "暗影箭")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusSb", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影箭")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseSb", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影箭")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petSb", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影箭")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-UP", "CLICK raid1targetSb:LeftButton")
    mybind("ALT-UP", "CLICK raid2targetSb:LeftButton")
    mybind("SHIFT-UP", "CLICK raid3targetSb:LeftButton")
    mybind("CTRL-SHIFT-UP", "CLICK raid4targetSb:LeftButton")
    mybind("ALT-CTRL-UP", "CLICK raid5targetSb:LeftButton")
    mybind("ALT-SHIFT-UP", "CLICK raid6targetSb:LeftButton")
    mybind("ALT-CTRL-SHIFT-UP", "CLICK raid7targetSb:LeftButton")
    mybind("CTRL-DOWN", "CLICK raid8targetSb:LeftButton")
    mybind("ALT-DOWN", "CLICK raid9targetSb:LeftButton")
    mybind("SHIFT-DOWN", "CLICK raid10targetSb:LeftButton")
    mybind("CTRL-SHIFT-DOWN", "CLICK raid11targetSb:LeftButton")
    mybind("ALT-CTRL-DOWN", "CLICK raid12targetSb:LeftButton")
    mybind("ALT-SHIFT-DOWN", "CLICK raid13targetSb:LeftButton")
    mybind("ALT-CTRL-SHIFT-DOWN", "CLICK raid14targetSb:LeftButton")
    mybind("CTRL-LEFT", "CLICK raid15targetSb:LeftButton")
    mybind("ALT-LEFT", "CLICK raid16targetSb:LeftButton")
    mybind("SHIFT-LEFT", "CLICK raid17targetSb:LeftButton")
    mybind("CTRL-SHIFT-LEFT", "CLICK raid18targetSb:LeftButton")
    mybind("ALT-CTRL-LEFT", "CLICK raid19targetSb:LeftButton")
    mybind("ALT-SHIFT-LEFT", "CLICK raid20targetSb:LeftButton")
    mybind("ALT-CTRL-SHIFT-LEFT", "CLICK raid21targetSb:LeftButton")
    mybind("CTRL-RIGHT", "CLICK raid22targetSb:LeftButton")
    mybind("ALT-RIGHT", "CLICK raid23targetSb:LeftButton")
    mybind("SHIFT-RIGHT", "CLICK raid24targetSb:LeftButton")
    mybind("CTRL-SHIFT-RIGHT", "CLICK raid25targetSb:LeftButton")
    mybind("ALT-CTRL-RIGHT", "CLICK focusSb:LeftButton")
    mybind("ALT-SHIFT-RIGHT", "CLICK mouseSb:LeftButton")
    mybind("ALT-CTRL-SHIFT-RIGHT", "CLICK petSb:LeftButton")
    mybind("CTRL-7", "CLICK party1targetSb:LeftButton")
    mybind("ALT-7", "CLICK party2targetSb:LeftButton")
    mybind("SHIFT-7", "CLICK party3targetSb:LeftButton")
    mybind("CTRL-SHIFT-7", "CLICK party4targetSb:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "SbL1", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "暗影箭(等级 1)")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusSbL1", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影箭(等级 1)")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseSbL1", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影箭(等级 1)")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petSbL1", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "暗影箭(等级 1)")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-;", "CLICK raid1targetSbL1:LeftButton")
    mybind("ALT-;", "CLICK raid2targetSbL1:LeftButton")
    mybind("SHIFT-;", "CLICK raid3targetSbL1:LeftButton")
    mybind("CTRL-SHIFT-;", "CLICK raid4targetSbL1:LeftButton")
    mybind("ALT-CTRL-;", "CLICK raid5targetSbL1:LeftButton")
    mybind("ALT-SHIFT-;", "CLICK raid6targetSbL1:LeftButton")
    mybind("ALT-CTRL-SHIFT-;", "CLICK raid7targetSbL1:LeftButton")
    mybind("CTRL-'", "CLICK raid8targetSbL1:LeftButton")
    mybind("ALT-'", "CLICK raid9targetSbL1:LeftButton")
    mybind("SHIFT-'", "CLICK raid10targetSbL1:LeftButton")
    mybind("CTRL-SHIFT-'", "CLICK raid11targetSbL1:LeftButton")
    mybind("ALT-CTRL-'", "CLICK raid12targetSbL1:LeftButton")
    mybind("ALT-SHIFT-'", "CLICK raid13targetSbL1:LeftButton")
    mybind("ALT-CTRL-SHIFT-'", "CLICK raid14targetSbL1:LeftButton")
    mybind("CTRL-,", "CLICK raid15targetSbL1:LeftButton")
    mybind("ALT-,", "CLICK raid16targetSbL1:LeftButton")
    mybind("SHIFT-,", "CLICK raid17targetSbL1:LeftButton")
    mybind("CTRL-SHIFT-,", "CLICK raid18targetSbL1:LeftButton")
    mybind("ALT-CTRL-,", "CLICK raid19targetSbL1:LeftButton")
    mybind("ALT-SHIFT-,", "CLICK raid20targetSbL1:LeftButton")
    mybind("ALT-CTRL-SHIFT-,", "CLICK raid21targetSbL1:LeftButton")
    mybind("CTRL-.", "CLICK raid22targetSbL1:LeftButton")
    mybind("ALT-.", "CLICK raid23targetSbL1:LeftButton")
    mybind("SHIFT-.", "CLICK raid24targetSbL1:LeftButton")
    mybind("CTRL-SHIFT-.", "CLICK raid25targetSbL1:LeftButton")
    mybind("ALT-CTRL-.", "CLICK focusSbL1:LeftButton")
    mybind("ALT-SHIFT-.", "CLICK mouseSbL1:LeftButton")
    mybind("ALT-CTRL-SHIFT-.", "CLICK petSbL1:LeftButton")
    mybind("ALT-CTRL-7", "CLICK party1targetSbL1:LeftButton")
    mybind("ALT-SHIFT-7", "CLICK party2targetSbL1:LeftButton")
    mybind("ALT-CTRL-SHIFT-7", "CLICK party3targetSbL1:LeftButton")
    mybind("SHIFT-L", "CLICK party4targetSbL1:LeftButton")
end

local spellnameMap = {
    ["生命分流"] = "lifeTap",
    ["痛苦无常"] = "unAff",
    ["腐蚀之种"] = "seed",
    ["死亡缠绕"] = "deathCoil",
    ["恶魔增效"] = "demonicEmpowerment",
    ["暗影箭"] = "sb",
    ["灵魂之火"] = "soulFire",
    ["吸取灵魂"] = "drainSoul",
    ["腐蚀术"] = "corruption",
    ["痛苦诅咒"] = "agony",
    ["鬼影缠身"] = "haunt",
    ["暗影防护结界"] = "shadowWard",
    ["献祭"] = "immo",
    ["献祭光环"] = "immoAura",
    ["混乱之箭"] = "chaosBolt",
    ["烧尽"] = "incinerate",
    ["燃烧"] = "conflagrate",
    ["射击"] = "shoot",
    ["生存意志"] = "willToSurvive",
    ["厄运诅咒"] = "doom",
    ["恶魔法阵：召唤"] = "gate",
    ["恶魔法阵：传送"] = "teleport",
    ["暗影烈焰"] = "shadowfury",
    ["灵魂碎裂"] = "shatter"
}

function keybindToJson(keybind)
    if type(keybind) ~= "table" then
        return "{}"
    end

    local function processValue(value)
        -- 1. 删除CLICK和SPELL并去除首尾空格
        value = value:gsub("CLICK", ""):gsub("SPELL", ""):gsub(":LeftButton", "")
        value = value:gsub("^%s*(.-)%s*$", "%1")
        if spellnameMap[value] then
            value = spellnameMap[value]
        end
        -- 2. 检查特定后缀并重新排序
        local suffixes = {"Agony", "Sb", "Corruption", "SbL1", "DrainSoul", "UnAff"}
        for _, suffix in ipairs(suffixes) do
            local pattern = "(.+)" .. suffix .. "$"
            local target = value:match(pattern)
            if target then
                return suffix .. target
            end
        end

        return value
    end

    local parts = {}
    for k, v in pairs(keybind) do
        local key = tostring(k)
        local value = processValue(tostring(v))
        table.insert(parts, string.format('"%s":"%s"', key, value))
    end

    return "{" .. table.concat(parts, ",") .. "}"
end
createMacro()

-- key-色值　映射
local eventJson = tableToJson(eventMap)
-- 快捷键-key　映射
local keybindJson = keybindToJson(myKeybind)

function compareJsons(eventJson, keybindJson)
    -- 解析 JSON 字符串为 table
    local function parseJson(jsonStr)
        local result = {}
        for k, v in jsonStr:gmatch('"([^"]+)":"([^"]+)"') do
            result[k] = v
        end
        return result
    end

    local eventTable = parseJson(eventJson)
    local keybindTable = parseJson(keybindJson)

    -- 创建两个结果表，分别存储未匹配和已匹配的项
    local unmatched = {}
    local matched = {}

    -- 遍历 eventTable
    for eventKey, eventValue in pairs(eventTable) do
        -- 初始化为未匹配状态
        local isMatched = false
        local matchedCom = ""

        -- 在 keybindTable 中查找匹配项
        for keybindKey, keybindValue in pairs(keybindTable) do
            -- 获取技能的英文名称
            local englishName = keybindValue

            -- 忽略大小写比较
            if englishName:lower() == eventKey:lower() then
                isMatched = true
                matchedCom = keybindKey
                break
            end
        end

        -- 根据匹配状态存入对应的表
        if isMatched then
            matched[eventKey] = {
                color = eventValue,
                com = matchedCom
            }
        else
            unmatched[eventKey] = {
                color = eventValue,
                com = ""
            }
        end
    end

    -- 将结果转换为 JSON 格式，先处理未匹配项，再处理匹配项
    local parts = {}

    -- 先添加未匹配项
    for k, v in pairs(unmatched) do
        table.insert(parts, string.format('"%s":{"color":"%s","com":"%s"}', k, v.color, v.com))
    end

    -- 再添加匹配项
    for k, v in pairs(matched) do
        table.insert(parts, string.format('"%s":{"color":"%s","com":"%s"}', k, v.color, v.com))
    end

    return "{" .. table.concat(parts, ",") .. "}"
end

local newJson = compareJsons(eventJson, keybindJson)
print(newJson)
