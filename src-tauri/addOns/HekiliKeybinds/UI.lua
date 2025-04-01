-- 创建事件框架
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- 简化获取专精的函数
local function GetCurrentSpec()
    return GetSpecialization() or 0
end

-- 保持单一默认配置
local defaultSettings = {
    healSelf = true,
    healSelfThreshold = 35,
    healAlly = true,
    healAllyThreshold = 20,
    healingStone = true,
    healingStoneThreshold = 35,
    agraPotion = true,
    agraPotionThreshold = 25,
    blessingSacrifice = true,
    blessingSacrificeThreshold = 50,
    glorySelf = true,
    glorySelf_2 = true,
    glorySelfThreshold = 50,
    gloryAlly = true,
    gloryAlly_2 = true,
    gloryAllyThreshold = 20,
    dsSelf = false,
    dsSelfThreshold = 20,
    sysSelf = true,
    sysSelfThreshold = 50,
    fczdSelf = true,
    fczdSelfThreshold = 80,
    daduan = true,
    daduanThreshold = 20,
    jbgxplThreshold = 0.05,
    tqjnajThreshold = 0.10,
    guanghuan = true,
    ziyou = true,
    qusan = true,
    autoTAB = true,
    qscz = true,
    zczcdd = true,
    zhanfu = true,
    zhanfuSetting = "鼠标指向"
}

-- 在文件开头添加一个变量来存储UI元素的引用
local uiElements = {
    sliders = {},
    checkButtons = {},
    dropDowns = {}
}

-- 修改CreateSlider函数
local function CreateSlider(parent, anchorTo, yOffset, label, setting, minValue, maxValue, step, formatString, suffix)
    local slider = CreateFrame("Slider", nil, parent, "OptionsSliderTemplate")
    slider:SetPoint("BOTTOMLEFT", anchorTo, "TOPLEFT", 0, yOffset)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetWidth(310)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)

    local currentSpec = GetCurrentSpec()
    slider:SetValue(HSPlugin_Settings[currentSpec][setting])

    local sliderLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sliderLabel:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 5)
    local value = HSPlugin_Settings[currentSpec][setting]
    sliderLabel:SetText(label .. string.format(formatString, value) .. suffix)

    slider:SetScript("OnValueChanged", function(self, value)
        local currentSpec = GetCurrentSpec()
        HSPlugin_Settings[currentSpec][setting] = value
        sliderLabel:SetText(label .. string.format(formatString, value) .. suffix)
    end)

    slider:SetScript("OnMouseWheel", function(self, delta)
        local newValue = slider:GetValue() + (delta > 0 and step or -step)
        newValue = math.min(maxValue, math.max(minValue, newValue))
        slider:SetValue(newValue)
    end)

    -- 存储slider的引用和相关信息
    table.insert(uiElements.sliders, {
        slider = slider,
        label = sliderLabel,
        setting = setting,
        formatString = formatString,
        suffix = suffix
    })

    return slider, sliderLabel
end

-- 创建复选框控件
local function CreateCheckButton(parent, x, y, text, setting)
    local checkButton = CreateFrame("CheckButton", nil, parent, "ChatConfigCheckButtonTemplate")
    checkButton:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    checkButton.Text:SetText(text)

    local currentSpec = GetCurrentSpec()
    checkButton:SetChecked(HSPlugin_Settings[currentSpec][setting])
    
    checkButton:SetScript("OnClick", function(self)
        local currentSpec = GetCurrentSpec()  -- 在事件处理时重新获取当前专精
        HSPlugin_Settings[currentSpec][setting] = self:GetChecked()
    end)
    
    -- 存储checkButton的引用
    table.insert(uiElements.checkButtons, {
        button = checkButton,
        setting = setting
    })

    return checkButton
end

