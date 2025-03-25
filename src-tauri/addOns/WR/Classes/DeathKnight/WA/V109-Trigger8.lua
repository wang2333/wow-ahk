function WR_DeathKnight_WA_Trigger8()
    local instanceName, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
    if instanceName then
        if instanceName == "十字军的试炼" then
            local currentTime = GetTime()
            local sxBuffRemaining = 0
            if WR_GetUnitBuffInfo("player", aura_env.sx, true) then
                sxBuffRemaining = WR_GetUnitBuffInfo("player", aura_env.sx, true)
            end
            local yyBuffRemaining = 0
            if WR_GetUnitBuffInfo("player", aura_env.yy, true) then
                yyBuffRemaining = WR_GetUnitBuffInfo("player", aura_env.yy, true)
            end
            local targetHealthPercent = UnitHealth("target") / UnitHealthMax("target") * 100
            local subZone = GetSubZoneText()
            local bossName = UnitName("target")
            local mapID = C_Map.GetBestMapForUnit("player")
            local Isboss = UnitLevel("target")
            aura_env.bfqd1 = false
            aura_env.bfqd2 = false
            aura_env.bfqd3 = false
            aura_env.djqd = false
            if bossName == "穿刺者戈莫克" then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            elseif bossName == "冰吼" and aura_env.bhys == true then
                aura_env.bfqd3 = true
                aura_env.djqd = true
            elseif bossName == "加拉克苏斯大王" then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            elseif bossName == "黑暗邪使艾蒂丝" or bossName == "光明邪使菲奥拉" then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            elseif sxBuffRemaining > 0 or yyBuffRemaining > 0 then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            elseif bossName == "阿努巴拉克" and targetHealthPercent > 60 then
                aura_env.bfqd1 = true
            elseif bossName == "阿努巴拉克" and targetHealthPercent < 35 and
                (sxBuffRemaining > 0 or yyBuffRemaining > 0) then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            end
        end
    end
end
