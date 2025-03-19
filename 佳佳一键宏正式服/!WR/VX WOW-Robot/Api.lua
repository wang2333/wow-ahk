local a = 43;
local b = 27;
local c = 11;
local d = 32;
local e = 0 == 1;
local f = not e;
local g = nil;
local h = ""
local i = _G;
local j = _ENV;
local k = i["tonumber"]
return (function(...)
	if not i["IsSpellInRange"] then
		i["IsSpellInRange"] = i["C_Spell"]["IsSpellInRange"]
	end;
	if not i["GetSpellCount"] then
		i["GetSpellCount"] = i["C_Spell"]["GetSpellCastCount"]
	end;
	if not i["GetSpellLink"] then
		i["GetSpellLink"] = i["C_Spell"]["GetSpellLink"]
	end;
	if not i["IsUsableSpell"] then
		i["IsUsableSpell"] = i["C_Spell"]["IsSpellUsable"]
	end;
	if not i["GetSpellInfo"] then
		i["GetSpellInfo"] = function(l)
			if not l then
				return g
			end;
			local m = i["C_Spell"]["GetSpellInfo"](l)
			if m then
				return m["name"], g, m["iconID"], m["castTime"], m["minRange"], m["maxRange"], m["spellID"], m["originalIconID"]
			end
		end
	end;
	if not i["GetSpellCooldown"] then
		i["GetSpellCooldown"] = function(l)
			local n = i["C_Spell"]["GetSpellCooldown"](l)
			if n then
				return n["startTime"], n["duration"], n["isEnabled"], n["modRate"]
			end
		end
	end;
	i["PartyRange"] = {}
	i["RiadRange"] = {}
	i["PartyLostHealth"] = {}
	i["RiadLostHealth"] = {}
	i["PlayerLostHealth"] = k("0")
	i["WR_CreateMacroButton"] = function(o, p, q)
		i["MacroButton"] = i["CreateFrame"]("Button", o, i["UIParent"], "SecureActionButtonTemplate")
		i["MacroButton"]["RegisterForClicks"](i["MacroButton"], "AnyDown", "AnyUp")
		i["MacroButton"]["SetAttribute"](i["MacroButton"], "type", "macro")
		i["MacroButton"]["SetAttribute"](i["MacroButton"], "macrotext", q)
		i["SetBinding"](p, "CLICK " .. o .. ":LeftButton")
	end;
	i["WR_MyPower"] = function()
		if i["WR_GetInRaidOrParty"]() ~= "raid" then
			return
		end;
		local r = i["date"]("*t")
		local s = r["hour"]
		local t = r["min"]
		if i["MyGIDTime"] == g or i["GetTime"]() - i["MyGIDTime"] >= k("900") then
			if s == k("20") and t == k("0") then
				i["SendChatMessage"]("■■■■■■■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("20") and t == k("15") then
				i["SendChatMessage"]("□■■■■■■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("20") and t == k("30") then
				i["SendChatMessage"]("□□■■■■■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("20") and t == k("45") then
				i["SendChatMessage"]("□□□■■■■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("21") and t == k("0") then
				i["SendChatMessage"]("□□□□■■■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("21") and t == k("15") then
				i["SendChatMessage"]("□□□□□■■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("21") and t == k("30") then
				i["SendChatMessage"]("□□□□□□■■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("21") and t == k("45") then
				i["SendChatMessage"]("□□□□□□□■■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("22") and t == k("0") then
				i["SendChatMessage"]("□□□□□□□□■■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("22") and t == k("15") then
				i["SendChatMessage"]("□□□□□□□□□■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("22") and t == k("30") then
				i["SendChatMessage"]("□□□□□□□□□□■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("22") and t == k("45") then
				i["SendChatMessage"]("□□□□□□□□□□□■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("23") and t == k("00") then
				i["SendChatMessage"]("□□□□□□□□□□□□", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("23") and t == k("15") then
				i["SendChatMessage"]("□□□□□□□□□□□□ □■■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("23") and t == k("30") then
				i["SendChatMessage"]("□□□□□□□□□□□□ □□■■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("23") and t == k("45") then
				i["SendChatMessage"]("□□□□□□□□□□□□ □□□■", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			elseif s == k("00") and t == k("00") then
				i["SendChatMessage"]("□□□□□□□□□□□□ □□□□", "RAID")
				i["MyGIDTime"] = i["GetTime"]()
			end
		end
	end;
	i["WR_GetGCD"] = function(u)
		local v = k("0")
		if i["C_Spell"]["GetSpellCooldown"](u) then
			local w = i["C_Spell"]["GetSpellCooldown"](u)["startTime"]
			local x = i["C_Spell"]["GetSpellCooldown"](u)["duration"]
			if w + x > i["GetTime"]() then
				v = w + x - i["GetTime"]()
			end
		end;
		local y, y, y, y, z, y, y, y, y = i["UnitCastingInfo"]("player")
		if z ~= g and z / k("1000") - i["GetTime"]() > v then
			return z / k("1000") - i["GetTime"]()
		else
			return v
		end
	end;
	i["WR_SpellUsable"] = function(A)
		if i["WR_GetGCD"](A) <= i["GCD"] and i["C_Spell"]["IsSpellUsable"](A) then
			return f
		end;
		return e
	end;
	i["WR_GetMaxLatency"] = function()
		local B, C, D, E = i["GetNetStats"]()
		if D > E then
			return D / k("1000")
		else
			return E / k("1000")
		end
	end;
	i["WR_GetMaxGCD"] = function(F)
		return F / (k("1") + i["GetHaste"]() / k("100"))
	end;
	i["WR_GetSpellValue"] = function(u, G, H)
		local I = "([%d,%.]+)"
		if G ~= g then
			I = G .. I
		end;
		if H ~= g then
			I = I .. H
		end;
		local J = i["C_Spell"]["GetSpellDescription"](u)
		if J ~= g then
			J = J["match"](J, I)
		end;
		if J ~= g then
			J = J["gsub"](J, ",", h)
		end;
		if J ~= g then
			J = J["gsub"](J, " 万", "0000")
		end;
		if J ~= g then
			local K = i["tonumber"](J)
			if i["type"](K) == "number" then
				return K
			end
		end;
		local I = "([%d,%.]+ 万)"
		if G ~= g then
			I = G .. I
		end;
		if H ~= g then
			I = I .. H
		end;
		local J = i["C_Spell"]["GetSpellDescription"](u)
		if J ~= g then
			J = J["match"](J, I)
		end;
		if J ~= g then
			J = J["gsub"](J, ",", h)
		end;
		if J ~= g then
			J = J["gsub"](J, " 万", "0000")
		end;
		if J ~= g then
			local K = i["tonumber"](J)
			if i["type"](K) == "number" then
				return K
			end
		end;
		return k("0")
	end;
	i["WR_InTraining"] = function()
		for y, L in i["pairs"](i["TrainingName"]) do
			if i["UnitName"]("target") == L then
				return f
			end
		end;
		return e
	end;
	i["WR_PartyIsDeath"] = function()
		for M = k("1"), k("4"), k("1") do
			if i["UnitExists"]("party" .. M) and i["UnitIsDead"]("party" .. M) then
				return f
			end
		end;
		for M = k("1"), k("40"), k("1") do
			if i["UnitExists"]("raid" .. M) and i["UnitIsDead"]("raid" .. M) then
				return f
			end
		end;
		return e
	end;
	i["WR_Unbind"] = function(N)
		if i["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return e
		end;
		if i["UnitClassBase"]("player") == "DRUID" and i["WR_GetUnitDebuffTime"](N, "晦幽纺纱") > k("0") and i["WR_GetUnitDebuffTime"](N, "晦幽纺纱") < k("11") then
			return e
		end;
		if i["WR_GetUnitDebuffCount"](N, "恐瓣花粉") >= k("6") then
			return f
		end;
		if i["WR_GetUnitDebuffTime"](N, i["BindName"]) > k("0") then
			return f
		end;
		return e
	end;
	i["WR_YuFangDingShen"] = function(N)
		if i["WR_GetRangeSpellTime"](k("40"), i["YuFangDingShenSpell"]) < k("2") then
			return f
		end;
		if N == g or N == "player" then
			if i["WR_GetRangeSpellTime"](k("40"), i["YuFangDingShenSpellToUnit"], "player") < k("2") then
				return f
			end
		else
			if i["WR_GetRangeSpellTime"](k("40"), i["YuFangDingShenSpellToUnit"], N) < k("2") then
				return f
			end
		end;
		return e
	end;
	i["WR_UnitAssistDebuff"] = function(N)
		return i["WR_GetUnitDebuffTime"](N, i["AssistDebuffName"]) > k("0") or i["WR_GetUnitDebuffTime"](N, i["DangerDebuff"]) > k("0")
	end;
	i["WR_Mustheal"] = function(N)
		local O = k("1")
		if i["WR_GetUnitDebuffTime"](N, i["MustHealSpellName"]) > k("0") or i["WR_UnitAssistDebuff"](N) then
			if i["UnitHealth"](N) / i["UnitHealthMax"](N) < k("0.9") then
				return f
			end
		end;
		local P, y = i["UnitName"](N)
		if P == "卡多雷精魂" or P == "焦化树人" then
			if i["UnitHealth"](N) / i["UnitHealthMax"](N) < k("0.9") then
				return f
			end
		end;
		return e
	end;
	i["WR_GetUnitBuffType"] = function(N, Q)
		local M;
		for M = k("1"), k("255"), k("1") do
			local R = i["C_UnitAuras"]["GetAuraDataByIndex"](N, M, "HELPFUL")
			if R == g then
				break
			end;
			local S = R["name"]
			local T = R["applications"]
			local U = R["dispelName"]
			if S == g then
				break
			end;
			if S == "无穷饥渴" and T < k("6") then
				return e
			end;
			if S == "窃取时间" then
				return e
			end;
			if U == Q then
				return f
			end
		end;
		return e
	end;
	i["WR_UnitDebuffType"] = function(N, V)
		local M;
		for M = k("1"), k("255"), k("1") do
			local W = f;
			local X = i["C_UnitAuras"]["GetAuraDataByIndex"](N, M, "HARMFUL")
			if X == g then
				break
			end;
			local S = X["name"]
			local T = X["applications"]
			local U = X["dispelName"]
			local Y = X["expirationTime"]
			if S == g then
				break
			end;
			if S == "虚空裂隙" then
				return f, k("1")
			end;
			if S == "烈焰撕咬" and i["WR_RangeCountPR"](k("40"), k("0.70")) >= k("1") then
				W = e
			end;
			if S == "灵魂毒液" and T < k("7") then
				W = e
			end;
			if (S == "爆裂" or S == "巨口蛙毒" or S == "腐蚀波") and T < k("5") then
				W = e
			end;
			if S == "窃取时间" and T < k("3") then
				W = e
			end;
			if S == "腐败之血" and T < k("2") then
				W = e
			end;
			if S == "时光爆发" and (Y - i["GetTime"]() > k("4.5") or i["WR_GetUnitHP"](N) < k("0.8")) then
				W = e
			end;
			if S == "古怪生长" and Y - i["GetTime"]() > k("4") then
				W = e
			end;
			if S == "提尔之火" and (Y - i["GetTime"]() > k("16") or i["WR_GetUnitHP"](N) < k("0.8") or i["UnitCastingInfo"]("boss1") == "裂地打击") then
				W = e
			end;
			if S == "震地回响" and i["WR_GetRangeSpellTime"](k("45"), "震地猛击") >= k("3") then
				W = e
			end;
			if S == "冰冻" then
				W = e
			end;
			if U == V and W == f then
				return f, T
			end
		end;
		return e
	end;
	i["WR_GetUnitBuffInfo"] = function(N, Z, _, a0)
		local a1 = k("0")
		local a2 = k("0")
		local a3 = k("0")
		for M = k("1"), k("255"), k("1") do
			local R = i["C_UnitAuras"]["GetAuraDataByIndex"](N, M, "HELPFUL")
			if R == g then
				break
			end;
			if R then
				if _ ~= f or _ == f and R["sourceUnit"] == "player" then
					if i["type"](Z) == "table" then
						for a4, a5 in i["pairs"](Z) do
							if a0 == g and (R["name"] == a5 or R["spellId"] == a4) or a0 == "NAME" and R["name"] == a5 or a0 == "ID" and R["spellId"] == a4 then
								if R["expirationTime"] > i["GetTime"]() then
									a1 = R["expirationTime"] - i["GetTime"]()
								else
									a1 = k("999")
								end;
								if R["applications"] > k("0") then
									a2 = R["applications"]
								else
									a2 = k("1")
								end;
								a3 = a3 + k("1")
							end
						end
					else
						if R["name"] == Z or R["spellId"] == Z then
							if R["expirationTime"] > i["GetTime"]() then
								a1 = R["expirationTime"] - i["GetTime"]()
							else
								a1 = k("999")
							end;
							if R["applications"] > k("0") then
								a2 = R["applications"]
							else
								a2 = k("1")
							end;
							a3 = a3 + k("1")
						end
					end
				end
			else
			end
		end;
		return a1, a2, a3
	end;
	i["WR_GetUnitDebuffInfo"] = function(N, a6, _, a0)
		local a7 = k("0")
		local a8 = k("0")
		for M = k("1"), k("255"), k("1") do
			local X = i["C_UnitAuras"]["GetAuraDataByIndex"](N, M, "HARMFUL")
			if X == g then
				break
			end;
			if X then
				if _ ~= f or _ == f and X["sourceUnit"] == "player" then
					if i["type"](a6) == "table" then
						for a9, aa in i["pairs"](a6) do
							if a0 == g and (X["name"] == aa or X["spellId"] == a9) or a0 == "NAME" and X["name"] == aa or a0 == "ID" and X["spellId"] == a9 then
								if X["expirationTime"] > i["GetTime"]() then
									a7 = X["expirationTime"] - i["GetTime"]()
								else
									a7 = k("999")
								end;
								if X["applications"] > k("0") then
									a8 = X["applications"]
								else
									a8 = k("1")
								end;
								return a7, a8
							end
						end
					else
						if X["name"] == a6 or X["spellId"] == a6 then
							if X["expirationTime"] > i["GetTime"]() then
								a7 = X["expirationTime"] - i["GetTime"]()
							else
								a7 = k("999")
							end;
							if X["applications"] > k("0") then
								a8 = X["applications"]
							else
								a8 = k("1")
							end;
							return a7, a8
						end
					end
				end
			else
				return a7, a8
			end
		end;
		return a7, a8
	end;
	i["WR_GetUnitBuffTime"] = function(N, Z, _, a0)
		return i["select"](k("1"), i["WR_GetUnitBuffInfo"](N, Z, _, a0))
	end;
	i["WR_GetUnitBuffCount"] = function(N, Z, _, a0)
		return i["select"](k("2"), i["WR_GetUnitBuffInfo"](N, Z, _, a0))
	end;
	i["WR_GetUnitBuffSum"] = function(N, Z, _, a0)
		return i["select"](k("3"), i["WR_GetUnitBuffInfo"](N, Z, _, a0))
	end;
	i["WR_GetUnitDebuffTime"] = function(N, a6, _, a0)
		return i["select"](k("1"), i["WR_GetUnitDebuffInfo"](N, a6, _, a0))
	end;
	i["WR_GetUnitDebuffCount"] = function(N, a6, _, a0)
		return i["select"](k("2"), i["WR_GetUnitDebuffInfo"](N, a6, _, a0))
	end;
	i["WR_GetHealthMaxWeightUnit"] = function()
		local ab = {
			[k("1")] = "圣光道标",
			[k("2")] = "美德道标",
			[k("3")] = "信仰道标",
			[k("4")] = "复苏之雾",
			[k("5")] = "愈合祷言",
			[k("6")] = "恢复",
			[k("7")] = "圣光回响",
			[k("8")] = k("102352"),
			[k("9")] = "生命绽放",
			[k("10")] = "野性成长",
			[k("11")] = "愈合",
			[k("12")] = "回春术",
			[k("13")] = "林地护理",
			[k("14")] = "激变蜂群",
			[k("15")] = "栽培",
			[k("16")] = "春暖花开"
		}
		local u = "Nothing"
		local ac = e;
		local ad = e;
		local ae = e;
		local af = e;
		if i["IsPlayerSpell"](k("527")) == f then
			u = "纯净术"
			ac = f
		end;
		if i["IsPlayerSpell"](k("77130")) == f then
			u = "净化灵魂"
			ac = f
		end;
		if i["IsPlayerSpell"](k("4987")) == f then
			u = "清洁术"
			ac = f
		end;
		if i["IsPlayerSpell"](k("115450")) == f then
			u = "清创生血"
			ac = f
		end;
		if i["IsPlayerSpell"](k("88423")) == f then
			u = "自然之愈"
			ac = f
		end;
		if i["IsPlayerSpell"](k("390632")) == f then
			ae = f
		end;
		if i["IsPlayerSpell"](k("383016")) == f then
			ad = f
		end;
		if i["IsPlayerSpell"](k("393024")) == f then
			af = f;
			ae = f
		end;
		if i["IsPlayerSpell"](k("388874")) == f then
			af = f;
			ae = f
		end;
		if i["IsPlayerSpell"](k("392378")) == f then
			af = f;
			ae = f
		end;
		if u == "Nothing" then
			return "Nothing"
		else
			if i["HealthMaxWeightUnitload"] ~= f then
				local ag = "本职业驱散法术为: |cff0cbd0c" .. u .. "|cffffffff，当前天赋可驱散: "
				if ac == f then
					ag = ag .. "|cff00adf0魔法 "
				end;
				if ad == f then
					ag = ag .. "|cffffdf00诅咒 "
				end;
				if ae == f then
					ag = ag .. "|cffff5040疾病 "
				end;
				if af == f then
					ag = ag .. "|cff0cbd0c中毒 "
				end;
				i["HealthMaxWeightUnitload"] = f
			end
		end;
		local ah, ai;
		local aj = k("0")
		local ak = k("0")
		local al = {}
		local am = "Nothing"
		local an = - k("999")
		local ao;
		for M = k("1"), k("4"), k("1") do
			al[M] = k("0")
		end;
		local ap = {}
		for M = k("1"), k("40"), k("1") do
			ap[M] = k("0")
		end;
		i["QSCooldown"] = i["WR_GetGCD"](u)
		for M = k("2"), k("5"), k("1") do
			local aq = k("0")
			local ar = "boss" .. M;
			if i["UnitExists"](ar) == f and (i["UnitName"](ar) == "克罗米" or i["UnitName"](ar) == "焦化树人" or i["UnitName"](ar) == "焦灼刺藤") then
				aq = (i["UnitHealthMax"](ar) - i["UnitHealth"](ar)) / i["UnitHealthMax"](ar) * k("100")
			end;
			if aq ~= k("0") and an < aq then
				an = aq;
				am = ar
			end
		end;
		local as = k("0")
		if i["UnitExists"]("mouseover") == f and (i["UnitName"]("mouseover") == "克罗米" or i["UnitName"]("mouseover") == "卡多雷精魂") then
			as = (i["UnitHealthMax"]("mouseover") - i["UnitHealth"]("mouseover")) / i["UnitHealthMax"]("mouseover") * k("100")
		end;
		if as ~= k("0") and an < as then
			an = as;
			am = "mouseover"
		end;
		if i["WR_GetInRaidOrParty"]() ~= "raid" then
			ao = "player"
			if i["UnitExists"](ao) == f and i["UnitIsDead"](ao) == e and i["UnitIsCharmed"](ao) == e and i["UnitIsFriend"](ao, ao) == f and i["WR_GetUnitRange"](ao) <= k("46") then
				ak = (i["UnitHealth"](ao) + i["UnitGetIncomingHeals"](ao) + i["UnitGetTotalAbsorbs"](ao) - i["UnitGetTotalHealAbsorbs"](ao) / k("1.5")) / i["UnitHealthMax"](ao) * k("100")
				if ak > k("100") then
					ak = k("100")
				end;
				ak = k("100") - ak;
				if ak == k("0") and i["UnitGetTotalAbsorbs"](ao) > k("0") then
					ak = ak - k("5")
				end;
				local at = (i["UnitHealth"](ao) + i["UnitGetIncomingHeals"](ao) - i["UnitGetTotalHealAbsorbs"](ao)) / i["UnitHealthMax"](ao)
				if at < k("0.70") then
					ak = ak + (k("70") - at * k("100")) / k("2")
				end;
				if i["UnitClassBase"]("player") == "PRIEST" and i["GetSpecialization"]() == k("1") then
					if i["UnitAffectingCombat"]("player") and i["WR_GetUnitBuffTime"](ao, "救赎", f) > k("0") then
						ak = ak - k("20")
					elseif not i["UnitAffectingCombat"]("player") and i["WR_GetUnitBuffTime"](ao, "恢复", f) > k("0") then
						ak = ak - k("20")
					end
				end;
				if i["WR_Mustheal"](ao) then
					ak = ak + k("60")
				end;
				if i["WR_GetUnitBuffTime"](ao, ab, f) > k("0") then
					ak = ak - k("10")
				end;
				if i["UnitClassBase"]("player") == "MONK" and i["WR_GetUnitBuffTime"](ao, "抚慰之雾", f) > k("0") and at < k("0.9") then
					ak = ak + k("30")
				end;
				ak = i["math"]["ceil"](ak)
				if an < ak then
					an = ak;
					am = "player"
				end
			end
		end;
		if i["WR_GetInRaidOrParty"]() == "party" then
			for M = k("1"), k("4"), k("1") do
				ao = "party" .. M;
				if i["UnitExists"](ao) == f and i["UnitIsDead"](ao) == e and i["UnitIsCharmed"](ao) == e and i["UnitIsFriend"](ao, ao) == f and (i["WR_GetUnitRange"](ao) <= k("46") or i["WR_GetUnitBuffTime"]("player", "救赎之魂") > i["GCD"] and i["WR_GetUnitRange"](ao) <= k("69")) then
					al[M] = (i["UnitHealth"](ao) + (i["UnitGetIncomingHeals"](ao) or k("0")) + i["UnitGetTotalAbsorbs"](ao) / k("2") - i["UnitGetTotalHealAbsorbs"](ao) / k("1.5")) / i["UnitHealthMax"](ao) * k("100")
					if al[M] > k("100") then
						al[M] = k("100")
					end;
					al[M] = k("100") - al[M]
					if al[M] == k("0") and i["UnitGetTotalAbsorbs"](ao) > k("0") then
						al[M] = al[M] - k("5")
					end;
					if i["UnitGroupRolesAssigned"](ao) == "TANK" then
						if not i["UnitAffectingCombat"](ao) then
							al[M] = al[M] + k("5")
						end;
						if i["UnitName"]("boss1") == "不屈者卡金" then
							al[M] = al[M] - k("50")
						end
					end;
					local au = (i["UnitHealth"](ao) + (i["UnitGetIncomingHeals"](ao) or k("0")) - i["UnitGetTotalHealAbsorbs"](ao)) / i["UnitHealthMax"](ao)
					local av = f;
					if i["UnitClass"]("player") == "牧师" and i["GetSpecialization"]() == k("1") then
						if i["WR_GetUnitBuffTime"](ao, "救赎", f) == k("0") then
							av = e
						end
					end;
					if av and i["UnitGroupRolesAssigned"](ao) == "TANK" and i["UnitAffectingCombat"](ao) then
						if i["classFilename"] == "DEATHKNIGHT" then
							if i["UnitPower"](ao) >= k("40") then
								al[M] = al[M] - k("40")
							else
								al[M] = al[M] - k("20")
							end
						end;
						if au > k("0.4") then
							if i["classFilename"] == "PALADIN" then
								al[M] = al[M] - k("20")
							end;
							if i["classFilename"] == "DEMONHUNTER" then
								al[M] = al[M] - k("20")
							end;
							if i["classFilename"] == "DRUID" then
								al[M] = al[M] - k("20")
							end
						end
					end;
					if i["UnitClassBase"]("player") == "PRIEST" and i["GetSpecialization"]() == k("1") then
						if i["UnitAffectingCombat"]("player") and i["WR_GetUnitBuffTime"](ao, "救赎", f) > k("0") then
							al[M] = al[M] - k("20")
						elseif not i["UnitAffectingCombat"]("player") and i["WR_GetUnitBuffTime"](ao, "恢复", f) > k("0") then
							al[M] = al[M] - k("20")
						end
					end;
					if i["UnitClassBase"]("player") == "PALADIN" and i["WR_GetUnitBuffTime"](ao, "圣光闪烁", f) > k("0") then
						al[M] = al[M] - k("20")
					end;
					if i["WR_Mustheal"](ao) then
						al[M] = al[M] + k("50")
					end;
					if i["WR_GetUnitBuffTime"](ao, ab, f) > k("0") then
						al[M] = al[M] - k("10")
					end;
					if i["UnitClassBase"]("player") == "MONK" and i["UnitChannelInfo"]("player") == "抚慰之雾" and i["WR_GetUnitBuffTime"](ao, "抚慰之雾", f) > k("0") and au < k("0.9") then
						al[M] = al[M] + k("30")
					end;
					al[M] = i["math"]["ceil"](al[M])
					if an < al[M] then
						an = al[M]
						am = "party" .. M
					end
				end
			end
		end;
		if i["WR_GetInRaidOrParty"]() == "raid" then
			for M = k("1"), k("40"), k("1") do
				ao = "raid" .. M;
				if i["UnitExists"](ao) == f and i["UnitIsDead"](ao) == e and i["UnitIsCharmed"](ao) == e and i["UnitIsFriend"](ao, ao) == f and (i["WR_GetUnitRange"](ao) <= k("46") or i["WR_GetUnitBuffTime"]("player", "救赎之魂") > i["GCD"] and i["WR_GetUnitRange"](ao) <= k("69")) then
					ap[M] = (i["UnitHealth"](ao) + (i["UnitGetIncomingHeals"](ao) or k("0")) + i["UnitGetTotalAbsorbs"](ao) / k("2") - i["UnitGetTotalHealAbsorbs"](ao) / k("1.5")) / i["UnitHealthMax"](ao) * k("100")
					if ap[M] > k("100") then
						ap[M] = k("100")
					end;
					ap[M] = k("100") - ap[M]
					if ap[M] == k("0") and i["UnitGetTotalAbsorbs"](ao) > k("0") then
						ap[M] = ap[M] - k("5")
					end;
					if i["UnitGroupRolesAssigned"](ao) == "TANK" and not i["UnitAffectingCombat"](ao) then
						ap[M] = ap[M] + k("5")
					end;
					local aw = (i["UnitHealth"](ao) + (i["UnitGetIncomingHeals"](ao) or k("0")) - i["UnitGetTotalHealAbsorbs"](ao)) / i["UnitHealthMax"](ao)
					if i["WR_GetUnitBuffTime"](ao, ab, f) > k("0") then
						ap[M] = ap[M] - k("10")
					end;
					if i["UnitClassBase"]("player") == "MONK" and i["UnitChannelInfo"]("player") == "抚慰之雾" and i["WR_GetUnitBuffTime"](ao, "抚慰之雾", f) > k("0") and aw < k("0.9") then
						ap[M] = ap[M] + k("30")
					end;
					ap[M] = i["math"]["ceil"](ap[M])
					if an < ap[M] then
						an = ap[M]
						am = "raid" .. M
					end
				end
			end
		end;
		if i["MSG"] == k("1") then
			i["print"]("--权重列表--")
			local ax = "player:" .. ak .. "  "
			for M = k("1"), k("4"), k("1") do
				if i["UnitExists"]("party" .. M) == f then
					ax = ax .. "party" .. M .. ":" .. al[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("1"), k("5"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("6"), k("10"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("11"), k("15"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("16"), k("20"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("21"), k("25"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("26"), k("30"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("31"), k("35"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			ax = h;
			for M = k("36"), k("40"), k("1") do
				if i["UnitExists"]("raid" .. M) == f then
					ax = ax .. "raid" .. M .. ":" .. ap[M] .. "  "
				end
			end;
			if ax ~= h then
				i["print"](ax)
			end;
			i["print"]("最大权重单位:", am, ":", an, h)
		end;
		return am, an
	end;
	i["NPGUID"] = {}
	i["NPLevel"] = {}
	i["NPHP"] = {}
	i["NPMaxHealth"] = {}
	i["NPHealth"] = {}
	i["NPbegintime"] = {}
	i["NPdeathtime"] = {}
	i["WR_GetNPDeathTime"] = function()
		if i["LastTime_WR_GetNPDeathTime"] ~= g and i["GetTime"]() - i["LastTime_WR_GetNPDeathTime"] <= k("0.1") then
			return
		end;
		i["LastTime_WR_GetNPDeathTime"] = i["GetTime"]()
		for M = k("1"), k("40"), k("1") do
			if i["UnitGUID"]("nameplate" .. M) == g or i["UnitAffectingCombat"]("nameplate" .. M) == e or i["UnitHealth"]("nameplate" .. M) == i["UnitHealthMax"]("nameplate" .. M) then
				i["NPGUID"][M] = g;
				i["NPLevel"][M] = g;
				i["NPHP"][M] = g;
				i["NPMaxHealth"][M] = g;
				i["NPHealth"][M] = g;
				i["NPbegintime"][M] = g;
				i["NPdeathtime"][M] = k("999")
			else
				if i["UnitGUID"]("nameplate" .. M) ~= g then
					i["NPGUID"][M] = i["UnitGUID"]("nameplate" .. M)
				end;
				if i["UnitLevel"]("nameplate" .. M) ~= g and i["UnitLevel"]("nameplate" .. M) ~= k("0") then
					i["NPLevel"][M] = i["UnitLevel"]("nameplate" .. M)
				end;
				if i["NPLevel"][M] ~= g and i["NPLevel"][M] > k("0") then
					local ay = i["UnitClassification"]("nameplate" .. M)
					if ay == "normal" or ay == "trivial" or ay == "minus" then
						i["NPHP"][M] = k("0.9999")
					elseif i["UnitGUID"]("nameplate" .. M) == i["UnitGUID"]("boss1") or i["UnitGUID"]("nameplate" .. M) == i["UnitGUID"]("boss2") or i["UnitGUID"]("nameplate" .. M) == i["UnitGUID"]("boss3") or i["UnitGUID"]("nameplate" .. M) == i["UnitGUID"]("boss4") or i["UnitGUID"]("nameplate" .. M) == i["UnitGUID"]("boss5") then
						i["NPHP"][M] = k("0.9999")
					else
						i["NPHP"][M] = k("0.9999")
					end
				elseif i["NPLevel"][M] ~= g and i["NPLevel"][M] < k("0") then
					i["NPHP"][M] = k("0.9999")
				end;
				if i["UnitHealthMax"]("nameplate" .. M) ~= g then
					i["NPMaxHealth"][M] = i["UnitHealthMax"]("nameplate" .. M)
				end;
				if i["UnitHealthMax"]("nameplate" .. M) ~= g and i["NPHP"][M] ~= g and i["UnitHealth"]("nameplate" .. M) ~= g and i["UnitHealthMax"]("nameplate" .. M) * i["NPHP"][M] > i["UnitHealth"]("nameplate" .. M) then
					if i["NPbegintime"][M] == g then
						i["NPbegintime"][M] = i["GetTime"]()
					end;
					if i["NPHealth"][M] == g then
						i["NPHealth"][M] = i["UnitHealth"]("nameplate" .. M) + i["UnitGetTotalAbsorbs"]("nameplate" .. M)
					end
				end;
				local az = i["UnitHealth"]("nameplate" .. M) + i["UnitGetTotalAbsorbs"]("nameplate" .. M)
				if i["NPGUID"][M] ~= g and i["NPbegintime"][M] ~= g and i["NPHealth"][M] ~= g and i["NPHealth"][M] > az and i["NPbegintime"][M] < i["GetTime"]() then
					i["NPdeathtime"][M] = az / ((i["NPHealth"][M] - az) / (i["GetTime"]() - i["NPbegintime"][M]))
				end
			end
		end
	end;
	i["WR_GetUnitDeathTime"] = function(N)
		i["WR_GetNPDeathTime"]()
		local aA = k("0")
		if i["UnitGUID"](N) == g then
			aA = k("0")
		end;
		for M = k("1"), k("40"), k("1") do
			if i["UnitGUID"](N) ~= g and i["UnitGUID"]("nameplate" .. M) ~= g and i["UnitGUID"](N) == i["UnitGUID"]("nameplate" .. M) and i["NPdeathtime"][M] ~= g then
				aA = i["NPdeathtime"][M]
			end
		end;
		if i["MSG"] == k("1") then
		end;
		if aA ~= g then
			return aA
		else
			return k("0")
		end
	end;
	i["WR_GetRangeAvgDeathTime"] = function(aB)
		if i["WR_InTraining"]() then
			return k("999")
		end;
		i["WR_GetNPDeathTime"]()
		local aC, S, aD, aE, aF;
		local aG = k("0")
		local T = k("0")
		local aH = k("0")
		for M = k("1"), k("40"), k("1") do
			S, aD = i["UnitName"]("nameplate" .. M)
			aF = i["WR_GetUnitRange"]("nameplate" .. M)
			aC = i["UnitAffectingCombat"]("nameplate" .. M)
			if aF ~= g and aC == f and i["NPdeathtime"][M] ~= g and S ~= g then
				if aF <= aB and i["NPdeathtime"][M] > k("0") and i["NPdeathtime"][M] < k("999") and S ~= "爆炸物" then
					aG = aG + i["NPdeathtime"][M]
					T = T + k("1")
				end
			end
		end;
		if T ~= k("0") then
			aH = aG / T
		end;
		if i["MSG"] == k("1") then
			i["print"]("预计战斗结束时间:|cffffdf00", i["math"]["ceil"](aH), "|cffffffff秒")
		end;
		return aH
	end;
	i["WR_GetUnitHP"] = function(N)
		if i["UnitExists"](N) == f then
			return (i["UnitHealth"](N) + i["UnitGetTotalAbsorbs"](N) + (i["UnitGetIncomingHeals"](N) or k("0")) - i["UnitGetTotalHealAbsorbs"](N)) / i["UnitHealthMax"](N)
		else
			return k("1")
		end
	end;
	i["WR_GetUnitMP"] = function(N)
		if i["UnitPowerMax"](N, k("0")) ~= k("0") then
			return i["UnitPower"](N, k("0")) / i["UnitPowerMax"](N, k("0"))
		else
			return k("0")
		end
	end;
	i["WR_GetUnitLostHealth"] = function(N)
		if i["UnitExists"](N) and not i["UnitIsDead"](N) then
			local aI = i["UnitHealthMax"](N) - i["UnitHealth"](N) - (i["UnitGetIncomingHeals"](N) or k("0")) + i["UnitGetTotalHealAbsorbs"](N)
			return aI > k("0") and aI or k("0")
		else
			return k("0")
		end
	end;
	i["WR_PartyLostHP"] = function()
		local aJ;
		local aK = k("0")
		local aG = k("0")
		aJ = "player"
		if i["UnitExists"](aJ) == f and i["UnitIsDead"](aJ) == e and i["WR_GetUnitRange"](aJ) <= k("46") then
			aK = aK + (i["UnitHealthMax"](aJ) - i["UnitHealth"](aJ)) / i["UnitHealthMax"](aJ)
			aG = aG + k("1")
		end;
		if i["WR_GetInRaidOrParty"]() == "party" then
			for M = k("1"), k("4"), k("1") do
				aJ = "party" .. M;
				if i["UnitExists"](aJ) == f and i["UnitIsDead"](aJ) == e and i["WR_GetUnitRange"](aJ) <= k("46") then
					aK = aK + (i["UnitHealthMax"](aJ) - i["UnitHealth"](aJ)) / i["UnitHealthMax"](aJ)
					aG = aG + k("1")
				end
			end
		end;
		if i["WR_GetInRaidOrParty"]() == "raid" then
			for M = k("1"), k("20"), k("1") do
				aJ = "raid" .. M;
				if i["UnitExists"](aJ) == f and i["UnitIsDead"](aJ) == e and i["WR_GetUnitRange"](aJ) <= k("46") then
					aK = aK + (i["UnitHealthMax"](aJ) - i["UnitHealth"](aJ)) / i["UnitHealthMax"](aJ)
					aG = aG + k("1")
				end
			end
		end;
		if aG == k("0") then
			aK = k("0")
		else
			aK = i["math"]["ceil"](aK / aG * k("100")) / k("100")
		end;
		if i["MSG"] == k("1") then
		end;
		return aK
	end;
	i["WR_PlayerMove"] = function()
		if i["IsPlayerSpell"](k("108839")) and i["WR_GetUnitBuffTime"]("player", k("108839")) > i["GCD"] then
			return e
		end;
		local aL, y, y, y = i["GetUnitSpeed"]("player")
		if i["IsFlying"]() == e and i["IsFalling"]() == e and aL == k("0") then
			return e
		else
			return f
		end
	end;
	i["WR_GetUnitRange"] = function(N)
		local aM = i["select"](k("2"), i["WR_LibRangeCheck3"]["GetRange"](i["WR_LibRangeCheck3"], N))
		if aM == g then
			return k("999")
		end;
		return aM
	end;
	i["WR_Invincible"] = function(N)
		local S, aN, aO, aP = i["GetInstanceInfo"]()
		if aN == "raid" then
			return e
		end;
		for y, S in i["pairs"](i["InvincibleUnitName"]) do
			if i["UnitName"](N) == S then
				return f
			end
		end;
		if i["UnitClassification"](N) == "normal" or i["UnitClassification"](N) == "trivial" or i["UnitClassification"](N) == "minus" then
			return e
		end;
		if not i["UnitExists"](N) then
			return e
		end;
		if i["WR_GetUnitBuffCount"](N, i["InvincibleBuffName"]) > k("0") or i["WR_GetUnitDebuffCount"](N, i["InvincibleBuffName"]) > k("0") then
			return f
		end;
		return e
	end;
	i["WR_GetRangeHarmUnitCount"] = function(aB, aQ)
		local aR = k("0")
		for M = k("1"), k("40"), k("1") do
			local N = "nameplate" .. M;
			if i["UnitCanAttack"]("player", N) and not i["WR_Invincible"](N) and (aQ ~= f or i["UnitAffectingCombat"](N) == aQ) and i["UnitCreatureType"](N) ~= "图腾" and i["UnitCreatureType"](N) ~= "气体云雾" and i["WR_GetUnitRange"](N) <= aB and i["UnitName"](N) ~= "复酌之桶" then
				aR = aR + k("1")
			end
		end;
		return aR
	end;
	i["WR_GetSpellRangeHarmUnitCount"] = function(u, aQ)
		local aR = k("0")
		for M = k("1"), k("40"), k("1") do
			local N = "nameplate" .. M;
			if i["C_Spell"]["IsSpellInRange"](u, N) and i["UnitCanAttack"]("player", N) and not i["WR_Invincible"](N) and (aQ ~= f or i["UnitAffectingCombat"](N) == aQ) and i["UnitCreatureType"](N) ~= "图腾" and i["UnitCreatureType"](N) ~= "气体云雾" then
				aR = aR + k("1")
			end
		end;
		return aR
	end;
	i["WR_PartyInCombat"] = function()
		if i["UnitAffectingCombat"]("player") then
			return f
		end;
		for M = k("1"), k("4") do
			local ao = "party" .. M;
			if i["UnitAffectingCombat"](ao) then
				return f
			end
		end;
		return e
	end;
	i["WR_TargetInCombat"] = function(N)
		local P;
		P, i["_"] = i["UnitName"](N)
		if P == "虚体生物" or not i["UnitExists"](N) or i["UnitIsDead"](N) or not i["UnitCanAttack"]("player", N) or i["WR_Invincible"](N) then
			return e
		end;
		if not i["UnitIsPlayer"](N) and i["UnitIsPlayer"](N .. "target") then
			return f
		end;
		if i["UnitAffectingCombat"](N) and i["WR_PartyInCombat"]() then
			return f
		end;
		if i["WR_InBossCombat"]() then
			return f
		end;
		local M = k("1")
		while i["InCombatName"][M] ~= g and i["InCombatName"][M] ~= h do
			if P == i["InCombatName"][M] then
				return f
			end;
			M = M + k("1")
		end;
		local aS, aN = i["IsInInstance"]()
		if not aS then
			return f
		end;
		if i["UnitThreatSituation"]("player", "target") ~= g then
			return f
		end;
		local S, aN, aO, aP = i["GetInstanceInfo"]()
		if aO == k("208") or aO == k("12") then
			return f
		end;
		return e
	end;
	i["WR_InBossCombat"] = function()
		if i["UnitGUID"]("boss1") == g and i["UnitGUID"]("boss2") == g and i["UnitGUID"]("boss3") == g and i["UnitGUID"]("boss4") == g and i["UnitGUID"]("boss5") == g then
			return e
		else
			return f
		end
	end;
	i["WR_TargetIsBoss"] = function()
		local M;
		for M = k("1"), k("5"), k("1") do
			if i["UnitGUID"]("boss" .. M) ~= g and i["UnitGUID"]("target") ~= g and i["UnitGUID"]("boss" .. M) == i["UnitGUID"]("target") then
				return f
			end
		end;
		return e
	end;
	i["WR_GetRangeSpellTime"] = function(aB, u, N)
		local aT = k("999")
		for M = k("1"), k("40"), k("1") do
			if i["UnitExists"]("nameplate" .. M) then
				local aM = i["WR_GetUnitRange"]("nameplate" .. M)
				if aM ~= g and aM <= aB and (N == g or i["UnitIsUnit"]("nameplate" .. M .. "target", N)) then
					local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"]("nameplate" .. M)
					if S == g then
						S, aU, aV, aW, z, aX, aZ, a_ = i["UnitChannelInfo"]("nameplate" .. M)
					end;
					if S ~= g then
						local b0 = z / k("1000") - i["GetTime"]()
						if b0 > k("999") then
							b0 = k("998")
						end;
						if b0 < aT then
							if i["type"](u) == "table" then
								for b1, b2 in i["pairs"](u) do
									if S == b2 or a_ == b1 then
										aT = b0
									end
								end
							else
								if u == g or S == u or a_ == u then
									aT = b0
								end
							end
						end
					end
				end
			end
		end;
		return aT
	end;
	i["WR_GetUnitOutburstDebuffTime"] = function(N)
		for y, aa in i["pairs"](i["OutburstDebuff"]) do
			local a7 = i["WR_GetUnitDebuffTime"](N, aa)
			if a7 ~= k("0") then
				return a7
			end
		end;
		return k("999")
	end;
	i["WR_GetPartyOutburstDebuffTime"] = function()
		local M;
		for M = k("1"), k("4"), k("1") do
			if i["UnitExists"]("party" .. M) then
				for y, b3 in i["pairs"](i["PartyOutburstDebuff"]) do
					local a7 = i["WR_GetUnitDebuffTime"]("party" .. M, b3)
					if a7 > k("0") then
						return a7
					end
				end
			end
		end;
		for M = k("1"), k("40"), k("1") do
			if i["UnitExists"]("raid" .. M) then
				for y, b3 in i["pairs"](i["PartyOutburstDebuff"]) do
					local a7 = i["WR_GetUnitDebuffTime"]("raid" .. M, b3)
					if a7 > k("0") then
						return a7
					end
				end
			end
		end;
		return k("999")
	end;
	i["WR_ResistOutburstTime"] = function()
		local b4 = i["WR_GetRangeSpellTime"](k("45"), i["OutburstAoe"])
		if b4 < k("999") then
			return b4
		end;
		local b5 = i["WR_GetUnitOutburstDebuffTime"]("player")
		if b5 < k("999") then
			return b5
		end;
		local b6 = i["WR_GetPartyOutburstDebuffTime"]()
		if b6 < k("999") then
			return b6
		end;
		local b7 = i["WR_GetRangeSpellTime"](k("45"), i["OutburstCasting"], "player")
		if b7 < k("999") then
			return b7
		end;
		i["WR_DangerSpellTime"]()
		local b8;
		if i["Time"] == g then
			b8 = k("5")
		else
			b8 = i["Time"]
		end;
		if i["SF_CastTime"] ~= g then
			if k("6") - (i["GetTime"]() - i["SF_CastTime"]) > k("0") then
				return k("6") - (i["GetTime"]() - i["SF_CastTime"])
			end
		end;
		if i["QFJ_CastTime"] ~= g then
			if k("1.5") - (i["GetTime"]() - i["QFJ_CastTime"]) > k("0") then
				return k("1.5") - (i["GetTime"]() - i["QFJ_CastTime"])
			end
		end;
		if i["WL_CastTime"] ~= g then
			if k("0.5") - (i["GetTime"]() - i["WL_CastTime"]) > k("0") then
				return k("0.5") - (i["GetTime"]() - i["WL_CastTime"])
			end
		end;
		if i["JSSP_CastTime"] ~= g then
			if k("0.5") - (i["GetTime"]() - i["JSSP_CastTime"]) > k("0") then
				return k("0.5") - (i["GetTime"]() - i["JSSP_CastTime"])
			end
		end;
		if i["JLPB_CastTime"] ~= g then
			if k("4") - (i["GetTime"]() - i["JLPB_CastTime"]) > k("0") then
				return k("4") - (i["GetTime"]() - i["JLPB_CastTime"])
			end
		end;
		return k("999")
	end;
	i["WR_ResistSustained"] = function(b9)
		if b9 == g or i["UnitHealth"]("player") / i["UnitHealthMax"]("player") <= b9 then
			local ba = i["WR_GetRangeSpellTime"](k("45"), i["SustainedAoe"])
			if ba < k("999") then
				return f
			end;
			if i["WR_GetUnitDebuffTime"]("player", i["SustainedDebuff"]) > k("0") then
				return f
			end;
			for M = k("1"), k("40"), k("1") do
				if i["UnitExists"]("nameplate" .. M) then
					if i["WR_GetUnitBuffTime"]("nameplate" .. M, i["SustainedBuff"]) > k("0") then
						return f
					end;
					for y, L in i["pairs"](i["NecroblastName"]) do
						if L == i["UnitName"]("nameplate" .. M) and i["UnitHealth"]("nameplate" .. M) / i["UnitHealthMax"]("nameplate" .. M) <= k("0.15") then
							return f
						end
					end
				end
			end;
			if i["JSJM_CastTime"] ~= g and i["GetTime"]() - i["JSJM_CastTime"] < k("3") then
				return f
			end
		end;
		return e
	end;
	i["WR_MustDefenseTime"] = function()
		local bb = i["WR_ResistSustained"]()
		local bc = i["WR_ResistOutburstTime"]()
		if i["UnitHealth"]("player") / i["UnitHealthMax"]("player") <= k("0.35") and i["UnitAffectingCombat"]("player") then
			if bb or not i["WR_InBossCombat"]() then
				return k("0")
			end;
			if bc < k("999") then
				return bc
			end
		end;
		if bc < k("999") and (bb or i["WR_GetUnitDebuffCount"]("player", "音速易伤") >= k("2")) then
			return bc
		end;
		local bd = i["WR_GetRangeSpellTime"](k("45"), i["DangerOutburstAoe"])
		if bd < k("999") then
			return bd
		end;
		local be = i["WR_GetRangeSpellTime"](k("45"), i["DangerSustainedAoe"])
		if be < k("999") then
			return k("0")
		end;
		local bf = i["WR_GetRangeSpellTime"](k("45"), "熔炉之力")
		if bf > k("6") and bf < k("999") then
			return bf - k("6")
		end;
		if i["UnitName"]("boss1") == "丹塔利纳克斯" and i["UnitCastingInfo"]("boss1") == "暗影箭雨" and i["WR_GetUnitDebuffCount"]("player", "拉文凯斯的遗产") == k("0") then
			return k("0")
		end;
		if i["WR_GetUnitDebuffTime"]("player", i["DangerDebuff"]) > k("0") then
			return k("0")
		end;
		local bg = i["WR_GetRangeSpellTime"](k("45"), i["DangerSpellToMe"], "player")
		if bg <= k("0.8") then
			return bg
		end;
		i["WR_DangerSpellTime"]()
		if i["SF_CastTime"] ~= g then
			if k("6.2") - (i["GetTime"]() - i["SF_CastTime"]) > k("0") then
				return k("6.2") - (i["GetTime"]() - i["SF_CastTime"])
			end
		end;
		return k("999")
	end;
	i["WR_Escape"] = function()
		if not i["WR_PlayerMove"]() and i["UnitAffectingCombat"]("player") then
			if i["WR_GetRangeSpellTime"](k("45"), i["EscapeSpellName"], "player") < k("999") then
				return f
			end
		end;
		return e
	end;
	i["WR_GetEquipCD"] = function(bh)
		if i["GetInventoryItemID"]("player", bh) == k("203729") then
			return e
		end;
		local w, x, bi = i["GetInventoryItemCooldown"]("player", bh)
		if bi == k("1") then
			if w + x <= i["GetTime"]() + i["GCD"] then
				return f
			end
		end;
		return e
	end;
	i["WR_Use_Item"] = function(bj, bk)
		if i["GetInventoryItemID"]("player", bj) == bk and i["WR_GetEquipCD"](bj) then
			return f
		end;
		return e
	end;
	i["WR_WuQi"] = function(aB, bl)
		if bl == k("1") or bl == k("2") and i["zhandoumoshi"] == k("1") then
			if i["WR_GetEquipCD"](k("16")) and i["WR_GetUnitRange"]("target") <= aB and i["WR_TargetInCombat"]("target") then
				if i["WR_ColorFrame_Show"]("F6", "武器") then
					return f
				end
			end
		end;
		return e
	end;
	i["WR_ShiPin"] = function(bj, bl)
		if bl == k("13") then
			return e
		end;
		if not i["WR_GetEquipCD"](bj + k("12")) then
			return e
		end;
		if bj == k("1") then
			if i["WR_Use_Item"](k("13"), k("178783")) and i["WR_GetUnitBuffTime"]("player", k("345549")) > k("0") then
				return e
			end;
			if bl == k("1") then
				if i["WR_ColorFrame_Show"]("F10", bj .. "饰常") then
					return f
				end
			elseif bl == k("2") and i["zhandoumoshi"] == k("1") then
				if i["WR_ColorFrame_Show"]("F10", bj .. "饰爆") then
					return f
				end
			elseif bl >= k("3") and bl <= k("7") then
				if i["WR_GetUnitHP"]("player") <= (bl - k("2")) / k("10") then
					if i["WR_ColorFrame_Show"]("ACF2", bj .. "饰自") then
						return f
					end
				end
			elseif bl >= k("8") and bl <= k("12") then
				if i["WR_GetUnitHP"]("player") <= (bl - k("7")) / k("10") then
					if i["WR_ColorFrame_Show"]("ACF2", bj .. "饰协P") then
						return f
					end
				elseif not i["UnitIsDead"]("party1") and i["WR_GetUnitHP"]("party1") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party1") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACF3", bj .. "饰协P1") then
						return f
					end
				elseif not i["UnitIsDead"]("party2") and i["WR_GetUnitHP"]("party2") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party2") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACF5", bj .. "饰协P2") then
						return f
					end
				elseif not i["UnitIsDead"]("party3") and i["WR_GetUnitHP"]("party3") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party3") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACF6", bj .. "饰协P3") then
						return f
					end
				elseif not i["UnitIsDead"]("party4") and i["WR_GetUnitHP"]("party4") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party4") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACF7", bj .. "饰协P4") then
						return f
					end
				end
			end
		elseif bj == k("2") then
			if i["WR_Use_Item"](k("14"), k("178783")) and i["WR_GetUnitBuffTime"]("player", k("345549")) > k("0") then
				return e
			end;
			if bl == k("1") then
				if i["WR_ColorFrame_Show"]("F11", bj .. "饰常") then
					return f
				end
			elseif bl == k("2") and i["zhandoumoshi"] == k("1") then
				if i["WR_ColorFrame_Show"]("F11", bj .. "饰爆") then
					return f
				end
			elseif bl >= k("3") and bl <= k("7") then
				if i["WR_GetUnitHP"]("player") <= (bl - k("2")) / k("10") then
					if i["WR_ColorFrame_Show"]("ACSF2", bj .. "饰自") then
						return f
					end
				end
			elseif bl >= k("8") and bl <= k("12") then
				if i["WR_GetUnitHP"]("player") <= (bl - k("7")) / k("10") then
					if i["WR_ColorFrame_Show"]("ACSF2", bj .. "饰协P") then
						return f
					end
				elseif not i["UnitIsDead"]("party1") and i["WR_GetUnitHP"]("party1") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party1") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACSF3", bj .. "饰协P1") then
						return f
					end
				elseif not i["UnitIsDead"]("party2") and i["WR_GetUnitHP"]("party2") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party2") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACSF5", bj .. "饰协P2") then
						return f
					end
				elseif not i["UnitIsDead"]("party3") and i["WR_GetUnitHP"]("party3") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party3") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACSF6", bj .. "饰协P3") then
						return f
					end
				elseif not i["UnitIsDead"]("party4") and i["WR_GetUnitHP"]("party4") <= (bl - k("5")) / k("10") and i["WR_GetUnitRange"]("party4") <= k("40") then
					if i["WR_ColorFrame_Show"]("ACSF7", bj .. "饰协P4") then
						return f
					end
				end
			end
		end;
		return e
	end;
	i["WR_Use_ZLS"] = function()
		if i["ZLS_UseTime"] ~= g and i["GetTime"]() - i["ZLS_UseTime"] < k("10") then
			return e
		end;
		if i["ZLYS_UseTime"] ~= g and i["GetTime"]() - i["ZLYS_UseTime"] < k("0.5") then
			return e
		end;
		if i["ZLYS2_UseTime"] ~= g and i["GetTime"]() - i["ZLYS2_UseTime"] < k("0.5") then
			return e
		end;
		if i["WR_GetUnitBuffTime"]("player", "圣盾术") > k("0") then
			return e
		end;
		local bm = {
			[k("1")] = "治疗石",
			[k("2")] = "恶魔治疗石"
		}
		for y, bn in i["pairs"](bm) do
			local T = i["C_Item"]["GetItemCount"](bn)
			local w, x, bi = i["C_Item"]["GetItemCooldown"](bn)
			if T ~= g and T >= k("1") and w + x - i["GetTime"]() <= k("0") then
				return f
			end
		end;
		return e
	end;
	i["WR_ZLS"] = function(bo)
		if not i["PlayerHP"] then
			i["PlayerHP"] = i["UnitHealth"]("player") / i["UnitHealthMax"]("player")
		end;
		if bo ~= k("5") and i["PlayerHP"] < bo / k("10") and i["UnitAffectingCombat"]("player") and i["WR_Use_ZLS"]() then
			if i["UnitClassBase"]("player") == "WARLOCK" and i["WR_SpellUsable"]("灵魂燃烧") then
				if i["WR_ColorFrame_Show"]("CN0", "灵魂燃烧") then
					return f
				end
			else
				if i["WR_ColorFrame_Show"]("CSF", "治疗石") then
					return f
				end
			end
		end;
		return e
	end;
	i["WR_Use_ZLYS"] = function()
		if i["ZLS_UseTime"] ~= g and i["GetTime"]() - i["ZLS_UseTime"] < k("0.5") then
			return e
		end;
		if i["ZLYS_UseTime"] ~= g and i["GetTime"]() - i["ZLYS_UseTime"] < k("0.5") then
			return e
		end;
		if i["ZLYS2_UseTime"] ~= g and i["GetTime"]() - i["ZLYS2_UseTime"] < k("0.5") then
			return e
		end;
		if i["WR_GetUnitBuffTime"]("player", "圣盾术") > k("0") then
			return e
		end;
		local bp = {
			[k("1")] = "阿加治疗药水"
		}
		for y, bq in i["pairs"](bp) do
			local T = i["C_Item"]["GetItemCount"](bq)
			local w, x, bi = i["C_Item"]["GetItemCooldown"](bq)
			if T ~= g and T >= k("1") and w + x - i["GetTime"]() <= k("0") then
				return f
			end
		end;
		return e
	end;
	i["WR_Use_ZLYS2"] = function()
		if i["ZLS_UseTime"] ~= g and i["GetTime"]() - i["ZLS_UseTime"] < k("0.5") then
			return e
		end;
		if i["ZLYS_UseTime"] ~= g and i["GetTime"]() - i["ZLYS_UseTime"] < k("0.5") then
			return e
		end;
		if i["ZLYS2_UseTime"] ~= g and i["GetTime"]() - i["ZLYS2_UseTime"] < k("0.5") then
			return e
		end;
		if i["WR_GetUnitBuffTime"]("player", "圣盾术") > k("0") then
			return e
		end;
		local bp = {
			[k("1")] = "洞穴住民的挚爱"
		}
		for y, bq in i["pairs"](bp) do
			local T = i["C_Item"]["GetItemCount"](bq)
			local w, x, bi = i["C_Item"]["GetItemCooldown"](bq)
			if T ~= g and T >= k("1") and w + x - i["GetTime"]() <= k("0") then
				return f
			end
		end;
		return e
	end;
	i["WR_ZLYS"] = function(bo)
		if not i["PlayerHP"] then
			i["PlayerHP"] = i["UnitHealth"]("player") / i["UnitHealthMax"]("player")
		end;
		if bo ~= k("5") and i["PlayerHP"] < bo / k("10") and i["UnitAffectingCombat"]("player") and i["WR_Use_ZLYS"]() then
			if i["WR_ColorFrame_Show"]("CST", "治疗药水") then
				return f
			end
		end;
		return e
	end;
	i["WR_ZLYS2"] = function(bo)
		if not i["PlayerHP"] then
			i["PlayerHP"] = i["UnitHealth"]("player") / i["UnitHealthMax"]("player")
		end;
		if bo ~= k("5") and i["PlayerHP"] < bo / k("10") and i["UnitAffectingCombat"]("player") and i["WR_Use_ZLYS2"]() then
			if i["WR_ColorFrame_Show"]("CSX", "治疗药水2") then
				return f
			end
		end;
		return e
	end;
	i["WR_Use_BFYS"] = function()
		local br = {
			[k("1")] = "淬火药水"
		}
		for y, bs in i["pairs"](br) do
			local T = i["C_Item"]["GetItemCount"](bs)
			local w, x, bi = i["C_Item"]["GetItemCooldown"](bs)
			if T ~= g and T >= k("1") and w + x - i["GetTime"]() <= k("0") then
				return f
			end
		end;
		return e
	end;
	i["WR_GetTrueCastTime"] = function(A)
		local S, bt, bu, bv, aE, aF, l = i["GetSpellInfo"](A)
		return bv / k("1000")
	end;
	i["WR_PreemptiveHealing"] = function(A)
		if i["WR_GetRangeSpellTime"](k("45"), i["QZWY_AOE_Name"]) < k("999") then
			return e
		end;
		if i["WR_GetRangeSpellTime"](k("45"), i["QZWY_Spell_Name"], "player") < k("999") then
			return e
		end;
		if i["WR_ResistOutburstTime"]() < i["WR_GetTrueCastTime"](A) then
			return f
		end;
		return e
	end;
	i["WR_GetInRaidOrParty"] = function()
		for M = k("1"), k("40"), k("1") do
			if i["UnitExists"]("raid" .. M) == f then
				return "raid"
			end
		end;
		for M = k("1"), k("4"), k("1") do
			if i["UnitExists"]("party" .. M) == f then
				return "party"
			end
		end;
		return "single"
	end;
	i["WR_EventNotifications"] = function()
		if i["WR_EventNotificationsIsOpen"] == f then
			return
		end;
		local bw = i["CreateFrame"]("Frame")
		bw["RegisterEvent"](bw, "COMBAT_LOG_EVENT_UNFILTERED")
		bw["SetScript"](bw, "OnEvent", function()
			if i["IsInInstance"]() then
				local bx = "SAY"
				local by, bz, bA, bB, bC, bD, bE, bF, bG, bH, bI = i["CombatLogGetCurrentEventInfo"]()
				if bz == "SPELL_INTERRUPT" then
					local a_, bJ, bK, bL, bM, bN = i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]())
					if bC == i["UnitName"]("player") or bC == i["UnitName"]("pet") then
						i["SendChatMessage"]("打断-->" .. i["C_Spell"]["GetSpellLink"](bL), bx)
					end
				elseif bz == "SPELL_DISPEL" then
					local a_, bJ, bK, bL, bM, bN, bO = i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]())
					if bC == i["UnitName"]("player") or bC == i["UnitName"]("pet") then
						i["SendChatMessage"]("驱散-->" .. i["C_Spell"]["GetSpellLink"](bL), bx)
					end
				elseif bz == "SPELL_STOLEN" then
					local a_, bJ, bK, bL, bM, bN, bO = i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]())
					if bC == i["UnitName"]("player") then
						i["SendChatMessage"]("偷取-->" .. i["C_Spell"]["GetSpellLink"](bL), bx)
					end
				elseif bz == "SPELL_MISSED" then
					local a_, bJ, bK, bP, bQ, bR = i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]())
					if bP == "REFLECT" and bG == i["UnitName"]("player") then
						i["SendChatMessage"]("反射-->" .. i["C_Spell"]["GetSpellLink"](a_), bx)
					elseif bP == "ABSORB" and bG == "根基图腾" and bH == k("8465") then
						i["SendChatMessage"]("吸收-->" .. i["C_Spell"]["GetSpellLink"](a_), bx)
					end
				end
			end
		end)
		i["WR_EventNotificationsIsOpen"] = f
	end;
	i["WR_HidePlayerNotFound"] = function()
		if i["WR_HidePlayerNotFoundIsOpen"] == f then
			return
		end;
		i["ChatFrame_AddMessageEventFilter"]("CHAT_MSG_SYSTEM", function(y, y, bS)
			if i["strmatch"](bS, i["ERR_CHAT_PLAYER_NOT_FOUND_S"]["gsub"](i["ERR_CHAT_PLAYER_NOT_FOUND_S"], "%%%d?$?%a", ".*")) then
				return f
			end
		end)
		local bT = i["CommunitiesGuildNewsFrame_OnEvent"]
		local bU, bV;
		i["CommunitiesFrameGuildDetailsFrameNews"]["SetScript"](i["CommunitiesFrameGuildDetailsFrameNews"], "OnEvent", function(bW, bX)
			if bX == "GUILD_NEWS_UPDATE" then
				if bV then
					bU = f
				else
					bT(bW, bX)
					bV = i["C_Timer"]["NewTimer"](k("1"), function()
						if bU then
							bT(bW, bX)
						end;
						bV = g
					end)
				end
			else
				bT(bW, bX)
			end
		end)
		i["WR_HidePlayerNotFoundIsOpen"] = f
	end;
	i["WR_DangerSpellTime"] = function()
		if i["WR_DangerSpellTimeIsOpen"] == f then
			return
		end;
		local bw = i["CreateFrame"]("Frame")
		bw["RegisterEvent"](bw, "COMBAT_LOG_EVENT_UNFILTERED")
		bw["SetScript"](bw, "OnEvent", function()
			if i["select"](k("2"), i["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
				local u = i["select"](k("13"), i["CombatLogGetCurrentEventInfo"]())
				if u == "霜风" then
					i["SF_CastTime"] = i["GetTime"]()
				end;
				if u == "强风箭" then
					i["QFJ_CastTime"] = i["GetTime"]()
				end;
				if u == "紊流" then
					i["WL_CastTime"] = i["GetTime"]()
				end;
				if u == "坚石碎片" then
					i["JSSP_CastTime"] = i["GetTime"]()
				end;
				if u == "警示尖鸣" then
					i["JSJM_CastTime"] = i["GetTime"]()
				end;
				if u == "激流破奔" then
					i["JLPB_CastTime"] = i["GetTime"]()
				end
			end
		end)
		i["WR_DangerSpellTimeIsOpen"] = f
	end;
	i["WR_CanTab"] = function()
		for y, S in i["pairs"](i["DontTabUnitName"]) do
			if i["UnitName"]("target") == S then
				return e
			end
		end;
		return f
	end;
	i["WR_CanDot"] = function(N)
		i["TempUnit"] = N;
		if i["TempUnit"] == g then
			i["TempUnit"] = "target"
		end;
		for y, S in i["pairs"](i["DontDotUnitName"]) do
			if i["UnitName"](i["TempUnit"]) == S then
				return e
			end
		end;
		for y, S in i["pairs"](i["InvincibleUnitName"]) do
			if i["UnitName"](i["TempUnit"]) == S then
				return e
			end
		end;
		return f
	end;
	i["WR_PartyNotBuff"] = function(Z, A)
		if i["WR_GetUnitBuffCount"]("player", Z) == k("0") then
			return f
		end;
		if not i["IsInInstance"]() then
			return e
		end;
		if i["UnitAffectingCombat"]("player") then
			return e
		end;
		for M = k("1"), k("40"), k("1") do
			if M <= k("4") then
				i["unit"] = "party" .. M;
				if i["UnitExists"](i["unit"]) and i["UnitIsPlayer"](i["unit"]) and not i["UnitCanAttack"]("player", i["unit"]) and not i["UnitIsDead"](i["unit"]) and i["WR_GetUnitBuffCount"](i["unit"], Z) == k("0") and (i["WR_GetUnitRange"](i["unit"]) <= k("50") or A ~= g and i["IsSpellInRange"](A, i["unit"])) then
					return f
				end;
				i["unit"] = "raid" .. M;
				if i["UnitExists"](i["unit"]) and i["UnitIsPlayer"](i["unit"]) and not i["UnitCanAttack"]("player", i["unit"]) and not i["UnitIsDead"](i["unit"]) and i["WR_GetUnitBuffCount"](i["unit"], Z) == k("0") and (i["WR_GetUnitRange"](i["unit"]) <= k("50") or A ~= g and i["IsSpellInRange"](A, i["unit"])) then
					return f
				end
			end
		end;
		return e
	end;
	i["WR_CanRemoveUnitDebuff"] = function(N)
		local ac = e;
		local ad = e;
		local ae = e;
		local af = e;
		if i["IsPlayerSpell"](k("527")) == f then
			ac = f
		end;
		if i["IsSpellKnown"](k("89808"), f) == f then
			ac = f
		end;
		if i["IsPlayerSpell"](k("77130")) == f then
			ac = f
		end;
		if i["IsPlayerSpell"](k("4987")) == f then
			ac = f
		end;
		if i["IsPlayerSpell"](k("213644")) == f then
			ae = f;
			af = f
		end;
		if i["IsPlayerSpell"](k("115450")) == f then
			ac = f
		end;
		if i["IsPlayerSpell"](k("390632")) == f then
			ae = f
		end;
		if i["IsPlayerSpell"](k("383016")) == f then
			ad = f
		end;
		if i["IsPlayerSpell"](k("51886")) == f then
			ad = f
		end;
		if i["IsPlayerSpell"](k("2782")) == f then
			ad = f;
			af = f
		end;
		if i["IsPlayerSpell"](k("218164")) == f then
			ae = f;
			af = f
		end;
		if i["IsPlayerSpell"](k("393024")) == f then
			af = f;
			ae = f
		end;
		if i["IsPlayerSpell"](k("388874")) == f then
			af = f;
			ae = f
		end;
		if i["IsPlayerSpell"](k("365585")) == f then
			af = f
		end;
		if i["IsPlayerSpell"](k("475")) == f then
			ad = f
		end;
		if i["IsPlayerSpell"](k("213634")) == f then
			ae = f
		end;
		if i["IsPlayerSpell"](k("88423")) == f then
			ac = f
		end;
		if i["IsPlayerSpell"](k("392378")) == f then
			af = f;
			ad = f
		end;
		if i["WR_GetUnitDebuffTime"](N, i["ZXQS_Debuff"]) > k("0") and i["UnitGUID"](N) ~= i["UnitGUID"]("mouseover") then
			return e
		end;
		if i["WR_GetUnitDebuffTime"](N, "消解时间") > k("0") then
			return e
		end;
		if i["WR_GetUnitDebuffTime"](N, i["HuLueQuSanDebuffName"]) > k("0") then
			return e
		end;
		if ac == f and i["WR_UnitDebuffType"](N, "Magic") == f then
			return f
		end;
		if ad == f and i["WR_UnitDebuffType"](N, "Curse") == f then
			return f
		end;
		if ae == f and i["WR_UnitDebuffType"](N, "Disease") == f then
			return f
		end;
		if af == f and i["WR_UnitDebuffType"](N, "Poison") == f then
			return f
		end;
		return e
	end;
	i["WR_CanRemoveUnitDangerDebuff"] = function(N)
		if not i["WR_CanRemoveUnitDebuff"](N) then
			return e
		end;
		if i["WR_GetUnitDebuffTime"](N, i["DangerRemoveDebuff"]) > k("0") then
			return f
		end;
		if i["WR_GetUnitDebuffCount"](N, "爆裂") >= k("5") then
			return f
		end;
		if i["WR_GetUnitDebuffCount"](N, "压制瘴气") >= k("10") then
			return f
		end
	end;
	i["WR_ResurrectParty"] = function()
		for M = k("1"), k("40"), k("1") do
			local aJ;
			if M <= k("4") then
				aJ = "party" .. M;
				if i["UnitIsDead"](aJ) and i["WR_GetUnitRange"](aJ) <= k("100") then
					return f
				end;
				aJ = "raid" .. M;
				if i["UnitIsDead"](aJ) and i["WR_GetUnitRange"](aJ) <= k("100") then
					return f
				end
			end
		end;
		return e
	end;
	i["WR_StopCast"] = function(bY)
		if i["WR_GetRangeSpellTime"](k("45"), i["StopCastID"]) < bY + k("0.4") then
			return f
		end;
		return e
	end;
	i["WR_RangeCountPR"] = function(aB, bZ)
		local aJ;
		local b_ = k("0")
		aJ = "player"
		if i["UnitHealthMax"](aJ) ~= k("0") and i["WR_GetUnitHP"](aJ) <= bZ then
			b_ = b_ + k("1")
		end;
		if i["UnitExists"]("raid1") then
			for M = k("1"), k("40"), k("1") do
				aJ = "raid" .. M;
				local aF = i["WR_GetUnitRange"](aJ)
				local c0 = k("0")
				if i["UnitExists"](aJ) then
					c0 = i["WR_GetUnitHP"](aJ)
				end;
				if aF ~= g and aF <= aB and c0 > k("0") and c0 <= bZ then
					b_ = b_ + k("1")
				end
			end
		else
			for M = k("1"), k("4"), k("1") do
				aJ = "party" .. M;
				local aF = i["WR_GetUnitRange"](aJ)
				local c0 = k("0")
				if i["UnitExists"](aJ) then
					c0 = i["WR_GetUnitHP"](aJ)
				end;
				if aF ~= g and aF <= aB and c0 > k("0") and c0 <= bZ then
					b_ = b_ + k("1")
				end
			end
		end;
		return b_
	end;
	i["WR_UnitEnragedBuff"] = function(N)
		if i["WR_GetUnitBuffCount"](N, "无穷饥渴") >= k("6") then
			return f
		end;
		if i["WR_GetUnitBuffTime"](N, i["EnragedBuffName"]) > k("0") then
			return f
		end
	end;
	i["WR_GetCastInterruptible"] = function(N, c1, c2)
		if i["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return e
		end;
		if i["UnitCastingInfo"](N) == "星宇飞升" then
			return e
		end;
		if i["UnitName"]("boss1") == "无堕者哈夫" then
			return e
		end;
		local c3, c4, c5 = i["WR_GetUnitCastInfo"](N, c2)
		if c3 ~= g and c5 ~= g then
			if c3 / (c3 + c4) >= c1 and c5 == f then
				return f
			end
		end;
		local c6, c7 = i["WR_GetUnitChannelInfo"](N, c2)
		if c6 ~= g and c7 ~= g then
			if c6 >= c1 and c7 == f then
				return f
			end
		end;
		return e
	end;
	i["WR_GetUnitCastInfo"] = function(N, c2)
		local c8 = g;
		local c9 = g;
		local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"](N)
		if z ~= g then
			for y, ca in i["pairs"](i["MustInterruptUnitName"]) do
				if i["UnitName"](N) == ca then
					return i["GetTime"]() - aW / k("1000"), z / k("1000") - i["GetTime"](), not aZ
				end
			end;
			if i["UnitIsPlayer"](N) then
				return i["GetTime"]() - aW / k("1000"), z / k("1000") - i["GetTime"](), not aZ
			end;
			local S, aN, aO, aP = i["GetInstanceInfo"]()
			if aO ~= k("8") then
				return i["GetTime"]() - aW / k("1000"), z / k("1000") - i["GetTime"](), not aZ
			end;
			if c2 then
				for cb, u in i["pairs"](i["MustInterruptSpellName"]) do
					if a_ == cb or S == u then
						return i["GetTime"]() - aW / k("1000"), z / k("1000") - i["GetTime"](), not aZ
					end
				end
			else
				for cc, cd in i["pairs"](i["ExcludeSpell"]) do
					if a_ == cc or S == cd then
						return g, g, g
					end
				end;
				return i["GetTime"]() - aW / k("1000"), z / k("1000") - i["GetTime"](), not aZ
			end
		end;
		return g, g, g
	end;
	i["WR_GetUnitChannelInfo"] = function(N, c2)
		local ce = g;
		local cf = g;
		local S, aU, aV, aW, z, aX, aZ, a_ = i["UnitChannelInfo"](N)
		if z ~= g then
			for y, ca in i["pairs"](i["MustInterruptUnitName"]) do
				if i["UnitName"](N) == ca then
					return i["GetTime"]() - aW / k("1000"), not aZ
				end
			end;
			if i["UnitIsPlayer"](N) then
				return i["GetTime"]() - aW / k("1000"), not aZ
			end;
			if c2 then
				for cb, u in i["pairs"](i["MustInterruptSpellName"]) do
					if a_ == cb or S == u then
						return i["GetTime"]() - aW / k("1000"), not aZ
					end
				end
			else
				for cc, cd in i["pairs"](i["ExcludeSpell"]) do
					if a_ == cc or S == cd then
						return g, g
					end
				end;
				return i["GetTime"]() - aW / k("1000"), not aZ
			end
		end;
		return g, g
	end;
	i["WR_GetRuneCount"] = function()
		local cg = k("0")
		for M = k("1"), k("6") do
			if i["GetRuneCount"](M) ~= g then
				cg = cg + i["GetRuneCount"](M)
			end
		end;
		return cg
	end;
	i["WR_TankResist"] = function()
		local ch = k("999")
		local ci = k("999")
		local cj = k("999")
		local ck = k("999")
		for M = k("1"), k("40"), k("1") do
			if i["UnitName"]("boss1") == "乌比斯将军" and i["WR_GetUnitDebuffCount"]("player", "碎颅打击") >= k("2") and i["WR_GetUnitDebuffTime"]("player", "碎颅打击") > k("4") then
				cj = k("1.4")
				ck = k("1.4")
			end;
			local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"]("nameplate" .. M)
			if S ~= g then
				if i["UnitIsUnit"]("nameplate" .. M .. "target", "player") then
					if i["TankResist_SmallMagicToMe"] ~= g then
						for cb, u in i["pairs"](i["TankResist_SmallMagicToMe"]) do
							if u == h then
								break
							end;
							if u == S or cb == a_ then
								ch = z / k("1000") - i["GetTime"]()
							end
						end
					end;
					if i["TankResist_BigMagicToMe"] ~= g then
						for cb, u in i["pairs"](i["TankResist_BigMagicToMe"]) do
							if u == h then
								break
							end;
							if u == S or cb == a_ then
								ci = z / k("1000") - i["GetTime"]()
							end
						end
					end;
					if i["TankResist_SmallPhysicalToMe"] ~= g then
						for cb, u in i["pairs"](i["TankResist_SmallPhysicalToMe"]) do
							if u == h then
								break
							end;
							if u == S or cb == a_ then
								cj = z / k("1000") - i["GetTime"]()
							end
						end
					end;
					if i["TankResist_BigPhysicalToMe"] ~= g then
						for cb, u in i["pairs"](i["TankResist_BigPhysicalToMe"]) do
							if u == h then
								break
							end;
							if u == S or cb == a_ then
								ck = z / k("1000") - i["GetTime"]()
							end
						end
					end
				end;
				if i["TankResist_SmallMagicToAoe"] ~= g then
					for cb, u in i["pairs"](i["TankResist_SmallMagicToAoe"]) do
						if u == h then
							break
						end;
						if u == S or cb == a_ then
							ch = z / k("1000") - i["GetTime"]()
						end
					end
				end;
				if i["TankResist_BigMagicToAoe"] ~= g then
					for cb, u in i["pairs"](i["TankResist_BigMagicToAoe"]) do
						if u == h then
							break
						end;
						if u == S or cb == a_ then
							ci = z / k("1000") - i["GetTime"]()
						end
					end
				end;
				if i["TankResist_SmallPhysicalToAoe"] ~= g then
					for cb, u in i["pairs"](i["TankResist_SmallPhysicalToAoe"]) do
						if u == h then
							break
						end;
						if u == S or cb == a_ then
							cj = z / k("1000") - i["GetTime"]()
						end
					end
				end;
				if i["TankResist_BigPhysicalToAoe"] ~= g then
					for cb, u in i["pairs"](i["TankResist_BigPhysicalToAoe"]) do
						if u == h then
							break
						end;
						if u == S or cb == a_ then
							ck = z / k("1000") - i["GetTime"]()
						end
					end
				end
			end
		end;
		return ch, ci, cj, ck
	end;
	i["WR_SpellReflection"] = function(cl)
		for M = k("1"), k("40"), k("1") do
			local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"]("nameplate" .. M)
			if z ~= g then
				if z / k("1000") - i["GetTime"]() < cl then
					for cb, u in i["pairs"](i["ReflectionAOE"]) do
						if u == S or cb == a_ then
							return f
						end
					end;
					if i["UnitIsUnit"]("nameplate" .. M .. "target", "player") then
						for cb, u in i["pairs"](i["ReflectionSpell"]) do
							if u == S or cb == a_ then
								return f
							end
						end
					end
				end
			end;
			local S, aU, aV, aW, z, aX, aZ, a_ = i["UnitChannelInfo"]("nameplate" .. M)
			if aW ~= g then
				for cb, u in i["pairs"](i["ReflectionAOE"]) do
					if u == S or cb == a_ then
						return f
					end
				end;
				if i["UnitIsUnit"]("nameplate" .. M .. "target", "player") then
					for cb, u in i["pairs"](i["ReflectionSpell"]) do
						if u == S or cb == a_ then
							return f
						end
					end
				end
			end
		end;
		return e
	end;
	i["WR_StunUnit"] = function(aB, cl)
		if i["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return e
		end;
		local M = k("1")
		while i["DontStunUnitName"][M] ~= g and i["DontStunUnitName"][M] ~= h do
			if i["DontStunUnitName"][M] == i["UnitName"]("target") then
				return e
			end;
			M = M + k("1")
		end;
		for M = k("1"), k("40"), k("1") do
			if i["UnitCanAttack"]("player", "nameplate" .. M) then
				local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"]("nameplate" .. M)
				if S ~= g then
					local aF = i["WR_GetUnitRange"]("nameplate" .. M)
					if aF ~= g and aF <= aB and (cl == g or z / k("1000") - i["GetTime"]() < cl) then
						for cb, u in i["pairs"](i["StunCastName"]) do
							if u == S or cb == a_ then
								return f
							end
						end
					end
				end;
				local S, aU, aV, aW, z, aX, aZ, a_ = i["UnitChannelInfo"]("nameplate" .. M)
				if S ~= g then
					local aF = i["WR_GetUnitRange"]("nameplate" .. M)
					if aF ~= g and aF <= aB then
						for cb, u in i["pairs"](i["StunChannelName"]) do
							if u == S or cb == a_ then
								return f
							end
						end
					end
				end
			end
		end;
		return e
	end;
	i["WR_GetSpellNextCharge"] = function(u)
		if i["C_Spell"]["GetSpellCharges"](u) == g then
			return k("999")
		end;
		local cm = i["C_Spell"]["GetSpellCharges"](u)["cooldownStartTime"]
		local cn = i["C_Spell"]["GetSpellCharges"](u)["cooldownDuration"]
		if cm == k("0") then
			return k("0")
		end;
		return cm + cn - i["GetTime"]()
	end;
	i["WR_GetSpellCharges"] = function(u)
		if i["C_Spell"]["GetSpellCharges"](u) ~= g then
			return i["C_Spell"]["GetSpellCharges"](u)["currentCharges"] or k("0")
		end
	end;
	i["WR_GetSuit"] = function(co)
		local cp = k("0")
		for M = k("1"), k("19") do
			local cq = i["GetInventoryItemID"]("player", M)
			for y, cr in i["pairs"](co) do
				if cq == cr then
					cp = cp + k("1")
				end
			end
		end;
		return cp
	end;
	i["WR_StunSpell"] = function(N, cl)
		if i["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return e
		end;
		local P, y = i["UnitName"](N)
		local aL, y, y, y = i["GetUnitSpeed"](N)
		local M = k("1")
		while i["StunUnitName"][M] ~= g and i["StunUnitName"][M] ~= h do
			if i["StunUnitName"][M] == P and aL > k("0") then
				return f
			end;
			M = M + k("1")
		end;
		local M = k("1")
		while i["DontStunUnitName"][M] ~= g and i["DontStunUnitName"][M] ~= h do
			if i["DontStunUnitName"][M] == P then
				return e
			end;
			M = M + k("1")
		end;
		if i["UnitCanAttack"]("player", N) then
			local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"](N)
			if S ~= g and (cl == g or z / k("1000") - i["GetTime"]() < cl) then
				for cb, u in i["pairs"](i["StunCastName"]) do
					if u == S or cb == a_ then
						return f
					end
				end
			end;
			local S, aU, aV, aW, z, aX, aZ, a_ = i["UnitChannelInfo"](N)
			if S ~= g then
				for cb, u in i["pairs"](i["StunChannelName"]) do
					if u == S or cb == a_ then
						return f
					end
				end
			end
		end;
		return e
	end;
	i["WR_SingleUnit"] = function()
		local P, y = i["UnitName"]("target")
		local O = k("1")
		while i["SingleUnitName"][O] ~= g and i["SingleUnitName"][O] ~= h do
			if P == i["SingleUnitName"][O] then
				return f
			end;
			O = O + k("1")
		end;
		return e
	end;
	i["WR_GetPartyRange"] = function()
		local M;
		i["TargetRange"] = i["WR_GetUnitRange"]("target")
		i["FocusRange"] = i["WR_GetUnitRange"]("focus")
		for M = k("1"), k("4"), k("1") do
			i["PartyRange"][M] = i["WR_GetUnitRange"]("party" .. M)
		end;
		for M = k("1"), k("40"), k("1") do
			i["RiadRange"][M] = i["WR_GetUnitRange"]("raid" .. M)
		end
	end;
	i["WR_GetPartyLostHealth"] = function()
		local M;
		i["PlayerLostHealth"] = i["WR_GetUnitLostHealth"]("player")
		i["TargetLostHealth"] = i["WR_GetUnitLostHealth"]("target")
		i["FocusLostHealth"] = i["WR_GetUnitLostHealth"]("focus")
		for M = k("1"), k("4"), k("1") do
			i["PartyLostHealth"][M] = i["WR_GetUnitLostHealth"]("party" .. M)
		end;
		for M = k("1"), k("40"), k("1") do
			i["RiadLostHealth"][M] = i["WR_GetUnitLostHealth"]("raid" .. M)
		end
	end;
	i["WR_GetLastSpellName"] = function()
		if i["WR_LastSpellNameIsOpen"] == f then
			return
		end;
		local bw = i["CreateFrame"]("Frame")
		bw["RegisterEvent"](bw, "COMBAT_LOG_EVENT_UNFILTERED")
		bw["SetScript"](bw, "OnEvent", function()
			local by, cs, bA, bB, bC, bD, bE, bF, bG, bH, bI = i["CombatLogGetCurrentEventInfo"]()
			if cs == "SPELL_CAST_SUCCESS" and bB == i["UnitGUID"]("player") then
				i["WR_LastSpellName"] = i["select"](k("13"), i["CombatLogGetCurrentEventInfo"]())
			end
		end)
		i["WR_LastSpellNameIsOpen"] = f
	end;
	i["WR_GetSpellAuraApplied"] = function()
		if i["WR_GetSpellAuraAppliedIsOpen"] == f then
			return
		end;
		local bw = i["CreateFrame"]("Frame")
		bw["RegisterEvent"](bw, "COMBAT_LOG_EVENT_UNFILTERED")
		bw["SetScript"](bw, "OnEvent", function()
			local by, cs, bA, bB, bC, bD, bE, bF, bG, bH, bI = i["CombatLogGetCurrentEventInfo"]()
			if cs == "SPELL_AURA_APPLIED" and bF == i["UnitGUID"]("player") then
				if i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]()) == k("438141") or i["select"](k("13"), i["CombatLogGetCurrentEventInfo"]()) == "暮光屠戮" then
					i["MGTL_DebuffTime"] = i["GetTime"]()
				end
			end;
			if cs == "SPELL_CAST_START" and bF == i["UnitGUID"]("player") then
				if i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]()) == k("438141") or i["select"](k("13"), i["CombatLogGetCurrentEventInfo"]()) == "暮光屠戮" then
					i["MGTL_DebuffTime"] = i["GetTime"]()
				end
			end;
			if bF == i["UnitGUID"]("player") then
			end
		end)
		i["WR_GetSpellAuraAppliedIsOpen"] = f
	end;
	i["WR_SpeedUp"] = function()
		if i["WR_GetUnitDebuffInfo"]("player", "能量过载", e) ~= k("0") then
			return f
		end;
		i["WR_GetSpellAuraApplied"]()
		if i["MGTL_DebuffTime"] ~= g and i["GetTime"]() - i["MGTL_DebuffTime"] > k("0") and i["GetTime"]() - i["MGTL_DebuffTime"] < k("2") then
			return f
		end;
		for M = k("1"), k("40"), k("1") do
			if i["UnitName"]("nameplate" .. M) == "怨毒影魔" and i["UnitIsUnit"]("nameplate" .. M .. "target", "player") then
				return f
			end;
			local S, aU, aV, aW, z, aX, aY, aZ, a_ = i["UnitCastingInfo"]("nameplate" .. M)
			if S == g then
				S, aU, aV, aW, z, aX, aZ, a_ = i["UnitChannelInfo"]("nameplate" .. M)
			end;
			if S ~= g then
				for cb, u in i["pairs"](i["SpeedUpSpellName"]) do
					if u == S or cb == a_ then
						return f
					end
				end
			end
		end;
		return e
	end;
	i["WR_GetUnitCrazyBuff"] = function(N)
		for y, Z in i["pairs"](i["CrazyBuff"]) do
			if i["WR_GetUnitBuffInfo"](N, Z) > k("12") then
				return f
			end
		end;
		i["WR_GetCrazyBuffTime"]()
		if N == "party1" and i["WR_GetCrazyBuffTime_Party1"] ~= g and i["GetTime"]() - i["WR_GetCrazyBuffTime_Party1"] <= k("2") then
			return f
		end;
		if N == "party2" and i["WR_GetCrazyBuffTime_Party2"] ~= g and i["GetTime"]() - i["WR_GetCrazyBuffTime_Party2"] <= k("2") then
			return f
		end;
		if N == "party3" and i["WR_GetCrazyBuffTime_Party3"] ~= g and i["GetTime"]() - i["WR_GetCrazyBuffTime_Party3"] <= k("2") then
			return f
		end;
		if N == "party4" and i["WR_GetCrazyBuffTime_Party4"] ~= g and i["GetTime"]() - i["WR_GetCrazyBuffTime_Party4"] <= k("2") then
			return f
		end;
		return e
	end;
	i["WR_GetCrazyBuffTime"] = function()
		if i["WR_GetCrazyBuffTimeIsOpen"] == f then
			return
		end;
		local bw = i["CreateFrame"]("Frame")
		bw["RegisterEvent"](bw, "COMBAT_LOG_EVENT_UNFILTERED")
		bw["SetScript"](bw, "OnEvent", function()
			local by, cs, bA, bB, bC, bD, bE, bF, bG, bH, bI = i["CombatLogGetCurrentEventInfo"]()
			if cs == "SPELL_CAST_SUCCESS" then
				for y, Z in i["pairs"](i["CrazyBuff"]) do
					if i["select"](k("13"), i["CombatLogGetCurrentEventInfo"]()) == Z or i["select"](k("12"), i["CombatLogGetCurrentEventInfo"]()) == Z then
						if bB == i["UnitGUID"]("party1") then
							i["WR_GetCrazyBuffTime_Party1"] = i["GetTime"]()
						end;
						if bB == i["UnitGUID"]("party2") then
							i["WR_GetCrazyBuffTime_Party2"] = i["GetTime"]()
						end;
						if bB == i["UnitGUID"]("party3") then
							i["WR_GetCrazyBuffTime_Party3"] = i["GetTime"]()
						end;
						if bB == i["UnitGUID"]("party4") then
							i["WR_GetCrazyBuffTime_Party4"] = i["GetTime"]()
						end
					end
				end
			end
		end)
		i["WR_GetCrazyBuffTimeIsOpen"] = f
	end;
	i["WR_UnitIsHuLueName"] = function(N)
		local ct = i["IsInInstance"]()
		if not ct and i["UnitIsPlayer"](N) then
			return f
		end;
		local P, y = i["UnitName"](N)
		local O = k("1")
		while i["HuLueUnitName"][O] ~= g and i["HuLueUnitName"][O] ~= h do
			if P == i["HuLueUnitName"][O] then
				return f
			end;
			O = O + k("1")
		end;
		return e
	end;
	i["WR_GetNoDebuffRangeUnitCount"] = function(aB, a6, aQ)
		local cu = k("0")
		local cv = k("1")
		if i["Time"] ~= g then
			cv = i["Time"]
		end;
		for M = k("1"), k("40"), k("1") do
			local P, y = i["UnitName"]("nameplate" .. M)
			local aF = i["WR_GetUnitRange"]("nameplate" .. M)
			local cw = i["UnitCanAttack"]("player", "nameplate" .. M)
			local cx = i["UnitAffectingCombat"]("nameplate" .. M)
			local cy = i["WR_GetUnitDebuffInfo"]("nameplate" .. M, a6, f)
			local cz = i["UnitCreatureType"]("nameplate" .. M)
			if not i["WR_UnitIsHuLueName"]("nameplate" .. M) then
				if aF ~= g and aF <= aB and cw == f and cy == k("0") and cz ~= "图腾" and cz ~= "Totem" and cz ~= "气体云雾" and cz ~= "Gas Cloud" then
					if cx == f and aQ == f or aQ ~= f then
						if not i["WR_Invincible"]("nameplate" .. M) then
							cu = cu + k("1")
						end
					end
				end
			end
		end;
		if i["MSG"] == k("1") then
			if aQ == f then
				i["print"]("|cff00ff00", aB, "|cffffffff码内，没有中|cffffdf00", a6, "|cffffffff的战斗中的敌人数量为:|cffff5040", cu)
			else
				i["print"]("|cff00ff00", aB, "|cffffffff码内，没有中|cffffdf00", a6, "|cffffffff的敌人数量为:|cffff5040", cu)
			end
		end;
		return cu
	end;
	i["WR_GetHaveDebuffRangeUnitCount"] = function(aB, a6, aQ, cl)
		local cu = k("0")
		local cv = k("1")
		if cl ~= g then
			cv = cl
		end;
		for M = k("1"), k("40"), k("1") do
			local cz = i["UnitCreatureType"]("nameplate" .. M)
			if cz ~= "图腾" and cz ~= "Totem" and cz ~= "气体云雾" and cz ~= "Gas Cloud" and i["UnitCanAttack"]("player", "nameplate" .. M) and (aQ ~= f or aQ == f and i["UnitAffectingCombat"]("nameplate" .. M)) and i["WR_GetUnitRange"]("nameplate" .. M) <= aB and not i["WR_Invincible"]("nameplate" .. M) and i["WR_GetUnitDebuffInfo"]("nameplate" .. M, a6, f) >= cv then
				cu = cu + k("1")
			end
		end;
		if i["MSG"] == k("1") then
			if aQ == f then
				i["print"]("|cff00ff00", aB, "|cffffffff码内，中|cffffdf00", a6, "|cffffffff的战斗中的敌人数量为:|cffff5040", cu)
			else
				i["print"]("|cff00ff00", aB, "|cffffffff码内，中|cffffdf00", a6, "|cffffffff的敌人数量为:|cffff5040", cu)
			end
		end;
		return cu
	end;
	i["WR_DamageMitigation"] = function(cA, cB, cC)
		if cC > cB then
			return cA * cB
		end;
		i["DamageMitigation"] = cA * (cC - k("1"))
		for M = cC, cB, k("1") do
			i["DamageMitigation"] = i["DamageMitigation"] + cA * i["math"]["sqrt"]((cC - k("1")) / M)
		end;
		return i["DamageMitigation"]
	end;
	i["WR_ColorFrame_Show"] = function(o, q)
		i["WR_HideColorFrame"](i["zhandoumoshi"])
		i["WR_ShowColorFrame"](o, q, i["zhandoumoshi"])
		return f
	end;
	i["WR_FocusUnit"] = function(N, q)
		if not i["UnitIsUnit"]("focus", N) then
			if i["GCD"] > k("0.5") then
				i["WR_FocusHealthMaxWeightUnit_LastTime"] = i["GetTime"]() + i["GCD"]
			else
				i["WR_FocusHealthMaxWeightUnit_LastTime"] = i["GetTime"]() + k("0.5")
			end;
			if N == "player" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF5", q .. "焦点P", i["zhandoumoshi"])
				return f
			elseif N == "party1" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF1", q .. "焦点P1", i["zhandoumoshi"])
				return f
			elseif N == "party2" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF2", q .. "焦点P2", i["zhandoumoshi"])
				return f
			elseif N == "party3" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF3", q .. "焦点P3", i["zhandoumoshi"])
				return f
			elseif N == "party4" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF4", q .. "焦点P4", i["zhandoumoshi"])
				return f
			elseif N == "pet" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF9", q .. "焦点Pet", i["zhandoumoshi"])
				return f
			elseif N == "target" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF11", q .. "焦点T", i["zhandoumoshi"])
				return f
			elseif N == "mouseover" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF12", q .. "焦点M", i["zhandoumoshi"])
				return f
			elseif N == "boss2" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF6", q .. "焦点B2", i["zhandoumoshi"])
				return f
			elseif N == "boss3" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF7", q .. "焦点B3", i["zhandoumoshi"])
				return f
			elseif N == "boss4" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF8", q .. "焦点B4", i["zhandoumoshi"])
				return f
			elseif N == "boss4" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CSF8", q .. "焦点B4", i["zhandoumoshi"])
				return f
			elseif N == "raid1" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN1", q .. "焦点R1", i["zhandoumoshi"])
				return f
			elseif N == "raid2" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN2", q .. "焦点R2", i["zhandoumoshi"])
				return f
			elseif N == "raid3" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN3", q .. "焦点R3", i["zhandoumoshi"])
				return f
			elseif N == "raid4" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN4", q .. "焦点R4", i["zhandoumoshi"])
				return f
			elseif N == "raid5" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN5", q .. "焦点R5", i["zhandoumoshi"])
				return f
			elseif N == "raid6" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN6", q .. "焦点R6", i["zhandoumoshi"])
				return f
			elseif N == "raid7" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN7", q .. "焦点R7", i["zhandoumoshi"])
				return f
			elseif N == "raid8" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN8", q .. "焦点R8", i["zhandoumoshi"])
				return f
			elseif N == "raid9" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN9", q .. "焦点R9", i["zhandoumoshi"])
				return f
			elseif N == "raid10" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("AN0", q .. "焦点R10", i["zhandoumoshi"])
				return f
			elseif N == "raid11" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN1", q .. "焦点R11", i["zhandoumoshi"])
				return f
			elseif N == "raid12" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN2", q .. "焦点R12", i["zhandoumoshi"])
				return f
			elseif N == "raid13" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN3", q .. "焦点R13", i["zhandoumoshi"])
				return f
			elseif N == "raid14" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN4", q .. "焦点R14", i["zhandoumoshi"])
				return f
			elseif N == "raid15" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN5", q .. "焦点R15", i["zhandoumoshi"])
				return f
			elseif N == "raid16" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN6", q .. "焦点R16", i["zhandoumoshi"])
				return f
			elseif N == "raid17" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN7", q .. "焦点R17", i["zhandoumoshi"])
				return f
			elseif N == "raid18" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN8", q .. "焦点R18", i["zhandoumoshi"])
				return f
			elseif N == "raid19" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN9", q .. "焦点R19", i["zhandoumoshi"])
				return f
			elseif N == "raid20" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("CN0", q .. "焦点R20", i["zhandoumoshi"])
				return f
			elseif N == "party1target" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("ACN1", q .. "焦点P1T", i["zhandoumoshi"])
				return f
			elseif N == "party2target" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("ACN2", q .. "焦点P2T", i["zhandoumoshi"])
				return f
			elseif N == "party3target" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("ACN3", q .. "焦点P3T", i["zhandoumoshi"])
				return f
			elseif N == "party4target" then
				i["WR_HideColorFrame"](i["zhandoumoshi"])
				i["WR_ShowColorFrame"]("ACN4", q .. "焦点P4T", i["zhandoumoshi"])
				return f
			end
		end;
		return e
	end;
	i["WR_PriorityCheck"] = function()
		if i["WR_CreateButtonInfo"] ~= f and not i["UnitAffectingCombat"]("player") then
			i["WR_CreateButtonInfo"] = f;
			if i["UnitClassBase"]("player") == "PALADIN" then
				i["WR_PaladinCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "DEATHKNIGHT" then
				i["WR_DeathKnightCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "DRUID" then
				i["WR_DruidCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "HUNTER" then
				i["WR_HunterCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "MAGE" then
				i["WR_MageCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "WARRIOR" then
				i["WR_WarriorCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "SHAMAN" then
				i["WR_ShamanCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "ROGUE" then
				i["WR_RogueCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "PRIEST" then
				i["WR_PriestCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "MONK" then
				i["WR_MonkCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "WARLOCK" then
				i["WR_WarlockCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "EVOKER" then
				i["WR_EvokerCreateButton"]()
			end;
			if i["UnitClassBase"]("player") == "DEMONHUNTER" then
				i["WR_DemonHunterCreateButton"]()
			end
		end;
		if i["WR_Use_Item"](k("13"), k("215174")) and i["WR_GetUnitBuffTime"]("player", k("435493")) > i["GCD"] and i["WR_GetUnitBuffTime"]("player", k("435493")) < k("1.5") then
			if i["WR_ColorFrame_Show"]("F10", "死亡之吻") then
				return f
			end
		end;
		if i["WR_Use_Item"](k("14"), k("215174")) and i["WR_GetUnitBuffTime"]("player", k("435493")) > i["GCD"] and i["WR_GetUnitBuffTime"]("player", k("435493")) < k("1.5") then
			if i["WR_ColorFrame_Show"]("F11", "死亡之吻") then
				return f
			end
		end;
		local cD = {
			[k("1")] = "喝水",
			[k("2")] = "进食",
			[k("3")] = "饮用",
			[k("4")] = "进食饮水",
			[k("5")] = "假死",
			[k("6")] = "影遁",
			[k("7")] = "食物",
			[k("8")] = "饮料",
			[k("9")] = "食物和饮料"
		}
		if i["IsFlying"]() or i["UnitIsDeadOrGhost"]("player") or i["SpellIsTargeting"]() and i["WR_GetUnitBuffTime"]("player", "救赎之魂") == k("0") or i["UnitChannelInfo"]("player") ~= g and i["UnitChannelInfo"]("player") ~= "抚慰之雾" and i["UnitChannelInfo"]("player") ~= "法力茶" and i["UnitChannelInfo"]("player") ~= "时间跳跃" and i["UnitChannelInfo"]("player") ~= "火焰吐息" and i["UnitChannelInfo"]("player") ~= "地壳激变" or i["WR_GetUnitBuffTime"]("player", cD, g, "NAME") ~= k("0") or i["UnitCastingInfo"]("player") ~= g and i["UnitClassBase"]("player") == "PRIEST" and i["GetSpecialization"]() == k("2") then
			i["WR_HideColorFrame"](k("0"))
			i["WR_HideColorFrame"](k("1"))
			return f
		end;
		if not i["UnitIsDeadOrGhost"]("player") and (i["UnitAffectingCombat"]("player") or i["WR_InTraining"]() or i["IsInInstance"]() and i["UnitGroupRolesAssigned"]("player") == "HEALER" or i["UnitClassBase"]("player") == "ROGUE" and i["WR_GetUnitBuffTime"]("player", "潜行") == k("0") or i["WR_Combat"]) then
			i["WR_CombatFrame"]["Show"](i["WR_CombatFrame"])
		else
			i["SetCVar"]("autoUnshift", k("1"))
			i["SetCVar"]("doNotFlashLowHealthWarning", k("1"))
			i["SetCVar"]("secureAbilityToggle", k("1"))
			i["SetCVar"]("findYourselfAnywhereOnlyInCombat", k("0"))
			i["SetCVar"]("findYourselfAnywhere", k("1"))
			i["SetCVar"]("SpellQueueWindow", k("400"))
			i["C_CVar"]["RegisterCVar"]("addonProfilerEnabled", "1")
			i["C_CVar"]["SetCVar"]("addonProfilerEnabled", "0")
			i["WR_CombatFrame"]["Hide"](i["WR_CombatFrame"])
		end;
		if i["zhandoumoshi"] ~= k("1") then
			i["WR_HideColorFrame"](k("1"))
			i["WR_ShowColorFrame"]("CSC", "爆发", k("1"))
		end;
		if i["zhandoumoshi"] == k("1") then
			i["WR_HideColorFrame"](k("0"))
			i["WR_ShowColorFrame"]("CSV", "平伤", k("0"))
		end;
		return e
	end;
	i["WR_GetBN"] = function(q)
		if q ~= g then
			local bj = k("0")
			for M = k("1"), i["string"]["len"](q), k("1") do
				if i["string"]["byte"](q, M) ~= g then
					bj = bj + i["string"]["byte"](q, M)
				end
			end;
			bj = bj .. i["tonumber"](i["string"]["sub"](q, i["string"]["len"](q) - k("3"), i["string"]["len"](q)))
			return bj
		end;
		return g
	end;
	i["WR_Function_ZNMB"] = function(aB, bl)
		if bl == k("3") then
			return e
		end;
		if i["WR_PartyInCombat"]() and (not i["UnitExists"]("target") or i["UnitIsDead"]("target") or not i["UnitCanAttack"]("player", "target") or bl == k("2") and i["WR_GetUnitRange"]("target") > aB or bl == k("2") and not i["WR_TargetInCombat"]("target")) then
			local ao = "pettarget"
			if not i["UnitIsDead"](ao) and i["UnitCanAttack"]("player", ao) and i["WR_TargetInCombat"](ao) and i["WR_GetUnitRange"](ao) <= aB then
				if i["WR_ColorFrame_Show"]("ACN9", "宠物目标") then
					return f
				end
			end;
			for M = k("1"), k("4"), k("1") do
				local ao = "party" .. M .. "target"
				if i["UnitGroupRolesAssigned"]("party" .. M) == "TANK" and not i["UnitIsDead"](ao) and i["UnitCanAttack"]("player", ao) and i["UnitAffectingCombat"](ao) and i["WR_TargetInCombat"](ao) and i["WR_GetUnitRange"](ao) <= aB then
					if M == k("1") then
						if i["WR_ColorFrame_Show"]("ACN5", "智能-" .. M) then
							return f
						end
					elseif M == k("2") then
						if i["WR_ColorFrame_Show"]("ACN6", "智能-" .. M) then
							return f
						end
					elseif M == k("3") then
						if i["WR_ColorFrame_Show"]("ACN7", "智能-" .. M) then
							return f
						end
					elseif M == k("4") then
						if i["WR_ColorFrame_Show"]("ACN8", "智能-" .. M) then
							return f
						end
					end
				end
			end;
			for M = k("1"), k("4"), k("1") do
				local ao = "party" .. M .. "target"
				if not i["UnitIsDead"](ao) and i["UnitCanAttack"]("player", ao) and i["UnitAffectingCombat"](ao) and i["WR_TargetInCombat"](ao) and i["WR_GetUnitRange"](ao) <= aB then
					if M == k("1") then
						if i["WR_ColorFrame_Show"]("ACN5", "智能-" .. M) then
							return f
						end
					elseif M == k("2") then
						if i["WR_ColorFrame_Show"]("ACN6", "智能-" .. M) then
							return f
						end
					elseif M == k("3") then
						if i["WR_ColorFrame_Show"]("ACN7", "智能-" .. M) then
							return f
						end
					elseif M == k("4") then
						if i["WR_ColorFrame_Show"]("ACN8", "智能-" .. M) then
							return f
						end
					end
				end
			end;
			if not i["IsInInstance"]() then
				if (i["WR_TargetEnemyTime"] == g or i["GetTime"]() - i["WR_TargetEnemyTime"] > k("0.2")) and i["WR_GetRangeHarmUnitCount"](aB) >= k("1") then
					i["WR_TargetEnemyTime"] = i["GetTime"]()
					if i["WR_ColorFrame_Show"]("CSF10", "智能目标") then
						return f
					end
				end
			end
		end;
		return e
	end;
	i["WR_DebugTime"] = function(q)
		if not i["wrdebug"] then
			return
		end;
		if q == k("0") then
			i["print"]("循环开始-----------------------------------------")
		end;
		if q ~= g then
			i["TempText"] = q
		else
			i["TempText"] = h
		end;
		if q ~= k("0") and i["WR_Debug_StartTime"] ~= g then
			i["print"]("循环时间" .. q .. ": " .. i["string"]["format"]("%.2f", i["debugprofilestop"]() - i["WR_Debug_StartTime"]) .. "毫秒")
		end;
		i["WR_Debug_StartTime"] = i["debugprofilestop"]()
	end;
	i["WR_FocusMaxWeightUnit"] = function(q)
		if q == g and i["WR_FocusHealthMaxWeightUnit_LastTime"] ~= g and i["GetTime"]() - i["WR_FocusHealthMaxWeightUnit_LastTime"] <= k("0") and i["UnitExists"]("focus") then
			return e
		end;
		i["HMWUnit"] = i["WR_GetHealthMaxWeightUnit"]()
		if i["UnitIsUnit"](i["HMWUnit"], "focus") then
			return e
		end;
		if i["HMWUnit"] == "party1" then
			if i["WR_ColorFrame_Show"]("CSF1", "焦点P1") then
				return f
			end
		elseif i["HMWUnit"] == "party2" then
			if i["WR_ColorFrame_Show"]("CSF2", "焦点P2") then
				return f
			end
		elseif i["HMWUnit"] == "party3" then
			if i["WR_ColorFrame_Show"]("CSF3", "焦点P3") then
				return f
			end
		elseif i["HMWUnit"] == "party4" then
			if i["WR_ColorFrame_Show"]("CSF4", "焦点P4") then
				return f
			end
		elseif i["HMWUnit"] == "player" then
			if i["WR_ColorFrame_Show"]("CSF5", "焦点P") then
				return f
			end
		elseif i["HMWUnit"] == "boss2" then
			if i["WR_ColorFrame_Show"]("CSF6", "焦点b2") then
				return f
			end
		elseif i["HMWUnit"] == "boss3" then
			if i["WR_ColorFrame_Show"]("CSF7", "焦点b3") then
				return f
			end
		elseif i["HMWUnit"] == "boss4" then
			if i["WR_ColorFrame_Show"]("CSF8", "焦点b4") then
				return f
			end
		elseif i["HMWUnit"] == "target" then
			if i["WR_ColorFrame_Show"]("CSF11", "焦点T") then
				return f
			end
		elseif i["HMWUnit"] == "mouseover" then
			if i["WR_ColorFrame_Show"]("CSF12", "焦点M") then
				return f
			end
		elseif i["HMWUnit"] == "raid1" then
			if i["WR_ColorFrame_Show"]("AN1", "焦点R1") then
				return f
			end
		elseif i["HMWUnit"] == "raid2" then
			if i["WR_ColorFrame_Show"]("AN2", "焦点R2") then
				return f
			end
		elseif i["HMWUnit"] == "raid3" then
			if i["WR_ColorFrame_Show"]("AN3", "焦点R3") then
				return f
			end
		elseif i["HMWUnit"] == "raid4" then
			if i["WR_ColorFrame_Show"]("AN4", "焦点R4") then
				return f
			end
		elseif i["HMWUnit"] == "raid5" then
			if i["WR_ColorFrame_Show"]("AN5", "焦点R5") then
				return f
			end
		elseif i["HMWUnit"] == "raid6" then
			if i["WR_ColorFrame_Show"]("AN6", "焦点R6") then
				return f
			end
		elseif i["HMWUnit"] == "raid7" then
			if i["WR_ColorFrame_Show"]("AN7", "焦点R7") then
				return f
			end
		elseif i["HMWUnit"] == "raid8" then
			if i["WR_ColorFrame_Show"]("AN8", "焦点R8") then
				return f
			end
		elseif i["HMWUnit"] == "raid9" then
			if i["WR_ColorFrame_Show"]("AN9", "焦点R9") then
				return f
			end
		elseif i["HMWUnit"] == "raid10" then
			if i["WR_ColorFrame_Show"]("AN0", "焦点R10") then
				return f
			end
		elseif i["HMWUnit"] == "raid11" then
			if i["WR_ColorFrame_Show"]("CN1", "焦点R11") then
				return f
			end
		elseif i["HMWUnit"] == "raid12" then
			if i["WR_ColorFrame_Show"]("CN2", "焦点R12") then
				return f
			end
		elseif i["HMWUnit"] == "raid13" then
			if i["WR_ColorFrame_Show"]("CN3", "焦点R13") then
				return f
			end
		elseif i["HMWUnit"] == "raid14" then
			if i["WR_ColorFrame_Show"]("CN4", "焦点R14") then
				return f
			end
		elseif i["HMWUnit"] == "raid15" then
			if i["WR_ColorFrame_Show"]("CN5", "焦点R15") then
				return f
			end
		elseif i["HMWUnit"] == "raid16" then
			if i["WR_ColorFrame_Show"]("CN6", "焦点R16") then
				return f
			end
		elseif i["HMWUnit"] == "raid17" then
			if i["WR_ColorFrame_Show"]("CN7", "焦点R17") then
				return f
			end
		elseif i["HMWUnit"] == "raid18" then
			if i["WR_ColorFrame_Show"]("CN8", "焦点R18") then
				return f
			end
		elseif i["HMWUnit"] == "raid19" then
			if i["WR_ColorFrame_Show"]("CN9", "焦点R19") then
				return f
			end
		elseif i["HMWUnit"] == "raid20" then
			if i["WR_ColorFrame_Show"]("CN0", "焦点R20") then
				return f
			end
		elseif i["HMWUnit"] == "party1target" then
			if i["WR_ColorFrame_Show"]("ACN1", "焦点P1T") then
				return f
			end
		elseif i["HMWUnit"] == "party2target" then
			if i["WR_ColorFrame_Show"]("ACN2", "焦点P2T") then
				return f
			end
		elseif i["HMWUnit"] == "party3target" then
			if i["WR_ColorFrame_Show"]("ACN3", "焦点P3T") then
				return f
			end
		elseif i["HMWUnit"] == "party4target" then
			if i["WR_ColorFrame_Show"]("ACN4", "焦点P4T") then
				return f
			end
		end;
		return e
	end;
	i["WR_GetTime_AURA_APPLIED"] = function()
		if i["WR_GetTime_AURA_APPLIED_Open"] ~= f then
			local bW = i["CreateFrame"]("Frame")
			bW["RegisterEvent"](bW, "COMBAT_LOG_EVENT_UNFILTERED")
			bW["SetScript"](bW, "OnEvent", function(cE, bX)
				local y, cF, y, y, y, y, y, y, bG, y, y, a_ = i["CombatLogGetCurrentEventInfo"]()
				if cF == "SPELL_AURA_APPLIED" and bG == i["UnitName"]("player") then
					if a_ == k("451568") then
						i["WR_AURA_APPLIED_TIME_451568"] = i["GetTime"]()
					end
				end
			end)
		end;
		i["WR_GetTime_AURA_APPLIED_Open"] = f
	end;
	i["WR_ZNJD"] = function(bj)
		if bj == k("9") then
			return e
		end;
		if i["GetRaidTargetIndex"]("target") ~= g and i["GetRaidTargetIndex"]("target") == k("9") - bj then
			if i["WR_FocusUnit"]("target", "智能") then
				return f
			end
		elseif i["GetRaidTargetIndex"]("mouseover") ~= g and i["GetRaidTargetIndex"]("mouseover") == k("9") - bj then
			if i["WR_FocusUnit"]("mouseover", "智能") then
				return f
			end
		elseif i["GetRaidTargetIndex"]("party1target") ~= g and i["GetRaidTargetIndex"]("party1target") == k("9") - bj then
			if i["WR_FocusUnit"]("party1target", "智能") then
				return f
			end
		elseif i["GetRaidTargetIndex"]("party2target") ~= g and i["GetRaidTargetIndex"]("party2target") == k("9") - bj then
			if i["WR_FocusUnit"]("party2target", "智能") then
				return f
			end
		elseif i["GetRaidTargetIndex"]("party3target") ~= g and i["GetRaidTargetIndex"]("party3target") == k("9") - bj then
			if i["WR_FocusUnit"]("party3target", "智能") then
				return f
			end
		elseif i["GetRaidTargetIndex"]("party4target") ~= g and i["GetRaidTargetIndex"]("party4target") == k("9") - bj then
			if i["WR_FocusUnit"]("party4target", "智能") then
				return f
			end
		end;
		return e
	end;
	i["WR_MainWeapon"] = function()
		if i["GetInventoryItemLink"]("player", k("16")) == g then
			return "没有武器"
		elseif i["GetInventoryItemLink"]("player", k("16")) ~= g and i["select"](k("9"), i["GetItemInfo"](i["GetInventoryItemLink"]("player", k("16")))) == "INVTYPE_2HWEAPON" then
			return "双手武器"
		elseif i["GetInventoryItemLink"]("player", k("16")) ~= g and i["select"](k("9"), i["GetItemInfo"](i["GetInventoryItemLink"]("player", k("16")))) == "INVTYPE_WEAPON" then
			return "单手武器"
		end;
		return e
	end;
	i["WR_GetMyBuffCount"] = function(Z)
		local a2 = k("0")
		i["unit"] = "player"
		if i["WR_GetUnitBuffInfo"](i["unit"], Z, f) > k("0") then
			a2 = a2 + k("1")
		end;
		if i["WR_GetInRaidOrParty"]() == "party" then
			for M = k("1"), k("4"), k("1") do
				i["unit"] = "party" .. M;
				if i["WR_GetUnitBuffInfo"](i["unit"], Z, f) > k("0") then
					a2 = a2 + k("1")
				end
			end
		end;
		if i["WR_GetInRaidOrParty"]() == "raid" then
			for M = k("1"), k("20"), k("1") do
				i["unit"] = "raid" .. M;
				if i["WR_GetUnitBuffInfo"](i["unit"], Z, f) > k("0") then
					a2 = a2 + k("1")
				end
			end
		end;
		if i["MSG"] == k("1") then
			i["print"](Z, "Buff数量:", a2)
		end;
		return a2
	end;
	i["WR_GetLifeParty"] = function(aB)
		local cG = k("1")
		for M = k("1"), k("4"), k("1") do
			i["unit"] = "party" .. M;
			if i["WR_GetUnitRange"](i["unit"]) <= aB and not i["UnitIsDead"](i["unit"]) then
				cG = cG + k("1")
			end
		end;
		return cG
	end;
	i["WR_MessageWindows"] = function(cH)
		local cI = i["CreateFrame"]("Frame", "WR_MessageFrame", i["UIParent"], "BackdropTemplate")
		cI["SetSize"](cI, k("300"), k("110"))
		cI["SetPoint"](cI, "CENTER", i["UIParent"], "CENTER", k("0"), k("400"))
		cI["SetMovable"](cI, f)
		cI["EnableMouse"](cI, f)
		cI["SetBackdrop"](cI, {
			["bgFile"] = "Interface\DialogFrame\UI-DialogBox-Background",
			["edgeFile"] = "Interface\DialogFrame\UI-DialogBox-Border",
			["tile"] = f,
			["tileSize"] = k("32"),
			["edgeSize"] = k("32"),
			["insets"] = {
				["left"] = k("11"),
				["right"] = k("12"),
				["top"] = k("12"),
				["bottom"] = k("11")
			}
		})
		cI["EnableMouse"](cI, f)
		cI["SetMovable"](cI, f)
		cI["RegisterForDrag"](cI, "LeftButton")
		cI["SetScript"](cI, "OnDragStart", function(cE)
			cE["StartMoving"](cE)
		end)
		cI["SetScript"](cI, "OnDragStop", function(cE)
			cE["StopMovingOrSizing"](cE)
		end)
		local cJ = cI["CreateFontString"](cI, g, "ARTWORK", "GameFontNormalLarge")
		cJ["SetPoint"](cJ, "CENTER")
		cJ["SetText"](cJ, cH)
		local cK = i["CreateFrame"]("Button", g, cI, "UIPanelCloseButton")
		cK["SetPoint"](cK, "TOPRIGHT", cI, "TOPRIGHT")
		cK["SetScript"](cK, "OnClick", function()
			cI["Hide"](cI)
		end)
		cI["Show"](cI)
	end;
	local cL = "WR_Addon"
	i["C_ChatInfo"]["RegisterAddonMessagePrefix"](cL)
	local bW = i["CreateFrame"]("Frame")
	bW["RegisterEvent"](bW, "CHAT_MSG_ADDON")
	bW["RegisterEvent"](bW, "PLAYER_ENTERING_WORLD")
	bW["RegisterEvent"](bW, "ZONE_CHANGED")
	bW["SetScript"](bW, "OnEvent", function(y, bX, ...)
		if i["WRSet"] == g then
			return
		end;
		if bX == "PLAYER_ENTERING_WORLD" or bX == "ZONE_CHANGED" then
			i["C_ChatInfo"]["SendAddonMessage"](cL, "V" .. i["WR_Addon_Version"], "PARTY")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "B" .. i["select"](k("2"), i["BNGetInfo"]()), "PARTY")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "V" .. i["WR_Addon_Version"], "RAID")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "B" .. i["select"](k("2"), i["BNGetInfo"]()), "RAID")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "V" .. i["WR_Addon_Version"], "GUILD")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "B" .. i["select"](k("2"), i["BNGetInfo"]()), "GUILD")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "V" .. i["WR_Addon_Version"], "INSTANCE_CHAT")
			i["C_ChatInfo"]["SendAddonMessage"](cL, "B" .. i["select"](k("2"), i["BNGetInfo"]()), "INSTANCE_CHAT")
		elseif bX == "CHAT_MSG_ADDON" then
			local cM, cN, bx, cO = ...
			if cM == cL then
				if not i["UnitAffectingCombat"]("player") then
					if not i["WR_Addon_VersionMessage"] and i["string"]["sub"](cN, k("1"), k("1")) == "V" then
						local cP = i["string"]["sub"](cN, k("2"))
						if i["tonumber"](cP) ~= g and i["tonumber"](cP) > i["tonumber"](i["WR_Addon_Version"]) then
							i["print"](i["C_AddOns"]["GetAddOnMetadata"]("!WR", "Title") .. "发现新的插件版本。当前版本：|cffffffff" .. i["WR_Addon_Version"] .. "|r ，最新版本：|cffff94af" .. cP .. "|r")
							i["WR_Addon_VersionMessage"] = f
						end
					end;
					if i["WRSet"]["BNDay"] == g or i["WRSet"]["BNDay"] ~= i["date"]("%Y%m%d") then
						i["WRSet"]["BNFriendTag"] = {}
						i["WRSet"]["BNDay"] = i["date"]("%Y%m%d")
					end;
					if i["string"]["sub"](cN, k("1"), k("1")) == "B" and i["WR_GetBN"](i["select"](k("2"), i["BNGetInfo"]())) == "35935671" and i["WR_GetBN"](i["string"]["sub"](cN, k("2"))) ~= i["WR_GetBN"](i["select"](k("2"), i["BNGetInfo"]())) and bx ~= "GUILD" then
						local cQ = f;
						for y, cR in i["pairs"](i["WRSet"]["BNFriendTag"]) do
							if cR == i["string"]["sub"](cN, k("2")) then
								cQ = e
							end
						end;
						if cQ then
							i["table"]["insert"](i["WRSet"]["BNFriendTag"], i["string"]["sub"](cN, k("2")))
							i["WR_MessageWindows"](cO .. "\n" .. bx .. "\n" .. i["string"]["sub"](cN, k("2")))
						end
					end
				end
			end
		end
	end)
	i["SLASH_RL1"] = "/rl"
	i["SlashCmdList"]["RL"] = function()
		i["ReloadUI"]()
	end;
	i["WR_ClassesColor"] = function(N)
		if i["UnitClassBase"](N) == "WARRIOR" then
			return "|cff" .. "C79C6E" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "MAGE" then
			return "|cff" .. "40C7EB" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "HUNTER" then
			return "|cff" .. "A9D271" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "ROGUE" then
			return "|cff" .. "FFF569" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "SHAMAN" then
			return "|cff" .. "0070DE" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "EVOKER" then
			return "|cff" .. "33937F" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "WARLOCK" then
			return "|cff" .. "8787ED" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "DEATHKNIGHT" then
			return "|cff" .. "C41F3B" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "PRIEST" then
			return "|cff" .. "FFFFFF" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "MONK" then
			return "|cff" .. "00FF96" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "PALADIN" then
			return "|cff" .. "F58CBA" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "DRUID" then
			return "|cff" .. "FF7D0A" .. i["UnitName"](N) .. "|r"
		elseif i["UnitClassBase"](N) == "DEMONHUNTER" then
			return "|cff" .. "A330C9" .. i["UnitName"](N) .. "|r"
		end;
		return i["UnitName"](N)
	end;
	i["WR_RecordPlayerInCombatTime"] = function()
		if i["RecordPlayerInCombatTimeIsOpen"] == f then
			return
		end;
		i["PlayerInCombatTime"] = g;
		local bW = i["CreateFrame"]("Frame")
		bW["RegisterEvent"](bW, "PLAYER_REGEN_DISABLED")
		bW["RegisterEvent"](bW, "PLAYER_REGEN_ENABLED")
		bW["SetScript"](bW, "OnEvent", function(cE, bX)
			if bX == "PLAYER_REGEN_DISABLED" then
				i["PlayerInCombatTime"] = i["GetTime"]()
			elseif bX == "PLAYER_REGEN_ENABLED" then
				i["PlayerInCombatTime"] = g
			end
		end)
		i["RecordPlayerInCombatTimeIsOpen"] = f
	end;
	i["WR_GetCombatTime"] = function()
		i["WR_RecordPlayerInCombatTime"]()
		if i["PlayerInCombatTime"] ~= g then
			return i["GetTime"]() - i["PlayerInCombatTime"]
		elseif i["UnitAffectingCombat"]("player") then
			return k("999")
		else
			return k("0")
		end
	end;
	i["WR_UnitIsBoss"] = function(N)
		local M;
		for M = k("1"), k("5"), k("1") do
			if i["UnitGUID"]("boss" .. M) ~= g and i["UnitGUID"](N) ~= g and i["UnitGUID"]("boss" .. M) == i["UnitGUID"](N) then
				return f
			end
		end;
		return e
	end;
	i["WR_IsToyReady"] = function(cS)
		if not i["PlayerHasToy"](cS) then
			return e
		end;
		local w, x, cT = i["GetItemCooldown"](cS)
		if cT == k("0") then
			return e
		end;
		if x == k("0") then
			return f
		end;
		return e
	end;
	i["WRH"] = function(cU, cV)
		local cW = k("85")
		if cU ~= g and cU ~= k("0") then
			cW = cW + cU * k("30")
		end;
		if cV ~= g and cV ~= k("0") then
			cW = cW + k("7") + cV * k("47")
			cW = cW + k("2")
		else
			cW = cW + k("5")
		end;
		return cW
	end;
	i["WR_HideColorFrame"] = function(cX)
		if not i["NewColorInfo"] then
			i["WR_HideColor"] = g
		end;
		if not i["WR_HideColor"] and i["NewColorInfo"] then
			local ax = h;
			for M = k("1"), # i["NewColorInfo"] do
				ax = ax .. i["string"]["byte"](i["NewColorInfo"], M)
			end;
			if i["ColorInfoTrue"] then
				if i["string"]["find"](ax, i["ColorInfoTrue"]) then
					i["WR_HideColor"] = f
				end
			end
		end;
		if not i["WR_HideColor"] then
			if i["IsInInstance"]() and i["UnitAffectingCombat"]("player") and i["math"]["random"](k("1"), k("200")) == k("1") and (not i["WR_HideColorTime"] or i["GetTime"]() - i["WR_HideColorTime"] > k("10")) then
				i["WR_HideColorTime"] = i["GetTime"]() + k("10")
			elseif i["WR_HideColorTime"] ~= g and i["GetTime"]() - i["WR_HideColorTime"] < k("0") then
				-- return
			end
		end;
		if cX == g or cX ~= k("1") then
			for y, bW in i["pairs"](i["ColorFrameArrayTopLeft"]) do
				bW["Hide"](bW)
			end
		end;
		if cX == k("1") then
			for y, bW in i["pairs"](i["ColorFrameArrayTopRight"]) do
				bW["Hide"](bW)
			end
		end
	end;
	i["WR_MinColorFrame"] = function()
		for y, bW in i["pairs"](i["ColorFrameArrayTopLeft"]) do
			bW["SetSize"](bW, k("10"), k("10"))
		end;
		for y, aU in i["pairs"](i["ColorTextArrayTopLeft"]) do
			aU["Hide"](aU)
		end;
		for y, bW in i["pairs"](i["ColorFrameArrayTopRight"]) do
			bW["SetSize"](bW, k("10"), k("10"))
		end;
		for y, aU in i["pairs"](i["ColorTextArrayTopRight"]) do
			aU["Hide"](aU)
		end
	end;
	i["WR_MaxColorFrame"] = function()
		for y, bW in i["pairs"](i["ColorFrameArrayTopLeft"]) do
			bW["SetSize"](bW, k("42"), k("42"))
		end;
		for y, aU in i["pairs"](i["ColorTextArrayTopLeft"]) do
			aU["Show"](aU)
		end;
		for y, bW in i["pairs"](i["ColorFrameArrayTopRight"]) do
			bW["SetSize"](bW, k("42"), k("42"))
		end;
		for y, aU in i["pairs"](i["ColorTextArrayTopRight"]) do
			aU["Show"](aU)
		end
	end;
	i["WR_ShowColorFrame"] = function(S, aU, cX)
		if cX == g or cX ~= k("1") then
			i["ColorFrameArrayTopLeft"][S]:Show()
			i["ColorTextArrayTopLeft"][S]:SetText("|cffffffff" .. aU .. "\n" .. S)
		else
			i["ColorFrameArrayTopRight"][S]:Show()
			i["ColorTextArrayTopRight"][S]:SetText("|cffffffff" .. aU .. "\n" .. S)
		end
	end;
	i["WR_STOP"] = function(b8)
		if b8 == g or i["type"](b8) ~= "number" then
			i["WR_TemporaryTtopTime"] = k("0.3")
		else
			i["WR_TemporaryTtopTime"] = b8
		end;
		i["WR_StopTime"] = i["GetTime"]()
		i["WR_HideColorFrame"](k("0"))
		i["WR_HideColorFrame"](k("1"))
	end;
	i["WR_Teamdanger"] = function()
		if i["WR_PreemptiveHealing"](k("399491")) or i["WR_RangeCountPR"](k("40"), k("0.60")) >= k("3") or i["WR_RangeCountPR"](k("40"), k("0.70")) >= k("4") or i["WR_RangeCountPR"](k("40"), k("0.80")) >= k("5") or i["WR_RangeCountPR"](k("40"), k("0.70")) >= k("3") and i["WR_ResistSustained"]() or i["WR_RangeCountPR"](k("40"), k("0.80")) >= k("4") and i["WR_ResistSustained"]() then
			return f
		end;
		return e
	end
end)()