-- 创建下拉框控件
local function CreateDropDown(parent, x, y, setting, options)
    -- 创建一个框架来包含下拉框
    local frame = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    frame:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    local currentSpec = GetCurrentSpec()
    
    UIDropDownMenu_Initialize(frame, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        
        for i, option in ipairs(options) do
            info.text = option
            info.value = option
            info.func = function(self)
                local currentSpec = GetCurrentSpec()  -- 在事件处理时重新获取当前专精
                HSPlugin_Settings[currentSpec][setting] = self.value
                UIDropDownMenu_SetText(frame, self.value)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- 设置默认值
    UIDropDownMenu_SetWidth(frame, 90) -- 宽度
    UIDropDownMenu_SetText(frame, HSPlugin_Settings[currentSpec][setting])  -- 默认显示第一个选项

    -- 存储dropDown的引用
    table.insert(uiElements.dropDowns, {
        frame = frame,
        setting = setting
    })

    -- 返回下拉框控件
    return frame
end

-- 切换显示元素
local function ToggleElements(show, elements)
    for _, element in ipairs(elements) do
        element:SetShown(show)
    end
end

-- 优化后的创建UI函数
local function CreateUI()
    local frame = CreateFrame("Frame", "HS_UI_Frame", UIParent)
    frame:SetSize(350, 620)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetFrameStrata("DIALOG")
    frame:SetFrameLevel(100)
    frame:Hide()

    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetColorTexture(0, 0, 0)
    frame.bg:SetAlpha(0.7)
    frame.bg:SetAllPoints(frame)

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function() frame:Hide() end)

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -5)
    frame.title:SetText("插件设置")

    local mainElements = {}
    local secondaryElements = {}

    -- 使用优化后的CreateSlider函数
    local healSelfCheck = CreateCheckButton(frame, 20, -40, "圣疗自己", "healSelf")
    local healSelfSlider, healSelfLabel = CreateSlider(frame, healSelfCheck, -60, "圣疗自己血量：", "healSelfThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, healSelfCheck)
    table.insert(mainElements, healSelfSlider)
    table.insert(mainElements, healSelfLabel)

    -- 圣疗队友
    local healAllyCheck = CreateCheckButton(frame, 20, -120, "圣疗队友", "healAlly")
    local healAllySlider, healAllyLabel = CreateSlider(frame, healAllyCheck, -60, "圣疗队友血量：", "healAllyThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, healAllyCheck)
    table.insert(mainElements, healAllySlider)
    table.insert(mainElements, healAllyLabel)

    -- 治疗石
    local stoneCheck = CreateCheckButton(frame, 20, -200, "治疗石", "healingStone")
    local stoneSlider, stoneLabel = CreateSlider(frame, stoneCheck, -60, "治疗石血量：", "healingStoneThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, stoneCheck)
    table.insert(mainElements, stoneSlider)
    table.insert(mainElements, stoneLabel)

    -- 阿加治疗药水
    local potionCheck = CreateCheckButton(frame, 20, -280, "阿加治疗药水", "agraPotion")
    local potionSlider, potionLabel = CreateSlider(frame, potionCheck, -60, "阿加治疗药水血量：", "agraPotionThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, potionCheck)
    table.insert(mainElements, potionSlider)
    table.insert(mainElements, potionLabel)

    -- 牺牲祝福
    local sacrificeCheck = CreateCheckButton(frame, 20, -360, "牺牲祝福", "blessingSacrifice")
    local sacrificeSlider, sacrificeLabel = CreateSlider(frame, sacrificeCheck, -60, "牺牲祝福血量：", "blessingSacrificeThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, sacrificeCheck)
    table.insert(mainElements, sacrificeSlider)
    table.insert(mainElements, sacrificeLabel)

    -- 荣耀圣令自己
    local glorySelfCheck = CreateCheckButton(frame, 20, -440, "荣耀圣令自己", "glorySelf")
    local glorySelfCheck2 = CreateCheckButton(frame, 190, -440, "只用免费圣令自己", "glorySelf_2")
    local glorySelfSlider, glorySelfLabel = CreateSlider(frame, glorySelfCheck, -60, "荣耀圣令自己血量：", "glorySelfThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, glorySelfCheck)
    table.insert(mainElements, glorySelfCheck2)
    table.insert(mainElements, glorySelfSlider)
    table.insert(mainElements, glorySelfLabel)

    -- 荣耀圣令队友
    local gloryAllyCheck = CreateCheckButton(frame, 20, -520, "荣耀圣令队友", "gloryAlly")
    local gloryAllyCheck2 = CreateCheckButton(frame, 190, -520, "只用免费圣令队友", "gloryAlly_2")
    local gloryAllySlider, gloryAllyLabel = CreateSlider(frame, gloryAllyCheck, -60, "荣耀圣令队友血量：", "gloryAllyThreshold", 1, 100, 1, "%d", "%")
    table.insert(mainElements, gloryAllyCheck)
    table.insert(mainElements, gloryAllyCheck2)
    table.insert(mainElements, gloryAllySlider)
    table.insert(mainElements, gloryAllyLabel)

    -- 圣盾术
    local dsCheck = CreateCheckButton(frame, 20, -40, "圣盾术", "dsSelf")
    local dsSlider, dsLabel = CreateSlider(frame, dsCheck, -60, "圣盾术血量：", "dsSelfThreshold", 1, 100, 1, "%d", "%")
    table.insert(secondaryElements, dsCheck)
    table.insert(secondaryElements, dsSlider)
    table.insert(secondaryElements, dsLabel)

    -- 圣佑术
    local sysCheck = CreateCheckButton(frame, 20, -120, "圣佑术", "sysSelf")
    local sysSlider, sysLabel = CreateSlider(frame, sysCheck, -60, "圣佑术血量：", "sysSelfThreshold", 1, 100, 1, "%d", "%")
    table.insert(secondaryElements, sysCheck)
    table.insert(secondaryElements, sysSlider)
    table.insert(secondaryElements, sysLabel)

    -- 复仇之盾
    local fczdCheck = CreateCheckButton(frame, 20, -200, "复仇之盾", "fczdSelf")
    local fczdSlider, fczdLabel = CreateSlider(frame, fczdCheck, -60, "复仇之盾血量：", "fczdSelfThreshold", 1, 100, 1, "%d", "%")
    table.insert(secondaryElements, fczdCheck)
    table.insert(secondaryElements, fczdSlider)
    table.insert(secondaryElements, fczdLabel)

    -- 打断
    local daduanCheck = CreateCheckButton(frame, 20, -280, "打断", "daduan")
    local daduanSlider, daduanLabel = CreateSlider(frame, daduanCheck, -60, "读条到", "daduanThreshold", 1, 100, 1, "%d", "%以上打断")
    table.insert(secondaryElements, daduanCheck)
    table.insert(secondaryElements, daduanSlider)
    table.insert(secondaryElements, daduanLabel)

    -- 自动切换光环
    local ghCheck = CreateCheckButton(frame, 20, -360, "自动切换光环", "guanghuan")
    table.insert(secondaryElements, ghCheck)

    -- 自动自由祝福
    local zyCheck = CreateCheckButton(frame, 200, -360, "自动自由祝福", "ziyou")
    table.insert(secondaryElements, zyCheck)

    -- 自动驱散
    local qusanCheck = CreateCheckButton(frame, 20, -400, "自动驱散", "qusan")
    table.insert(secondaryElements, qusanCheck)

    -- 自动切换目标
    local autoTABCheck = CreateCheckButton(frame, 200, -400, "自动切换目标", "autoTAB")
    table.insert(secondaryElements, autoTABCheck)

    -- 驱散词缀
    local qsczCheck = CreateCheckButton(frame, 20, -440, "驱散词缀", "qscz")
    table.insert(secondaryElements, qsczCheck)

    -- 制裁之锤打断
    local zczcddCheck = CreateCheckButton(frame, 200, -440, "制裁之锤打断", "zczcdd")
    table.insert(secondaryElements, zczcddCheck)

    -- 战复
    local zhanfuCheck = CreateCheckButton(frame, 20, -480, "战复", "zhanfu")
    table.insert(secondaryElements, zhanfuCheck)

    -- 战复下拉框
    local zhanfuoptions = {"鼠标指向", "自动"}
    local zhanfudropDown = CreateDropDown(frame, 60, -480, "zhanfuSetting", zhanfuoptions)
	table.insert(secondaryElements, zhanfudropDown)

    -- 提前技能按键
    local tqjnajSlider, tqjnajLabel = CreateSlider(frame, secondaryElements[#secondaryElements], -75, "提前：", "tqjnajThreshold", 0.01, 1, 0.01, "%.2f", " 秒按键")
    tqjnajSlider:SetPoint("LEFT", frame, "LEFT", 20, -20)
    table.insert(secondaryElements, tqjnajSlider)
    table.insert(secondaryElements, tqjnajLabel)

    -- 脚本更新频率
    local jbgxplSlider, jbgxplLabel = CreateSlider(frame, secondaryElements[#secondaryElements], -90, "脚本更新频率：", "jbgxplThreshold", 0.01, 1, 0.01, "%.2f", " 秒")
    jbgxplSlider:SetPoint("LEFT", frame, "LEFT", 20, -20)
    table.insert(secondaryElements, jbgxplSlider)
    table.insert(secondaryElements, jbgxplLabel)

    ToggleElements(true, mainElements)
    ToggleElements(false, secondaryElements)

    local toggleButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    toggleButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, -25)
    toggleButton:SetSize(150, 25)
    toggleButton:SetText("切换选项")

    -- 修改切换按钮的点击事件
    local showingMain = true
    toggleButton:SetScript("OnClick", function()
        showingMain = not showingMain
        ToggleElements(showingMain, mainElements)
        ToggleElements(not showingMain, secondaryElements)
    end)

    -- 修改小地图按钮的点击事件
    local minimapButton = CreateFrame("Button", "HS_MinimapButton", Minimap)
    minimapButton:SetSize(32, 32)
    minimapButton:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -10, -10)
    minimapButton:SetNormalTexture("Interface\\Icons\\Spell_Holy_SealOfWrath")

    minimapButton:SetScript("OnClick", function()
        frame:SetShown(not frame:IsShown())
    end)

    minimapButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("点击打开插件设置")
        GameTooltip:Show()
    end)

    minimapButton:SetScript("OnLeave", function() GameTooltip:Hide() end)

    minimapButton:SetMovable(true)
    minimapButton:EnableMouse(true)
    minimapButton:RegisterForDrag("LeftButton")
    minimapButton:SetScript("OnDragStart", minimapButton.StartMoving)
    minimapButton:SetScript("OnDragStop", minimapButton.StopMovingOrSizing)
end

-- 修改UpdateUI函数
local function UpdateUI()
    local currentSpec = GetCurrentSpec()
    
    -- 更新所有滑块
    for _, sliderInfo in ipairs(uiElements.sliders) do
        local value = HSPlugin_Settings[currentSpec][sliderInfo.setting]
        sliderInfo.slider:SetValue(value)
        
        -- 获取原始标签名（不包含数值和后缀）
        local baseLabel = sliderInfo.label:GetText():match("^(.-)%d") or sliderInfo.label:GetText():gsub("：.*$", "：")
        
        -- 设置新的标签文本
        sliderInfo.label:SetText(baseLabel .. string.format(sliderInfo.formatString, value) .. sliderInfo.suffix)
    end
    
    -- 更新所有复选框
    for _, checkInfo in ipairs(uiElements.checkButtons) do
        local value = HSPlugin_Settings[currentSpec][checkInfo.setting]
        checkInfo.button:SetChecked(value)
    end
    
    -- 更新所有下拉框
    for _, dropInfo in ipairs(uiElements.dropDowns) do
        local value = HSPlugin_Settings[currentSpec][dropInfo.setting]
        UIDropDownMenu_SetText(dropInfo.frame, value)
    end
end

-- 修改OnAddonLoaded函数
local function OnAddonLoaded(_, _, addonName)
    if addonName ~= "HekiliKeybinds" then return end
    
    -- 初始化配置
    HSPlugin_Settings = HSPlugin_Settings or {}
    
    -- 确保每个专精都有配置
    for spec = 0, 3 do
        HSPlugin_Settings[spec] = HSPlugin_Settings[spec] or {}
        for k, v in pairs(defaultSettings) do
            if HSPlugin_Settings[spec][k] == nil then
                HSPlugin_Settings[spec][k] = v
            end
        end
    end

    CreateUI()
    UpdateUI()
end

-- 修改事件处理
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        OnAddonLoaded(self, event, ...)
    elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
        UpdateUI()
    elseif event == "PLAYER_ENTERING_WORLD" then
        UpdateUI()
    end
end)
