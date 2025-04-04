﻿local f = CreateFrame("Frame")

-- 注册 PLAYER_LOGIN 事件
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then

        if UnitClassBase("player")~="ROGUE" then
    return
end
-- 禁用生命值过低时的红色闪烁警告
SetCVar("doNotFlashLowHealthWarning", 1)
-- 关闭色盲模式
SetCVar("Colorblindsimulator", 0)
-- 伽马值1.0
SetCVar("gamma",1)
-- 亮度50
SetCVar("Brightness",50)
--对比度50
SetCVar("Contrast",50)

local MacroButton

    MacroButton = CreateFrame("Button", "SF1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 冷血")
    
    MacroButton = CreateFrame("Button", "SF2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 锁喉")
    
    MacroButton = CreateFrame("Button", "SF3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 割裂")
    
    MacroButton = CreateFrame("Button", "SF4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "SF5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 血之饥渴")
    
    MacroButton = CreateFrame("Button", "SF6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 毒伤")
    
    MacroButton = CreateFrame("Button", "SF7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 毁伤")            
    
    MacroButton = CreateFrame("Button", "SF8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus,exists] 脚踢;脚踢")
    
    MacroButton = CreateFrame("Button", "SF9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")        
    
    MacroButton = CreateFrame("Button", "SF10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 消失")        
    
    MacroButton = CreateFrame("Button", "CF1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 闪避")    
    
    MacroButton = CreateFrame("Button", "CF2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 暗影斗篷")    
    
    MacroButton = CreateFrame("Button", "CF3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 佯攻")    
    
    MacroButton = CreateFrame("Button", "CF4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "CF5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 刺骨")    
    
    MacroButton = CreateFrame("Button", "CF6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/startattack")    
    
    MacroButton = CreateFrame("Button", "CF7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus] 嫁祸诀窍")    
    
    
    MacroButton = CreateFrame("Button", "CF8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 脚踢")    
    
    MacroButton = CreateFrame("Button", "CF9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/stopattack")    
    
    MacroButton = CreateFrame("Button", "CF10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/施放 狂暴(种族特长)\n/施放 血性狂怒(种族特长)\n/use 13\n/use 14\n/use 10\n/cast 剑刃乱舞")    
    
    MacroButton = CreateFrame("Button", "AN1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 切割")    
    
    MacroButton = CreateFrame("Button", "AN2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 杀戮盛筵\n/use 13\n/use 14\n/use 10")    
    
    MacroButton = CreateFrame("Button", "AN3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/施放 狂暴(种族特长)\n/施放 血性狂怒(种族特长)\n/use 13\n/use 14\n/use 10\n/cast 冲动")    
    
    MacroButton = CreateFrame("Button", "AN4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 影袭")    
    
    MacroButton = CreateFrame("Button", "AN5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 破甲")    
    
    MacroButton = CreateFrame("Button", "AN6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 刀扇")    
    
    MacroButton = CreateFrame("Button", "AN7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/施放 狂暴(种族特长)\n/施放 血性狂怒(种族特长)\n/use 13\n/use 14\n/use 10")    
    
    MacroButton = CreateFrame("Button", "AN8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/use 13\n/use 14\n/use 10")    
    
    MacroButton = CreateFrame("Button", "AN9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/use 邪能治疗石")    
    
    MacroButton = CreateFrame("Button", "AN10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cancelaura 嫁祸诀窍")    
    
    MacroButton = CreateFrame("Button", "CN1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/use 速度药水")    
    
    
    MacroButton = CreateFrame("Button", "CN2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/use [@player] 通用热力工程炸药\n/use [@player] 萨隆邪铁炸弹")    
    
    
    MacroButton = CreateFrame("Button", "CN3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 邪恶攻击")    
    
    
    MacroButton = CreateFrame("Button", "CN4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 鬼魅攻击\n/cast 出血")    
    
    
    MacroButton = CreateFrame("Button", "CN5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 背刺")    
    
    
    MacroButton = CreateFrame("Button", "CN6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 伏击")    
    
    
    MacroButton = CreateFrame("Button", "CN7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "CN8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "CN9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "CN10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "N10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
MacroButton = CreateFrame("Button", "S1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")
    
    MacroButton = CreateFrame("Button", "S2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")
    
    MacroButton = CreateFrame("Button", "S3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")
    
    MacroButton = CreateFrame("Button", "S4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "S5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")
    
    MacroButton = CreateFrame("Button", "S6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")
    
    MacroButton = CreateFrame("Button", "S7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")            
    
    MacroButton = CreateFrame("Button", "S8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")
    
    MacroButton = CreateFrame("Button", "S9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")        
    
    MacroButton = CreateFrame("Button", "S10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")        
    
    MacroButton = CreateFrame("Button", "C1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "C8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/use 速度药水")    
    
    MacroButton = CreateFrame("Button", "C9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/target 黑暗邪使艾蒂丝")    
    
    MacroButton = CreateFrame("Button", "C10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/target 光明邪使菲奥拉")         


    
    ----------
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
    SetBinding("SHIFT-=", "CLICK S1:LeftButton")
    SetBinding("SHIFT--", "CLICK S2:LeftButton")
    SetBinding("SHIFT-p", "CLICK S3:LeftButton")
    SetBinding("SHIFT-o", "CLICK S4:LeftButton")
    SetBinding("SHIFT-i", "CLICK S5:LeftButton")
    SetBinding("SHIFT-l", "CLICK S6:LeftButton")
    SetBinding("SHIFT-k", "CLICK S7:LeftButton")
    SetBinding("SHIFT-j", "CLICK S8:LeftButton")
    SetBinding("SHIFT-m", "CLICK S9:LeftButton")
    SetBinding("SHIFT-n", "CLICK S10:LeftButton")
    SetBinding("CTRL-=", "CLICK C1:LeftButton")
    SetBinding("CTRL--", "CLICK C2:LeftButton")
    SetBinding("CTRL-p", "CLICK C3:LeftButton")
    SetBinding("CTRL-o", "CLICK C4:LeftButton")
    SetBinding("CTRL-i", "CLICK C5:LeftButton")
    SetBinding("CTRL-l", "CLICK C6:LeftButton")
    SetBinding("CTRL-k", "CLICK C7:LeftButton")
    SetBinding("CTRL-j", "CLICK C8:LeftButton")
    SetBinding("CTRL-m", "CLICK C9:LeftButton")
    SetBinding("CTRL-n", "CLICK C10:LeftButton") 

    
    
    
        print("欢迎使用猪猪一键宏，如果你的联系微信不是chengjnuu，均为盗版")
    end
end)

