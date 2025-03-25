if UnitClassBase("player")~="PRIEST" then
    return
end

local MacroButton
local classFilename, classId = UnitClassBase("player")

    DEFAULT_CHAT_FRAME:AddMessage("欢迎使用猪猪的一键宏\n微信chengjnuu", 1, 1, 0)
    
    MacroButton = CreateFrame("Button", "SF1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 吸血鬼之触")
    
    MacroButton = CreateFrame("Button", "SF2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 暗言术：痛")
    
    MacroButton = CreateFrame("Button", "SF3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 噬灵疫病")
    
    MacroButton = CreateFrame("Button", "SF4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 心灵震爆")    
    
    MacroButton = CreateFrame("Button", "SF5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [nochanneling:精神鞭笞] 精神鞭笞")
    
    MacroButton = CreateFrame("Button", "SF6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 暗言术：灭")
    
    MacroButton = CreateFrame("Button", "SF7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 暗影恶魔\n/cast 暗影魔")            
    
    MacroButton = CreateFrame("Button", "SF8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST /cast [nostance:1]!暗影形态")
    
    MacroButton = CreateFrame("Button", "SF9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")        
    
    MacroButton = CreateFrame("Button", "SF10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus] 噬灵疫病")        
    
    MacroButton = CreateFrame("Button", "CF1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 消散")    
    
    MacroButton = CreateFrame("Button", "CF2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus] 心灵震爆")    
    
    MacroButton = CreateFrame("Button", "CF3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus] 吸血鬼之触")    
    
    MacroButton = CreateFrame("Button", "CF4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus] 暗言术：痛")    
    
    MacroButton = CreateFrame("Button", "CF5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=mouseover] 吸血鬼之触")    
    
    MacroButton = CreateFrame("Button", "CF6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=mouseover] 暗言术：痛")    
    
    MacroButton = CreateFrame("Button", "CF7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=focus] 精神鞭笞")    
    
    MacroButton = CreateFrame("Button", "CF8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=mouseover] 精神鞭笞")    
    
    MacroButton = CreateFrame("Button", "CF9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=mouseover] 噬灵疫病")    
    
    MacroButton = CreateFrame("Button", "CF10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [target=mouseover] 心灵震爆")    
    
    MacroButton = CreateFrame("Button", "AN1", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast [nochanneling:精神灼烧] 精神灼烧")    
    
    MacroButton = CreateFrame("Button", "AN2", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/CAST 心灵之火")    
    
    MacroButton = CreateFrame("Button", "AN3", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/cast 吸血鬼的拥抱")    
    
    MacroButton = CreateFrame("Button", "AN4", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/targetenemy")    
    
    MacroButton = CreateFrame("Button", "AN5", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "/USE 10\n/cast 狂暴(种族特长)\n/cast 血性狂怒(种族特长)")    
    
    MacroButton = CreateFrame("Button", "AN6", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "AN7", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    MacroButton = CreateFrame("Button", "AN8", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext", "")    
    
    
    MacroButton = CreateFrame("Button", "AN9", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext","")    
    
    MacroButton = CreateFrame("Button", "AN10", UIParent, "SecureActionButtonTemplate");
    MacroButton:SetAttribute("type", "macro")
    MacroButton:SetAttribute("macrotext","")    
    
    
    
    
    
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

