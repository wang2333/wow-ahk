-- 创建死亡骑士的设置窗口
function WR_DeathKnightConfigFrame()
    if WR_ConfigIsOK ~= nil then -- 如果已经执行过了，就不再执行
        return
    end
    WR_ConfigIsOK = true -- 记录已经执行过了
    -- 创建配置窗口
    local FrameWide = 185 -- 窗体宽度
    local FrameHigh = 250 -- 窗体高度
    local OptionsInterval = -15 -- 选项间隔
    local configFrame = CreateFrame("Frame", "WowRobotConfigFrame", UIParent, "UIPanelDialogTemplate")
    configFrame:SetSize(FrameWide, FrameHigh)
    configFrame:SetPoint("LEFT", -5, 0)
    configFrame:SetMovable(true)
    configFrame:EnableMouse(true)
    configFrame:RegisterForDrag("LeftButton")
    configFrame:SetScript("OnDragStart", configFrame.StartMoving)
    configFrame:SetScript("OnDragStop", configFrame.StopMovingOrSizing)
    configFrame:SetFrameStrata("FULLSCREEN") -- 设置框体的层级为FULLSCREEN全屏幕层
    configFrame:Hide()

    -- 设置窗口标题
    configFrame.title = configFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    configFrame.title:SetPoint("TOP", configFrame.Title, "TOP", 0, 0)
    configFrame.title:SetText("|cff00adf0WOW-Robot")
    -----------------------------------------------------------------------------------------------------

    -- 创建图标
    local iconTexture = configFrame:CreateTexture(nil, "ARTWORK")
    iconTexture:SetSize(40, 40)
    iconTexture:SetPoint("TOPLEFT", 20, -35)
    iconTexture:SetTexture("Interface\\AddOns\\WR\\Color\\WOW-Robot.tga")
    -----------------------------------------------------------------------------------------------------

    -- 创建勾选框
    checkbox = CreateFrame("CheckButton", "WR_TestCheckbox", configFrame, "UICheckButtonTemplate")
    checkbox:SetPoint("LEFT", iconTexture, "RIGHT", 10, 0)
    checkbox:SetChecked(false)

    -- 鼠标指向时的提示
    checkbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("如果卡技能，请勾选此选项，\n可以查出卡在什么技能或功能上了。")
        GameTooltip:Show()
    end)

    -- 设置说明文字
    local TSMS_Text = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    TSMS_Text:SetText("调试模式")
    TSMS_Text:SetPoint("LEFT", checkbox, "RIGHT", 0, 0)
    -----------------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------------
    -- 设置说明文字
    local ZZ_Text = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    ZZ_Text:SetText("当前专精")
    ZZ_Text:SetPoint("TOPLEFT", iconTexture, "BOTTOMLEFT", 0, OptionsInterval)

    local TianFu_Frame = CreateFrame("Frame", nil, configFrame)
    TianFu_Frame:SetSize(90, 20) -- 设置Frame的大小，适应FontString的大小
    TianFu_Frame:SetPoint("LEFT", ZZ_Text, "RIGHT", 0, 0)

    -- 创建FontString
    TianFu_Text = TianFu_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    TianFu_Text:SetText("邪恶")
    TianFu_Text:SetAllPoints(TianFu_Frame) -- 让FontString填满Frame

    -- 鼠标指向时的提示
    TianFu_Frame:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("根据当前专精自动切换。")
        GameTooltip:Show()
    end)

    -- 鼠标离开时隐藏提示
    TianFu_Frame:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    ----------------------------------------------------------------------------------------------
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    ----------------------------------------------------------------------------------------------

    -- 邪恶 子窗体---------------------------------------------------------------------------------------------------
    XE_Frame = CreateFrame("Frame", "XE_Frame", configFrame)
    XE_Frame:SetSize(1, 1)
    XE_Frame:SetPoint("CENTER", 0, 0)
    -- 邪恶 子窗体---------------------------------------------------------------------------------------------------

    -----------------------------------------------------------------------------------------------------
    -- ????????????????????????????????????????????????????????
    -----------------------------------------------------------------------------------------------------
    -- 设置说明文字
    XE_DL_Text = XE_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    XE_DL_Text:SetText("凋零位置")
    XE_DL_Text:SetPoint("TOPRIGHT", ZZ_Text, "BOTTOMRIGHT", 0, OptionsInterval)

    -- 创建下拉菜单
    local dropdown = CreateFrame("Frame", "XE_DL_Dropdown", XE_Frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", XE_DL_Text, "RIGHT", -16, -2)

    -- 设置下拉菜单框架大小
    UIDropDownMenu_SetWidth(dropdown, 70)

    -- 初始化下拉菜单项
    local menuItems = {{
        text = "|cffffa500自身",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 1)
        end
    }, {
        text = "|cffa020f0鼠标",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 2)
        end
    }}

    -- 设置下拉菜单的初始化函数
    UIDropDownMenu_Initialize(dropdown, function()
        for _, item in ipairs(menuItems) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.text
            info.func = item.func
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- 鼠标指向时的提示
    dropdown:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("枯萎凋零释放位置。")
        GameTooltip:Show()
    end)

    -- 鼠标离开时隐藏提示
    dropdown:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    -- 读取存储的参数
    if WRSet.XE_DL == nil then
        UIDropDownMenu_SetSelectedID(dropdown, 1)
    else
        UIDropDownMenu_SetSelectedID(dropdown, WRSet.XE_DL)
    end

    -----------------------------------------------------------------------------------------------------
    -- ????????????????????????????????????????????????????????
    -----------------------------------------------------------------------------------------------------
    -- 设置说明文字
    XE_AOE_Text = XE_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    XE_AOE_Text:SetText("AOE模式")
    XE_AOE_Text:SetPoint("TOPRIGHT", XE_DL_Text, "BOTTOMRIGHT", 0, OptionsInterval)

    -- 创建下拉菜单
    local dropdown = CreateFrame("Frame", "XE_AOE_Dropdown", XE_Frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", XE_AOE_Text, "RIGHT", -16, -2)

    -- 设置下拉菜单框架大小
    UIDropDownMenu_SetWidth(dropdown, 70)

    -- 初始化下拉菜单项
    local menuItems = {{
        text = "自动",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 1)
        end
    }, {
        text = "单体",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 2)
        end
    }, {
        text = "AOE",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 3)
        end
    }}

    -- 设置下拉菜单的初始化函数
    UIDropDownMenu_Initialize(dropdown, function()
        for _, item in ipairs(menuItems) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.text
            info.func = item.func
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- 鼠标指向时的提示
    dropdown:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("AOE模式。")
        GameTooltip:Show()
    end)

    -- 鼠标离开时隐藏提示
    dropdown:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    -- 读取存储的参数
    if WRSet.XE_AOE == nil then
        UIDropDownMenu_SetSelectedID(dropdown, 1)
    else
        UIDropDownMenu_SetSelectedID(dropdown, WRSet.XE_AOE)
    end
    -----------------------------------------------------------------------------------------------------
    -- ????????????????????????????????????????????????????????
    -----------------------------------------------------------------------------------------------------
    XE_BF_Text = XE_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    XE_BF_Text:SetText("爆发加入循环")
    XE_BF_Text:SetPoint("TOPRIGHT", XE_AOE_Text, "BOTTOMRIGHT", 0, OptionsInterval)

    -- 创建下拉菜单
    local dropdown = CreateFrame("Frame", "XE_BF_Dropdown", XE_Frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", XE_BF_Text, "RIGHT", -16, -2)

    -- 设置下拉菜单框架大小
    UIDropDownMenu_SetWidth(dropdown, 70)

    -- 初始化下拉菜单项
    local menuItems = {{
        text = "|cffffa500开启",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 1)
        end
    }, {
        text = "|cffa020f0关闭",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 2)
        end
    }}

    -- 设置下拉菜单的初始化函数
    UIDropDownMenu_Initialize(dropdown, function()
        for _, item in ipairs(menuItems) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.text
            info.func = item.func
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- 鼠标指向时的提示
    dropdown:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("选择爆发加入循环。")
        GameTooltip:Show()
    end)

    -- 鼠标离开时隐藏提示
    dropdown:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    -- 读取存储的参数
    if WRSet.XE_BF == nil then
        UIDropDownMenu_SetSelectedID(dropdown, 1)
    else
        UIDropDownMenu_SetSelectedID(dropdown, WRSet.XE_BF)
    end

    -----------------------------------------------------------------------------------------------------
    -- ????????????????????????????????????????????????????????
    -----------------------------------------------------------------------------------------------------
    XE_GJ_Text = XE_Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    XE_GJ_Text:SetText("挂机模式")
    XE_GJ_Text:SetPoint("TOPRIGHT", XE_BF_Text, "BOTTOMRIGHT", 0, OptionsInterval)

    -- 创建下拉菜单
    local dropdown = CreateFrame("Frame", "XE_GJ_Dropdown", XE_Frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("LEFT", XE_GJ_Text, "RIGHT", -16, -2)

    -- 设置下拉菜单框架大小
    UIDropDownMenu_SetWidth(dropdown, 70)

    -- 初始化下拉菜单项
    local menuItems = {{
        text = "|cffffa500开启",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 1)
        end
    }, {
        text = "|cffa020f0关闭",
        func = function()
            UIDropDownMenu_SetSelectedID(dropdown, 2)
        end
    }}

    -- 设置下拉菜单的初始化函数
    UIDropDownMenu_Initialize(dropdown, function()
        for _, item in ipairs(menuItems) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = item.text
            info.func = item.func
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- 鼠标指向时的提示
    dropdown:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("挂机模式。")
        GameTooltip:Show()
    end)

    -- 鼠标离开时隐藏提示
    dropdown:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)

    -- 读取存储的参数
    if WRSet.XE_GJ == nil then
        UIDropDownMenu_SetSelectedID(dropdown, 1)
    else
        UIDropDownMenu_SetSelectedID(dropdown, WRSet.XE_GJ)
    end
    ----------------------------------------------------------------------------------------------
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    -- ????????????????????????????????????????????????????????
    ----------------------------------------------------------------------------------------------

    -- 显示和隐藏配置窗口的函数
    function ToggleConfigFrame()
        if configFrame:IsShown() then
            configFrame:Hide()
        else
            configFrame:Show()
        end
    end

    -- 注册聊天命令，当输入/wr时显示配置窗口
    SLASH_WOW_ROBOT1 = "/wr"
    SlashCmdList["WOW_ROBOT"] = ToggleConfigFrame

    -----------------------------------------------------------------------------------------------------
    -- 创建左下角点击弹出界面图标窗体
    local frame = CreateFrame("Button", "WR_ClickFrame", UIParent, "UIPanelButtonTemplate")
    frame:SetSize(25, 25) -- 设置框体大小
    frame:SetPoint("BOTTOMLEFT", 0, 0) -- 设置框体位置
    frame:SetFrameStrata("FULLSCREEN") -- 设置框体的层级为FULLSCREEN全屏幕层
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton") -- 注册左键点击拖动
    frame:SetScript("OnDragStart", frame.StartMoving) -- 开始拖动时调用StartMoving
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing) -- 停止拖动时调用StopMovingOrSizing
    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(frame)
    texture:SetTexture("Interface\\AddOns\\WR\\Color\\WOW-Robot.tga") -- 窗体图片路径
    frame:SetScript("OnClick", function(self, button, down)
        if configFrame:IsShown() then
            configFrame:Hide()
        else
            configFrame:Show()
        end
    end)
    frame:Show() -- 显示窗体
    -----------------------------------------------------------------------------------------------------
    -- 创建战斗识别窗体
    local frame = CreateFrame("Frame", "WR_CombatFrame")
    frame:SetSize(8, 8) -- 设置框体大小
    frame:SetPoint("BOTTOMRIGHT", 0, 0) -- 设置框体位置
    frame:SetFrameStrata("FULLSCREEN") -- 设置框体的层级为FULLSCREEN全屏幕层
    local texture = frame:CreateTexture(nil, "OVERLAY")
    texture:SetAllPoints(frame)
    texture:SetTexture("Interface\\AddOns\\WR\\Color\\Combat.tga") -- 窗体图片路径
    frame:Hide() -- 隐藏窗体
end

