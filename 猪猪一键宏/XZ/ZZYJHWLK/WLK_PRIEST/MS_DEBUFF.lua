if UnitClassBase("player")~="PRIEST" then
    return
end
-----------------------------
-- 演示用：Debuff 扫描示例
-- 将时间存到全局变量
-----------------------------

-- 先确保全局变量都存在（如果你已在别的地方声明，可省略此步）
chu, tong, shiling = nil, nil, nil       -- target
fchu, ftong, fshiling = nil, nil, nil    -- focus
mchu, mtong, mshiling = nil, nil, nil    -- mouseover

------------------------------------------------------------
-- 通用函数：GetMyDebuffs(unit)
-- 扫描指定unit身上1~40个Debuff，寻找“吸血鬼之触”“暗言术：痛”“噬灵疫病”
-- 如果找到了并且是玩家自己施放，则返回剩余时间
------------------------------------------------------------
local function GetMyDebuffs(unit)
    local localChu, localTong, localShiling

    -- 最多 40 个 Debuff，一旦三种都找到了就可以提前结束
    for i = 1, 40 do
        local name, _, _, _, _, expirationTime, source = UnitDebuff(unit, i)
        if not name then
            -- 说明没有更多的 Debuff 了，直接结束扫描
            break
        end
        -- 只关心玩家自己施放的
        if source == "player" then
            if name == "吸血鬼之触" then
                localChu = expirationTime - GetTime()
            elseif name == "暗言术：痛" then
                localTong = expirationTime - GetTime()
            elseif name == "噬灵疫病" then
                localShiling = expirationTime - GetTime()
            end
        end

        -- 如果三个都已经检测到，就没必要再继续扫描
        if localChu and localTong and localShiling then
            break
        end
    end

    return localChu, localTong, localShiling
end

------------------------------------------------------------
-- 建立一个Frame，每帧调用 OnUpdate（演示用）
-- 如果想更高效，可用事件注册替代
------------------------------------------------------------
local frame = CreateFrame("Frame", "MyDebuffWatcher", UIParent)
frame:SetScript("OnUpdate", function(self, elapsed)
    -- 扫描 Target
    chu, tong, shiling = GetMyDebuffs("target")

    -- 扫描 Focus
    fchu, ftong, fshiling = GetMyDebuffs("focus")

    -- 扫描 Mouseover
    mchu, mtong, mshiling = GetMyDebuffs("mouseover")

    --------------------------------------------------------
    -- 你可以在这里对得到的全局变量进行 UI 显示或其他处理
    -- 例如仅用于调试，可以每帧在聊天窗口打印（实战中建议不要）
    -- print("T:", chu, tong, shiling, " | F:", fchu, ftong, fshiling, " | M:", mchu, mtong, mshiling)
    --------------------------------------------------------
end)
