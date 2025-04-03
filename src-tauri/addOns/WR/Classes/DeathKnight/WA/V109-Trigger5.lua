function WR_DeathKnight_WA_Trigger5()
    local _, subEvent, _, sourceGUID, _, _, _, _, _, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()
    if subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and spellName == aura_env.fwwqzx then
        if aura_env.wzdjCDRemaining <= 0 and
            (aura_env.djqd == true or UnitName("target") == "大领主的训练假人" or zhandoumoshi == 1) then
            aura_env.djsfdl = 1
            C_Timer.After(10, function()
                aura_env.djsfdl = 0
            end)
        end
    elseif subEvent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and spellName == aura_env.wzdj then
        aura_env.djsfdl = 0
    end
end
