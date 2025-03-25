if UnitClassBase("player") ~= "DEATHKNIGHT" then
    return
end

-- 初始化所有符文的变量（保持全局变量不变）
hong1cd = nil 
hong1rd = nil
hong2cd = nil 
hong2rd = nil
lv1cd = nil 
lv1rd = nil
lv2cd = nil 
lv2rd = nil
lan1cd = nil 
lan1rd = nil
lan2cd = nil 
lan2rd = nil

-- 初始化凋零状态和天灾打击的全局变量
diaolinghongse = false
diaolinglvse = false
diaolinglanse = false
diaolingzise = false
tianzaidaji = false

-- 更新符文冷却时间的函数
function updateRuneStatus(runeNumber, cdVar, rdVar, ziVar)
    local start, duration, runeReady = GetRuneCooldown(runeNumber)
    
    if start ~= nil and duration ~= nil then
        _G[cdVar] = (start + duration) - GetTime() > 0 and (start + duration) - GetTime() or nil
    else
        _G[cdVar] = nil
    end
    
    _G[rdVar] = runeReady  -- 直接设置为 true 或 false
    
    -- 更新符文类型
    _G[ziVar] = GetRuneType(runeNumber)
end

-- 定义符文信息列表，每个元素包含符文编号、冷却变量、准备变量和类型变量
local runes = {
    {1, "hong1cd", "hong1rd", "zi1"},
    {2, "hong2cd", "hong2rd", "zi2"},
    {3, "lv1cd", "lv1rd", "zi3"},
    {4, "lv2cd", "lv2rd", "zi4"},
    {5, "lan1cd", "lan1rd", "zi5"},
    {6, "lan2cd", "lan2rd", "zi6"},
}

-- 计算凋零阈值的函数
function calculateDiaoling()
    local start, duration, _, _ = GetSpellCooldown(49938)
    if start then
        return (start + duration) - GetTime() > 0 and (start + duration) - GetTime() or nil
    else
        return nil
    end
end

-- 检查两个符文是否满足凋零条件
local function checkDying(rd1, cd1, rd2, cd2, diaoling)
    if rd1 and cd2 and cd2 > 0 and diaoling > 0 and cd2 <= diaoling then
        return true
    end
    if rd2 and cd1 and cd1 > 0 and diaoling > 0 and cd1 <= diaoling then
        return true
    end
    if rd1 and rd2 then
        return true
    end
    return false
end

-- 检查紫色凋零状态（需要类型为4）
local function checkDyingZi(rd1, rd2, zi1, zi2, diaoling)
    if (zi1 == 4 or zi2 == 4) and rd1 and rd2 then
        return true
    end
    return checkDying(rd1, nil, rd2, nil, diaoling)  -- 调用普通凋零检查作为补充
end

-- 每帧调用的主逻辑
local function OnFrameUpdate()
    -- 更新所有符文的状态
    for _, rune in ipairs(runes) do
        updateRuneStatus(rune[1], rune[2], rune[3], rune[4])
    end

    -- 计算凋零阈值
    local diaoling = calculateDiaoling()

    -- 如果没有有效的凋零阈值，设置所有凋零状态为 false
    if not diaoling then
        diaolinghongse = false
        diaolinglvse = false
        diaolinglanse = false
        diaolingzise = false
        tianzaidaji = false
        return
    end

    -- 计算各颜色凋零状态
    diaolinghongse = checkDying(
        hong1rd, hong1cd, hong2rd, hong2cd, diaoling
    )
    diaolinglvse = checkDying(
        lv1rd, lv1cd, lv2rd, lv2cd, diaoling
    )
    diaolinglanse = checkDying(
        lan1rd, lan1cd, lan2rd, lan2cd, diaoling
    )

    -- 计算紫色凋零状态，确保包含 zi1 和 zi2 的判断
    diaolingzise = (function()
        if (GetRuneType(5) == 4 and hong1rd) or (GetRuneType(6) == 4 and hong2rd) then
            return true
        end
        return false
    end)()

    -- 天灾打击判断
    tianzaidaji = diaolinglanse and diaolinglvse
end

-- 注册事件，假设这是在魔兽世界插件开发环境下
local frame = CreateFrame("Frame")

-- 注册需要的事件，比如 PLAYER_LOGIN
frame:RegisterEvent("PLAYER_LOGIN")  -- 你可以根据需要注册其他事件

-- 设置每帧调用 OnFrameUpdate
frame:SetScript("OnUpdate", function(self, elapsed)
    OnFrameUpdate()
end)