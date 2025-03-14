local bit = bit32
raidMemberTargetUnitStr = {}
for i = 1, 25 do
    raidMemberTargetUnitStr[i] = "raid" .. i .. "target";
end
raidMemberUnitStr = {}
for i = 1, 25 do
    raidMemberUnitStr[i] = "raid" .. i
end

eventName1 = "onListChange";
eventName2 = "onMapChange";
actInner = "acti";
myweapon = "00c7"
seed = "blade" .. _G["myweapon"]

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
              {"startMove", false}, {"tab", false}, {"turn", false}, {"rocketBoot", false}, {"stopMove", false},
              {"stopMoveQE", false}, {"cancelStormPower", false}, {"tarBoss1", false}, {"tarBoss2", false},
              {"tarBoss3", false}, {"clearMirror", false}, {"tarEnemy", false}, {"clearFocus", false},
              {"focusBoneSpike", false}, {"focusBloodBeast", false}, {"focusValkyr", false}, {"kologarnTarget3", false},
              {"launcher", true}, {"killShot", true}, {"serpent", true}, {"chimera", true}, {"aimedShot", true},
              {"steadyShot", true}, {"multiShot", true}, {"viper", false}, {"dragonhawk", false}, {"mark", true},
              {"feignDeath", false}, {"killCommand", false}, {"explosiveShot", true}, {"explosiveShotL3", true},
              {"blackArrow", true}, {"volley", true}, {"tranqFocus", true}, {"missdFocus", true}, {"raptor", false},
              {"frostTrap", true}, {"forwardJump", false}, {"autoshot", false}, {"backwardJump", false},
              {"feedPet", false}, {"mBite", true}, {"snakeTrap", true}}
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "killShot" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"killShotfocus", true})
table.insert(actionList, {"killShotmouseover", true})
table.insert(actionList, {"killShotpettarget", true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "serpent" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"serpentfocus", true})
table.insert(actionList, {"serpentmouseover", true})
table.insert(actionList, {"serpentpettarget", true})
for i, v in ipairs(raidMemberTargetUnitStr) do
    local skillTarget = "explosiveShot" .. v
    table.insert(actionList, {skillTarget, true})
