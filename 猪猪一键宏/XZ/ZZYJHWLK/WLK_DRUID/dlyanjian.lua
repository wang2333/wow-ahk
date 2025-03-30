if UnitClassBase("player")~="DRUID" then
    return
end

local MacroButton
local classFilename, classId = UnitClassBase("player")
    DEFAULT_CHAT_FRAME:AddMessage("欢迎使用猪猪的一键宏\n微信chengjnuu", 1, 1, 0)
    
    MacroButton = CreateFrame("Button", "SF1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 复生")
    
    MacroButton = CreateFrame("Button", "SF2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [nostance:3]!猎豹形态(变形)")
    
    MacroButton = CreateFrame("Button", "SF3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 猛虎之怒")
    
    MacroButton = CreateFrame("Button", "SF4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 狂暴")    
    
    MacroButton = CreateFrame("Button", "SF5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 精灵之火（野性）")
    
    MacroButton = CreateFrame("Button", "SF6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 野蛮咆哮")
    
    MacroButton = CreateFrame("Button", "SF7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 割裂")            
    
    MacroButton = CreateFrame("Button", "SF8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 凶猛撕咬")
    
    MacroButton = CreateFrame("Button", "SF9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 横扫(猎豹形态)")        
    
    MacroButton = CreateFrame("Button", "SF10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 斜掠")        
    
    MacroButton = CreateFrame("Button", "CF1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 裂伤(猎豹形态)")    
    
    MacroButton = CreateFrame("Button", "CF2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 撕碎")    
    
    MacroButton = CreateFrame("Button", "CF3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [@cursor] 自然之力")    
    
    MacroButton = CreateFrame("Button", "CF4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 星辰坠落")    
    
    MacroButton = CreateFrame("Button", "CF5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 虫群")    
    
    MacroButton = CreateFrame("Button", "CF6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 月火术")    
    
    MacroButton = CreateFrame("Button", "CF7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 星涌术")    
    
    MacroButton = CreateFrame("Button", "CF8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 星火术")    
    
    MacroButton = CreateFrame("Button", "CF9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 愤怒")    
    
    MacroButton = CreateFrame("Button", "CF10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 日光术")    
    
    MacroButton = CreateFrame("Button", "AN1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 裂伤(熊形态)")    
    
    MacroButton = CreateFrame("Button", "AN2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 割伤")    
    
    MacroButton = CreateFrame("Button", "AN3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 激怒")    
    
    MacroButton = CreateFrame("Button", "AN4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 痛击")    
    
    MacroButton = CreateFrame("Button", "AN5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 重殴")    
    
    MacroButton = CreateFrame("Button", "AN6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 粉碎")    
    
    MacroButton = CreateFrame("Button", "AN7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 横扫(熊形态)")    
    
    MacroButton = CreateFrame("Button", "AN8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast !熊形态")    
    
    MacroButton = CreateFrame("Button", "AN9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 毁灭")    
    
    MacroButton = CreateFrame("Button", "AN10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/startattack")    
    
    MacroButton = CreateFrame("Button", "CN1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 痛击(猎豹形态)")    
    MacroButton = CreateFrame("Button", "CN2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/USE 10\n/cast 狂暴(种族特长)\n/cast 血性狂怒(种族特长)")    
    
    MacroButton = CreateFrame("Button", "CN3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 猛击")    
    
    MacroButton = CreateFrame("Button", "CN4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 挑战咆哮")  

        MacroButton = CreateFrame("Button", "CN5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/use 邪能治疗石")  
    
    
    
    
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
    

