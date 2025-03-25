function WR_DeathKnight_WA_Trigger3()
    local keyIsDown = false
    if aura_env.config.keyChoice1 then
        keyIsDown = IsShiftKeyDown()
    elseif aura_env.config.keyChoice2 then
        keyIsDown = IsKeyDown("F12")
    elseif aura_env.config.keyChoice3 then
        keyIsDown = IsAltKeyDown()
    end
    if keyIsDown and not aura_env.keyWasDown then
        if not aura_env.stateCounter then
            aura_env.stateCounter = 0
        end
        aura_env.stateCounter = (aura_env.stateCounter + 1) % 3
        if aura_env.stateCounter == 0 then
            aura_env.msqh = "qt"
        elseif aura_env.stateCounter == 1 then
            aura_env.msqh = "zd"
        elseif aura_env.stateCounter == 2 then
            aura_env.msqh = "dt"
        end
    end
    aura_env.keyWasDown = keyIsDown
    return false
end