end
table.insert(actionList, {"explosiveShotfocus", true})
table.insert(actionList, {"explosiveShotmouseover", true})
table.insert(actionList, {"explosiveShotpettarget", true})
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
local seed = "dagger";
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
            k = k:gsub("mouseover$", "mouse"):gsub("pettarget$", "pet"):gsub("L8$", "LL8"):gsub("^serpent", "Serpent")
                :gsub("^killShot", "KillShot"):gsub("^explosiveShot", "Es")
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
    -- button:SetAttribute("macrotext", "/focus [@mouseover,nodead]")
    -- button = CreateFrame("Button", "clearFocus", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/clearfocus")
    -- button = CreateFrame("Button", "launcher", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast [@cursor] 陷阱发射器：爆炸陷阱")
    -- button = CreateFrame("Button", "volley", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast [@cursor] 乱射")
    -- button = CreateFrame("Button", "focusTranq", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "宁神射击")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "focusMissd", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "误导")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "esL3", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "爆炸射击(等级 3)")
    -- button:SetAttribute("unit", "target")
    mybind("CTRL-MOUSEWHEELUP", "CLICK mouseFocus:LeftButton")
    mybind("CTRL-MOUSEWHEELDOWN", "CLICK clearFocus:LeftButton")
    mybind("UP", "MOVEFORWARD")
    mybind("DOWN", "MOVEBACKWARD")
    mybind("LEFT", "STRAFELEFT")
    mybind("RIGHT", "STRAFERIGHT")
    mybind("NUMLOCK", "COMBATLOGPAGEDOWN")
    mybind("CTRL-F1", "CLICK launcher:LeftButton")
    mybind("ALT-F1", "SPELL 杀戮射击")
    mybind("SHIFT-F1", "SPELL 毒蛇钉刺")
    mybind("CTRL-SHIFT-F1", "SPELL 奇美拉射击")
    mybind("ALT-CTRL-F1", "SPELL 瞄准射击")
    mybind("ALT-SHIFT-F1", "SPELL 稳固射击")
    mybind("ALT-CTRL-SHIFT-F1", "SPELL 多重射击")
    mybind("CTRL-F2", "SPELL 爆炸射击")
    mybind("ALT-F2", "CLICK esL3:LeftButton")
    mybind("SHIFT-F2", "SPELL 蝰蛇守护")
    mybind("CTRL-SHIFT-F2", "SPELL 龙鹰守护")
    mybind("ALT-CTRL-F2", "SPELL 猎人印记")
    mybind("ALT-SHIFT-F2", "SPELL 黑箭")
    mybind("ALT-CTRL-SHIFT-F2", "CLICK volley:LeftButton")
    -- button = CreateFrame("Button", "forwardJump", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/run SetView(1)\n/run MouselookStart()\n/run MouselookStop()")
    -- button = CreateFrame("Button", "forwardJump2", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/stopcasting\n/cast 逃脱\n/run MouselookStart()\n/run RunNextFrame(function() MouselookStop() end)")
    mybind("CTRL-F3", "SPELL 假死")
    mybind("ALT-F3", "CLICK focusTranq:LeftButton")
    mybind("SHIFT-F3", "SPELL 杀戮命令")
    mybind("CTRL-SHIFT-F3", "CLICK focusMissd:LeftButton")
    mybind("ALT-CTRL-F3", "SPELL 猛禽一击")
    mybind("ALT-SHIFT-F3", "SPELL 冰霜陷阱")
    mybind("ALT-CTRL-SHIFT-F3", "CLICK forwardJump:LeftButton")
    -- button = CreateFrame("Button", "autoshot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting\n/cast 自动射击")
    -- button = CreateFrame("Button", "feedPet", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 香辣猛犸小吃")
    mybind("CTRL-F4", "CLICK autoshot:LeftButton")
    mybind("SHIFT-F4", "CLICK forwardJump2:LeftButton")
    mybind("CTRL-SHIFT-F4", "SPELL 逃脱")
    mybind("ALT-CTRL-F4", "CLICK feedPet:LeftButton")
    mybind("ALT-CTRL-SHIFT-F4", "SPELL 猫鼬撕咬")
    mybind("CTRL-F5", "SPELL 毒蛇陷阱")
    -- button = CreateFrame("Button", "burst1", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast 狂暴 \n/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14")
    -- button = CreateFrame("Button", "burst2", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext",
    --     "/cast 狂暴 \n/cast 血性狂怒 \n/use 10 \n/use 13 \n/use 14\n/use 速度药水\n/cast 急速射击\n/cast 野性呼唤")
    -- button = CreateFrame("Button", "burst3", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 10")
    -- button = CreateFrame("Button", "sapper", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/use 通用热力工程炸药")
    -- button = CreateFrame("Button", "saronite", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cast [@cursor] 萨隆邪铁炸弹")
    -- button = CreateFrame("Button", "healthStone", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/use 邪能治疗石")
    -- button = CreateFrame("Button", "stop", UIParent, "SecureActionButtonTemplate")
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/stopattack")
    -- button = CreateFrame("Button", "rocketBoot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/stopcasting \n/use 8")
    -- button = CreateFrame("Button", "turn", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/run SetView(1) \n/run MouselookStart() \n/run MouselookStop()")
    -- button = CreateFrame("Button", "cancelStorm", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/cancelaura 风暴之力")
    mybind("CTRL-F9", "CLICK stop:LeftButton")
    mybind("ALT-F9", "CLICK burst1:LeftButton")
    mybind("SHIFT-F9", "CLICK burst2:LeftButton")
    mybind("CTRL-SHIFT-F9", "CLICK burst3:LeftButton")
    mybind("ALT-CTRL-F9", "CLICK sapper:LeftButton")
    mybind("ALT-SHIFT-F9", "CLICK saronite:LeftButton")
    mybind("ALT-CTRL-SHIFT-F9", "CLICK healthStone:LeftButton")
    mybind("CTRL-F10", "CLICK rocketBoot:LeftButton")
    mybind("ALT-F10", "CLICK turn:LeftButton")
    mybind("CTRL-SHIFT-F10", "CLICK cancelStorm:LeftButton")
    mybind("CTRL-F11", "bbainsertburst1")
    mybind("ALT-F11", "bbainsertburst2")
    mybind("SHIFT-F11", "bbamodemain")
    mybind("CTRL-SHIFT-F11", "bbamodeaoe")
    mybind("ALT-CTRL-F11", "bbainsertsapper")
    mybind("ALT-SHIFT-F11", "bbainsertsaronite")
    mybind("ALT-CTRL-SHIFT-F11", "bbamodeaoe2")
    mybind("CTRL-F12", "bbainsertmissd")
    mybind("ALT-F12", "bbainsertlauncher")
    mybind("SHIFT-F12", "bbainsertblackArrow")
    mybind("CTRL-SHIFT-F12", "bbainsertfrostTrap")
    mybind("ALT-CTRL-F12", "bbainsertforwardJump")
    mybind("ALT-SHIFT-F12", "bbainsertburst3")
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
    -- button:SetAttribute("macrotext", "/petattack 镜像 \n/petattack 裹体之网")
    -- button = CreateFrame("Button", "tarEnemy", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/targetenemy [noharm] [dead]")
    -- button = CreateFrame("Button", "focusBoneSpike", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 骨针\n/focus\n/tar 玛洛加尔领主")
    -- button = CreateFrame("Button", "focusBloodBeast", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 血兽\n/focus\n/tar 死亡使者萨鲁法尔")
    -- button = CreateFrame("Button", "focusValkyr", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 瓦格里暗影戒卫者\n/focus\n/tar 巫妖王")
    -- button = CreateFrame("Button", "ktarget3", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "macro")
    -- button:SetAttribute("macrotext", "/tar 右臂\n/focus\n/petattack 左臂\n/tar 科隆加恩")
    mybind("CTRL-NUMPAD0", "CLICK tarBoss1:LeftButton")
    mybind("ALT-NUMPAD0", "CLICK tarBoss2:LeftButton")
    mybind("SHIFT-NUMPAD0", "CLICK tarBoss3:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD0", "CLICK clearMirror:LeftButton")
    mybind("ALT-CTRL-NUMPAD0", "CLICK tarEnemy:LeftButton")
    mybind("ALT-SHIFT-NUMPAD0", "CLICK focusBoneSpike:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD0", "CLICK focusBloodBeast:LeftButton")
    mybind("CTRL-NUMPAD1", "CLICK focusValkyr:LeftButton")
    mybind("ALT-NUMPAD1", "CLICK ktarget3:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "KillShot", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "杀戮射击")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusKillShot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "杀戮射击")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseKillShot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "杀戮射击")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petKillShot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "杀戮射击")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-INSERT", "CLICK raid1targetKillShot:LeftButton")
    mybind("ALT-INSERT", "CLICK raid2targetKillShot:LeftButton")
    mybind("SHIFT-INSERT", "CLICK raid3targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-INSERT", "CLICK raid4targetKillShot:LeftButton")
    mybind("ALT-CTRL-INSERT", "CLICK raid5targetKillShot:LeftButton")
    mybind("ALT-SHIFT-INSERT", "CLICK raid6targetKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-INSERT", "CLICK raid7targetKillShot:LeftButton")
    mybind("CTRL-DELETE", "CLICK raid8targetKillShot:LeftButton")
    mybind("ALT-DELETE", "CLICK raid9targetKillShot:LeftButton")
    mybind("SHIFT-DELETE", "CLICK raid10targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-DELETE", "CLICK raid11targetKillShot:LeftButton")
    mybind("ALT-CTRL-DELETE", "CLICK raid12targetKillShot:LeftButton")
    mybind("ALT-SHIFT-DELETE", "CLICK raid13targetKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-DELETE", "CLICK raid14targetKillShot:LeftButton")
    mybind("CTRL-HOME", "CLICK raid15targetKillShot:LeftButton")
    mybind("ALT-HOME", "CLICK raid16targetKillShot:LeftButton")
    mybind("SHIFT-HOME", "CLICK raid17targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-HOME", "CLICK raid18targetKillShot:LeftButton")
    mybind("ALT-CTRL-HOME", "CLICK raid19targetKillShot:LeftButton")
    mybind("ALT-SHIFT-HOME", "CLICK raid20targetKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-HOME", "CLICK raid21targetKillShot:LeftButton")
    mybind("CTRL-END", "CLICK raid22targetKillShot:LeftButton")
    mybind("ALT-END", "CLICK raid23targetKillShot:LeftButton")
    mybind("SHIFT-END", "CLICK raid24targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-END", "CLICK raid25targetKillShot:LeftButton")
    mybind("ALT-CTRL-END", "CLICK focusKillShot:LeftButton")
    mybind("ALT-SHIFT-END", "CLICK mouseKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-END", "CLICK petKillShot:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "KillShot", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "杀戮射击")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusKillShot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "杀戮射击")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseKillShot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "杀戮射击")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petKillShot", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "杀戮射击")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-INSERT", "CLICK raid1targetKillShot:LeftButton")
    mybind("ALT-INSERT", "CLICK raid2targetKillShot:LeftButton")
    mybind("SHIFT-INSERT", "CLICK raid3targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-INSERT", "CLICK raid4targetKillShot:LeftButton")
    mybind("ALT-CTRL-INSERT", "CLICK raid5targetKillShot:LeftButton")
    mybind("ALT-SHIFT-INSERT", "CLICK raid6targetKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-INSERT", "CLICK raid7targetKillShot:LeftButton")
    mybind("CTRL-DELETE", "CLICK raid8targetKillShot:LeftButton")
    mybind("ALT-DELETE", "CLICK raid9targetKillShot:LeftButton")
    mybind("SHIFT-DELETE", "CLICK raid10targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-DELETE", "CLICK raid11targetKillShot:LeftButton")
    mybind("ALT-CTRL-DELETE", "CLICK raid12targetKillShot:LeftButton")
    mybind("ALT-SHIFT-DELETE", "CLICK raid13targetKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-DELETE", "CLICK raid14targetKillShot:LeftButton")
    mybind("CTRL-HOME", "CLICK raid15targetKillShot:LeftButton")
    mybind("ALT-HOME", "CLICK raid16targetKillShot:LeftButton")
    mybind("SHIFT-HOME", "CLICK raid17targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-HOME", "CLICK raid18targetKillShot:LeftButton")
    mybind("ALT-CTRL-HOME", "CLICK raid19targetKillShot:LeftButton")
    mybind("ALT-SHIFT-HOME", "CLICK raid20targetKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-HOME", "CLICK raid21targetKillShot:LeftButton")
    mybind("CTRL-END", "CLICK raid22targetKillShot:LeftButton")
    mybind("ALT-END", "CLICK raid23targetKillShot:LeftButton")
    mybind("SHIFT-END", "CLICK raid24targetKillShot:LeftButton")
    mybind("CTRL-SHIFT-END", "CLICK raid25targetKillShot:LeftButton")
    mybind("ALT-CTRL-END", "CLICK focusKillShot:LeftButton")
    mybind("ALT-SHIFT-END", "CLICK mouseKillShot:LeftButton")
    mybind("ALT-CTRL-SHIFT-END", "CLICK petKillShot:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "Serpent", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "毒蛇钉刺")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusSerpent", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "毒蛇钉刺")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseSerpent", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "毒蛇钉刺")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petSerpent", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "毒蛇钉刺")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-PAGEUP", "CLICK raid1targetSerpent:LeftButton")
    mybind("ALT-PAGEUP", "CLICK raid2targetSerpent:LeftButton")
    mybind("SHIFT-PAGEUP", "CLICK raid3targetSerpent:LeftButton")
    mybind("CTRL-SHIFT-PAGEUP", "CLICK raid4targetSerpent:LeftButton")
    mybind("ALT-CTRL-PAGEUP", "CLICK raid5targetSerpent:LeftButton")
    mybind("ALT-SHIFT-PAGEUP", "CLICK raid6targetSerpent:LeftButton")
    mybind("ALT-CTRL-SHIFT-PAGEUP", "CLICK raid7targetSerpent:LeftButton")
    mybind("CTRL-PAGEDOWN", "CLICK raid8targetSerpent:LeftButton")
    mybind("ALT-PAGEDOWN", "CLICK raid9targetSerpent:LeftButton")
    mybind("SHIFT-PAGEDOWN", "CLICK raid10targetSerpent:LeftButton")
    mybind("CTRL-SHIFT-PAGEDOWN", "CLICK raid11targetSerpent:LeftButton")
    mybind("ALT-CTRL-PAGEDOWN", "CLICK raid12targetSerpent:LeftButton")
    mybind("ALT-SHIFT-PAGEDOWN", "CLICK raid13targetSerpent:LeftButton")
    mybind("ALT-CTRL-SHIFT-PAGEDOWN", "CLICK raid14targetSerpent:LeftButton")
    mybind("CTRL-[", "CLICK raid15targetSerpent:LeftButton")
    mybind("ALT-[", "CLICK raid16targetSerpent:LeftButton")
    mybind("SHIFT-[", "CLICK raid17targetSerpent:LeftButton")
    mybind("CTRL-SHIFT-[", "CLICK raid18targetSerpent:LeftButton")
    mybind("ALT-CTRL-[", "CLICK raid19targetSerpent:LeftButton")
    mybind("ALT-SHIFT-NUMPAD5", "CLICK raid20targetSerpent:LeftButton")
    mybind("ALT-CTRL-SHIFT-[", "CLICK raid21targetSerpent:LeftButton")
    mybind("CTRL-]", "CLICK raid22targetSerpent:LeftButton")
    mybind("ALT-]", "CLICK raid23targetSerpent:LeftButton")
    mybind("SHIFT-]", "CLICK raid24targetSerpent:LeftButton")
    mybind("CTRL-SHIFT-]", "CLICK raid25targetSerpent:LeftButton")
    mybind("ALT-CTRL-]", "CLICK focusSerpent:LeftButton")
    mybind("ALT-SHIFT-]", "CLICK mouseSerpent:LeftButton")
    mybind("ALT-CTRL-SHIFT-]", "CLICK petSerpent:LeftButton")
    -- for k, v in ipairs(raidMemberTargetUnitStr) do
    --     button = CreateFrame("Button", v .. "Es", UIParent, "SecureActionButtonTemplate");
    --     button:SetAttribute("type", "spell")
    --     button:SetAttribute("spell", "爆炸射击")
    --     button:SetAttribute("unit", v)
    -- end
    -- button = CreateFrame("Button", "focusEs", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "爆炸射击")
    -- button:SetAttribute("unit", "focus")
    -- button = CreateFrame("Button", "mouseEs", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "爆炸射击")
    -- button:SetAttribute("unit", "mouseover")
    -- button = CreateFrame("Button", "petEs", UIParent, "SecureActionButtonTemplate");
    -- button:SetAttribute("type", "spell")
    -- button:SetAttribute("spell", "爆炸射击")
    -- button:SetAttribute("unit", "pettarget")
    mybind("CTRL-NUMPAD6", "CLICK raid1targetEs:LeftButton")
    mybind("ALT-NUMPAD6", "CLICK raid2targetEs:LeftButton")
    mybind("SHIFT-NUMPAD6", "CLICK raid3targetEs:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD6", "CLICK raid4targetEs:LeftButton")
    mybind("ALT-CTRL-NUMPAD6", "CLICK raid5targetEs:LeftButton")
    mybind("ALT-SHIFT-NUMPAD6", "CLICK raid6targetEs:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD6", "CLICK raid7targetEs:LeftButton")
    mybind("CTRL-NUMPAD7", "CLICK raid8targetEs:LeftButton")
    mybind("ALT-NUMPAD7", "CLICK raid9targetEs:LeftButton")
    mybind("SHIFT-NUMPAD7", "CLICK raid10targetEs:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD7", "CLICK raid11targetEs:LeftButton")
    mybind("ALT-CTRL-NUMPAD7", "CLICK raid12targetEs:LeftButton")
    mybind("ALT-SHIFT-NUMPAD7", "CLICK raid13targetEs:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD7", "CLICK raid14targetEs:LeftButton")
    mybind("CTRL-NUMPAD8", "CLICK raid15targetEs:LeftButton")
    mybind("ALT-NUMPAD8", "CLICK raid16targetEs:LeftButton")
    mybind("SHIFT-NUMPAD8", "CLICK raid17targetEs:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD8", "CLICK raid18targetEs:LeftButton")
    mybind("ALT-CTRL-NUMPAD8", "CLICK raid19targetEs:LeftButton")
    mybind("ALT-SHIFT-NUMPAD8", "CLICK raid20targetEs:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD8", "CLICK raid21targetEs:LeftButton")
    mybind("CTRL-NUMPAD9", "CLICK raid22targetEs:LeftButton")
    mybind("ALT-NUMPAD9", "CLICK raid23targetEs:LeftButton")
    mybind("SHIFT-NUMPAD9", "CLICK raid24targetEs:LeftButton")
    mybind("CTRL-SHIFT-NUMPAD9", "CLICK raid25targetEs:LeftButton")
    mybind("ALT-CTRL-NUMPAD9", "CLICK focusEs:LeftButton")
    mybind("ALT-SHIFT-NUMPAD9", "CLICK mouseEs:LeftButton")
    mybind("ALT-CTRL-SHIFT-NUMPAD9", "CLICK petEs:LeftButton")
end

local spellnameMap = {
    ["多重射击"] = "multiShot",
    ["黑箭"] = "blackArrow",
    ["冰霜陷阱"] = "frostTrap",
    ["假死"] = "feignDeath",
    ["毒蛇钉刺"] = "serpent",
    ["杀戮射击"] = "killShot",
    ["爆炸射击"] = "explosiveShot",
    ["蝰蛇守护"] = "viper",
    ["猎人印记"] = "mark",
    ["奇美拉射击"] = "chimera",
    ["稳固射击"] = "steadyShot",
    ["猫鼬撕咬"] = "mBite",
    ["杀戮命令"] = "killCommand",
    ["猛禽一击"] = "raptor",
    ["龙鹰守护"] = "dragonhawk",
    ["毒蛇陷阱"] = "snakeTrap",
    ["瞄准射击"] = "aimedShot",
    ["逃脱"] = "forwardJump"
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
        local suffixes = {"KillShot", "Es", "Serpent", "Missd", "Tranq"}
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
print(eventJson)
print(keybindJson)
print(newJson)
