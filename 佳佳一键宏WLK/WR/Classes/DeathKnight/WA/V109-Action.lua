function WR_DeathKnight_WA_Action()
    if aura_env ~= nil then
        return
    end
    aura_env = {}
    aura_env.msqh = "dt"
    aura_env.config = {
        bfkg = false,
        hmf = false,
        hmfName = "恐怖酒杯",
        szjName = "乌米尔，北地的风暴"
    }
    aura_env.blcm = GetSpellInfo(49909)
    aura_env.aydj = GetSpellInfo(49921)
    aura_env.zhsxg = GetSpellInfo(49206)
    aura_env.xxdj = GetSpellInfo(49930)
    aura_env.xyft = GetSpellInfo(49941)
    aura_env.cr = GetSpellInfo(50842)
    aura_env.tzdj = GetSpellInfo(55090)
    aura_env.dlcr = GetSpellInfo(49895)
    aura_env.kwdl = GetSpellInfo(49938)
    aura_env.fwwqzx = GetSpellInfo(47568)
    aura_env.wzdj = GetSpellInfo(42650)
    aura_env.hlfl = GetSpellInfo(45529)
    aura_env.ssgkl = GetSpellInfo(63560)
    aura_env.wzfs = GetSpellInfo(46584)
    aura_env.bgzd = GetSpellInfo(49222)
    aura_env.bsyb = GetSpellInfo(55095)
    aura_env.xzyb = GetSpellInfo(55078)
    aura_env.hdhj = GetSpellInfo(57623)
    aura_env.gj = GetSpellInfo(66803)
    aura_env.xxlq = GetSpellInfo(48266)
    aura_env.xelq = GetSpellInfo(48265)
    aura_env.sx = GetSpellInfo(2825)
    aura_env.yy = GetSpellInfo(65983)
    aura_env.dlszj = GetSpellInfo(53365)
    aura_env.hmf = GetSpellInfo(59626)
    aura_env.blcmdl = true
    aura_env.tzdjdl = false
    aura_env.bhzq = false
    aura_env.xz = 2
    aura_env.cs = 0
    aura_env.xxdjdl = true
    aura_env.xyftdl = false
    aura_env.aydjdl = true
    aura_env.kldl = false
    aura_env.tzdj1 = false
    aura_env.hlflbj = false
    aura_env.djsfdl = 0
    aura_env.time = 120
    aura_env.msqh = "zd"
    aura_env.inBossFight = false
    aura_env.csFight = false
    aura_env.testZones = {
        [1423] = true,
        [1454] = true,
        [1455] = true
    }
    aura_env.bsxz = 0
    aura_env.xexz = 0
    aura_env.xxxz = 0
    aura_env.getMaxRuneCooldown = function(rune1, rune2)
        local start1, duration1, ready1 = GetRuneCooldown(rune1)
        local start2, duration2, ready2 = GetRuneCooldown(rune2)
        local remaining1 = 0
        local remaining2 = 0
        if start1 and duration1 and not ready1 then
            remaining1 = math.max(start1 + duration1 - GetTime(), 0)
        end
        if start2 and duration2 and not ready2 then
            remaining2 = math.max(start2 + duration2 - GetTime(), 0)
        end
        return math.max(remaining1, remaining2)
    end
    aura_env.getMinRuneCooldown = function(rune3, rune4)
        local start3, duration3, ready3 = GetRuneCooldown(rune3)
        local start4, duration4, ready4 = GetRuneCooldown(rune4)
        local remaining3 = 0
        local remaining4 = 0
        if start3 and duration3 and not ready3 then
            remaining3 = math.max(start3 + duration3 - GetTime(), 0)
        end
        if start4 and duration4 and not ready4 then
            remaining4 = math.max(start4 + duration4 - GetTime(), 0)
        end
        return math.min(remaining3, remaining4)
    end
    aura_env.targets = aura_env.targets or {}
    aura_env.shiftWasDown = aura_env.shiftWasDown or false
    aura_env.shiftToggleState = false
    aura_env.decodedString1 = nil
    aura_env.decodedString2 = nil
    aura_env.decodedString3 = nil
    -- local data = WeakAuras.GetData(aura_env.id)
    -- local frame = WeakAuras.GetRegion(data.parent)
    local function decodeBytes(encodedBytes)
        local decodedBytes = {}
        for _, byte in ipairs(encodedBytes) do
            table.insert(decodedBytes, (byte - 3) % 256)
        end
        return decodedBytes
    end
    local function bytesToUtf8(bytes)
        local chars = {}
        local i = 1
        while i <= #bytes do
            local byte = bytes[i]
            if byte < 128 then
                table.insert(chars, string.char(byte))
                i = i + 1
            else
                local len = 2
                if byte >= 240 then
                    len = 4
                elseif byte >= 224 then
                    len = 3
                end
                table.insert(chars, string.char(unpack(bytes, i, i + len - 1)))
                i = i + len
            end
        end
        return table.concat(chars)
    end
    aura_env.createContentFrame = function(name, textContent)
        local frame = CreateFrame("Frame", name, UIParent, "BackdropTemplate")
        frame:SetSize(250, 150)
        frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        frame:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = {
                left = 4,
                right = 4,
                top = 4,
                bottom = 4
            }
        })
        frame:SetBackdropColor(0, 0, 0, 1)
        local editBox = CreateFrame("EditBox", nil, frame)
        editBox:SetMultiLine(true)
        editBox:SetSize(frame:GetWidth() - 40, frame:GetHeight())
        editBox:SetFontObject(GameFontNormal)
        editBox:SetAutoFocus(false)
        editBox:EnableMouse(false)
        editBox:SetEnabled(false)
        editBox:SetAllPoints(frame)
        editBox:SetText(textContent)
        editBox:SetTextInsets(20, 20, 20, 20)
        editBox:SetScript("OnEscapePressed", function()
            editBox:ClearFocus()
        end)
        return frame, editBox
    end
    local encodedBytes1 = {233, 159, 180, 235, 131, 132, 233, 160, 194, 232, 145, 162, 232, 139, 158, 233, 140, 150,
                           232, 159, 179, 236, 191, 163, 90, 68, 43, 233, 141, 153, 236, 162, 182, 236, 176, 151, 232,
                           136, 192, 90, 68, 233, 159, 180, 235, 131, 132, 233, 160, 194, 242, 191, 143, 232, 193, 177,
                           231, 194, 164, 109, 108, 110, 104, 54, 52, 53, 44, 232, 136, 185, 231, 190, 153, 233, 187,
                           163, 236, 132, 150, 235, 145, 186, 232, 146, 153, 234, 157, 135, 232, 160, 138, 231, 187,
                           189, 234, 158, 154, 234, 140, 139, 235, 194, 138, 233, 159, 162, 234, 140, 139, 233, 159,
                           175, 47, 233, 179, 187, 231, 188, 136, 236, 190, 148, 232, 147, 144, 232, 144, 152, 85, 88,
                           86, 75, 232, 150, 168, 47, 90, 82, 90, 232, 179, 146, 232, 187, 136, 47, 35, 235, 142, 180,
                           232, 138, 164, 236, 176, 151, 232, 136, 192, 47, 234, 174, 188, 232, 192, 180, 47, 235, 179,
                           171, 236, 155, 181, 231, 187, 141, 232, 192, 150}
    local decodedBytes1 = decodeBytes(encodedBytes1)
    aura_env.decodedString1 = bytesToUtf8(decodedBytes1)
    local encodedBytes2 = {233, 159, 180, 235, 131, 132, 233, 160, 194, 90, 68, 71, 78, 54, 90, 79, 78, 236, 133, 173,
                           233, 132, 185, 71, 78, 89, 52, 52, 56}
    local decodedBytes2 = decodeBytes(encodedBytes2)
    aura_env.decodedString2 = bytesToUtf8(decodedBytes2)
    local encodedBytes3 = {53, 51, 53, 55, 51, 55, 54, 51}
    local decodedBytes3 = decodeBytes(encodedBytes3)
    aura_env.decodedString3 = bytesToUtf8(decodedBytes3)
    local encodedBytes4 = {76, 113, 119, 104, 117, 105, 100, 102, 104, 95, 68, 103, 103, 82, 113, 118, 95, 70, 92, 93,
                           95, 232, 149, 137, 232, 150, 177, 49, 114, 106, 106}
    local decodedBytes4 = decodeBytes(encodedBytes4)
    aura_env.decodedString4 = bytesToUtf8(decodedBytes4)
    local encodedBytes5 = {76, 113, 119, 104, 117, 105, 100, 102, 104, 95, 68, 103, 103, 82, 113, 118, 95, 70, 92, 93,
                           95, 232, 140, 181, 235, 166, 133, 49, 114, 106, 106}
    local decodedBytes5 = decodeBytes(encodedBytes5)
    aura_env.decodedString5 = bytesToUtf8(decodedBytes5)
    local encodedBytes6 = {76, 113, 119, 104, 117, 105, 100, 102, 104, 95, 68, 103, 103, 82, 113, 118, 95, 70, 92, 93,
                           95, 233, 159, 139, 234, 132, 174, 49, 114, 106, 106}
    local decodedBytes6 = decodeBytes(encodedBytes6)
    aura_env.decodedString6 = bytesToUtf8(decodedBytes6)
    local encodedBytes7 = {76, 113, 119, 104, 117, 105, 100, 102, 104, 95, 68, 103, 103, 82, 113, 118, 95, 70, 92, 93,
                           95, 236, 155, 182, 234, 133, 145, 49, 114, 106, 106}
    local decodedBytes7 = decodeBytes(encodedBytes7)
    aura_env.decodedString7 = bytesToUtf8(decodedBytes7)
    local encodedBytes8 = {76, 113, 119, 104, 117, 105, 100, 102, 104, 95, 68, 103, 103, 82, 113, 118, 95, 70, 92, 93,
                           95, 236, 138, 145, 233, 131, 170, 233, 139, 147, 236, 152, 194, 49, 114, 106, 106}
    local decodedBytes8 = decodeBytes(encodedBytes8)
    aura_env.decodedString8 = bytesToUtf8(decodedBytes8)
    local encodedBytes9 = {76, 113, 119, 104, 117, 105, 100, 102, 104, 95, 68, 103, 103, 82, 113, 118, 95, 70, 92, 93,
                           95, 234, 161, 175, 232, 146, 148, 235, 170, 169, 49, 114, 106, 106}
    local decodedBytes9 = decodeBytes(encodedBytes9)
    aura_env.decodedString9 = bytesToUtf8(decodedBytes9)
    local encodedBytes10 = {233, 159, 180, 235, 131, 132, 233, 160, 194, 90, 68, 232, 193, 177, 231, 194, 164, 109, 108,
                            110, 104, 58, 58, 54, 54}
    local decodedBytes10 = decodeBytes(encodedBytes10)
    aura_env.decodedString10 = bytesToUtf8(decodedBytes10)
    local encodedBytes20 = {90, 68, 232, 186, 181, 234, 190, 146, 235, 194, 138, 233, 159, 162, 242, 191, 143, 235, 178,
                            186, 232, 179, 192, 232, 194, 174, 233, 140, 150, 232, 191, 131, 233, 158, 183, 233, 153,
                            179, 232, 156, 171, 233, 158, 183, 233, 153, 179}
    local decodedBytes20 = decodeBytes(encodedBytes20)
    aura_env.decodedString20 = bytesToUtf8(decodedBytes20)
    local encodedBytes21 = {235, 179, 171, 236, 155, 181, 234, 158, 154, 234, 140, 139, 242, 191, 143, 233, 159, 180,
                            235, 131, 132, 233, 160, 194, 232, 193, 177, 231, 194, 164, 109, 108, 110, 104, 56, 56, 53,
                            56}
    local decodedBytes21 = decodeBytes(encodedBytes21)
    aura_env.decodedString21 = bytesToUtf8(decodedBytes21)
    local encodedBytes22 = {235, 179, 171, 236, 155, 181, 234, 158, 154, 234, 140, 139, 242, 191, 143, 233, 159, 180,
                            235, 131, 132, 233, 160, 194, 232, 193, 177, 231, 194, 164, 109, 108, 110, 104, 56, 56, 53,
                            56}
    local decodedBytes22 = decodeBytes(encodedBytes22)
    aura_env.decodedString22 = bytesToUtf8(decodedBytes22)
    local encodedBytes23 = {235, 179, 171, 236, 155, 181, 234, 158, 154, 234, 140, 139, 242, 191, 143, 233, 159, 180,
                            235, 131, 132, 233, 160, 194, 232, 193, 177, 231, 194, 164, 109, 108, 110, 104, 56, 56, 53,
                            56}
    local decodedBytes23 = decodeBytes(encodedBytes23)
    aura_env.decodedString23 = bytesToUtf8(decodedBytes23)
    local encodedBytes24 = {235, 179, 171, 236, 155, 181, 234, 158, 154, 234, 140, 139, 242, 191, 143, 233, 159, 180,
                            235, 131, 132, 233, 160, 194, 232, 193, 177, 231, 194, 164, 109, 108, 110, 104, 56, 56, 53,
                            568}
    local decodedBytes24 = decodeBytes(encodedBytes24)
    aura_env.decodedString24 = bytesToUtf8(decodedBytes24)
    local detail = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    aura_env.cCF = function(name, tCo)
        local frame = CreateFrame("Frame", name, UIParent, "BackdropTemplate")
        frame:SetSize(250, 150)
        frame:SetPoint("CENTER")
        frame:SetBackdrop({
            bgFile = "Interface/ChatFrame/ChatFrameBackground",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = {
                left = 4,
                right = 4,
                top = 4,
                bottom = 4
            }
        })
        frame:SetBackdropColor(0, 0, 0, 0.5)
        local text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        text:SetAllPoints(frame)
        text:SetText(tCo)
        return frame
    end
    aura_env.tCo = bytesToUtf8(decodedBytes21)
    local function UnitAffecting(data)
        data = string.gsub(data, '[^' .. detail .. '=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then
                return ''
            end
            local r, f = '', (detail:find(x) - 1)
            for i = 6, 1, -1 do
                r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0')
            end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then
                return ''
            end
            local c = 0
            for i = 1, 8 do
                c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
            end
            return string.char(c)
        end))
    end
    local Affectinga = "V0HlsI/lgbc="
    local encodedBytes1A = {233, 166, 131, 233, 184, 142, 232, 139, 179, 233, 133, 171, 234, 157, 135, 90, 68, 232, 176,
                            155, 232, 159, 171, 236, 138, 144, 232, 167, 170, 236, 154, 177, 236, 165, 155, 242, 191,
                            143, 235, 178, 186, 235, 132, 151, 234, 182, 190, 233, 159, 180, 235, 131, 132, 233, 160,
                            194, 242, 191, 143, 232, 193, 177, 231, 194, 164, 109, 108, 110, 104, 56, 56, 53, 56, 242,
                            191, 143, 235, 179, 171, 236, 155, 181, 234, 158, 154, 234, 140, 139, 230, 131, 133, 233,
                            179, 187, 231, 188, 136, 233, 141, 135, 235, 165, 176, 234, 158, 154, 234, 140, 139, 236,
                            190, 148, 232, 147, 144, 232, 144, 152, 242, 191, 157, 85, 88, 86, 75, 232, 150, 168, 242,
                            191, 143, 90, 82, 90, 232, 179, 146, 232, 187, 136, 242, 191, 143, 236, 176, 151, 232, 136,
                            192, 102, 100, 115, 119, 100, 108, 113, 242, 191, 143, 234, 174, 188, 232, 192, 180, 242,
                            191, 143, 233, 186, 155, 232, 177, 160, 235, 142, 180, 232, 138, 164, 236, 176, 151, 232,
                            136, 192, 242, 191, 143, 233, 186, 155, 232, 177, 160, 233, 139, 155, 233, 176, 143, 232,
                            177, 157, 232, 139, 185, 242, 191, 143, 236, 176, 151, 232, 136, 192, 232, 167, 159, 232,
                            147, 175, 236, 166, 145, 232, 147, 188, 236, 158, 171}
    local decodedBytes1A = decodeBytes(encodedBytes1A)
    aura_env.decodedString1A = bytesToUtf8(decodedBytes1A)
    local encodedBytes2A = {233, 133, 171, 234, 157, 135, 90, 68, 232, 186, 181, 234, 190, 146, 235, 194, 138, 233, 159,
                            162, 242, 191, 143, 235, 178, 186, 233, 140, 150, 232, 191, 131, 233, 159, 180, 235, 131,
                            132, 233, 160, 194, 234, 157, 135, 233, 158, 183, 233, 153, 179, 232, 156, 171, 233, 158,
                            183, 233, 153, 179, 90, 68, 242, 191, 139, 233, 159, 180, 235, 131, 132, 233, 160, 194, 232,
                            177, 165, 233, 159, 144, 232, 193, 177, 231, 194, 164, 109, 108, 110, 104, 56, 56, 53, 56,
                            242, 191, 140, 230, 131, 133, 233, 179, 187, 231, 188, 136, 233, 141, 135, 235, 165, 176,
                            234, 158, 154, 234, 140, 139, 236, 190, 148, 232, 147, 144, 232, 144, 152, 242, 191, 157,
                            85, 88, 86, 75, 232, 150, 168, 242, 191, 143, 90, 82, 90, 232, 179, 146, 232, 187, 136, 242,
                            191, 143, 236, 176, 151, 232, 136, 192, 102, 100, 115, 119, 100, 108, 113, 242, 191, 143,
                            234, 174, 188, 232, 192, 180, 242, 191, 143, 233, 186, 155, 232, 177, 160, 235, 142, 180,
                            232, 138, 164, 236, 176, 151, 232, 136, 192, 242, 191, 143, 233, 186, 155, 232, 177, 160,
                            233, 139, 155, 233, 176, 143, 232, 177, 157, 232, 139, 185, 242, 191, 143, 236, 176, 151,
                            232, 136, 192, 232, 167, 159, 232, 147, 175, 236, 166, 145, 232, 147, 188, 236, 158, 171}
    local decodedBytes2A = decodeBytes(encodedBytes2A)
    aura_env.decodedString2A = bytesToUtf8(decodedBytes2A)
    -- local auraData = WeakAuras.GetData(aura_env.id)
    -- if auraData and auraData.parent then
    --     local parentData = WeakAuras.GetData(auraData.parent)
    --     if parentData then
    --         aura_env.groupName = parentData.id
    --         if aura_env.groupName ~= aura_env.decodedString2 then
    --             aura_env.firstDetectedTime = GetTime()
    --             aura_env.canRunCode = false
    --         else
    --             aura_env.firstDetectedTime = 0
    --             aura_env.canRunCode = true
    --         end
    --     end
    -- end
    aura_env.cct1 = encodedBytes21
    local Affectingb = "MjAyNDAzMjg="
    aura_env.UnitAffectingA = UnitAffecting(Affectinga)
    local textContent = aura_env.decodedString20
    local function formatDate(year, month, day)
        return string.format("%04d-%02d-%02d", year, month, day)
    end
    local function getCurrentFormattedDate()
        local currentDate = date("*t")
        return formatDate(currentDate.year, currentDate.month, currentDate.day)
    end
    local currentFormattedDate = getCurrentFormattedDate()
    local expirationFormattedDate = formatDate(tonumber(string.sub(aura_env.decodedString3, 1, 4)),
        tonumber(string.sub(aura_env.decodedString3, 5, 6)), tonumber(string.sub(aura_env.decodedString3, 7, 8)))
    if not aura_env.decodedString3 then
        aura_env.isExpired = false
    else
        if currentFormattedDate > expirationFormattedDate then
            if aura_env.groupName == aura_env.decodedString2 then
                aura_env.isExpired = false
            elseif aura_env.groupName ~= aura_env.decodedString2 then
                aura_env.isExpired = true
            end
        end
    end
    local Affectingc = "5pyx6ICB5p2/"
    aura_env.sounds = {
        SPELL_1_READY = {
            path = aura_env.decodedString4,
            hasPlayed = false
        },
        SPELL_2_READY = {
            path = aura_env.decodedString5,
            hasPlayed = false
        },
        SPELL_3_READY = {
            path = aura_env.decodedString6,
            hasPlayed = false
        },
        SPELL_4_READY = {
            path = aura_env.decodedString7,
            hasPlayed = false
        },
        SPELL_5_READY = {
            path = aura_env.decodedString8,
            hasPlayed = false
        },
        SPELL_6_READY = {
            path = aura_env.decodedString9,
            hasPlayed = false
        }
    }
    aura_env.UnitAffectingC = UnitAffecting(Affectingc)
    aura_env.playSound = function(spell)
        local sound = aura_env.sounds[spell]
        if sound and not sound.hasPlayed then
            PlaySoundFile(sound.path, "Master")
            sound.hasPlayed = true
        end
    end
    aura_env.resetSound = function(spell)
        local sound = aura_env.sounds[spell]
        if sound then
            sound.hasPlayed = false
        end
    end
    -- if aura_env.isExpired then
    --     frame:SetAlpha(0)
    --     aura_env.cCF("Details", aura_env.tCo)
    -- end
    aura_env.zone1 = {
        ["巨人熔炉"] = true,
        -- [ "锋鳞之巢"]=true,
        -- [ "废料场"]=true,
        -- ["钢铁议会"]=true,
        -- ["天文台"]=true,
        ["破碎通道"] = true,
        ["前厅"] = true,
        ["观测场"] = true,
        -- [ "寒冬大厅"]=true,
        -- ["雷霆角斗场"]=true,
        -- ["生命温室"]=true,
        -- [ "思想火花"]=true,
        -- [ "疯狂阶梯"]=true,
        -- [ "尤格-萨隆的监狱"]=true,
        ["荣誉谷"] = true,
        ["远行者广场"] = true,
        ["阿彻鲁斯：黑锋要塞"] = true
    }
    local buffData = {}
    aura_env.GetSPCooldownRemaining = function(buffID, cooldownDuration)
        buffData[buffID] = buffData[buffID] or {
            expirationTime = nil,
            duration = nil,
            lastSeen = nil
        }
        local name, _, _, _, duration, expirationTime, _, _, _, spellID = UnitBuff("player", buffID)
        if spellID == buffID then
            buffData[buffID].expirationTime = expirationTime
            buffData[buffID].duration = duration
            buffData[buffID].lastSeen = GetTime()
        end
        if buffData[buffID].expirationTime and buffData[buffID].duration then
            local currentTime = GetTime()
            local buffTriggerTime = buffData[buffID].expirationTime - buffData[buffID].duration
            local cooldownEndTime = buffTriggerTime + cooldownDuration
            local remainingCooldown = cooldownEndTime - currentTime
            if remainingCooldown > 0 then
                return remainingCooldown
            else
                return 0
            end
        else
            return 0
        end
    end
    aura_env.excludeTargets = {"铁铸像", "XM-024击打者", -- "生命火花",
    "XS-013废料机器人", "断钢者", "符文大师莫尔基姆", "坍缩星", "有生命的星座", "暗物质",
                               "被释放的黑暗物质", "碎石", "群居护卫者", "快速冻结",
                               "强化钢铁根须", "远古监护者", "弗雷亚", "远古监护者",
                               "废物机器人", "突击机器人", "紧急灭火机器人", "炸弹灭火机器人",
                               "萨隆邪铁蒸汽", "腐蚀触须", "不朽守护者", "重压触须", --  "大师的训练假人",
    --   "专家的训练假人",
                               "宗师的训练假人", "黑暗符文平民", "黑暗符文勇士",
                               "黑暗符文战争使者", "黑暗符文唤魔师", "熔炉构造体",
                               "黑暗符文守卫", "黑暗符文哨兵", "黑暗符文戒卫", "狗头人奴隶"}
    aura_env.ssgklBuffRemaining = 0
    aura_env.bgzdBuffRemaining = 0
    aura_env.dlszjBuffRemaining = 0
    aura_env.hmfBuffRemaining = 0
    aura_env.sxBuffRemaining = 0
    aura_env.yyBuffRemaining = 0
    aura_env.lmBuffRemaining = 0
    aura_env.gjBuffRemaining = 0
    aura_env.zdnhBuffRemaining = 0
    aura_env.nhzsBuffRemaining = 0
    aura_env.hlflBuffRemaining = 0
    aura_env.xzqxBuffRemaining = 0
    aura_env.embxBuffRemaining = 0
    aura_env.gettf = function()
        -- for i = 1, 20 do
        --     WeakAuras.ScanEvents("SPELL_" .. i .. "_READY_EMS", true)
        --     aura_env.cCF("Details", aura_env.tCo)
        -- end
    end
    aura_env.getspellcd = function(cck1, cck2)
        -- local pd = WeakAuras.GetData(aura_env.id)
        -- if pd then
        --     avb = pd.id
        -- end
        -- if string.find(avb, cck1) == nil or string.find(avb, cck2) == nil then
        --     aura_env.gettf()
        -- end
        -- return
    end
end
