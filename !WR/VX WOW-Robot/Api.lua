local a = 46;
local b = 98;
local c = 0 == 1;
local d = not c;
local e = nil;
local f = ""
local g = _G;
local h = _ENV;
local i = g["tonumber"]
return (function(...)
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
		if g["WR_GetGCD"](y) <= g["GCD"] and g["C_Spell"]["IsSpellUsable"](y) and g["Temp_Number"] ~= e then
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
		return g["WR_GetUnitDebuffTime"](L, g["AssistDebuffName"]) > i("0") or g["WR_GetUnitDebuffTime"](L, g["DangerDebuff"]) > i("0") or g["WR_GetRangeSpellTime"](i("45"), g["OutburstCasting"], L) < i("5")
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
			local W = V["spellId"]
			local R = V["applications"]
			local S = V["dispelName"]
			local X = V["expirationTime"]
			if Q == e then
				break
			end;
			if W == i("440313") or Q == "吞噬裂隙" then
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
			if Q == "时光爆发" and (X - g["GetTime"]() > i("4.5") or g["WR_GetUnitHP"](L) < i("0.8")) then
				U = c
			end;
			if Q == "古怪生长" and X - g["GetTime"]() > i("4") then
				U = c
			end;
			if Q == "提尔之火" and (X - g["GetTime"]() > i("16") or g["WR_GetUnitHP"](L) < i("0.8") or g["UnitCastingInfo"]("boss1") == "裂地打击") then
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
	g["WR_GetUnitBuffInfo"] = function(L, Y, Z, _, a0)
		local a1 = i("0")
		local a2 = i("0")
		local a3 = i("0")
		for K = i("1"), i("255"), i("1") do
			local P = g["C_UnitAuras"]["GetAuraDataByIndex"](L, K, "HELPFUL")
			if not P then
				break
			end;
			if Z and P["sourceUnit"] ~= "player" then
			else
				if g["type"](Y) == "table" then
					for a4, a5 in g["pairs"](Y) do
						if _ == e and (P["name"] == a5 or P["spellId"] == a4) or _ == "NAME" and P["name"] == a5 or _ == "ID" and P["spellId"] == a4 then
							if a1 == i("0") then
								local a6 = g["GetTime"]()
								if P["expirationTime"] > a6 then
									a1 = P["expirationTime"] - a6
								else
									a1 = i("999")
								end;
								if P["applications"] > i("0") then
									a2 = P["applications"]
								else
									a2 = i("1")
								end
							end;
							if not a0 then
								break
							end;
							a3 = a3 + i("1")
						end
					end
				else
					if _ == e and (P["name"] == Y or P["spellId"] == Y) or _ == "NAME" and P["name"] == Y or _ == "ID" and P["spellId"] == Y then
						if a1 == i("0") then
							local a6 = g["GetTime"]()
							if P["expirationTime"] > a6 then
								a1 = P["expirationTime"] - a6
							else
								a1 = i("999")
							end;
							if P["applications"] > i("0") then
								a2 = P["applications"]
							else
								a2 = i("1")
							end
						end;
						if not a0 then
							break
						end;
						a3 = a3 + i("1")
					end
				end
			end
		end;
		if g["Buff_Info"] then
			return a1, a2, a3
		else
			return i("0"), i("0"), i("0")
		end
	end;
	g["WR_GetUnitDebuffInfo"] = function(L, a7, Z, _)
		local a8 = i("0")
		local a9 = i("0")
		for K = i("1"), i("255"), i("1") do
			local V = g["C_UnitAuras"]["GetAuraDataByIndex"](L, K, "HARMFUL")
			if V == e then
				break
			end;
			if Z and V["sourceUnit"] ~= "player" then
			else
				if g["type"](a7) == "table" then
					for aa, ab in g["pairs"](a7) do
						if _ == e and (V["name"] == ab or V["spellId"] == aa) or _ == "NAME" and V["name"] == ab or _ == "ID" and V["spellId"] == aa then
							local a6 = g["GetTime"]()
							if V["expirationTime"] > a6 then
								a8 = V["expirationTime"] - a6
							else
								a8 = i("999")
							end;
							if V["applications"] > i("0") then
								a9 = V["applications"]
							else
								a9 = i("1")
							end;
							break
						end
					end
				else
					if _ == e and (V["name"] == a7 or V["spellId"] == a7) or _ == "NAME" and V["name"] == a7 or _ == "ID" and V["spellId"] == a7 then
						local a6 = g["GetTime"]()
						if V["expirationTime"] > a6 then
							a8 = V["expirationTime"] - a6
						else
							a8 = i("999")
						end;
						if V["applications"] > i("0") then
							a9 = V["applications"]
						else
							a9 = i("1")
						end;
						break
					end
				end
			end
		end;
		if g["Buff_Info"] then
			return a8, a9
		else
			return i("0"), i("0"), i("0")
		end
	end;
	g["WR_GetUnitBuffTime"] = function(L, Y, Z, _)
		return g["select"](i("1"), g["WR_GetUnitBuffInfo"](L, Y, Z, _))
	end;
	g["WR_GetUnitBuffCount"] = function(L, Y, Z, _)
		return g["select"](i("2"), g["WR_GetUnitBuffInfo"](L, Y, Z, _))
	end;
	g["WR_GetUnitBuffSum"] = function(L, Y, Z, _)
		return g["select"](i("3"), g["WR_GetUnitBuffInfo"](L, Y, Z, _, d))
	end;
	g["WR_GetUnitDebuffTime"] = function(L, a7, Z, _)
		return g["select"](i("1"), g["WR_GetUnitDebuffInfo"](L, a7, Z, _))
	end;
	g["WR_GetUnitDebuffCount"] = function(L, a7, Z, _)
		return g["select"](i("2"), g["WR_GetUnitDebuffInfo"](L, a7, Z, _))
	end;
	g["WR_GetHealthMaxWeightUnit"] = function()
		local ac = {
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
		local ad = c;
		local ae = c;
		local af = c;
		local ag = c;
		if g["IsPlayerSpell"](i("527")) == d then
			s = "纯净术"
			ad = d
		end;
		if g["IsPlayerSpell"](i("77130")) == d then
			s = "净化灵魂"
			ad = d
		end;
		if g["IsPlayerSpell"](i("4987")) == d then
			s = "清洁术"
			ad = d
		end;
		if g["IsPlayerSpell"](i("115450")) == d then
			s = "清创生血"
			ad = d
		end;
		if g["IsPlayerSpell"](i("88423")) == d then
			s = "自然之愈"
			ad = d
		end;
		if g["IsPlayerSpell"](i("390632")) == d then
			af = d
		end;
		if g["IsPlayerSpell"](i("383016")) == d then
			ae = d
		end;
		if g["IsPlayerSpell"](i("393024")) == d then
			ag = d;
			af = d
		end;
		if g["IsPlayerSpell"](i("388874")) == d then
			ag = d;
			af = d
		end;
		if g["IsPlayerSpell"](i("392378")) == d then
			ag = d;
			af = d
		end;
		if s == "Nothing" or not g["WR_Good_Info"] then
			return "Nothing"
		else
			if g["HealthMaxWeightUnitload"] ~= d then
				local ah = "本职业驱散法术为: |cff0cbd0c" .. s .. "|cffffffff，当前天赋可驱散: "
				if ad == d then
					ah = ah .. "|cff00adf0魔法 "
				end;
				if ae == d then
					ah = ah .. "|cffffdf00诅咒 "
				end;
				if af == d then
					ah = ah .. "|cffff5040疾病 "
				end;
				if ag == d then
					ah = ah .. "|cff0cbd0c中毒 "
				end;
				g["HealthMaxWeightUnitload"] = d
			end
		end;
		local ai, aj;
		local ak = i("0")
		local al = i("0")
		local am = {}
		local an = "Nothing"
		local ao = - i("999")
		local ap;
		for K = i("1"), i("4"), i("1") do
			am[K] = i("0")
		end;
		local aq = {}
		for K = i("1"), i("40"), i("1") do
			aq[K] = i("0")
		end;
		g["QSCooldown"] = g["WR_GetGCD"](s)
		for K = i("2"), i("5"), i("1") do
			local ar = i("0")
			local as = "boss" .. K;
			if g["UnitExists"](as) == d and (g["UnitName"](as) == "克罗米" or g["UnitName"](as) == "焦化树人" or g["UnitName"](as) == "焦灼刺藤") then
				ar = (g["UnitHealthMax"](as) - g["UnitHealth"](as)) / g["UnitHealthMax"](as) * i("100")
			end;
			if ar ~= i("0") and ao < ar then
				ao = ar;
				an = as
			end
		end;
		local at = i("0")
		if g["UnitExists"]("mouseover") == d and (g["UnitName"]("mouseover") == "克罗米" or g["UnitName"]("mouseover") == "卡多雷精魂") then
			at = (g["UnitHealthMax"]("mouseover") - g["UnitHealth"]("mouseover")) / g["UnitHealthMax"]("mouseover") * i("100")
		end;
		if at ~= i("0") and ao < at then
			ao = at;
			an = "mouseover"
		end;
		if g["WR_GetInRaidOrParty"]() ~= "raid" then
			ap = "player"
			if g["UnitExists"](ap) == d and g["UnitIsDead"](ap) == c and g["UnitIsCharmed"](ap) == c and g["UnitIsFriend"](ap, ap) == d and g["WR_GetUnitRange"](ap) <= i("46") then
				al = (g["UnitHealth"](ap) + g["UnitGetIncomingHeals"](ap) + g["UnitGetTotalAbsorbs"](ap) - g["UnitGetTotalHealAbsorbs"](ap) / i("1.5")) / g["UnitHealthMax"](ap) * i("100")
				if al > i("100") then
					al = i("100")
				end;
				al = i("100") - al;
				if al == i("0") and g["UnitGetTotalAbsorbs"](ap) > i("0") then
					al = al - i("5")
				end;
				local au = (g["UnitHealth"](ap) + g["UnitGetIncomingHeals"](ap) - g["UnitGetTotalHealAbsorbs"](ap)) / g["UnitHealthMax"](ap)
				if au < i("0.70") then
					al = al + (i("70") - au * i("100")) / i("2")
				end;
				if g["UnitClassBase"]("player") == "PRIEST" and g["GetSpecialization"]() == i("1") then
					if g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](ap, "救赎", d) > i("0") then
						al = al - i("20")
					elseif not g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](ap, "恢复", d) > i("0") then
						al = al - i("20")
					end
				end;
				if g["WR_Mustheal"](ap) then
					al = al + i("60")
				end;
				if g["WR_GetUnitBuffTime"](ap, ac, d) > i("0") then
					al = al - i("10")
				end;
				if g["UnitClassBase"]("player") == "MONK" and g["WR_GetUnitBuffTime"](ap, "抚慰之雾", d) > i("0") and au < i("0.9") then
					al = al + i("30")
				end;
				al = g["math"]["ceil"](al)
				if ao < al then
					ao = al;
					an = "player"
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "party" then
			for K = i("1"), i("4"), i("1") do
				ap = "party" .. K;
				if g["UnitExists"](ap) == d and g["UnitIsDead"](ap) == c and g["UnitIsCharmed"](ap) == c and g["UnitIsFriend"](ap, ap) == d and (g["WR_GetUnitRange"](ap) <= i("46") or g["WR_GetUnitBuffTime"]("player", "救赎之魂") > g["GCD"] and g["WR_GetUnitRange"](ap) <= i("69")) then
					am[K] = (g["UnitHealth"](ap) + (g["UnitGetIncomingHeals"](ap) or i("0")) + g["UnitGetTotalAbsorbs"](ap) / i("2") - g["UnitGetTotalHealAbsorbs"](ap) / i("1.5")) / g["UnitHealthMax"](ap) * i("100")
					if am[K] > i("100") then
						am[K] = i("100")
					end;
					am[K] = i("100") - am[K]
					if am[K] == i("0") and g["UnitGetTotalAbsorbs"](ap) > i("0") then
						am[K] = am[K] - i("5")
					end;
					if g["UnitGroupRolesAssigned"](ap) == "TANK" then
						if not g["UnitAffectingCombat"](ap) then
							am[K] = am[K] + i("5")
						end;
						if g["UnitName"]("boss1") == "不屈者卡金" then
							am[K] = am[K] - i("50")
						end
					end;
					local av = (g["UnitHealth"](ap) + (g["UnitGetIncomingHeals"](ap) or i("0")) - g["UnitGetTotalHealAbsorbs"](ap)) / g["UnitHealthMax"](ap)
					local aw = d;
					if g["UnitClass"]("player") == "牧师" and g["GetSpecialization"]() == i("1") then
						if g["WR_GetUnitBuffTime"](ap, "救赎", d) == i("0") then
							aw = c
						end
					end;
					if aw and g["UnitGroupRolesAssigned"](ap) == "TANK" and g["UnitAffectingCombat"](ap) then
						if g["classFilename"] == "DEATHKNIGHT" then
							if g["UnitPower"](ap) >= i("40") then
								am[K] = am[K] - i("40")
							else
								am[K] = am[K] - i("20")
							end
						end;
						if av > i("0.4") then
							if g["classFilename"] == "PALADIN" then
								am[K] = am[K] - i("20")
							end;
							if g["classFilename"] == "DEMONHUNTER" then
								am[K] = am[K] - i("20")
							end;
							if g["classFilename"] == "DRUID" then
								am[K] = am[K] - i("20")
							end
						end
					end;
					if g["UnitClassBase"]("player") == "PRIEST" and g["GetSpecialization"]() == i("1") then
						if g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](ap, "救赎", d) > i("0") then
							am[K] = am[K] - i("20")
						elseif not g["UnitAffectingCombat"]("player") and g["WR_GetUnitBuffTime"](ap, "恢复", d) > i("0") then
							am[K] = am[K] - i("20")
						end
					end;
					if g["UnitClassBase"]("player") == "PALADIN" and g["WR_GetUnitBuffTime"](ap, "圣光闪烁", d) > i("0") then
						am[K] = am[K] - i("20")
					end;
					if g["WR_Mustheal"](ap) then
						am[K] = am[K] + i("50")
					end;
					if g["WR_GetUnitBuffTime"](ap, ac, d) > i("0") then
						am[K] = am[K] - i("10")
					end;
					if g["UnitClassBase"]("player") == "MONK" and g["UnitChannelInfo"]("player") == "抚慰之雾" and g["WR_GetUnitBuffTime"](ap, "抚慰之雾", d) > i("0") and av < i("0.9") then
						am[K] = am[K] + i("30")
					end;
					am[K] = g["math"]["ceil"](am[K])
					if not g["Classes_true"] then
						am[K] = i("0")
					end;
					if ao < am[K] then
						ao = am[K]
						an = "party" .. K
					end
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "raid" then
			for K = i("1"), i("40"), i("1") do
				ap = "raid" .. K;
				if g["UnitExists"](ap) == d and g["UnitIsDead"](ap) == c and g["UnitIsCharmed"](ap) == c and g["UnitIsFriend"](ap, ap) == d and (g["WR_GetUnitRange"](ap) <= i("46") or g["WR_GetUnitBuffTime"]("player", "救赎之魂") > g["GCD"] and g["WR_GetUnitRange"](ap) <= i("69")) then
					aq[K] = (g["UnitHealth"](ap) + (g["UnitGetIncomingHeals"](ap) or i("0")) + g["UnitGetTotalAbsorbs"](ap) / i("2") - g["UnitGetTotalHealAbsorbs"](ap) / i("1.5")) / g["UnitHealthMax"](ap) * i("100")
					if aq[K] > i("100") then
						aq[K] = i("100")
					end;
					aq[K] = i("100") - aq[K]
					if aq[K] == i("0") and g["UnitGetTotalAbsorbs"](ap) > i("0") then
						aq[K] = aq[K] - i("5")
					end;
					if g["UnitGroupRolesAssigned"](ap) == "TANK" and not g["UnitAffectingCombat"](ap) then
						aq[K] = aq[K] + i("5")
					end;
					local ax = (g["UnitHealth"](ap) + (g["UnitGetIncomingHeals"](ap) or i("0")) - g["UnitGetTotalHealAbsorbs"](ap)) / g["UnitHealthMax"](ap)
					if g["WR_GetUnitBuffTime"](ap, ac, d) > i("0") then
						aq[K] = aq[K] - i("10")
					end;
					if g["UnitClassBase"]("player") == "MONK" and g["UnitChannelInfo"]("player") == "抚慰之雾" and g["WR_GetUnitBuffTime"](ap, "抚慰之雾", d) > i("0") and ax < i("0.9") then
						aq[K] = aq[K] + i("30")
					end;
					aq[K] = g["math"]["ceil"](aq[K])
					if ao < aq[K] then
						ao = aq[K]
						an = "raid" .. K
					end
				end
			end
		end;
		if g["MSG"] == i("1") then
			g["print"]("--权重列表--")
			local ay = "player:" .. al .. "  "
			for K = i("1"), i("4"), i("1") do
				if g["UnitExists"]("party" .. K) == d then
					ay = ay .. "party" .. K .. ":" .. am[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("1"), i("5"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("6"), i("10"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("11"), i("15"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("16"), i("20"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("21"), i("25"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("26"), i("30"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("31"), i("35"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			ay = f;
			for K = i("36"), i("40"), i("1") do
				if g["UnitExists"]("raid" .. K) == d then
					ay = ay .. "raid" .. K .. ":" .. aq[K] .. "  "
				end
			end;
			if ay ~= f then
				g["print"](ay)
			end;
			g["print"]("最大权重单位:", an, ":", ao, f)
		end;
		return an, ao
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
					local az = g["UnitClassification"]("nameplate" .. K)
					if az == "normal" or az == "trivial" or az == "minus" then
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
				local aA = g["UnitHealth"]("nameplate" .. K) + g["UnitGetTotalAbsorbs"]("nameplate" .. K)
				if g["NPGUID"][K] ~= e and g["NPbegintime"][K] ~= e and g["NPHealth"][K] ~= e and g["NPHealth"][K] > aA and g["NPbegintime"][K] < g["GetTime"]() then
					g["NPdeathtime"][K] = aA / ((g["NPHealth"][K] - aA) / (g["GetTime"]() - g["NPbegintime"][K]))
				end
			end
		end
	end;
	g["WR_GetUnitDeathTime"] = function(L)
		g["WR_GetNPDeathTime"]()
		local aB = i("0")
		if g["UnitGUID"](L) == e then
			aB = i("0")
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitGUID"](L) ~= e and g["UnitGUID"]("nameplate" .. K) ~= e and g["UnitGUID"](L) == g["UnitGUID"]("nameplate" .. K) and g["NPdeathtime"][K] ~= e then
				aB = g["NPdeathtime"][K]
			end
		end;
		if g["MSG"] == i("1") then
		end;
		if aB ~= e then
			return aB
		else
			return i("0")
		end
	end;
	g["WR_GetRangeAvgDeathTime"] = function(aC)
		if g["WR_InTraining"]() then
			return i("999")
		end;
		g["WR_GetNPDeathTime"]()
		local aD, Q, aE, aF, aG;
		local aH = i("0")
		local R = i("0")
		local aI = i("0")
		for K = i("1"), i("40"), i("1") do
			Q, aE = g["UnitName"]("nameplate" .. K)
			aG = g["WR_GetUnitRange"]("nameplate" .. K)
			aD = g["UnitAffectingCombat"]("nameplate" .. K)
			if aG ~= e and aD == d and g["NPdeathtime"][K] ~= e and Q ~= e then
				if aG <= aC and g["NPdeathtime"][K] > i("0") and g["NPdeathtime"][K] < i("999") and Q ~= "爆炸物" then
					aH = aH + g["NPdeathtime"][K]
					R = R + i("1")
				end
			end
		end;
		if R ~= i("0") then
			aI = aH / R
		end;
		if g["MSG"] == i("1") then
			g["print"]("预计战斗结束时间:|cffffdf00", g["math"]["ceil"](aI), "|cffffffff秒")
		end;
		return aI
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
			local aJ = g["UnitHealthMax"](L) - g["UnitHealth"](L) - (g["UnitGetIncomingHeals"](L) or i("0")) + g["UnitGetTotalHealAbsorbs"](L)
			return aJ > i("0") and aJ or i("0")
		else
			return i("0")
		end
	end;
	g["WR_PartyLostHP"] = function()
		local aK;
		local aL = i("0")
		local aH = i("0")
		aK = "player"
		if g["UnitExists"](aK) == d and g["UnitIsDead"](aK) == c and g["WR_GetUnitRange"](aK) <= i("46") then
			aL = aL + (g["UnitHealthMax"](aK) - g["UnitHealth"](aK)) / g["UnitHealthMax"](aK)
			aH = aH + i("1")
		end;
		if g["WR_GetInRaidOrParty"]() == "party" then
			for K = i("1"), i("4"), i("1") do
				aK = "party" .. K;
				if g["UnitExists"](aK) == d and g["UnitIsDead"](aK) == c and g["WR_GetUnitRange"](aK) <= i("46") then
					aL = aL + (g["UnitHealthMax"](aK) - g["UnitHealth"](aK)) / g["UnitHealthMax"](aK)
					aH = aH + i("1")
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "raid" then
			for K = i("1"), i("20"), i("1") do
				aK = "raid" .. K;
				if g["UnitExists"](aK) == d and g["UnitIsDead"](aK) == c and g["WR_GetUnitRange"](aK) <= i("46") then
					aL = aL + (g["UnitHealthMax"](aK) - g["UnitHealth"](aK)) / g["UnitHealthMax"](aK)
					aH = aH + i("1")
				end
			end
		end;
		if aH == i("0") then
			aL = i("0")
		else
			aL = g["math"]["ceil"](aL / aH * i("100")) / i("100")
		end;
		if g["MSG"] == i("1") then
		end;
		return aL
	end;
	g["WR_PlayerMove"] = function()
		if g["IsPlayerSpell"](i("108839")) and g["WR_GetUnitBuffTime"]("player", i("108839")) > g["GCD"] then
			return c
		end;
		local aM, w, w, w = g["GetUnitSpeed"]("player")
		if g["IsFlying"]() == c and g["IsFalling"]() == c and aM == i("0") then
			return c
		else
			return d
		end
	end;
	g["WR_GetUnitRange"] = function(L)
		local aN = g["select"](i("2"), g["WR_LibRangeCheck3"]["GetRange"](g["WR_LibRangeCheck3"], L))
		if aN == e then
			return i("999")
		end;
		return aN
	end;
	g["WR_Invincible"] = function(L)
		if g["Test_Sum"] ~= i("31642050581") then
			return d
		end;
		local Q, aO, aP, aQ = g["GetInstanceInfo"]()
		if aO == "raid" then
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
	g["WR_GetRangeHarmUnitCount"] = function(aC, aR)
		local aS = i("0")
		for K = i("1"), i("40"), i("1") do
			local L = "nameplate" .. K;
			if g["UnitCanAttack"]("player", L) and not g["WR_Invincible"](L) and (aR ~= d or g["UnitAffectingCombat"](L) == aR or g["WR_InBossCombat"]()) and g["UnitCreatureType"](L) ~= "图腾" and g["UnitCreatureType"](L) ~= "气体云雾" and g["WR_GetUnitRange"](L) <= aC and g["UnitName"](L) ~= "复酌之桶" and g["WR_Frame_Show"] ~= e then
				aS = aS + i("1")
			end
		end;
		return aS
	end;
	g["WR_GetSpellRangeHarmUnitCount"] = function(s, aR)
		local aS = i("0")
		for K = i("1"), i("40"), i("1") do
			local L = "nameplate" .. K;
			if g["C_Spell"]["IsSpellInRange"](s, L) and g["UnitCanAttack"]("player", L) and not g["WR_Invincible"](L) and (aR ~= d or g["UnitAffectingCombat"](L) == aR) and g["UnitCreatureType"](L) ~= "图腾" and g["UnitCreatureType"](L) ~= "气体云雾" then
				aS = aS + i("1")
			end
		end;
		return aS
	end;
	g["WR_PartyInCombat"] = function()
		if g["UnitAffectingCombat"]("player") then
			return d
		end;
		for K = i("1"), i("4") do
			local ap = "party" .. K;
			if g["UnitAffectingCombat"](ap) then
				return d
			end
		end;
		return c
	end;
	g["WR_TargetInCombat"] = function(L)
		if not g["WR_Frame_Info"] then
			return d
		end;
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
		local aT, aO = g["IsInInstance"]()
		if not aT then
			return d
		end;
		if g["UnitThreatSituation"]("player", "target") ~= e then
			return d
		end;
		local Q, aO, aP, aQ = g["GetInstanceInfo"]()
		if aP == i("208") or aP == i("12") then
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
	g["WR_GetRangeSpellTime"] = function(aC, s, L)
		local aU = i("999")
		for K = i("1"), i("40"), i("1") do
			if g["UnitExists"]("nameplate" .. K) then
				local aN = g["WR_GetUnitRange"]("nameplate" .. K)
				if aN ~= e and aN <= aC and (L == e or g["UnitIsUnit"]("nameplate" .. K .. "target", L)) then
					local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"]("nameplate" .. K)
					if Q == e then
						Q, aV, aW, aX, x, aY, a_, W = g["UnitChannelInfo"]("nameplate" .. K)
					end;
					if Q ~= e then
						local b0 = x / i("1000") - g["GetTime"]()
						if b0 > i("999") then
							b0 = i("998")
						end;
						if b0 < aU then
							if g["type"](s) == "table" then
								for b1, b2 in g["pairs"](s) do
									if Q == b2 or W == b1 then
										aU = b0
									end
								end
							else
								if s == e or Q == s or W == s then
									aU = b0
								end
							end
						end
					end
				end
			end
		end;
		return aU
	end;
	g["WR_GetUnitOutburstDebuffTime"] = function(L)
		for w, ab in g["pairs"](g["OutburstDebuff"]) do
			local a8 = g["WR_GetUnitDebuffTime"](L, ab)
			if a8 ~= i("0") then
				return a8
			end
		end;
		return i("999")
	end;
	g["WR_GetPartyOutburstDebuffTime"] = function()
		local K;
		for K = i("1"), i("4"), i("1") do
			if g["UnitExists"]("party" .. K) then
				for w, b3 in g["pairs"](g["PartyOutburstDebuff"]) do
					local a8 = g["WR_GetUnitDebuffTime"]("party" .. K, b3)
					if a8 > i("0") then
						return a8
					end
				end
			end
		end;
		for K = i("1"), i("40"), i("1") do
			if g["UnitExists"]("raid" .. K) then
				for w, b3 in g["pairs"](g["PartyOutburstDebuff"]) do
					local a8 = g["WR_GetUnitDebuffTime"]("raid" .. K, b3)
					if a8 > i("0") then
						return a8
					end
				end
			end
		end;
		return i("999")
	end;
	g["WR_ResistOutburstTime"] = function()
		local b4 = g["WR_GetRangeSpellTime"](i("45"), g["OutburstAoe"])
		if b4 < i("999") then
			return b4
		end;
		local b5 = g["WR_GetUnitOutburstDebuffTime"]("player")
		if b5 < i("999") then
			return b5
		end;
		local b6 = g["WR_GetPartyOutburstDebuffTime"]()
		if b6 < i("999") then
			return b6
		end;
		local b7 = g["WR_GetRangeSpellTime"](i("45"), g["OutburstCasting"], "player")
		if b7 < i("999") then
			return b7
		end;
		g["WR_DangerSpellTime"]()
		local b8;
		if g["Time"] == e then
			b8 = i("5")
		else
			b8 = g["Time"]
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
	g["WR_ResistSustained"] = function(b9)
		if b9 == e or g["UnitHealth"]("player") / g["UnitHealthMax"]("player") <= b9 then
			local ba = g["WR_GetRangeSpellTime"](i("45"), g["SustainedAoe"])
			if ba < i("999") then
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
		local bb = g["WR_ResistSustained"]()
		local bc = g["WR_ResistOutburstTime"]()
		if g["UnitHealth"]("player") / g["UnitHealthMax"]("player") <= i("0.35") and g["UnitAffectingCombat"]("player") then
			if bb or not g["WR_InBossCombat"]() then
				return i("0")
			end;
			if bc < i("999") then
				return bc
			end
		end;
		if bc < i("999") and (bb or g["WR_GetUnitDebuffCount"]("player", "音速易伤") >= i("2")) then
			return bc
		end;
		local bd = g["WR_GetRangeSpellTime"](i("45"), g["DangerOutburstAoe"])
		if bd < i("999") then
			return bd
		end;
		local be = g["WR_GetRangeSpellTime"](i("45"), g["DangerSustainedAoe"])
		if be < i("999") then
			return i("0")
		end;
		local bf = g["WR_GetRangeSpellTime"](i("45"), "熔炉之力")
		if bf > i("6") and bf < i("999") then
			return bf - i("6")
		end;
		if g["UnitName"]("boss1") == "丹塔利纳克斯" and g["UnitCastingInfo"]("boss1") == "暗影箭雨" and g["WR_GetUnitDebuffCount"]("player", "拉文凯斯的遗产") == i("0") then
			return i("0")
		end;
		if g["WR_GetUnitDebuffTime"]("player", g["DangerDebuff"]) > i("0") then
			return i("0")
		end;
		local bg = g["WR_GetRangeSpellTime"](i("45"), g["DangerSpellToMe"], "player")
		if bg <= i("0.8") then
			return bg
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
	g["WR_GetEquipCD"] = function(bh)
		if g["GetInventoryItemID"]("player", bh) == i("203729") then
			return c
		end;
		local u, v, bi = g["GetInventoryItemCooldown"]("player", bh)
		if bi == i("1") then
			if u + v <= g["GetTime"]() + g["GCD"] then
				return d
			end
		end;
		return c
	end;
	g["WR_Use_Item"] = function(bj, bk)
		if g["GetInventoryItemID"]("player", bj) == bk and g["WR_GetEquipCD"](bj) then
			return d
		end;
		return c
	end;
	g["WR_WuQi"] = function(aC, bl)
		if bl == i("1") or bl == i("2") and g["zhandoumoshi"] == i("1") then
			if g["WR_GetEquipCD"](i("16")) and g["WR_GetUnitRange"]("target") <= aC and g["WR_TargetInCombat"]("target") then
				if g["WR_ColorFrame_Show"]("F6", "武器") then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_ShiPin"] = function(bj, bl)
		if bl == i("13") then
			return c
		end;
		if not g["WR_GetEquipCD"](bj + i("12")) then
			return c
		end;
		if bj == i("1") then
			if g["WR_Use_Item"](i("13"), i("178783")) and g["WR_GetUnitBuffTime"]("player", i("345549")) > i("0") then
				return c
			end;
			if bl == i("1") then
				if g["WR_ColorFrame_Show"]("F10", bj .. "饰常") then
					return d
				end
			elseif bl == i("2") and g["zhandoumoshi"] == i("1") then
				if g["WR_ColorFrame_Show"]("F10", bj .. "饰爆") then
					return d
				end
			elseif bl >= i("3") and bl <= i("7") then
				if g["WR_GetUnitHP"]("player") <= (bl - i("2")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACF2", bj .. "饰自") then
						return d
					end
				end
			elseif bl >= i("8") and bl <= i("12") then
				if g["WR_GetUnitHP"]("player") <= (bl - i("7")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACF2", bj .. "饰协P") then
						return d
					end
				elseif not g["UnitIsDead"]("party1") and g["WR_GetUnitHP"]("party1") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party1") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF3", bj .. "饰协P1") then
						return d
					end
				elseif not g["UnitIsDead"]("party2") and g["WR_GetUnitHP"]("party2") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party2") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF5", bj .. "饰协P2") then
						return d
					end
				elseif not g["UnitIsDead"]("party3") and g["WR_GetUnitHP"]("party3") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party3") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF6", bj .. "饰协P3") then
						return d
					end
				elseif not g["UnitIsDead"]("party4") and g["WR_GetUnitHP"]("party4") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party4") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACF7", bj .. "饰协P4") then
						return d
					end
				end
			end
		elseif bj == i("2") then
			if g["WR_Use_Item"](i("14"), i("178783")) and g["WR_GetUnitBuffTime"]("player", i("345549")) > i("0") then
				return c
			end;
			if bl == i("1") then
				if g["WR_ColorFrame_Show"]("F11", bj .. "饰常") then
					return d
				end
			elseif bl == i("2") and g["zhandoumoshi"] == i("1") then
				if g["WR_ColorFrame_Show"]("F11", bj .. "饰爆") then
					return d
				end
			elseif bl >= i("3") and bl <= i("7") then
				if g["WR_GetUnitHP"]("player") <= (bl - i("2")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACSF2", bj .. "饰自") then
						return d
					end
				end
			elseif bl >= i("8") and bl <= i("12") then
				if g["WR_GetUnitHP"]("player") <= (bl - i("7")) / i("10") then
					if g["WR_ColorFrame_Show"]("ACSF2", bj .. "饰协P") then
						return d
					end
				elseif not g["UnitIsDead"]("party1") and g["WR_GetUnitHP"]("party1") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party1") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF3", bj .. "饰协P1") then
						return d
					end
				elseif not g["UnitIsDead"]("party2") and g["WR_GetUnitHP"]("party2") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party2") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF5", bj .. "饰协P2") then
						return d
					end
				elseif not g["UnitIsDead"]("party3") and g["WR_GetUnitHP"]("party3") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party3") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF6", bj .. "饰协P3") then
						return d
					end
				elseif not g["UnitIsDead"]("party4") and g["WR_GetUnitHP"]("party4") <= (bl - i("5")) / i("10") and g["WR_GetUnitRange"]("party4") <= i("40") then
					if g["WR_ColorFrame_Show"]("ACSF7", bj .. "饰协P4") then
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
		local bm = {
			[i("1")] = "治疗石",
			[i("2")] = "恶魔治疗石"
		}
		for w, bn in g["pairs"](bm) do
			local R = g["C_Item"]["GetItemCount"](bn)
			local u, v, bi = g["C_Item"]["GetItemCooldown"](bn)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_ZLS"] = function(bo)
		if not g["PlayerHP"] then
			g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
		end;
		if bo ~= i("5") and g["PlayerHP"] < bo / i("10") and g["UnitAffectingCombat"]("player") and g["WR_Use_ZLS"]() then
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
		local bp = {
			[i("1")] = "阿加治疗药水"
		}
		for w, bq in g["pairs"](bp) do
			local R = g["C_Item"]["GetItemCount"](bq)
			local u, v, bi = g["C_Item"]["GetItemCooldown"](bq)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	local br = g["CreateFrame"]("Frame", "FindInfo")
	br["SetScript"](br, "OnUpdate", function(bs, bt)
		if not g["WR_Addon_Version"] or not g["WR_WelcomeIsOK"] or not g["WR_WelcomeIsNotOK"] then
			if g["IsInGuild"]() and (g["FindInfoSendTime"] == e or g["GetTime"]() - g["FindInfoSendTime"] >= i("60")) then
				local p = g["date"]("*t")
				local q = p["hour"]
				local r = p["min"]
				g["SendChatMessage"](q .. ":" .. r, "GUILD")
				g["FindInfoSendTime"] = g["GetTime"]()
			end
		end
	end)
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
		local bp = {
			[i("1")] = "洞穴住民的挚爱"
		}
		for w, bq in g["pairs"](bp) do
			local R = g["C_Item"]["GetItemCount"](bq)
			local u, v, bi = g["C_Item"]["GetItemCooldown"](bq)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_ZLYS"] = function(bo)
		if not g["PlayerHP"] then
			g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
		end;
		if bo ~= i("5") and g["PlayerHP"] < bo / i("10") and g["UnitAffectingCombat"]("player") and g["WR_Use_ZLYS"]() then
			if g["WR_ColorFrame_Show"]("CST", "治疗药水") then
				return d
			end
		end;
		return c
	end;
	g["WR_ZLYS2"] = function(bo)
		if not g["PlayerHP"] then
			g["PlayerHP"] = g["UnitHealth"]("player") / g["UnitHealthMax"]("player")
		end;
		if bo ~= i("5") and g["PlayerHP"] < bo / i("10") and g["UnitAffectingCombat"]("player") and g["WR_Use_ZLYS2"]() then
			if g["WR_ColorFrame_Show"]("CSX", "治疗药水2") then
				return d
			end
		end;
		return c
	end;
	g["WR_Use_BFYS"] = function()
		local bu = {
			[i("1")] = "淬火药水"
		}
		for w, bv in g["pairs"](bu) do
			local R = g["C_Item"]["GetItemCount"](bv)
			local u, v, bi = g["C_Item"]["GetItemCooldown"](bv)
			if R ~= e and R >= i("1") and u + v - g["GetTime"]() <= i("0") then
				return d
			end
		end;
		return c
	end;
	g["WR_GetTrueCastTime"] = function(y)
		local Q, bw, bx, by, aF, aG, j = g["GetSpellInfo"](y)
		return by / i("1000")
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
		local bz = g["CreateFrame"]("Frame")
		bz["RegisterEvent"](bz, "COMBAT_LOG_EVENT_UNFILTERED")
		bz["SetScript"](bz, "OnEvent", function()
			if g["IsInInstance"]() then
				local bA = "SAY"
				local bB, bC, bD, bE, bF, bG, bH, bI, bJ, bK, bL = g["CombatLogGetCurrentEventInfo"]()
				if bC == "SPELL_INTERRUPT" then
					local W, bM, bN, bO, bP, bQ = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bF == g["UnitName"]("player") or bF == g["UnitName"]("pet") then
						g["SendChatMessage"]("打断-->" .. g["C_Spell"]["GetSpellLink"](bO), bA)
					end
				elseif bC == "SPELL_DISPEL" then
					local W, bM, bN, bO, bP, bQ, bR = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bF == g["UnitName"]("player") or bF == g["UnitName"]("pet") then
						g["SendChatMessage"]("驱散-->" .. g["C_Spell"]["GetSpellLink"](bO), bA)
					end
				elseif bC == "SPELL_STOLEN" then
					local W, bM, bN, bO, bP, bQ, bR = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bF == g["UnitName"]("player") then
						g["SendChatMessage"]("偷取-->" .. g["C_Spell"]["GetSpellLink"](bO), bA)
					end
				elseif bC == "SPELL_MISSED" then
					local W, bM, bN, bS, bT, bU = g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]())
					if bS == "REFLECT" and bJ == g["UnitName"]("player") then
						g["SendChatMessage"]("反射-->" .. g["C_Spell"]["GetSpellLink"](W), bA)
					elseif bS == "ABSORB" and bJ == "根基图腾" and bK == i("8465") then
						g["SendChatMessage"]("吸收-->" .. g["C_Spell"]["GetSpellLink"](W), bA)
					end
				end
			end
		end)
		g["WR_EventNotificationsIsOpen"] = d
	end;
	g["WR_HidePlayerNotFound"] = function()
		if not g["WR_CreateButtonInfo"] and g["WowRobotConfigFrame"] then
			g["WowRobotConfigFrame"]["SetPoint"](g["WowRobotConfigFrame"], "LEFT", i("9999"), i("9999"))
			g["WowRobotConfigFrame"]["Hide"](g["WowRobotConfigFrame"])
		end;
		if g["WR_HidePlayerNotFoundIsOpen"] == d then
			return
		end;
		g["ChatFrame_AddMessageEventFilter"]("CHAT_MSG_SYSTEM", function(w, w, bV)
			if g["strmatch"](bV, g["ERR_CHAT_PLAYER_NOT_FOUND_S"]["gsub"](g["ERR_CHAT_PLAYER_NOT_FOUND_S"], "%%%d?$?%a", ".*")) then
				return d
			end
		end)
		local bW = g["CommunitiesGuildNewsFrame_OnEvent"]
		local bX, bY;
		g["CommunitiesFrameGuildDetailsFrameNews"]["SetScript"](g["CommunitiesFrameGuildDetailsFrameNews"], "OnEvent", function(br, bZ)
			if bZ == "GUILD_NEWS_UPDATE" then
				if bY then
					bX = d
				else
					bW(br, bZ)
					bY = g["C_Timer"]["NewTimer"](i("1"), function()
						if bX then
							bW(br, bZ)
						end;
						bY = e
					end)
				end
			else
				bW(br, bZ)
			end
		end)
		g["WR_HidePlayerNotFoundIsOpen"] = d
	end;
	g["WR_DangerSpellTime"] = function()
		if g["WR_DangerSpellTimeIsOpen"] == d then
			return
		end;
		local bz = g["CreateFrame"]("Frame")
		bz["RegisterEvent"](bz, "COMBAT_LOG_EVENT_UNFILTERED")
		bz["SetScript"](bz, "OnEvent", function()
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
	g["WR_PartyNotBuff"] = function(Y, y)
		if g["WR_GetUnitBuffCount"]("player", Y) == i("0") then
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
				if g["UnitExists"](g["unit"]) and g["UnitIsPlayer"](g["unit"]) and not g["UnitCanAttack"]("player", g["unit"]) and not g["UnitIsDead"](g["unit"]) and g["WR_GetUnitBuffCount"](g["unit"], Y) == i("0") and (g["WR_GetUnitRange"](g["unit"]) <= i("50") or y ~= e and g["IsSpellInRange"](y, g["unit"])) then
					return d
				end;
				g["unit"] = "raid" .. K;
				if g["UnitExists"](g["unit"]) and g["UnitIsPlayer"](g["unit"]) and not g["UnitCanAttack"]("player", g["unit"]) and not g["UnitIsDead"](g["unit"]) and g["WR_GetUnitBuffCount"](g["unit"], Y) == i("0") and (g["WR_GetUnitRange"](g["unit"]) <= i("50") or y ~= e and g["IsSpellInRange"](y, g["unit"])) then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_CanRemoveUnitDebuff"] = function(L)
		local ad = c;
		local ae = c;
		local af = c;
		local ag = c;
		if g["IsPlayerSpell"](i("527")) == d then
			ad = d
		end;
		if g["IsSpellKnown"](i("89808"), d) == d then
			ad = d
		end;
		if g["IsPlayerSpell"](i("77130")) == d then
			ad = d
		end;
		if g["IsPlayerSpell"](i("4987")) == d then
			ad = d
		end;
		if g["IsPlayerSpell"](i("213644")) == d then
			af = d;
			ag = d
		end;
		if g["IsPlayerSpell"](i("115450")) == d then
			ad = d
		end;
		if g["IsPlayerSpell"](i("390632")) == d then
			af = d
		end;
		if g["IsPlayerSpell"](i("383016")) == d then
			ae = d
		end;
		if g["IsPlayerSpell"](i("51886")) == d then
			ae = d
		end;
		if g["IsPlayerSpell"](i("2782")) == d then
			ae = d;
			ag = d
		end;
		if g["IsPlayerSpell"](i("218164")) == d then
			af = d;
			ag = d
		end;
		if g["IsPlayerSpell"](i("393024")) == d then
			ag = d;
			af = d
		end;
		if g["IsPlayerSpell"](i("388874")) == d then
			ag = d;
			af = d
		end;
		if g["IsPlayerSpell"](i("365585")) == d then
			ag = d
		end;
		if g["IsPlayerSpell"](i("475")) == d then
			ae = d
		end;
		if g["IsPlayerSpell"](i("213634")) == d then
			af = d
		end;
		if g["IsPlayerSpell"](i("88423")) == d then
			ad = d
		end;
		if g["IsPlayerSpell"](i("392378")) == d then
			ag = d;
			ae = d
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
		if ad == d and g["WR_UnitDebuffType"](L, "Magic") == d then
			return d
		end;
		if ae == d and g["WR_UnitDebuffType"](L, "Curse") == d then
			return d
		end;
		if af == d and g["WR_UnitDebuffType"](L, "Disease") == d then
			return d
		end;
		if ag == d and g["WR_UnitDebuffType"](L, "Poison") == d then
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
			local aK;
			if K <= i("4") then
				aK = "party" .. K;
				if g["UnitIsDead"](aK) and g["WR_GetUnitRange"](aK) <= i("100") then
					return d
				end;
				aK = "raid" .. K;
				if g["UnitIsDead"](aK) and g["WR_GetUnitRange"](aK) <= i("100") then
					return d
				end
			end
		end;
		return c
	end;
	g["WR_StopCast"] = function(b_)
		if g["WR_GetRangeSpellTime"](i("45"), g["StopCastID"]) < b_ + i("0.4") then
			return d
		end;
		return c
	end;
	g["WR_RangeCountPR"] = function(aC, c0)
		local aK;
		local c1 = i("0")
		aK = "player"
		if g["UnitHealthMax"](aK) ~= i("0") and g["WR_GetUnitHP"](aK) <= c0 then
			c1 = c1 + i("1")
		end;
		if g["UnitExists"]("raid1") then
			for K = i("1"), i("40"), i("1") do
				aK = "raid" .. K;
				local aG = g["WR_GetUnitRange"](aK)
				local c2 = i("0")
				if g["UnitExists"](aK) then
					c2 = g["WR_GetUnitHP"](aK)
				end;
				if aG ~= e and aG <= aC and c2 > i("0") and c2 <= c0 then
					c1 = c1 + i("1")
				end
			end
		else
			for K = i("1"), i("4"), i("1") do
				aK = "party" .. K;
				local aG = g["WR_GetUnitRange"](aK)
				local c2 = i("0")
				if g["UnitExists"](aK) then
					c2 = g["WR_GetUnitHP"](aK)
				end;
				if aG ~= e and aG <= aC and c2 > i("0") and c2 <= c0 then
					c1 = c1 + i("1")
				end
			end
		end;
		return c1
	end;
	g["WR_UnitEnragedBuff"] = function(L)
		if g["WR_GetUnitBuffCount"](L, "无穷饥渴") >= i("6") then
			return d
		end;
		if g["WR_GetUnitBuffTime"](L, g["EnragedBuffName"]) > i("0") then
			return d
		end
	end;
	g["WR_GetCastInterruptible"] = function(L, c3, c4)
		if g["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return c
		end;
		if g["UnitCastingInfo"](L) == "星宇飞升" then
			return c
		end;
		if g["UnitName"]("boss1") == "无堕者哈夫" then
			return c
		end;
		local c5, c6, c7 = g["WR_GetUnitCastInfo"](L, c4)
		if c5 ~= e and c7 ~= e then
			if c5 / (c5 + c6) >= c3 and c7 == d then
				return d
			end
		end;
		local c8, c9 = g["WR_GetUnitChannelInfo"](L, c4)
		if c8 ~= e and c9 ~= e then
			if c8 >= c3 and c9 == d then
				return d
			end
		end;
		return c
	end;
	g["WR_GetUnitCastInfo"] = function(L, c4)
		local ca = e;
		local cb = e;
		local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"](L)
		if x ~= e then
			for w, cc in g["pairs"](g["MustInterruptUnitName"]) do
				if g["UnitName"](L) == cc then
					return g["GetTime"]() - aX / i("1000"), x / i("1000") - g["GetTime"](), not a_
				end
			end;
			if g["UnitIsPlayer"](L) then
				return g["GetTime"]() - aX / i("1000"), x / i("1000") - g["GetTime"](), not a_
			end;
			local Q, aO, aP, aQ = g["GetInstanceInfo"]()
			if aP ~= i("8") then
				return g["GetTime"]() - aX / i("1000"), x / i("1000") - g["GetTime"](), not a_
			end;
			if c4 then
				for cd, s in g["pairs"](g["MustInterruptSpellName"]) do
					if W == cd or Q == s then
						return g["GetTime"]() - aX / i("1000"), x / i("1000") - g["GetTime"](), not a_
					end
				end
			else
				for ce, cf in g["pairs"](g["ExcludeSpell"]) do
					if W == ce or Q == cf then
						return e, e, e
					end
				end;
				return g["GetTime"]() - aX / i("1000"), x / i("1000") - g["GetTime"](), not a_
			end
		end;
		return e, e, e
	end;
	g["WR_GetUnitChannelInfo"] = function(L, c4)
		local cg = e;
		local ch = e;
		local Q, aV, aW, aX, x, aY, a_, W = g["UnitChannelInfo"](L)
		if x ~= e then
			for w, cc in g["pairs"](g["MustInterruptUnitName"]) do
				if g["UnitName"](L) == cc then
					return g["GetTime"]() - aX / i("1000"), not a_
				end
			end;
			if g["UnitIsPlayer"](L) then
				return g["GetTime"]() - aX / i("1000"), not a_
			end;
			if c4 then
				for cd, s in g["pairs"](g["MustInterruptSpellName"]) do
					if W == cd or Q == s then
						return g["GetTime"]() - aX / i("1000"), not a_
					end
				end
			else
				for ce, cf in g["pairs"](g["ExcludeSpell"]) do
					if W == ce or Q == cf then
						return e, e
					end
				end;
				return g["GetTime"]() - aX / i("1000"), not a_
			end
		end;
		return e, e
	end;
	g["WR_GetRuneCount"] = function()
		local ci = i("0")
		for K = i("1"), i("6") do
			if g["GetRuneCount"](K) ~= e then
				ci = ci + g["GetRuneCount"](K)
			end
		end;
		return ci
	end;
	g["WR_TankResist"] = function()
		local cj = i("999")
		local ck = i("999")
		local cl = i("999")
		local cm = i("999")
		for K = i("1"), i("40"), i("1") do
			if g["UnitName"]("boss1") == "乌比斯将军" and g["WR_GetUnitDebuffCount"]("player", "碎颅打击") >= i("2") and g["WR_GetUnitDebuffTime"]("player", "碎颅打击") > i("4") then
				cl = i("1.4")
				cm = i("1.4")
			end;
			local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"]("nameplate" .. K)
			if Q ~= e then
				if g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
					if g["TankResist_SmallMagicToMe"] ~= e then
						for cd, s in g["pairs"](g["TankResist_SmallMagicToMe"]) do
							if s == f then
								break
							end;
							if s == Q or cd == W then
								cj = x / i("1000") - g["GetTime"]()
							end
						end
					end;
					if g["TankResist_BigMagicToMe"] ~= e then
						for cd, s in g["pairs"](g["TankResist_BigMagicToMe"]) do
							if s == f then
								break
							end;
							if s == Q or cd == W then
								ck = x / i("1000") - g["GetTime"]()
							end
						end
					end;
					if g["TankResist_SmallPhysicalToMe"] ~= e then
						for cd, s in g["pairs"](g["TankResist_SmallPhysicalToMe"]) do
							if s == f then
								break
							end;
							if s == Q or cd == W then
								cl = x / i("1000") - g["GetTime"]()
							end
						end
					end;
					if g["TankResist_BigPhysicalToMe"] ~= e then
						for cd, s in g["pairs"](g["TankResist_BigPhysicalToMe"]) do
							if s == f then
								break
							end;
							if s == Q or cd == W then
								cm = x / i("1000") - g["GetTime"]()
							end
						end
					end
				end;
				if g["TankResist_SmallMagicToAoe"] ~= e then
					for cd, s in g["pairs"](g["TankResist_SmallMagicToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or cd == W then
							cj = x / i("1000") - g["GetTime"]()
						end
					end
				end;
				if g["TankResist_BigMagicToAoe"] ~= e then
					for cd, s in g["pairs"](g["TankResist_BigMagicToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or cd == W then
							ck = x / i("1000") - g["GetTime"]()
						end
					end
				end;
				if g["TankResist_SmallPhysicalToAoe"] ~= e then
					for cd, s in g["pairs"](g["TankResist_SmallPhysicalToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or cd == W then
							cl = x / i("1000") - g["GetTime"]()
						end
					end
				end;
				if g["TankResist_BigPhysicalToAoe"] ~= e then
					for cd, s in g["pairs"](g["TankResist_BigPhysicalToAoe"]) do
						if s == f then
							break
						end;
						if s == Q or cd == W then
							cm = x / i("1000") - g["GetTime"]()
						end
					end
				end
			end
		end;
		return cj, ck, cl, cm
	end;
	g["WR_SpellReflection"] = function(cn)
		for K = i("1"), i("40"), i("1") do
			local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"]("nameplate" .. K)
			if x ~= e then
				if x / i("1000") - g["GetTime"]() < cn then
					for cd, s in g["pairs"](g["ReflectionAOE"]) do
						if s == Q or cd == W then
							return d
						end
					end;
					if g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
						for cd, s in g["pairs"](g["ReflectionSpell"]) do
							if s == Q or cd == W then
								return d
							end
						end
					end
				end
			end;
			local Q, aV, aW, aX, x, aY, a_, W = g["UnitChannelInfo"]("nameplate" .. K)
			if aX ~= e then
				for cd, s in g["pairs"](g["ReflectionAOE"]) do
					if s == Q or cd == W then
						return d
					end
				end;
				if g["UnitIsUnit"]("nameplate" .. K .. "target", "player") then
					for cd, s in g["pairs"](g["ReflectionSpell"]) do
						if s == Q or cd == W then
							return d
						end
					end
				end
			end
		end;
		return c
	end;
	g["WR_StunUnit"] = function(aC, cn)
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
				local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"]("nameplate" .. K)
				if Q ~= e then
					local aG = g["WR_GetUnitRange"]("nameplate" .. K)
					if aG ~= e and aG <= aC and (cn == e or x / i("1000") - g["GetTime"]() < cn) then
						for cd, s in g["pairs"](g["StunCastName"]) do
							if s == Q or cd == W then
								return d
							end
						end
					end
				end;
				local Q, aV, aW, aX, x, aY, a_, W = g["UnitChannelInfo"]("nameplate" .. K)
				if Q ~= e then
					local aG = g["WR_GetUnitRange"]("nameplate" .. K)
					if aG ~= e and aG <= aC then
						for cd, s in g["pairs"](g["StunChannelName"]) do
							if s == Q or cd == W then
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
		local co = g["C_Spell"]["GetSpellCharges"](s)["cooldownStartTime"]
		local cp = g["C_Spell"]["GetSpellCharges"](s)["cooldownDuration"]
		if co == i("0") then
			return i("0")
		end;
		return co + cp - g["GetTime"]()
	end;
	g["WR_GetSpellCharges"] = function(s)
		if g["C_Spell"]["GetSpellCharges"](s) ~= e then
			return g["C_Spell"]["GetSpellCharges"](s)["currentCharges"] or i("0")
		end
	end;
	g["WR_GetSuit"] = function(cq)
		local cr = i("0")
		for K = i("1"), i("19") do
			local cs = g["GetInventoryItemID"]("player", K)
			for w, ct in g["pairs"](cq) do
				if cs == ct then
					cr = cr + i("1")
				end
			end
		end;
		return cr
	end;
	g["WR_StunSpell"] = function(L, cn)
		if g["UnitCastingInfo"]("boss1") == "宇宙奇点" then
			return c
		end;
		local N, w = g["UnitName"](L)
		local aM, w, w, w = g["GetUnitSpeed"](L)
		local K = i("1")
		while g["StunUnitName"][K] ~= e and g["StunUnitName"][K] ~= f do
			if g["StunUnitName"][K] == N and aM > i("0") then
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
			local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"](L)
			if Q ~= e and (cn == e or x / i("1000") - g["GetTime"]() < cn) then
				for cd, s in g["pairs"](g["StunCastName"]) do
					if s == Q or cd == W then
						return d
					end
				end
			end;
			local Q, aV, aW, aX, x, aY, a_, W = g["UnitChannelInfo"](L)
			if Q ~= e then
				for cd, s in g["pairs"](g["StunChannelName"]) do
					if s == Q or cd == W then
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
		local bz = g["CreateFrame"]("Frame")
		bz["RegisterEvent"](bz, "COMBAT_LOG_EVENT_UNFILTERED")
		bz["SetScript"](bz, "OnEvent", function()
			local bB, cu, bD, bE, bF, bG, bH, bI, bJ, bK, bL = g["CombatLogGetCurrentEventInfo"]()
			if cu == "SPELL_CAST_SUCCESS" and bE == g["UnitGUID"]("player") then
				g["WR_LastSpellName"] = g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]())
			end
		end)
		g["WR_LastSpellNameIsOpen"] = d
	end;
	g["WR_GetSpellAuraApplied"] = function()
		if g["WR_GetSpellAuraAppliedIsOpen"] == d then
			return
		end;
		local bz = g["CreateFrame"]("Frame")
		bz["RegisterEvent"](bz, "COMBAT_LOG_EVENT_UNFILTERED")
		bz["SetScript"](bz, "OnEvent", function()
			local bB, cu, bD, bE, bF, bG, bH, bI, bJ, bK, bL = g["CombatLogGetCurrentEventInfo"]()
			if cu == "SPELL_AURA_APPLIED" and bI == g["UnitGUID"]("player") then
				if g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]()) == i("438141") or g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]()) == "暮光屠戮" then
					g["MGTL_DebuffTime"] = g["GetTime"]()
				end
			end;
			if cu == "SPELL_CAST_START" and bI == g["UnitGUID"]("player") then
				if g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]()) == i("438141") or g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]()) == "暮光屠戮" then
					g["MGTL_DebuffTime"] = g["GetTime"]()
				end
			end;
			if bI == g["UnitGUID"]("player") then
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
			local Q, aV, aW, aX, x, aY, aZ, a_, W = g["UnitCastingInfo"]("nameplate" .. K)
			if Q == e then
				Q, aV, aW, aX, x, aY, a_, W = g["UnitChannelInfo"]("nameplate" .. K)
			end;
			if Q ~= e then
				for cd, s in g["pairs"](g["SpeedUpSpellName"]) do
					if s == Q or cd == W then
						return d
					end
				end
			end
		end;
		return c
	end;
	g["WR_GetUnitCrazyBuff"] = function(L)
		for w, Y in g["pairs"](g["CrazyBuff"]) do
			if g["WR_GetUnitBuffInfo"](L, Y) > i("12") then
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
		local bz = g["CreateFrame"]("Frame")
		bz["RegisterEvent"](bz, "COMBAT_LOG_EVENT_UNFILTERED")
		bz["SetScript"](bz, "OnEvent", function()
			local bB, cu, bD, bE, bF, bG, bH, bI, bJ, bK, bL = g["CombatLogGetCurrentEventInfo"]()
			if cu == "SPELL_CAST_SUCCESS" then
				for w, Y in g["pairs"](g["CrazyBuff"]) do
					if g["select"](i("13"), g["CombatLogGetCurrentEventInfo"]()) == Y or g["select"](i("12"), g["CombatLogGetCurrentEventInfo"]()) == Y then
						if bE == g["UnitGUID"]("party1") then
							g["WR_GetCrazyBuffTime_Party1"] = g["GetTime"]()
						end;
						if bE == g["UnitGUID"]("party2") then
							g["WR_GetCrazyBuffTime_Party2"] = g["GetTime"]()
						end;
						if bE == g["UnitGUID"]("party3") then
							g["WR_GetCrazyBuffTime_Party3"] = g["GetTime"]()
						end;
						if bE == g["UnitGUID"]("party4") then
							g["WR_GetCrazyBuffTime_Party4"] = g["GetTime"]()
						end
					end
				end
			end
		end)
		g["WR_GetCrazyBuffTimeIsOpen"] = d
	end;
	g["WR_UnitIsHuLueName"] = function(L)
		local cv = g["IsInInstance"]()
		if not cv and g["UnitIsPlayer"](L) then
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
	g["WR_GetNoDebuffRangeUnitCount"] = function(aC, a7, aR)
		local cw = i("0")
		local cx = i("1")
		if g["Time"] ~= e then
			cx = g["Time"]
		end;
		for K = i("1"), i("40"), i("1") do
			local N, w = g["UnitName"]("nameplate" .. K)
			local aG = g["WR_GetUnitRange"]("nameplate" .. K)
			local cy = g["UnitCanAttack"]("player", "nameplate" .. K)
			local cz = g["UnitAffectingCombat"]("nameplate" .. K)
			local cA = g["WR_GetUnitDebuffInfo"]("nameplate" .. K, a7, d)
			local cB = g["UnitCreatureType"]("nameplate" .. K)
			if not g["WR_UnitIsHuLueName"]("nameplate" .. K) then
				if aG ~= e and aG <= aC and cy == d and cA == i("0") and cB ~= "图腾" and cB ~= "Totem" and cB ~= "气体云雾" and cB ~= "Gas Cloud" then
					if cz == d and aR == d or aR ~= d then
						if not g["WR_Invincible"]("nameplate" .. K) then
							cw = cw + i("1")
						end
					end
				end
			end
		end;
		if g["MSG"] == i("1") then
			if aR == d then
				g["print"]("|cff00ff00", aC, "|cffffffff码内，没有中|cffffdf00", a7, "|cffffffff的战斗中的敌人数量为:|cffff5040", cw)
			else
				g["print"]("|cff00ff00", aC, "|cffffffff码内，没有中|cffffdf00", a7, "|cffffffff的敌人数量为:|cffff5040", cw)
			end
		end;
		return cw
	end;
	g["WR_GetHaveDebuffRangeUnitCount"] = function(aC, a7, aR, cn)
		local cw = i("0")
		local cx = i("1")
		if cn ~= e then
			cx = cn
		end;
		for K = i("1"), i("40"), i("1") do
			local cB = g["UnitCreatureType"]("nameplate" .. K)
			if cB ~= "图腾" and cB ~= "Totem" and cB ~= "气体云雾" and cB ~= "Gas Cloud" and g["UnitCanAttack"]("player", "nameplate" .. K) and (aR ~= d or aR == d and g["UnitAffectingCombat"]("nameplate" .. K)) and g["WR_GetUnitRange"]("nameplate" .. K) <= aC and not g["WR_Invincible"]("nameplate" .. K) and g["WR_GetUnitDebuffInfo"]("nameplate" .. K, a7, d) >= cx then
				cw = cw + i("1")
			end
		end;
		if g["MSG"] == i("1") then
			if aR == d then
				g["print"]("|cff00ff00", aC, "|cffffffff码内，中|cffffdf00", a7, "|cffffffff的战斗中的敌人数量为:|cffff5040", cw)
			else
				g["print"]("|cff00ff00", aC, "|cffffffff码内，中|cffffdf00", a7, "|cffffffff的敌人数量为:|cffff5040", cw)
			end
		end;
		return cw
	end;
	g["WR_DamageMitigation"] = function(cC, cD, cE)
		if cE > cD then
			return cC * cD
		end;
		g["DamageMitigation"] = cC * (cE - i("1"))
		for K = cE, cD, i("1") do
			g["DamageMitigation"] = g["DamageMitigation"] + cC * g["math"]["sqrt"]((cE - i("1")) / K)
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
		local cF = {
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
		if g["IsFlying"]() or g["UnitIsDeadOrGhost"]("player") or g["SpellIsTargeting"]() and g["WR_GetUnitBuffTime"]("player", "救赎之魂") == i("0") or g["UnitChannelInfo"]("player") ~= e and g["UnitChannelInfo"]("player") ~= "抚慰之雾" and g["UnitChannelInfo"]("player") ~= "法力茶" and g["UnitChannelInfo"]("player") ~= "时间跳跃" and g["UnitChannelInfo"]("player") ~= "火焰吐息" and g["UnitChannelInfo"]("player") ~= "地壳激变" or g["WR_GetUnitBuffTime"]("player", cF, e, "NAME") ~= i("0") or g["UnitCastingInfo"]("player") ~= e and g["UnitClassBase"]("player") == "PRIEST" and g["GetSpecialization"]() == i("2") then
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
			local bj = i("0")
			for K = i("1"), g["string"]["len"](o), i("1") do
				if g["string"]["byte"](o, K) ~= e then
					bj = bj + g["string"]["byte"](o, K)
				end
			end;
			bj = bj .. g["tonumber"](g["string"]["sub"](o, g["string"]["len"](o) - i("3"), g["string"]["len"](o)))
			return bj
		end;
		return e
	end;
	g["WR_Function_ZNMB"] = function(aC, bl)
		if bl == i("3") then
			return c
		end;
		if g["WR_PartyInCombat"]() and (not g["UnitExists"]("target") or g["UnitIsDead"]("target") or not g["UnitCanAttack"]("player", "target") or bl == i("2") and g["WR_GetUnitRange"]("target") > aC or bl == i("2") and not g["WR_TargetInCombat"]("target")) then
			local ap = "pettarget"
			if not g["UnitIsDead"](ap) and g["UnitCanAttack"]("player", ap) and g["WR_TargetInCombat"](ap) and g["WR_GetUnitRange"](ap) <= aC then
				if g["WR_ColorFrame_Show"]("ACN9", "宠物目标") then
					return d
				end
			end;
			for K = i("1"), i("4"), i("1") do
				local ap = "party" .. K .. "target"
				if g["UnitGroupRolesAssigned"]("party" .. K) == "TANK" and not g["UnitIsDead"](ap) and g["UnitCanAttack"]("player", ap) and g["UnitAffectingCombat"](ap) and g["WR_TargetInCombat"](ap) and g["WR_GetUnitRange"](ap) <= aC then
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
				local ap = "party" .. K .. "target"
				if not g["UnitIsDead"](ap) and g["UnitCanAttack"]("player", ap) and g["UnitAffectingCombat"](ap) and g["WR_TargetInCombat"](ap) and g["WR_GetUnitRange"](ap) <= aC then
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
				if (g["WR_TargetEnemyTime"] == e or g["GetTime"]() - g["WR_TargetEnemyTime"] > i("0.2")) and g["WR_GetRangeHarmUnitCount"](aC) >= i("1") then
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
		-- if not g["WR_CreateColorFramePass"] then
		-- 	return d
		-- end;
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
			local br = g["CreateFrame"]("Frame")
			br["RegisterEvent"](br, "COMBAT_LOG_EVENT_UNFILTERED")
			br["SetScript"](br, "OnEvent", function(bs, bZ)
				local w, cG, w, w, w, w, w, w, bJ, w, w, W = g["CombatLogGetCurrentEventInfo"]()
				if cG == "SPELL_AURA_APPLIED" and bJ == g["UnitName"]("player") then
					if W == i("451568") then
						g["WR_AURA_APPLIED_TIME_451568"] = g["GetTime"]()
					end
				end
			end)
		end;
		g["WR_GetTime_AURA_APPLIED_Open"] = d
	end;
	g["WR_ZNJD"] = function(bj)
		if bj == i("9") then
			return c
		end;
		if g["GetRaidTargetIndex"]("target") ~= e and g["GetRaidTargetIndex"]("target") == i("9") - bj then
			if g["WR_FocusUnit"]("target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("mouseover") ~= e and g["GetRaidTargetIndex"]("mouseover") == i("9") - bj then
			if g["WR_FocusUnit"]("mouseover", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party1target") ~= e and g["GetRaidTargetIndex"]("party1target") == i("9") - bj then
			if g["WR_FocusUnit"]("party1target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party2target") ~= e and g["GetRaidTargetIndex"]("party2target") == i("9") - bj then
			if g["WR_FocusUnit"]("party2target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party3target") ~= e and g["GetRaidTargetIndex"]("party3target") == i("9") - bj then
			if g["WR_FocusUnit"]("party3target", "智能") then
				return d
			end
		elseif g["GetRaidTargetIndex"]("party4target") ~= e and g["GetRaidTargetIndex"]("party4target") == i("9") - bj then
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
	g["WR_GetMyBuffCount"] = function(Y)
		local a2 = i("0")
		g["unit"] = "player"
		if g["WR_GetUnitBuffInfo"](g["unit"], Y, d) > i("0") then
			a2 = a2 + i("1")
		end;
		if g["WR_GetInRaidOrParty"]() == "party" then
			for K = i("1"), i("4"), i("1") do
				g["unit"] = "party" .. K;
				if g["WR_GetUnitBuffInfo"](g["unit"], Y, d) > i("0") then
					a2 = a2 + i("1")
				end
			end
		end;
		if g["WR_GetInRaidOrParty"]() == "raid" then
			for K = i("1"), i("20"), i("1") do
				g["unit"] = "raid" .. K;
				if g["WR_GetUnitBuffInfo"](g["unit"], Y, d) > i("0") then
					a2 = a2 + i("1")
				end
			end
		end;
		if g["MSG"] == i("1") then
			g["print"](Y, "Buff数量:", a2)
		end;
		return a2
	end;
	g["WR_GetLifeParty"] = function(aC)
		local cH = i("1")
		for K = i("1"), i("4"), i("1") do
			g["unit"] = "party" .. K;
			if g["WR_GetUnitRange"](g["unit"]) <= aC and not g["UnitIsDead"](g["unit"]) then
				cH = cH + i("1")
			end
		end;
		return cH
	end;
	g["WR_MessageWindows"] = function(cI)
		local cJ = g["CreateFrame"]("Frame", "WR_MessageFrame", g["UIParent"], "BackdropTemplate")
		cJ["SetSize"](cJ, i("300"), i("110"))
		cJ["SetPoint"](cJ, "CENTER", g["UIParent"], "CENTER", i("0"), i("400"))
		cJ["SetMovable"](cJ, d)
		cJ["EnableMouse"](cJ, d)
		cJ["SetBackdrop"](cJ, {
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
		cJ["EnableMouse"](cJ, d)
		cJ["SetMovable"](cJ, d)
		cJ["RegisterForDrag"](cJ, "LeftButton")
		cJ["SetScript"](cJ, "OnDragStart", function(bs)
			bs["StartMoving"](bs)
		end)
		cJ["SetScript"](cJ, "OnDragStop", function(bs)
			bs["StopMovingOrSizing"](bs)
		end)
		local cK = cJ["CreateFontString"](cJ, e, "ARTWORK", "GameFontNormalLarge")
		cK["SetPoint"](cK, "CENTER")
		cK["SetText"](cK, cI)
		local cL = g["CreateFrame"]("Button", e, cJ, "UIPanelCloseButton")
		cL["SetPoint"](cL, "TOPRIGHT", cJ, "TOPRIGHT")
		cL["SetScript"](cL, "OnClick", function()
			cJ["Hide"](cJ)
		end)
		cJ["Show"](cJ)
	end;
	local cM = "WR_Addon"
	g["C_ChatInfo"]["RegisterAddonMessagePrefix"](cM)
	local br = g["CreateFrame"]("Frame")
	br["RegisterEvent"](br, "CHAT_MSG_ADDON")
	br["RegisterEvent"](br, "PLAYER_ENTERING_WORLD")
	br["RegisterEvent"](br, "ZONE_CHANGED")
	br["SetScript"](br, "OnEvent", function(w, bZ, ...)
		if g["WRSet"] == e then
			return
		end;
		if bZ == "PLAYER_ENTERING_WORLD" or bZ == "ZONE_CHANGED" then
			g["C_ChatInfo"]["SendAddonMessage"](cM, "V" .. g["WR_Addon_Version"], "PARTY")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "PARTY")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "V" .. g["WR_Addon_Version"], "RAID")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "RAID")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "V" .. g["WR_Addon_Version"], "GUILD")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "GUILD")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "V" .. g["WR_Addon_Version"], "INSTANCE_CHAT")
			g["C_ChatInfo"]["SendAddonMessage"](cM, "B" .. g["select"](i("2"), g["BNGetInfo"]()), "INSTANCE_CHAT")
		elseif bZ == "CHAT_MSG_ADDON" then
			local cN, cO, bA, cP = ...
			if cN == cM then
				if not g["UnitAffectingCombat"]("player") then
					if not g["WR_Addon_VersionMessage"] and g["string"]["sub"](cO, i("1"), i("1")) == "V" then
						local cQ = g["string"]["sub"](cO, i("2"))
						if g["tonumber"](cQ) ~= e and g["tonumber"](cQ) > g["tonumber"](g["WR_Addon_Version"]) then
							g["print"](g["C_AddOns"]["GetAddOnMetadata"]("!WR", "Title") .. "发现新的插件版本。")
							g["print"]("当前版本：|cffff94af" .. g["WR_Addon_Version"] .. "|r")
							g["print"]("最新版本：|cffff94af" .. cQ .. "|r")
							g["WR_Addon_VersionMessage"] = d
						end
					end;
					if g["WRSet"]["BNDay"] == e or g["WRSet"]["BNDay"] ~= g["date"]("%Y%m%d") then
						g["WRSet"]["BNFriendTag"] = {}
						g["WRSet"]["BNDay"] = g["date"]("%Y%m%d")
					end;
					if g["string"]["sub"](cO, i("1"), i("1")) == "B" and g["WR_GetBN"](g["select"](i("2"), g["BNGetInfo"]())) == "35935671" and g["WR_GetBN"](g["string"]["sub"](cO, i("2"))) ~= g["WR_GetBN"](g["select"](i("2"), g["BNGetInfo"]())) and bA ~= "GUILD" then
						local cR = d;
						for w, cS in g["pairs"](g["WRSet"]["BNFriendTag"]) do
							if cS == g["string"]["sub"](cO, i("2")) then
								cR = c
							end
						end;
						if cR then
							g["table"]["insert"](g["WRSet"]["BNFriendTag"], g["string"]["sub"](cO, i("2")))
							g["WR_MessageWindows"](cP .. "\n" .. bA .. "\n" .. g["string"]["sub"](cO, i("2")))
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
		local br = g["CreateFrame"]("Frame")
		br["RegisterEvent"](br, "PLAYER_REGEN_DISABLED")
		br["RegisterEvent"](br, "PLAYER_REGEN_ENABLED")
		br["SetScript"](br, "OnEvent", function(bs, bZ)
			if bZ == "PLAYER_REGEN_DISABLED" then
				g["PlayerInCombatTime"] = g["GetTime"]()
			elseif bZ == "PLAYER_REGEN_ENABLED" then
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
	g["WR_IsToyReady"] = function(cT)
		if not g["PlayerHasToy"](cT) then
			return c
		end;
		local u, v, cU = g["GetItemCooldown"](cT)
		if cU == i("0") then
			return c
		end;
		if v == i("0") then
			return d
		end;
		return c
	end;
	g["WRH"] = function(cV, cW)
		local cX = i("85")
		if cV ~= e and cV ~= i("0") then
			cX = cX + cV * i("30")
		end;
		if cW ~= e and cW ~= i("0") then
			cX = cX + i("7") + cW * i("47")
			cX = cX + i("2")
		else
			cX = cX + i("5")
		end;
		return cX
	end;
	g["BGRtoRGB"] = function(cY)
		local cZ = g["math"]["floor"](cY / i("0x10000")) % i("0x100")
		local c_ = g["math"]["floor"](cY / i("0x100")) % i("0x100")
		local d0 = cY % i("0x100")
		d0 = d0 / i("255")
		c_ = c_ / i("255")
		cZ = cZ / i("255")
		if not g["WOW_Robot_Frame"] then
			return i("0"), i("0"), i("0")
		end;
		return d0, c_, cZ
	end;
	g["WR_HideColorFrame"] = function(d1)
		-- if not g["Frame_Number"] then
		-- 	return
		-- end;
		if d1 == e or d1 ~= i("1") then
			for w, br in g["pairs"](g["ColorFrameArrayTopLeft"]) do
				br["Hide"](br)
			end
		end;
		if d1 == i("1") then
			for w, br in g["pairs"](g["ColorFrameArrayTopRight"]) do
				br["Hide"](br)
			end
		end
	end;
	g["WR_MinColorFrame"] = function()
		for w, br in g["pairs"](g["ColorFrameArrayTopLeft"]) do
			br["SetSize"](br, i("10"), i("10"))
		end;
		for w, aV in g["pairs"](g["ColorTextArrayTopLeft"]) do
			aV["Hide"](aV)
		end;
		for w, br in g["pairs"](g["ColorFrameArrayTopRight"]) do
			br["SetSize"](br, i("10"), i("10"))
		end;
		for w, aV in g["pairs"](g["ColorTextArrayTopRight"]) do
			aV["Hide"](aV)
		end
	end;
	g["WR_MaxColorFrame"] = function()
		for w, br in g["pairs"](g["ColorFrameArrayTopLeft"]) do
			br["SetSize"](br, i("42"), i("42"))
		end;
		for w, aV in g["pairs"](g["ColorTextArrayTopLeft"]) do
			aV["Show"](aV)
		end;
		for w, br in g["pairs"](g["ColorFrameArrayTopRight"]) do
			br["SetSize"](br, i("42"), i("42"))
		end;
		for w, aV in g["pairs"](g["ColorTextArrayTopRight"]) do
			aV["Show"](aV)
		end
	end;
	g["WR_ShowColorFrame"] = function(Q, aV, d1)
		-- if not g["Welcome_WOW_Robot"] then
		-- 	return
		-- end;
		if d1 == e or d1 ~= i("1") then
			g["ColorFrameArrayTopLeft"][Q]:Show()
			g["ColorTextArrayTopLeft"][Q]:SetText("|cffffffff" .. aV .. "\n" .. Q)
		else
			g["ColorFrameArrayTopRight"][Q]:Show()
			g["ColorTextArrayTopRight"][Q]:SetText("|cffffffff" .. aV .. "\n" .. Q)
		end
	end;
	g["WR_STOP"] = function(b8)
		if b8 == e or g["type"](b8) ~= "number" then
			g["WR_TemporaryTtopTime"] = i("0.3")
		else
			g["WR_TemporaryTtopTime"] = b8
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