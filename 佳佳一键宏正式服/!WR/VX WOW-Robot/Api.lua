local a = 56;
local b = 25;
local c = 0 == 1;
local d = not c;
local e = nil;
local f = ""
local g = _G;
local h = _ENV;
local i = g["tonumber"]
return (function(...)
g["WRFindWRBN20250315"] = true
g["Welcome_XiaoManZS"] = true
g["DemonHunterPass"] = true

	if not g["IsSpellInRange"] then
		g["IsSpellInRange"] = g["C_Spell"]["IsSpellInRange"]
	end;
	if not g["GetSpellCount"] then
		g["GetSpellCount"] = g["C_Spell"]["GetSpellCastCount"]
	end;
	if not g["GetSpellLink"] then
		g["GetSpellLink"] = g["C_Spell"]["GetSpellLink"]
	end;
	if not g["IsUsableSpell"] then
		g["IsUsableSpell"] = g["C_Spell"]["IsSpellUsable"]
	end;
	if not g["GetSpellInfo"] then
		g["GetSpellInfo"] = function(j)
			if not j then
				return e
			end;
			local k = g["C_Spell"]["GetSpellInfo"](j)
			if k then
				return k["name"], e, k["iconID"], k["castTime"], k["minRange"], k["maxRange"], k["spellID"], k["originalIconID"]
			end
		end
	end;
	if not g["GetSpellCooldown"] then
		g["GetSpellCooldown"] = function(j)
			local l = g["C_Spell"]["GetSpellCooldown"](j)
			if l then
				return l["startTime"], l["duration"], l["isEnabled"], l["modRate"]
			end
		end
	end;
	g["PartyRange"] = {}
	g["RiadRange"] = {}
	g["PartyLostHealth"] = {}
	g["RiadLostHealth"] = {}
	g["PlayerLostHealth"] = i("0")
	g["WR_CreateMacroButton"] = function(m, n, o)
		g["MacroButton"] = g["CreateFrame"]("Button", m, g["UIParent"], "SecureActionButtonTemplate")
		g["MacroButton"]["RegisterForClicks"](g["MacroButton"], "AnyDown", "AnyUp")
		g["MacroButton"]["SetAttribute"](g["MacroButton"], "type", "macro")
		g["MacroButton"]["SetAttribute"](g["MacroButton"], "macrotext", o)
		g["SetBinding"](n, "CLICK " .. m .. ":LeftButton")
	end;
	g["WR_MyPower"] = function()
		if g["WR_GetInRaidOrParty"]() ~= "raid" then
			return
		end;
		local p = g["date"]("*t")
		local q = p["hour"]
		local r = p["min"]
		if g["MyGIDTime"] == e or g["GetTime"]() - g["MyGIDTime"] >= i("900") then
			if q == i("20") and r == i("0") then
				g["SendChatMessage"]("■■■■■■■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("20") and r == i("15") then
				g["SendChatMessage"]("□■■■■■■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("20") and r == i("30") then
				g["SendChatMessage"]("□□■■■■■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("20") and r == i("45") then
				g["SendChatMessage"]("□□□■■■■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("21") and r == i("0") then
				g["SendChatMessage"]("□□□□■■■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("21") and r == i("15") then
				g["SendChatMessage"]("□□□□□■■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("21") and r == i("30") then
				g["SendChatMessage"]("□□□□□□■■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("21") and r == i("45") then
				g["SendChatMessage"]("□□□□□□□■■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("22") and r == i("0") then
				g["SendChatMessage"]("□□□□□□□□■■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("22") and r == i("15") then
				g["SendChatMessage"]("□□□□□□□□□■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("22") and r == i("30") then
				g["SendChatMessage"]("□□□□□□□□□□■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("22") and r == i("45") then
				g["SendChatMessage"]("□□□□□□□□□□□■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("23") and r == i("00") then
				g["SendChatMessage"]("□□□□□□□□□□□□", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("23") and r == i("15") then
				g["SendChatMessage"]("□□□□□□□□□□□□ □■■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("23") and r == i("30") then
				g["SendChatMessage"]("□□□□□□□□□□□□ □□■■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("23") and r == i("45") then
				g["SendChatMessage"]("□□□□□□□□□□□□ □□□■", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			elseif q == i("00") and r == i("00") then
				g["SendChatMessage"]("□□□□□□□□□□□□ □□□□", "RAID")
				g["MyGIDTime"] = g["GetTime"]()
			end
		end
	end;
	g["WR_GetGCD"] = function(s)
		local t = i("0")
		if g["C_Spell"]["GetSpellCooldown"](s) then
			local u = g["C_Spell"]["GetSpellCooldown"](s)["startTime"]
			local v = g["C_Spell"]["GetSpellCooldown"](s)["duration"]
			if u + v > g["GetTime"]() then
				t = u + v - g["GetTime"]()
			end
		end;
		local w, w, w, w, x, w, w, w, w = g["UnitCastingInfo"]("player")
		if x ~= e and x / i("1000") - g["GetTime"]() > t then
			return x / i("1000") - g["GetTime"]()
		else
			return t
		end
	end;
	g["WR_SpellUsable"] = function(y)
		if g["WR_GetGCD"](y) <= g["GCD"] and g["C_Spell"]["IsSpellUsable"](y) then
			return d
		end;
		return c
	end;
	g["WR_GetMaxLatency"] = function()
		local z, A, B, C = g["GetNetStats"]()
		if B > C then
			return B / i("1000")
		else
			return C / i("1000")
		end
	end;
	g["WR_GetMaxGCD"] = function(D)
		return D / (i("1") + g["GetHaste"]() / i("100"))
	end;
	g["WR_GetSpellValue"] = function(s, E, F)
		local G = "([%d,%.]+)"
		if E ~= e then
			G = E .. G
		end;
		if F ~= e then
			G = G .. F
		end;
		local H = g["C_Spell"]["GetSpellDescription"](s)
		if H ~= e then
			H = H["match"](H, G)
		end;
		if H ~= e then
			H = H["gsub"](H, ",", f)
		end;
		if H ~= e then
			H = H["gsub"](H, " 万", "0000")
		end;
		if H ~= e then
			local I = g["tonumber"](H)
			if g["type"](I) == "number" then
				return I
			end
		end;
		local G = "([%d,%.]+ 万)"
		if E ~= e then
			G = E .. G
		end;
		if F ~= e then
			G = G .. F
		end;
		local H = g["C_Spell"]["GetSpellDescription"](s)
		if H ~= e then
			H = H["match"](H, G)
		end;
		if H ~= e then
			H = H["gsub"](H, ",", f)
		end;
		if H ~= e then
			H = H["gsub"](H, " 万", "0000")
		end;
		if H ~= e then
			local I = g["tonumber"](H)
			if g["type"](I) == "number" then
				return I
			end
		end;
		return i("0")
	end;
	g["WR_InTraining"] = function()
		for w, J in g["pairs"](g["TrainingName"]) do
			if g["UnitName"]("target") == J then
				return d
			end
		end;
		return c
	end;
	g["WR_PartyIsDeath"] = function()
		for K = i("1"), i("4"), i("1") do
			if g["UnitExists"]("party" .. K) and g["UnitIsDead"]("party" .. K) then
				return d
			end
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitExists"]("raid" .. K) and g["UnitIsDead"]("raid" .. K) then
				return d
			end
		end;
		return c
	end;
	g["WR_Unbind"] = function(L)
		if g["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return c
		end;
		if g["UnitClassBase"]("player") == "DRUID" then
			if g["WR_GetUnitDebuffTime"](L, "晦幽纺纱") > i("0") and g["WR_GetUnitDebuffTime"](L, "晦幽纺纱") < i("11") then
				return c
			end;
			if g["WR_GetUnitDebuffTime"](L, "钉伤") > i("0") and g["WR_GetUnitDebuffTime"](L, "钉伤") < i("1.9") then
				return c
			end
		end;
		if g["WR_GetUnitDebuffCount"](L, "恐瓣花粉") >= i("6") then
			return d
		end;
		if g["WR_GetUnitDebuffTime"](L, g["BindName"]) > i("0") then
			return d
		end;
		return c
	end;
	g["WR_YuFangDingShen"] = function(L)
		if g["WR_GetRangeSpellTime"](i("40"), g["YuFangDingShenSpell"]) < i("2") then
			return d
		end;
		if L == e or L == "player" then
			if g["WR_GetRangeSpellTime"](i("40"), g["YuFangDingShenSpellToUnit"], "player") < i("2") then
				return d
			end
		else
			if g["WR_GetRangeSpellTime"](i("40"), g["YuFangDingShenSpellToUnit"], L) < i("2") then
				return d
			end
		end;
		return c
	end;
	g["WR_UnitAssistDebuff"] = function(L)
		return g["WR_GetUnitDebuffTime"](L, g["AssistDebuffName"]) > i("0") or g["WR_GetUnitDebuffTime"](L, g["DangerDebuff"]) > i("0")
	end;
	g["WR_Mustheal"] = function(L)
		local M = i("1")
		if g["WR_GetUnitDebuffTime"](L, g["MustHealSpellName"]) > i("0") or g["WR_UnitAssistDebuff"](L) then
			if g["UnitHealth"](L) / g["UnitHealthMax"](L) < i("0.9") then
				return d
			end
		end;
		local N, w = g["UnitName"](L)
		if N == "卡多雷精魂" or N == "焦化树人" then
			if g["UnitHealth"](L) / g["UnitHealthMax"](L) < i("0.9") then
				return d
			end
		end;
		return c
	end;
	g["WR_GetUnitBuffType"] = function(L, O)
		local K;
		for K = i("1"), i("255"), i("1") do
			local P = g["C_UnitAuras"]["GetAuraDataByIndex"](L, K, "HELPFUL")
			if P == e then
				break
			end;
			local Q = P["name"]
			local R = P["applications"]
			local S = P["dispelName"]
			if Q == e then
				break
			end;
			if Q == "无穷饥渴" and R < i("6") then
				return c
			end;
			if Q == "窃取时间" then
				return c
			end;
			if S == O then
				return d
			end
		end;
		return c
	end;
	g["WR_UnitDebuffType"] = function(L, T)
		local K;
		for K = i("1"), i("255"), i("1") do
			local U = d;
			local V = g["C_UnitAuras"]["GetAuraDataByIndex"](L, K, "HARMFUL")
			if V == e then
				break
			end;
			local Q = V["name"]
			local R = V["applications"]
			local S = V["dispelName"]
			local W = V["expirationTime"]
			if Q == e then
				break
			end;
			if Q == "虚空裂隙" then
				return d, i("1")
			end;
			if Q == "烈焰撕咬" and g["WR_RangeCountPR"](i("40"), i("0.70")) >= i("1") then
				U = c
			end;
			if Q == "灵魂毒液" and R < i("7") then
				U = c
			end;
			if (Q == "爆裂" or Q == "巨口蛙毒" or Q == "腐蚀波" or Q == "蜂毒") and R < i("5") then
				U = c
			end;
			if Q == "窃取时间" and R < i("3") then
				U = c
			end;
			if Q == "腐败之血" and R < i("2") then
				U = c
			end;
			if Q == "时光爆发" and (W - g["GetTime"]() > i("4.5") or g["WR_GetUnitHP"](L) < i("0.8")) then
				U = c
			end;
			if Q == "古怪生长" and W - g["GetTime"]() > i("4") then
				U = c
			end;
			if Q == "提尔之火" and (W - g["GetTime"]() > i("16") or g["WR_GetUnitHP"](L) < i("0.8") or g["UnitCastingInfo"]("boss1") == "裂地打击") then
				U = c
			end;
			if Q == "震地回响" and g["WR_GetRangeSpellTime"](i("45"), "震地猛击") >= i("3") then
				U = c
			end;
			if Q == "冰冻" then
				U = c
			end;
			if S == T and U == d then
				return d, R
			end
		end;
		return c
	end;
	g["WR_GetUnitBuffInfo"] = function(L, X, Y, Z)
		local _ = i("0")
		local a0 = i("0")
		local a1 = i("0")
		for K = i("1"), i("255"), i("1") do
			local P = g["C_UnitAuras"]["GetAuraDataByIndex"](L, K, "HELPFUL")
			if P == e then
				break
			end;
			if P then
				if Y ~= d or Y == d and P["sourceUnit"] == "player" then
					if g["type"](X) == "table" then
						for a2, a3 in g["pairs"](X) do
							if Z == e and (P["name"] == a3 or P["spellId"] == a2) or Z == "NAME" and P["name"] == a3 or Z == "ID" and P["spellId"] == a2 then
								if P["expirationTime"] > g["GetTime"]() then
									_ = P["expirationTime"] - g["GetTime"]()
								else
									_ = i("999")
								end;
								if P["applications"] > i("0") then
									a0 = P["applications"]
								else
									a0 = i("1")
								end;
								a1 = a1 + i("1")
							end
						end
					else
						if P["name"] == X or P["spellId"] == X then
							if P["expirationTime"] > g["GetTime"]() then
								_ = P["expirationTime"] - g["GetTime"]()
							else
								_ = i("999")
							end;
							if P["applications"] > i("0") then
								a0 = P["applications"]
							else
								a0 = i("1")
							end;
							a1 = a1 + i("1")
						end
					end
				end
			else
			end
		end;
		return _, a0, a1
	end;
	g["WR_GetUnitDebuffInfo"] = function(L, a4, Y, Z)
		local a5 = i("0")
		local a6 = i("0")
		for K = i("1"), i("255"), i("1") do
			local V = g["C_UnitAuras"]["GetAuraDataByIndex"](L, K, "HARMFUL")
			if V == e then
				break
			end;
			if V then
				if Y ~= d or Y == d and V["sourceUnit"] == "player" then
					if g["type"](a4) == "table" then
						for a7, a8 in g["pairs"](a4) do
							if Z == e and (V["name"] == a8 or V["spellId"] == a7) or Z == "NAME" and V["name"] == a8 or Z == "ID" and V["spellId"] == a7 then
								if V["expirationTime"] > g["GetTime"]() then
									a5 = V["expirationTime"] - g["GetTime"]()
								else
									a5 = i("999")
								end;
								if V["applications"] > i("0") then
									a6 = V["applications"]
								else
									a6 = i("1")
								end;
								return a5, a6
							end
						end
					else
						if V["name"] == a4 or V["spellId"] == a4 then
							if V["expirationTime"] > g["GetTime"]() then
								a5 = V["expirationTime"] - g["GetTime"]()
							else
								a5 = i("999")
							end;
							if V["applications"] > i("0") then
								a6 = V["applications"]
							else
								a6 = i("1")
							end;
							return a5, a6
						end
					end
				end
			else
				return a5, a6
			end
		end;
		return a5, a6
	end;
	g["WR_GetUnitBuffTime"] = function(L, X, Y, Z)
		return g["select"](i("1"), g["WR_GetUnitBuffInfo"](L, X, Y, Z))
	end;
	g["WR_GetUnitBuffCount"] = function(L, X, Y, Z)
		return g["select"](i("2"), g["WR_GetUnitBuffInfo"](L, X, Y, Z))
	end;
	g["WR_GetUnitBuffSum"] = function(L, X, Y, Z)
		return g["select"](i("3"), g["WR_GetUnitBuffInfo"](L, X, Y, Z))
	end;
	g["WR_GetUnitDebuffTime"] = function(L, a4, Y, Z)
		return g["select"](i("1"), g["WR_GetUnitDebuffInfo"](L, a4, Y, Z))
	end;
	g["WR_GetUnitDebuffCount"] = function(L, a4, Y, Z)
		return g["select"](i("2"), g["WR_GetUnitDebuffInfo"](L, a4, Y, Z))
	end;
	g["WR_GetHealthMaxWeightUnit"] = function()
		local a9 = {
			[i("1")] = "圣光道标",
			[i("2")] = "美德道标",
			[i("3")] = "信仰道标",
			[i("4")] = "复苏之雾",
			[i("5")] = "愈合祷言",
			[i("6")] = "恢复",
			[i("7")] = "圣光回响",
			[i("8")] = i("102352"),
			[i("9")] = "生命绽放",
			[i("10")] = "野性成长",
			[i("11")] = "愈合",
			[i("12")] = "回春术",
			[i("13")] = "林地护理",
			[i("14")] = "激变蜂群",
			[i("15")] = "栽培",
			[i("16")] = "春暖花开"
		}
		local s = "Nothing"
		local aa = c;
		local ab = c;
		local ac = c;
		local ad = c;
		if g["IsPlayerSpell"](i("527")) == d then
			s = "纯净术"
			aa = d
		end;
		if g["IsPlayerSpell"](i("77130")) == d then
			s = "净化灵魂"
			aa = d
		end;
		if g["IsPlayerSpell"](i("4987")) == d then
			s = "清洁术"
			aa = d
		end;
		if g["IsPlayerSpell"](i("115450")) == d then
			s = "清创生血"
			aa = d
		end;
		if g["IsPlayerSpell"](i("88423")) == d then
			s = "自然之愈"
			aa = d
		end;
		if g["IsPlayerSpell"](i("390632")) == d then
			ac = d
		end;
		if g["IsPlayerSpell"](i("383016")) == d then
			ab = d
		end;
		if g["IsPlayerSpell"](i("393024")) == d then
			ad = d;
			ac = d
		end;
		if g["IsPlayerSpell"](i("388874")) == d then
			ad = d;
			ac = d
		end;
		if g["IsPlayerSpell"](i("392378")) == d then
			ad = d;
			ac = d
		end;
		if s == "Nothing" then
			return "Nothing"
		else
			if g["HealthMaxWeightUnitload"] ~= d then
				local ae = "本职业驱散法术为: |cff0cbd0c" .. s .. "|cffffffff，当前天赋可驱散: "
				if aa == d then
					ae = ae .. "|cff00adf0魔法 "
				end;
				if ab == d then
					ae = ae .. "|cffffdf00诅咒 "
				end;
				if ac == d then
					ae = ae .. "|cffff5040疾病 "
				end;
				if ad == d then
					ae = ae .. "|cff0cbd0c中毒 "
				end;
				g["HealthMaxWeightUnitload"] = d
			end
		end;
		local af, ag;
		local ah = i("0")
		local ai = i("0")
		local aj = {}
		local ak = "Nothing"
		local al = - i("999")
		local am;
		for K = i("1"), i("4"), i("1") do
			aj[K] = i("0")
		end;
		local an = {}
		for K = i("1"), i("40"), i("1") do
			an[K] = i("0")
		end;
		g["QSCooldown"] = g["WR_GetGCD"](s)
		for K = i("2"), i("5"), i("1") do
			local ao = i("0")
			local ap = "boss" .. K;
			if g["UnitExists"](ap) == d and (g["UnitName"](ap) == "克罗米" or g["UnitName"](ap) == "焦化树人" or g["UnitName"](ap) == "焦灼刺藤") then
				ao = (g["UnitHealthMax"](ap) - g["UnitHealth"](ap)) / g["UnitHealthMax"](ap) * i("100")
			end;
			if ao ~= i("0") and al < ao then
				al = ao;
				ak = ap
			end
		end;
		local aq = i("0")
		if g["UnitExists"]("mouseover") == d and (g["UnitName"]("mouseover") == "克罗米" or g["UnitName"]("mouseover") == "卡多雷精魂") then
			aq = (g["UnitHealthMax"]("mouseover") - g["UnitHealth"]("mouseover")) / g["UnitHealthMax"]("mouseover") * i("100")
		end;
		if aq ~= i("0") and al < aq then
			al = aq;
			ak = "mouseover"
		end;
		if g["WR_GetInRaidOrParty"]() ~= "raid" then
			am = "player"
			if g["UnitExists"](am) == d and g["UnitIsDead"](am) == c and g["UnitIsCharmed"](am) == c and g["UnitIsFriend"](am, am) == d and g["WR_GetUnitRange"](am) <= i("46") then
				ai = (g["UnitHealth"](am) + g["UnitGetIncomingHeals"](am) + g["UnitGetTotalAbsorbs"](am) - g["UnitGetTotalHealAbsorbs"](am) / i("1.5")) / g["UnitHealthMax"](am) * i("100")
				if ai > i("100") then
					ai = i("100")
				end;
				ai = i("100") - ai;
				if ai == i("0") and g["UnitGetTotalAbsorbs"](am) > i("0") then
					ai = ai - i("5")
				end;
				local ar = (g["UnitHealth"](am) + g["UnitGetIncomingHeals"](am) - g["UnitGetTotalHealAbsorbs"](am)) / g["UnitHealthMax"](am)
				if ar < i("0.70") then
					ai = ai + (i("70") - ar * i("100")) / i("2")
				end;
				if g["UnitClassBase"]("player") == "PRIEST" and g["GetSpecialization"]() == i("1") then
					if g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](am, "救赎", d) > i("0") then
						ai = ai - i("20")
					elseif not g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](am, "恢复", d) > i("0") then
						ai = ai - i("20")
					end
				end;
				if g["WR_Mustheal"](am) then
					ai = ai + i("60")
				end;
				if g["WR_GetUnitBuffTime"](am, a9, d) > i("0") then
					ai = ai - i("10")
				end;
				if g["UnitClassBase"]("player") == "MONK" and g["WR_GetUnitBuffTime"](am, "抚慰之雾", d) > i("0") and ar < i("0.9") then
					ai = ai + i("30")
				end;
				ai = g["math"]["ceil"](ai)
				if al < ai then
					al = ai;
					ak = "player"
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "party" then
			for K = i("1"), i("4"), i("1") do
				am = "party" .. K;
				if g["UnitExists"](am) == d and g["UnitIsDead"](am) == c and g["UnitIsCharmed"](am) == c and g["UnitIsFriend"](am, am) == d and (g["WR_GetUnitRange"](am) <= i("46") or g["WR_GetUnitBuffTime"]("player", "救赎之魂") > g["GCD"] and g["WR_GetUnitRange"](am) <= i("69")) then
					aj[K] = (g["UnitHealth"](am) + (g["UnitGetIncomingHeals"](am) or i("0")) + g["UnitGetTotalAbsorbs"](am) / i("2") - g["UnitGetTotalHealAbsorbs"](am) / i("1.5")) / g["UnitHealthMax"](am) * i("100")
					if aj[K] > i("100") then
						aj[K] = i("100")
					end;
					aj[K] = i("100") - aj[K]
					if aj[K] == i("0") and g["UnitGetTotalAbsorbs"](am) > i("0") then
						aj[K] = aj[K] - i("5")
					end;
					if g["UnitGroupRolesAssigned"](am) == "TANK" then
						if not g["UnitAffectingCombat"](am) then
							aj[K] = aj[K] + i("5")
						end;
						if g["UnitName"]("boss1") == "不屈者卡金" then
							aj[K] = aj[K] - i("50")
						end
					end;
					local as = (g["UnitHealth"](am) + (g["UnitGetIncomingHeals"](am) or i("0")) - g["UnitGetTotalHealAbsorbs"](am)) / g["UnitHealthMax"](am)
					local at = d;
					if g["UnitClass"]("player") == "牧师" and g["GetSpecialization"]() == i("1") then
						if g["WR_GetUnitBuffTime"](am, "救赎", d) == i("0") then
							at = c
						end
					end;
					if at and g["UnitGroupRolesAssigned"](am) == "TANK" and g["UnitAffectingCombat"](am) then
						if g["classFilename"] == "DEATHKNIGHT" then
							if g["UnitPower"](am) >= i("40") then
								aj[K] = aj[K] - i("40")
							else
								aj[K] = aj[K] - i("20")
							end
						end;
						if as > i("0.4") then
							if g["classFilename"] == "PALADIN" then
								aj[K] = aj[K] - i("20")
							end;
							if g["classFilename"] == "DEMONHUNTER" then
								aj[K] = aj[K] - i("20")
							end;
							if g["classFilename"] == "DRUID" then
								aj[K] = aj[K] - i("20")
							end
						end
					end;
					if g["UnitClassBase"]("player") == "PRIEST" and g["GetSpecialization"]() == i("1") then
						if g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](am, "救赎", d) > i("0") then
							aj[K] = aj[K] - i("20")
						elseif not g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](am, "恢复", d) > i("0") then
							aj[K] = aj[K] - i("20")
						end
					end;
					if g["UnitClassBase"]("player") == "PALADIN" and g["WR_GetUnitBuffTime"](am, "圣光闪烁", d) > i("0") then
						aj[K] = aj[K] - i("20")
					end;
					if g["WR_Mustheal"](am) then
						aj[K] = aj[K] + i("50")
					end;
					if g["WR_GetUnitBuffTime"](am, a9, d) > i("0") then
						aj[K] = aj[K] - i("10")
					end;
					if g["UnitClassBase"]("player") == "MONK" and g["UnitChannelInfo"]("player") == "抚慰之雾" and g["WR_GetUnitBuffTime"](am, "抚慰之雾", d) > i("0") and as < i("0.9") then
						aj[K] = aj[K] + i("30")
					end;
					aj[K] = g["math"]["ceil"](aj[K])
					if al < aj[K] then
						al = aj[K]
						ak = "party" .. K
					end
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "raid" then
			for K = i("1"), i("40"), i("1") do
				am = "raid" .. K;
				if g["UnitExists"](am) == d and g["UnitIsDead"](am) == c and g["UnitIsCharmed"](am) == c and g["UnitIsFriend"](am, am) == d and (g["WR_GetUnitRange"](am) <= i("46") or g["WR_GetUnitBuffTime"]("player", "救赎之魂") > g["GCD"] and g["WR_GetUnitRange"](am) <= i("69")) then
					an[K] = (g["UnitHealth"](am) + (g["UnitGetIncomingHeals"](am) or i("0")) + g["UnitGetTotalAbsorbs"](am) / i("2") - g["UnitGetTotalHealAbsorbs"](am) / i("1.5")) / g["UnitHealthMax"](am) * i("100")
					if an[K] > i("100") then
						an[K] = i("100")
					end;
					an[K] = i("100") - an[K]
					if an[K] == i("0") and g["UnitGetTotalAbsorbs"](am) > i("0") then
						an[K] = an[K] - i("5")
					end;
					if g["UnitGroupRolesAssigned"](am) == "TANK" and not g["UnitAffectingCombat"](am) then
						an[K] = an[K] + i("5")
					end;
					local au = (g["UnitHealth"](am) + (g["UnitGetIncomingHeals"](am) or i("0")) - g["UnitGetTotalHealAbsorbs"](am)) / g["UnitHealthMax"](am)
					if g["WR_GetUnitBuffTime"](am, a9, d) > i("0") then
						an[K] = an[K] - i("10")
					end;
					if g["UnitClassBase"]("player") == "MONK" and g["UnitChannelInfo"]("player") == "抚慰之雾" and g["WR_GetUnitBuffTime"](am, "抚慰之雾", d) > i("0") and au < i("0.9") then
						an[K] = an[K] + i("30")
					end;
					an[K] = g["math"]["ceil"](an[K])
					if al < an[K] then
						al = an[K]
						ak = "raid" .. K
					end
				end
			end
		end;
		if g["MSG"] == i("1") then
			g["print"]("--权重列表--")
			local av = "player:" .. ai .. "  "
			for K = i("1"), i("4"), i("1") do
				if g["UnitExists"]("party" .. K) == d then
					av = av .. "party" .. K .. ":" .. aj[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("1"), i("5"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("6"), i("10"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("11"), i("15"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("16"), i("20"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("21"), i("25"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("26"), i("30"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("31"), i("35"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			av = f;
			for K = i("36"), i("40"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					av = av .. "raid" .. K .. ":" .. an[K] .. "  "
				end
			end;
			if av ~= f then
				g["print"](av)
			end;
			g["print"]("最大权重单位:", ak, ":", al, f)
		end;
		return ak, al
	end;
	g["NPGUID"] = {}
	g["NPLevel"] = {}
	g["NPHP"] = {}
	g["NPMaxHealth"] = {}
	g["NPHealth"] = {}
	g["NPbegintime"] = {}
	g["NPdeathtime"] = {}
	g["WR_GetNPDeathTime"] = function()
		if g["LastTime_WR_GetNPDeathTime"] ~= e and g["GetTime"]() - g["LastTime_WR_GetNPDeathTime"] <= i("0.1") then
			return
		end;
		g["LastTime_WR_GetNPDeathTime"] = g["GetTime"]()
		for K = i("1"), i("40"), i("1") do
			if g["UnitGUID"]("nameplate" .. K) == e or g["UnitAffectingCombat"]("nameplate" .. K) == c or g["UnitHealth"]("nameplate" .. K) == g["UnitHealthMax"]("nameplate" .. K) then
				g["NPGUID"][K] = e;
				g["NPLevel"][K] = e;
				g["NPHP"][K] = e;
				g["NPMaxHealth"][K] = e;
				g["NPHealth"][K] = e;
				g["NPbegintime"][K] = e;
				g["NPdeathtime"][K] = i("999")
			else
				if g["UnitGUID"]("nameplate" .. K) ~= e then
					g["NPGUID"][K] = g["UnitGUID"]("nameplate" .. K)
				end;
				if g["UnitLevel"]("nameplate" .. K) ~= e and g["UnitLevel"]("nameplate" .. K) ~= i("0") then
					g["NPLevel"][K] = g["UnitLevel"]("nameplate" .. K)
				end;
				if g["NPLevel"][K] ~= e and g["NPLevel"][K] > i("0") then
					local aw = g["UnitClassification"]("nameplate" .. K)
					if aw == "normal" or aw == "trivial" or aw == "minus" then
						g["NPHP"][K] = i("0.9999")
					elseif g["UnitGUID"]("nameplate" .. K) == g["UnitGUID"]("boss1") or g["UnitGUID"]("nameplate" .. K) == g["UnitGUID"]("boss2") or g["UnitGUID"]("nameplate" .. K) == g["UnitGUID"]("boss3") or g["UnitGUID"]("nameplate" .. K) == g["UnitGUID"]("boss4") or g["UnitGUID"]("nameplate" .. K) == g["UnitGUID"]("boss5") then
						g["NPHP"][K] = i("0.9999")
					else
						g["NPHP"][K] = i("0.9999")
					end
				elseif g["NPLevel"][K] ~= e and g["NPLevel"][K] < i("0") then
					g["NPHP"][K] = i("0.9999")
				end;
				if g["UnitHealthMax"]("nameplate" .. K) ~= e then
					g["NPMaxHealth"][K] = g["UnitHealthMax"]("nameplate" .. K)
				end;
				if g["UnitHealthMax"]("nameplate" .. K) ~= e and g["NPHP"][K] ~= e and g["UnitHealth"]("nameplate" .. K) ~= e and g["UnitHealthMax"]("nameplate" .. K) * g["NPHP"][K] > g["UnitHealth"]("nameplate" .. K) then
					if g["NPbegintime"][K] == e then
						g["NPbegintime"][K] = g["GetTime"]()
					end;
					if g["NPHealth"][K] == e then
						g["NPHealth"][K] = g["UnitHealth"]("nameplate" .. K) + g["UnitGetTotalAbsorbs"]("nameplate" .. K)
					end
				end;
				local ax = g["UnitHealth"]("nameplate" .. K) + g["UnitGetTotalAbsorbs"]("nameplate" .. K)
				if g["NPGUID"][K] ~= e and g["NPbegintime"][K] ~= e and g["NPHealth"][K] ~= e and g["NPHealth"][K] > ax and g["NPbegintime"][K] < g["GetTime"]() then
					g["NPdeathtime"][K] = ax / ((g["NPHealth"][K] - ax) / (g["GetTime"]() - g["NPbegintime"][K]))
				end
			end
		end
	end;
	g["WR_GetUnitDeathTime"] = function(L)
		g["WR_GetNPDeathTime"]()
		local ay = i("0")
		if g["UnitGUID"](L) == e then
			ay = i("0")
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitGUID"](L) ~= e and g["UnitGUID"]("nameplate" .. K) ~= e and g["UnitGUID"](L) == g["UnitGUID"]("nameplate" .. K) and g["NPdeathtime"][K] ~= e then
				ay = g["NPdeathtime"][K]
			end
		end;
		if g["MSG"] == i("1") then
		end;
		if ay ~= e then
			return ay
		else
			return i("0")
		end
	end;
	g["WR_GetRangeAvgDeathTime"] = function(az)
		if g["WR_InTraining"]() then
			return i("999")
		end;
		g["WR_GetNPDeathTime"]()
		local aA, Q, aB, aC, aD;
		local aE = i("0")
		local R = i("0")
		local aF = i("0")
		for K = i("1"), i("40"), i("1") do
			Q, aB = g["UnitName"]("nameplate" .. K)
			aD = g["WR_GetUnitRange"]("nameplate" .. K)
			aA = g["UnitAffectingCombat"]("nameplate" .. K)
			if aD ~= e and aA == d and g["NPdeathtime"][K] ~= e and Q ~= e then
				if aD <= az and g["NPdeathtime"][K] > i("0") and g["NPdeathtime"][K] < i("999") and Q ~= "爆炸物" then
					aE = aE + g["NPdeathtime"][K]
					R = R + i("1")
				end
			end
		end;
		if R ~= i("0") then
			aF = aE / R
		end;
		if g["MSG"] == i("1") then
			g["print"]("预计战斗结束时间:|cffffdf00", g["math"]["ceil"](aF), "|cffffffff秒")
		end;
		return aF
	end;
	g["WR_GetUnitHP"] = function(L)
		if g["UnitExists"](L) == d then
			return (g["UnitHealth"](L) + g["UnitGetTotalAbsorbs"](L) + (g["UnitGetIncomingHeals"](L) or i("0")) - g["UnitGetTotalHealAbsorbs"](L)) / g["UnitHealthMax"](L)
		else
			return i("1")
		end
	end;
	g["WR_GetUnitMP"] = function(L)
		if g["UnitPowerMax"](L, i("0")) ~= i("0") then
			return g["UnitPower"](L, i("0")) / g["UnitPowerMax"](L, i("0"))
		else
			return i("0")
		end
	end;
	g["WR_GetUnitLostHealth"] = function(L)
		if g["UnitExists"](L) and not g["UnitIsDead"](L) then
			local aG = g["UnitHealthMax"](L) - g["UnitHealth"](L) - (g["UnitGetIncomingHeals"](L) or i("0")) + g["UnitGetTotalHealAbsorbs"](L)
			return aG > i("0") and aG or i("0")
		else
			return i("0")
		end
	end;
	g["WR_PartyLostHP"] = function()
		local aH;
		local aI = i("0")
		local aE = i("0")
		aH = "player"
		if g["UnitExists"](aH) == d and g["UnitIsDead"](aH) == c and g["WR_GetUnitRange"](aH) <= i("46") then
			aI = aI + (g["UnitHealthMax"](aH) - g["UnitHealth"](aH)) / g["UnitHealthMax"](aH)
			aE = aE + i("1")
		end;
		if g["WR_GetInRaidOrParty"]() == "party" then
			for K = i("1"), i("4"), i("1") do
				aH = "party" .. K;
				if g["UnitExists"](aH) == d and g["UnitIsDead"](aH) == c and g["WR_GetUnitRange"](aH) <= i("46") then
					aI = aI + (g["UnitHealthMax"](aH) - g["UnitHealth"](aH)) / g["UnitHealthMax"](aH)
					aE = aE + i("1")
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "raid" then
			for K = i("1"), i("20"), i("1") do
				aH = "raid" .. K;
				if g["UnitExists"](aH) == d and g["UnitIsDead"](aH) == c and g["WR_GetUnitRange"](aH) <= i("46") then
					aI = aI + (g["UnitHealthMax"](aH) - g["UnitHealth"](aH)) / g["UnitHealthMax"](aH)
					aE = aE + i("1")
				end
			end
		end;
		if aE == i("0") then
			aI = i("0")
		else
			aI = g["math"]["ceil"](aI / aE * i("100")) / i("100")
		end;
		if g["MSG"] == i("1") then
		end;
		return aI
	end;
	g["WR_PlayerMove"] = function()
		if g["IsPlayerSpell"](i("108839")) and g["WR_GetUnitBuffTime"]("player", i("108839")) > g["GCD"] then
			return c
		end;
		local aJ, w, w, w = g["GetUnitSpeed"]("player")
		if g["IsFlying"]() == c and g["IsFalling"]() == c and aJ == i("0") then
			return c
		else
			return d
		end
	end;
	g["WR_GetUnitRange"] = function(L)
		local aK = g["select"](i("2"), g["WR_LibRangeCheck3"]["GetRange"](g["WR_LibRangeCheck3"], L))
		if aK == e then
			return i("999")
		end;
		return aK
	end;
	g["WR_Invincible"] = function(L)
		local Q, aL, aM, aN = g["GetInstanceInfo"]()
		if aL == "raid" then
			return c
		end;
		for w, Q in g["pairs"](g["InvincibleUnitName"]) do
			if g["UnitName"](L) == Q then
				return d
			end
		end;
		if g["UnitClassification"](L) == "normal" or g["UnitClassification"](L) == "trivial" or g["UnitClassification"](L) == "minus" then
			return c
		end;
		if not g["UnitExists"](L) then
			return c
		end;
		if g["WR_GetUnitBuffCount"](L, g["InvincibleBuffName"]) > i("0") or g["WR_GetUnitDebuffCount"](L, g["InvincibleBuffName"]) > i("0") then
			return d
		end;
		return c
	end;
	g["WR_GetRangeHarmUnitCount"] = function(az, aO)
		local aP = i("0")
		for K = i("1"), i("40"), i("1") do
			local L = "nameplate" .. K;
			if g["UnitCanAttack"]("player", L) and not g["WR_Invincible"](L) and (aO ~= d or g["UnitAffectingCombat"](L) == aO) and g["UnitCreatureType"](L) ~= "图腾" and g["UnitCreatureType"](L) ~= "气体云雾" and g["WR_GetUnitRange"](L) <= az and g["UnitName"](L) ~= "复酌之桶" then
				aP = aP + i("1")
			end
		end;
		return aP
	end;
	g["WR_GetSpellRangeHarmUnitCount"] = function(s, aO)
		local aP = i("0")
		for K = i("1"), i("40"), i("1") do
			local L = "nameplate" .. K;
			if g["C_Spell"]["IsSpellInRange"](s, L) and g["UnitCanAttack"]("player", L) and not g["WR_Invincible"](L) and (aO ~= d or g["UnitAffectingCombat"](L) == aO) and g["UnitCreatureType"](L) ~= "图腾" and g["UnitCreatureType"](L) ~= "气体云雾" then
				aP = aP + i("1")
			end
		end;
		return aP
	end;
	g["WR_PartyInCombat"] = function()
		if g["UnitAffectingCombat"]("player") then
			return d
		end;
		for K = i("1"), i("4") do
			local am = "party" .. K;
			if g["UnitAffectingCombat"](am) then
				return d
			end
		end;
		return c
	end;
	g["WR_TargetInCombat"] = function(L)
		local N;
		N, g["_"] = g["UnitName"](L)
		if N == "虚体生物" or not g["UnitExists"](L) or g["UnitIsDead"](L) or not g["UnitCanAttack"]("player", L) or g["WR_Invincible"](L) then
			return c
		end;
		if not g["UnitIsPlayer"](L) and g["UnitIsPlayer"](L .. "target") then
			return d
		end;
		if g["UnitAffectingCombat"](L) and g["WR_PartyInCombat"]() then
			return d
		end;
		if g["WR_InBossCombat"]() then
			return d
		end;
		local K = i("1")
		while g["InCombatName"][K] ~= e and g["InCombatName"][K] ~= f do
			if N == g["InCombatName"][K] then
				return d
			end;
			K = K + i("1")
		end;
		local aQ, aL = g["IsInInstance"]()
		if not aQ then
			return d
		end;
		if g["UnitThreatSituation"]("player", "target") ~= e then
			return d
		end;
		local Q, aL, aM, aN = g["GetInstanceInfo"]()
		if aM == i("208") or aM == i("12") then
			return d
		end;
		return c
	end;
	g["WR_InBossCombat"] = function()
		if g["UnitGUID"]("boss1") == e and g["UnitGUID"]("boss2") == e and g["UnitGUID"]("boss3") == e and g["UnitGUID"]("boss4") == e and g["UnitGUID"]("boss5") == e then
			return c
		else
			return d
		end
	end;
	g["WR_TargetIsBoss"] = function()
		local K;
		for K = i("1"), i("5"), i("1") do
			if g["UnitGUID"]("boss" .. K) ~= e and g["UnitGUID"]("target") ~= e and g["UnitGUID"]("boss" .. K) == g["UnitGUID"]("target") then
				return d
			end
		end;
		return c
	end;
	g["WR_GetRangeSpellTime"] = function(az, s, L)
		local aR = i("999")
		for K = i("1"), i("40"), i("1") do
			if g["UnitExists"]("nameplate" .. K) then
				local aK = g["WR_GetUnitRange"]("nameplate" .. K)
				if aK ~= e and aK <= az and (L == e or g["UnitIsUnit"]("nameplate" .. K .. "target", L)) then
					local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"]("nameplate" .. K)
					if Q == e then
						Q, aS, aT, aU, x, aV, aX, aY = g["UnitChannelInfo"]("nameplate" .. K)
					end;
					if Q ~= e then
						local aZ = x / i("1000") - g["GetTime"]()
						if aZ > i("999") then
							aZ = i("998")
						end;
						if aZ < aR then
							if g["type"](s) == "table" then
								for a_, b0 in g["pairs"](s) do
									if Q == b0 or aY == a_ then
										aR = aZ
									end
								end
							else
								if s == e or Q == s or aY == s then
									aR = aZ
								end
							end
						end
					end
				end
			end
		end;
		return aR
	end;
	g["WR_GetUnitOutburstDebuffTime"] = function(L)
		for w, a8 in g["pairs"](g["OutburstDebuff"]) do
			local a5 = g["WR_GetUnitDebuffTime"](L, a8)
			if a5 ~= i("0") then
				return a5
			end
		end;
		return i("999")
	end;
	g["WR_GetPartyOutburstDebuffTime"] = function()
		local K;
		for K = i("1"), i("4"), i("1") do
			if g["UnitExists"]("party" .. K) then
				for w, b1 in g["pairs"](g["PartyOutburstDebuff"]) do
					local a5 = g["WR_GetUnitDebuffTime"]("party" .. K, b1)
					if a5 > i("0") then
						return a5
					end
				end
			end
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitExists"]("raid" .. K) then
				for w, b1 in g["pairs"](g["PartyOutburstDebuff"]) do
					local a5 = g["WR_GetUnitDebuffTime"]("raid" .. K, b1)
					if a5 > i("0") then
						return a5
					end
				end
			end
		end;
		return i("999")
	end;
	g["WR_ResistOutburstTime"] = function()
		local b2 = g["WR_GetRangeSpellTime"](i("45"), g["OutburstAoe"])
		if b2 < i("999") then
			return b2
		end;
		local b3 = g["WR_GetUnitOutburstDebuffTime"]("player")
		if b3 < i("999") then
			return b3
		end;
		local b4 = g["WR_GetPartyOutburstDebuffTime"]()
		if b4 < i("999") then
			return b4
		end;
		local b5 = g["WR_GetRangeSpellTime"](i("45"), g["OutburstCasting"], "player")
		if b5 < i("999") then
			return b5
		end;
		g["WR_DangerSpellTime"]()
		local b6;
		if g["Time"] == e then
			b6 = i("5")
		else
			b6 = g["Time"]
		end;
		if g["SF_CastTime"] ~= e then
			if i("6") - (g["GetTime"]() - g["SF_CastTime"]) > i("0") then
				return i("6") - (g["GetTime"]() - g["SF_CastTime"])
			end
		end;
		if g["QFJ_CastTime"] ~= e then
			if i("1.5") - (g["GetTime"]() - g["QFJ_CastTime"]) > i("0") then
				return i("1.5") - (g["GetTime"]() - g["QFJ_CastTime"])
			end
		end;
		if g["WL_CastTime"] ~= e then
			if i("0.5") - (g["GetTime"]() - g["WL_CastTime"]) > i("0") then
				return i("0.5") - (g["GetTime"]() - g["WL_CastTime"])
			end
		end;
		if g["JSSP_CastTime"] ~= e then
			if i("0.5") - (g["GetTime"]() - g["JSSP_CastTime"]) > i("0") then
				return i("0.5") - (g["GetTime"]() - g["JSSP_CastTime"])
			end
		end;
		if g["JLPB_CastTime"] ~= e then
			if i("4") - (g["GetTime"]() - g["JLPB_CastTime"]) > i("0") then
				return i("4") - (g["GetTime"]() - g["JLPB_CastTime"])
			end
		end;
		return i("999")
	end;
	g["WR_ResistSustained"] = function(b7)
		if b7 == e or g["UnitHealth"]("player") / g["UnitHealthMax"]("player") <= b7 then
			local b8 = g["WR_GetRangeSpellTime"](i("45"), g["SustainedAoe"])
			if b8 < i("999") then
				return d
			end;
			if g["WR_GetUnitDebuffTime"]("player", g["SustainedDebuff"]) > i("0") then
				return d
			end;
			for K = i("1"), i("40"), i("1") do
				if g["UnitExists"]("nameplate" .. K) then
					if g["WR_GetUnitBuffTime"]("nameplate" .. K, g["SustainedBuff"]) > i("0") then
						return d
					end;
					for w, J in g["pairs"](g["NecroblastName"]) do
						if J == g["UnitName"]("nameplate" .. K) and g["UnitHealth"]("nameplate" .. K) / g["UnitHealthMax"]("nameplate" .. K) <= i("0.15") then
							return d
						end
					end
				end
			end;
			if g["JSJM_CastTime"] ~= e and g["GetTime"]() - g["JSJM_CastTime"] < i("3") then
				return d
			end
		end;
		return c
	end;
	g["WR_MustDefenseTime"] = function()
		local b9 = g["WR_ResistSustained"]()
		local ba = g["WR_ResistOutburstTime"]()
		if g["UnitHealth"]("player") / g["UnitHealthMax"]("player") <= i("0.35") and g["UnitAffectingCombat"]("player") then
			if b9 or not g["WR_InBossCombat"]() then
				return i("0")
			end;
			if ba < i("999") then
				return ba
			end
		end;
		if ba < i("999") and (b9 or g["WR_GetUnitDebuffCount"]("player", "音速易伤") >= i("2")) then
			return ba
		end;
		local bb = g["WR_GetRangeSpellTime"](i("45"), g["DangerOutburstAoe"])
		if bb < i("999") then
			return bb
		end;
		local bc = g["WR_GetRangeSpellTime"](i("45"), g["DangerSustainedAoe"])
		if bc < i("999") then
			return i("0")
		end;
		local bd = g["WR_GetRangeSpellTime"](i("45"), "熔炉之力")
		if bd > i("6") and bd < i("999") then
			return bd - i("6")
		end;
		if g["UnitName"]("boss1") == "丹塔利纳克斯" and g["UnitCastingInfo"]("boss1") == "暗影箭雨" and g["WR_GetUnitDebuffCount"]("player", "拉文凯斯的遗产") == i("0") then
			return i("0")
		end;
		if g["WR_GetUnitDebuffTime"]("player", g["DangerDebuff"]) > i("0") then
			return i("0")
		end;
		local be = g["WR_GetRangeSpellTime"](i("45"), g["DangerSpellToMe"], "player")
		if be <= i("0.8") then
			return be
		end;
		g["WR_DangerSpellTime"]()
		if g["SF_CastTime"] ~= e then
			if i("6.2") - (g["GetTime"]() - g["SF_CastTime"]) > i("0") then
				return i("6.2") - (g["GetTime"]() - g["SF_CastTime"])
			end
		end;
		return i("999")
	end;
	g["WR_Escape"] = function()
		if not g["WR_PlayerMove"]() and g["UnitAffectingCombat"]("player") then
			if g["WR_GetRangeSpellTime"](i("45"), g["EscapeSpellName"], "player") < i("999") then
				return d
			end
		end;
		return c
	end;
	g["WR_GetEquipCD"] = function(bf)
		if g["GetInventoryItemID"]("player", bf) == i("203729") then
			return c
		end;
		local u, v, bg = g["GetInventoryItemCooldown"]("player", bf)
		if bg == i("1") then
			if u + v <= g["GetTime"]() + g["GCD"] then
				return d
			end
		end;
		return c
	end;
	g["WR_Use_Item"] = function(bh, bi)
		if g["GetInventoryItemID"]("player", bh) == bi and g["WR_GetEquipCD"](bh) then
			return d
		end;
		return c
	end;
	g["WR_WuQi"] = function(az, bj)
		if bj == i("1") or bj == i("2") and g["zhandoumoshi"] == i("1") then
			if g["WR_GetEquipCD"](i("16")) and g["WR_GetUnitRange"]("target") <= az and g["WR_TargetInCombat"]("target") then
				if g["WR_ColorFrame_Show"]("F6", "武器") then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_ShiPin"] = function(bh, bj)
		if bj == i("13") then
			return c
		end;
		if not g["WR_GetEquipCD"](bh + i("12")) then
			return c
		end;
		if bh == i("1") then
			if g["WR_Use_Item"](i("13"), i("178783")) and g["WR_GetUnitBuffTime"]("player", i("345549")) > i("0") then
				return c
			end;
			if bj == i("1") then
				if g["WR_ColorFrame_Show"]("F10", bh .. "饰常") then
					return d
				end
			elseif bj == i("2") and g["zhandoumoshi"] == i("1") then
				if g["WR_ColorFrame_Show"]("F10", bh .. "饰爆") then
					return d
				end
			elseif bj >= i("3") and bj <= i("7") then
				if g["WR_GetUnitHP"]("player") <= (bj - i("2")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACF2", bh .. "饰自") then
						return d
					end
				end
			elseif bj >= i("8") and bj <= i("12") then
				if g["WR_GetUnitHP"]("player") <= (bj - i("7")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACF2", bh .. "饰协P") then
						return d
					end
				elseif not g["UnitIsDead"]("party1") and g["WR_GetUnitHP"]("party1") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party1") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF3", bh .. "饰协P1") then
						return d
					end
				elseif not g["UnitIsDead"]("party2") and g["WR_GetUnitHP"]("party2") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party2") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF5", bh .. "饰协P2") then
						return d
					end
				elseif not g["UnitIsDead"]("party3") and g["WR_GetUnitHP"]("party3") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party3") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF6", bh .. "饰协P3") then
						return d
					end
				elseif not g["UnitIsDead"]("party4") and g["WR_GetUnitHP"]("party4") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party4") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF7", bh .. "饰协P4") then
						return d
					end
				end
			end
		elseif bh == i("2") then
			if g["WR_Use_Item"](i("14"), i("178783")) and g["WR_GetUnitBuffTime"]("player", i("345549")) > i("0") then
				return c
			end;
			if bj == i("1") then
				if g["WR_ColorFrame_Show"]("F11", bh .. "饰常") then
					return d
				end
			elseif bj == i("2") and g["zhandoumoshi"] == i("1") then
				if g["WR_ColorFrame_Show"]("F11", bh .. "饰爆") then
					return d
				end
			elseif bj >= i("3") and bj <= i("7") then
				if g["WR_GetUnitHP"]("player") <= (bj - i("2")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACSF2", bh .. "饰自") then
						return d
					end
				end
			elseif bj >= i("8") and bj <= i("12") then
				if g["WR_GetUnitHP"]("player") <= (bj - i("7")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACSF2", bh .. "饰协P") then
						return d
					end
				elseif not g["UnitIsDead"]("party1") and g["WR_GetUnitHP"]("party1") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party1") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF3", bh .. "饰协P1") then
						return d
					end
				elseif not g["UnitIsDead"]("party2") and g["WR_GetUnitHP"]("party2") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party2") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF5", bh .. "饰协P2") then
						return d
					end
				elseif not g["UnitIsDead"]("party3") and g["WR_GetUnitHP"]("party3") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party3") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF6", bh .. "饰协P3") then
						return d
					end
				elseif not g["UnitIsDead"]("party4") and g["WR_GetUnitHP"]("party4") <= (bj - i("5")) / i("10") and g["WR_GetUnitRange"]("party4") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF7", bh .. "饰协P4") then
						return d
					end
				end
			end
		end;
		return c
	end;
	g["WR_Use_ZLS"] = function()
		if g["ZLS_UseTime"] ~= e and g["GetTime"]() - g["ZLS_UseTime"] < i("10") then
			return c
		end;
		if g["ZLYS_UseTime"] ~= e and g["GetTime"]() - g["ZLYS_UseTime"] < i("0.5") then
			return c
		end;
		if g["ZLYS2_UseTime"] ~= e and g["GetTime"]() - g["ZLYS2_UseTime"] < i("0.5") then
			return c
		end;
		if g["WR_GetUnitBuffTime"]("player", "圣盾术") > i("0") then
			return c
		end;
		local bk = {
			[i("1")] = "治疗石",
			[i("2")] = "恶魔治疗石"
		}
		for w, bl in g["pairs"](bk) do
			local R = g["C_Item"]["GetItemCount"](bl)
			local u, v, bg = g["C_Item"]["GetItemCooldown"](bl)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_ZLS"] = function(bm)
		if not g["PlayerHP"] then
			g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
		end;
		if bm ~= i("5") and g["PlayerHP"] < bm / i("10") and g["UnitAffectingCombat"]("player") and g["WR_Use_ZLS"]() then
			if g["UnitClassBase"]("player") == "WARLOCK" and g["WR_SpellUsable"]("灵魂燃烧") then
				if g["WR_ColorFrame_Show"]("CN0", "灵魂燃烧") then
					return d
				end
			else
				if g["WR_ColorFrame_Show"]("CSF", "治疗石") then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_Use_ZLYS"] = function()
		if g["ZLS_UseTime"] ~= e and g["GetTime"]() - g["ZLS_UseTime"] < i("0.5") then
			return c
		end;
		if g["ZLYS_UseTime"] ~= e and g["GetTime"]() - g["ZLYS_UseTime"] < i("0.5") then
			return c
		end;
		if g["ZLYS2_UseTime"] ~= e and g["GetTime"]() - g["ZLYS2_UseTime"] < i("0.5") then
			return c
		end;
		if g["WR_GetUnitBuffTime"]("player", "圣盾术") > i("0") then
			return c
		end;
		local bn = {
			[i("1")] = "阿加治疗药水"
		}
		for w, bo in g["pairs"](bn) do
			local R = g["C_Item"]["GetItemCount"](bo)
			local u, v, bg = g["C_Item"]["GetItemCooldown"](bo)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_Use_ZLYS2"] = function()
		if g["ZLS_UseTime"] ~= e and g["GetTime"]() - g["ZLS_UseTime"] < i("0.5") then
			return c
		end;
		if g["ZLYS_UseTime"] ~= e and g["GetTime"]() - g["ZLYS_UseTime"] < i("0.5") then
			return c
		end;
		if g["ZLYS2_UseTime"] ~= e and g["GetTime"]() - g["ZLYS2_UseTime"] < i("0.5") then
			return c
		end;
		if g["WR_GetUnitBuffTime"]("player", "圣盾术") > i("0") then
			return c
		end;
		local bn = {
			[i("1")] = "洞穴住民的挚爱"
		}
		for w, bo in g["pairs"](bn) do
			local R = g["C_Item"]["GetItemCount"](bo)
			local u, v, bg = g["C_Item"]["GetItemCooldown"](bo)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_ZLYS"] = function(bm)
		if not g["PlayerHP"] then
			g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
		end;
		if bm ~= i("5") and g["PlayerHP"] < bm / i("10") and g["UnitAffectingCombat"]("player") and g["WR_Use_ZLYS"]() then
			if g["WR_ColorFrame_Show"]("CST", "治疗药水") then
				return d
			end
		end;
		return c
	end;
	g["WR_ZLYS2"] = function(bm)
		if not g["PlayerHP"] then
			g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
		end;
		if bm ~= i("5") and g["PlayerHP"] < bm / i("10") and g["UnitAffectingCombat"]("player") and g["WR_Use_ZLYS2"]() then
			if g["WR_ColorFrame_Show"]("CSX", "治疗药水2") then
				return d
			end
		end;
		return c
	end;
	g["WR_Use_BFYS"] = function()
		local bp = {
			[i("1")] = "淬火药水"
		}
		for w, bq in g["pairs"](bp) do
			local R = g["C_Item"]["GetItemCount"](bq)
			local u, v, bg = g["C_Item"]["GetItemCooldown"](bq)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_GetTrueCastTime"] = function(y)
		local Q, br, bs, bt, aC, aD, j = g["GetSpellInfo"](y)
		return bt / i("1000")
	end;
	g["WR_PreemptiveHealing"] = function(y)
		if g["WR_GetRangeSpellTime"](i("45"), g["QZWY_AOE_Name"]) < i("999") then
			return c
		end;
		if g["WR_GetRangeSpellTime"](i("45"), g["QZWY_Spell_Name"], "player") < i("999") then
			return c
		end;
		if g["WR_ResistOutburstTime"]() < g["WR_GetTrueCastTime"](y) then
			return d
		end;
		return c
	end;
	g["WR_GetInRaidOrParty"] = function()
		for K = i("1"), i("40"), i("1") do
			if g["UnitExists"]("raid" .. K) == d then
				return "raid"
			end
		end;
		for K = i("1"), i("4"), i("1") do
			if g["UnitExists"]("party" .. K) == d then
				return "party"
			end
		end;
		return "single"
	end;
	g["WR_EventNotifications"] = function()
		if g["WR_EventNotificationsIsOpen"] == d then
			return
		end;
		local bu = g["CreateFrame"]("Frame")
		bu["RegisterEvent"](bu, "COMBAT_LOG_EVENT_UNFILTERED")
		bu["SetScript"](bu, "OnEvent", function()
			if g["IsInInstance"]() then
				local bv = "SAY"
				local bw, bx, by, bz, bA, bB, bC, bD, bE, bF, bG = g["CombatLogGetCurrentEventInfo"]()
				if bx == "SPELL_INTERRUPT" then
					local aY, bH, bI, bJ, bK, bL = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bA == g["UnitName"]("player") or bA == g["UnitName"]("pet") then
						g["SendChatMessage"]("打断-->" .. g["C_Spell"]["GetSpellLink"](bJ), bv)
					end
				elseif bx == "SPELL_DISPEL" then
					local aY, bH, bI, bJ, bK, bL, bM = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bA == g["UnitName"]("player") or bA == g["UnitName"]("pet") then
						g["SendChatMessage"]("驱散-->" .. g["C_Spell"]["GetSpellLink"](bJ), bv)
					end
				elseif bx == "SPELL_STOLEN" then
					local aY, bH, bI, bJ, bK, bL, bM = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bA == g["UnitName"]("player") then
						g["SendChatMessage"]("偷取-->" .. g["C_Spell"]["GetSpellLink"](bJ), bv)
					end
				elseif bx == "SPELL_MISSED" then
					local aY, bH, bI, bN, bO, bP = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bN == "REFLECT" and bE == g["UnitName"]("player") then
						g["SendChatMessage"]("反射-->" .. g["C_Spell"]["GetSpellLink"](aY), bv)
					elseif bN == "ABSORB" and bE == "根基图腾" and bF == i("8465") then
						g["SendChatMessage"]("吸收-->" .. g["C_Spell"]["GetSpellLink"](aY), bv)
					end
				end
			end
		end)
		g["WR_EventNotificationsIsOpen"] = d
	end;
	g["WR_HidePlayerNotFound"] = function()
		if g["WR_HidePlayerNotFoundIsOpen"] == d then
			return
		end;
		g["ChatFrame_AddMessageEventFilter"]("CHAT_MSG_SYSTEM", function(w, w, bQ)
			if g["strmatch"](bQ, g["ERR_CHAT_PLAYER_NOT_FOUND_S"]["gsub"](g["ERR_CHAT_PLAYER_NOT_FOUND_S"], "%%%d?$?%a", ".*")) then
				return d
			end
		end)
		local bR = g["CommunitiesGuildNewsFrame_OnEvent"]
		local bS, bT;
		g["CommunitiesFrameGuildDetailsFrameNews"]["SetScript"](g["CommunitiesFrameGuildDetailsFrameNews"], "OnEvent", function(bU, bV)
			if bV == "GUILD_NEWS_UPDATE" then
				if bT then
					bS = d
				else
					bR(bU, bV)
					bT = g["C_Timer"]["NewTimer"](i("1"), function()
						if bS then
							bR(bU, bV)
						end;
						bT = e
					end)
				end
			else
				bR(bU, bV)
			end
		end)
		g["WR_HidePlayerNotFoundIsOpen"] = d
	end;
	g["WR_DangerSpellTime"] = function()
		if g["WR_DangerSpellTimeIsOpen"] == d then
			return
		end;
		local bu = g["CreateFrame"]("Frame")
		bu["RegisterEvent"](bu, "COMBAT_LOG_EVENT_UNFILTERED")
		bu["SetScript"](bu, "OnEvent", function()
			if g["select"](i("2"), g["CombatLogGetCurrentEventInfo"]()) == "SPELL_CAST_SUCCESS" then
				local s = g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]())
				if s == "霜风" then
					g["SF_CastTime"] = g["GetTime"]()
				end;
				if s == "强风箭" then
					g["QFJ_CastTime"] = g["GetTime"]()
				end;
				if s == "紊流" then
					g["WL_CastTime"] = g["GetTime"]()
				end;
				if s == "坚石碎片" then
					g["JSSP_CastTime"] = g["GetTime"]()
				end;
				if s == "警示尖鸣" then
					g["JSJM_CastTime"] = g["GetTime"]()
				end;
				if s == "激流破奔" then
					g["JLPB_CastTime"] = g["GetTime"]()
				end
			end
		end)
		g["WR_DangerSpellTimeIsOpen"] = d
	end;
	g["WR_CanTab"] = function()
		for w, Q in g["pairs"](g["DontTabUnitName"]) do
			if g["UnitName"]("target") == Q then
				return c
			end
		end;
		return d
	end;
	g["WR_CanDot"] = function(L)
		g["TempUnit"] = L;
		if g["TempUnit"] == e then
			g["TempUnit"] = "target"
		end;
		for w, Q in g["pairs"](g["DontDotUnitName"]) do
			if g["UnitName"](g["TempUnit"]) == Q then
				return c
			end
		end;
		for w, Q in g["pairs"](g["InvincibleUnitName"]) do
			if g["UnitName"](g["TempUnit"]) == Q then
				return c
			end
		end;
		return d
	end;
	g["WR_PartyNotBuff"] = function(X, y)
		if g["WR_GetUnitBuffCount"]("player", X) == i("0") then
			return d
		end;
		if not g["IsInInstance"]() then
			return c
		end;
		if g["UnitAffectingCombat"]("player") then
			return c
		end;
		for K = i("1"), i("40"), i("1") do
			if K <= i("4") then
				g["unit"] = "party" .. K;
				if g["UnitExists"](g["unit"]) and g["UnitIsPlayer"](g["unit"]) and not g["UnitCanAttack"]("player", g["unit"]) and not g["UnitIsDead"](g["unit"]) and g["WR_GetUnitBuffCount"](g["unit"], X) == i("0") and (g["WR_GetUnitRange"](g["unit"]) <= i("50") or y ~= e and g["IsSpellInRange"](y, g["unit"])) then
					return d
				end;
				g["unit"] = "raid" .. K;
				if g["UnitExists"](g["unit"]) and g["UnitIsPlayer"](g["unit"]) and not g["UnitCanAttack"]("player", g["unit"]) and not g["UnitIsDead"](g["unit"]) and g["WR_GetUnitBuffCount"](g["unit"], X) == i("0") and (g["WR_GetUnitRange"](g["unit"]) <= i("50") or y ~= e and g["IsSpellInRange"](y, g["unit"])) then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_CanRemoveUnitDebuff"] = function(L)
		local aa = c;
		local ab = c;
		local ac = c;
		local ad = c;
		if g["IsPlayerSpell"](i("527")) == d then
			aa = d
		end;
		if g["IsSpellKnown"](i("89808"), d) == d then
			aa = d
		end;
		if g["IsPlayerSpell"](i("77130")) == d then
			aa = d
		end;
		if g["IsPlayerSpell"](i("4987")) == d then
			aa = d
		end;
		if g["IsPlayerSpell"](i("213644")) == d then
			ac = d;
			ad = d
		end;
		if g["IsPlayerSpell"](i("115450")) == d then
			aa = d
		end;
		if g["IsPlayerSpell"](i("390632")) == d then
			ac = d
		end;
		if g["IsPlayerSpell"](i("383016")) == d then
			ab = d
		end;
		if g["IsPlayerSpell"](i("51886")) == d then
			ab = d
		end;
		if g["IsPlayerSpell"](i("2782")) == d then
			ab = d;
			ad = d
		end;
		if g["IsPlayerSpell"](i("218164")) == d then
			ac = d;
			ad = d
		end;
		if g["IsPlayerSpell"](i("393024")) == d then
			ad = d;
			ac = d
		end;
		if g["IsPlayerSpell"](i("388874")) == d then
			ad = d;
			ac = d
		end;
		if g["IsPlayerSpell"](i("365585")) == d then
			ad = d
		end;
		if g["IsPlayerSpell"](i("475")) == d then
			ab = d
		end;
		if g["IsPlayerSpell"](i("213634")) == d then
			ac = d
		end;
		if g["IsPlayerSpell"](i("88423")) == d then
			aa = d
		end;
		if g["IsPlayerSpell"](i("392378")) == d then
			ad = d;
			ab = d
		end;
		if g["WR_GetUnitDebuffTime"](L, g["ZXQS_Debuff"]) > i("0") and g["UnitGUID"](L) ~= g["UnitGUID"]("mouseover") then
			return c
		end;
		if g["WR_GetUnitDebuffTime"](L, "消解时间") > i("0") then
			return c
		end;
		if g["WR_GetUnitDebuffTime"](L, g["HuLueQuSanDebuffName"]) > i("0") then
			return c
		end;
		if aa == d and g["WR_UnitDebuffType"](L, "Magic") == d then
			return d
		end;
		if ab == d and g["WR_UnitDebuffType"](L, "Curse") == d then
			return d
		end;
		if ac == d and g["WR_UnitDebuffType"](L, "Disease") == d then
			return d
		end;
		if ad == d and g["WR_UnitDebuffType"](L, "Poison") == d then
			return d
		end;
		return c
	end;
	g["WR_CanRemoveUnitDangerDebuff"] = function(L)
		if not g["WR_CanRemoveUnitDebuff"](L) then
			return c
		end;
		if g["WR_GetUnitDebuffTime"](L, g["DangerRemoveDebuff"]) > i("0") then
			return d
		end;
		if g["WR_GetUnitDebuffCount"](L, "爆裂") >= i("5") then
			return d
		end;
		if g["WR_GetUnitDebuffCount"](L, "压制瘴气") >= i("10") then
			return d
		end
	end;
	g["WR_ResurrectParty"] = function()
		for K = i("1"), i("40"), i("1") do
			local aH;
			if K <= i("4") then
				aH = "party" .. K;
				if g["UnitIsDead"](aH) and g["WR_GetUnitRange"](aH) <= i("100") then
					return d
				end;
				aH = "raid" .. K;
				if g["UnitIsDead"](aH) and g["WR_GetUnitRange"](aH) <= i("100") then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_StopCast"] = function(bW)
		if g["WR_GetRangeSpellTime"](i("45"), g["StopCastID"]) < bW + i("0.4") then
			return d
		end;
		return c
	end;
	g["WR_RangeCountPR"] = function(az, bX)
		local aH;
		local bY = i("0")
		aH = "player"
		if g["UnitHealthMax"](aH) ~= i("0") and g["WR_GetUnitHP"](aH) <= bX then
			bY = bY + i("1")
		end;
		if g["UnitExists"]("raid1") then
			for K = i("1"), i("40"), i("1") do
				aH = "raid" .. K;
				local aD = g["WR_GetUnitRange"](aH)
				local bZ = i("0")
				if g["UnitExists"](aH) then
					bZ = g["WR_GetUnitHP"](aH)
				end;
				if aD ~= e and aD <= az and bZ > i("0") and bZ <= bX then
					bY = bY + i("1")
				end
			end
		else
			for K = i("1"), i("4"), i("1") do
				aH = "party" .. K;
				local aD = g["WR_GetUnitRange"](aH)
				local bZ = i("0")
				if g["UnitExists"](aH) then
					bZ = g["WR_GetUnitHP"](aH)
				end;
				if aD ~= e and aD <= az and bZ > i("0") and bZ <= bX then
					bY = bY + i("1")
				end
			end
		end;
		return bY
	end;
	g["WR_UnitEnragedBuff"] = function(L)
		if g["WR_GetUnitBuffCount"](L, "无穷饥渴") >= i("6") then
			return d
		end;
		if g["WR_GetUnitBuffTime"](L, g["EnragedBuffName"]) > i("0") then
			return d
		end
	end;
	g["WR_GetCastInterruptible"] = function(L, b_, c0)
		if g["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return c
		end;
		if g["UnitCastingInfo"](L) == "星宇飞升" then
			return c
		end;
		if g["UnitName"]("boss1") == "无堕者哈夫" then
			return c
		end;
		local c1, c2, c3 = g["WR_GetUnitCastInfo"](L, c0)
		if c1 ~= e and c3 ~= e then
			if c1 / (c1 + c2) >= b_ and c3 == d then
				return d
			end
		end;
		local c4, c5 = g["WR_GetUnitChannelInfo"](L, c0)
		if c4 ~= e and c5 ~= e then
			if c4 >= b_ and c5 == d then
				return d
			end
		end;
		return c
	end;
	g["WR_GetUnitCastInfo"] = function(L, c0)
		local c6 = e;
		local c7 = e;
		local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"](L)
		if x ~= e then
			for w, c8 in g["pairs"](g["MustInterruptUnitName"]) do
				if g["UnitName"](L) == c8 then
					return g["GetTime"]() - aU / i("1000"), x / i("1000") - g["GetTime"](), not aX
				end
			end;
			if g["UnitIsPlayer"](L) then
				return g["GetTime"]() - aU / i("1000"), x / i("1000") - g["GetTime"](), not aX
			end;
			local Q, aL, aM, aN = g["GetInstanceInfo"]()
			if aM ~= i("8") then
				return g["GetTime"]() - aU / i("1000"), x / i("1000") - g["GetTime"](), not aX
			end;
			if c0 then
				for c9, s in g["pairs"](g["MustInterruptSpellName"]) do
					if aY == c9 or Q == s then
						return g["GetTime"]() - aU / i("1000"), x / i("1000") - g["GetTime"](), not aX
					end
				end
			else
				for ca, cb in g["pairs"](g["ExcludeSpell"]) do
					if aY == ca or Q == cb then
						return e, e, e
					end
				end;
				return g["GetTime"]() - aU / i("1000"), x / i("1000") - g["GetTime"](), not aX
			end
		end;
		return e, e, e
	end;
	g["WR_GetUnitChannelInfo"] = function(L, c0)
		local cc = e;
		local cd = e;
		local Q, aS, aT, aU, x, aV, aX, aY = g["UnitChannelInfo"](L)
		if x ~= e then
			for w, c8 in g["pairs"](g["MustInterruptUnitName"]) do
				if g["UnitName"](L) == c8 then
					return g["GetTime"]() - aU / i("1000"), not aX
				end
			end;
			if g["UnitIsPlayer"](L) then
				return g["GetTime"]() - aU / i("1000"), not aX
			end;
			if c0 then
				for c9, s in g["pairs"](g["MustInterruptSpellName"]) do
					if aY == c9 or Q == s then
						return g["GetTime"]() - aU / i("1000"), not aX
					end
				end
			else
				for ca, cb in g["pairs"](g["ExcludeSpell"]) do
					if aY == ca or Q == cb then
						return e, e
					end
				end;
				return g["GetTime"]() - aU / i("1000"), not aX
			end
		end;
		return e, e
	end;
	g["WR_GetRuneCount"] = function()
		local ce = i("0")
		for K = i("1"), i("6") do
			if g["GetRuneCount"](K) ~= e then
				ce = ce + g["GetRuneCount"](K)
			end
		end;
		return ce
	end;
	g["WR_TankResist"] = function()
		local cf = i("999")
		local cg = i("999")
		local ch = i("999")
		local ci = i("999")
		for K = i("1"), i("40"), i("1") do
			if g["UnitName"]("boss1") == "乌比斯将军" and g["WR_GetUnitDebuffCount"]("player", "碎颅打击") >= i("2") and g["WR_GetUnitDebuffTime"]("player", "碎颅打击") > i("4") then
				ch = i("1.4")
				ci = i("1.4")
			end;
			local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"]("nameplate" .. K)
			if Q ~= e then
				if g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
					if g["TankResist_SmallMagicToMe"] ~= e then
						for c9, s in g["pairs"](g["TankResist_SmallMagicToMe"]) do
							if s == f then
								break
							end;
							if s == Q or c9 == aY then
								cf = x / i("1000") - g["GetTime"]()
							end
						end
					end;
					if g["TankResist_BigMagicToMe"] ~= e then
						for c9, s in g["pairs"](g["TankResist_BigMagicToMe"]) do
							if s == f then
								break
							end;
							if s == Q or c9 == aY then
								cg = x / i("1000") - g["GetTime"]()
							end
						end
					end;
					if g["TankResist_SmallPhysicalToMe"] ~= e then
						for c9, s in g["pairs"](g["TankResist_SmallPhysicalToMe"]) do
							if s == f then
								break
							end;
							if s == Q or c9 == aY then
								ch = x / i("1000") - g["GetTime"]()
							end
						end
					end;
					if g["TankResist_BigPhysicalToMe"] ~= e then
						for c9, s in g["pairs"](g["TankResist_BigPhysicalToMe"]) do
							if s == f then
								break
							end;
							if s == Q or c9 == aY then
								ci = x / i("1000") - g["GetTime"]()
							end
						end
					end
				end;
				if g["TankResist_SmallMagicToAoe"] ~= e then
					for c9, s in g["pairs"](g["TankResist_SmallMagicToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or c9 == aY then
							cf = x / i("1000") - g["GetTime"]()
						end
					end
				end;
				if g["TankResist_BigMagicToAoe"] ~= e then
					for c9, s in g["pairs"](g["TankResist_BigMagicToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or c9 == aY then
							cg = x / i("1000") - g["GetTime"]()
						end
					end
				end;
				if g["TankResist_SmallPhysicalToAoe"] ~= e then
					for c9, s in g["pairs"](g["TankResist_SmallPhysicalToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or c9 == aY then
							ch = x / i("1000") - g["GetTime"]()
						end
					end
				end;
				if g["TankResist_BigPhysicalToAoe"] ~= e then
					for c9, s in g["pairs"](g["TankResist_BigPhysicalToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or c9 == aY then
							ci = x / i("1000") - g["GetTime"]()
						end
					end
				end
			end
		end;
		return cf, cg, ch, ci
	end;
	g["WR_SpellReflection"] = function(cj)
		for K = i("1"), i("40"), i("1") do
			local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"]("nameplate" .. K)
			if x ~= e then
				if x / i("1000") - g["GetTime"]() < cj then
					for c9, s in g["pairs"](g["ReflectionAOE"]) do
						if s == Q or c9 == aY then
							return d
						end
					end;
					if g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
						for c9, s in g["pairs"](g["ReflectionSpell"]) do
							if s == Q or c9 == aY then
								return d
							end
						end
					end
				end
			end;
			local Q, aS, aT, aU, x, aV, aX, aY = g["UnitChannelInfo"]("nameplate" .. K)
			if aU ~= e then
				for c9, s in g["pairs"](g["ReflectionAOE"]) do
					if s == Q or c9 == aY then
						return d
					end
				end;
				if g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
					for c9, s in g["pairs"](g["ReflectionSpell"]) do
						if s == Q or c9 == aY then
							return d
						end
					end
				end
			end
		end;
		return c
	end;
	g["WR_StunUnit"] = function(az, cj)
		if g["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return c
		end;
		local K = i("1")
		while g["DontStunUnitName"][K] ~= e and g["DontStunUnitName"][K] ~= f do
			if g["DontStunUnitName"][K] == g["UnitName"]("target") then
				return c
			end;
			K = K + i("1")
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitCanAttack"]("player", "nameplate" .. K) then
				local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"]("nameplate" .. K)
				if Q ~= e then
					local aD = g["WR_GetUnitRange"]("nameplate" .. K)
					if aD ~= e and aD <= az and (cj == e or x / i("1000") - g["GetTime"]() < cj) then
						for c9, s in g["pairs"](g["StunCastName"]) do
							if s == Q or c9 == aY then
								return d
							end
						end
					end
				end;
				local Q, aS, aT, aU, x, aV, aX, aY = g["UnitChannelInfo"]("nameplate" .. K)
				if Q ~= e then
					local aD = g["WR_GetUnitRange"]("nameplate" .. K)
					if aD ~= e and aD <= az then
						for c9, s in g["pairs"](g["StunChannelName"]) do
							if s == Q or c9 == aY then
								return d
							end
						end
					end
				end
			end
		end;
		return c
	end;
	g["WR_GetSpellNextCharge"] = function(s)
		if g["C_Spell"]["GetSpellCharges"](s) == e then
			return i("999")
		end;
		local ck = g["C_Spell"]["GetSpellCharges"](s)["cooldownStartTime"]
		local cl = g["C_Spell"]["GetSpellCharges"](s)["cooldownDuration"]
		if ck == i("0") then
			return i("0")
		end;
		return ck + cl - g["GetTime"]()
	end;
	g["WR_GetSpellCharges"] = function(s)
		if g["C_Spell"]["GetSpellCharges"](s) ~= e then
			return g["C_Spell"]["GetSpellCharges"](s)["currentCharges"] or i("0")
		end
	end;
	g["WR_GetSuit"] = function(cm)
		local cn = i("0")
		for K = i("1"), i("19") do
			local co = g["GetInventoryItemID"]("player", K)
			for w, cp in g["pairs"](cm) do
				if co == cp then
					cn = cn + i("1")
				end
			end
		end;
		return cn
	end;
	g["WR_StunSpell"] = function(L, cj)
		if g["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return c
		end;
		local N, w = g["UnitName"](L)
		local aJ, w, w, w = g["GetUnitSpeed"](L)
		local K = i("1")
		while g["StunUnitName"][K] ~= e and g["StunUnitName"][K] ~= f do
			if g["StunUnitName"][K] == N and aJ > i("0") then
				return d
			end;
			K = K + i("1")
		end;
		local K = i("1")
		while g["DontStunUnitName"][K] ~= e and g["DontStunUnitName"][K] ~= f do
			if g["DontStunUnitName"][K] == N then
				return c
			end;
			K = K + i("1")
		end;
		if g["UnitCanAttack"]("player", L) then
			local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"](L)
			if Q ~= e and (cj == e or x / i("1000") - g["GetTime"]() < cj) then
				for c9, s in g["pairs"](g["StunCastName"]) do
					if s == Q or c9 == aY then
						return d
					end
				end
			end;
			local Q, aS, aT, aU, x, aV, aX, aY = g["UnitChannelInfo"](L)
			if Q ~= e then
				for c9, s in g["pairs"](g["StunChannelName"]) do
					if s == Q or c9 == aY then
						return d
					end
				end
			end
		end;
		return c
	end;
	g["WR_SingleUnit"] = function()
		local N, w = g["UnitName"]("target")
		local M = i("1")
		while g["SingleUnitName"][M] ~= e and g["SingleUnitName"][M] ~= f do
			if N == g["SingleUnitName"][M] then
				return d
			end;
			M = M + i("1")
		end;
		return c
	end;
	g["WR_GetPartyRange"] = function()
		local K;
		g["TargetRange"] = g["WR_GetUnitRange"]("target")
		g["FocusRange"] = g["WR_GetUnitRange"]("focus")
		for K = i("1"), i("4"), i("1") do
			g["PartyRange"][K] = g["WR_GetUnitRange"]("party" .. K)
		end;
		for K = i("1"), i("40"), i("1") do
			g["RiadRange"][K] = g["WR_GetUnitRange"]("raid" .. K)
		end
	end;
	g["WR_GetPartyLostHealth"] = function()
		local K;
		g["PlayerLostHealth"] = g["WR_GetUnitLostHealth"]("player")
		g["TargetLostHealth"] = g["WR_GetUnitLostHealth"]("target")
		g["FocusLostHealth"] = g["WR_GetUnitLostHealth"]("focus")
		for K = i("1"), i("4"), i("1") do
			g["PartyLostHealth"][K] = g["WR_GetUnitLostHealth"]("party" .. K)
		end;
		for K = i("1"), i("40"), i("1") do
			g["RiadLostHealth"][K] = g["WR_GetUnitLostHealth"]("raid" .. K)
		end
	end;
	g["WR_GetLastSpellName"] = function()
		if g["WR_LastSpellNameIsOpen"] == d then
			return
		end;
		local bu = g["CreateFrame"]("Frame")
		bu["RegisterEvent"](bu, "COMBAT_LOG_EVENT_UNFILTERED")
		bu["SetScript"](bu, "OnEvent", function()
			local bw, cq, by, bz, bA, bB, bC, bD, bE, bF, bG = g["CombatLogGetCurrentEventInfo"]()
			if cq == "SPELL_CAST_SUCCESS" and bz == g["UnitGUID"]("player") then
				g["WR_LastSpellName"] = g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]())
			end
		end)
		g["WR_LastSpellNameIsOpen"] = d
	end;
	g["WR_GetSpellAuraApplied"] = function()
		if g["WR_GetSpellAuraAppliedIsOpen"] == d then
			return
		end;
		local bu = g["CreateFrame"]("Frame")
		bu["RegisterEvent"](bu, "COMBAT_LOG_EVENT_UNFILTERED")
		bu["SetScript"](bu, "OnEvent", function()
			local bw, cq, by, bz, bA, bB, bC, bD, bE, bF, bG = g["CombatLogGetCurrentEventInfo"]()
			if cq == "SPELL_AURA_APPLIED" and bD == g["UnitGUID"]("player") then
				if g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]()) == i("438141") or g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]()) == "暮光屠戮" then
					g["MGTL_DebuffTime"] = g["GetTime"]()
				end
			end;
			if cq == "SPELL_CAST_START" and bD == g["UnitGUID"]("player") then
				if g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]()) == i("438141") or g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]()) == "暮光屠戮" then
					g["MGTL_DebuffTime"] = g["GetTime"]()
				end
			end;
			if bD == g["UnitGUID"]("player") then
			end
		end)
		g["WR_GetSpellAuraAppliedIsOpen"] = d
	end;
	g["WR_SpeedUp"] = function()
		if g["WR_GetUnitDebuffInfo"]("player", "能量过载", c) ~= i("0") then
			return d
		end;
		g["WR_GetSpellAuraApplied"]()
		if g["MGTL_DebuffTime"] ~= e and g["GetTime"]() - g["MGTL_DebuffTime"] > i("0") and g["GetTime"]() - g["MGTL_DebuffTime"] < i("2") then
			return d
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitName"]("nameplate" .. K) == "怨毒影魔" and g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
				return d
			end;
			local Q, aS, aT, aU, x, aV, aW, aX, aY = g["UnitCastingInfo"]("nameplate" .. K)
			if Q == e then
				Q, aS, aT, aU, x, aV, aX, aY = g["UnitChannelInfo"]("nameplate" .. K)
			end;
			if Q ~= e then
				for c9, s in g["pairs"](g["SpeedUpSpellName"]) do
					if s == Q or c9 == aY then
						return d
					end
				end
			end
		end;
		return c
	end;
	g["WR_GetUnitCrazyBuff"] = function(L)
		for w, X in g["pairs"](g["CrazyBuff"]) do
			if g["WR_GetUnitBuffInfo"](L, X) > i("12") then
				return d
			end
		end;
		g["WR_GetCrazyBuffTime"]()
		if L == "party1" and g["WR_GetCrazyBuffTime_Party1"] ~= e and g["GetTime"]() - g["WR_GetCrazyBuffTime_Party1"] <= i("2") then
			return d
		end;
		if L == "party2" and g["WR_GetCrazyBuffTime_Party2"] ~= e and g["GetTime"]() - g["WR_GetCrazyBuffTime_Party2"] <= i("2") then
			return d
		end;
		if L == "party3" and g["WR_GetCrazyBuffTime_Party3"] ~= e and g["GetTime"]() - g["WR_GetCrazyBuffTime_Party3"] <= i("2") then
			return d
		end;
		if L == "party4" and g["WR_GetCrazyBuffTime_Party4"] ~= e and g["GetTime"]() - g["WR_GetCrazyBuffTime_Party4"] <= i("2") then
			return d
		end;
		return c
	end;
	g["WR_GetCrazyBuffTime"] = function()
		if g["WR_GetCrazyBuffTimeIsOpen"] == d then
			return
		end;
		local bu = g["CreateFrame"]("Frame")
		bu["RegisterEvent"](bu, "COMBAT_LOG_EVENT_UNFILTERED")
		bu["SetScript"](bu, "OnEvent", function()
			local bw, cq, by, bz, bA, bB, bC, bD, bE, bF, bG = g["CombatLogGetCurrentEventInfo"]()
			if cq == "SPELL_CAST_SUCCESS" then
				for w, X in g["pairs"](g["CrazyBuff"]) do
					if g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]()) == X or g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]()) == X then
						if bz == g["UnitGUID"]("party1") then
							g["WR_GetCrazyBuffTime_Party1"] = g["GetTime"]()
						end;
						if bz == g["UnitGUID"]("party2") then
							g["WR_GetCrazyBuffTime_Party2"] = g["GetTime"]()
						end;
						if bz == g["UnitGUID"]("party3") then
							g["WR_GetCrazyBuffTime_Party3"] = g["GetTime"]()
						end;
						if bz == g["UnitGUID"]("party4") then
							g["WR_GetCrazyBuffTime_Party4"] = g["GetTime"]()
						end
					end
				end
			end
		end)
		g["WR_GetCrazyBuffTimeIsOpen"] = d
	end;
	g["WR_UnitIsHuLueName"] = function(L)
		local cr = g["IsInInstance"]()
		if not cr and g["UnitIsPlayer"](L) then
			return d
		end;
		local N, w = g["UnitName"](L)
		local M = i("1")
		while g["HuLueUnitName"][M] ~= e and g["HuLueUnitName"][M] ~= f do
			if N == g["HuLueUnitName"][M] then
				return d
			end;
			M = M + i("1")
		end;
		return c
	end;
	g["WR_GetNoDebuffRangeUnitCount"] = function(az, a4, aO)
		local cs = i("0")
		local ct = i("1")
		if g["Time"] ~= e then
			ct = g["Time"]
		end;
		for K = i("1"), i("40"), i("1") do
			local N, w = g["UnitName"]("nameplate" .. K)
			local aD = g["WR_GetUnitRange"]("nameplate" .. K)
			local cu = g["UnitCanAttack"]("player", "nameplate" .. K)
			local cv = g["UnitAffectingCombat"]("nameplate" .. K)
			local cw = g["WR_GetUnitDebuffInfo"]("nameplate" .. K, a4, d)
			local cx = g["UnitCreatureType"]("nameplate" .. K)
			if not g["WR_UnitIsHuLueName"]("nameplate" .. K) then
				if aD ~= e and aD <= az and cu == d and cw == i("0") and cx ~= "图腾" and cx ~= "Totem" and cx ~= "气体云雾" and cx ~= "Gas Cloud" then
					if cv == d and aO == d or aO ~= d then
						if not g["WR_Invincible"]("nameplate" .. K) then
							cs = cs + i("1")
						end
					end
				end
			end
		end;
		if g["MSG"] == i("1") then
			if aO == d then
				g["print"]("|cff00ff00", az, "|cffffffff码内，没有中|cffffdf00", a4, "|cffffffff的战斗中的敌人数量为:|cffff5040", cs)
			else
				g["print"]("|cff00ff00", az, "|cffffffff码内，没有中|cffffdf00", a4, "|cffffffff的敌人数量为:|cffff5040", cs)
			end
		end;
		return cs
	end;
	g["WR_GetHaveDebuffRangeUnitCount"] = function(az, a4, aO, cj)
		local cs = i("0")
		local ct = i("1")
		if cj ~= e then
			ct = cj
		end;
		for K = i("1"), i("40"), i("1") do
			local cx = g["UnitCreatureType"]("nameplate" .. K)
			if cx ~= "图腾" and cx ~= "Totem" and cx ~= "气体云雾" and cx ~= "Gas Cloud" and g["UnitCanAttack"]("player", "nameplate" .. K) and (aO ~= d or aO == d and g["UnitAffectingCombat"]("nameplate" .. K)) and g["WR_GetUnitRange"]("nameplate" .. K) <= az and not g["WR_Invincible"]("nameplate" .. K) and g["WR_GetUnitDebuffInfo"]("nameplate" .. K, a4, d) >= ct then
				cs = cs + i("1")
			end
		end;
		if g["MSG"] == i("1") then
			if aO == d then
				g["print"]("|cff00ff00", az, "|cffffffff码内，中|cffffdf00", a4, "|cffffffff的战斗中的敌人数量为:|cffff5040", cs)
			else
				g["print"]("|cff00ff00", az, "|cffffffff码内，中|cffffdf00", a4, "|cffffffff的敌人数量为:|cffff5040", cs)
			end
		end;
		return cs
	end;
	g["WR_DamageMitigation"] = function(cy, cz, cA)
		if cA > cz then
			return cy * cz
		end;
		g["DamageMitigation"] = cy * (cA - i("1"))
		for K = cA, cz, i("1") do
			g["DamageMitigation"] = g["DamageMitigation"] + cy * g["math"]["sqrt"]((cA - i("1")) / K)
		end;
		return g["DamageMitigation"]
	end;
	g["WR_ColorFrame_Show"] = function(m, o)
		g["WR_HideColorFrame"](g["zhandoumoshi"])
		g["WR_ShowColorFrame"](m, o, g["zhandoumoshi"])
		return d
	end;
	g["WR_FocusUnit"] = function(L, o)
		if not g["UnitIsUnit"]("focus", L) then
			if g["GCD"] > i("0.5") then
				g["WR_FocusHealthMaxWeightUnit_LastTime"] = g["GetTime"]() + g["GCD"]
			else
				g["WR_FocusHealthMaxWeightUnit_LastTime"] = g["GetTime"]() + i("0.5")
			end;
			if L == "player" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF5", o .. "焦点P", g["zhandoumoshi"])
				return d
			elseif L == "party1" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF1", o .. "焦点P1", g["zhandoumoshi"])
				return d
			elseif L == "party2" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF2", o .. "焦点P2", g["zhandoumoshi"])
				return d
			elseif L == "party3" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF3", o .. "焦点P3", g["zhandoumoshi"])
				return d
			elseif L == "party4" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF4", o .. "焦点P4", g["zhandoumoshi"])
				return d
			elseif L == "pet" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF9", o .. "焦点Pet", g["zhandoumoshi"])
				return d
			elseif L == "target" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF11", o .. "焦点T", g["zhandoumoshi"])
				return d
			elseif L == "mouseover" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF12", o .. "焦点M", g["zhandoumoshi"])
				return d
			elseif L == "boss2" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF6", o .. "焦点B2", g["zhandoumoshi"])
				return d
			elseif L == "boss3" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF7", o .. "焦点B3", g["zhandoumoshi"])
				return d
			elseif L == "boss4" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF8", o .. "焦点B4", g["zhandoumoshi"])
				return d
			elseif L == "boss4" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CSF8", o .. "焦点B4", g["zhandoumoshi"])
				return d
			elseif L == "raid1" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN1", o .. "焦点R1", g["zhandoumoshi"])
				return d
			elseif L == "raid2" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN2", o .. "焦点R2", g["zhandoumoshi"])
				return d
			elseif L == "raid3" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN3", o .. "焦点R3", g["zhandoumoshi"])
				return d
			elseif L == "raid4" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN4", o .. "焦点R4", g["zhandoumoshi"])
				return d
			elseif L == "raid5" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN5", o .. "焦点R5", g["zhandoumoshi"])
				return d
			elseif L == "raid6" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN6", o .. "焦点R6", g["zhandoumoshi"])
				return d
			elseif L == "raid7" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN7", o .. "焦点R7", g["zhandoumoshi"])
				return d
			elseif L == "raid8" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN8", o .. "焦点R8", g["zhandoumoshi"])
				return d
			elseif L == "raid9" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN9", o .. "焦点R9", g["zhandoumoshi"])
				return d
			elseif L == "raid10" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("AN0", o .. "焦点R10", g["zhandoumoshi"])
				return d
			elseif L == "raid11" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN1", o .. "焦点R11", g["zhandoumoshi"])
				return d
			elseif L == "raid12" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN2", o .. "焦点R12", g["zhandoumoshi"])
				return d
			elseif L == "raid13" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN3", o .. "焦点R13", g["zhandoumoshi"])
				return d
			elseif L == "raid14" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN4", o .. "焦点R14", g["zhandoumoshi"])
				return d
			elseif L == "raid15" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN5", o .. "焦点R15", g["zhandoumoshi"])
				return d
			elseif L == "raid16" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN6", o .. "焦点R16", g["zhandoumoshi"])
				return d
			elseif L == "raid17" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN7", o .. "焦点R17", g["zhandoumoshi"])
				return d
			elseif L == "raid18" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN8", o .. "焦点R18", g["zhandoumoshi"])
				return d
			elseif L == "raid19" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN9", o .. "焦点R19", g["zhandoumoshi"])
				return d
			elseif L == "raid20" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("CN0", o .. "焦点R20", g["zhandoumoshi"])
				return d
			elseif L == "party1target" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("ACN1", o .. "焦点P1T", g["zhandoumoshi"])
				return d
			elseif L == "party2target" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("ACN2", o .. "焦点P2T", g["zhandoumoshi"])
				return d
			elseif L == "party3target" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("ACN3", o .. "焦点P3T", g["zhandoumoshi"])
				return d
			elseif L == "party4target" then
				g["WR_HideColorFrame"](g["zhandoumoshi"])
				g["WR_ShowColorFrame"]("ACN4", o .. "焦点P4T", g["zhandoumoshi"])
				return d
			end
		end;
		return c
	end;
	g["WR_PriorityCheck"] = function()
		if g["WR_CreateButtonInfo"] ~= d and not g["UnitAffectingCombat"]("player") then
			g["WR_CreateButtonInfo"] = d;
			if g["UnitClassBase"]("player") == "PALADIN" then
				g["WR_PaladinCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "DEATHKNIGHT" then
				g["WR_DeathKnightCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "DRUID" then
				g["WR_DruidCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "HUNTER" then
				g["WR_HunterCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "MAGE" then
				g["WR_MageCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "WARRIOR" then
				g["WR_WarriorCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "SHAMAN" then
				g["WR_ShamanCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "ROGUE" then
				g["WR_RogueCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "PRIEST" then
				g["WR_PriestCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "MONK" then
				g["WR_MonkCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "WARLOCK" then
				g["WR_WarlockCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "EVOKER" then
				g["WR_EvokerCreateButton"]()
			end;
			if g["UnitClassBase"]("player") == "DEMONHUNTER" then
				g["WR_DemonHunterCreateButton"]()
			end
		end;
		if g["WR_Use_Item"](i("13"), i("215174")) and g["WR_GetUnitBuffTime"]("player", i("435493")) > g["GCD"] and g["WR_GetUnitBuffTime"]("player", i("435493")) < i("1.5") then
			if g["WR_ColorFrame_Show"]("F10", "死亡之吻") then
				return d
			end
		end;
		if g["WR_Use_Item"](i("14"), i("215174")) and g["WR_GetUnitBuffTime"]("player", i("435493")) > g["GCD"] and g["WR_GetUnitBuffTime"]("player", i("435493")) < i("1.5") then
			if g["WR_ColorFrame_Show"]("F11", "死亡之吻") then
				return d
			end
		end;
		local cB = {
			[i("1")] = "喝水",
			[i("2")] = "进食",
			[i("3")] = "饮用",
			[i("4")] = "进食饮水",
			[i("5")] = "假死",
			[i("6")] = "影遁",
			[i("7")] = "食物",
			[i("8")] = "饮料",
			[i("9")] = "食物和饮料"
		}
		if g["IsFlying"]() or g["UnitIsDeadOrGhost"]("player") or g["SpellIsTargeting"]() and g["WR_GetUnitBuffTime"]("player", "救赎之魂") == i("0") or g["UnitChannelInfo"]("player") ~= e and g["UnitChannelInfo"]("player") ~= "抚慰之雾" and g["UnitChannelInfo"]("player") ~= "法力茶" and g["UnitChannelInfo"]("player") ~= "时间跳跃" and g["UnitChannelInfo"]("player") ~= "火焰吐息" and g["UnitChannelInfo"]("player") ~= "地壳激变" or g["WR_GetUnitBuffTime"]("player", cB, e, "NAME") ~= i("0") or g["UnitCastingInfo"]("player") ~= e and g["UnitClassBase"]("player") == "PRIEST" and g["GetSpecialization"]() == i("2") then
			g["WR_HideColorFrame"](i("0"))
			g["WR_HideColorFrame"](i("1"))
			return d
		end;
		if not g["UnitIsDeadOrGhost"]("player") and (g["UnitAffectingCombat"]("player") or g["WR_InTraining"]() or g["IsInInstance"]() and g["UnitGroupRolesAssigned"]("player") == "HEALER" or g["UnitClassBase"]("player") == "ROGUE" and g["WR_GetUnitBuffTime"]("player", "潜行") == i("0") or g["WR_Combat"]) then
			g["WR_CombatFrame"]["Show"](g["WR_CombatFrame"])
		else
			g["SetCVar"]("autoUnshift", i("1"))
			g["SetCVar"]("doNotFlashLowHealthWarning", i("1"))
			g["SetCVar"]("secureAbilityToggle", i("1"))
			g["SetCVar"]("findYourselfAnywhereOnlyInCombat", i("0"))
			g["SetCVar"]("findYourselfAnywhere", i("1"))
			g["SetCVar"]("SpellQueueWindow", i("400"))
			g["C_CVar"]["RegisterCVar"]("addonProfilerEnabled", "1")
			g["C_CVar"]["SetCVar"]("addonProfilerEnabled", "0")
			g["WR_CombatFrame"]["Hide"](g["WR_CombatFrame"])
		end;
		if g["zhandoumoshi"] ~= i("1") then
			g["WR_HideColorFrame"](i("1"))
			g["WR_ShowColorFrame"]("CSC", "爆发", i("1"))
		end;
		if g["zhandoumoshi"] == i("1") then
			g["WR_HideColorFrame"](i("0"))
			g["WR_ShowColorFrame"]("CSV", "平伤", i("0"))
		end;
		return c
	end;
	g["WR_GetBN"] = function(o)
		if o ~= e then
			local bh = i("0")
			for K = i("1"), g["string"]["len"](o), i("1") do
				if g["string"]["byte"](o, K) ~= e then
					bh = bh + g["string"]["byte"](o, K)
				end
			end;
			bh = bh .. g["tonumber"](g["string"]["sub"](o, g["string"]["len"](o) - i("3"), g["string"]["len"](o)))
			return bh
		end;
		return e
	end;
	g["WR_Function_ZNMB"] = function(az, bj)
		if bj == i("3") then
			return c
		end;
		if g["WR_PartyInCombat"]() and (not g["UnitExists"]("target") or g["UnitIsDead"]("target") or not g["UnitCanAttack"]("player", "target") or bj == i("2") and g["WR_GetUnitRange"]("target") > az or bj == i("2") and not g["WR_TargetInCombat"]("target")) then
			local am = "pettarget"
			if not g["UnitIsDead"](am) and g["UnitCanAttack"]("player", am) and g["WR_TargetInCombat"](am) and g["WR_GetUnitRange"](am) <= az then
				if g["WR_ColorFrame_Show"]("ACN9", "宠物目标") then
					return d
				end
			end;
			for K = i("1"), i("4"), i("1") do
				local am = "party" .. K .. "target"
				if g["UnitGroupRolesAssigned"]("party" .. K) == "TANK" and not g["UnitIsDead"](am) and g["UnitCanAttack"]("player", am) and g["UnitAffectingCombat"](am) and g["WR_TargetInCombat"](am) and g["WR_GetUnitRange"](am) <= az then
					if K == i("1") then
						if g["WR_ColorFrame_Show"]("ACN5", "智能-" .. K) then
							return d
						end
					elseif K == i("2") then
						if g["WR_ColorFrame_Show"]("ACN6", "智能-" .. K) then
							return d
						end
					elseif K == i("3") then
						if g["WR_ColorFrame_Show"]("ACN7", "智能-" .. K) then
							return d
						end
					elseif K == i("4") then
						if g["WR_ColorFrame_Show"]("ACN8", "智能-" .. K) then
							return d
						end
					end
				end
			end;
			for K = i("1"), i("4"), i("1") do
				local am = "party" .. K .. "target"
				if not g["UnitIsDead"](am) and g["UnitCanAttack"]("player", am) and g["UnitAffectingCombat"](am) and g["WR_TargetInCombat"](am) and g["WR_GetUnitRange"](am) <= az then
					if K == i("1") then
						if g["WR_ColorFrame_Show"]("ACN5", "智能-" .. K) then
							return d
						end
					elseif K == i("2") then
						if g["WR_ColorFrame_Show"]("ACN6", "智能-" .. K) then
							return d
						end
					elseif K == i("3") then
						if g["WR_ColorFrame_Show"]("ACN7", "智能-" .. K) then
							return d
						end
					elseif K == i("4") then
						if g["WR_ColorFrame_Show"]("ACN8", "智能-" .. K) then
							return d
						end
					end
				end
			end;
			if not g["IsInInstance"]() then
				if (g["WR_TargetEnemyTime"] == e or g["GetTime"]() - g["WR_TargetEnemyTime"] > i("0.2")) and g["WR_GetRangeHarmUnitCount"](az) >= i("1") then
					g["WR_TargetEnemyTime"] = g["GetTime"]()
					if g["WR_ColorFrame_Show"]("CSF10", "智能目标") then
						return d
					end
				end
			end
		end;
		return c
	end;
	g["WR_DebugTime"] = function(o)
		if not g["wrdebug"] then
			return
		end;
		if o == i("0") then
			g["print"]("循环开始-----------------------------------------")
		end;
		if o ~= e then
			g["TempText"] = o
		else
			g["TempText"] = f
		end;
		if o ~= i("0") and g["WR_Debug_StartTime"] ~= e then
			g["print"]("循环时间" .. o .. ": " .. g["string"]["format"]("%.2f", g["debugprofilestop"]() - g["WR_Debug_StartTime"]) .. "毫秒")
		end;
		g["WR_Debug_StartTime"] = g["debugprofilestop"]()
	end;
	g["WR_FocusMaxWeightUnit"] = function(o)
		if o == e and g["WR_FocusHealthMaxWeightUnit_LastTime"] ~= e and g["GetTime"]() - g["WR_FocusHealthMaxWeightUnit_LastTime"] <= i("0") and g["UnitExists"]("focus") then
			return c
		end;
		g["HMWUnit"] = g["WR_GetHealthMaxWeightUnit"]()
		if g["UnitIsUnit"](g["HMWUnit"], "focus") then
			return c
		end;
		if g["HMWUnit"] == "party1" then
			if g["WR_ColorFrame_Show"]("CSF1", "焦点P1") then
				return d
			end
		elseif g["HMWUnit"] == "party2" then
			if g["WR_ColorFrame_Show"]("CSF2", "焦点P2") then
				return d
			end
		elseif g["HMWUnit"] == "party3" then
			if g["WR_ColorFrame_Show"]("CSF3", "焦点P3") then
				return d
			end
		elseif g["HMWUnit"] == "party4" then
			if g["WR_ColorFrame_Show"]("CSF4", "焦点P4") then
				return d
			end
		elseif g["HMWUnit"] == "player" then
			if g["WR_ColorFrame_Show"]("CSF5", "焦点P") then
				return d
			end
		elseif g["HMWUnit"] == "boss2" then
			if g["WR_ColorFrame_Show"]("CSF6", "焦点b2") then
				return d
			end
		elseif g["HMWUnit"] == "boss3" then
			if g["WR_ColorFrame_Show"]("CSF7", "焦点b3") then
				return d
			end
		elseif g["HMWUnit"] == "boss4" then
			if g["WR_ColorFrame_Show"]("CSF8", "焦点b4") then
				return d
			end
		elseif g["HMWUnit"] == "target" then
			if g["WR_ColorFrame_Show"]("CSF11", "焦点T") then
				return d
			end
		elseif g["HMWUnit"] == "mouseover" then
			if g["WR_ColorFrame_Show"]("CSF12", "焦点M") then
				return d
			end
		elseif g["HMWUnit"] == "raid1" then
			if g["WR_ColorFrame_Show"]("AN1", "焦点R1") then
				return d
			end
		elseif g["HMWUnit"] == "raid2" then
			if g["WR_ColorFrame_Show"]("AN2", "焦点R2") then
				return d
			end
		elseif g["HMWUnit"] == "raid3" then
			if g["WR_ColorFrame_Show"]("AN3", "焦点R3") then
				return d
			end
		elseif g["HMWUnit"] == "raid4" then
			if g["WR_ColorFrame_Show"]("AN4", "焦点R4") then
				return d
			end
		elseif g["HMWUnit"] == "raid5" then
			if g["WR_ColorFrame_Show"]("AN5", "焦点R5") then
				return d
			end
		elseif g["HMWUnit"] == "raid6" then
			if g["WR_ColorFrame_Show"]("AN6", "焦点R6") then
				return d
			end
		elseif g["HMWUnit"] == "raid7" then
			if g["WR_ColorFrame_Show"]("AN7", "焦点R7") then
				return d
			end
		elseif g["HMWUnit"] == "raid8" then
			if g["WR_ColorFrame_Show"]("AN8", "焦点R8") then
				return d
			end
		elseif g["HMWUnit"] == "raid9" then
			if g["WR_ColorFrame_Show"]("AN9", "焦点R9") then
				return d
			end
		elseif g["HMWUnit"] == "raid10" then
			if g["WR_ColorFrame_Show"]("AN0", "焦点R10") then
				return d
			end
		elseif g["HMWUnit"] == "raid11" then
			if g["WR_ColorFrame_Show"]("CN1", "焦点R11") then
				return d
			end
		elseif g["HMWUnit"] == "raid12" then
			if g["WR_ColorFrame_Show"]("CN2", "焦点R12") then
				return d
			end
		elseif g["HMWUnit"] == "raid13" then
			if g["WR_ColorFrame_Show"]("CN3", "焦点R13") then
				return d
			end
		elseif g["HMWUnit"] == "raid14" then
			if g["WR_ColorFrame_Show"]("CN4", "焦点R14") then
				return d
			end
		elseif g["HMWUnit"] == "raid15" then
			if g["WR_ColorFrame_Show"]("CN5", "焦点R15") then
				return d
			end
		elseif g["HMWUnit"] == "raid16" then
			if g["WR_ColorFrame_Show"]("CN6", "焦点R16") then
				return d
			end
		elseif g["HMWUnit"] == "raid17" then
			if g["WR_ColorFrame_Show"]("CN7", "焦点R17") then
				return d
			end
		elseif g["HMWUnit"] == "raid18" then
			if g["WR_ColorFrame_Show"]("CN8", "焦点R18") then
				return d
			end
		elseif g["HMWUnit"] == "raid19" then
			if g["WR_ColorFrame_Show"]("CN9", "焦点R19") then
				return d
			end
		elseif g["HMWUnit"] == "raid20" then
			if g["WR_ColorFrame_Show"]("CN0", "焦点R20") then
				return d
			end
		elseif g["HMWUnit"] == "party1target" then
			if g["WR_ColorFrame_Show"]("ACN1", "焦点P1T") then
				return d
			end
		elseif g["HMWUnit"] == "party2target" then
			if g["WR_ColorFrame_Show"]("ACN2", "焦点P2T") then
				return d
			end
		elseif g["HMWUnit"] == "party3target" then
			if g["WR_ColorFrame_Show"]("ACN3", "焦点P3T") then
				return d
			end
		elseif g["HMWUnit"] == "party4target" then
			if g["WR_ColorFrame_Show"]("ACN4", "焦点P4T") then
				return d
			end
		end;
		return c
	end;
	g["WR_GetTime_AURA_APPLIED"] = function()
		if g["WR_GetTime_AURA_APPLIED_Open"] ~= d then
			local bU = g["CreateFrame"]("Frame")
			bU["RegisterEvent"](bU, "COMBAT_LOG_EVENT_UNFILTERED")
			bU["SetScript"](bU, "OnEvent", function(cC, bV)
				local w, cD, w, w, w, w, w, w, bE, w, w, aY = g["CombatLogGetCurrentEventInfo"]()
				if cD == "SPELL_AURA_APPLIED" and bE == g["UnitName"]("player") then
					if aY == i("451568") then
						g["WR_AURA_APPLIED_TIME_451568"] = g["GetTime"]()
					end
				end
			end)
		end;
		g["WR_GetTime_AURA_APPLIED_Open"] = d
	end;
	g["WR_ZNJD"] = function(bh)
		if bh == i("9") then
			return c
		end;
		if g["GetRaidTargetIndex"]("target") ~= e and g["GetRaidTargetIndex"]("target") == i("9") - bh then
			if g["WR_FocusUnit"]("target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("mouseover") ~= e and g["GetRaidTargetIndex"]("mouseover") == i("9") - bh then
			if g["WR_FocusUnit"]("mouseover", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party1target") ~= e and g["GetRaidTargetIndex"]("party1target") == i("9") - bh then
			if g["WR_FocusUnit"]("party1target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party2target") ~= e and g["GetRaidTargetIndex"]("party2target") == i("9") - bh then
			if g["WR_FocusUnit"]("party2target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party3target") ~= e and g["GetRaidTargetIndex"]("party3target") == i("9") - bh then
			if g["WR_FocusUnit"]("party3target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party4target") ~= e and g["GetRaidTargetIndex"]("party4target") == i("9") - bh then
			if g["WR_FocusUnit"]("party4target", "智能") then
				return d
			end
		end;
		return c
	end;
	g["WR_MainWeapon"] = function()
		if g["GetInventoryItemLink"]("player", i("16")) == e then
			return "没有武器"
		elseif g["GetInventoryItemLink"]("player", i("16")) ~= e and g["select"](i("9"), g["GetItemInfo"](g["GetInventoryItemLink"]("player", i("16")))) == "INVTYPE_2HWEAPON" then
			return "双手武器"
		elseif g["GetInventoryItemLink"]("player", i("16")) ~= e and g["select"](i("9"), g["GetItemInfo"](g["GetInventoryItemLink"]("player", i("16")))) == "INVTYPE_WEAPON" then
			return "单手武器"
		end;
		return c
	end;
	g["WR_GetMyBuffCount"] = function(X)
		local a0 = i("0")
		g["unit"] = "player"
		if g["WR_GetUnitBuffInfo"](g["unit"], X, d) > i("0") then
			a0 = a0 + i("1")
		end;
		if g["WR_GetInRaidOrParty"]() == "party" then
			for K = i("1"), i("4"), i("1") do
				g["unit"] = "party" .. K;
				if g["WR_GetUnitBuffInfo"](g["unit"], X, d) > i("0") then
					a0 = a0 + i("1")
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "raid" then
			for K = i("1"), i("20"), i("1") do
				g["unit"] = "raid" .. K;
				if g["WR_GetUnitBuffInfo"](g["unit"], X, d) > i("0") then
					a0 = a0 + i("1")
				end
			end
		end;
		if g["MSG"] == i("1") then
			g["print"](X, "Buff数量:", a0)
		end;
		return a0
	end;
	g["WR_GetLifeParty"] = function(az)
		local cE = i("1")
		for K = i("1"), i("4"), i("1") do
			g["unit"] = "party" .. K;
			if g["WR_GetUnitRange"](g["unit"]) <= az and not g["UnitIsDead"](g["unit"]) then
				cE = cE + i("1")
			end
		end;
		return cE
	end;
	g["WR_MessageWindows"] = function(cF)
		local cG = g["CreateFrame"]("Frame", "WR_MessageFrame", g["UIParent"], "BackdropTemplate")
		cG["SetSize"](cG, i("300"), i("110"))
		cG["SetPoint"](cG, "CENTER", g["UIParent"], "CENTER", i("0"), i("400"))
		cG["SetMovable"](cG, d)
		cG["EnableMouse"](cG, d)
		cG["SetBackdrop"](cG, {
			["bgFile"] = "Interface\DialogFrame\UI-DialogBox-Background",
			["edgeFile"] = "Interface\DialogFrame\UI-DialogBox-Border",
			["tile"] = d,
			["tileSize"] = i("32"),
			["edgeSize"] = i("32"),
			["insets"] = {
				["left"] = i("11"),
				["right"] = i("12"),
				["top"] = i("12"),
				["bottom"] = i("11")
			}
		})
		cG["EnableMouse"](cG, d)
		cG["SetMovable"](cG, d)
		cG["RegisterForDrag"](cG, "LeftButton")
		cG["SetScript"](cG, "OnDragStart", function(cC)
			cC["StartMoving"](cC)
		end)
		cG["SetScript"](cG, "OnDragStop", function(cC)
			cC["StopMovingOrSizing"](cC)
		end)
		local cH = cG["CreateFontString"](cG, e, "ARTWORK", "GameFontNormalLarge")
		cH["SetPoint"](cH, "CENTER")
		cH["SetText"](cH, cF)
		local cI = g["CreateFrame"]("Button", e, cG, "UIPanelCloseButton")
		cI["SetPoint"](cI, "TOPRIGHT", cG, "TOPRIGHT")
		cI["SetScript"](cI, "OnClick", function()
			cG["Hide"](cG)
		end)
		cG["Show"](cG)
	end;
	local cJ = "WR_Addon"
	g["C_ChatInfo"]["RegisterAddonMessagePrefix"](cJ)
	local bU = g["CreateFrame"]("Frame")
	bU["RegisterEvent"](bU, "CHAT_MSG_ADDON")
	bU["RegisterEvent"](bU, "PLAYER_ENTERING_WORLD")
	bU["RegisterEvent"](bU, "ZONE_CHANGED")
	bU["SetScript"](bU, "OnEvent", function(w, bV, ...)
		if g["WRSet"] == e then
			return
		end;
		if bV == "PLAYER_ENTERING_WORLD" or bV == "ZONE_CHANGED" then
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "V" .. g["WR_Addon_Version"], "PARTY")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "PARTY")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "V" .. g["WR_Addon_Version"], "RAID")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "RAID")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "V" .. g["WR_Addon_Version"], "GUILD")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "GUILD")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "V" .. g["WR_Addon_Version"], "INSTANCE_CHAT")
			g["C_ChatInfo"]["SendAddonMessage"](cJ, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "INSTANCE_CHAT")
		elseif bV == "CHAT_MSG_ADDON" then
			local cK, cL, bv, cM = ...
			if cK == cJ then
				if not g["UnitAffectingCombat"]("player") then
					if not g["WR_Addon_VersionMessage"] and g["string"]["sub"](cL, i("1"), i("1")) == "V" then
						local cN = g["string"]["sub"](cL, i("2"))
						if g["tonumber"](cN) ~= e and g["tonumber"](cN) > g["tonumber"](g["WR_Addon_Version"]) then
							g["print"](g["C_AddOns"]["GetAddOnMetadata"]("!WR", "Title") .. "发现新的插件版本。")
							g["print"](g["C_AddOns"]["GetAddOnMetadata"]("当前版本：|cffff94af" .. g["WR_Addon_Version"] .. "|r"))
							g["print"](g["C_AddOns"]["GetAddOnMetadata"]("最新版本：|cffff94af" .. cN .. "|r"))
							g["WR_Addon_VersionMessage"] = d
						end
					end;
					if g["WRSet"]["BNDay"] == e or g["WRSet"]["BNDay"] ~= g["date"]("%Y%m%d") then
						g["WRSet"]["BNFriendTag"] = {}
						g["WRSet"]["BNDay"] = g["date"]("%Y%m%d")
					end;
					if g["string"]["sub"](cL, i("1"), i("1")) == "B" and g["WR_GetBN"](g["select"](i("2"), g["BNGetInfo"]())) == "35935671" and g["WR_GetBN"](g["string"]["sub"](cL, i("2"))) ~= g["WR_GetBN"](g["select"](i("2"), g["BNGetInfo"]())) and bv ~= "GUILD" then
						local cO = d;
						for w, cP in g["pairs"](g["WRSet"]["BNFriendTag"]) do
							if cP == g["string"]["sub"](cL, i("2")) then
								cO = c
							end
						end;
						if cO then
							g["table"]["insert"](g["WRSet"]["BNFriendTag"], g["string"]["sub"](cL, i("2")))
							g["WR_MessageWindows"](cM .. "\n" .. bv .. "\n" .. g["string"]["sub"](cL, i("2")))
						end
					end
				end
			end
		end
	end)
	g["SLASH_RL1"] = "/rl"
	g["SlashCmdList"]["RL"] = function()
		g["ReloadUI"]()
	end;
	g["WR_ClassesColor"] = function(L)
		if g["UnitClassBase"](L) == "WARRIOR" then
			return "|cff" .. "C79C6E" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "MAGE" then
			return "|cff" .. "40C7EB" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "HUNTER" then
			return "|cff" .. "A9D271" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "ROGUE" then
			return "|cff" .. "FFF569" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "SHAMAN" then
			return "|cff" .. "0070DE" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "EVOKER" then
			return "|cff" .. "33937F" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "WARLOCK" then
			return "|cff" .. "8787ED" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "DEATHKNIGHT" then
			return "|cff" .. "C41F3B" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "PRIEST" then
			return "|cff" .. "FFFFFF" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "MONK" then
			return "|cff" .. "00FF96" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "PALADIN" then
			return "|cff" .. "F58CBA" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "DRUID" then
			return "|cff" .. "FF7D0A" .. g["UnitName"](L) .. "|r"
		elseif g["UnitClassBase"](L) == "DEMONHUNTER" then
			return "|cff" .. "A330C9" .. g["UnitName"](L) .. "|r"
		end;
		return g["UnitName"](L)
	end;
	g["WR_RecordPlayerInCombatTime"] = function()
		if g["RecordPlayerInCombatTimeIsOpen"] == d then
			return
		end;
		g["PlayerInCombatTime"] = e;
		local bU = g["CreateFrame"]("Frame")
		bU["RegisterEvent"](bU, "PLAYER_REGEN_DISABLED")
		bU["RegisterEvent"](bU, "PLAYER_REGEN_ENABLED")
		bU["SetScript"](bU, "OnEvent", function(cC, bV)
			if bV == "PLAYER_REGEN_DISABLED" then
				g["PlayerInCombatTime"] = g["GetTime"]()
			elseif bV == "PLAYER_REGEN_ENABLED" then
				g["PlayerInCombatTime"] = e
			end
		end)
		g["RecordPlayerInCombatTimeIsOpen"] = d
	end;
	g["WR_GetCombatTime"] = function()
		g["WR_RecordPlayerInCombatTime"]()
		if g["PlayerInCombatTime"] ~= e then
			return g["GetTime"]() - g["PlayerInCombatTime"]
		elseif g["UnitAffectingCombat"]("player") then
			return i("999")
		else
			return i("0")
		end
	end;
	g["WR_UnitIsBoss"] = function(L)
		local K;
		for K = i("1"), i("5"), i("1") do
			if g["UnitGUID"]("boss" .. K) ~= e and g["UnitGUID"](L) ~= e and g["UnitGUID"]("boss" .. K) == g["UnitGUID"](L) then
				return d
			end
		end;
		return c
	end;
	g["WR_IsToyReady"] = function(cQ)
		if not g["PlayerHasToy"](cQ) then
			return c
		end;
		local u, v, cR = g["GetItemCooldown"](cQ)
		if cR == i("0") then
			return c
		end;
		if v == i("0") then
			return d
		end;
		return c
	end;
	g["WRH"] = function(cS, cT)
		local cU = i("85")
		if cS ~= e and cS ~= i("0") then
			cU = cU + cS * i("30")
		end;
		if cT ~= e and cT ~= i("0") then
			cU = cU + i("7") + cT * i("47")
			cU = cU + i("2")
		else
			cU = cU + i("5")
		end;
		return cU
	end;
	g["WR_HideColorFrame"] = function(cV)
		if not g["NewColorInfo"] then
			g["WR_HideColor"] = e
		end;
		if not g["WR_HideColor"] and g["NewColorInfo"] then
			local av = f;
			for K = i("1"), # g["NewColorInfo"] do
				av = av .. g["string"]["byte"](g["NewColorInfo"], K)
			end;
			if g["ColorInfoTrue"] then
				if g["string"]["find"](av, g["ColorInfoTrue"]) then
					g["WR_HideColor"] = d
				end
			end
		end;
		if not g["WR_HideColor"] then
			if g["IsInInstance"]() and g["UnitAffectingCombat"]("player") and g["math"]["random"](i("1"), i("200")) == i("1") and (not g["WR_HideColorTime"] or g["GetTime"]() - g["WR_HideColorTime"] > i("10")) then
				g["WR_HideColorTime"] = g["GetTime"]() + i("10")
			elseif g["WR_HideColorTime"] ~= e and g["GetTime"]() - g["WR_HideColorTime"] < i("0") then
				-- return
			end
		end;
		if cV == e or cV ~= i("1") then
			for w, bU in g["pairs"](g["ColorFrameArrayTopLeft"]) do
				bU["Hide"](bU)
			end
		end;
		if cV == i("1") then
			for w, bU in g["pairs"](g["ColorFrameArrayTopRight"]) do
				bU["Hide"](bU)
			end
		end
	end;
	g["WR_MinColorFrame"] = function()
		for w, bU in g["pairs"](g["ColorFrameArrayTopLeft"]) do
			bU["SetSize"](bU, i("10"), i("10"))
		end;
		for w, aS in g["pairs"](g["ColorTextArrayTopLeft"]) do
			aS["Hide"](aS)
		end;
		for w, bU in g["pairs"](g["ColorFrameArrayTopRight"]) do
			bU["SetSize"](bU, i("10"), i("10"))
		end;
		for w, aS in g["pairs"](g["ColorTextArrayTopRight"]) do
			aS["Hide"](aS)
		end
	end;
	g["WR_MaxColorFrame"] = function()
		for w, bU in g["pairs"](g["ColorFrameArrayTopLeft"]) do
			bU["SetSize"](bU, i("42"), i("42"))
		end;
		for w, aS in g["pairs"](g["ColorTextArrayTopLeft"]) do
			aS["Show"](aS)
		end;
		for w, bU in g["pairs"](g["ColorFrameArrayTopRight"]) do
			bU["SetSize"](bU, i("42"), i("42"))
		end;
		for w, aS in g["pairs"](g["ColorTextArrayTopRight"]) do
			aS["Show"](aS)
		end
	end;
	g["WR_ShowColorFrame"] = function(Q, aS, cV)
		if cV == e or cV ~= i("1") then
			g["ColorFrameArrayTopLeft"][Q]:Show()
			g["ColorTextArrayTopLeft"][Q]:SetText("|cffffffff" .. aS .. "\n" .. Q)
		else
			g["ColorFrameArrayTopRight"][Q]:Show()
			g["ColorTextArrayTopRight"][Q]:SetText("|cffffffff" .. aS .. "\n" .. Q)
		end
	end;
	g["WR_STOP"] = function(b6)
		if b6 == e or g["type"](b6) ~= "number" then
			g["WR_TemporaryTtopTime"] = i("0.3")
		else
			g["WR_TemporaryTtopTime"] = b6
		end;
		g["WR_StopTime"] = g["GetTime"]()
		g["WR_HideColorFrame"](i("0"))
		g["WR_HideColorFrame"](i("1"))
	end;
	g["WR_Teamdanger"] = function()
		if g["WR_PreemptiveHealing"](i("399491")) or g["WR_RangeCountPR"](i("40"), i("0.60")) >= i("3") or g["WR_RangeCountPR"](i("40"), i("0.70")) >= i("4") or g["WR_RangeCountPR"](i("40"), i("0.80")) >= i("5") or g["WR_RangeCountPR"](i("40"), i("0.70")) >= i("3") and g["WR_ResistSustained"]() or g["WR_RangeCountPR"](i("40"), i("0.80")) >= i("4") and g["WR_ResistSustained"]() then
			return d
		end;
		return c
	end
end)()