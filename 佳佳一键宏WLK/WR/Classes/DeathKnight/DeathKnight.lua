-- 作者微信:WOW-Robot(转载请保留,感谢!)
-- 死亡骑士
function WR_DeathKnight()
    WR_DeathKnightSettings() -- 初始化储存值
    WR_DeathKnightConfigFrame() -- 创建的设置窗口
    WR_DeathKnightSettingsSave() -- 设置写入
    WR_DeathKnightFrameShowOrHide() -- 对应专精显示或隐藏
    WR_DeathKnight_WA_Action() -- 死亡骑士WA
    WR_DeathKnightFunction() -- 死亡骑士运行库
end

-- 初始化储存值
function WR_DeathKnightSettings()

    if WRSet == nil then
        local Settings = {
            -- Stop=true,	--自动停止
            -- ZZ=1,	--职责

            XE_DL = 1, -- 枯萎凋零位置
            XE_AOE = 1, -- AOE模式
            XE_GJ = 1 -- 挂机模式
        }
        WRSet = Settings
    end
end

-- 设置写入
function WR_DeathKnightSettingsSave()
    if WRSet ~= nil then
        -- WRSet.Stop=WR_StopCheckbox:GetChecked() --自动停止
        -- WRSet.ZZ=UIDropDownMenu_GetSelectedID(ZZ_Dropdown) --职责
        WRSet.XE_DL = UIDropDownMenu_GetSelectedID(XE_DL_Dropdown) -- 枯萎凋零位置
        WRSet.XE_AOE = UIDropDownMenu_GetSelectedID(XE_AOE_Dropdown) -- AOE模式
        WRSet.XE_BF = UIDropDownMenu_GetSelectedID(XE_BF_Dropdown) -- 爆发模式
        WRSet.XE_GJ = UIDropDownMenu_GetSelectedID(XE_GJ_Dropdown) -- 挂机模式
    end
end

-- 对应专精显示或隐藏
function WR_DeathKnightFrameShowOrHide()
    local SUM = 1
    local Talent = WR_DeathKnight_GetTalent()
    if Talent == "鲜血" then -- 鲜血
        TianFu_Text:SetText("|cffff69b4鲜血")
        -- XX_Frame:Show()
        WowRobotConfigFrame:SetSize(185, 100 + (SUM + 5) * 35)
    end
    if Talent == "冰霜" then -- 冰霜
        TianFu_Text:SetText("|cffff69b4冰霜")
        -- BS_Frame:Show()
        WowRobotConfigFrame:SetSize(185, 100 + (SUM + 5) * 35)
    end
    if Talent == "邪恶" or Talent == nil then -- 邪恶
        TianFu_Text:SetText("|cffff69b4邪恶")
        XE_Frame:Show()
        WowRobotConfigFrame:SetSize(185, 100 + (SUM + 5) * 35)
    end

end

-- 获取当前天赋
function WR_DeathKnight_GetTalent()
    local holyPoints = 0
    local protectionPoints = 0
    local retributionPoints = 0

    -- 获取神圣天赋点数
    for i = 1, GetNumTalents(1) do
        local name, _, _, _, rank, maxRank = GetTalentInfo(1, i)
        holyPoints = holyPoints + rank
    end

    -- 获取防护天赋点数
    for i = 1, GetNumTalents(2) do
        local name, _, _, _, rank, maxRank = GetTalentInfo(2, i)
        protectionPoints = protectionPoints + rank
    end

    -- 获取惩戒天赋点数
    for i = 1, GetNumTalents(3) do
        local name, _, _, _, rank, maxRank = GetTalentInfo(3, i)
        retributionPoints = retributionPoints + rank
    end

    if holyPoints > protectionPoints and holyPoints > retributionPoints then
        return "鲜血"
    elseif protectionPoints > holyPoints and protectionPoints > retributionPoints then
        return "冰霜"
    elseif retributionPoints > holyPoints and retributionPoints > protectionPoints then
        return "邪恶"
    else
        return nil
    end
end
