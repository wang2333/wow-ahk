if UnitClassBase("player") ~= "HUNTER" then
    return
end

local function createMacroButton(name, text)
    local button = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate")
    button:SetAttribute("type", "macro")
    button:SetAttribute("macrotext", text)
    return button
end

-- 创建按钮
createMacroButton("SF1", "/cast !雄鹰守护")
createMacroButton("SF2", "/CAST 冰霜陷阱")
createMacroButton("SF3", "/CAST 猛禽一击")
createMacroButton("SF4", "/CAST 猎人印记")
createMacroButton("SF5", "/CAST 杀戮射击")
createMacroButton("SF6", "/CAST 毒蛇钉刺")
createMacroButton("SF7", "/cast 爆炸射击")
createMacroButton("SF8", "/cast 黑箭")
createMacroButton("SF9", "/cast ")  -- Intentionally left blank
createMacroButton("SF10", "/CAST 灵狐守护")

createMacroButton("CF1", "/CAST 眼镜蛇射击")
createMacroButton("CF2", "/cast 稳固射击")
createMacroButton("CF3", "/cast 瞄准射击")
createMacroButton("CF4", "/cast 奇美拉射击")
createMacroButton("CF5", "/cast 杀戮命令")
createMacroButton("CF6", "/cast 集中火力")
createMacroButton("CF7", "/cast 奥术射击")
createMacroButton("CF8", "/cast 陷阱发射器")
createMacroButton("CF9", "/cast [@cursor] 爆炸陷阱")
createMacroButton("CF10", "/cast 多重射击")

createMacroButton("AN1", "/petattack")
createMacroButton("AN2", "/cast 野性呼唤\n/cast 急速射击")
createMacroButton("AN3", "/cast 准备就绪")
createMacroButton("AN4", "/USE 10\n/cast 狂暴(种族特长)\n/cast 血性狂怒(种族特长)\n/cast 狂野怒火")
createMacroButton("AN5", "/cast 热情")
createMacroButton("AN6", "/targetenemy")
createMacroButton("AN7", "/USE 10\n/cast 狂暴(种族特长)\n/cast 血性狂怒(种族特长)")

-- 绑定按键
SetBinding("SHIFT-F1", "CLICK SF1:LeftButton")
SetBinding("SHIFT-F2", "CLICK SF2:LeftButton")
SetBinding("SHIFT-F3", "CLICK SF3:LeftButton")
SetBinding("SHIFT-F4", "CLICK SF4:LeftButton")
SetBinding("SHIFT-F5", "CLICK SF5:LeftButton")
SetBinding("SHIFT-F6", "CLICK SF6:LeftButton")
SetBinding("SHIFT-F7", "CLICK SF7:LeftButton")
SetBinding("SHIFT-F8", "CLICK SF8:LeftButton")
SetBinding("SHIFT-F9", "CLICK SF9:LeftButton")
SetBinding("SHIFT-F10", "CLICK SF10:LeftButton")
SetBinding("CTRL-F1", "CLICK CF1:LeftButton")
SetBinding("CTRL-F2", "CLICK CF2:LeftButton")
SetBinding("CTRL-F3", "CLICK CF3:LeftButton")
SetBinding("CTRL-F4", "CLICK CF4:LeftButton")
SetBinding("CTRL-F5", "CLICK CF5:LeftButton")
SetBinding("CTRL-F6", "CLICK CF6:LeftButton")
SetBinding("CTRL-F7", "CLICK CF7:LeftButton")
SetBinding("CTRL-F8", "CLICK CF8:LeftButton")
SetBinding("CTRL-F9", "CLICK CF9:LeftButton")
SetBinding("CTRL-F10", "CLICK CF10:LeftButton")
SetBinding("ALT-NUMPAD1", "CLICK AN1:LeftButton")
SetBinding("ALT-NUMPAD2", "CLICK AN2:LeftButton")
SetBinding("ALT-NUMPAD3", "CLICK AN3:LeftButton")
SetBinding("ALT-NUMPAD4", "CLICK AN4:LeftButton")
SetBinding("ALT-NUMPAD5", "CLICK AN5:LeftButton")
SetBinding("ALT-NUMPAD6", "CLICK AN6:LeftButton")
SetBinding("ALT-NUMPAD7", "CLICK AN7:LeftButton")
SetBinding("ALT-NUMPAD8", "CLICK AN8:LeftButton")
SetBinding("ALT-NUMPAD9", "CLICK AN9:LeftButton")
SetBinding("ALT-NUMPAD0", "CLICK AN10:LeftButton")
SetBinding("CTRL-NUMPAD1", "CLICK CN1:LeftButton")
SetBinding("CTRL-NUMPAD2", "CLICK CN2:LeftButton")
SetBinding("CTRL-NUMPAD3", "CLICK CN3:LeftButton")
SetBinding("CTRL-NUMPAD4", "CLICK CN4:LeftButton")
SetBinding("CTRL-NUMPAD5", "CLICK CN5:LeftButton")
SetBinding("CTRL-NUMPAD6", "CLICK CN6:LeftButton")
SetBinding("CTRL-NUMPAD7", "CLICK CN7:LeftButton")
SetBinding("CTRL-NUMPAD8", "CLICK CN8:LeftButton")
SetBinding("CTRL-NUMPAD9", "CLICK CN9:LeftButton")
SetBinding("CTRL-NUMPAD0", "CLICK CN10:LeftButton")
SetBinding("NUMPAD1", "CLICK N1:LeftButton")
SetBinding("NUMPAD2", "CLICK N2:LeftButton")
SetBinding("NUMPAD3", "CLICK N3:LeftButton")
SetBinding("NUMPAD4", "CLICK N4:LeftButton")
SetBinding("NUMPAD5", "CLICK N5:LeftButton")
SetBinding("NUMPAD6", "CLICK N6:LeftButton")
SetBinding("NUMPAD7", "CLICK N7:LeftButton")
SetBinding("NUMPAD8", "CLICK N8:LeftButton")
SetBinding("NUMPAD9", "CLICK N9:LeftButton")
SetBinding("NUMPAD0", "CLICK N10:LeftButton")


