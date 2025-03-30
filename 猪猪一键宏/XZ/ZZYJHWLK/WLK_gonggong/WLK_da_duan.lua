-- 创建一个框架用于更新检测
local updateFrame = CreateFrame("Frame")

-- 定义目标和焦点的变量
dd, gt, yddd, ydgt = nil, nil, nil, nil
jddd, jdgt, jdyddd, jdydgt = nil, nil, nil, nil

-- 创建一个函数来更新施法和通道信息
local function updateCastInfo(self, elapsed)
    -- 更新目标的施法信息
    local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo("target")
    if endTimeMS ~= nil then
        dd = endTimeMS / 1000 - GetTime()
        gt = notInterruptible
    else
        dd = nil
        gt = nil
    end

    -- 更新目标的通道信息
    local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible, spellId = UnitChannelInfo("target")
    if startTimeMS ~= nil then
        yddd = GetTime() - startTimeMS / 1000
        ydgt = notInterruptible
    else
        yddd = nil
        ydgt = nil
    end

    -- 更新焦点的施法信息
    local fname, ftext, ftexture, fstartTimeMS, fendTimeMS, fisTradeSkill, fcastID, fnotInterruptible, fspellId = UnitCastingInfo("focus")
    if fendTimeMS ~= nil then
        jddd = fendTimeMS / 1000 - GetTime()
        jdgt = fnotInterruptible
    else
        jddd = nil
        jdgt = nil
    end

    -- 更新焦点的通道信息
    local fname, ftext, ftexture, fstartTimeMS, fendTimeMS, fisTradeSkill, fnotInterruptible, fspellId = UnitChannelInfo("focus")
    if fstartTimeMS ~= nil then
        jdyddd = GetTime() - fstartTimeMS / 1000
        jdydgt = fnotInterruptible
    else
        jdyddd = nil
        jdydgt = nil
    end
end

-- 设置框架在每一帧时调用 updateCastInfo 函数
updateFrame:SetScript("OnUpdate", updateCastInfo)
