function WR_DeathKnight_WA_Trigger7()
    local instanceName, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
    if instanceName then
        if instanceName == "奥杜尔" then
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
            aura_env.djqd = false
            if aura_env.zone1[subZone] then
                aura_env.bfqd2 = true
                aura_env.djqd = true
            elseif subZone == "锋鳞之巢" and bossName == "锋鳞" then
                aura_env.bfqd2 = true
                aura_env.djqd = true
            elseif subZone == "天文台" then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            elseif subZone == "废料场" then
                if ((bossName == "XT-002拆解者" and targetHealthPercent <= 78) or bossName == "拆解者之心") then
                    aura_env.bfqd2 = true
                    aura_env.djqd = true
                end
            elseif subZone == "钢铁议会" or subZone == "寒冬大厅" or subZone == "生命温室" then
                if sxBuffRemaining > 0 or yyBuffRemaining > 0 then
                    aura_env.bfqd2 = true
                    aura_env.djqd = true
                end
            elseif subZone == "雷霆角斗场" and bossName == "托里姆" then
                aura_env.bfqd1 = true
                aura_env.djqd = true
            elseif subZone == "思想火花" then
                if bossName == "巨兽二型" or bossName == "VX-001" or sxBuffRemaining > 0 or yyBuffRemaining > 0 then
                    aura_env.bfqd2 = true
                    aura_env.djqd = true
                end
            elseif subZone == "疯狂阶梯" then
                if (bossName == "维扎克斯将军" and targetHealthPercent >= 70) or sxBuffRemaining > 0 or
                    yyBuffRemaining > 0 then
                    aura_env.bfqd2 = true
                elseif sxBuffRemaining > 0 or yyBuffRemaining > 0 then
                    aura_env.bfqd2 = true
                    aura_env.djqd = true
                end
            elseif subZone == "尤格-萨隆的监狱" then
                if bossName == "尤格-萨隆" and targetHealthPercent < 30 then
                    aura_env.bfqd1 = true
                elseif sxBuffRemaining > 0 or yyBuffRemaining > 0 then
                    aura_env.bfqd2 = true
                end
            end
        end
    end
end
