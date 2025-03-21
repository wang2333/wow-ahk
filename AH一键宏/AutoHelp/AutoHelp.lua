local b, c = "LibStub", 2;
local e = _G[b]
if not e or e.minor < c then
	e = e or {
		libs = {},
		minors = {}
	}
	_G[b] = e;
	e.minor = c;
	function e:NewLibrary(f, g)
		assert(type(f) == "string", "Bad argument #2 to `NewLibrary' (string expected)")
		g = assert(tonumber(strmatch(g, "%d+")), "Minor version must either be a number or contain a number.")
		local h = self.minors[f]
		if h and h >= g then
			return nil
		end;
		self.minors[f], self.libs[f] = g, self.libs[f] or {}
		return self.libs[f], h
	end;
	function e:GetLibrary(f, j)
		if not self.libs[f] and not j then
			error(("Cannot find a library instance of %q."):format(tostring(f)), 2)
		end;
		return self.libs[f], self.minors[f]
	end;
	function e:IterateLibraries()
		return pairs(self.libs)
	end;
	setmetatable(e, {
		__call = e.GetLibrary
	})
end;
local function k()
	local l, m = "CallbackHandler-1.0", 7;
	local k = e:NewLibrary(l, m)
	if not k then
		return
	end;
	local n = {
		__index = function(o, p)
			o[p] = {}
			return o[p]
		end
	}
	local q = table.concat;
	local assert, error, loadstring = assert, error, loadstring;
	local setmetatable, rawset, rawget = setmetatable, rawset, rawget;
	local next, select, pairs, type, tostring = next, select, pairs, type, tostring;
	local xpcall = xpcall;
	local function r(s)
		return geterrorhandler()(s)
	end;
	local function t(u, ...)
		local v, w = next(u)
		if not w then
			return
		end;
		repeat
			xpcall(w, r, ...)
			v, w = next(u, v)
		until not w
	end;
	function k:New(x, z, A, B)
		z = z or "RegisterCallback"
		A = A or "UnregisterCallback"
		if B == nil then
			B = "UnregisterAllCallbacks"
		end;
		local C = setmetatable({}, n)
		local D = {
			recurse = 0,
			events = C
		}
		function D:Fire(E, ...)
			if not rawget(C, E) or not next(C[E]) then
				return
			end;
			local F = D.recurse;
			D.recurse = F + 1;
			t(C[E], E, ...)
			D.recurse = F;
			if D.insertQueue and F == 0 then
				for E, G in pairs(D.insertQueue) do
					local H = not rawget(C, E) or not next(C[E])
					for self, I in pairs(G) do
						C[E][self] = I;
						if H and D.OnUsed then
							D.OnUsed(D, x, E)
							H = nil
						end
					end
				end;
				D.insertQueue = nil
			end
		end;
		x[z] = function(self, E, w, ...)
			if type(E) ~= "string" then
				error("Usage: " .. z .. "(eventname, method[, arg]): 'eventname' - string expected.", 2)
			end;
			w = w or E;
			local H = not rawget(C, E) or not next(C[E])
			if type(w) ~= "string" and type(w) ~= "function" then
				error("Usage: " .. z .. "(\"eventname\", \"methodname\"): 'methodname' - string or function expected.", 2)
			end;
			local J;
			if type(w) == "string" then
				if type(self) ~= "table" then
					error("Usage: " .. z .. "(\"eventname\", \"methodname\"): self was not a table?", 2)
				elseif self == x then
					error("Usage: " .. z .. "(\"eventname\", \"methodname\"): do not use Library:" .. z .. "(), use your own 'self'", 2)
				elseif type(self[w]) ~= "function" then
					error("Usage: " .. z .. "(\"eventname\", \"methodname\"): 'methodname' - method '" .. tostring(w) .. "' not found on self.", 2)
				end;
				if select("#", ...) >= 1 then
					local K = select(1, ...)
					J = function(...)
						self[w](self, K, ...)
					end
				else
					J = function(...)
						self[w](self, ...)
					end
				end
			else
				if type(self) ~= "table" and type(self) ~= "string" and type(self) ~= "thread" then
					error("Usage: " .. z .. "(self or \"addonId\", eventname, method): 'self or addonId': table or string or thread expected.", 2)
				end;
				if select("#", ...) >= 1 then
					local K = select(1, ...)
					J = function(...)
						w(K, ...)
					end
				else
					J = w
				end
			end;
			if C[E][self] or D.recurse < 1 then
				C[E][self] = J;
				if D.OnUsed and H then
					D.OnUsed(D, x, E)
				end
			else
				D.insertQueue = D.insertQueue or setmetatable({}, n)
				D.insertQueue[E][self] = J
			end
		end;
		x[A] = function(self, E)
			if not self or self == x then
				error("Usage: " .. A .. "(eventname): bad 'self'", 2)
			end;
			if type(E) ~= "string" then
				error("Usage: " .. A .. "(eventname): 'eventname' - string expected.", 2)
			end;
			if rawget(C, E) and C[E][self] then
				C[E][self] = nil;
				if D.OnUnused and not next(C[E]) then
					D.OnUnused(D, x, E)
				end
			end;
			if D.insertQueue and rawget(D.insertQueue, E) and D.insertQueue[E][self] then
				D.insertQueue[E][self] = nil
			end
		end;
		if B then
			x[B] = function(...)
				if select("#", ...) < 1 then
					error("Usage: " .. B .. "([whatFor]): missing 'self' or \"addonId\" to unregister events for.", 2)
				end;
				if select("#", ...) == 1 and ... == x then
					error("Usage: " .. B .. "([whatFor]): supply a meaningful 'self' or \"addonId\"", 2)
				end;
				for i = 1, select("#", ...) do
					local self = select(i, ...)
					if D.insertQueue then
						for E, G in pairs(D.insertQueue) do
							if G[self] then
								G[self] = nil
							end
						end
					end;
					for E, G in pairs(C) do
						if G[self] then
							G[self] = nil;
							if D.OnUnused and not next(G) then
								D.OnUnused(D, x, E)
							end
						end
					end
				end
			end
		end;
		return D
	end
end;
k()
local function L()
	local M = 24;
	local _G = _G;
	if _G.ChatThrottleLib then
		if _G.ChatThrottleLib.version >= M then
			return
		elseif not _G.ChatThrottleLib.securelyHooked then
			print("ChatThrottleLib: Warning: There's an ANCIENT ChatThrottleLib.lua (pre-wow 2.0, <v16) in an addon somewhere. Get the addon updated or copy in a newer ChatThrottleLib.lua (>=v16) in it!")
			_G.SendChatMessage = _G.ChatThrottleLib.ORIG_SendChatMessage;
			if _G.ChatThrottleLib.ORIG_SendAddonMessage then
				_G.SendAddonMessage = _G.ChatThrottleLib.ORIG_SendAddonMessage
			end
		end;
		_G.ChatThrottleLib.ORIG_SendChatMessage = nil;
		_G.ChatThrottleLib.ORIG_SendAddonMessage = nil
	end;
	if not _G.ChatThrottleLib then
		_G.ChatThrottleLib = {}
	end;
	L = _G.ChatThrottleLib;
	local L = _G.ChatThrottleLib;
	L.version = M;
	L.MAX_CPS = 800;
	L.MSG_OVERHEAD = 40;
	L.BURST = 4000;
	L.MIN_FPS = 20;
	local setmetatable = setmetatable;
	local N = table.remove;
	local tostring = tostring;
	local GetTime = GetTime;
	local O = math.min;
	local P = math.max;
	local next = next;
	local strlen = string.len;
	local GetFramerate = GetFramerate;
	local Q = string.lower;
	local unpack, type, pairs, wipe = unpack, type, pairs, wipe;
	local UnitInRaid, UnitInParty = UnitInRaid, UnitInParty;
	local R = {}
	local S = {
		__index = R
	}
	function R:New()
		local T = {}
		setmetatable(T, S)
		return T
	end;
	function R:Add(U)
		if self.pos then
			U.prev = self.pos.prev;
			U.prev.next = U;
			U.next = self.pos;
			U.next.prev = U
		else
			U.next = U;
			U.prev = U;
			self.pos = U
		end
	end;
	function R:Remove(U)
		U.next.prev = U.prev;
		U.prev.next = U.next;
		if self.pos == U then
			self.pos = U.next;
			if self.pos == U then
				self.pos = nil
			end
		end
	end;
	L.PipeBin = nil;
	local V = setmetatable({}, {
		__mode = "k"
	})
	local function W(X)
		V[X] = true
	end;
	local function Y()
		local X = next(V)
		if X then
			wipe(X)
			V[X] = nil;
			return X
		end;
		return {}
	end;
	L.MsgBin = nil;
	local Z = setmetatable({}, {
		__mode = "k"
	})
	local function a0(a1)
		a1[1] = nil;
		Z[a1] = true
	end;
	local function a2()
		local a1 = next(Z)
		if a1 then
			Z[a1] = nil;
			return a1
		end;
		return {}
	end;
	function L:Init()
		if not self.Prio then
			self.Prio = {}
			self.Prio["ALERT"] = {
				ByName = {},
				Ring = R:New(),
				avail = 0
			}
			self.Prio["NORMAL"] = {
				ByName = {},
				Ring = R:New(),
				avail = 0
			}
			self.Prio["BULK"] = {
				ByName = {},
				Ring = R:New(),
				avail = 0
			}
		end;
		for _, a3 in pairs(self.Prio) do
			a3.nTotalSent = a3.nTotalSent or 0
		end;
		if not self.avail then
			self.avail = 0
		end;
		if not self.nTotalSent then
			self.nTotalSent = 0
		end;
		if not self.Frame then
			self.Frame = CreateFrame("Frame")
			self.Frame:Hide()
		end;
		self.Frame:SetScript("OnUpdate", self.OnUpdate)
		self.Frame:SetScript("OnEvent", self.OnEvent)
		self.Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
		self.OnUpdateDelay = 0;
		self.LastAvailUpdate = GetTime()
		self.HardThrottlingBeginTime = GetTime()
		if not self.securelyHooked then
			self.securelyHooked = true;
			hooksecurefunc("SendChatMessage", function(...)
				return L.Hook_SendChatMessage(...)
			end)
			if _G.C_ChatInfo then
				hooksecurefunc(_G.C_ChatInfo, "SendAddonMessage", function(...)
					return L.Hook_SendAddonMessage(...)
				end)
			else
				hooksecurefunc("SendAddonMessage", function(...)
					return L.Hook_SendAddonMessage(...)
				end)
			end
		end;
		self.nBypass = 0
	end;
	local a4 = false;
	function L.Hook_SendChatMessage(a5, a6, a7, a8, ...)
		if a4 then
			return
		end;
		local self = L;
		local a9 = strlen(tostring(a5 or "")) + strlen(tostring(a8 or "")) + self.MSG_OVERHEAD;
		self.avail = self.avail - a9;
		self.nBypass = self.nBypass + a9
	end;
	function L.Hook_SendAddonMessage(aa, a5, a6, a8, ...)
		if a4 then
			return
		end;
		local self = L;
		local a9 = tostring(a5 or ""):len() + tostring(aa or ""):len()
		a9 = a9 + tostring(a8 or ""):len() + self.MSG_OVERHEAD;
		self.avail = self.avail - a9;
		self.nBypass = self.nBypass + a9
	end;
	function L:UpdateAvail()
		local ab = GetTime()
		local ac = self.MAX_CPS;
		local ad = ac * (ab - self.LastAvailUpdate)
		local ae = self.avail;
		if ab - self.HardThrottlingBeginTime < 5 then
			ae = O(ae + ad * 0.1, ac * 0.5)
			self.bChoking = true
		elseif GetFramerate() < self.MIN_FPS then
			ae = O(ac, ae + ad * 0.5)
			self.bChoking = true
		else
			ae = O(self.BURST, ae + ad)
			self.bChoking = false
		end;
		ae = P(ae, 0 - ac * 2)
		self.avail = ae;
		self.LastAvailUpdate = ab;
		return ae
	end;
	function L:Despool(a3)
		local af = a3.Ring;
		while af.pos and a3.avail > af.pos[1].nSize do
			local a1 = N(af.pos, 1)
			if not af.pos[1] then
				local X = a3.Ring.pos;
				a3.Ring:Remove(X)
				a3.ByName[X.name] = nil;
				W(X)
			else
				a3.Ring.pos = a3.Ring.pos.next
			end;
			local ag = false;
			local ah = Q(a1[3] or "")
			if ah == "raid" and not UnitInRaid("player") then
			elseif ah == "party" and not UnitInParty("player") then
			else
				a3.avail = a3.avail - a1.nSize;
				a4 = true;
				a1.f(unpack(a1, 1, a1.n))
				a4 = false;
				a3.nTotalSent = a3.nTotalSent + a1.nSize;
				a0(a1)
				ag = true
			end;
			if a1.callbackFn then
				a1.callbackFn(a1.callbackArg, ag)
			end
		end
	end;
	function L.OnEvent(ai, aj)
		local self = L;
		if aj == "PLAYER_ENTERING_WORLD" then
			self.HardThrottlingBeginTime = GetTime()
			self.avail = 0
		end
	end;
	function L.OnUpdate(ai, ak)
		local self = L;
		self.OnUpdateDelay = self.OnUpdateDelay + ak;
		if self.OnUpdateDelay < 0.08 then
			return
		end;
		self.OnUpdateDelay = 0;
		self:UpdateAvail()
		if self.avail < 0 then
			return
		end;
		local al = 0;
		for am, a3 in pairs(self.Prio) do
			if a3.Ring.pos or a3.avail < 0 then
				al = al + 1
			end
		end;
		if al < 1 then
			for am, a3 in pairs(self.Prio) do
				self.avail = self.avail + a3.avail;
				a3.avail = 0
			end;
			self.bQueueing = false;
			self.Frame:Hide()
			return
		end;
		local ae = self.avail / al;
		self.avail = 0;
		for am, a3 in pairs(self.Prio) do
			if a3.Ring.pos or a3.avail < 0 then
				a3.avail = a3.avail + ae;
				if a3.Ring.pos and a3.avail > a3.Ring.pos[1].nSize then
					self:Despool(a3)
				end
			end
		end
	end;
	function L:Enqueue(am, an, a1)
		local a3 = self.Prio[am]
		local X = a3.ByName[an]
		if not X then
			self.Frame:Show()
			X = Y()
			X.name = an;
			a3.ByName[an] = X;
			a3.Ring:Add(X)
		end;
		X[# X + 1] = a1;
		self.bQueueing = true
	end;
	function L:SendChatMessage(ao, aa, a5, a6, a7, a8, ap, aq, ar)
		if not self or not ao or not aa or not a5 or not self.Prio[ao] then
			error('Usage: ChatThrottleLib:SendChatMessage("{BULK||NORMAL||ALERT}", "prefix", "text"[, "chattype"[, "language"[, "destination"]]]', 2)
		end;
		if aq and type(aq) ~= "function" then
			error('ChatThrottleLib:ChatMessage(): callbackFn: expected function, got ' .. type(aq), 2)
		end;
		local as = a5:len()
		if as > 255 then
			error("ChatThrottleLib:SendChatMessage(): message length cannot exceed 255 bytes", 2)
		end;
		as = as + self.MSG_OVERHEAD;
		if not self.bQueueing and as < self:UpdateAvail() then
			self.avail = self.avail - as;
			a4 = true;
			_G.SendChatMessage(a5, a6, a7, a8)
			a4 = false;
			self.Prio[ao].nTotalSent = self.Prio[ao].nTotalSent + as;
			if aq then
				aq(ar, true)
			end;
			return
		end;
		local a1 = a2()
		a1.f = _G.SendChatMessage;
		a1[1] = a5;
		a1[2] = a6 or "SAY"
		a1[3] = a7;
		a1[4] = a8;
		a1.n = 4;
		a1.nSize = as;
		a1.callbackFn = aq;
		a1.callbackArg = ar;
		self:Enqueue(ao, ap or aa .. (a6 or "SAY") .. (a8 or ""), a1)
	end;
	function L:SendAddonMessage(ao, aa, a5, a6, x, ap, aq, ar)
		if not self or not ao or not aa or not a5 or not a6 or not self.Prio[ao] then
			error('Usage: ChatThrottleLib:SendAddonMessage("{BULK||NORMAL||ALERT}", "prefix", "text", "chattype"[, "target"])', 2)
		end;
		if aq and type(aq) ~= "function" then
			error('ChatThrottleLib:SendAddonMessage(): callbackFn: expected function, got ' .. type(aq), 2)
		end;
		local as = a5:len()
		if C_ChatInfo or RegisterAddonMessagePrefix then
			if as > 255 then
				error("ChatThrottleLib:SendAddonMessage(): message length cannot exceed 255 bytes", 2)
			end
		else
			as = as + aa:len() + 1;
			if as > 255 then
				error("ChatThrottleLib:SendAddonMessage(): prefix + message length cannot exceed 254 bytes", 2)
			end
		end;
		as = as + self.MSG_OVERHEAD;
		if not self.bQueueing and as < self:UpdateAvail() then
			self.avail = self.avail - as;
			a4 = true;
			if _G.C_ChatInfo then
				_G.C_ChatInfo.SendAddonMessage(aa, a5, a6, x)
			else
				_G.SendAddonMessage(aa, a5, a6, x)
			end;
			a4 = false;
			self.Prio[ao].nTotalSent = self.Prio[ao].nTotalSent + as;
			if aq then
				aq(ar, true)
			end;
			return
		end;
		local a1 = a2()
		a1.f = _G.C_ChatInfo and _G.C_ChatInfo.SendAddonMessage or _G.SendAddonMessage;
		a1[1] = aa;
		a1[2] = a5;
		a1[3] = a6;
		a1[4] = x;
		a1.n = x ~= nil and 4 or 3;
		a1.nSize = as;
		a1.callbackFn = aq;
		a1.callbackArg = ar;
		self:Enqueue(ao, ap or aa .. a6 .. (x or ""), a1)
	end;
	L:Init()
end;
L()
local function at()
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		return
	end;
	local f = "LibHealComm-4.0"
	local g = 200;
	assert(e, format("%s requires LibStub.", f))
	local au = e:NewLibrary(f, g)
	if not au then
		return
	end;
	local av = "LHC40"
	C_ChatInfo.RegisterAddonMessagePrefix(av)
	local bit = bit;
	local ceil = ceil;
	local error = error;
	local floor = floor;
	local format = format;
	local gsub = gsub;
	local max = max;
	local min = min;
	local pairs = pairs;
	local ipairs = ipairs;
	local rawset = rawset;
	local select = select;
	local setmetatable = setmetatable;
	local strlen = strlen;
	local strmatch = strmatch;
	local strsplit = strsplit;
	local strsub = strsub;
	local tinsert = tinsert;
	local tonumber = tonumber;
	local tremove = tremove;
	local type = type;
	local unpack = unpack;
	local wipe = wipe;
	local GetBuildInfo = GetBuildInfo;
	local aw = C_Seasons.HasActiveSeason;
	local ax = C_Seasons.GetActiveSeason;
	local Ambiguate = Ambiguate;
	local CastingInfo = CastingInfo;
	local ChannelInfo = ChannelInfo;
	local CreateFrame = CreateFrame;
	local GetInventoryItemLink = GetInventoryItemLink;
	local GetInventorySlotInfo = GetInventorySlotInfo;
	local GetNumGroupMembers = GetNumGroupMembers;
	local GetNumTalents = GetNumTalents;
	local GetNumTalentTabs = GetNumTalentTabs;
	local GetRaidRosterInfo = GetRaidRosterInfo;
	local GetSpellBonusHealing = GetSpellBonusHealing;
	local GetSpellCritChance = GetSpellCritChance;
	local GetSpellInfo = GetSpellInfo;
	local GetTalentInfo = GetTalentInfo;
	local GetTime = GetTime;
	local GetZonePVPInfo = GetZonePVPInfo;
	local hooksecurefunc = hooksecurefunc;
	local InCombatLockdown = InCombatLockdown;
	local IsEquippedItem = IsEquippedItem;
	local IsInGroup = IsInGroup;
	local IsInInstance = IsInInstance;
	local IsInRaid = IsInRaid;
	local IsLoggedIn = IsLoggedIn;
	local IsSpellInRange = IsSpellInRange;
	local SpellIsTargeting = SpellIsTargeting;
	local UnitAura = UnitAura;
	local UnitCanAssist = UnitCanAssist;
	local UnitExists = UnitExists;
	local UnitBuff = UnitBuff;
	local UnitGUID = UnitGUID;
	local UnitIsCharmed = UnitIsCharmed;
	local UnitIsVisible = UnitIsVisible;
	local UnitInRaid = UnitInRaid;
	local UnitLevel = UnitLevel;
	local UnitName = UnitName;
	local UnitPlayerControlled = UnitPlayerControlled;
	local CheckInteractDistance = CheckInteractDistance;
	local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo;
	local UnitHasVehicleUI = UnitHasVehicleUI or function()
	end;
	local GetGlyphSocketInfo = GetGlyphSocketInfo or function()
	end;
	local GetNumGlyphSockets = GetNumGlyphSockets or function()
		return 0
	end;
	local C_Engraving = C_Engraving;
	local MAX_RAID_MEMBERS = MAX_RAID_MEMBERS;
	local MAX_PARTY_MEMBERS = MAX_PARTY_MEMBERS;
	local COMBATLOG_OBJECT_AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE;
	local ay = floor(select(4, GetBuildInfo()) / 10000)
	local az = ay == 2;
	local aA = ay == 3;
	local aB = ay == 1;
	local aC = aw() and ax() == (Enum.SeasonID.SeasonOfDiscovery or Enum.SeasonID.Placeholder) and aB;
	local aD = {
		[1] = {
			774,
			8936,
			5185,
			740,
			635,
			19750,
			139,
			2060,
			596,
			2061,
			2054,
			2050,
			1064,
			331,
			8004,
			136,
			755,
			689,
			746,
			33763,
			32546,
			37563,
			48438,
			61295,
			51945,
			50464,
			47757,
			408120,
			408124,
			402277,
			415236,
			415240,
			412510,
			401417,
			417057,
			425268,
			436937,
			408247,
			20473,
			47540,
			61295
		},
		[2] = {
			1058,
			8938,
			5186,
			8918,
			639,
			19939,
			6074,
			10963,
			996,
			9472,
			2055,
			2052,
			10622,
			332,
			8008,
			3111,
			3698,
			699,
			1159,
			53248,
			61299,
			51990,
			48450,
			52986,
			48119,
			417058,
			425269,
			436938,
			20929,
			53005,
			61299
		},
		[3] = {
			1430,
			8939,
			5187,
			9862,
			647,
			19940,
			6075,
			10964,
			10960,
			9473,
			6063,
			2053,
			10623,
			547,
			8010,
			3661,
			3699,
			709,
			3267,
			53249,
			61300,
			51997,
			48451,
			52987,
			48120,
			417059,
			425270,
			436939,
			20930,
			53006,
			61300
		},
		[4] = {
			2090,
			8940,
			5188,
			9863,
			1026,
			19941,
			6076,
			10965,
			10961,
			9474,
			6064,
			913,
			10466,
			3662,
			3700,
			7651,
			3268,
			25422,
			53251,
			61301,
			51998,
			52988,
			417060,
			425271,
			436940,
			27174,
			53007,
			61301
		},
		[5] = {
			2091,
			8941,
			5189,
			1042,
			19942,
			6077,
			22009,
			25314,
			25316,
			10915,
			939,
			10467,
			13542,
			11693,
			11699,
			7926,
			25423,
			26983,
			51999,
			417061,
			425272,
			436942,
			33072
		},
		[6] = {
			3627,
			9750,
			6778,
			3472,
			19943,
			6078,
			10916,
			959,
			10468,
			13543,
			11694,
			11700,
			7927,
			23569,
			24412,
			25210,
			25308,
			52000,
			55458,
			48446,
			417062,
			425273,
			436943,
			48824
		},
		[7] = {
			8910,
			9856,
			8903,
			10328,
			10927,
			10917,
			8005,
			13544,
			11695,
			10838,
			27137,
			25213,
			25420,
			27219,
			55459,
			48447,
			48072,
			417063,
			425274,
			436944,
			48825
		},
		[8] = {
			9839,
			9857,
			9758,
			10329,
			10928,
			10395,
			10839,
			23568,
			24413,
			25233,
			27259,
			27220,
			27046,
			48784,
			49275,
			48062,
			417064,
			425275,
			436945
		},
		[9] = {
			9840,
			9858,
			9888,
			25292,
			10929,
			10396,
			18608,
			25235,
			48785,
			49276,
			48063,
			48989,
			47856,
			47857,
			417065,
			425276,
			436946
		},
		[10] = {
			9841,
			9889,
			25315,
			25357,
			18610,
			23567,
			24414,
			26980,
			27135,
			48070,
			48990,
			417066,
			425277
		},
		[11] = {
			25299,
			25297,
			30020,
			27136,
			25221,
			25391,
			27030,
			48442,
			48071,
			417068
		},
		[12] = {
			26981,
			26978,
			25222,
			25396,
			27031,
			48781,
			48443
		},
		[13] = {
			26982,
			26979,
			48782,
			49272,
			48067,
			45543
		},
		[14] = {
			49273,
			48377,
			48440,
			48068,
			51827
		},
		[15] = {
			48378,
			48441,
			45544
		},
		[16] = {
			51803
		}
	}
	au.spellRankTableData = aD;
	local aE = {}
	for aF, aG in pairs(aD) do
		for _, aH in pairs(aG) do
			aE[aH] = aF
		end
	end;
	local aI = 15;
	local aJ = 1;
	local aK = 2;
	local aL = 4;
	local aM = 8;
	local aN = 16;
	local aO = bit.bor(aJ, aK, aL, aN)
	local aP = bit.bor(aJ, aK)
	local aQ = bit.bor(aL, aK)
	local aR = bit.bor(aL, aK, aN)
	au.ALL_HEALS, au.OVERTIME_HEALS, au.OVERTIME_AND_BOMB_HEALS, au.CHANNEL_HEALS, au.DIRECT_HEALS, au.HOT_HEALS, au.CASTED_HEALS, au.ABSORB_SHIELDS, au.ALL_DATA, au.BOMB_HEALS = aO, aQ, aR, aK, aJ, aL, aP, aM, aI, aN;
	local aS, aT, aU;
	local aV = 1;
	au.callbacks = au.callbacks or e:GetLibrary("CallbackHandler-1.0"):New(au)
	au.activeHots = au.activeHots or {}
	au.activePets = au.activePets or {}
	au.equippedSetCache = au.equippedSetCache or {}
	au.guidToGroup = au.guidToGroup or {}
	au.guidToUnit = au.guidToUnit or {}
	au.hotData = au.hotData or {}
	au.itemSetsData = au.itemSetsData or {}
	au.pendingHeals = au.pendingHeals or {}
	au.pendingHots = au.pendingHots or {}
	au.spellData = au.spellData or {}
	au.talentData = au.talentData or {}
	au.tempPlayerList = au.tempPlayerList or {}
	au.glyphCache = au.glyphCache or {}
	if not au.unitToPet then
		au.unitToPet = {
			["player"] = "pet"
		}
		for i = 1, MAX_PARTY_MEMBERS do
			au.unitToPet["party" .. i] = "partypet" .. i
		end;
		for i = 1, MAX_RAID_MEMBERS do
			au.unitToPet["raid" .. i] = "raidpet" .. i
		end
	end;
	local aW, aX, aY, aZ, a_ = au.spellData, au.hotData, au.tempPlayerList, au.pendingHeals, au.pendingHots;
	local b0, b1, b2 = au.equippedSetCache, au.itemSetsData, au.talentData;
	local b3, b4 = au.activeHots, au.activePets;
	local b5 = select(2, UnitClass("player"))
	if not au.compressGUID then
		au.compressGUID = setmetatable({}, {
			__index = function(o, b6)
				local b7;
				if strsub(b6, 1, 6) ~= "Player" then
					for b8, b9 in pairs(b4) do
						if b9 == b6 and UnitExists(b8) then
							b7 = "p-" .. strmatch(UnitGUID(b8), "^%w*-([-%w]*)$")
						end
					end;
					if not b7 then
						return nil
					end
				else
					b7 = strmatch(b6, "^%w*-([-%w]*)$")
				end;
				rawset(o, b6, b7)
				return b7
			end
		})
		au.decompressGUID = setmetatable({}, {
			__index = function(o, b7)
				if not b7 then
					return nil
				end;
				local b6;
				if strsub(b7, 1, 2) == "p-" then
					local b8 = au.guidToUnit["Player-" .. strsub(b7, 3)]
					if not b8 then
						return nil
					end;
					b6 = b4[b8]
				else
					b6 = "Player-" .. b7
				end;
				rawset(o, b7, b6)
				return b6
			end
		})
	end;
	local ba, bb = au.compressGUID, au.decompressGUID;
	if not au.tableCache then
		au.tableCache = setmetatable({}, {
			__mode = "k"
		})
		function au:RetrieveTable()
			return tremove(au.tableCache, 1) or {}
		end;
		function au:DeleteTable(o)
			wipe(o)
			tinsert(au.tableCache, o)
		end
	end;
	if not au.tooltip then
		local bc = CreateFrame("GameTooltip")
		bc:SetOwner(UIParent, "ANCHOR_NONE")
		bc.TextLeft1 = bc:CreateFontString()
		bc.TextRight1 = bc:CreateFontString()
		bc:AddFontStrings(bc.TextLeft1, bc.TextRight1)
		au.tooltip = bc
	end;
	local function bd(be, b6, amount, bf, bg, bh)
		if be[b6] then
			local bi = be[b6]
			be[bi] = b6;
			be[bi + 1] = amount;
			be[bi + 2] = bf;
			be[bi + 3] = bg or 0;
			be[bi + 4] = bh or 0
		else
			be[b6] = # be + 1;
			tinsert(be, b6)
			tinsert(be, amount)
			tinsert(be, bf)
			tinsert(be, bg or 0)
			tinsert(be, bh or 0)
			if be.bitType == aL then
				b3[b6] = (b3[b6] or 0) + 1;
				au.hotMonitor:Show()
			end
		end
	end;
	local function bj(be, b6)
		local bi = be[b6]
		if not bi then
			return nil
		end;
		return be[bi + 1], be[bi + 2], be[bi + 3], be[bi + 4]
	end;
	local function bk(be, b6)
		local bi = be[b6]
		if not bi then
			return nil
		end;
		tremove(be, bi + 4)
		tremove(be, bi + 3)
		tremove(be, bi + 2)
		local amount = tremove(be, bi + 1)
		tremove(be, bi)
		be[b6] = nil;
		if type(amount) == "table" then
			au:DeleteTable(amount)
		end;
		if be.bitType == aL and b3[b6] then
			b3[b6] = b3[b6] - 1;
			b3[b6] = b3[b6] > 0 and b3[b6] or nil
		end;
		for i = 1, # be, 5 do
			local b6 = be[i]
			if be[b6] > bi then
				be[b6] = be[b6] - 5
			end
		end
	end;
	local function bl(be, bm, bn, ...)
		for i = 1, select("#", ...), bm do
			local b6 = select(i, ...)
			b6 = bn and bb[b6] or b6;
			if b6 then
				local bi = be[b6]
				tremove(be, bi + 4)
				tremove(be, bi + 3)
				tremove(be, bi + 2)
				local amount = tremove(be, bi + 1)
				tremove(be, bi)
				be[b6] = nil;
				if type(amount) == "table" then
					au:DeleteTable(amount)
				end
			end
		end;
		for i = 1, # be, 5 do
			be[be[i]] = i
		end
	end;
	local function bo(b6)
		local bp;
		for _, o in pairs({
			aZ,
			a_
		}) do
			for _, bq in pairs(o) do
				for _, be in pairs(bq) do
					if be.bitType and be[b6] then
						local bi = be[b6]
						tremove(be, bi + 4)
						tremove(be, bi + 3)
						tremove(be, bi + 2)
						local amount = tremove(be, bi + 1)
						tremove(be, bi)
						be[b6] = nil;
						if type(amount) == "table" then
							au:DeleteTable(amount)
						end;
						if # be > 0 then
							for i = 1, # be, 5 do
								local b6 = be[i]
								if be[b6] > bi then
									be[b6] = be[b6] - 5
								end
							end
						else
							wipe(be)
						end;
						bp = true
					end
				end
			end
		end;
		b3[b6] = nil;
		if bp then
			au.callbacks:Fire("HealComm_GUIDDisappeared", b6)
		end
	end;
	au.removeRecordList = bl;
	au.removeRecord = bk;
	au.getRecord = bj;
	au.updateRecord = bd;
	local function br()
		for _, o in pairs({
			aZ,
			a_
		}) do
			for bs, bq in pairs(o) do
				for _, be in pairs(bq) do
					if be.bitType then
						wipe(aY)
						for i = # be, 1, - 5 do
							tinsert(aY, be[i - 4])
						end;
						if # aY > 0 then
							local aH, bt = be.spellID, be.bitType;
							wipe(be)
							au.callbacks:Fire("HealComm_HealStopped", bs, aH, bt, true, unpack(aY))
						end
					end
				end
			end
		end
	end;
	function au:GetPlayerHealingMod()
		return aV or 1
	end;
	function au:GetHealModifier(b6)
		return au.currentModifiers[b6] or 1
	end;
	function au:GUIDHasHealed(b6)
		return (aZ[b6] or a_[b6]) and true or nil
	end;
	function au:GetGUIDUnitMapTable()
		if not au.protectedMap then
			au.protectedMap = setmetatable({}, {
				__index = function(o, p)
					return au.guidToUnit[p]
				end,
				__newindex = function()
					error("This is a read only table and cannot be modified.", 2)
				end,
				__metatable = false
			})
		end;
		return au.protectedMap
	end;
	function au:GetTimeframeHealAmount(b6, bu, bv, time, bw, bx)
		local by, bz;
		local bA = 0;
		local bB = bv or GetTime()
		if bv and time and bv > time then
			return
		end;
		for _, o in pairs({
			aZ,
			a_
		}) do
			for bs, bq in pairs(o) do
				if (not bw or bw ~= bs) and (not bx or bx == bs) then
					for _, be in pairs(bq) do
						if be.bitType and bit.band(be.bitType, bu) > 0 then
							for i = 1, # be, 5 do
								local bC = be[i]
								if not b6 or bC == b6 then
									local amount = be[i + 1]
									local bf = be[i + 2]
									local bg = be[i + 3]
									bg = bg > 0 and bg or be.endTime;
									if (be.bitType == aJ or be.bitType == aN) and (not time or not bv or bv <= bg and bg <= time) then
										if not bz or bg < bz then
											bz = bg;
											by = bs;
											bA = bA + amount * bf
										end
									elseif be.bitType == aK or be.bitType == aL then
										local bh = be[i + 4]
										local bD = bg - bB;
										local bE = time - bB;
										local bF = floor(min(bE, bD) / be.tickInterval)
										local bG = bD % be.tickInterval;
										local bH = bE % be.tickInterval;
										if bG > 0 and bG < bH then
											bF = bF + 1
										end;
										bA = bA + amount * bf * min(bF, bh)
									end
								end
							end
						end
					end
				end
			end
		end;
		return bA, by, bz
	end;
	function au:GetNextHealAmount(b6, bu, time, bw, bx)
		local bz, bA, by;
		local bB = GetTime()
		for _, o in pairs({
			aZ,
			a_
		}) do
			for bs, bq in pairs(o) do
				if (not bw or bw ~= bs) and (not bx or bx == bs) then
					for _, be in pairs(bq) do
						if be.bitType and bit.band(be.bitType, bu) > 0 then
							for i = 1, # be, 5 do
								local bC = be[i]
								if not b6 or bC == b6 then
									local amount = be[i + 1]
									local bf = be[i + 2]
									local bg = be[i + 3]
									bg = bg > 0 and bg or be.endTime;
									if (be.bitType == aJ or be.bitType == aN) and (not time or bg <= time) then
										if not bz or bg < bz then
											bz = bg;
											bA = amount * bf;
											by = bs
										end
									elseif be.bitType == aK or be.bitType == aL then
										local bD = time and time - bB or bg - bB;
										local bI = bB + bD % be.tickInterval;
										if not bz or bI < bz then
											bz = bI;
											if be.hasVariableTicks then
												bA = amount[be.totalTicks - be[i + 4] + 1]
											else
												bA = amount * bf
											end;
											by = bs
										end
									end
								end
							end
						end
					end
				end
			end
		end;
		return bz, by, bA
	end;
	local function bJ(bq, bK, bu, time, bw)
		local bA = 0;
		local bB = GetTime()
		if bq then
			for _, be in pairs(bq) do
				if be.bitType and bit.band(be.bitType, bu) > 0 then
					for i = 1, # be, 5 do
						local b6 = be[i]
						if b6 == bK or bw then
							local amount = be[i + 1]
							local bf = be[i + 2]
							local bg = be[i + 3]
							bg = bg > 0 and bg or be.endTime;
							if (be.bitType == aJ or be.bitType == aN) and (not time or bg <= time) then
								bA = bA + amount * bf
							elseif (be.bitType == aK or be.bitType == aL) and bg > bB then
								local bh = be[i + 4]
								if not time or time >= bg then
									if not be.hasVariableTicks then
										bA = bA + amount * bf * bh
									else
										local bL = be.totalTicks - bh;
										for bM, bN in pairs(amount) do
											if bM > bL then
												bA = bA + bN * bf
											end
										end
									end
								else
									local bD = bg - bB;
									local bE = time - bB;
									local bF = floor(min(bE, bD) / be.tickInterval)
									local bG = bD % be.tickInterval;
									local bH = bE % be.tickInterval;
									if bG > 0 and bG < bH then
										bF = bF + 1
									end;
									if not be.hasVariableTicks then
										bA = bA + amount * bf * min(bF, bh)
									else
										local bL = be.totalTicks - bh;
										for bM, bN in ipairs(amount) do
											if bM > bL then
												bA = bA + bN * bf
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end;
		return bA
	end;
	function au:GetHealAmount(b6, bu, time, bs)
		local amount = 0;
		if bs and (aZ[bs] or a_[bs]) then
			amount = bJ(aZ[bs], b6, bu, time) + bJ(a_[bs], b6, bu, time)
		elseif not bs then
			for _, o in pairs({
				aZ,
				a_
			}) do
				for _, bq in pairs(o) do
					amount = amount + bJ(bq, b6, bu, time)
				end
			end
		end;
		return amount > 0 and amount or nil
	end;
	function au:GetOthersHealAmount(b6, bu, time)
		local amount = 0;
		for _, o in pairs({
			aZ,
			a_
		}) do
			for bs, bq in pairs(o) do
				if bs ~= aS then
					amount = amount + bJ(bq, b6, bu, time)
				end
			end
		end;
		return amount > 0 and amount or nil
	end;
	function au:GetCasterHealAmount(b6, bu, time)
		local amount = aZ[b6] and bJ(aZ[b6], nil, bu, time, true) or 0;
		amount = amount + (a_[b6] and bJ(a_[b6], nil, bu, time, true) or 0)
		return amount > 0 and amount or nil
	end;
	function au:GetHealAmountEx(bO, bP, bQ, bx, bR, bS)
		local bT = 0;
		local bU = 0;
		local bV = 0;
		local bW = 0;
		local bX = GetTime()
		bP = bP or aO;
		bR = bR or aO;
		for _, o in ipairs({
			aZ,
			a_
		}) do
			for bs, bq in pairs(o) do
				local time;
				if bs ~= bx then
					time = bQ
				else
					time = bS
				end;
				if bq then
					for _, be in pairs(bq) do
						local bt = be.bitType or 0;
						if bs ~= bx then
							bt = bit.band(bt, bP)
						else
							bt = bit.band(bt, bR)
						end;
						if bt > 0 then
							for i = 1, # be, 5 do
								local bC = be[i]
								if bC == bO then
									local amount = 0;
									if not be.hasVariableTicks then
										amount = be[i + 1]
									end;
									local bf = be[i + 2]
									local bg = be[i + 3]
									bg = bg > 0 and bg or be.endTime;
									if bg > bX then
										amount = amount * bf;
										local bY = 0;
										local bZ = 0;
										if bt == aJ or bt == aN then
											if not time or bg <= time then
												bY = amount
											end;
											bZ = amount
										elseif bt == aL or bt == aK then
											local bh = be[i + 4]
											local bF;
											if not time then
												bF = 1
											elseif time >= bg then
												bF = bh
											else
												local b_ = be.tickInterval;
												local bD = bg - bX;
												local bE = max(time - bX, 0)
												bF = floor(min(bE, bD) / b_)
												local bG = bD % b_;
												local bH = bE % b_;
												if bG > 0 and bG < bH then
													bF = bF + 1
												end
											end;
											if bF > bh then
												bF = bh
											end;
											if not be.hasVariableTicks then
												bY = amount * bF;
												bZ = amount * bh
											else
												amount = be[i + 1]
												bY = amount[be.totalTicks - be[i + 4] + 1] or 0;
												local bL = be.totalTicks - bh;
												for bM, bN in ipairs(amount) do
													if bM > bL then
														bZ = bZ + bN * bf
													end
												end
											end
										end;
										if bs ~= bx then
											bT = bT + bY;
											bU = bU + bZ
										else
											bV = bV + bY;
											bW = bW + bZ
										end
									end
								end
							end
						end
					end
				end
			end
		end;
		bU = bU - bT;
		bW = bW - bV;
		bT = bT > 0 and bT or nil;
		bU = bU > 0 and bU or nil;
		bV = bV > 0 and bV or nil;
		bW = bW > 0 and bW or nil;
		return bT, bU, bV, bW
	end;
	function au:GetNumHeals(bK, time)
		local c0 = 0;
		for _, bq in pairs(aZ) do
			if bq then
				for _, be in pairs(bq) do
					for i = 1, # be, 5 do
						local b6 = be[i]
						if b6 == bK then
							local bg = be[i + 3]
							bg = bg > 0 and bg or be.endTime;
							if be.bitType == aJ and (not time or bg <= time) then
								c0 = c0 + 1
							end
						end
					end
				end
			end
		end;
		return c0
	end;
	local c1;
	local c2, c3, c4 = au.guidToUnit, au.guidToGroup, au.glyphCache;
	local c5;
	do
		local c6 = AuraUtil.FindAura;
		local c7 = AuraUtil.FindAuraByName;
		local function c8(c9, _, _, _, _, _, _, _, _, _, _, _, ca)
			return c9 == ca
		end;
		local function cb(ca, b8, cc)
			return c6(c8, b8, cc, ca)
		end;
		function c5(b8, cd)
			if type(cd) == "number" then
				return cb(cd, b8)
			else
				return c7(cd, b8)
			end
		end
	end;
	local function ce(cf, amount, cg, ch, ci)
		cf = cf or aC and aU;
		local cj = cf > 20 and 1 or 1 - (20 - cf) * 0.0375;
		if aA then
			cj = min(1, max(0, (22 + cf + 5 - aU) / 20))
		elseif az then
			cj = cj * min(1, (cf + 11) / aU)
		end;
		cg = cg * cj;
		return ci * (amount + cg * ch)
	end;
	local function ck(cl)
		return cl / 3.5
	end;
	local function cm(cn)
		return cn / 15
	end;
	local function co(a, cp)
		return (a + cp) / 2
	end;
	local cq, cr, cs, ct, cu, cv;
	local function cw(aW, cx, aH, cy)
		if aH == 37563 then
			aW = aW["37563"]
		else
			aW = aW[cx]
		end;
		local cz = aW.averages[cy]
		if type(cz) == "number" then
			return cz
		end;
		local cA = aW.levels[cy] or aC and 1;
		return cz[min(aU - cA + 1, # cz)]
	end;
	local function cB(cC, cD, cE, cF)
		local cG = {}
		for cH = 1, 60 do
			cG[cH] = cD * (cC + cE * cH + cF * cH * cH)
		end;
		return {
			cG
		}
	end;
	if b5 == "DRUID" then
		cv = function()
			local cI = GetSpellInfo(17104)
			local cJ = GetSpellInfo(5185)
			local cK = GetSpellInfo(17111)
			local cL = GetSpellInfo(1126)
			local cM = GetSpellInfo(8936)
			local cN = GetSpellInfo(774)
			local cO = GetSpellInfo(740)
			local cP = GetSpellInfo(33763) or "Lifebloom"
			local cQ = GetSpellInfo(33886) or "Empowered Rejuv"
			local cR = GetSpellInfo(33879) or "Empowered Touch"
			local cS = GetSpellInfo(48438) or "Wild Growth"
			local cT = GetSpellInfo(50464) or "Nourish"
			local cU = GetSpellInfo(48411) or "Master Shapeshifter"
			local cV = GetSpellInfo(57810) or "Genesis"
			local cW = GetSpellInfo(57865) or "Natures Splendor"
			local cX = GetSpellInfo(33891) or "Tree of Life"
			aX[cM] = {
				interval = 3,
				ticks = 7,
				coeff = (az or aA) and 0.7 or 0.5,
				levels = {
					12,
					18,
					24,
					30,
					36,
					42,
					48,
					54,
					60,
					65,
					71,
					77
				},
				averages = {
					98,
					175,
					259,
					343,
					427,
					546,
					686,
					861,
					1064,
					1274,
					1792,
					2345
				}
			}
			aX[cN] = {
				interval = 3,
				levels = {
					4,
					10,
					16,
					22,
					28,
					34,
					40,
					46,
					52,
					58,
					60,
					63,
					69
				},
				averages = {
					32,
					56,
					116,
					180,
					244,
					304,
					388,
					488,
					608,
					756,
					888,
					932,
					1060
				}
			}
			if aA then
				aX[cN] = {
					interval = 3,
					levels = {
						4,
						10,
						16,
						22,
						28,
						34,
						40,
						46,
						52,
						58,
						60,
						63,
						69,
						75,
						80
					},
					averages = {
						40,
						70,
						145,
						225,
						305,
						380,
						485,
						610,
						760,
						945,
						1110,
						1165,
						1325,
						1490,
						1690
					}
				}
				aX[cP] = {
					interval = 1,
					ticks = 7,
					coeff = 0.66626,
					dhCoeff = 0.517928287,
					levels = {
						64,
						72,
						80
					},
					averages = {
						224,
						287,
						371
					},
					bomb = {
						480,
						616,
						776
					}
				}
				aX[cS] = {
					interval = 1,
					ticks = 7,
					coeff = 0.8056,
					levels = {
						60,
						70,
						75,
						80
					},
					averages = {
						686,
						861,
						1239,
						1442
					}
				}
			elseif az then
				aX[cP] = {
					interval = 1,
					ticks = 7,
					coeff = 0.52,
					dhCoeff = 0.34335,
					levels = {
						64
					},
					averages = {
						273
					},
					bomb = {
						600
					}
				}
			elseif aC then
				aX[cP] = {
					interval = 1,
					ticks = 7,
					coeff = 7 * 0.051,
					dhCoeff = 0.274,
					levels = {
						nil
					},
					averages = cB(38.949830, 0.04 * 7, 0.606705, 0.167780),
					bomb = cB(38.949830, 0.57, 0.606705, 0.167780)
				}
				aX[cS] = {
					interval = 1,
					ticks = 7,
					coeff = 7 * 0.061,
					levels = {
						nil
					},
					averages = cB(38.949830, 0.34 * 7, 0.606705, 0.167780)
				}
			end;
			if aA then
				aW[cJ] = {
					levels = {
						1,
						8,
						14,
						20,
						26,
						32,
						38,
						44,
						50,
						56,
						60,
						62,
						69,
						74,
						79
					},
					averages = {
						{
							co(37, 51),
							co(37, 52),
							co(38, 53),
							co(39, 54),
							co(40, 55)
						},
						{
							co(88, 112),
							co(89, 114),
							co(90, 115),
							co(91, 116),
							co(93, 118),
							co(94, 119)
						},
						{
							co(195, 243),
							co(196, 245),
							co(198, 247),
							co(200, 249),
							co(202, 251),
							co(204, 253)
						},
						{
							co(363, 445),
							co(365, 448),
							co(368, 451),
							co(371, 454),
							co(373, 456),
							co(376, 459)
						},
						{
							co(490, 594),
							co(493, 597),
							co(496, 600),
							co(499, 603),
							co(502, 606),
							co(505, 609)
						},
						{
							co(636, 766),
							co(639, 770),
							co(642, 773),
							co(646, 777),
							co(649, 780),
							co(653, 783)
						},
						{
							co(802, 960),
							co(805, 964),
							co(809, 968),
							co(813, 972),
							co(817, 976),
							co(821, 980)
						},
						{
							co(1199, 1427),
							co(1203, 1432),
							co(1208, 1436),
							co(1212, 1441),
							co(1217, 1445),
							co(1221, 1450)
						},
						{
							co(1299, 1539),
							co(1304, 1545),
							co(1309, 1550),
							co(1314, 1555),
							co(1319, 1560),
							co(1324, 1565)
						},
						{
							co(1620, 1912),
							co(1625, 1918),
							co(1631, 1924),
							co(1637, 1930),
							co(1642, 1935),
							co(1648, 1941)
						},
						{
							co(1944, 2294),
							co(1950, 2301),
							co(1956, 2307),
							co(1962, 2313),
							co(1968, 2319),
							co(1975, 2325)
						},
						{
							co(2026, 2392),
							co(2032, 2399),
							co(2038, 2405),
							co(2044, 2411),
							co(2051, 2418),
							co(2057, 2424)
						},
						{
							co(2321, 2739),
							co(2328, 2746),
							co(2335, 2753),
							co(2342, 2760),
							co(2349, 2767)
						},
						{
							co(3223, 3805),
							co(3232, 3815),
							co(3242, 3825),
							co(3252, 3835),
							co(3262, 3845)
						},
						{
							co(3750, 4428),
							co(3761, 4440)
						}
					}
				}
			else
				aW[cJ] = {
					levels = {
						1,
						8,
						14,
						20,
						26,
						32,
						38,
						44,
						50,
						56,
						60,
						62,
						69
					},
					averages = {
						{
							co(37, 51),
							co(37, 52),
							co(38, 53),
							co(39, 54),
							co(40, 55)
						},
						{
							co(88, 112),
							co(89, 114),
							co(90, 115),
							co(91, 116),
							co(93, 118),
							co(94, 119)
						},
						{
							co(195, 243),
							co(196, 245),
							co(198, 247),
							co(200, 249),
							co(202, 251),
							co(204, 253)
						},
						{
							co(363, 445),
							co(365, 448),
							co(368, 451),
							co(371, 454),
							co(373, 456),
							co(376, 459)
						},
						{
							co(572, 694),
							co(575, 698),
							co(579, 701),
							co(582, 705),
							co(586, 708),
							co(589, 712)
						},
						{
							co(742, 894),
							co(746, 898),
							co(750, 902),
							co(754, 906),
							co(758, 910),
							co(762, 914)
						},
						{
							co(936, 1120),
							co(940, 1125),
							co(945, 1129),
							co(949, 1134),
							co(954, 1138),
							co(958, 1143)
						},
						{
							co(1199, 1427),
							co(1204, 1433),
							co(1209, 1438),
							co(1214, 1443),
							co(1219, 1448),
							co(1225, 1453)
						},
						{
							co(1516, 1796),
							co(1521, 1802),
							co(1527, 1808),
							co(1533, 1814),
							co(1539, 1820),
							co(1545, 1826)
						},
						{
							co(1890, 2230),
							co(1896, 2237),
							co(1903, 2244),
							co(1909, 2250),
							co(1916, 2257),
							co(1923, 2263)
						},
						{
							co(2267, 2677),
							co(2274, 2685),
							co(2281, 2692),
							co(2288, 2699),
							co(2296, 2707),
							co(2303, 2714)
						},
						{
							co(2364, 2790),
							co(2371, 2798),
							co(2378, 2805),
							co(2386, 2813),
							co(2393, 2820),
							co(2401, 2827)
						},
						{
							co(2707, 3197),
							co(2715, 3206)
						}
					}
				}
			end;
			aW[cM] = {
				coeff = (aA and 0.6 or 0.5) * 2 / 3.5,
				levels = aX[cM].levels,
				averages = {
					{
						co(84, 98),
						co(85, 100),
						co(87, 102),
						co(89, 104),
						co(91, 106),
						co(93, 107)
					},
					{
						co(164, 188),
						co(166, 191),
						co(169, 193),
						co(171, 196),
						co(174, 198),
						co(176, 201)
					},
					{
						co(240, 274),
						co(243, 278),
						co(246, 281),
						co(249, 284),
						co(252, 287),
						co(255, 290)
					},
					{
						co(318, 360),
						co(321, 364),
						co(325, 368),
						co(328, 371),
						co(332, 375),
						co(336, 378)
					},
					{
						co(405, 457),
						co(409, 462),
						co(413, 466),
						co(417, 470),
						co(421, 474),
						co(425, 478)
					},
					{
						co(511, 575),
						co(515, 580),
						co(520, 585),
						co(525, 590),
						co(529, 594),
						co(534, 599)
					},
					{
						co(646, 724),
						co(651, 730),
						co(656, 735),
						co(661, 740),
						co(667, 746),
						co(672, 751)
					},
					{
						co(809, 905),
						co(815, 911),
						co(821, 917),
						co(827, 923),
						co(833, 929),
						co(839, 935)
					},
					{
						co(1003, 1119),
						co(1009, 1126),
						co(1016, 1133),
						co(1023, 1140),
						co(1030, 1147),
						co(1037, 1153)
					},
					{
						co(1215, 1355),
						co(1222, 1363),
						co(1230, 1371),
						co(1238, 1379),
						co(1245, 1386),
						co(1253, 1394)
					},
					{
						co(1710, 1908),
						co(1720, 1919),
						co(1731, 1930),
						co(1742, 1941),
						co(1753, 1952),
						co(1764, 1962)
					},
					{
						co(2234, 2494),
						co(2241, 2502),
						co(2249, 2510),
						co(2257, 2518)
					}
				}
			}
			if az or aA then
				aW[cO] = {
					_isChanneled = true,
					coeff = 1.145,
					ticks = 4,
					interval = 2,
					levels = {
						30,
						40,
						50,
						60,
						70,
						75,
						80
					},
					averages = {
						{
							351 * 4,
							354 * 4,
							356 * 4,
							358 * 4,
							360 * 4,
							362 * 4,
							365 * 4
						},
						{
							515 * 4,
							518 * 4,
							521 * 4,
							523 * 4,
							526 * 4,
							528 * 4,
							531 * 4
						},
						{
							765 * 4,
							769 * 4,
							772 * 4,
							776 * 4,
							779 * 4,
							782 * 4,
							786 * 4
						},
						{
							1097 * 4,
							1101 * 4,
							1105 * 4,
							1109 * 4,
							1112 * 4,
							1116 * 4,
							1120 * 4
						},
						{
							1518 * 4,
							1523 * 4,
							1527 * 4,
							1532 * 4,
							1536 * 4
						},
						{
							2598 * 4,
							2606 * 4,
							2614 * 4,
							2622 * 4,
							2629 * 4
						},
						{
							3035 * 4
						}
					}
				}
			else
				aW[cO] = {
					_isChanneled = true,
					coeff = 1 / 3,
					ticks = 5,
					interval = 2,
					levels = {
						30,
						40,
						50,
						60
					},
					averages = {
						{
							94 * 5,
							95 * 5,
							96 * 5,
							96 * 5,
							97 * 5,
							97 * 5,
							98 * 5
						},
						{
							138 * 5,
							139 * 5,
							140 * 5,
							141 * 5,
							141 * 5,
							142 * 5,
							143 * 5
						},
						{
							205 * 5,
							206 * 5,
							207 * 5,
							208 * 5,
							209 * 5,
							210 * 5,
							211 * 5
						},
						{
							294 * 5
						}
					}
				}
			end;
			if aC then
				aW[cT] = {
					coeff = 0.357,
					levels = {
						nil
					},
					averages = cB(38.949830, co(1.61, 1.89), 0.606705, 0.167780)
				}
			elseif aA then
				aW[cT] = {
					coeff = 0.358005,
					levels = {
						80
					},
					averages = {
						co(1883, 2187)
					}
				}
			end;
			b2[cI] = {
				mod = 0.02,
				current = 0
			}
			b2[cK] = {
				mod = 0.05,
				current = 0
			}
			b2[cQ] = {
				mod = 0.04,
				current = 0
			}
			b2[cR] = {
				mod = 0.1,
				current = 0
			}
			b2[cV] = {
				mod = 0.01,
				current = 0
			}
			b2[cW] = {
				mod = 1,
				current = 0
			}
			b2[cU] = {
				mod = 0.02,
				current = 0
			}
			b1["Stormrage"] = {
				16903,
				16898,
				16904,
				16897,
				16900,
				16899,
				16901,
				16902
			}
			b1["Nordrassil"] = {
				30216,
				30217,
				30219,
				30220,
				30221
			}
			b1["Thunderheart"] = {
				31041,
				31032,
				31037,
				31045,
				31047,
				34571,
				34445,
				34554
			}
			b1["Dreamwalker"] = {
				40460,
				40461,
				40462,
				40463,
				40465,
				39531,
				39538,
				39539,
				39542,
				39543
			}
			b1["Lasherweave"] = {
				50106,
				50107,
				50108,
				50109,
				50113,
				51139,
				51138,
				51137,
				51136,
				51135,
				51300,
				51301,
				51302,
				51303,
				51304
			}
			local cY = {
				[28355] = 87,
				[33076] = 105,
				[33841] = 116,
				[35021] = 131,
				[42576] = 188,
				[42577] = 217,
				[42578] = 246,
				[42579] = 294,
				[42580] = 376,
				[51423] = 448
			}
			local cZ = {
				[186054] = 15,
				[22398] = 50,
				[25643] = 86,
				[38366] = 33
			}
			local c_ = {
				[40711] = 125,
				[27886] = 47
			}
			local d0, d1 = {}, {}
			cs = function(b8, b6)
				d0[b6] = 0;
				if c5(b8, cN) then
					d0[b6] = d0[b6] + 1
				end;
				if c5(b8, cP) then
					d0[b6] = d0[b6] + 1
				end;
				if c5(b8, cS) then
					d0[b6] = d0[b6] + 1
				end;
				if c5(b8, cM) then
					d1[b6] = true;
					d0[b6] = d0[b6] + 1
				else
					d1[b6] = nil
				end
			end;
			cr = function(bt, b6, aH)
				local cx = GetSpellInfo(aH)
				if cx == cO then
					local d2 = ba[aS]
					local d3 = c3[aS]
					for d4, bi in pairs(c3) do
						if bi == d3 and aS ~= d4 and not UnitHasVehicleUI(c2[d4]) and IsSpellInRange(cL, c2[d4]) == 1 then
							d2 = d2 .. "," .. ba[d4]
						end
					end;
					return d2
				end;
				return ba[b6]
			end;
			local d5 = {}
			ct = function(b6, aH)
				if aH == 70691 then
					aH = 48441
				end;
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local bA = cw(aX, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				local d6, d7;
				if az or aA then
					ci = ci * (1 + b2[cI].current)
				else
					bA = bA + b2[cI].current
				end;
				if c5("player", cX) then
					if c1 == 32387 then
						cg = cg + 44
					end
				end;
				if cx == cN then
					if az or aA then
						ci = ci + b2[cK].current
					else
						bA = bA * (1 + b2[cK].current)
					end;
					if c1 and cZ[c1] then
						cg = cg + cZ[c1]
					end;
					local cn = aA and 15 or 12;
					local bF = cn / aX[cx].interval;
					if b0["Stormrage"] >= 8 then
						bA = bA + bA / bF;
						cn = cn + 3;
						bF = bF + 1
					end;
					d7 = bF;
					cg = cg * cn / 15 * (aA and 1.88 or 1) * (1 + b2[cQ].current)
					cg = cg / bF;
					bA = bA / bF
				elseif cx == cM then
					cg = cg * aX[cx].coeff * (aA and 1.88 or 1) * (1 + b2[cQ].current)
					cg = cg / aX[cx].ticks;
					bA = bA / aX[cx].ticks;
					d7 = 7;
					if b2[cW].current >= 1 then
						d7 = d7 + 2
					end;
					if b0["Nordrassil"] >= 2 then
						d7 = d7 + 2
					end
				elseif cx == cP then
					local d8 = cg;
					if c1 and cY[c1] then
						d8 = d8 + cY[c1]
					end;
					local d9 = d8 * aX[cx].dhCoeff * (1 + b2[cQ].current)
					if aC then
						local da = aX[cx].bomb[cy]
						if type(da) == "table" then
							da = da[min(aU, # da)]
						end;
						d6 = ceil(ce(aX[cx].levels[cy], da, d9, ch, ci))
					else
						d6 = ceil(ce(aX[cx].levels[cy], aX[cx].bomb[cy], d9, ch, ci))
					end;
					cg = cg * aX[cx].coeff * (1 + b2[cQ].current)
					cg = cg / aX[cx].ticks;
					bA = bA / aX[cx].ticks;
					d7 = 7;
					if c1 and c_[c1] then
						cg = cg + c_[c1]
					end;
					if c4[54826] then
						d7 = d7 + 1
					end;
					if b2[cW].current >= 1 then
						d7 = d7 + 2
					end
				elseif cx == cS then
					cg = cg * aX[cx].coeff * (1 + b2[cQ].current)
					cg = cg / aX[cx].ticks;
					bA = bA / aX[cx].ticks;
					ci = ci + b2[cV].current;
					table.wipe(d5)
					local db = b0["Lasherweave"] >= 2 and 0.70 or 1;
					local dc = bA / aX[cx].ticks;
					for i = 1, aX[cx].ticks do
						table.insert(d5, math.ceil(ci * (bA + dc * (3 - (i - 1) * db) + cg * ch)))
					end;
					if aA and c5("player", cU) then
						ci = ci * (1 + b2[cU].current)
					end;
					return aL, d5, aX[cx].ticks, aX[cx].interval, nil, true
				end;
				ci = ci + b2[cV].current;
				if aA and c5("player", cU) then
					ci = ci * (1 + b2[cU].current)
					if d6 then
						d6 = d6 * (1 + b2[cU].current)
					end
				end;
				bA = ce(aX[cx].levels[cy], bA, cg, ch, ci)
				return aL, ceil(max(0, bA)), d7, aX[cx].interval, d6
			end;
			cq = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local bA = cw(aW, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				if az or aA then
					ci = ci * (1 + b2[cI].current)
				else
					bA = bA * (1 + b2[cI].current)
				end;
				if aA and c5("player", cU) then
					ci = ci * (1 + b2[cU].current)
					if c1 == 32387 then
						cg = cg + 44
					end
				end;
				if cx == cM then
					if c4[54743] and d1[b6] then
						ci = ci * 1.20
					end;
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1)
				elseif cx == cT then
					if c1 == 46138 then
						cg = cg + 187
					end;
					local dd = d0[b6]
					if dd and dd > 0 then
						local de = 1.20;
						if b0["Dreamwalker"] >= 2 then
							de = de + 0.05 * dd
						end;
						if c4[62971] then
							de = de + 0.06 * dd
						end;
						ci = ci * de
					end;
					cg = cg * (aW[cx].coeff * (aA and 1.88 or 1) + b2[cR].current)
				elseif cx == cJ then
					local cl;
					if aA then
						cl = cy > 3 and 3 or cy == 3 and 2.5 or cy == 2 and 2 or 1.5
					else
						cl = cy >= 5 and 3.5 or (cy == 4 and 3 or (cy == 3 and 2.5 or (cy == 2 and 2 or 1.5)))
					end;
					if c4[54825] then
						bA = bA / 2;
						cl = max(cl - 1.5, 1.5)
					end;
					cg = cg * (cl / 3.5 * (aA and 1.88 or 1) + b2[cR].current * (aA and 2 or 1))
					if c1 == 22399 then
						bA = bA + 100
					elseif c1 == 28568 then
						bA = bA + 136
					end;
					if b0["Thunderheart"] >= 4 then
						ci = ci * 1.05
					end
				elseif cx == cO then
					ci = ci + b2[cV].current;
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1) * (1 + b2[cQ].current)
					cg = cg / aW[cx].ticks;
					bA = bA / aW[cx].ticks
				end;
				bA = ce(aW[cx].levels[cy], bA, cg, ch, ci)
				if GetSpellCritChance(4) >= 100 then
					bA = bA * 1.50
				end;
				if aW[cx].ticks then
					return aK, ceil(bA), aW[cx].ticks, aW[cx].interval
				end;
				return aJ, ceil(bA)
			end
		end
	end;
	local df, dg;
	if b5 == "PALADIN" then
		cv = function()
			local dh = GetSpellInfo(20216)
			local di = GetSpellInfo(19750)
			local dj = GetSpellInfo(20237)
			local dk = GetSpellInfo(635)
			local dl = GetSpellInfo(20473)
			local dm = GetSpellInfo(63646) or "Divinity"
			local dn = GetSpellInfo(53592) or "Touched by the Light"
			local dp = GetSpellInfo(53563) or "Beacon of Light"
			local dq = GetSpellInfo(20165) or "Seal of Light"
			local dr = GetSpellInfo(31842) or "Divine Illumination"
			local ds = GetSpellInfo(54428)
			local dt = GetSpellInfo(31884)
			local du = GetSpellInfo(407805) or "Sacrifice Redeemed"
			if aA then
				aW[dl] = {
					coeff = 1 / 3.5,
					levels = {
						1,
						48,
						56,
						64,
						70,
						75,
						80
					},
					averages = {
						{
							co(538, 582)
						},
						{
							co(721, 780)
						},
						{
							co(946, 1025)
						},
						{
							co(1188, 1287)
						},
						{
							co(1408, 1526)
						},
						{
							co(2312, 2504)
						},
						{
							co(2989, 2911)
						}
					}
				}
				aW[dk] = {
					coeff = 2.5 / 3.5,
					levels = {
						1,
						6,
						14,
						22,
						30,
						38,
						46,
						54,
						60,
						62,
						70,
						75,
						80
					},
					averages = {
						{
							co(50, 60),
							co(50, 61),
							co(51, 62),
							co(52, 63),
							co(53, 64)
						},
						{
							co(96, 116),
							co(97, 118),
							co(98, 119),
							co(99, 120),
							co(100, 121),
							co(101, 122)
						},
						{
							co(203, 239),
							co(204, 241),
							co(206, 243),
							co(208, 245),
							co(209, 246),
							co(211, 248)
						},
						{
							co(397, 455),
							co(399, 458),
							co(401, 460),
							co(404, 463),
							co(406, 465),
							co(409, 467)
						},
						{
							co(628, 708),
							co(631, 712),
							co(634, 715),
							co(637, 718),
							co(640, 721),
							co(643, 724)
						},
						{
							co(894, 998),
							co(897, 1002),
							co(901, 1006),
							co(905, 1010),
							co(909, 1014),
							co(913, 1017)
						},
						{
							co(1209, 1349),
							co(1213, 1354),
							co(1218, 1359),
							co(1222, 1363),
							co(1227, 1368),
							co(1232, 1372)
						},
						{
							co(1595, 1777),
							co(1600, 1783),
							co(1605, 1788),
							co(1610, 1793),
							co(1615, 1798),
							co(1621, 1803)
						},
						{
							co(2034, 2266),
							co(2039, 2272),
							co(2045, 2278),
							co(2051, 2284),
							co(2057, 2290),
							co(2063, 2295)
						},
						{
							co(2232, 2486),
							co(2238, 2493),
							co(2244, 2499),
							co(2251, 2506),
							co(2257, 2512),
							co(2264, 2518)
						},
						{
							co(2818, 3138),
							co(2825, 3145),
							co(2832, 3152),
							co(2839, 3159),
							co(2846, 3166)
						},
						{
							co(4199, 4677),
							co(4209, 4688),
							co(4219, 4698),
							co(4230, 4709),
							co(4240, 4719)
						},
						{
							co(4888, 5444)
						}
					}
				}
				aW[di] = {
					coeff = 1.5 / 3.5,
					levels = {
						20,
						26,
						34,
						42,
						50,
						58,
						66,
						74,
						79
					},
					averages = {
						{
							co(81, 93),
							co(82, 94),
							co(83, 95),
							co(84, 96),
							co(85, 97),
							co(86, 98)
						},
						{
							co(124, 144),
							co(125, 146),
							co(126, 147),
							co(127, 148),
							co(129, 150),
							co(130, 151)
						},
						{
							co(189, 211),
							co(190, 213),
							co(192, 215),
							co(193, 216),
							co(195, 218),
							co(197, 219)
						},
						{
							co(256, 288),
							co(257, 290),
							co(259, 292),
							co(261, 294),
							co(263, 296),
							co(265, 298)
						},
						{
							co(346, 390),
							co(348, 393),
							co(350, 395),
							co(352, 397),
							co(354, 399),
							co(357, 401)
						},
						{
							co(445, 499),
							co(447, 502),
							co(450, 505),
							co(452, 507),
							co(455, 510),
							co(458, 512)
						},
						{
							co(588, 658),
							co(591, 661),
							co(594, 664),
							co(597, 667),
							co(600, 670)
						},
						{
							co(682, 764),
							co(685, 768),
							co(688, 771),
							co(692, 775),
							co(695, 778)
						},
						{
							co(785, 879),
							co(788, 883)
						}
					}
				}
			else
				aW[dl] = {
					coeff = 1 / 3.5,
					levels = {
						1,
						48,
						56,
						64,
						70,
						75,
						80
					},
					averages = {
						{
							co(538, 582)
						},
						{
							co(721, 780)
						},
						{
							co(946, 1025)
						},
						{
							co(1188, 1287)
						},
						{
							co(1408, 1526)
						},
						{
							co(2312, 2504)
						},
						{
							co(2989, 2911)
						}
					}
				}
				aW[dk] = {
					coeff = 2.5 / 3.5,
					levels = {
						1,
						6,
						14,
						22,
						30,
						38,
						46,
						54,
						60,
						62,
						70
					},
					averages = {
						{
							co(39, 47),
							co(39, 48),
							co(40, 49),
							co(41, 50),
							co(42, 51)
						},
						{
							co(76, 90),
							co(77, 92),
							co(78, 93),
							co(79, 94),
							co(80, 95),
							co(81, 96)
						},
						{
							co(159, 187),
							co(160, 189),
							co(162, 191),
							co(164, 193),
							co(165, 194),
							co(167, 196)
						},
						{
							co(310, 356),
							co(312, 359),
							co(314, 361),
							co(317, 364),
							co(319, 366),
							co(322, 368)
						},
						{
							co(491, 553),
							co(494, 557),
							co(497, 560),
							co(500, 563),
							co(503, 566),
							co(506, 569)
						},
						{
							co(698, 780),
							co(701, 784),
							co(705, 788),
							co(709, 792),
							co(713, 796),
							co(717, 799)
						},
						{
							co(945, 1053),
							co(949, 1058),
							co(954, 1063),
							co(958, 1067),
							co(963, 1072),
							co(968, 1076)
						},
						{
							co(1246, 1388),
							co(1251, 1394),
							co(1256, 1399),
							co(1261, 1404),
							co(1266, 1409),
							co(1272, 1414)
						},
						{
							co(1590, 1770),
							co(1595, 1775),
							co(1601, 1781),
							co(1607, 1787),
							co(1613, 1793),
							co(1619, 1799)
						},
						{
							co(1741, 1939),
							co(1747, 1946),
							co(1753, 1952),
							co(1760, 1959),
							co(1766, 1965),
							co(1773, 1971)
						},
						{
							co(2196, 2446)
						}
					}
				}
				aW[di] = {
					coeff = 1.5 / 3.5,
					levels = {
						20,
						26,
						34,
						42,
						50,
						58,
						66
					},
					averages = {
						{
							co(62, 72),
							co(63, 73),
							co(64, 74),
							co(65, 75),
							co(66, 76),
							co(67, 77)
						},
						{
							co(96, 110),
							co(97, 112),
							co(98, 113),
							co(99, 114),
							co(101, 116),
							co(102, 117)
						},
						{
							co(145, 163),
							co(146, 165),
							co(148, 167),
							co(149, 168),
							co(151, 170),
							co(153, 171)
						},
						{
							co(197, 221),
							co(198, 223),
							co(200, 225),
							co(202, 227),
							co(204, 229),
							co(206, 231)
						},
						{
							co(267, 299),
							co(269, 302),
							co(271, 304),
							co(273, 306),
							co(275, 308),
							co(278, 310)
						},
						{
							co(343, 383),
							co(345, 386),
							co(348, 389),
							co(350, 391),
							co(353, 394),
							co(356, 396)
						},
						{
							co(448, 502),
							co(450, 505),
							co(453, 508),
							co(455, 510),
							co(458, 513)
						}
					}
				}
			end;
			b2[dj] = {
				mod = 0.04,
				current = 0
			}
			b2[dm] = {
				mod = 0.01,
				current = 0
			}
			b2[dn] = {
				mod = 0.10,
				current = 0
			}
			b1["Lightbringer"] = {
				30992,
				30983,
				30988,
				30994,
				30996,
				34432,
				34487,
				34559
			}
			b1["Lightsworn"] = {
				50865,
				50866,
				50867,
				50868,
				50869,
				51270,
				51271,
				51272,
				51273,
				51274,
				51165,
				51166,
				51167,
				51168,
				51169
			}
			local dv;
			if aA then
				dv = {
					[51472] = 510,
					[42616] = 436,
					[42615] = 375,
					[42614] = 331,
					[42613] = 293,
					[42612] = 204,
					[28592] = 89,
					[25644] = 79,
					[23006] = 43,
					[23201] = 28
				}
			else
				dv = {
					[23006] = 83,
					[23201] = 53,
					[186065] = 10,
					[25644] = 79
				}
			end;
			local dw = {
				[45436] = 160,
				[40268] = 141,
				[28296] = 47
			}
			local dx = {
				[19977] = {
					[dk] = 210,
					[di] = 60
				},
				[19978] = {
					[dk] = 300,
					[di] = 85
				},
				[19979] = {
					[dk] = 400,
					[di] = 115
				},
				[25890] = {
					[dk] = 400,
					[di] = 115
				},
				[27144] = {
					[dk] = 580,
					[di] = 185
				},
				[27145] = {
					[dk] = 580,
					[di] = 185
				}
			}
			cs = function(b8, b6)
				if c5(b8, dp) then
					dg = b6
				elseif dg == b6 then
					dg = nil
				end;
				if b8 == "player" then
					df = c5("player", dh)
				end
			end;
			cr = function(bt, b6, aH)
				if dg and dg ~= b6 and c2[dg] and UnitIsVisible(c2[dg]) then
					return string.format("%s,%s", ba[b6], ba[dg])
				end;
				return ba[b6]
			end;
			cq = function(b6, aH, b8)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local bA = cw(aW, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				if c4[54943] and c5("player", dq) then
					ci = ci * 1.05
				end;
				if aC and c5("player", du) then
					ci = ci * 1.10
				end;
				if az or aA then
					ci = ci * (1 + b2[dj].current) * (1 + b2[dm].current * (UnitIsUnit(b8, "player") and 2 or 1))
				else
					bA = bA * (1 + b2[dj].current)
				end;
				if c1 then
					if cx == dk and dw[c1] then
						cg = cg + dw[c1]
					elseif cx == di and dv[c1] then
						cg = cg + dv[c1]
					end
				end;
				if b0["Lightsworn"] >= 2 and c5("player", dr) then
					ci = ci * 1.35
				end;
				if b0["Lightbringer"] >= 4 and cx == di then
					ci = ci + 0.05
				end;
				if aA then
					if c5("player", dt) then
						ci = ci * 1.2
					end;
					if c5("player", ds) then
						ci = ci * 0.5
					end
				end;
				cg = cg * aW[cx].coeff * (aA and 2.35 or 1)
				bA = ce(aW[cx].levels[cy], bA, cg, ch, ci)
				if not aA then
					for dy, dz in pairs(dx) do
						if c5(b8, dy) then
							if c1 == 28592 then
								if cx == di then
									bA = ce(aW[cx].levels[cy], bA, dz[cx] + 60, ci, 1)
								else
									bA = ce(aW[cx].levels[cy], bA, dz[cx] + 120, ci, 1)
								end
							else
								bA = ce(aW[cx].levels[cy], bA, dz[cx], ci, 1)
							end;
							break
						end
					end
				end;
				if df or GetSpellCritChance(2) >= 100 then
					bA = bA * 1.50 * (1 + b2[dn].current)
				end;
				return aJ, ceil(bA)
			end
		end
	end;
	if b5 == "PRIEST" then
		cv = function()
			local dA = GetSpellInfo(139)
			local dB = GetSpellInfo(2060)
			local dC = GetSpellInfo(596)
			local dD = GetSpellInfo(2061)
			local dE = GetSpellInfo(2054)
			local dF = GetSpellInfo(2050)
			local dG = GetSpellInfo(14898)
			local dH = GetSpellInfo(14908)
			local dI = GetSpellInfo(22009)
			local dJ = GetSpellInfo(527)
			local dK = GetSpellInfo(32546) or "Binding Heal"
			local dL = GetSpellInfo(33158) or "Empowered Healing"
			local dM = GetSpellInfo(37563) and "37563"
			local dN = GetSpellInfo(53007) or "Penance"
			local dO = GetSpellInfo(47517) or "Grace"
			local dP = GetSpellInfo(33142) or "Blessed Resilience"
			local dQ = GetSpellInfo(33190) or "Focused Power"
			local dR = GetSpellInfo(47567) or "Divine Providence"
			local dS = GetSpellInfo(63534) or "Empowered Renew"
			local dT = GetSpellInfo(47586) or "Twin Disciplines"
			aX[dA] = {
				coeff = 1,
				interval = 3,
				ticks = 5,
				levels = {
					8,
					14,
					20,
					26,
					32,
					38,
					44,
					50,
					56,
					60,
					65,
					70,
					75,
					80
				},
				averages = {
					45,
					100,
					175,
					245,
					315,
					400,
					510,
					650,
					810,
					970,
					1010,
					1110,
					1235,
					1400
				}
			}
			aX[dI] = aX[dA]
			if dM then
				aX[dM] = {
					coeff = 0,
					interval = 3,
					ticks = 3,
					levels = {
						70
					},
					averages = {
						150
					}
				}
			end;
			aW[dD] = {
				coeff = 1.5 / 3.5,
				levels = {
					20,
					26,
					32,
					38,
					44,
					50,
					56,
					61,
					67,
					73,
					79
				},
				averages = {
					{
						co(193, 237),
						co(194, 239),
						co(196, 241),
						co(198, 243),
						co(200, 245),
						co(202, 247)
					},
					{
						co(258, 314),
						co(260, 317),
						co(262, 319),
						co(264, 321),
						co(266, 323),
						co(269, 325)
					},
					{
						co(327, 393),
						co(329, 396),
						co(332, 398),
						co(334, 401),
						co(337, 403),
						co(339, 406)
					},
					{
						co(400, 478),
						co(402, 481),
						co(405, 484),
						co(408, 487),
						co(411, 490),
						co(414, 492)
					},
					{
						co(518, 616),
						co(521, 620),
						co(524, 623),
						co(527, 626),
						co(531, 630),
						co(534, 633)
					},
					{
						co(644, 764),
						co(647, 768),
						co(651, 772),
						co(655, 776),
						co(658, 779),
						co(662, 783)
					},
					{
						co(812, 958),
						co(816, 963),
						co(820, 967),
						co(824, 971),
						co(828, 975),
						co(833, 979)
					},
					{
						co(913, 1059),
						co(917, 1064),
						co(922, 1069),
						co(927, 1074),
						co(931, 1078)
					},
					{
						co(1101, 1279),
						co(1106, 1285),
						co(1111, 1290),
						co(1116, 1295),
						co(1121, 1300)
					},
					{
						co(1578, 1832),
						co(1586, 1840),
						co(1594, 1848),
						co(1602, 1856),
						co(1610, 1864),
						co(1618, 1872)
					},
					{
						co(1887, 2193),
						co(1896, 2203)
					}
				}
			}
			aW[dB] = {
				coeff = 3 / 3.5,
				levels = {
					40,
					46,
					52,
					58,
					60,
					63,
					68,
					73,
					78
				},
				averages = {
					{
						co(899, 1013),
						co(904, 1019),
						co(909, 1024),
						co(914, 1029),
						co(919, 1034),
						co(924, 1039)
					},
					{
						co(1149, 1289),
						co(1154, 1295),
						co(1160, 1301),
						co(1166, 1307),
						co(1172, 1313),
						co(1178, 1318)
					},
					{
						co(1437, 1609),
						co(1443, 1616),
						co(1450, 1623),
						co(1456, 1629),
						co(1463, 1636),
						co(1470, 1642)
					},
					{
						co(1798, 2006),
						co(1805, 2014),
						co(1813, 2021),
						co(1820, 2029),
						co(1828, 2036),
						co(1835, 2044)
					},
					{
						co(1966, 2194),
						co(1974, 2203),
						co(1982, 2211),
						co(1990, 2219),
						co(1998, 2227),
						co(2006, 2235)
					},
					{
						co(2074, 2410),
						co(2082, 2419),
						co(2090, 2427),
						co(2099, 2436),
						co(2107, 2444)
					},
					{
						co(2396, 2784),
						co(2405, 2794),
						co(2414, 2803),
						co(2423, 2812),
						co(2433, 2822)
					},
					{
						co(3395, 3945),
						co(3408, 3959),
						co(3421, 3972),
						co(3434, 3985),
						co(3447, 3998)
					},
					{
						co(3950, 4590),
						co(3965, 4606),
						co(3980, 4621)
					}
				}
			}
			aW[dE] = {
				coeff = 3 / 3.5,
				levels = {
					16,
					22,
					28,
					34
				},
				averages = {
					{
						co(295, 341),
						co(297, 344),
						co(299, 346),
						co(302, 349),
						co(304, 351),
						co(307, 353)
					},
					{
						co(429, 491),
						co(432, 495),
						co(435, 498),
						co(438, 501),
						co(441, 504),
						co(445, 507)
					},
					{
						co(566, 642),
						co(570, 646),
						co(574, 650),
						co(578, 654),
						co(582, 658),
						co(586, 662)
					},
					{
						co(712, 804),
						co(716, 809),
						co(721, 813),
						co(725, 818),
						co(730, 822),
						co(734, 827)
					}
				}
			}
			aW[dF] = {
				levels = {
					1,
					4,
					10
				},
				averages = {
					{
						co(46, 56),
						co(46, 57),
						co(47, 58)
					},
					{
						co(71, 85),
						co(72, 87),
						co(73, 88),
						co(74, 89),
						co(75, 90),
						co(76, 91)
					},
					{
						co(135, 157),
						co(136, 159),
						co(138, 161),
						co(139, 162),
						co(141, 164),
						co(143, 165)
					}
				}
			}
			aW[dC] = {
				coeff = aA and 0.2798 or az and 0.431596 or 3 / 3.5 / 3,
				levels = {
					30,
					40,
					50,
					60,
					60,
					68,
					76
				},
				averages = {
					{
						co(301, 321),
						co(302, 323),
						co(303, 324),
						co(304, 325),
						co(306, 327),
						co(307, 328),
						co(308, 329),
						co(310, 331),
						co(311, 332),
						co(312, 333)
					},
					{
						co(444, 472),
						co(445, 474),
						co(447, 476),
						co(448, 477),
						co(450, 479),
						co(452, 480),
						co(453, 482),
						co(455, 484),
						co(456, 485),
						co(458, 487)
					},
					{
						co(657, 695),
						co(659, 697),
						co(661, 699),
						co(663, 701),
						co(665, 703),
						co(667, 705),
						co(669, 707),
						co(671, 709),
						co(673, 711),
						co(675, 713)
					},
					{
						co(939, 991),
						co(941, 994),
						co(943, 996),
						co(946, 999),
						co(948, 1001),
						co(951, 1003),
						co(953, 1006),
						co(955, 1008),
						co(958, 1011),
						co(960, 1013)
					},
					{
						co(997, 1053),
						co(999, 1056),
						co(1002, 1058),
						co(1004, 1061),
						co(1007, 1063),
						co(1009, 1066),
						co(1012, 1068),
						co(1014, 1071),
						co(1017, 1073),
						co(1019, 1076)
					},
					{
						co(1246, 1316),
						co(1248, 1319),
						co(1251, 1322),
						co(1254, 1325),
						co(1257, 1328),
						co(1260, 1330),
						co(1262, 1333),
						co(1265, 1336)
					},
					{
						co(2091, 2209),
						co(2095, 2214),
						co(2100, 2219),
						co(2105, 2224),
						co(2109, 2228)
					}
				}
			}
			aW[dK] = {
				coeff = 1.5 / 3.5,
				levels = {
					64,
					72,
					78
				},
				averages = {
					{
						co(1042, 1338),
						co(1043, 1340),
						co(1045, 1342),
						co(1047, 1344),
						co(1049, 1346),
						co(1051, 1348),
						co(1053, 1350),
						co(1055, 1352)
					},
					{
						co(1619, 2081),
						co(1622, 2084),
						co(1625, 2087),
						co(1628, 2090),
						co(1631, 2093)
					},
					{
						co(1952, 2508),
						co(1955, 2512),
						co(1959, 2516)
					}
				}
			}
			if aC then
				aW[dN] = {
					_isChanneled = true,
					coeff = 0.857,
					ticks = 3,
					levels = {
						nil
					},
					averages = cB(38.258376, 1.06 * 0.8, 0.904195, 0.161311)
				}
			else
				aW[dN] = {
					_isChanneled = true,
					coeff = 0.857,
					ticks = 3,
					levels = {
						60,
						70,
						75,
						80
					},
					averages = {
						co(670, 756),
						co(805, 909),
						co(1278, 1442),
						co(1484, 1676)
					}
				}
			end;
			b2[dH] = {
				mod = 0.05,
				current = 0
			}
			b2[dG] = {
				mod = 0.02,
				current = 0
			}
			b2[dL] = {
				mod = 0.02,
				current = 0
			}
			if aA then
				b2[dL].mod = 0.04
			end;
			b2[dP] = {
				mod = 0.01,
				current = 0
			}
			b2[dQ] = {
				mod = 0.02,
				current = 0
			}
			b2[dR] = {
				mod = 0.02,
				current = 0
			}
			b2[dS] = {
				mod = 0.05,
				current = 0
			}
			b2[dT] = {
				mod = 0.01,
				current = 0
			}
			b1["Oracle"] = {
				21351,
				21349,
				21350,
				21348,
				21352
			}
			b1["Absolution"] = {
				31068,
				31063,
				31060,
				31069,
				31066,
				34562,
				34527,
				34435
			}
			b1["Avatar"] = {
				30153,
				30152,
				30151,
				30154,
				30150
			}
			local dU, dV = nil, 0;
			cs = function(b8, b6)
				local bf, _, _, _, dW = select(3, c5(b8, dO))
				if dW == "player" then
					dV = bf * 0.03;
					dU = b6
				elseif dU == b6 then
					dU = nil
				end
			end;
			cr = function(bt, b6, aH)
				local cx = GetSpellInfo(aH)
				if cx == dK then
					if b6 == aS then
						return format("%s", ba[aS])
					else
						return format("%s,%s", ba[b6], ba[aS])
					end
				elseif cx == dC then
					if not aA then
						b6 = UnitGUID("player")
					end;
					local d2 = ba[b6]
					local dX = c3[b6]
					for d4, bi in pairs(c3) do
						local b8 = aA and "player" or c2[d4]
						local dY = c2[d4]
						local dZ;
						if aB then
							dZ = InCombatLockdown() and not UnitCanAttack("player", b8)
						else
							dZ = false
						end;
						local d_ = IsSpellInRange(dJ, b8) == 1 or not dZ and CheckInteractDistance(b8, 4)
						if bi == dX and b6 ~= d4 and d_ and UnitIsVisible(dY) and not UnitHasVehicleUI(dY) then
							d2 = d2 .. "," .. ba[d4]
						end
					end;
					return d2
				end;
				return ba[b6]
			end;
			ct = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				if not cy then
					return
				end;
				local bA = cw(aX, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				local d7;
				if aA then
					ci = ci + b2[dG].current
				elseif az then
					ci = ci * (1 + b2[dG].current)
				else
					bA = bA * (1 + b2[dG].current)
				end;
				if cx == dA or cx == dI then
					if aA then
						ci = ci + b2[dH].current
					elseif az then
						ci = ci * (1 + b2[dH].current)
					else
						bA = bA * (1 + b2[dH].current)
					end;
					ci = ci + b2[dT].current;
					d7 = aX[cx].ticks;
					if c4[55674] then
						ci = ci + 0.25;
						bA = bA - bA / d7;
						cg = cg - cg / d7;
						d7 = d7 - 1
					end;
					if b0["Oracle"] >= 5 or b0["Avatar"] >= 4 then
						bA = bA + bA / d7;
						d7 = d7 + 1
					end;
					if aC then
						local e0 = C_Engraving.GetRuneForEquipmentSlot(6)
						if e0 and e0.itemEnchantmentID == 7026 then
							cg = cg * 1.15
						end
					end;
					cg = cg * (aA and 1.88 or 1) * (1 + b2[dS].current)
					cg = cg / d7;
					bA = bA / d7
				end;
				if dU == b6 then
					ci = ci * (1 + dV)
				end;
				ci = ci * (1 + b2[dQ].current)
				ci = ci * (1 + b2[dP].current)
				bA = ce(aX[cx].levels[cy], bA, cg, ch, ci)
				return aL, ceil(bA), d7, aX[cx].interval
			end;
			cq = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				if not cy then
					return
				end;
				local bA = cw(aW, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				if aA then
					ci = ci + b2[dG].current
				elseif az then
					ci = ci * (1 + b2[dG].current)
				else
					bA = bA * (1 + b2[dG].current)
				end;
				if cx == dB then
					if b0["Absolution"] >= 4 then
						ci = ci * 1.05
					end;
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1) * (1 + b2[dL].current * 2)
				elseif cx == dD then
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1) * (1 + b2[dL].current)
				elseif cx == dK then
					ci = ci + b2[dR].current;
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1) * (1 + b2[dL].current)
				elseif cx == dN then
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1)
					cg = cg / aW[cx].ticks;
					ci = ci + b2[dT].current
				elseif cx == dC then
					ci = ci + b2[dR].current;
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1)
				elseif cx == dE then
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1)
				elseif cx == dF then
					local cl = cy >= 3 and 2.5 or cy == 2 and 2 or 1.5;
					cg = cg * cl / 3.5 * (aA and 1.88 or 1)
				end;
				if dU == b6 then
					ci = ci * (1 + dV)
				end;
				ci = ci * (1 + b2[dQ].current)
				ci = ci * (1 + b2[dP].current)
				bA = ce(aW[cx].levels[cy], bA, cg, ch, ci)
				if GetSpellCritChance(2) >= 100 then
					bA = bA * 1.50
				end;
				if cx == dN then
					return aK, math.ceil(bA), aW[cx].ticks, 1
				end;
				return aJ, ceil(bA)
			end
		end
	end;
	local e1;
	if b5 == "SHAMAN" then
		cv = function()
			local e2 = GetSpellInfo(1064)
			local e3 = GetSpellInfo(331)
			local e4 = GetSpellInfo(8004)
			local e5 = GetSpellInfo(30872) or "Improved Chain Heal"
			local e6 = GetSpellInfo(29206) or "Healing Way"
			local e7 = GetSpellInfo(16178) or "Purification"
			local e8 = GetSpellInfo(49284) or "Earth Shield"
			local e9 = GetSpellInfo(51566) or "Tidal Waves"
			local ea = GetSpellInfo(61295) or "Riptide"
			local eb = GetSpellInfo(52000) or "Earthliving"
			local ec = GetSpellInfo(415236) or "Healing Rain"
			aX[ea] = {
				interval = 3,
				ticks = 5,
				coeff = 0.50,
				levels = {
					60,
					70,
					75,
					80
				},
				averages = {
					665,
					885,
					1435,
					1670
				}
			}
			aX[eb] = {
				interval = 3,
				ticks = 4,
				coeff = 0.364,
				levels = {
					30,
					40,
					50,
					60,
					70,
					80
				},
				averages = {
					116,
					160,
					220,
					348,
					456,
					652
				}
			}
			if aC then
				aX[ec] = {
					interval = 1,
					ticks = 10,
					coeff = 10 * 0.063,
					levels = {
						nil
					},
					averages = cB(29.888200, 10 * 0.15, 0.690312, 0.136267)
				}
			end;
			aW[ea] = {
				coeff = 1 / 3.5,
				levels = {
					60,
					70,
					75,
					80
				},
				averages = {
					{
						co(639, 691)
					},
					{
						co(849, 919)
					},
					{
						co(1378, 1492)
					},
					{
						co(1604, 1736)
					}
				}
			}
			aW[e2] = {
				coeff = 2.5 / 3.5,
				levels = {
					40,
					46,
					54,
					61,
					68,
					74,
					80
				},
				averages = {
					{
						co(320, 368),
						co(322, 371),
						co(325, 373),
						co(327, 376),
						co(330, 378),
						co(332, 381)
					},
					{
						co(405, 465),
						co(407, 468),
						co(410, 471),
						co(413, 474),
						co(416, 477),
						co(419, 479)
					},
					{
						co(551, 629),
						co(554, 633),
						co(557, 636),
						co(560, 639),
						co(564, 643),
						co(567, 646)
					},
					{
						co(605, 691),
						co(608, 695),
						co(612, 699),
						co(616, 703),
						co(620, 707),
						co(624, 710)
					},
					{
						co(826, 942),
						co(829, 946),
						co(833, 950),
						co(837, 954),
						co(841, 958),
						co(845, 961)
					},
					{
						co(906, 1034),
						co(909, 1038),
						co(913, 1042),
						co(917, 1046),
						co(921, 1050),
						co(925, 1053)
					},
					{
						co(1055, 1205)
					}
				}
			}
			aW[e3] = {
				levels = {
					1,
					6,
					12,
					18,
					24,
					32,
					40,
					48,
					56,
					60,
					63,
					70,
					75,
					80
				},
				averages = {
					{
						co(34, 44),
						co(34, 45),
						co(35, 46),
						co(36, 47)
					},
					{
						co(64, 78),
						co(65, 79),
						co(66, 80),
						co(67, 81),
						co(68, 82),
						co(69, 83)
					},
					{
						co(129, 155),
						co(130, 157),
						co(132, 158),
						co(133, 160),
						co(135, 161),
						co(136, 163)
					},
					{
						co(268, 316),
						co(270, 319),
						co(272, 321),
						co(274, 323),
						co(277, 326),
						co(279, 328)
					},
					{
						co(376, 440),
						co(378, 443),
						co(381, 446),
						co(384, 449),
						co(386, 451),
						co(389, 454)
					},
					{
						co(536, 622),
						co(539, 626),
						co(542, 629),
						co(545, 632),
						co(549, 636),
						co(552, 639)
					},
					{
						co(740, 854),
						co(743, 858),
						co(747, 862),
						co(751, 866),
						co(755, 870),
						co(759, 874)
					},
					{
						co(1017, 1167),
						co(1021, 1172),
						co(1026, 1177),
						co(1031, 1182),
						co(1035, 1186),
						co(1040, 1191)
					},
					{
						co(1367, 1561),
						co(1372, 1567),
						co(1378, 1572),
						co(1383, 1578),
						co(1389, 1583),
						co(1394, 1589)
					},
					{
						co(1620, 1850),
						co(1625, 1856),
						co(1631, 1861),
						co(1636, 1867),
						co(1642, 1872),
						co(1647, 1878)
					},
					{
						co(1725, 1969),
						co(1731, 1976),
						co(1737, 1982),
						co(1743, 1988),
						co(1750, 1995),
						co(1756, 2001)
					},
					{
						co(2134, 2436),
						co(2141, 2444),
						co(2148, 2451),
						co(2155, 2458),
						co(2162, 2465)
					},
					{
						co(2624, 2996),
						co(2632, 3004),
						co(2640, 3012),
						co(2648, 3020),
						co(2656, 3028)
					},
					{
						co(3034, 3466)
					}
				}
			}
			aW[e4] = {
				coeff = 1.5 / 3.5,
				levels = {
					20,
					28,
					36,
					44,
					52,
					60,
					66,
					72,
					77
				},
				averages = {
					{
						co(162, 186),
						co(163, 188),
						co(165, 190),
						co(167, 192),
						co(168, 193),
						co(170, 195)
					},
					{
						co(247, 281),
						co(249, 284),
						co(251, 286),
						co(253, 288),
						co(255, 290),
						co(257, 292)
					},
					{
						co(337, 381),
						co(339, 384),
						co(342, 386),
						co(344, 389),
						co(347, 391),
						co(349, 394)
					},
					{
						co(458, 514),
						co(461, 517),
						co(464, 520),
						co(467, 523),
						co(470, 526),
						co(473, 529)
					},
					{
						co(631, 705),
						co(634, 709),
						co(638, 713),
						co(641, 716),
						co(645, 720),
						co(649, 723)
					},
					{
						co(832, 928),
						co(836, 933),
						co(840, 937),
						co(844, 941),
						co(848, 945),
						co(853, 949)
					},
					{
						co(1039, 1185),
						co(1043, 1190),
						co(1047, 1194),
						co(1051, 1198),
						co(1055, 1202)
					},
					{
						co(1382, 1578),
						co(1387, 1583),
						co(1392, 1588),
						co(1397, 1593),
						co(1402, 1598)
					},
					{
						co(1606, 1834),
						co(1612, 1840),
						co(1618, 1846),
						co(1624, 1852)
					}
				}
			}
			b2[e6] = {
				mod = 0.25 / 3,
				current = 0
			}
			b2[e5] = {
				mod = 0.10,
				current = 0
			}
			b2[e7] = {
				mod = 0.02,
				current = 0
			}
			b2[e9] = {
				mod = 0.04,
				current = 0
			}
			b1["Skyshatter"] = {
				31016,
				31007,
				31012,
				31019,
				31022,
				34543,
				34438,
				34565
			}
			b1["T7 Resto"] = {
				40508,
				40509,
				40510,
				40512,
				40513,
				39583,
				39588,
				39589,
				39590,
				39591
			}
			b1["T9 Resto"] = {
				48280,
				48281,
				48282,
				48283,
				48284,
				48295,
				48296,
				48297,
				48298,
				48299,
				48301,
				48302,
				48303,
				48304,
				48300,
				48306,
				48307,
				48308,
				48309,
				48305,
				48286,
				48287,
				48288,
				48289,
				48285,
				48293,
				48292,
				48291,
				48290,
				48294
			}
			local ed = {
				[42598] = 320,
				[42597] = 267,
				[42596] = 236,
				[42595] = 204,
				[25645] = 79,
				[22396] = 80,
				[23200] = 53,
				[186072] = 10
			}
			local ee = {
				[45114] = 243,
				[38368] = 102,
				[28523] = 87
			}
			local ef, eg = {}, {}
			cs = function(b8, b6)
				ef[b6] = c5(b8, ea) and true or nil;
				if c5(b8, e8) then
					eg[b6] = true
				elseif eg[b6] then
					eg[b6] = nil
				end
			end;
			cu = function(b6)
				ef[b6] = c2[b6] and c5(c2[b6], ea) and true or nil
			end;
			cr = function(bt, b6, aH, amount)
				local cx = GetSpellInfo(aH)
				if c4[55440] and b6 ~= aS and cx == e3 then
					if c2[b6] then
						return string.format("%s,%d,%s,%d", ba[b6], amount, ba[aS], amount * 0.20), - 1
					else
						return ba[UnitGUID("player")], amount * 0.20
					end
				elseif aC and cx == ec then
					if c3[e1] ~= c3[b6] then
						return nil
					end
				end;
				return ba[b6]
			end;
			ct = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local bA = cw(aX, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				local d7 = aX[cx].ticks;
				ci = ci * (1 + b2[e7].current)
				if cx == ea then
					if b0["T9 Resto"] >= 2 then
						ch = ch * 1.20
					end;
					if c4[63273] then
						d7 = d7 + 2
					end
				end;
				cg = cg * aX[cx].coeff * (aA and 1.88 or 1)
				cg = cg / aX[cx].ticks;
				bA = bA / aX[cx].ticks;
				bA = ce(aX[cx].levels[cy], bA, cg, ch, ci)
				if aC and cx == ec then
					local _, _, _, _, _, eh = c5("player", ec)
					local bh = ceil(eh - GetTime())
					d7 = bh
				end;
				return aL, math.floor(bA), d7, aX[cx].interval
			end;
			cq = function(b6, aH, b8)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local bA = cw(aW, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				if az or aA then
					ci = ci * (1 + b2[e7].current)
				else
					bA = bA * (1 + b2[e7].current)
				end;
				if cx == e2 then
					cg = cg * aW[cx].coeff * (aA and 1.88 or 1)
					if b0["Skyshatter"] >= 4 then
						ci = ci * 1.05
					end;
					if b0["T7 Resto"] >= 4 then
						ci = ci * 1.05
					end;
					ci = ci * (1 + b2[e5].current)
					if ef[b6] then
						ci = ci * 1.25;
						ef[b6] = nil
					end;
					if c1 and ee[c1] then
						bA = bA + ee[c1]
					end
				elseif cx == e3 then
					local ei = select(3, c5(b8, 29203))
					if ei then
						bA = bA * (ei * 0.06 + 1)
					end;
					if aA then
						ci = ci * (1 + b2[e6].current)
					end;
					if b0["T7 Resto"] >= 4 then
						ci = ci * 1.05
					end;
					local cl = cy > 3 and 3 or cy == 3 and 2.5 or cy == 2 and 2 or 1.5;
					if c1 == 27544 then
						cg = cg + 88
					end;
					cg = cg * (cl / 3.5 * (aA and 1.88 or 1) + b2[e9].current)
				elseif cx == e4 then
					if c4[55438] and eg[b6] then
						ci = ci * 1.20
					end;
					cg = cg + (c1 and ed[c1] or 0)
					cg = cg * (aW[cx].coeff * (aA and 1.88 or 1) + b2[e9].current / 2)
				elseif cx == ea then
					cg = ceil(cg * aW[cx].coeff * (aA and 1.88 or 1))
				end;
				bA = ce(aW[cx].levels[cy], bA, cg, ch, ci)
				if GetSpellCritChance(4) >= 100 then
					bA = bA * 1.50
				end;
				return aJ, ceil(bA)
			end
		end
	end;
	if b5 == "HUNTER" then
		cv = function()
			local ej = GetSpellInfo(136)
			if az or aA then
				aX[ej] = {
					interval = 3,
					levels = {
						12,
						20,
						28,
						36,
						44,
						52,
						60,
						68,
						74,
						80
					},
					ticks = 5,
					averages = {
						125,
						250,
						450,
						700,
						1000,
						1400,
						1825,
						2375,
						4250,
						5250
					}
				}
			else
				aW[ej] = {
					interval = 1,
					levels = {
						12,
						20,
						28,
						36,
						44,
						52,
						60
					},
					ticks = 5,
					averages = {
						100,
						190,
						340,
						515,
						710,
						945,
						1225
					}
				}
			end;
			b1["Giantstalker"] = {
				16851,
				16849,
				16850,
				16845,
				16848,
				16852,
				16846,
				16847
			}
			cr = function(bt, b6, aH)
				local ek = UnitGUID("pet")
				return ek and ba[ek]
			end;
			ct = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local amount = cw(aX, cx, aH, cy)
				if b0["Giantstalker"] >= 3 then
					amount = amount * 1.1
				end;
				return aL, ceil(amount / aX[cx].ticks), aX[cx].ticks, aX[cx].interval
			end;
			cq = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				local bA = cw(aW, cx, aH, cy)
				if b0["Giantstalker"] >= 3 then
					bA = bA * 1.1
				end;
				return aK, ceil(bA / aW[cx].ticks), aW[cx].ticks, aW[cx].interval
			end
		end
	end;
	if aC and b5 == "MAGE" then
		cv = function()
			local el = GetSpellInfo(412510) or "Mass Regeneration"
			local em = GetSpellInfo(401417) or "Regeneration"
			aW[el] = {
				_isChanneled = true,
				coeff = 0.081 * 3,
				interval = 1,
				ticks = 3,
				levels = {
					nil
				},
				averages = cB(38.258376, 0.42, 0.904195, 0.161311)
			}
			aW[em] = {
				_isChanneled = true,
				coeff = 0.243 * 3,
				interval = 1,
				ticks = 3,
				levels = {
					nil
				},
				averages = cB(38.258376, 0.42, 0.904195, 0.161311)
			}
			cr = function(bt, b6, aH)
				local cx = GetSpellInfo(aH)
				if cx == el then
					local d2 = ba[b6]
					local dX = c3[b6]
					for d4, bi in pairs(c3) do
						local dY = c2[d4]
						if bi == dX and b6 ~= d4 and UnitIsVisible(dY) and not UnitHasVehicleUI(dY) then
							d2 = d2 .. "," .. ba[d4]
						end
					end;
					return d2
				end;
				return ba[b6]
			end;
			cq = function(b6, aH)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				if not cy then
					return
				end;
				local bA = cw(aW, cx, aH, cy)
				local cg = GetSpellBonusHealing()
				local ci, ch = aV, 1;
				cg = cg * aW[cx].coeff;
				cg = cg / aW[cx].ticks;
				bA = ce(aW[cx].levels[cy], bA, cg, ch, ci)
				if cx == el or cx == em then
					return aK, math.ceil(bA), aW[cx].ticks, aW[cx].interval
				end;
				return aJ, ceil(bA)
			end
		end
	end;
	if not au.aurasUpdated then
		au.aurasUpdated = true;
		au.healingModifiers = nil
	end;
	au.currentModifiers = au.currentModifiers or {}
	au.healingModifiers = au.healingModifiers or {
		[28776] = 0.10,
		[36693] = 0.55,
		[46296] = 0.25,
		[19716] = 0.25,
		[13737] = 0.50,
		[15708] = 0.50,
		[16856] = 0.50,
		[17547] = 0.50,
		[19643] = 0.50,
		[24573] = 0.50,
		[27580] = 0.50,
		[29572] = 0.50,
		[31911] = 0.50,
		[32736] = 0.50,
		[35054] = 0.50,
		[37335] = 0.50,
		[39171] = 0.50,
		[40220] = 0.50,
		[44268] = 0.50,
		[12294] = 0.50,
		[21551] = 0.50,
		[21552] = 0.50,
		[21553] = 0.50,
		[25248] = 0.50,
		[30330] = 0.50,
		[43441] = 0.50,
		[30843] = 0.00,
		[19434] = 0.50,
		[20900] = 0.50,
		[20901] = 0.50,
		[20902] = 0.50,
		[20903] = 0.50,
		[20904] = 0.50,
		[27065] = 0.50,
		[34625] = 0.25,
		[35189] = 0.50,
		[32315] = 0.50,
		[32378] = 0.50,
		[36917] = 0.50,
		[44534] = 0.50,
		[34366] = 0.75,
		[36023] = 0.50,
		[36054] = 0.50,
		[45885] = 0.50,
		[41292] = 0.00,
		[40599] = 0.50,
		[9035] = 0.80,
		[19281] = 0.80,
		[19282] = 0.80,
		[19283] = 0.80,
		[19284] = 0.80,
		[25470] = 0.80,
		[34073] = 0.85,
		[31306] = 0.25,
		[44475] = 0.25,
		[23169] = 0.50,
		[22859] = 0.50,
		[38572] = 0.50,
		[39595] = 0.50,
		[45996] = 0.00,
		[41350] = 2.00,
		[28176] = 1.20,
		[7068] = 0.25,
		[17820] = 0.25,
		[22687] = 0.25,
		[23224] = 0.25,
		[24674] = 0.25,
		[28440] = 0.25,
		[13583] = 0.50,
		[23230] = 0.50,
		[31977] = 1.50
	}
	if aA then
		au.healingModifiers[34123] = 1.06;
		au.healingModifiers[45237] = 1.03;
		au.healingModifiers[45241] = 1.04;
		au.healingModifiers[45242] = 1.05
	end;
	au.healingStackMods = au.healingStackMods or {
		[25646] = function(en)
			return 1 - en * 0.10
		end,
		[28467] = function(en)
			return 1 - en * 0.10
		end,
		[30641] = function(en)
			return 1 - en * 0.05
		end,
		[31464] = function(en)
			return 1 - en * 0.10
		end,
		[36814] = function(en)
			return 1 - en * 0.10
		end,
		[38770] = function(en)
			return 1 - en * 0.05
		end,
		[45347] = function(en)
			return 1 - en * 0.05
		end,
		[30423] = function(en)
			return 1 - en * 0.01
		end,
		[45242] = function(en)
			return 1 + en * 0.10
		end
	}
	if az or aA then
		au.healingStackMods[13218] = function(en)
			return 1 - en * 0.10
		end;
		au.healingStackMods[13222] = function(en)
			return 1 - en * 0.10
		end;
		au.healingStackMods[13223] = function(en)
			return 1 - en * 0.10
		end;
		au.healingStackMods[13224] = function(en)
			return 1 - en * 0.10
		end;
		au.healingStackMods[27189] = function(en)
			return 1 - en * 0.10
		end
	end;
	local eo = au.healingStackMods;
	local ep, eq = au.healingModifiers, au.currentModifiers;
	local er;
	local es = _G.ChatThrottleLib;
	local function et(a1)
		if er and strlen(a1) <= 240 then
			if es then
				es:SendAddonMessage("BULK", av, a1, er or 'GUILD')
			end
		end
	end;
	local eu;
	local function ev()
		if eu == "pvp" or eu == "arena" or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			er = "INSTANCE_CHAT"
		elseif IsInRaid() then
			er = "RAID"
		elseif IsInGroup() then
			er = "PARTY"
		else
			er = nil
		end
	end;
	function au:PLAYER_ENTERING_WORLD()
		au.eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
		au:ZONE_CHANGED_NEW_AREA()
	end;
	function au:ZONE_CHANGED_NEW_AREA()
		local ew = GetZonePVPInfo()
		local ex = select(2, IsInInstance())
		au.zoneHealModifier = 1;
		if ew == "combat" or ex == "arena" or ex == "pvp" then
			au.zoneHealModifier = 0.90
		end;
		if ex ~= eu then
			eu = ex;
			ev()
			br()
			wipe(b3)
		end;
		eu = ex
	end;
	local ey = {}
	function au:UNIT_AURA(b8)
		local b6 = UnitGUID(b8)
		if not c2[b6] then
			return
		end;
		local ez, eA, eB, eC = 1, 1, 1, 1;
		local bi = 1;
		while true do
			local cd, _, bf, _, _, _, _, _, _, aH = UnitAura(b8, bi, "HELPFUL")
			if not cd then
				break
			end;
			if not ey[cd] then
				ey[cd] = true;
				if ep[aH] then
					ez = ez * ep[aH]
				elseif eo[aH] then
					ez = ez * eo[aH](bf)
				end
			end;
			bi = bi + 1
		end;
		bi = 1;
		while true do
			local cd, _, bf, _, _, _, _, _, _, aH = UnitAura(b8, bi, "HARMFUL")
			if not cd then
				break
			end;
			if ep[aH] then
				eA = min(eA, ep[aH])
			elseif eo[aH] then
				eA = min(eA, eo[aH](bf))
			end;
			bi = bi + 1
		end;
		local eD = ez * eA;
		if eD ~= eq[b6] then
			if eq[b6] or eD ~= 1 then
				eq[b6] = eD;
				self.callbacks:Fire("HealComm_ModifierChanged", b6, eD)
			else
				eq[b6] = eD
			end
		end;
		wipe(ey)
		if b8 == "player" then
			if c5("player", 10060) and not (aA or az) then
				eB = eB * 1.20
			end;
			local eE = select(3, c5("player", 30422))
			if eE then
				eB = eB * (1 + eE * 0.05)
			end;
			if c5("player", 41406) then
				eB = eB * 1.05
			end;
			if c5("player", 41409) then
				eC = eC * 0.95
			end;
			if c5("player", 32346) then
				eC = eC * 0.50
			end;
			if c5("player", 40099) then
				eC = eC * 0.50
			end;
			if c5("player", 38246) then
				eC = eC * 0.50
			end;
			if c5("player", 45573) then
				eC = eC * 0.50
			end;
			aV = eB * eC
		end;
		if cs then
			cs(b8, b6)
		end
	end;
	function au:GlyphsUpdated(bi)
		local aH = c4[bi]
		if aH then
			c4[aH] = nil;
			c4[bi] = nil
		end;
		local eF, _, eG = GetGlyphSocketInfo(bi)
		if eF and eG then
			c4[eG] = true;
			c4[bi] = eG
		end
	end;
	au.GLYPH_ADDED = au.GlyphsUpdated;
	au.GLYPH_REMOVED = au.GlyphsUpdated;
	au.GLYPH_UPDATED = au.GlyphsUpdated;
	function au:PLAYER_LEVEL_UP(cf)
		aU = tonumber(cf) or UnitLevel("player")
	end;
	function au:CHARACTER_POINTS_CHANGED()
		for eH = 1, GetNumTalentTabs() do
			for i = 1, GetNumTalents(eH) do
				local cd, _, _, _, eI = GetTalentInfo(eH, i)
				if cd and b2[cd] then
					b2[cd].current = b2[cd].mod * eI;
					b2[cd].spent = eI
				end
			end
		end
	end;
	local eJ = GetInventorySlotInfo("RangedSlot")
	function au:PLAYER_EQUIPMENT_CHANGED()
		if not InCombatLockdown() then
			for cd, eK in pairs(b1) do
				b0[cd] = 0;
				for _, eL in pairs(eK) do
					if IsEquippedItem(eL) then
						b0[cd] = b0[cd] + 1
					end
				end
			end
		end;
		local eM = GetInventoryItemLink("player", eJ)
		c1 = eM and tonumber(strmatch(eM, "item:(%d+):")) or nil
	end;
	local function eN(...)
		local o = au:RetrieveTable()
		for i = 1, select("#", ...) do
			o[i] = tonumber(select(i, ...))
		end;
		return o
	end;
	local function eO(be, amount, bf, bg, bh, ...)
		wipe(aY)
		if amount ~= - 1 and amount ~= "-1" then
			amount = not be.hasVariableTicks and amount or eN(strsplit("@", amount))
			for i = 1, select("#", ...) do
				local b6 = select(i, ...)
				local eP = b6 and bb[b6]
				if eP then
					bd(be, eP, amount, bf, bg, bh)
					tinsert(aY, eP)
				end
			end
		else
			for i = 1, select("#", ...), 2 do
				local b6 = select(i, ...)
				local eP = b6 and bb[b6]
				amount = not be.hasVariableTicks and tonumber(select(i + 1, ...)) or eN(string.split("@", amount))
				if eP and amount then
					bd(be, eP, amount, bf, bg, bh)
					tinsert(aY, eP)
				end
			end
		end
	end;
	local function eQ(bs, aH, amount, cl, ...)
		local cx = GetSpellInfo(aH)
		local b8 = c2[bs]
		if not b8 or not cx or not amount or select("#", ...) == 0 then
			return
		end;
		local bg;
		if b8 == "player" then
			bg = select(5, CastingInfo())
			if not bg then
				return
			end;
			bg = bg / 1000
		else
			bg = GetTime() + (cl or 1.5)
		end;
		aZ[bs] = aZ[bs] or {}
		aZ[bs][cx] = aZ[bs][cx] or {}
		local be = aZ[bs][cx]
		wipe(be)
		be.endTime = bg;
		be.spellID = aH;
		be.bitType = aJ;
		eO(be, amount, 1, be.endTime, nil, ...)
		au.callbacks:Fire("HealComm_HealStarted", bs, aH, be.bitType, be.endTime, unpack(aY))
	end;
	au.parseDirectHeal = eQ;
	local function eR(bs, aH, amount, d7, ...)
		local cx = GetSpellInfo(aH)
		local b8 = c2[bs]
		if not b8 or not cx or not d7 or not amount or select("#", ...) == 0 then
			return
		end;
		local b_ = cx == GetSpellInfo(740) and 2 or 1;
		local bv, bg;
		if b8 == "player" then
			bv, bg = select(4, ChannelInfo())
			if not bv then
				return
			end;
			bv = bv / 1000;
			bg = bg / 1000
		else
			bv = GetTime()
			bg = bv + d7 * b_
		end;
		a_[bs] = a_[bs] or {}
		a_[bs][cx] = a_[bs][cx] or {}
		local bm = amount == - 1 and 2 or 1;
		local be = a_[bs][cx]
		wipe(be)
		be.startTime = bv;
		be.endTime = bg;
		be.duration = bg - bv;
		be.totalTicks = d7;
		be.tickInterval = be.duration / d7;
		be.spellID = aH;
		be.isMultiTarget = select("#", ...) / bm > 1;
		be.bitType = aK;
		local bh = ceil((bg - GetTime()) / be.tickInterval)
		eO(be, amount, 1, bg, bh, ...)
		au.callbacks:Fire("HealComm_HealStarted", bs, aH, be.bitType, be.endTime, unpack(aY))
	end;
	local function c6(bs, aH, ...)
		for i = 1, select("#", ...) do
			local b6 = bb[select(i, ...)]
			local b8 = b6 and c2[b6]
			if b8 and UnitIsVisible(b8) then
				local bi = 1;
				while true do
					local cd, _, bf, _, cn, bg, dW, _, _, eS = UnitAura(b8, bi, 'HELPFUL')
					if not eS then
						break
					end;
					if eS == aH and dW and UnitGUID(dW) == bs then
						return bf and bf > 0 and bf or 1, cn or 0, bg or 0
					end;
					bi = bi + 1
				end
			end
		end
	end;
	local function eT(bs, eU, aH, dc, d7, b_, ...)
		local cx = GetSpellInfo(aH)
		if not dc or not cx or select("#", ...) == 0 then
			return
		end;
		if type(dc) == "table" then
			dc = table.concat(dc, "@")
		end;
		local bm = 2;
		local bf, cn, bg = c6(bs, aH, ...)
		if not (dc == - 1 or dc == "-1") then
			bm = 1;
			cn = d7 * (b_ or 1)
			bg = GetTime() + cn
		end;
		if not bf or bf == 0 or cn == 0 or bg == 0 then
			return
		end;
		a_[bs] = a_[bs] or {}
		a_[bs][cx] = a_[bs][cx] or {}
		local be = a_[bs][cx]
		be.duration = cn;
		be.endTime = bg;
		be.stack = bf;
		be.totalTicks = d7 or cn / b_;
		be.tickInterval = d7 and cn / d7 or b_;
		be.spellID = aH;
		be.hasVariableTicks = type(dc) == "string"
		be.isMultiTarget = select("#", ...) / bm > 1;
		be.bitType = aL;
		local bh = ceil((bg - GetTime()) / be.tickInterval)
		eO(be, dc, bf, bg, bh, ...)
		if not eU then
			au.callbacks:Fire("HealComm_HealStarted", bs, aH, be.bitType, bg, unpack(aY))
		else
			au.callbacks:Fire("HealComm_HealUpdated", bs, aH, be.bitType, bg, unpack(aY))
		end
	end;
	local function eV(bs, eU, aH, amount, ...)
		local cx, cy = GetSpellInfo(aH)
		if not amount or not cx or select("#", ...) == 0 then
			return
		end;
		local eW = a_[bs] and a_[bs][cx]
		if not eW or not eW.bitType then
			return
		end;
		eW.hasBomb = true;
		aZ[bs] = aZ[bs] or {}
		aZ[bs][cx] = aZ[bs][cx] or {}
		local be = aZ[bs][cx]
		be.endTime = eW.endTime;
		be.spellID = aH;
		be.bitType = aN;
		be.stack = (aA or aC) and eW.stack or 1;
		eO(be, amount, be.stack, be.endTime, nil, ...)
		if not eU then
			au.callbacks:Fire("HealComm_HealStarted", bs, aH, be.bitType, be.endTime, unpack(aY))
		else
			au.callbacks:Fire("HealComm_HealUpdated", bs, aH, be.bitType, be.endTime, unpack(aY))
		end
	end;
	local function eX(bs, be, eY, aH, eZ, ...)
		local cx = GetSpellInfo(aH)
		if not cx or not bs then
			return
		end;
		if not be then
			if aZ[bs] then
				be = aZ[bs][cx]
			end;
			if not be and a_[bs] then
				be = a_[bs][cx]
			end
		end;
		if not be or not be.bitType then
			return
		end;
		wipe(aY)
		if select("#", ...) == 0 then
			for i = # be, 1, - 5 do
				tinsert(aY, be[i - 4])
				bk(be, be[i - 4])
			end
		else
			for i = 1, select("#", ...) do
				local b6 = bb[select(i, ...)]
				if b6 then
					tinsert(aY, b6)
					bk(be, b6)
				end
			end
		end;
		if # aY == 0 then
			return
		end;
		local e_ = be.hasBomb and aZ[bs][cx]
		if e_ and e_.bitType then
			eX(bs, e_, "name", aH, eZ, ...)
		end;
		local bt = be.bitType;
		if # be == 0 then
			wipe(be)
		end;
		au.callbacks:Fire("HealComm_HealStopped", bs, aH, bt, eZ, unpack(aY))
	end;
	au.parseHealEnd = eX;
	local function f0(bs, f1, f2, aH)
		local cx = GetSpellInfo(aH)
		local bv = f1 + GetTime()
		local bg = f2 + GetTime()
		if not bs then
			return
		end;
		local be = aZ[bs][cx] or a_[bs][cx]
		if be.endTime == bg and be.startTime == bv then
			return
		end;
		if be.bitType == aJ then
			be.startTime = bv;
			be.endTime = bg
		elseif be.bitType == aK then
			be.startTime = bv;
			be.endTime = bg;
			be.duration = bg - bv;
			be.tickInterval = be.duration / be.totalTicks
		else
			return
		end;
		wipe(aY)
		for i = 1, # be, 5 do
			be[i + 3] = bg;
			tinsert(aY, be[i])
		end;
		au.callbacks:Fire("HealComm_HealDelayed", bs, be.spellID, be.bitType, be.endTime, unpack(aY))
	end;
	function au:CHAT_MSG_ADDON(aa, f3, f4, f5)
		if aa ~= av or f4 ~= er then
			return
		end;
		local f6, f7, aH, f8, f9, fa, fb, fc, fd = strsplit(":", f3)
		local bs = UnitGUID(Ambiguate(f5, "none"))
		aH = tonumber(aH)
		if not f6 or not aH or not bs or bs == aS then
			return
		end;
		if not AutoHelp.HealCommLibUsers then
			AutoHelp.HealCommLibUsers = {}
		end;
		if not AutoHelp.HealCommLibUsers[f5] then
			AutoHelp.HealCommLibUsers[f5] = GetTime()
		end;
		if f6 == "D" and f8 and f9 then
			eQ(bs, aH, tonumber(f8), tonumber(f7), strsplit(",", f9))
		elseif f6 == "C" and f8 and fa then
			eR(bs, aH, tonumber(f8), tonumber(f9), strsplit(",", fa))
		elseif f6 == "B" and f8 and fd then
			eT(bs, false, aH, tonumber(fa), tonumber(f7), tonumber(fc), strsplit(",", fd))
			eV(bs, false, aH, tonumber(f8), strsplit(",", f9))
		elseif f6 == "H" and f8 and fb then
			eT(bs, false, aH, tonumber(f8), tonumber(f7), tonumber(fa), strsplit(",", fb))
		elseif f6 == "U" and f8 and fa then
			eT(bs, true, aH, tonumber(f8), tonumber(f7), tonumber(f9), strsplit(",", fa))
		elseif f6 == "VH" and f8 and fb then
			eT(bs, false, aH, f8, tonumber(fa), tonumber(f7), string.split(",", fb))
		elseif f6 == "VU" and f8 and fa then
			eT(bs, true, aH, f8, tonumber(f9), tonumber(f7), string.split(",", fa))
		elseif f6 == "UB" and f8 and fc then
			eT(bs, true, aH, tonumber(fa), tonumber(f7), tonumber(fb), strsplit(",", fc))
			eV(bs, true, aH, tonumber(f8), strsplit(",", f9))
		elseif f6 == "S" or f6 == "HS" then
			local eZ = f8 == "1" and true or false;
			local fe = f6 == "HS" and "id" or "name"
			local be = f6 == "HS" and a_[bs] and a_[bs][GetSpellInfo(aH)]
			if f9 and f9 ~= "" then
				eX(bs, be, fe, aH, eZ, strsplit(",", f9))
			else
				eX(bs, be, fe, aH, eZ)
			end
		elseif f6 == "F" then
			f0(bs, tonumber(f8), tonumber(f9), aH)
		end
	end;
	au.bucketHeals = au.bucketHeals or {}
	local ff = au.bucketHeals;
	local fg = 0.30;
	au.bucketFrame = au.bucketFrame or CreateFrame("Frame")
	au.bucketFrame:Hide()
	au.bucketFrame:SetScript("OnUpdate", function(self, fh)
		local fi = 0;
		for bs, bq in pairs(ff) do
			for _, fj in pairs(bq) do
				if fj.timeout then
					fj.timeout = fj.timeout - fh;
					if fj.timeout <= 0 then
						if # fj == 0 or not fj.spellID or not fj.spellName then
							wipe(fj)
						elseif fj.type == "tick" then
							local be = a_[bs] and a_[bs][fj.spellName]
							if be and be.bitType then
								local bg = select(3, bj(be, fj[1]))
								au.callbacks:Fire("HealComm_HealUpdated", bs, be.spellID, be.bitType, bg, unpack(fj))
							end;
							wipe(fj)
						elseif fj.type == "heal" then
							local bt, amount, d7, b_, _, fk = ct(fj[1], fj.spellID)
							if bt then
								local d2 = cr(bt, fj[1], fj.spellID, fj)
								eT(aS, false, fj.spellID, amount, d7, b_, strsplit(",", d2))
								if not fk then
									et(format("H:%d:%d:%d::%d:%s", d7, fj.spellID, amount, b_, d2))
								else
									et(format("VH:%d:%d:%s::%d:%s", b_, fj.spellID, table.concat(amount, "@"), d7, d2))
								end
							end;
							wipe(fj)
						end
					else
						fi = fi + 1
					end
				end
			end
		end;
		if fi <= 0 then
			self:Hide()
		end
	end)
	local fl = {
		SPELL_HEAL = true,
		SPELL_PERIODIC_HEAL = true,
		SPELL_AURA_REMOVED = true,
		SPELL_AURA_APPLIED = true,
		SPELL_AURA_REFRESH = true,
		SPELL_AURA_APPLIED_DOSE = true,
		SPELL_AURA_REMOVED_DOSE = true
	}
	function au:COMBAT_LOG_EVENT_UNFILTERED(...)
		local fm, fn, fo, fp, fq, fr, fs, ft, fu, fv, fw = ...
		if not fl[fn] then
			return
		end;
		local _, cx = select(12, ...)
		local fx = c2[ft]
		if not fx then
			return
		end;
		local aH = fx and select(10, c5(fx, cx)) or select(7, GetSpellInfo(cx))
		if fn == "SPELL_HEAL" or fn == "SPELL_PERIODIC_HEAL" then
			local be = fp and a_[fp] and a_[fp][cx]
			if be and be[ft] and be.bitType and bit.band(be.bitType, aQ) > 0 then
				local amount, bf, _, bh = bj(be, ft)
				bh = bh - 1;
				local bg = GetTime() + be.tickInterval * bh;
				bd(be, ft, amount, bf, bg, bh)
				if be.isMultiTarget and fp then
					ff[fp] = ff[fp] or {}
					ff[fp][cx] = ff[fp][cx] or {}
					local fy = ff[fp][cx]
					if not fy[ft] then
						fy.timeout = fg;
						fy.type = "tick"
						fy.spellName = cx;
						fy.spellID = aH;
						fy[ft] = true;
						tinsert(fy, ft)
						self.bucketFrame:Show()
					end
				else
					au.callbacks:Fire("HealComm_HealUpdated", fp, aH, be.bitType, bg, ft)
				end
			end
		elseif (fn == "SPELL_AURA_APPLIED" or fn == "SPELL_AURA_REFRESH" or fn == "SPELL_AURA_APPLIED_DOSE") and bit.band(fr, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE then
			if aX[cx] then
				local bt, amount, d7, b_, d6, fk = ct(ft, aH)
				if bt then
					local d2 = cr(type, ft, aH)
					if d2 then
						eT(fp, false, aH, amount, d7, b_, strsplit(",", d2))
						if d6 then
							local fz = cr(aN, ft, cx)
							eV(fp, false, aH, d6, strsplit(",", fz))
							et(format("B:%d:%d:%d:%s:%d::%d:%s", d7, aH, d6, fz, amount, b_, d2))
						elseif fk then
							et(format("VH:%d:%d:%s::%d:%s", b_, aH, table.concat(amount, "@"), d7, d2))
						else
							et(format("H:%d:%d:%d::%d:%s", d7, aH, amount, b_, d2))
						end
					end
				end
			end
		elseif fn == "SPELL_AURA_REMOVED_DOSE" and bit.band(fr, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE then
			local be = fp and aZ[fp] and aZ[fp][aH]
			if be and be.bitType then
				local amount = bj(be, ft)
				if amount then
					eT(fp, true, aH, amount, be.totalTicks, be.tickInterval, ba[ft])
					local e_ = be.hasBomb and aZ[fp][cx]
					if e_ and e_.bitType then
						local d6 = bj(e_, ft)
						if d6 then
							eV(fp, true, aH, d6, ba[ft])
							et(format("UB:%s:%d:%d:%s:%d:%d:%s", be.totalTicks, aH, d6, ba[ft], amount, be.tickInterval, ba[ft]))
							return
						end
					end;
					if be.hasVariableTicks then
						et(format("VU:%d:%d:%s:%d:%s", be.tickInterval, aH, amount, be.totalTicks, ba[ft]))
					else
						et(format("U:%s:%d:%d:%d:%s", aH, amount, be.totalTicks, be.tickInterval, ba[ft]))
					end
				end
			end
		elseif fn == "SPELL_AURA_REMOVED" and bit.band(fr, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE then
			if ba[ft] then
				local be = a_[aS] and a_[aS][cx]
				if aX[cx] then
					if aC and cx == "Healing Rain" and c3[e1] ~= c3[ft] then
						return
					end;
					eX(fp, be, "id", aH, false, ba[ft])
					et(format("HS::%d::%s", aH, ba[ft]))
				elseif aW[cx] and aW[cx]._isChanneled then
					eX(fp, be, "id", aH, false, ba[ft])
					et(format("S::%d:0:%s", aH, ba[ft]))
				end
			end
		end
	end;
	local fA, fB, fC, fD, fE, fF, fG;
	local fH, fI, fJ, lastName, fK;
	local fL, fM = {}, {}
	local function fN(fO, cd, b6)
		if not b6 or not fE then
			return
		end;
		if fM[fE] and fM[fE] >= fO then
			return
		end;
		if fA and fA == cd then
			fO = 99
		end;
		fL[fE] = b6;
		fM[fE] = fO
	end;
	local fP = {
		[47540] = 47757,
		[53005] = 52986,
		[53006] = 52987,
		[53007] = 52988,
		[402174] = 402277
	}
	function au:UNIT_SPELLCAST_SENT(b8, fQ, fR, aH)
		local cx = GetSpellInfo(aH)
		if b8 ~= "player" then
			return
		end;
		if aX[cx] or aW[cx] then
			fQ = fQ or UnitName("player")
			fA = gsub(fQ, "(.-)%-(.*)$", "%1")
			fE = fP[aH] or aH;
			if fD then
				fD = nil;
				self.resetFrame:Show()
				fM[fE] = nil;
				fN(5, fC, fB)
			else
				local b6 = UnitGUID(fQ)
				if not b6 then
					b6 = UnitName("target") == fA and UnitGUID("target") or UnitName("focus") == fA and UnitGUID("focus") or UnitName("mouseover") == fA and UnitGUID("mouseover") or UnitName("targettarget") == fA and UnitGUID("target") or UnitName("focustarget") == fA and UnitGUID("focustarget")
				end;
				fM[fE] = nil;
				fN(0, nil, b6)
			end
		end
	end;
	local fS = {
		[GetSpellInfo(689)] = true,
		[GetSpellInfo(740)] = true,
		[GetSpellInfo(331)] = true
	}
	if az or aA then
		fS[GetSpellInfo(32546)] = true
	end;
	function au:UNIT_SPELLCAST_START(b8, fT, aH)
		if b8 ~= "player" then
			return
		end;
		local cx = GetSpellInfo(aH)
		if aC and cx == "Healing Rain" then
			e1 = fL[aH]
		end;
		if not aW[cx] or UnitIsCharmed("player") or not UnitPlayerControlled("player") then
			return
		end;
		local fR = fL[aH]
		local fU = c2[fR]
		if (az or aA) and not fU and fS[cx] then
			fR = UnitGUID("player")
			fU = "player"
		elseif c4[55440] and not fU and fS[cx] then
			fU = b8
		end;
		if not fR or not fU then
			return
		end;
		local bt, amount, bF, b_ = cq(fR, aH, fU)
		if not amount then
			return
		end;
		local d2, fV = cr(bt, fR, aH, amount)
		amount = fV or amount;
		if not d2 then
			return
		end;
		if bt == aJ then
			local bv, bg = select(4, CastingInfo())
			eQ(aS, aH, amount, (bg - bv) / 1000, strsplit(",", d2))
			et(format("D:%.3f:%d:%d:%s", (bg - bv) / 1000, aH or 0, amount or "", d2))
		elseif bt == aK then
			eR(aS, aH, amount, bF, string.split(",", d2))
			if cx == "Penance" then
				et(string.format("C::%d:%d:%s:%s", aH, amount, bF - 1, d2))
			else
				et(string.format("C::%d:%d:%s:%s", aH, amount, bF, d2))
			end
		end
	end;
	au.UNIT_SPELLCAST_CHANNEL_START = au.UNIT_SPELLCAST_START;
	local fW = {}
	local function fX()
		local i = 1;
		repeat
			local aH = select(10, UnitBuff("player", i))
			if aH == 17116 or aH == 16188 then
				return true
			end;
			i = i + 1
		until not aH
	end;
	function au:UNIT_SPELLCAST_SUCCEEDED(b8, fT, aH)
		if b8 ~= "player" then
			return
		end;
		local cx = GetSpellInfo(aH)
		if aH == 20216 then
			df = true
		end;
		if aW[cx] and not aW[cx]._isChanneled and not fX() then
			df = nil;
			eX(aS, nil, "name", aH, false)
			et(format("S::%d:0", aH or 0))
			fW[aH] = true
		elseif cx == GetSpellInfo(20473) then
			df = nil
		end
	end;
	function au:UNIT_SPELLCAST_STOP(b8, fR, aH)
		local cx = GetSpellInfo(aH)
		if b8 ~= "player" or not aW[cx] or aW[cx]._isChanneled then
			return
		end;
		if not fW[aH] then
			eX(aS, nil, "name", aH, true)
			et(format("S::%d:1", aH or 0))
		end;
		fW[aH] = nil
	end;
	function au:UNIT_SPELLCAST_CHANNEL_STOP(b8, _, aH)
		local cx = GetSpellInfo(aH)
		if b8 ~= "player" or not aW[cx] then
			return
		end;
		if cx == "Penance" then
			eX(aS, nil, "name", aH, true)
			et(format("S::%d:1", aH or 0))
		end
	end;
	function au:UNIT_SPELLCAST_INTERRUPTED(b8, fR, aH)
		local cx = GetSpellInfo(aH)
		if b8 ~= "player" or not aW[cx] then
			return
		end;
		local b6 = fL[aH]
		if b6 then
			cu(b6, aH)
		end
	end;
	function au:UNIT_SPELLCAST_DELAYED(b8, fR, aH)
		local cx = GetSpellInfo(aH)
		local bs = UnitGUID(b8)
		if b8 ~= "player" or not aZ[bs] or not aZ[bs][cx] then
			return
		end;
		if aZ[bs][cx].bitType == aJ then
			local bv, bg = select(4, CastingInfo())
			if bv and bg then
				local f1 = bv / 1000 - GetTime()
				local f2 = bg / 1000 - GetTime()
				f0(bs, f1, f2, aH)
				et(format("F::%d:%.3f:%.3f", aH, f1, f2))
			end
		elseif aZ[bs][cx].bitType == aK then
			local bv, bg = select(4, ChannelInfo())
			if bv and bg then
				local f1 = bv / 1000 - GetTime()
				local f2 = bg / 1000 - GetTime()
				f0(bs, f1, f2, aH)
				et(format("F::%d:%.3f:%.3f", aH, f1, f2))
			end
		end
	end;
	au.UNIT_SPELLCAST_CHANNEL_UPDATE = au.UNIT_SPELLCAST_DELAYED;
	function au:UPDATE_MOUSEOVER_UNIT()
		fB = UnitCanAssist("player", "mouseover") and UnitGUID("mouseover")
		fC = UnitCanAssist("player", "mouseover") and UnitName("mouseover")
	end;
	function au:PLAYER_TARGET_CHANGED()
		if fJ and lastName then
			if fK then
				fH, fI = fJ, lastName
			end;
			fF, fG = fJ, lastName
		end;
		fJ = UnitGUID("target")
		lastName = UnitName("target")
		fK = UnitCanAssist("player", "target")
	end;
	function au:Target(b8)
		if self.resetFrame:IsShown() and UnitCanAssist("player", b8) then
			fN(6, UnitName(b8), UnitGUID(b8))
		end;
		self.resetFrame:Hide()
		fD = nil
	end;
	au.TargetUnit = au.Target;
	au.SpellTargetUnit = au.Target;
	function au:AssistUnit(b8)
		if self.resetFrame:IsShown() and UnitCanAssist("player", b8 .. "target") then
			fN(6, UnitName(b8 .. "target"), UnitGUID(b8 .. "target"))
		end;
		self.resetFrame:Hide()
		fD = nil
	end;
	function au:TargetLast(b6, cd)
		if cd and b6 and self.resetFrame:IsShown() then
			fN(6, cd, b6)
		end;
		self.resetFrame:Hide()
		fD = nil
	end;
	function au:TargetLastFriend()
		self:TargetLast(fH, fI)
	end;
	function au:TargetLastTarget()
		self:TargetLast(fF, fG)
	end;
	function au:CastSpell(K, b8)
		local aH;
		if tonumber(K) then
			aH = K
		else
			aH = select(7, GetSpellInfo(K))
		end;
		local cx = GetSpellInfo(aH)
		if cx and (aX[cx] or aW[cx]) then
			fE = fP[aH] or aH;
			fM[fE] = nil
		end;
		if b8 and UnitCanAssist("player", b8) then
			fN(4, UnitName(b8), UnitGUID(b8))
		elseif not SpellIsTargeting() then
			if UnitCanAssist("player", "target") then
				fN(4, UnitName("target"), UnitGUID("target"))
			else
				fN(4, aT, aS)
			end;
			fD = nil
		else
			fD = true
		end
	end;
	au.CastSpellByName = au.CastSpell;
	au.CastSpellByID = au.CastSpell;
	au.UseAction = au.CastSpell;
	local function fY()
		for b6, b8 in pairs(c2) do
			if b6 ~= UnitGUID(b8) then
				for _, o in pairs({
					aZ,
					a_
				}) do
					if o[b6] then
						for _, be in pairs(o[b6]) do
							if be.bitType then
								eX(b6, be, nil, be.spellID, true)
							end
						end
					end
				end;
				aZ[b6] = nil;
				a_[b6] = nil;
				bo(b6)
				c2[b6] = nil;
				c3[b6] = nil
			end
		end
	end;
	if not au.hotMonitor then
		au.hotMonitor = CreateFrame("Frame")
		au.hotMonitor:Hide()
		au.hotMonitor.timeElapsed = 0;
		au.hotMonitor:SetScript("OnUpdate", function(self, fh)
			self.timeElapsed = self.timeElapsed + fh;
			if self.timeElapsed < 5 then
				return
			end;
			self.timeElapsed = self.timeElapsed - 5;
			local fZ;
			for b6 in pairs(b3) do
				if c2[b6] and not UnitIsVisible(c2[b6]) then
					bo(b6)
				else
					fZ = true
				end
			end;
			if not fZ then
				self:Hide()
			end
		end)
	end;
	local function f_()
		br()
		wipe(ba)
		wipe(bb)
		wipe(b4)
		aS = aS or UnitGUID("player")
		au.guidToUnit = {
			[aS] = "player"
		}
		c2 = au.guidToUnit;
		au.guidToGroup = {}
		c3 = au.guidToGroup;
		au.activeHots = {}
		b3 = au.activeHots;
		au.pendingHeals = {}
		aZ = au.pendingHeals;
		au.pendingHots = {}
		a_ = au.pendingHots;
		au.bucketHeals = {}
		ff = au.bucketHeals
	end;
	function au:UNIT_PET(b8)
		local b6 = UnitGUID(b8)
		b8 = c2[b6]
		if not b8 then
			return
		end;
		local g0 = self.unitToPet[b8]
		local ek = g0 and UnitGUID(g0)
		local g1 = b4[b8]
		if g1 and ek and g1 ~= ek then
			bo(g1)
			rawset(self.compressGUID, g1, nil)
			rawset(self.decompressGUID, "p-" .. strsub(b6, 8), nil)
			c2[g1] = nil;
			c3[g1] = nil;
			b4[b8] = nil
		end;
		if ek then
			c2[ek] = g0;
			c3[ek] = c3[b6]
			b4[b8] = ek
		end
	end;
	function au:GROUP_ROSTER_UPDATE()
		ev()
		wipe(b4)
		local function g2(b8)
			local b6 = UnitGUID(b8)
			if b6 then
				local g3 = UnitInRaid(b8)
				local dX = g3 and select(3, GetRaidRosterInfo(g3)) or 1;
				c2[b6] = b8;
				c3[b6] = dX;
				local g0 = self.unitToPet[b8]
				local ek = g0 and UnitGUID(g0)
				b4[b8] = ek;
				if ek then
					c2[ek] = g0;
					c3[ek] = dX
				end
			end
		end;
		if GetNumGroupMembers() == 0 then
			f_()
			g2("player")
		elseif not IsInRaid() then
			g2("player")
			for i = 1, MAX_PARTY_MEMBERS do
				g2(format("party%d", i))
			end
		else
			for i = 1, MAX_RAID_MEMBERS do
				g2(format("raid%d", i))
			end
		end;
		fY()
	end;
	function au:PLAYER_ALIVE()
		self:CHARACTER_POINTS_CHANGED()
		self.eventFrame:UnregisterEvent("PLAYER_ALIVE")
	end;
	function au:OnInitialize()
		wipe(aW)
		wipe(aX)
		wipe(b1)
		wipe(b2)
		if cv then
			cv()
		end;
		do
			local g4 = GetSpellInfo(746)
			aW[g4] = {
				_isChanneled = true,
				ticks = {
					6,
					6,
					7,
					7,
					8,
					8,
					8,
					8,
					8,
					8,
					8,
					8,
					8,
					8
				},
				interval = 1,
				averages = {
					66,
					114,
					161,
					301,
					400,
					640,
					800,
					1104,
					1360,
					2000,
					2800,
					3400,
					4800,
					5800
				}
			}
			local g5 = cr;
			cr = function(bt, b6, aH, amount)
				local cx = GetSpellInfo(aH)
				if cx == g4 then
					return ba[b6]
				end;
				if g5 then
					return g5(bt, b6, aH, amount)
				end
			end;
			local g6 = cq;
			cq = function(b6, aH, b8)
				local cx, cy = GetSpellInfo(aH), aE[aH]
				if cx == g4 then
					local bA = aW[cx].averages[cy]
					if not bA then
						return
					end;
					local bF = aW[cx].ticks[cy]
					return aK, ceil(bA / bF), bF, aW[cx].interval
				end;
				if g6 then
					return g6(b6, aH, b8)
				end
			end;
			self.CalculateHealing = cq;
			self.CalculateHotHealing = ct
		end;
		for bi = 1, GetNumGlyphSockets() do
			local eF, _, eG = GetGlyphSocketInfo(bi)
			if eF and eG then
				c4[eG] = true;
				c4[bi] = eG
			end
		end;
		self:PLAYER_EQUIPMENT_CHANGED()
		if GetNumTalentTabs() == 0 then
			self.eventFrame:RegisterEvent("PLAYER_ALIVE")
		else
			self:CHARACTER_POINTS_CHANGED()
		end;
		if cu then
			au.eventFrame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
		end;
		self.eventFrame:RegisterEvent("CHAT_MSG_ADDON")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_START")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_STOP")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
		self.eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		self.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self.eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
		self.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
		self.eventFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
		self.eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
		self.eventFrame:RegisterEvent("CHARACTER_POINTS_CHANGED")
		self.eventFrame:RegisterEvent("UNIT_AURA")
		if aA then
			self.eventFrame:RegisterEvent("GLYPH_ADDED")
			self.eventFrame:RegisterEvent("GLYPH_REMOVED")
			self.eventFrame:RegisterEvent("GLYPH_UPDATED")
		end;
		if self.initialized then
			return
		end;
		self.initialized = true;
		self.resetFrame = CreateFrame("Frame")
		self.resetFrame:Hide()
		self.resetFrame:SetScript("OnUpdate", function(self)
			self:Hide()
		end)
		hooksecurefunc("TargetUnit", function(...)
			au:TargetUnit(...)
		end)
		hooksecurefunc("SpellTargetUnit", function(...)
			au:SpellTargetUnit(...)
		end)
		hooksecurefunc("AssistUnit", function(...)
			au:AssistUnit(...)
		end)
		hooksecurefunc("UseAction", function(...)
			au:UseAction(...)
		end)
		hooksecurefunc("TargetLastFriend", function(...)
			au:TargetLastFriend(...)
		end)
		hooksecurefunc("TargetLastTarget", function(...)
			au:TargetLastTarget(...)
		end)
		hooksecurefunc("CastSpellByName", function(...)
			au:CastSpellByName(...)
		end)
		hooksecurefunc("CastSpellByID", function(...)
			au:CastSpellByID(...)
		end)
	end;
	local function g7(self, aj, ...)
		if aj == 'COMBAT_LOG_EVENT_UNFILTERED' then
			au[aj](au, CombatLogGetCurrentEventInfo())
		else
			au[aj](au, ...)
		end
	end;
	au.eventFrame = au.frame or au.eventFrame or CreateFrame("Frame")
	au.eventFrame:UnregisterAllEvents()
	au.eventFrame:RegisterEvent("UNIT_PET")
	au.eventFrame:SetScript("OnEvent", g7)
	au.frame = nil;
	function au:PLAYER_LOGIN()
		aS = UnitGUID("player")
		aT = UnitName("player")
		aU = UnitLevel("player")
		c2[aS] = "player"
		self:OnInitialize()
		self.eventFrame:UnregisterEvent("PLAYER_LOGIN")
		self.eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
		self.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
		self.eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
		self:ZONE_CHANGED_NEW_AREA()
		self:GROUP_ROSTER_UPDATE()
	end;
	if not IsLoggedIn() then
		au.eventFrame:RegisterEvent("PLAYER_LOGIN")
	else
		au:PLAYER_LOGIN()
	end
end;
at()
local function g8()
	local l, m = "HereBeDragons-2.0", 14;
	assert(e, l .. " requires LibStub")
	local g9, ga = e:NewLibrary(l, m)
	if not g9 then
		return
	end;
	local gb = e("CallbackHandler-1.0")
	g9.eventFrame = g9.eventFrame or CreateFrame("Frame")
	g9.mapData = g9.mapData or {}
	g9.worldMapData = g9.worldMapData or {}
	g9.transforms = g9.transforms or {}
	g9.callbacks = g9.callbacks or gb:New(g9, nil, nil, false)
	local gc = select(4, GetBuildInfo()) < 20000;
	local gd = 946;
	local ge = 947;
	local gf = math.pi * 2;
	local gg = math.atan2;
	local pairs, ipairs = pairs, ipairs;
	local UnitPosition = UnitPosition;
	local C_Map = C_Map;
	local gh = g9.mapData;
	local gi = g9.worldMapData;
	local gj = g9.transforms;
	local gk, gl;
	local gm = {
		[1152] = 1116,
		[1330] = 1116,
		[1153] = 1116,
		[1154] = 1116,
		[1158] = 1116,
		[1331] = 1116,
		[1159] = 1116,
		[1160] = 1116,
		[1191] = 1116,
		[1203] = 1116,
		[1207] = 1116,
		[1277] = 1116,
		[1402] = 1116,
		[1464] = 1116,
		[1465] = 1116,
		[1478] = 1220,
		[1495] = 1220,
		[1498] = 1220,
		[1502] = 1220,
		[1533] = 0,
		[1539] = 0,
		[1612] = 1220,
		[1626] = 1220,
		[1662] = 1220,
		[2213] = 0,
		[2241] = 1,
		[2274] = 1,
		[2275] = 870
	}
	local gn = {}
	gm = setmetatable(gm, {
		__index = gn
	})
	local function go(ex)
		return gm[ex] or ex
	end;
	g9.___DIIDO = gn;
	if not ga or ga < 7 then
		if ga then
			wipe(gh)
			wipe(gi)
			wipe(gj)
		end;
		local gp = {
			{
				530,
				0,
				4800,
				16000,
				- 10133.3,
				- 2666.67,
				- 2400,
				2400
			},
			{
				530,
				1,
				- 6933.33,
				533.33,
				- 16000,
				- 8000,
				10133.3,
				17600
			},
			{
				732,
				0,
				- 3200,
				533.3,
				- 533.3,
				2666.7,
				- 611.8,
				3904.3
			},
			{
				1064,
				870,
				5391,
				8148,
				3518,
				7655,
				- 2134.2,
				- 2286.6
			},
			{
				1208,
				1116,
				- 2666,
				- 2133,
				- 2133,
				- 1600,
				10210,
				2410
			},
			{
				1460,
				1220,
				- 1066.7,
				2133.3,
				0,
				3200,
				- 2333.9,
				966.7
			}
		}
		local function gq()
			for _, gr in pairs(gp) do
				local gs, gt, gu, gv, gw, gx, gy, gz = unpack(gr)
				if not gj[gs] then
					gj[gs] = {}
				end;
				table.insert(gj[gs], {
					newInstanceID = gt,
					minY = gu,
					maxY = gv,
					minX = gw,
					maxX = gx,
					offsetY = gy,
					offsetX = gz
				})
			end
		end;
		local function gA(gs, gB, gC, gD, gE)
			if gj[gs] then
				for _, fj in ipairs(gj[gs]) do
					if gB <= fj.maxX and gC >= fj.minX and gD <= fj.maxY and gE >= fj.minY then
						gs = fj.newInstanceID;
						gB = gB + fj.offsetX;
						gC = gC + fj.offsetX;
						gD = gD + fj.offsetY;
						gE = gE + fj.offsetY;
						break
					end
				end
			end;
			return gs, gB, gC, gD, gE
		end;
		local gF, gG = CreateVector2D(0, 0), CreateVector2D(0.5, 0.5)
		local function gH(bi, fj, gI)
			if not bi or not fj or gh[bi] then
				return
			end;
			if fj.parentMapID and fj.parentMapID ~= 0 then
				gI = fj.parentMapID
			elseif not gI then
				gI = 0
			end;
			local ex, gJ = C_Map.GetWorldPosFromMapPos(bi, gF)
			local _, gK = C_Map.GetWorldPosFromMapPos(bi, gG)
			if gJ and gK then
				local gD, gB = gJ:GetXY()
				local gE, gC = gK:GetXY()
				gE = gD + (gE - gD) * 2;
				gC = gB + (gC - gB) * 2;
				ex, gB, gC, gD, gE = gA(ex, gB, gC, gD, gE)
				gh[bi] = {
					gB - gC,
					gD - gE,
					gB,
					gD,
					instance = ex,
					name = fj.name,
					mapType = fj.mapType,
					parent = gI
				}
			else
				gh[bi] = {
					0,
					0,
					0,
					0,
					instance = ex or - 1,
					name = fj.name,
					mapType = fj.mapType,
					parent = gI
				}
			end
		end;
		local function gL(gI)
			local gM = C_Map.GetMapChildrenInfo(gI)
			if gM and # gM > 0 then
				for i = 1, # gM do
					local bi = gM[i].mapID;
					if bi and not gh[bi] then
						gH(bi, gM[i], gI)
						gL(bi)
						local gN = C_Map.GetMapGroupID(bi)
						if gN then
							local gO = C_Map.GetMapGroupMembersInfo(gN)
							if gO then
								for gP = 1, # gO do
									local gQ = gO[gP].mapID;
									if gQ and not gh[gQ] then
										gH(gQ, C_Map.GetMapInfo(gQ), gI)
										gL(gQ)
									end
								end
							end
						end
					end
				end
			end
		end;
		local function gR()
			local gS = C_Map.GetMapInfo(gd)
			if gS then
				gh[gd] = {
					0,
					0,
					0,
					0
				}
				gh[gd].instance = - 1;
				gh[gd].name = gS.name;
				gh[gd].mapType = gS.mapType
			end;
			if gc then
				gi[0] = {
					44688.53,
					29795.11,
					32601.04,
					9894.93
				}
				gi[1] = {
					44878.66,
					29916.10,
					8723.96,
					14824.53
				}
			else
				gi[0] = {
					76153.14,
					50748.62,
					65008.24,
					23827.51
				}
				gi[1] = {
					77803.77,
					51854.98,
					13157.6,
					28030.61
				}
				gi[571] = {
					71773.64,
					50054.05,
					36205.94,
					12366.81
				}
				gi[870] = {
					67710.54,
					45118.08,
					33565.89,
					38020.67
				}
				gi[1220] = {
					82758.64,
					55151.28,
					52943.46,
					24484.72
				}
				gi[1642] = {
					77933.3,
					51988.91,
					44262.36,
					32835.1
				}
				gi[1643] = {
					76060.47,
					50696.96,
					55384.8,
					25774.35
				}
			end
		end;
		local function gT()
			gq()
			if gc then
				gH(ge)
				gL(ge)
			else
				gL(gd)
			end;
			gR()
			for i = 1, 2000 do
				if not gh[i] then
					local gU = C_Map.GetMapInfo(i)
					if gU and gU.name then
						gH(i, gU, nil)
					end
				end
			end
		end;
		gT()
	end;
	local function gV(gW, y, gs)
		if gj[gs] then
			for _, gp in ipairs(gj[gs]) do
				if gp.minX <= gW and gp.maxX >= gW and gp.minY <= y and gp.maxY >= y then
					gs = gp.newInstanceID;
					gW = gW + gp.offsetX;
					y = y + gp.offsetY;
					break
				end
			end
		end;
		return gW, y, go(gs)
	end;
	local gX;
	local function gY(gZ)
		local g_ = C_Map.GetBestMapForUnit("player")
		if gZ then
			local h0, h1, ex = g9:GetPlayerWorldPosition()
			if ex and gh[g_] and gh[g_].instance ~= ex and g_ ~= - 1 and not gm[ex] and not gm[gh[g_].instance] then
				gn[ex] = gh[g_].instance
			end
		end;
		if g_ ~= gk then
			gk, gl = g_, gh[g_] and gh[g_].mapType or 0;
			g9.callbacks:Fire("PlayerZoneChanged", gk, gl)
		end;
		if gl == Enum.UIMapType.Micro then
			gX()
		end
	end;
	g9.UpdateCurrentPosition = gY;
	local function h2()
		g9.updateTimerActive = nil;
		g9.UpdateCurrentPosition()
	end;
	function gX()
		if not g9.updateTimerActive then
			g9.updateTimerActive = true;
			C_Timer.After(1, h2)
		end
	end;
	local function g7(h3, aj, ...)
		gY(true)
	end;
	g9.eventFrame:SetScript("OnEvent", g7)
	g9.eventFrame:UnregisterAllEvents()
	g9.eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	g9.eventFrame:RegisterEvent("ZONE_CHANGED")
	g9.eventFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
	g9.eventFrame:RegisterEvent("NEW_WMO_CHUNK")
	g9.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	if IsLoggedIn() then
		gY(true)
	end;
	function g9:GetLocalizedMap(g_)
		return gh[g_] and gh[g_].name or nil
	end;
	function g9:GetZoneSize(g_)
		local fj = gh[g_]
		if not fj then
			return 0, 0
		end;
		return fj[1], fj[2]
	end;
	function g9:GetAllMapIDs()
		local h4 = {}
		for bi in pairs(gh) do
			table.insert(h4, bi)
		end;
		return h4
	end;
	function g9:GetWorldCoordinatesFromZone(gW, y, h5)
		local fj = gh[h5]
		if not fj or fj[1] == 0 or fj[2] == 0 then
			return nil, nil, nil
		end;
		if not gW or not y then
			return nil, nil, nil
		end;
		local h6, h7, gB, gD = fj[1], fj[2], fj[3], fj[4]
		gW, y = gB - h6 * gW, gD - h7 * y;
		return gW, y, go(fj.instance)
	end;
	function g9:GetWorldCoordinatesFromAzerothWorldMap(gW, y, ex)
		local fj = gi[ex]
		if not fj or fj[1] == 0 or fj[2] == 0 then
			return nil, nil, nil
		end;
		if not gW or not y then
			return nil, nil, nil
		end;
		local h6, h7, gB, gD = fj[1], fj[2], fj[3], fj[4]
		gW, y = gB - h6 * gW, gD - h7 * y;
		return gW, y, ex
	end;
	function g9:GetZoneCoordinatesFromWorld(gW, y, h5, h8)
		local fj = gh[h5]
		if not fj or fj[1] == 0 or fj[2] == 0 then
			return nil, nil
		end;
		if not gW or not y then
			return nil, nil
		end;
		local h6, h7, gB, gD = fj[1], fj[2], fj[3], fj[4]
		gW, y = (gB - gW) / h6, (gD - y) / h7;
		if not h8 and (gW < 0 or gW > 1 or y < 0 or y > 1) then
			return nil, nil
		end;
		return gW, y
	end;
	function g9:GetAzerothWorldMapCoordinatesFromWorld(gW, y, ex, h8)
		local fj = gi[ex]
		if not fj or fj[1] == 0 or fj[2] == 0 then
			return nil, nil
		end;
		if not gW or not y then
			return nil, nil
		end;
		local h6, h7, gB, gD = fj[1], fj[2], fj[3], fj[4]
		gW, y = (gB - gW) / h6, (gD - y) / h7;
		if not h8 and (gW < 0 or gW > 1 or y < 0 or y > 1) then
			return nil, nil
		end;
		return gW, y
	end;
	local function h9(self, gW, y, ha, hb, h8)
		if ha ~= ge and not gh[ha] or hb ~= ge and not gh[hb] then
			return nil, nil
		end;
		local ex = go(ha == ge and gh[hb].instance or gh[ha].instance)
		if not gi[ex] then
			return nil, nil
		end;
		if ha == ge then
			gW, y = self:GetWorldCoordinatesFromAzerothWorldMap(gW, y, ex)
			return self:GetZoneCoordinatesFromWorld(gW, y, hb, h8)
		else
			gW, y = self:GetWorldCoordinatesFromZone(gW, y, ha)
			return self:GetAzerothWorldMapCoordinatesFromWorld(gW, y, ex, h8)
		end
	end;
	function g9:TranslateZoneCoordinates(gW, y, ha, hb, h8)
		if ha == hb then
			return gW, y
		end;
		if ha == ge or hb == ge then
			return h9(self, gW, y, ha, hb, h8)
		end;
		local hc, hd, ex = self:GetWorldCoordinatesFromZone(gW, y, ha)
		if not hc then
			return nil, nil
		end;
		local fj = gh[hb]
		if not fj or go(fj.instance) ~= ex then
			return nil, nil
		end;
		return self:GetZoneCoordinatesFromWorld(hc, hd, hb, h8)
	end;
	function g9:GetWorldDistance(gs, he, hf, hg, hh)
		if not he or not hf or not hg or not hh then
			return nil, nil, nil
		end;
		local hi, hj = hg - he, hh - hf;
		return (hi * hi + hj * hj) ^ 0.5, hi, hj
	end;
	function g9:GetZoneDistance(ha, he, hf, hb, hg, hh)
		local hk, hl;
		he, hf, hk = self:GetWorldCoordinatesFromZone(he, hf, ha)
		if not he then
			return nil, nil, nil
		end;
		hg, hh, hl = self:GetWorldCoordinatesFromZone(hg, hh, hb)
		if not hg then
			return nil, nil, nil
		end;
		if hk ~= hl then
			return nil, nil, nil
		end;
		return self:GetWorldDistance(hk, he, hf, hg, hh)
	end;
	function g9:GetWorldVector(gs, he, hf, hg, hh)
		local hm, hi, hj = self:GetWorldDistance(gs, he, hf, hg, hh)
		if not hm then
			return nil, nil
		end;
		local hn = gg(- hi, hj)
		if hn > 0 then
			hn = gf - hn
		else
			hn = - hn
		end;
		return hn, hm
	end;
	function g9:GetUnitWorldPosition(ho)
		local y, gW, hp, gs = UnitPosition(ho)
		if not gW or not y then
			return nil, nil, go(gs)
		end;
		return gV(gW, y, gs)
	end;
	function g9:GetPlayerWorldPosition()
		local y, gW, hp, gs = UnitPosition("player")
		if not gW or not y then
			return nil, nil, go(gs)
		end;
		return gV(gW, y, gs)
	end;
	function g9:GetPlayerZone()
		return gk, gl
	end;
	function g9:GetPlayerZonePosition(h8)
		if not gk then
			return nil, nil, nil, nil
		end;
		local gW, y, hq = self:GetPlayerWorldPosition()
		if not gW or not y then
			return nil, nil, nil, nil
		end;
		gW, y = self:GetZoneCoordinatesFromWorld(gW, y, gk, h8)
		if gW and y then
			return gW, y, gk, gl
		end;
		return nil, nil, nil, nil
	end
end;
g8()
local function hr()
	local hs = "LibRangeCheck-3.0"
	local ht = 99;
	local hu, h = e:NewLibrary(hs, ht)
	if not hu then
		return
	end;
	local hv = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE;
	local aA = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC;
	local hw = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC;
	local dZ;
	if hv or hw then
		dZ = function(b8)
			return InCombatLockdown() and not UnitCanAttack("player", b8)
		end
	else
		dZ = function()
			return false
		end
	end;
	local _G = _G;
	local next = next;
	local sort = sort;
	local type = type;
	local wipe = wipe;
	local print = print;
	local pairs = pairs;
	local ipairs = ipairs;
	local tinsert = tinsert;
	local tremove = tremove;
	local tostring = tostring;
	local setmetatable = setmetatable;
	local BOOKTYPE_SPELL = BOOKTYPE_SPELL;
	local GetSpellInfo = GetSpellInfo;
	local GetSpellBookItemName = GetSpellBookItemName;
	local GetNumSpellTabs = GetNumSpellTabs;
	local GetSpellTabInfo = GetSpellTabInfo;
	local GetItemInfo = GetItemInfo;
	local UnitCanAttack = UnitCanAttack;
	local UnitCanAssist = UnitCanAssist;
	local UnitExists = UnitExists;
	local UnitIsUnit = UnitIsUnit;
	local UnitGUID = UnitGUID;
	local UnitIsDeadOrGhost = UnitIsDeadOrGhost;
	local CheckInteractDistance = CheckInteractDistance;
	local IsSpellInRange = IsSpellInRange;
	local IsItemInRange = IsItemInRange;
	local UnitClass = UnitClass;
	local UnitRace = UnitRace;
	local GetInventoryItemLink = GetInventoryItemLink;
	local GetTime = GetTime;
	local hx = GetInventorySlotInfo("HANDSSLOT")
	local hy = math.floor;
	local UnitIsVisible = UnitIsVisible;
	local hz = 0.5;
	local hA = 10.0;
	local hB = {
		[3] = 8,
		[4] = 28
	}
	local hC = {
		Tauren = {
			[3] = 6,
			[4] = 25
		},
		Scourge = {
			[3] = 7,
			[4] = 27
		}
	}
	local hD = 2;
	local hE, hF, hG, hH = {}, {}, {}, {}
	for _, al in ipairs({
		"EVOKER",
		"DEATHKNIGHT",
		"DEMONHUNTER",
		"DRUID",
		"HUNTER",
		"SHAMAN",
		"MAGE",
		"PALADIN",
		"PRIEST",
		"WARLOCK",
		"WARRIOR",
		"MONK",
		"ROGUE"
	}) do
		hE[al], hF[al], hG[al], hH[al] = {}, {}, {}, {}
	end;
	tinsert(hF.EVOKER, 369819)
	tinsert(hE.EVOKER, 361469)
	tinsert(hE.EVOKER, 360823)
	tinsert(hG.EVOKER, 361227)
	tinsert(hF.DEATHKNIGHT, 49576)
	tinsert(hF.DEATHKNIGHT, 47541)
	tinsert(hG.DEATHKNIGHT, 61999)
	tinsert(hF.DEMONHUNTER, 185123)
	tinsert(hF.DEMONHUNTER, 183752)
	tinsert(hF.DEMONHUNTER, 204021)
	tinsert(hE.DRUID, 8936)
	tinsert(hE.DRUID, 774)
	tinsert(hE.DRUID, 2782)
	tinsert(hE.DRUID, 88423)
	if not hv then
		tinsert(hE.DRUID, 5185)
	end;
	tinsert(hF.DRUID, 5176)
	tinsert(hF.DRUID, 339)
	tinsert(hF.DRUID, 6795)
	tinsert(hF.DRUID, 33786)
	tinsert(hF.DRUID, 22568)
	tinsert(hF.DRUID, 8921)
	tinsert(hG.DRUID, 50769)
	tinsert(hG.DRUID, 20484)
	tinsert(hF.HUNTER, 75)
	if not hv then
		tinsert(hF.HUNTER, 2764)
	end;
	tinsert(hH.HUNTER, 136)
	tinsert(hE.MAGE, 1459)
	tinsert(hE.MAGE, 475)
	if not hv then
		tinsert(hE.MAGE, 130)
	end;
	tinsert(hF.MAGE, 44614)
	tinsert(hF.MAGE, 5019)
	tinsert(hF.MAGE, 118)
	tinsert(hF.MAGE, 116)
	tinsert(hF.MAGE, 133)
	tinsert(hF.MAGE, 44425)
	tinsert(hE.MONK, 115450)
	tinsert(hE.MONK, 115546)
	tinsert(hE.MONK, 116670)
	tinsert(hF.MONK, 115546)
	tinsert(hF.MONK, 115078)
	tinsert(hF.MONK, 100780)
	tinsert(hF.MONK, 117952)
	tinsert(hG.MONK, 115178)
	tinsert(hE.PALADIN, 19750)
	tinsert(hE.PALADIN, 85673)
	tinsert(hE.PALADIN, 4987)
	tinsert(hE.PALADIN, 213644)
	if not hv then
		tinsert(hE.PALADIN, 635)
	end;
	tinsert(hF.PALADIN, 853)
	tinsert(hF.PALADIN, 35395)
	tinsert(hF.PALADIN, 62124)
	tinsert(hF.PALADIN, 183218)
	tinsert(hF.PALADIN, 20271)
	tinsert(hF.PALADIN, 20473)
	tinsert(hG.PALADIN, 7328)
	if hv then
		tinsert(hE.PRIEST, 21562)
		tinsert(hE.PRIEST, 17)
	else
		tinsert(hE.PRIEST, 2050)
	end;
	tinsert(hE.PRIEST, 527)
	tinsert(hE.PRIEST, 2061)
	tinsert(hF.PRIEST, 589)
	tinsert(hF.PRIEST, 585)
	tinsert(hF.PRIEST, 5019)
	if not hv then
		tinsert(hF.PRIEST, 8092)
	end;
	tinsert(hG.PRIEST, 2006)
	if hv then
		tinsert(hE.ROGUE, 36554)
		tinsert(hE.ROGUE, 921)
	else
		tinsert(hF.ROGUE, 2764)
	end;
	tinsert(hF.ROGUE, 185565)
	tinsert(hF.ROGUE, 36554)
	tinsert(hF.ROGUE, 185763)
	tinsert(hF.ROGUE, 2094)
	tinsert(hF.ROGUE, 921)
	tinsert(hE.SHAMAN, 546)
	tinsert(hE.SHAMAN, 8004)
	tinsert(hE.SHAMAN, 188070)
	if not hv then
		tinsert(hE.SHAMAN, 331)
		tinsert(hE.SHAMAN, 526)
		tinsert(hE.SHAMAN, 2870)
	end;
	tinsert(hF.SHAMAN, 370)
	tinsert(hF.SHAMAN, 188196)
	tinsert(hF.SHAMAN, 73899)
	if not hv then
		tinsert(hF.SHAMAN, 403)
		tinsert(hF.SHAMAN, 8042)
	end;
	tinsert(hG.SHAMAN, 2008)
	tinsert(hF.WARRIOR, 355)
	tinsert(hF.WARRIOR, 5246)
	tinsert(hF.WARRIOR, 100)
	if not hv then
		tinsert(hF.WARRIOR, 2764)
	end;
	tinsert(hE.WARLOCK, 132)
	tinsert(hE.WARLOCK, 5697)
	tinsert(hE.WARLOCK, 20707)
	if hv then
		tinsert(hF.WARLOCK, 234153)
		tinsert(hF.WARLOCK, 198590)
		tinsert(hF.WARLOCK, 232670)
	else
		tinsert(hF.WARLOCK, 172)
		tinsert(hF.WARLOCK, 348)
		tinsert(hF.WARLOCK, 17877)
		tinsert(hF.WARLOCK, 18223)
		tinsert(hF.WARLOCK, 689)
		tinsert(hF.WARLOCK, 403677)
	end;
	tinsert(hF.WARLOCK, 5019)
	tinsert(hF.WARLOCK, 686)
	tinsert(hF.WARLOCK, 5782)
	tinsert(hG.WARLOCK, 20707)
	tinsert(hH.WARLOCK, 755)
	local hI = {
		[2] = {
			37727
		},
		[3] = {
			42732
		},
		[5] = {
			8149,
			136605,
			63427
		},
		[8] = {
			34368,
			33278
		},
		[10] = {
			32321,
			17626
		},
		[15] = {
			1251,
			2581,
			3530,
			3531,
			6450,
			6451,
			8544,
			8545,
			14529,
			14530,
			21990,
			21991,
			34721,
			34722
		},
		[20] = {
			21519
		},
		[25] = {
			31463,
			13289
		},
		[30] = {
			1180,
			1478,
			3012,
			1712,
			2290,
			1711,
			34191
		},
		[35] = {
			18904
		},
		[40] = {
			34471
		},
		[45] = {
			32698
		},
		[60] = {
			32825,
			37887
		},
		[70] = {
			41265
		},
		[80] = {
			35278
		},
		[100] = {
			41058
		},
		[150] = {
			46954
		}
	}
	if hv then
		hI[1] = {
			90175
		}
		hI[4] = {
			129055
		}
		hI[7] = {
			61323
		}
		hI[38] = {
			140786
		}
		hI[55] = {
			74637
		}
		hI[50] = {
			116139
		}
		hI[90] = {
			133925
		}
		hI[200] = {
			75208
		}
	end;
	local hJ = {
		[1] = {},
		[2] = {
			3912,
			37727
		},
		[3] = {
			42732
		},
		[5] = {
			8149,
			136605,
			63427
		},
		[8] = {
			34368,
			33278
		},
		[10] = {
			32321,
			17626
		},
		[15] = {
			33069
		},
		[20] = {
			10645
		},
		[25] = {
			24268,
			41509,
			31463,
			13289
		},
		[30] = {
			835,
			7734,
			34191
		},
		[35] = {
			24269,
			18904
		},
		[40] = {
			28767
		},
		[45] = {
			23836
		},
		[60] = {
			32825,
			37887
		},
		[70] = {
			41265
		},
		[80] = {
			35278
		},
		[100] = {
			33119
		},
		[150] = {
			46954
		}
	}
	if hv then
		hJ[4] = {
			129055
		}
		hJ[7] = {
			61323
		}
		hJ[38] = {
			140786
		}
		hJ[50] = {
			116139
		}
		hJ[55] = {
			74637
		}
		hJ[90] = {
			133925
		}
		hJ[200] = {
			75208
		}
	end;
	for _, hK in pairs(hE) do
		tinsert(hK, 28880)
	end;
	local hL = {}
	local hM = {}
	local hN;
	local hO;
	local hP;
	local hQ;
	local hR = 0;
	local hS = setmetatable({}, {
		__index = function(h4, hT)
			local I = function(b8)
				if IsSpellInRange(hT, BOOKTYPE_SPELL, b8) == 1 then
					return true
				end
			end;
			h4[hT] = I;
			return I
		end
	})
	local hU = {}
	local hV = setmetatable({}, {
		__index = function(h4, hW)
			local I = function(b8, hX)
				if not hX and dZ(b8) then
					return nil
				else
					return IsItemInRange(hW, b8) or nil
				end
			end;
			h4[hW] = I;
			return I
		end
	})
	local hY = setmetatable({}, {
		__index = function(h4, v)
			local I = function(b8, hX)
				if not hX and dZ(b8) then
					return nil
				else
					return CheckInteractDistance(b8, v) and true or false
				end
			end;
			h4[v] = I;
			return I
		end
	})
	local function hZ(h_, i0)
		if type(i0) ~= "table" then
			i0 = {}
		end;
		if type(h_) == "table" then
			for gP, hK in pairs(h_) do
				if type(hK) == "table" then
					hK = hZ(hK, i0[gP])
				end;
				i0[gP] = hK
			end
		end;
		return i0
	end;
	local function i1(i2)
		hP = hZ(hI)
		hQ = hZ(hJ)
		hO = i2;
		hN = nil
	end;
	local function i3()
		local _, _, i4, i5 = GetSpellTabInfo(GetNumSpellTabs())
		return i4 + i5
	end;
	local function i6(cx)
		if not cx or cx == "" then
			return nil
		end;
		for i = 1, i3() do
			local eS = GetSpellBookItemName(i, BOOKTYPE_SPELL)
			if eS == cx then
				return i
			end
		end;
		return nil
	end;
	local function i7(i8)
		if i8 then
			return hy(i8 + 0.5)
		end
	end;
	local function i9(ia)
		local cd, _, _, _, ib, i8 = GetSpellInfo(ia)
		return cd, i7(ib), i7(i8), i6(cd)
	end;
	local function ic(id, ie, ig, ih)
		for i = 1, # ig do
			local ia = ig[i]
			local cd, ib, i8, hT = i9(ia)
			if i8 and hT and id <= i8 and i8 <= ie and ib == 0 then
				return hS[i6(cd)]
			end
		end;
		for v, i8 in pairs(ih) do
			if id <= i8 and i8 <= ie then
				return hY[v]
			end
		end
	end;
	local function ii(hT, ib, i8, ig, ih)
		local ij = hU[hT]
		if ij then
			return ij
		end;
		local ik = ic(ib, i8, ig, ih)
		if ik then
			ij = function(b8)
				if IsSpellInRange(hT, BOOKTYPE_SPELL, b8) == 1 then
					return true
				elseif ik(b8) then
					return true, true
				end
			end;
			hU[hT] = ij;
			return ij
		end
	end;
	local function il(h4, i8, ib, ij, im)
		local io = {
			["range"] = i8,
			["minRange"] = ib,
			["checker"] = ij,
			["info"] = im
		}
		for i = 1, # h4 do
			local hK = h4[i]
			if io.range == hK.range then
				return
			end;
			if io.range > hK.range then
				tinsert(h4, i, io)
				return
			end
		end;
		tinsert(h4, io)
	end;
	local function ip(ig, iq, ir)
		local is, it = {}, {}
		if iq then
			for i8, eK in pairs(iq) do
				for i = 1, # eK do
					local hW = eK[i]
					if Item:CreateFromItemID(hW):IsItemDataCached() and GetItemInfo(hW) then
						il(is, i8, nil, hV[hW], "item:" .. hW)
						break
					end
				end
			end
		end;
		if ir and not next(is) then
			for v, i8 in pairs(ir) do
				il(is, i8, nil, hY[v], "interact:" .. v)
			end
		end;
		if ig then
			for i = 1, # ig do
				local ia = ig[i]
				local cd, ib, i8, hT = i9(ia)
				if hT and i8 then
					if ib == 0 then
						ib = nil
					end;
					if i8 == 0 then
						i8 = hD
					end;
					if ib then
						local ij = ii(hT, ib, i8, ig, ir)
						if ij then
							il(is, i8, ib, ij, "spell:" .. ia .. ":" .. tostring(cd))
							il(it, i8, ib, ij, "spell:" .. ia .. ":" .. tostring(cd))
						end
					else
						il(is, i8, ib, hS[hT], "spell:" .. ia .. ":" .. tostring(cd))
						il(it, i8, ib, hS[hT], "spell:" .. ia .. ":" .. tostring(cd))
					end
				end
			end
		end;
		return is, it
	end;
	local iu = {}
	local function iv()
		wipe(iu)
	end;
	local function iw(ix)
		local bB = GetTime()
		for gP, hK in pairs(iu) do
			if hK.updateTime + ix < bB then
				iu[gP] = nil
			end
		end
	end;
	local function iy(b8, iz)
		local iA, iB = 1, # iz;
		while iA <= iB do
			local iC = hy((iA + iB) / 2)
			local io = iz[iC]
			if io.checker(b8, true) then
				iA = iC + 1
			else
				iB = iC - 1
			end
		end;
		if # iz == 0 then
			return nil, nil
		elseif iA > # iz then
			return 0, iz[# iz].range
		elseif iA <= 1 then
			return iz[1].range, nil
		else
			return iz[iA].range, iz[iA - 1].range
		end
	end;
	local function iD(b8, iE)
		local iF = UnitCanAssist("player", b8)
		if UnitIsDeadOrGhost(b8) then
			if iF then
				return iy(b8, dZ(b8) and hu.resRCInCombat or hu.resRC)
			else
				return iy(b8, dZ(b8) and hu.miscRCInCombat or hu.miscRC)
			end
		end;
		if UnitCanAttack("player", b8) then
			return iy(b8, iE and hu.harmNoItemsRC or hu.harmRC)
		elseif UnitIsUnit("pet", b8) then
			if dZ(b8) then
				local ib, iG = iy(b8, iE and hu.friendNoItemsRCInCombat or hu.friendRCInCombat)
				if ib or iG then
					return ib, iG
				else
					return iy(b8, hu.petRCInCombat)
				end
			else
				local ib, iG = iy(b8, iE and hu.friendNoItemsRC or hu.friendRC)
				if ib or iG then
					return ib, iG
				else
					return iy(b8, hu.petRC)
				end
			end
		elseif iF then
			if dZ(b8) then
				return iy(b8, iE and hu.friendNoItemsRCInCombat or hu.friendRCInCombat)
			else
				return iy(b8, iE and hu.friendNoItemsRC or hu.friendRC)
			end
		else
			return iy(b8, dZ(b8) and hu.miscRCInCombat or hu.miscRC)
		end
	end;
	local function iH(b8, iE, iI)
		iI = iI or 0.1;
		iI = iI > 1 and 1 or iI;
		local b6 = UnitGUID(b8)
		local iJ = b6 .. (iE and "-1" or "-0")
		local iK = iu[iJ]
		local bB = GetTime()
		if iK and iK.updateTime + iI > bB then
			return iK.minRange, iK.maxRange
		end;
		local iL = iK or {}
		iL.minRange, iL.maxRange = iD(b8, iE)
		iL.updateTime = bB;
		iu[iJ] = iL;
		return iL.minRange, iL.maxRange
	end;
	local function iM(iN, iO)
		if # iN ~= # iO then
			wipe(iN)
			hZ(iO, iN)
			return true
		end;
		for i = 1, # iN do
			if iN[i].range ~= iO[i].range or iN[i].checker ~= iO[i].checker then
				wipe(iN)
				hZ(iO, iN)
				return true
			end
		end
	end;
	local function iP(iN, iQ, iO, iR)
		local bp = iM(iN, iO)
		bp = iM(iQ, iR) or bp;
		return bp
	end;
	local function iS(iz)
		local iT = # iz;
		return function()
			local io = iz[iT]
			if not io then
				return nil
			end;
			iT = iT - 1;
			return io.range, io.checker
		end
	end;
	local function iU(iz, i8)
		local ij, iV;
		for i = 1, # iz do
			local io = iz[i]
			if io.range < i8 then
				return ij, iV
			end;
			ij, iV = io.checker, io.range
		end;
		return ij, iV
	end;
	local function iW(iz, i8)
		for i = 1, # iz do
			local io = iz[i]
			if io.range <= i8 then
				return io.checker, io.range
			end
		end
	end;
	local function iX(iz, i8)
		for i = 1, # iz do
			local io = iz[i]
			if io.range == i8 then
				return io.checker
			end
		end
	end;
	local function iY()
	end;
	local function iZ(i_, j0, j1)
		j1 = j1 or iY;
		i_ = i_ or j1;
		j0 = j0 or j1;
		return function(b8)
			if not UnitExists(b8) then
				return nil
			end;
			if UnitIsDeadOrGhost(b8) then
				return j1(b8)
			end;
			if UnitCanAttack("player", b8) then
				return j0(b8)
			elseif UnitCanAssist("player", b8) then
				return i_(b8)
			else
				return j1(b8)
			end
		end
	end;
	local j2 = function(hW)
		if GetItemInfo(hW) then
			return function(b8)
				return IsItemInRange(hW, b8)
			end
		end
	end;
	hu.checkerCache_Spell = hu.checkerCache_Spell or {}
	hu.checkerCache_Item = hu.checkerCache_Item or {}
	hu.miscRC = ip(nil, nil, hB)
	hu.miscRCInCombat = {}
	hu.friendRC = ip(nil, nil, hB)
	hu.friendRCInCombat = {}
	hu.harmRC = ip(nil, nil, hB)
	hu.harmRCInCombat = {}
	hu.resRC = ip(nil, nil, hB)
	hu.resRCInCombat = {}
	hu.petRC = ip(nil, nil, hB)
	hu.petRCInCombat = {}
	hu.friendNoItemsRC = ip(nil, nil, hB)
	hu.friendNoItemsRCInCombat = {}
	hu.harmNoItemsRC = ip(nil, nil, hB)
	hu.harmNoItemsRCInCombat = {}
	hu.failedItemRequests = {}
	hu.CHECKERS_CHANGED = "CHECKERS_CHANGED"
	hu.MeleeRange = hD;
	function hu:findSpellIndex(eS)
		if type(eS) == "number" then
			eS = GetSpellInfo(eS)
		end;
		return i6(eS)
	end;
	function hu:getRangeAsString(b8, j3, j4)
		local ib, iG = self:getRange(b8, j3)
		if not ib then
			return nil
		end;
		if not iG then
			return j4 and ib .. " +" or nil
		end;
		return ib .. " - " .. iG
	end;
	function hu:init(j5)
		if self.initialized and not j5 then
			return
		end;
		self.initialized = true;
		local _, b5 = UnitClass("player")
		local _, j6 = UnitRace("player")
		local ir = hC[j6] or hB;
		self.handSlotItem = GetInventoryItemLink("player", hx)
		local bp = false;
		if iP(self.friendRC, self.friendRCInCombat, ip(hE[b5], hI, ir)) then
			bp = true
		end;
		if iP(self.harmRC, self.harmRCInCombat, ip(hF[b5], hJ, ir)) then
			bp = true
		end;
		if iP(self.friendNoItemsRC, self.friendNoItemsRCInCombat, ip(hE[b5], nil, ir)) then
			bp = true
		end;
		if iP(self.harmNoItemsRC, self.harmNoItemsRCInCombat, ip(hF[b5], nil, ir)) then
			bp = true
		end;
		if iP(self.miscRC, self.miscRCInCombat, ip(nil, nil, ir)) then
			bp = true
		end;
		if iP(self.resRC, self.resRCInCombat, ip(hG[b5], nil, ir)) then
			bp = true
		end;
		if iP(self.petRC, self.petRCInCombat, ip(hH[b5], nil, ir)) then
			bp = true
		end;
		if bp and self.callbacks then
			self.callbacks:Fire(self.CHECKERS_CHANGED)
		end
	end;
	function hu:GetFriendCheckers(j7)
		return iS(j7 and self.friendRCInCombat or self.friendRC)
	end;
	function hu:GetFriendCheckersNoItems(j7)
		return iS(j7 and self.friendNoItemsRCInCombat or self.friendNoItemsRC)
	end;
	function hu:GetHarmCheckers(j7)
		return iS(j7 and self.harmRCInCombat or self.harmRC)
	end;
	function hu:GetHarmCheckersNoItems(j7)
		return iS(j7 and self.harmNoItemsRCInCombat or self.harmNoItemsRC)
	end;
	function hu:GetMiscCheckers(j7)
		return iS(j7 and self.miscRCInCombat or self.miscRC)
	end;
	function hu:GetFriendMinChecker(i8, j7)
		return iU(j7 and self.friendRCInCombat or self.friendRC, i8)
	end;
	function hu:GetHarmMinChecker(i8, j7)
		return iU(j7 and self.harmRCInCombat or self.harmRC, i8)
	end;
	function hu:GetMiscMinChecker(i8, j7)
		return iU(j7 and self.miscRCInCombat or self.miscRC, i8)
	end;
	function hu:GetFriendMaxChecker(i8, j7)
		return iW(j7 and self.friendRCInCombat or self.friendRC, i8)
	end;
	function hu:GetHarmMaxChecker(i8, j7)
		return iW(j7 and self.harmRCInCombat or self.harmRC, i8)
	end;
	function hu:GetMiscMaxChecker(i8, j7)
		return iW(j7 and self.miscRCInCombat and self.miscRC, i8)
	end;
	function hu:GetFriendChecker(i8, j7)
		return iX(j7 and self.friendRCInCombat or self.friendRC, i8)
	end;
	function hu:GetHarmChecker(i8, j7)
		return iX(j7 and self.harmRCInCombat or self.harmRC, i8)
	end;
	function hu:GetMiscChecker(i8, j7)
		return iX(j7 and self.miscRCInCombat or self.miscRC, i8)
	end;
	function hu:GetSmartMinChecker(i8, j7)
		if j7 then
			return iZ(iU(self.friendRCInCombat, i8), iU(self.harmRCInCombat, i8), iU(self.miscRCInCombat, i8))
		else
			return iZ(iU(self.friendRC, i8), iU(self.harmRC, i8), iU(self.miscRC, i8))
		end
	end;
	function hu:GetSmartMaxChecker(i8, j7)
		if j7 then
			return iZ(iW(self.friendRCInCombat, i8), iW(self.harmRCInCombat, i8), iW(self.miscRCInCombat, i8))
		else
			return iZ(iW(self.friendRC, i8), iW(self.harmRC, i8), iW(self.miscRC, i8))
		end
	end;
	function hu:GetSmartChecker(i8, j8, j7)
		if j7 then
			return iZ(iX(self.friendRCInCombat, i8) or j8, iX(self.harmRCInCombat, i8) or j8, iX(self.miscRCInCombat, i8) or j8)
		else
			return iZ(iX(self.friendRC, i8) or j8, iX(self.harmRC, i8) or j8, iX(self.miscRC, i8) or j8)
		end
	end;
	function hu:GetRange(b8, j3, iE, iI)
		if not UnitExists(b8) then
			return nil
		end;
		if j3 and not UnitIsVisible(b8) then
			return nil
		end;
		return iH(b8, iE, iI)
	end;
	hu.getRange = hu.GetRange;
	function hu:OnEvent(aj, ...)
		if type(self[aj]) == "function" then
			self[aj](self, aj, ...)
		end
	end;
	function hu:LEARNED_SPELL_IN_TAB()
		self:scheduleInit()
	end;
	function hu:CHARACTER_POINTS_CHANGED()
		self:scheduleInit()
	end;
	function hu:PLAYER_TALENT_UPDATE()
		self:scheduleInit()
	end;
	function hu:SPELLS_CHANGED()
		self:scheduleInit()
	end;
	function hu:CVAR_UPDATE(_, j9)
		if j9 == "ShowAllSpellRanks" then
			self:scheduleInit()
		end
	end;
	function hu:UNIT_INVENTORY_CHANGED(aj, b8)
		if self.initialized and b8 == "player" and self.handSlotItem ~= GetInventoryItemLink("player", hx) then
			self:scheduleInit()
		end
	end;
	function hu:UNIT_AURA(aj, b8)
		if self.initialized and b8 == "player" then
			self:scheduleAuraCheck()
		end
	end;
	function hu:GET_ITEM_INFO_RECEIVED(aj, hW, ja)
		if hL[hW] then
			hL[hW] = nil;
			hM[hW] = nil;
			if not ja then
				self.failedItemRequests[hW] = true
			end;
			hR = hz
		end
	end;
	function hu:processItemRequests(jb)
		while true do
			local i8, eK = next(jb)
			if not i8 then
				return
			end;
			while true do
				local i, hW = next(eK)
				if not i then
					jb[i8] = nil;
					break
				elseif Item:CreateFromItemID(hW):IsItemEmpty() or self.failedItemRequests[hW] then
					tremove(eK, i)
				elseif hL[hW] and GetTime() < hM[hW] then
					return true
				elseif GetItemInfo(hW) then
					hN = true;
					hM[hW] = nil;
					hL[hW] = nil;
					if not hO then
						jb[i8] = nil;
						break
					end;
					tremove(eK, i)
				elseif not hM[hW] then
					hM[hW] = GetTime() + hA;
					hL[hW] = true;
					if not self.frame:IsEventRegistered("GET_ITEM_INFO_RECEIVED") then
						self.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
					end;
					return true
				elseif GetTime() >= hM[hW] then
					if hO then
						print(hs .. ": timeout for item: " .. tostring(hW))
					end;
					self.failedItemRequests[hW] = true;
					hM[hW] = nil;
					hL[hW] = nil;
					tremove(eK, i)
				else
					return true
				end
			end
		end
	end;
	function hu:initialOnUpdate()
		self:init()
		if hP then
			if self:processItemRequests(hP) then
				return
			end;
			hP = nil
		end;
		if hQ then
			if self:processItemRequests(hQ) then
				return
			end;
			hQ = nil
		end;
		if hN then
			self:init(true)
			hN = nil
		end;
		if hO then
			print(hs .. ": finished cache")
			hO = nil
		end;
		self.frame:Hide()
		self.frame:UnregisterEvent("GET_ITEM_INFO_RECEIVED")
	end;
	function hu:scheduleInit()
		self.initialized = nil;
		hR = 0;
		self.frame:Show()
	end;
	function hu:scheduleAuraCheck()
		hR = hz;
		self.frame:Show()
	end;
	function hu:activate()
		if not self.frame then
			local h3 = CreateFrame("Frame")
			self.frame = h3;
			h3:RegisterEvent("LEARNED_SPELL_IN_TAB")
			h3:RegisterEvent("CHARACTER_POINTS_CHANGED")
			h3:RegisterEvent("SPELLS_CHANGED")
			if hw or aA then
				h3:RegisterEvent("CVAR_UPDATE")
			end;
			if hv or aA then
				h3:RegisterEvent("PLAYER_TALENT_UPDATE")
			end;
			local _, b5 = UnitClass("player")
			if b5 == "MAGE" or b5 == "SHAMAN" then
				h3:RegisterUnitEvent("UNIT_INVENTORY_CHANGED", "player")
			end
		end;
		if not self.cacheResetTimer then
			self.cacheResetTimer = C_Timer.NewTicker(5, function()
				iw(5)
			end)
		end;
		i1()
		self.frame:SetScript("OnEvent", function(_, ...)
			self:OnEvent(...)
		end)
		self.frame:SetScript("OnUpdate", function(_, fh)
			hR = hR + fh;
			if hR < hz then
				return
			end;
			hR = 0;
			self:initialOnUpdate()
		end)
		self:scheduleInit()
	end;
	do
		hu.RegisterCallback = hu.RegisterCallback or function(...)
			local gb = e("CallbackHandler-1.0")
			hu.RegisterCallback = nil;
			hu.callbacks = gb:New(hu)
			return hu.RegisterCallback(...)
		end
	end;
	hu:activate()
end;
hr()
local function jc()
	if not AUTOHELP_L then
		AUTOHELP_L = {}
	end;
	local jd = AUTOHELP_L;
	local je = GetLocale()
	if je == 'zhCN' then
		jd.Nefarian = {
			YellP1 = "比赛开始！",
			YellP2 = "干得好，我的手下。凡人的勇气开始消退了！现在，现在让我们看看他们如何应对黑石塔的真正主人的力量！！！",
			YellP3 = "不可能！出现吧，我的仆人！再次为你们的主人效力！",
			YellShaman = "萨满祭司，让我看看你们的图腾到底是干什么用的！",
			YellPaladin = "圣骑士……听说你们有无数条命。让我看看到底是怎么样的吧。",
			YellDruid = "德鲁伊和你们愚蠢的变形法术。让我们看看有什么事情会发生吧！",
			YellPriest = "牧师们！如果你们要继续这么治疗的话，那我们就来玩点有趣的东西吧！",
			YellWarrior = "战士们，我知道你们应该更凶猛一些！让我们来见识一下吧！",
			YellRogue = "潜行者？不要躲躲藏藏了，勇敢地面对我吧！",
			YellWarlock = "术士们，不要随便去尝试那些你们根本不理解的法术。看到后果了吧？",
			YellHunter = "猎人们，还有你们那些讨厌的玩具枪！",
			YellMage = "你们也是法师？小心别玩火自焚……"
		}
	elseif je == 'enUs' then
		jd.Nefarian = {
			YellP1 = "Let the games begin!",
			YellP2 = "Well done, my minions. The mortals' courage begins to wane! Now, let's see how they contend with the true Lord of Blackrock Spire!!!",
			YellP3 = "Impossible! Rise my minions!  Serve your master once more!",
			YellShaman = "Shamans, show me",
			YellPaladin = "Paladins... I've heard you have many lives. Show me.",
			YellDruid = "Druids and your silly shapeshifting. Lets see it in action!",
			YellPriest = "Priests! If you're going to keep healing like that, we might as well make it a little more interesting!",
			YellWarrior = "Warriors, I know you can hit harder than that! Lets see it!",
			YellRogue = "Rogues? Stop hiding and face me!",
			YellWarlock = "Warlocks, you shouldn't be playing with magic you don't understand. See what happens?",
			YellHunter = "Hunters and your annoying pea-shooters!",
			YellMage = "Mages too? You should be more careful when you play with magic...",
			YellDK = "Death Knights... get over here!",
			YellMonk = "Monk"
		}
	elseif je == 'zhTW' then
		jd.Nefarian = {
			YellP1 = "讓賽事開始吧！",
			YellP2 = "幹得好，手下們。凡人的勇氣開始消退了！現在，我們就來看看他們怎麼面對黑石之王的力量吧！",
			YellP3 = "不可能！來吧，我的僕人！再次為你們的主人服務！",
			YellShaman = "薩滿，讓我看看你圖騰到底是什麼用處的！",
			YellPaladin = "聖騎士……聽說你有無數條命。讓我看看到底是怎麼樣的吧。",
			YellDruid = "德魯伊和你們愚蠢的變形。讓我們看看什麼會發生吧！",
			YellPriest = "牧師！如果你要繼續這麼治療的話，那我們來玩點有趣的東西！",
			YellWarrior = "戰士，我知道你應該比較抗打！讓我們來見識一下吧！",
			YellRogue = "盜賊？不要躲了，面對我吧！",
			YellWarlock = "術士，不要隨便去玩那些你不理解的法術。看看會發生什麼吧？",
			YellHunter = "獵人和你那討厭的豌豆射擊！",
			YellMage = "還有法師？你應該小心使用你的魔法……"
		}
	end;
	if not AutoHelp then
		AutoHelp = {}
	end;
	AutoHelp.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC;
	AutoHelp.isTBC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC;
	AutoHelp.isWotlk = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC;
	AutoHelp.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
end;
jc()
local function jf()
	local b5 = select(2, UnitClass("player"))
	function PlayerIsClass(jg)
		return b5 == jg
	end;
	if C_Container then
		ContainerIDToInventoryID = ContainerIDToInventoryID or C_Container.ContainerIDToInventoryID;
		PickupContainerItem = PickupContainerItem or C_Container.PickupContainerItem;
		UseContainerItem = UseContainerItem or C_Container.UseContainerItem;
		GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots;
		GetContainerItemLink = GetContainerItemLink or C_Container.GetContainerItemLink;
		GetContainerItemCooldown = GetContainerItemCooldown or C_Container.GetContainerItemCooldown;
		GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots;
		GetItemCooldown = GetItemCooldown or C_Container.GetItemCooldown;
		GetBagSlotFlag = GetBagSlotFlag or C_Container.GetBagSlotFlag;
		GetBagName = GetBagName or C_Container.GetBagName;
		GetContainerItemInfo = GetContainerItemInfo or function(jh, ji)
			local jj = C_Container.GetContainerItemInfo(jh, ji)
			if jj then
				return jj.iconFileID, jj.stackCount, jj.isLocked, jj.quality, jj.isReadable, jj.hasLoot, jj.hyperlink, jj.isFiltered, jj.hasNoValue, jj.itemID, jj.isBound
			end
		end
	end;
	EasyMenu = EasyMenu or function(jk, jl, jm, gW, y, jn, jo)
		if jn == "MENU" then
			jl.displayMode = jn
		end;
		UIDropDownMenu_Initialize(jl, EasyMenu_Initialize, jn, nil, jk)
		ToggleDropDownMenu(1, nil, jl, jm, gW, y, jk, nil, jo)
	end;
	function EasyMenu_Initialize(h3, cf, jk)
		for v = 1, # jk do
			local jp = jk[v]
			if jp.text then
				jp.index = v;
				UIDropDownMenu_AddButton(jp, cf)
			end
		end
	end;
	if not AutoHelp then
		AutoHelp = {}
	end;
	if not AutoHelp.Config then
		AutoHelp.Config = {}
	end;
	local jq = AutoHelp.config;
	if not ahenv then
		ahenv = {}
	end;
	local function jr(js, jt)
		return strsplit(jt or ",", js)
	end;
	local ju = 255;
	function Contains(h_, jv)
		if not h_ or not jv then
			return false
		end;
		if string.match(h_, jv) ~= nil then
			return true
		else
			return false
		end
	end;
	if not AutoHelp.isRetail then
		AutoHelp.LibHealComm = e("LibHealComm-4.0")
	end;
	local jw = e("HereBeDragons-2.0")
	AutoHelp.NAMEPLATES_SHOWENEMIES = 0;
	AutoHelp.NAMEPLATES_MAXDISTANCE = 8;
	AutoHelp.RangeCheck = e("LibRangeCheck-3.0")
	function AutoHelp.GetRange(x)
		local ib, iG = AutoHelp.RangeCheck:GetRange(x, true)
		if ib == nil and iG == nil then
			return 100, 100
		end;
		if ib ~= nil and iG == nil then
			return ib, ib
		end;
		if ib == nil and iG ~= nil then
			return iG, iG
		end;
		return ib, iG
	end;
	AutoHelp.CAN_ACTION = false;
	local je = GetLocale()
	local jx = {}
	function GetCombatValue(p)
		return jx[p]
	end;
	function GetCombatNumber(p)
		return jx[p] or 0
	end;
	function SetCombatValue(p, jp)
		jx[p] = jp
	end;
	function ClearCombatValues()
		table.wipe(jx)
	end;
	local function jy(p, jz)
		local jq = HelpSettings;
		if jq[p] == nil and jz ~= nil then
			jq[p] = jz
		end;
		return jq[p]
	end;
	local jA = {}
	local function jB(p, jC)
		if not jA[p] then
			jA[p] = {}
		end;
		table.insert(jA[p], jC)
	end;
	AutoHelp.RegisterKeyCallback = jB;
	local function jD(p, jp)
		for _, jC in pairs(jA[p] or {}) do
			jC(jp)
		end
	end;
	AutoHelp.triggerCallback = jD;
	function SetConfig(p, jp, jE)
		HelpSettings[p] = jp;
		if not jE then
			jD(p, jp)
		end
	end;
	function GetStatus(bi, jz)
		return jy(bi, jz)
	end;
	function GetStatusNumber(bi)
		return tonumber(GetStatus(bi)) or 0
	end;
	function GetStatusString(bi)
		return GetStatus(bi) or ""
	end;
	AutoHelp.GetStatus = GetStatus;
	AutoHelp.GetStatusNumber = GetStatusNumber;
	AutoHelp.GetStatusString = GetStatusString;
	AutoHelp.UseSpellQueueWindow = false;
	AutoHelp.AdjustSpellQueueWindow = 0.15;
	function SaveDebuffName(jF, im)
		local jG = jy("SavedDebuffs", {})
		jG[jF] = im
	end;
	AutoHelp.SetConfig = SetConfig;
	AutoHelp.GetConfig = jy;
	local jH = {}
	function SaveConfigValue(hW, jp)
		jH[hW] = jy(hW, jp)
		SetConfig(hW, jp)
	end;
	function RestoreConfigValue(hW)
		SetConfig(hW, jH[hW])
	end;
	function ToggleStatus(dz, jp, jI)
		if jI then
			for _, hK in pairs(dz) do
				if hK ~= jp then
					SetConfig("STATUS_" .. hK, false)
				end
			end
		end
	end;
	function GetToggleStatus(dz)
		for _, jp in pairs(dz) do
			if GetStatus("STATUS_" .. jp) then
				return jp
			end
		end
	end;
	AutoHelp.FINDTARGETMODE = {
		"转圈寻怪",
		"移动寻怪"
	}
	local jJ = {}
	AutoHelp.HealButtons = jJ;
	AutoHelp.SettingItems = {}
	AutoHelp.PanelItems = {}
	local jK = AutoHelp.SettingItems;
	local jL = AutoHelp.PanelItems;
	local function jM(self, jN)
		GameTooltip:SetOwner(self)
		GameTooltip:SetText(tostring(self.tooltipTitle))
		GameTooltip:AddLine(tostring(self.tooltipText), 1, 1, 1, true)
		GameTooltip:Show()
	end;
	local function jO(self, jN)
		GameTooltip:Hide()
	end;
	local function jP(gI, jq)
		local cp = CreateFrame("Button", nil, gI, jq["buttonTemplate"] or "GameMenuButtonTemplate")
		cp:SetText(jq["title"])
		if type(jq["fnc"]) == "function" then
			cp:SetScript("OnClick", jq["fnc"])
		end;
		if jq["tip"] ~= nil then
			cp.tooltipTitle = jq["tipTitle"] or jq["title"]
			cp.tooltipText = jq["tip"]
			cp:SetScript("OnEnter", jM)
			cp:SetScript("OnLeave", jO)
		end;
		return cp
	end;
	local function jQ(gI, jq)
		local cp = CreateFrame("CheckButton", nil, gI, "OptionsBaseCheckButtonTemplate")
		cp:SetSize(18, 18)
		cp.text = cp:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		cp.text:SetPoint("LEFT", cp, "RIGHT", 0, 0)
		cp.text:SetText(jq["title"])
		local jR, jS = cp.text:GetFont()
		cp.text:SetFont(jR, 14)
		cp:SetScript("OnClick", function()
			SetConfig(jq["id"], cp:GetChecked())
		end)
		local jT = jq["tipTitle"] or jq["title"]
		if jT and jq["tip"] then
			cp.tooltipTitle = jT or "帮助"
			cp.tooltipText = jq["tip"] or "没有内容"
			cp:SetScript("OnEnter", jM)
			cp:SetScript("OnLeave", jO)
		end;
		jB(jq["id"], function(hK)
			cp:SetChecked(hK)
			if type(jq["fnc"]) == "function" then
				jq["fnc"](cp:GetChecked())
			end
		end)
		jD(jq["id"], jy(jq["id"], jq["value"]))
		return cp
	end;
	local jU, jV = UnitFactionGroup("player")
	if jU == "Alliance" then
		AutoHelp.SXNAME = GetSpellInfo(32182) or "英勇"
	else
		AutoHelp.SXNAME = GetSpellInfo(2825) or "嗜血"
	end;
	local jW;
	if GetLocale() == "zhCN" or GetLocale() == "zhTW" then
		jW = {
			["WARRIOR"] = "战",
			["PALADIN"] = "骑",
			["HUNTER"] = "猎",
			["ROGUE"] = "贼",
			["PRIEST"] = "牧",
			["MAGE"] = "法",
			["WARLOCK"] = "术",
			["DRUID"] = "德",
			["SHAMAN"] = "萨",
			["DEATHKNIGHT"] = "死"
		}
	else
		jW = {
			["WARRIOR"] = "W",
			["PALADIN"] = "P",
			["HUNTER"] = "H",
			["ROGUE"] = "R",
			["PRIEST"] = "P",
			["MAGE"] = "M",
			["WARLOCK"] = "L",
			["DRUID"] = "D",
			["SHAMAN"] = "S",
			["DEATHKNIGHT"] = "K"
		}
	end;
	local function jX(gI, jq)
		local p = jq["id"]
		local jz = jq["value"]
		local cp = CreateFrame("Button", nil, gI, "UIMenuButtonStretchTemplate")
		cp:SetWidth(jq["width"] or 42)
		cp:SetHeight(20)
		cp.key = p;
		cp.buffValue = jz;
		cp:SetScript("OnClick", function(self)
			jD(self.key, 0)
		end)
		jB(p, function(hK)
			if hK ~= 0 then
				local jY = "无"
				for _, jZ in pairs(AutoHelp.ClassBuffList) do
					if jZ["name"] == hK then
						jY = jZ["ShortClassName"]
					end
				end;
				cp:SetText(jW[p] .. jY)
			end
		end)
		jD(p, jy(p, jz))
		return cp
	end;
	HEAL_EDITBOX_EDITING = false;
	local function j_(gI, p, jz, k0)
		local cp = CreateFrame("EditBox", p .. "Edit", gI, "BackDropTemplate")
		cp:SetSize(40, 16)
		cp:SetMultiLine(false)
		cp:SetAutoFocus(false)
		cp:SetJustifyH("CENTER")
		cp:SetFont(ChatFontNormal:GetFont())
		cp:SetBackdrop({
			_,
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			_,
			_,
			edgeSize = 5,
			_
		})
		cp.textType = type(jz)
		cp:SetScript("OnEnterPressed", function(self)
			SetConfig(p, self:GetText())
			self:ClearFocus()
		end)
		cp:SetScript("OnTabPressed", function(self)
			SetConfig(p, self:GetText())
			self:ClearFocus()
		end)
		cp:SetScript("OnEscapePressed", function(self)
			self:ClearFocus()
		end)
		cp:SetScript("OnEditFocusGained", function(self)
			HEAL_EDITBOX_EDITING = true
		end)
		cp:SetScript("OnEditFocusLost", function(self)
			HEAL_EDITBOX_EDITING = false
		end)
		jB(p, function(hK)
			cp:SetText(hK)
			if type(k0) == "function" then
				k0(hK)
			end
		end)
		jD(p, jy(p, jz))
		return cp
	end;
	local k1 = {}
	local k2;
	local function k3(gI, k4)
		local k5 = CreateFrame("Frame", nil, gI, "BackDropTemplate")
		k5.name = k4["name"]
		k5:SetHeight(k4["height"])
		k5:SetWidth(k4["width"])
		k5:SetPoint("TOPLEFT", 0, - 30)
		k5.texture = k5:CreateTexture(nil, 'BACKGROUND', nil, 7)
		k5.texture:SetColorTexture(0.1, 0.1, 0.1, 0.7)
		k5.texture:SetAllPoints()
		k5:EnableMouse(true)
		k5:SetMovable(true)
		k5:SetClampedToScreen(true)
		k5:RegisterForDrag("LeftButton")
		k5:SetScript("OnDragStart", function()
			local k6 = gI;
			k6:StartMoving()
			k6.isMoving = true
		end)
		k5:SetScript("OnDragStop", function()
			local k6 = gI;
			k6:StopMovingOrSizing()
			k6.isMoving = false;
			point, relativeTo, relativePoint, xOfs, yOfs = k6:GetPoint()
		end)
		if k4["show"] == true then
			k5.status = 1;
			k5:Show()
		else
			k5.status = 0;
			k5:Hide()
		end;
		return k5
	end;
	local function k7(gI, k4)
		local k8 = CreateFrame("CheckButton", nil, gI, "GameMenuButtonTemplate")
		k8.name = k4["name"]
		k8:SetText(k4["title"])
		if k4["buttonWidth"] then
			k8:SetWidth(k4["buttonWidth"])
		else
			k8:SetWidth(45)
		end;
		k8:SetPoint("TOPLEFT", k4["point"], - 5)
		if k4["create"] and type(k4["create"]) == "function" then
			k4["create"](k8)
		end;
		if k4["fnc"] then
			k8:SetScript("OnClick", k4["fnc"])
		else
			k8:SetScript("OnClick", function(self)
				for cd, k9 in pairs(k1) do
					if cd == self.name then
						k9["tabframe"]:Show()
						k9["tabframe"].status = 1
					else
						k9["tabframe"]:Hide()
						k9["tabframe"].status = 0
					end
				end;
				k2:SetText("-")
			end)
		end;
		return k8
	end;
	local function ka(cd, h6, h7)
		local kb = CreateFrame("Frame", nil, UIParent)
		kb.name = cd;
		kb:SetHeight(h7)
		kb:SetWidth(h6)
		kb:SetPoint("RIGHT", - 100, 180)
		local kc = jy("TabPanelLocation")
		if kc == nil then
			kb:SetPoint("RIGHT", - 100, 180)
		else
			local ja, s = pcall(function()
				kb:SetPoint(kc["point"], kc["relativeTo"], kc["relativePoint"], kc["xOfs"], kc["yOfs"])
			end)
			if not ja then
				kb:SetPoint("RIGHT", - 100, 180)
			end
		end;
		kb.texture = kb:CreateTexture(nil, 'BACKGROUND', nil, 7)
		kb.texture:SetColorTexture(0.1, 0.1, 0.1, 1)
		kb.texture:SetAllPoints()
		kb:EnableMouse(true)
		kb:SetMovable(true)
		kb:SetClampedToScreen(true)
		kb:RegisterForDrag("LeftButton")
		kb:SetScript("OnDragStart", function()
			local k6 = kb;
			k6:StartMoving()
			k6.isMoving = true
		end)
		kb:SetScript("OnDragStop", function()
			local k6 = kb;
			k6:StopMovingOrSizing()
			k6.isMoving = false;
			point, relativeTo, relativePoint, xOfs, yOfs = k6:GetPoint()
			local kd = {}
			kd["point"] = point;
			kd["relativeTo"] = relativeTo;
			kd["relativePoint"] = relativePoint;
			kd["xOfs"] = xOfs;
			kd["yOfs"] = yOfs;
			SetConfig("TabPanelLocation", kd)
		end)
		k2 = CreateFrame("CheckButton", nil, kb, "GameMenuButtonTemplate")
		k2:SetText("-")
		k2:SetWidth(20)
		k2:SetPoint("TOPLEFT", 140, - 5)
		k2:SetScript("OnClick", function(self)
			if self:GetText() == "-" then
				self:SetText("+")
				for cd, k9 in pairs(k1) do
					k9["tabframe"]:Hide()
				end
			else
				for cd, k9 in pairs(k1) do
					if k9["tabframe"].status == 1 then
						k9["tabframe"]:Show()
					end
				end;
				self:SetText("-")
			end
		end)
		return kb
	end;
	local ke = 0;
	local kf = function(i4, kg)
		if not i4 then
			i4 = 22 + (kg or 0)
		end;
		ke = ke - i4;
		return ke
	end;
	local function kh()
		local ki = AutoHelp.PANELHEIGHT or 490;
		local kj = AutoHelp.PANELWIDTH or 160;
		local kk = {
			{
				["name"] = "HealHelpBaseFrame",
				["id"] = "HealHelpBaseFrame",
				["title"] = "治疗",
				["point"] = 0,
				["topleftX"] = 0,
				["topleftY"] = - 30,
				["buttonWidth"] = 50,
				["width"] = kj,
				["height"] = ki,
				["show"] = true,
				["fnc"] = function(kl)
					local km = false;
					for cd, k9 in pairs(k1) do
						if cd == "HealHelpBaseFrame" then
							km = k9["tabframe"]:IsShown()
							k9["tabframe"]:Show()
							k9["tabframe"].status = 1
						else
							k9["tabframe"]:Hide()
							k9["tabframe"].status = 0
						end
					end;
					if km then
						k2:SetText("-")
						local kn = AutoHelp.ModeList;
						AutoHelp.PopupModeListMenu(kl, kn, jy("HEALMODE"), AutoHelp.HEAL_MODES)
					else
						k2:SetText("-")
					end
				end,
				["items"] = {
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_PAUSE",
						["value"] = false,
						["title"] = "\124cfff00000暂停\124r",
						["tip"] = "需要手动操作时，勾选暂停停止运行。\r\n可以使用小键盘零（0）快捷键切换/或者使用[暂停]宏进行切换。\n\n\124cff00ff00宏设置:\n/run AutoHelp.TogglePause()\124r",
						["point"] = 5,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主动开怪",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cfff00000主动开怪\124r",
						["tip"] = "选择此项，非战斗中可以主动攻击选中的敌对目标，不选择此项，只有进入战斗状态才开始自动攻击敌对目标",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_目标互动",
						["value"] = false,
						["hitRect"] = - 30,
						["title"] = "\124cffFFF569互动\124r",
						["tip"] = "自动与目标互动，比如距离过远自动靠近目标，并攻击\n不选择目标互动，必须手动移动到攻击位置，才开始自动攻击",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动寻怪",
						["value"] = false,
						["title"] = "\124cffFFF569寻怪\124r",
						["tip"] = "自动升级使用，站在某个地方，自动寻找怪物攻击，或者自动选择前方怪物进行攻击。有三种寻怪方式：\n\n\n\n\124cff00ff001.原地转圈，在原地转圈搜索\n2.移动搜索，向前移动然后右转搜索\n3.自动选择前方敌对目标。\n\n在设置页面可进行设置【转圈寻怪/移动寻怪，都不选则只搜索前方目标】 ",
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动拾取",
						["value"] = false,
						["title"] = "\124cffFFF569拾取\124r",
						["tip"] = "自动升级使用，杀死怪物后自动拾取",
						["point"] = 105,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_MOREHEALBUTTON",
						["title"] = "法术",
						["tipTitle"] = "技能等级选择",
						["tip"] = "选择多个治疗法术智能治疗",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(kl)
							kl:SetText("法术(" .. # jy("HEALKEYS", {}) .. "/" .. # jy("MOVEHEALKEYS", {}) .. ")")
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupMoreLevelListMenu(kl, AutoHelp.STAND_HEAL_SPELLS, AutoHelp.MOVE_HEAL_SPELLS)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AUTOHEAL",
						["value"] = true,
						["title"] = "\124cffFF7D0A全团治疗\124r",
						["tip"] = "自动搜索团队血量低于设定值最多的成员进行治疗\r\n缺省设定值为80%（0.80），提高或者降低该设定，可以改变加血频率。\n\n\124cff00ff00本选项是最低级别，优先级低于坦克治疗和掉血优先\124r\n\n\124cff00ff00宏设置:\n/run AutoHelp.SetHealRaid(true/false)\124r",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_AUTO_VALUE",
						["value"] = 92,
						["point"] = 100,
						["mode"] = "healer",
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTTANK",
						["value"] = true,
						["title"] = "\124cffFF7D0A坦克优先",
						["tip"] = "设置坦克优先治疗,坦克血量低于设定值优先治疗坦克\r\n坦克必须通过团队框架设置。\n\n\124cff00ff00本选项高于全团治疗，当坦克血量低于设定值，即使其他职业血量更低依然优先治疗坦克\124r",
						["point"] = 5,
						["mode"] = "healer",
						["hitRect"] = - 60,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_FIRSTTANK_VALUE",
						["value"] = 60,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTTARGET",
						["value"] = false,
						["title"] = "\124cffFF7D0A目标优先",
						["tip"] = "目标治疗，优先给当前目标或者当前敌人的目标加血，主要用于坦克专门治疗\n\n\124cff00ff00可以选择当前BOSS，将优先给boss的目标加血\n\n如果还设置了医保列表，则同时判定目标或者医保列表进行加血，比如TAQ双子治疗SST和战士T，可以将SS和战士加入医保，将只给这两个人加血！\124r",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_FIRSTPROTECT_VALUE",
						["value"] = 90,
						["percent"] = "%",
						["point"] = 100,
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_LOWHEAL",
						["value"] = false,
						["title"] = "\124cff00ff00省蓝\124r",
						["tip"] = "使用最节省蓝量或低级治疗法术，最小过量模式来进行治疗，预测加血阈值75%\n\n\124cff00ff00治疗阈值计算方式：比如目标需要治疗100血量，1级法术75点，2级100点，3级120点。计算均不考虑暴击。\n\n省蓝模式：100*0.75=75(1级)\n标准模式：100*100%=100（2级）\n过量模式：100*1.25=125（3级）\124r\n\n\124cffFF7D0A为了达到精确治疗，请尽可能多的勾选各级治疗法术！\124r",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "classic",
						["fnc"] = function(jI)
							if jI then
								SetConfig("HEAL_STATUS_NORMAHEAL", false)
								SetConfig("HEAL_STATUS_OVERHEAL", false)
								SetConfig("OverHealValue", 75)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_NORMAHEAL",
						["value"] = true,
						["title"] = "标准",
						["tip"] = "使用最标准模式和正常蓝耗来进行治疗，预测加血阈值100%\n\n\124cff00ff00标准模式治疗计算阈值100%\124r",
						["point"] = 60,
						["hitRect"] = - 30,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "classic",
						["fnc"] = function(jI)
							if jI then
								SetConfig("HEAL_STATUS_LOWHEAL", false)
								SetConfig("HEAL_STATUS_OVERHEAL", false)
								SetConfig("OverHealValue", 100)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_OVERHEAL",
						["value"] = false,
						["title"] = "\124cffFF7D0A过量\124r",
						["tip"] = "使用最过量模式和高蓝耗来进行治疗，适合短平快战斗，预测加血阈值125%\n\n\124cff00ff00标准模式治疗计算阈值125%\124r",
						["point"] = 110,
						["hitRect"] = - 30,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "classic",
						["fnc"] = function(jI)
							if jI then
								SetConfig("HEAL_STATUS_LOWHEAL", false)
								SetConfig("HEAL_STATUS_NORMAHEAL", false)
								SetConfig("OverHealValue", 125)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_RESCURIT",
						["value"] = true,
						["title"] = "自动救人",
						["tipTitle"] = "自动救人",
						["tip"] = "如果蓝量足够，脱战后是否自动救人",
						["point"] = 5,
						["nextpos"] = 70,
						["mode"] = "healer,moonkin,cat,bear",
						["create"] = function(ko)
							if not AutoHelp.RESCURIT_KEY or not AutoHelp.HasActionKey(AutoHelp.RESCURIT_KEY) then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_INBATTLE_HEAL",
						["value"] = true,
						["title"] = "战斗治疗",
						["tip"] = "选择只会在战斗状态下治疗\r\n不选择，非战斗状态也会治疗目标\n\n\124cff00ff00测试是否运行正常，可以关闭此选项后换装看是否自动加血！\124r",
						["point"] = 80,
						["nextpos"] = 70,
						["mode"] = "healer"
					}
				}
			},
			{
				["name"] = "HealHelpAssistFrame",
				["id"] = "HealHelpAssistFrame",
				["title"] = "攻击",
				["point"] = 50,
				["topleftX"] = 0,
				["topleftY"] = - 30,
				["buttonWidth"] = 50,
				["width"] = kj,
				["height"] = ki,
				["show"] = false,
				["items"] = {
					{
						["type"] = "checkbox",
						["id"] = "STATUS_主动攻击",
						["value"] = true,
						["hitRect"] = - 40,
						["title"] = "\124cff00ff00启动攻击\124r",
						["tip"] = "如果团队血量不需要治疗时,有敌方目标且在战斗就开始攻击模式",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主动开怪",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cfff00000主动开怪\124r",
						["tip"] = "选择此项，非战斗中可以主动攻击选中的敌对目标，不选择此项，即使有主动攻击，也不会进入战斗状态（攻击敌对目标）\124r",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_目标互动",
						["value"] = false,
						["hitRect"] = - 30,
						["title"] = "\124cffFFF569互动\124r",
						["tip"] = "自动与目标互动，比如距离过远自动靠近目标，并攻击\n不选择目标互动，必须手动移动到攻击位置，才开始自动攻击",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动寻怪",
						["value"] = false,
						["title"] = "\124cffFFF569寻怪\124r",
						["tip"] = "自动升级使用，站在某个地方，自动寻找怪物攻击",
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动拾取",
						["value"] = false,
						["title"] = "\124cffFFF569拾取\124r",
						["tip"] = "自动升级使用，杀死怪物后自动拾取",
						["point"] = 105,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_AUTOFOLLOW_BUTTON22",
						["title"] = "自动跟随",
						["tip"] = "选择设置自动跟随目标\r\n选择目标后，点击此按钮跟随目标\r\n跟随状态中，点击此按钮停止跟随\r\n\r\n只能跟随团队或队伍目标",
						["width"] = 150,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = 50,
						["fnc"] = function(hK)
							AutoHelp.triggerCallback("HEAL_STATUS_TOGGLE_AUTOFOLLOW", hK)
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_ASSISTUNIT_BUTTON22",
						["title"] = "协助攻击",
						["tip"] = "协助攻击，协助队友在战斗时进行攻击，只能选择队友",
						["width"] = 150,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = 25,
						["fnc"] = function(hK)
							AutoHelp.triggerCallback("HEAL_STATUS_TOGGLE_ASSISTUNIT", hK)
						end
					}
				}
			},
			{
				["name"] = "HealHelpSettingFrame",
				["id"] = "HealHelpSettingFrame",
				["title"] = "设置",
				["point"] = 100,
				["topleftX"] = 0,
				["topleftY"] = - 5,
				["buttonWidth"] = 50,
				["width"] = kj,
				["height"] = ki,
				["show"] = false,
				["items"] = {
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动战场",
						["value"] = false,
						["title"] = "战场",
						["tip"] = "\124cff00ff00自动帮你排战场/进入战场/退出战场，由于暴雪对战场控制严格，容易被举报，切勿在战场挂机！！！\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = 190,
						["version"] = "wlk"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_战场名称",
						["title"] = "选择加入战场",
						["tipTitle"] = "战场选择",
						["tip"] = "\n\124cff00ff00选择要加入的战场，将自动排队、进入、退出\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = 190,
						["version"] = "wlk",
						["create"] = function(kl)
							local kp = jy("JOIN_战场")
							if kp then
								kl:SetText(kp)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupBattleListMenu("选择自动加入战场", "HEAL_STATUS_战场名称", "JOIN_战场", kl, AutoHelp.BATTLEGROUNDS, jy("JOIN_战场"))
						end
					},
					{
						["type"] = "button",
						["id"] = "BUTTON_食物选择",
						["title"] = "选择食物",
						["tipTitle"] = "选择自动吃的食物",
						["tip"] = "\n\124cff00ff00除了系统缺省的食物可以自动吃喝，这里可以选择你要吃的食物\124r",
						["width"] = 80,
						["height"] = 20,
						["point"] = 0,
						["nextpos"] = 190,
						["version"] = "classic",
						["create"] = function(kl)
							local kq = jy("USEFOOD")
							if kq then
								local kp = GetItemInfo(kq) or ""
								kl:SetText(string.sub(kp, 1, 12))
							else
								kl:SetText("选择食物")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupFoodListMenu("选择食物", kl, "USEFOOD", true)
						end
					},
					{
						["type"] = "button",
						["id"] = "BUTTON_魔法水选择",
						["title"] = "选择喝水",
						["tipTitle"] = "选择喝水",
						["tip"] = "\n\124cff00ff00除了系统缺省的魔法水可以自动吃喝，这里可以选择你要喝的水，物理职业无效！\124r",
						["width"] = 80,
						["height"] = 20,
						["point"] = 80,
						["nextpos"] = 190,
						["version"] = "classic",
						["create"] = function(kl)
							local kq = jy("USEWATER")
							if kq then
								local kp = GetItemInfo(kq) or ""
								kl:SetText(string.sub(kp, 1, 12))
							else
								kl:SetText("选择喝水")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupFoodListMenu("选择喝水", kl, "USEWATER", false)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "EATING_STATUS",
						["value"] = true,
						["title"] = "自动面包",
						["tip"] = "脱战后，根据设定血量自动吃面包等食物，主要是法师魔法制造面包\n\n\124cff00ff00缺省设置为蓝量低于50%脱战自动喝水\124r",
						["point"] = 5,
						["nextpos"] = 170
					},
					{
						["type"] = "editbox",
						["id"] = "EATING_VALUE",
						["value"] = 50,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = 170
					},
					{
						["type"] = "checkbox",
						["id"] = "DRINKING_STATUS",
						["value"] = true,
						["title"] = "自动喝水",
						["tip"] = "脱战后，当自己血量或者蓝量低于时自动喝水（如果背包有魔法晶水/面包等法师制造物）。物理职业本设置无效！\n\n\124cff00ff00缺省设置为蓝量低于50%脱战自动喝水\124r",
						["point"] = 5,
						["nextpos"] = 150
					},
					{
						["type"] = "editbox",
						["id"] = "DRINKING_VALUE",
						["value"] = 50,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = 150
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动吃糖",
						["value"] = true,
						["title"] = "自动吃糖",
						["tip"] = "当自己血量危机时，自动吃糖或者喝红[符文治疗药水]（缺省血量过低于35%）",
						["point"] = 5,
						["nextpos"] = 130
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_保命血量",
						["value"] = 35,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = 130
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_创建队列宏",
						["value"] = true,
						["title"] = "职业宏",
						["tip"] = "将自动创建本职业相关的施法队列宏，并依次放入动作条1、2等位置。\n\n如果不需要自动创建宏，关闭此选项即可。\n\n\124cff00ff00由于AuthoHelp在运行时，要执行手动施法相对困难，所以可以使用类似下面的宏把施法动作插入执行队列\n\n#替换下面的xxxx为要执行的动作名称\n/ahcast xxxx\124r",
						["point"] = 5,
						["hitRect"] = - 40,
						["nextpos"] = 110
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_快速施法",
						["value"] = true,
						["title"] = "快速施法",
						["tip"] = "两次技能之间，由于网络延迟及程序运行等原因，一般会有0.2秒至0.35秒间隔延迟，使用此选项，会使用预读施法技能方式，完全消除两次施法间隔的延迟时间，最大化技能循环效率。\n\n\124cff00ff00对于输出职业，选择此选项将明显提高DPS，对于治疗职业，此选项有可能导致蓝量消耗过快，请根据自己战斗时长选择。\124r",
						["point"] = 80,
						["hitRect"] = - 40,
						["nextpos"] = 110,
						["fnc"] = function(hK)
							if hK then
								AutoHelp.UseSpellQueueWindow = true;
								SetCVar("SpellQueueWindow", GetCVarDefault("SpellQueueWindow"))
								AutoHelp.SpellQueueWindow = (tonumber(GetCVar("SpellQueueWindow")) or 400) / 1000 - AutoHelp.AdjustSpellQueueWindow;
								if AutoHelp.SpellQueueWindow < 0 then
									AutoHelp.SpellQueueWindow = 0
								end
							else
								AutoHelp.UseSpellQueueWindow = false;
								SetCVar("SpellQueueWindow", 200)
								AutoHelp.SpellQueueWindow = (tonumber(GetCVar("SpellQueueWindow")) or 400) / 1000 - AutoHelp.AdjustSpellQueueWindow;
								if AutoHelp.SpellQueueWindow < 0 then
									AutoHelp.SpellQueueWindow = 0
								end
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_SHOWINFOPANEL",
						["value"] = false,
						["title"] = "信息",
						["tip"] = "打开关闭信息条",
						["point"] = 5,
						["nextpos"] = 90
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_DEBUG",
						["value"] = false,
						["title"] = "技能",
						["tip"] = "在聊天窗口输出成功施法技能信息及目标等信息",
						["point"] = 60,
						["nextpos"] = 90
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动下马",
						["value"] = true,
						["title"] = "下马",
						["tip"] = "要释放技能是，如果在坐骑上，会自动下面。",
						["point"] = 110,
						["nextpos"] = 90
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_转圈寻怪",
						["value"] = true,
						["title"] = "转圈",
						["tipTitle"] = "转圈寻怪",
						["tip"] = "原地45度转圈方式寻找怪物，会一直是原地转圈，另一种是前进一段距离右转，如果都不选择，将会只选择前方目标。",
						["point"] = 5,
						["nextpos"] = 70,
						["fnc"] = function(jI)
							ToggleStatus(AutoHelp.FINDTARGETMODE, "转圈寻怪", jI)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_移动寻怪",
						["value"] = false,
						["title"] = "移动",
						["tipTitle"] = "移动寻怪",
						["tip"] = "寻怪方式为向前进一段距离右转，一种移动方式寻找怪物。如果都不选择，将会只选择前方目标。",
						["point"] = 60,
						["nextpos"] = 70,
						["fnc"] = function(jI)
							ToggleStatus(AutoHelp.FINDTARGETMODE, "移动寻怪", jI)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_快速转圈",
						["value"] = false,
						["title"] = "快转",
						["tipTitle"] = "快速转圈寻怪",
						["tip"] = "原地转圈的时候，采用快速转圈方式，建议不要勾选此项，看起来非人工操作。",
						["point"] = 110,
						["nextpos"] = 70
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AUTOFOLLOW",
						["value"] = true,
						["title"] = "控制",
						["tip"] = "打开队伍控制功能：自动跟随/停止跟随/协助攻击/跟随逃命 等，通过队伍/团队/私密发送命令\n\n\124cff00ff00/p 自动跟随 \n/p 停止跟随\n/p 协助攻击\n/p 跟随逃命\124r",
						["point"] = 5,
						["nextpos"] = 50
					},
					{
						["type"] = "button",
						["id"] = "BUTTON_TEAMMACRO",
						["title"] = "创建控制宏",
						["tip"] = "点击创建队伍控制宏， 包括协助攻击/自动跟随等宏，请自行从宏拖入快捷键使用",
						["width"] = 100,
						["height"] = 20,
						["point"] = 55,
						["nextpos"] = 50,
						["fnc"] = function(hK)
							FindOrCreateMacro("跟随我", 136119, "/p 自动跟随我\n", 55)
							FindOrCreateMacro("停止跟随", 136119, "/p 停止跟随我\n", 56)
							FindOrCreateMacro("逃命跟随", 136119, "/run SetConfig(\"STATUS_目标互动\", false);\n/p 逃命跟随我\n", 57)
							FindOrCreateMacro("协助攻击", 136119, "/p 开始协助我\n", 58)
							FindOrCreateMacro("重载界面", 136119, "/p 自动重载界面\n", 59)
							FindOrCreateMacro("开始AOE", 136119, "/p 开始AOE\n")
							FindOrCreateMacro("停止AOE", 136119, "/p 停止AOE\n")
							AutoHelp.Debug("队伍控制宏已经创建：\n跟随我/停止跟随/逃命跟随/协助攻击/重载界面/开始AOE/停止AOE！")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_RESETDEFAULT",
						["title"] = "恢复所有缺省值",
						["tip"] = "选择设置自动跟随目标\r\n选择目标后，点击此按钮跟随目标\r\n跟随状态中，点击此按钮停止跟随\r\n\r\n只能跟随团队或队伍目标",
						["width"] = 150,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = 25,
						["fnc"] = function(hK)
							HelpSettings = {}
							C_UI.Reload()
						end
					}
				}
			}
		}
		local kr = {
			{
				["type"] = "button",
				["id"] = "HEAL_STATUS_AUTOFOLLOW_BUTTON",
				["title"] = "自动跟随",
				["tip"] = "选择设置自动跟随目标\r\n选择目标后，点击此按钮跟随目标\r\n跟随状态中，点击此按钮停止跟随\r\n\r\n只能跟随团队或队伍目标",
				["width"] = 150,
				["height"] = 25,
				["point"] = 5,
				["nextpos"] = 50,
				["fnc"] = function(hK)
					AutoHelp.triggerCallback("HEAL_STATUS_TOGGLE_AUTOFOLLOW", hK)
				end
			},
			{
				["type"] = "button",
				["id"] = "HEAL_STATUS_ASSISTUNIT_BUTTON",
				["title"] = "协助攻击",
				["tip"] = "协助攻击，协助队友在战斗时进行攻击，只能选择队友",
				["width"] = 150,
				["height"] = 25,
				["point"] = 5,
				["nextpos"] = 25,
				["fnc"] = function(hK)
					AutoHelp.triggerCallback("HEAL_STATUS_TOGGLE_ASSISTUNIT", hK)
				end
			}
		}
		return kk, kr
	end;
	local function ks()
		if AutoHelp.PANEL_CONFIG == nil then
			return
		end;
		local kt = {}
		local kk, kr = kh()
		local ku = 0;
		if AutoHelp.PANEL_CONFIG["healer"] then
			local kv = kk[1]
			for _, hW in ipairs(kr) do
				tinsert(kv["items"], 1, hW)
			end;
			for _, hW in ipairs(AutoHelp.PANEL_CONFIG["healer"]) do
				tinsert(kv["items"], hW)
			end;
			kv["point"] = ku;
			kv["buttonWidth"] = 100;
			ku = ku + 50;
			tinsert(kt, kv)
		end;
		if AutoHelp.PANEL_CONFIG["attack"] then
			local kv = kk[2]
			if not AutoHelp.PANEL_CONFIG["healer"] then
				for _, hW in ipairs(kr) do
					tinsert(kv["items"], 1, hW)
				end
			else
				kv["items"][1]["nextpos"] = false
			end;
			for _, hW in ipairs(AutoHelp.PANEL_CONFIG["attack"]) do
				tinsert(kv["items"], hW)
			end;
			if not AutoHelp.PANEL_CONFIG["healer"] then
				kv["show"] = true
			end;
			kv["point"] = ku;
			tinsert(kt, kv)
		end;
		if AutoHelp.PANEL_CONFIG["setting"] then
			local kv = kk[3]
			for _, hW in ipairs(AutoHelp.PANEL_CONFIG["setting"]) do
				tinsert(kv["items"], hW)
			end;
			tinsert(kt, kv)
		end;
		k1 = {}
		local kb = ka("HealHelpTab", 160, 30)
		kb:SetFrameStrata("MEDIUM")
		kb:SetFrameLevel(9999)
		kb:SetClampedToScreen(true)
		jK["tab"] = kb;
		for _, kw in ipairs(kt) do
			local kx = k7(kb, kw)
			local h3 = k3(kb, kw)
			h3:SetPoint("TOPLEFT", kw["topleftX"], kw["topleftY"])
			h3:SetBackdrop({
				_,
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				_,
				_,
				edgeSize = 5,
				_
			})
			h3:SetFrameStrata("MEDIUM")
			h3:SetFrameLevel(9999)
			h3:SetClampedToScreen(true)
			jK[kw["id"]] = h3;
			jK[kw["id"] .. "tabbtn"] = kx;
			k1[kw["name"]] = {}
			k1[kw["name"]]["tabbtn"] = kx;
			k1[kw["name"]]["tabframe"] = h3;
			local ky = {}
			jL[kw["id"]] = ky;
			ke = - 5;
			local kz;
			for _, jq in ipairs(kw["items"]) do
				local kA = true;
				if jq["version"] ~= nil then
					kA = false;
					if Contains(jq["version"], "wlk") and AutoHelp.isWotlk then
						kA = true
					elseif Contains(jq["version"], "classic") and AutoHelp.isClassic then
						kA = true
					elseif Contains(jq["version"], "tbc") and AutoHelp.isTBC then
						kA = true
					elseif Contains(jq["version"], "retail") and AutoHelp.isRetail then
						kA = true
					end
				end;
				if kA then
					if jq["base"] and kz then
						ke = kz
					end;
					if jq["base"] then
						kz = ke
					end;
					if jq["nextpos"] == true and not jq["hide"] then
						kf(jq["offset"])
					end;
					local y;
					if type(jq["nextpos"]) == "boolean" then
						y = ke
					else
						y = jq["nextpos"] - AutoHelp.PANELHEIGHT
					end;
					local bn;
					if jq["type"] == "checkbox" then
						bn = jQ(h3, jq)
						bn:SetPoint("TOPLEFT", h3, jq["point"], y)
						if jq["hitRect"] ~= nil then
							bn:SetHitRectInsets(0, jq["hitRect"], 0, 0)
						else
							bn:SetHitRectInsets(0, - 30, 0, 0)
						end;
						if jq["hide"] then
							bn:Hide()
						end;
						jK[jq["id"]] = bn
					end;
					if jq["type"] == "buffbutton" then
						bn = jX(h3, jq)
						bn:SetPoint("TOPLEFT", h3, jq["point"], y)
						if jq["hide"] then
							bn:Hide()
						end;
						jK[jq["id"]] = bn
					end;
					if jq["type"] == "editbox" then
						local kB;
						bn = j_(h3, jq["id"], jq["value"], jq["fnc"])
						bn:SetPoint("TOPLEFT", h3, jq["point"], y - 2)
						kB = y;
						if jq["fontSize"] then
							local jR, jS, kC = bn:GetFont()
							bn:SetFont(jR, jq["fontSize"], kC)
						end;
						if jq["width"] then
							bn:SetSize(jq["width"], jq["height"] or 16)
						end;
						if jq["hide"] then
							bn:Hide()
						end;
						jK[jq["id"]] = bn;
						if jq["percent"] then
							local a = h3:CreateFontString(nil)
							a:SetTextColor(1, 1, 1, 1)
							a:SetFont(STANDARD_TEXT_FONT, 16, "THINOUTLINE")
							a:SetPoint("TOPLEFT", h3, jq["point"] + (jq["width"] or 40), kB)
							a:SetWidth(20)
							a:SetText(jq["percent"])
							if jq["hide"] then
								a:Hide()
							end;
							local kD = jq["id"] .. "_percent"
							jK[kD] = a;
							if jq["mode"] then
								a.mode = jq["mode"]
							end;
							local kE = {}
							kE["id"] = kD;
							kE["base"] = jq["base"]
							kE["point"] = jq["point"] + (jq["width"] or 40)
							kE["nextpos"] = jq["nextpos"]
							kE["offset"] = jq["offset"]
							kE["frame"] = h3;
							kE["comp"] = a;
							ky[# ky + 1] = kE
						end
					end;
					if jq["type"] == "fontstring" then
						bn = h3:CreateFontString(nil)
						bn:SetTextColor(1, 1, 1, 1)
						bn:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
						bn:SetPoint("TOPLEFT", h3, jq["point"] or 5, y)
						bn:SetWidth(jq["width"] or 140)
						bn:SetJustifyH("LEFT")
						bn:SetJustifyV("TOP")
						bn:SetText(jq["value"])
						if jq["hide"] then
							bn:Hide()
						end;
						jK[jq["id"]] = bn;
						AutoHelp.HealFollowFrame = bn
					end;
					if jq["type"] == "button" then
						bn = jP(h3, jq)
						bn:SetWidth(jq["width"] or 75)
						bn:SetHeight(jq["height"] or 25)
						bn:SetPoint("TOPLEFT", h3, jq["point"], y)
						if jq["hide"] then
							bn:Hide()
						end;
						jK[jq["id"]] = bn
					end;
					if bn then
						local kE = {}
						kE["id"] = jq["id"]
						kE["base"] = jq["base"]
						kE["point"] = jq["point"]
						kE["nextpos"] = jq["nextpos"]
						kE["offset"] = jq["offset"]
						kE["frame"] = h3;
						kE["comp"] = bn;
						ky[# ky + 1] = kE
					end;
					if bn and jq["stance"] then
						bn.stance = jq["stance"]
					end;
					if bn and jq["mode"] then
						bn.mode = jq["mode"]
					end;
					if bn and jq["create"] and type(jq["create"]) == "function" then
						jq["create"](bn)
					end
				end
			end
		end
	end;
	function AutoHelp.ReDrawItems()
		local kF = 0;
		for bi, eK in pairs(jL) do
			ke = - 5;
			local kz = nil;
			for _, jq in ipairs(eK) do
				local bn, h3 = jq["comp"], jq["frame"]
				if bn:IsShown() then
					if jq["base"] and kz then
						ke = kz
					end;
					if jq["base"] then
						kz = ke
					end;
					if jq["nextpos"] == true and not jq["hide"] then
						kf(jq["offset"])
					end;
					if type(jq["nextpos"]) == "boolean" then
						y = ke
					else
						y = jq["nextpos"] - AutoHelp.PANELHEIGHT
					end;
					if bn:GetObjectType() == "Button" then
						bn:SetPoint("TOPLEFT", h3, jq["point"], y + 3)
					else
						bn:SetPoint("TOPLEFT", h3, jq["point"], y)
					end
				end
			end;
			if kF > ke then
				kF = ke
			end
		end
	end;
	function AutoHelp.ResizePanel(h7)
		local kF = 0;
		for bi, eK in pairs(jL) do
			ke = - 5;
			local kz = nil;
			local kG = 0;
			for _, jq in ipairs(eK) do
				local bn, h3 = jq["comp"], jq["frame"]
				if bn:IsShown() then
					if jq["base"] and kz then
						ke = kz
					end;
					if jq["base"] then
						kz = ke
					end;
					if jq["nextpos"] == true and not jq["hide"] then
						kf(jq["offset"])
					end;
					if type(jq["nextpos"]) == "boolean" then
						y = ke
					else
						if jq["nextpos"] > kG then
							kG = jq["nextpos"]
						end
					end
				end
			end;
			ke = ke - kG - 30;
			if kF > ke then
				kF = ke
			end
		end;
		AutoHelp.PANELHEIGHT = 0 - kF or 460;
		for cd, k9 in pairs(k1) do
			k9["tabframe"]:SetHeight(0 - kF or 460)
		end;
		AutoHelp.ReDrawItems()
	end;
	function AutoHelp.HideItem(bi)
		if jK and jK[bi] then
			jK[bi]:Hide()
		end
	end;
	function AutoHelp.HideItems(kH)
		for _, bn in pairs(jK) do
			if bn.mode == kH then
				bn:Hide()
			end
		end
	end;
	function AutoHelp.ShowItem(bi)
		if jK and jK[bi] then
			jK[bi]:Show()
		end
	end;
	function AutoHelp.ShowItems(kH)
		for _, bn in pairs(jK) do
			if bn.mode == kH then
				bn:Show()
			end
		end
	end;
	function AutoHelp.DisableItem(bi)
		if jK and jK[bi] then
			jK[bi]:Disable()
		end
	end;
	function AutoHelp.EnableItem(bi)
		if jK and jK[bi] then
			jK[bi]:Enable()
		end
	end;
	HEAL_DEBUG = true;
	local function kI()
		local kw = CreateFrame("Frame", "Healpanel", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		kw:SetHeight(80)
		kw:SetWidth(280)
		kw:SetFrameStrata("MEDIUM")
		kw:SetFrameLevel(9999)
		kw:SetClampedToScreen(true)
		kw:SetBackdrop({
			_,
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			_,
			_,
			edgeSize = 10,
			_
		})
		local kc = jy("InfoPanelLocation")
		if kc == nil then
			kw:SetPoint("RIGHT", - 270, 150)
		else
			kw:SetPoint(kc["point"], kc["relativeTo"], kc["relativePoint"], kc["xOfs"], kc["yOfs"])
		end;
		kw.texture = kw:CreateTexture(nil, 'BACKGROUND', nil, 7)
		kw.texture:SetColorTexture(0.1, 0.1, 0.1, 0.7)
		kw.texture:SetAllPoints()
		kw:EnableMouse(true)
		kw:SetMovable(true)
		kw:SetClampedToScreen(true)
		kw:RegisterForDrag("LeftButton")
		kw:SetScript("OnDragStart", function()
			local k6 = kw;
			k6:StartMoving()
			k6.isMoving = true
		end)
		kw:SetScript("OnDragStop", function()
			local k6 = kw;
			k6:StopMovingOrSizing()
			k6.isMoving = false;
			point, relativeTo, relativePoint, xOfs, yOfs = k6:GetPoint()
			local kd = {}
			kd["point"] = point;
			kd["relativeTo"] = relativeTo;
			kd["relativePoint"] = relativePoint;
			kd["xOfs"] = xOfs;
			kd["yOfs"] = yOfs;
			SetConfig("InfoPanelLocation", kd)
		end)
		do
			a = kw:CreateFontString(nil)
			a:SetTextColor(1, 1, 1, 1)
			a:SetFont(STANDARD_TEXT_FONT, 15, "THINOUTLINE")
			a:SetPoint("TOPLEFT", 5, - 2)
			a:SetHeight(30)
			a:SetJustifyH("LEFT")
			a:SetJustifyV("TOP")
			a:SetText("团队")
			jJ["RaidMembersText"] = a
		end;
		do
			a = kw:CreateFontString(nil)
			a:SetTextColor(1, 1, 1, 1)
			a:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
			a:SetPoint("TOPLEFT", 5, - 20)
			a:SetHeight(30)
			a:SetJustifyH("LEFT")
			a:SetJustifyV("TOP")
			a:SetText("团队血量：100%")
			jJ["RaidHealthText"] = a
		end;
		do
			a = kw:CreateFontString(nil)
			a:SetTextColor(1, 1, 1, 1)
			a:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
			a:SetPoint("TOPLEFT", 5, - 50)
			a:SetWidth(300)
			a:SetJustifyH("LEFT")
			a:SetJustifyV("TOP")
			a:SetText("目标")
			jJ["HealTargetFrame"] = a
		end;
		do
			a = kw:CreateFontString(nil)
			a:SetTextColor(1, 1, 1, 1)
			a:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
			a:SetPoint("TOPLEFT", 5, - 64)
			a:SetWidth(300)
			a:SetJustifyH("LEFT")
			a:SetJustifyV("TOP")
			a:SetText("法术：")
			kw:SetHeight(100)
			jJ["HealSpellFrame"] = a
		end;
		do
			if HEAL_DEBUG then
				a = kw:CreateFontString(nil)
				a:SetTextColor(1, 1, 1, 1)
				a:SetFont(STANDARD_TEXT_FONT, 14, "THINOUTLINE")
				a:SetPoint("TOPLEFT", 5, - 80)
				a:SetWidth(300)
				a:SetJustifyH("LEFT")
				a:SetJustifyV("TOP")
				a:SetText("调试：")
				jJ["HealDebugFrame"] = a
			end
		end;
		do
			a = CreateFrame("CheckButton", nil, kw, "GameMenuButtonTemplate")
			a:SetPoint("TOPLEFT", 250, - 2)
			a:SetWidth(30)
			a.tooltipTitle = "关闭信息面板"
			a.tooltipText = "如果关闭后, 要重新打开, 请在设置里面重新勾选信息条"
			a:SetText("X")
			a:SetScript("OnClick", function(self)
				SetConfig("HEAL_STATUS_SHOWINFOPANEL", false)
				AutoHelp.Debug("##要重新打开, 请在设置里面重新勾选信息条!")
			end)
			jJ["CloseButton"] = a
		end;
		kw:Hide()
		return kw
	end;
	local kJ = 4;
	local kK = 4;
	local kL = 1;
	local function kM(i)
		if i ~= math.floor(i) then
			error("The number passed to 'integerToColor' must be an integer")
		end;
		if i > 256 * 256 * 256 - 1 then
			error("Integer too big to encode as color")
		end;
		local cp = Modulo(i, 256)
		i = math.floor(i / 256)
		local kN = Modulo(i, 256)
		i = math.floor(i / 256)
		local kO = Modulo(i, 256)
		return {
			kO / 255,
			kN / 255,
			cp / 255
		}
	end;
	local function kP()
		local h3 = CreateFrame("Frame", "MyColorFrame", UIParent)
		h3:SetPoint("TOPLEFT")
		h3:SetWidth(kJ)
		h3:SetHeight(kK)
		h3.texture = h3:CreateTexture("MyColorTexture", 'OVERLAY', nil, 7)
		h3.texture:SetColorTexture(0.2, 0.2, 0.2, 1)
		h3.texture:SetAllPoints()
		h3:SetFrameStrata("TOOLTIP")
		h3:Hide()
		return h3
	end;
	local function kQ()
		local h6, h7 = GetPhysicalScreenSize()
		local kR = UIParent:GetScale()
		return 768 / h7 / kR
	end;
	AutoHelp.GetActualScale = kQ;
	local kS = {}
	local function kT(cd, kU, kV, kW)
		local h3 = CreateFrame("Frame", cd .. "Frame", UIParent)
		h3:SetPoint("TOPLEFT", kJ * (kV - 1), - kK * (kW - 1))
		h3:SetWidth(kJ)
		h3:SetHeight(kK)
		h3.texture = h3:CreateTexture(cd .. "Texture", 'OVERLAY', nil, 7)
		h3.texture:SetColorTexture(kU[1], kU[2], kU[3], 1)
		h3.texture:SetAllPoints()
		h3:SetFrameStrata("TOOLTIP")
		h3:SetScale(kQ())
		h3:SetFrameLevel(10000)
		tinsert(kS, h3)
		return h3
	end;
	local function kX(h3, jS)
		local kY = kM(jS)
		h3.texture:SetColorTexture(kY[1], kY[2], kY[3], 1)
	end;
	function AutoHelp.UISCALECHANGED()
		for _, h3 in ipairs(kS) do
			h3:SetScale(kQ())
		end
	end;
	local function kZ()
		AutoHelp.InfoPanel = kI()
		AutoHelp.CertFrame1 = kT("MyStart1", kM(20000), 1, 1)
		AutoHelp.ColorFrame = kT("MyColor", {
			0.2,
			0.2,
			0.2
		}, 1, 2)
		AutoHelp.MoveNoFrame = kT("MoveNoAction", {
			0.1,
			0.1,
			0.1
		}, 1, 3)
		AutoHelp.MoveActionFrame = kT("MoveAction", {
			0.1,
			0.1,
			0.1
		}, 1, 4)
		AutoHelp.MoveDelayFrame = kT("MyMove", {
			0.1,
			0.1,
			0.1
		}, 1, 5)
		AutoHelp.CertFrame2 = kT("MyCert1", kM(20001), 1, 6)
		AutoHelp.CertColorFrame = kT("ColorCert", kM(2016), 1, 7)
		ks()
	end;
	AutoHelp.OPTIONS_INIT = kZ;
	AutoHelp.ActionHasDone = true;
	function AutoHelp.ActionDone()
		AutoHelp.ActionHasDone = true
	end;
	AutoHelp.MoveHasDone = true;
	function AutoHelp.MoveDone()
		AutoHelp.MoveHasDone = true
	end;
	local k_ = 0;
	local function l0()
		k_ = k_ + 1;
		if k_ > 40 then
			k_ = 1
		end;
		return k_
	end;
	local l1 = - 1;
	local l2 = - 1;
	local l3 = - 1;
	local l4 = false;
	local function l5(l6, l7, action)
		if AutoHelp.ColorFrame == nil then
			return
		end;
		if not l6 or not l7 or not action then
			return
		end;
		if l3 ~= l6 or l1 ~= l7 or l2 ~= action then
			l3 = l6;
			l1 = l7;
			l2 = action;
			AutoHelp.ColorFrame.texture:SetColorTexture(0, 0, 0, 1)
			AutoHelp.ColorFrame.texture:SetColorTexture(l6 / 255, l7 / 255, action / 255, 1)
			local kU = kM(l6 + l7 + action)
			AutoHelp.CertColorFrame.texture:SetColorTexture(0, 0, 0, 1)
			AutoHelp.CertColorFrame.texture:SetColorTexture(kU[1], kU[2], kU[3], 1)
			AutoHelp.ActionHasDone = false;
			AutoHelp.MakePixelTime = GetTime()
		end
	end;
	AutoHelp.MakePixelSquare = l5;
	local l8 = 0;
	local function l9()
		l8 = l8 + 1;
		if l8 > 40 then
			l8 = 1
		end;
		return l8
	end;
	local la = - 1;
	local lb = - 1;
	local function lc(ld, le, lf)
		kX(AutoHelp.MoveDelayFrame, lf)
		kX(AutoHelp.MoveActionFrame, le)
		kX(AutoHelp.MoveNoFrame, ld)
		AutoHelp.MoveHasDone = false
	end;
	AutoHelp.MakeMovePixel = lc;
	function AutoHelp.TryMoveAction(p, lg)
		lg = lg or 0;
		local lh, action = AutoHelp.GetActionKey(p)
		if not action or not action["moveaction"] then
			return false
		end;
		local le = action["commandKey"]
		lc(l9(), le, lg)
	end;
	HEAL_RAID = {}
	HEAL_RAID_GUIDS = {}
	HEAL_RAID_HEALER = {}
	HEAL_RAID_HEALER_GUIDS = {}
	HEAL_BUTTONS = {}
	HEAL_RAID_TARGET_BUTTONS = {}
	HEAL_RAID_NAMES = {}
	HEAL_RAID_TANKS = {}
	HEAL_RAID_GROUPS = {}
	HEAL_RAID_ATTACKED_UNITS = {}
	HEAL_FORCE_RESET = false;
	HEAL_BLACKLIST = {}
	HEAL_SPELL_BLACKLIST = {}
	HEAL_SPELL_CASTID = nil;
	HEAL_ISASSISTING = false;
	HEAL_ATTACK_ERRORFACING = false;
	HEAL_ATTACK_ERRORFACING_TIME = nil;
	HEAL_PET_ISDEAD = false;
	HEAL_ATTACK_NOTBACK_TIME = nil;
	HEAL_ATTACK_OUTOFMANA_TIME = nil;
	HEAL_BOSS_UNITS = {}
	HEAL_PLAYER_TALENTS = {}
	for i = 1, MAX_BOSS_FRAMES do
		local li = format("boss%d", i)
		HEAL_BOSS_UNITS[li] = true
	end;
	HEAL_TIMERS = {
		["RELOAD_UI"] = 0,
		["RELOAD_PANEL"] = 0,
		["CREATESECURE"] = 0,
		["CHECK_PROFILES"] = 6.2,
		["RELOAD_ZONES"] = 3.45,
		["UPDATE_CLUSTERS"] = 0,
		["REFRESH_INSPECT"] = 2.1,
		["REFRESH_TOOLTIP"] = 2.3,
		["UPDATE_AGGRO"] = 0,
		["UPDATE_RANGE"] = 1.1,
		["UPDATE_HOTS"] = 0.25,
		["REFRESH_TARGETS"] = 0.51,
		["RELOAD_RAID"] = 0,
		["RELOAD_ROSTER"] = 0,
		["REFRESH_DRAG"] = 0.05,
		["MIRROR_TO_MACRO"] = 8,
		["REFRESH_CUDE_TOOLTIP"] = 1,
		["BLACK_LIST"] = 1,
		["BUFF_WATCH"] = 1,
		["HEAL_TARGET"] = 1,
		["AUTO_FOLLOW"] = 3,
		["AUTO_INTERRUPT"] = 0.2,
		["EQUIP_CHANGED"] = 0,
		["RECALC_HEALS"] = 0,
		["TEST_MOVE"] = 10,
		["WALK"] = 0.1,
		["MP2"] = 0,
		["英勇"] = 0,
		["取消英勇"] = 0,
		["TEST"] = 1,
		["双采切换"] = 5
	}
	local HEAL_TIMERS = HEAL_TIMERS;
	local aD = AutoHelp.LibHealComm and AutoHelp.LibHealComm.spellRankTableData or {}
	local lj = {}
	for aF, aG in pairs(aD) do
		for _, aH in pairs(aG) do
			lj[aH] = aF
		end
	end;
	AutoHelp.SpellIdToRank = lj;
	local lk = {}
	function AutoHelp.SetHealAmount(p, amount)
		lk[p] = amount
	end;
	function AutoHelp.GetHealAmount(p, tInfo)
		if not tInfo then
			return lk[p]
		end;
		if tInfo then
			local _, action = AutoHelp.GetActionKey(p)
			if not action or not action["spellId"] then
				return 0
			end;
			if tInfo then
				_, amount = AutoHelp.LibHealComm.CalculateHealing(nil, action["spellId"], tInfo["unit"])
			else
				_, amount = AutoHelp.LibHealComm.CalculateHealing(nil, action["spellId"])
			end;
			return amount
		end
	end;
	local function ll(cd)
		local action = AutoHelp.GetAction(cd)
		if not action then
			return nil, nil
		else
			return action["actionkey"], action
		end
	end;
	function IsInErrorFace()
		if HEAL_ATTACK_ERRORFACING then
			return GetTime() - HEAL_ATTACK_ERRORFACING_TIME <= 1
		end;
		return false
	end;
	AutoHelp.GetActionKey = ll;
	function AutoHelp.GetAction(cd)
        local action = AutoHelp.ACTIONKEY_NAMES[cd]
        -- for k, v in pairs(action) do
        --     print(k, v)
        -- end
        -- print(action['actionkey'])
		return AutoHelp.ACTIONKEY_NAMES[cd]
	end;
	function AutoHelp.HasActionKey(cd)
		return not not AutoHelp.ACTIONKEY_NAMES[cd]
	end;
	function AutoHelp.IsMovingAction(p)
		return not AutoHelp.GetAction(p)["stopMoving"]
	end;
	function AutoHelp.GetActionSpellName(cd)
		local action = AutoHelp.GetAction(cd)
		return action["spellName"] or ""
	end;
	function AutoHelp.GetActionCostMana(cd)
		local action = AutoHelp.GetAction(cd)
		return action["powerCost"] or 0
	end;
	local function lm(cx, x, tInfo)
		if jJ["HealTargetFrame"] then
			if tInfo then
				local a5 = "目标：" .. x;
				if tInfo["hp"] * 100 >= 60 then
					a5 = a5 .. "【\124cff00ff00" .. floor(tInfo["hp"] * 100) .. "%\124r】"
				else
					a5 = a5 .. "【\124cfff00000" .. floor(tInfo["hp"] * 100) .. "%\124r】"
				end;
				jJ["HealTargetFrame"]:SetText(a5)
				jJ["HealSpellFrame"]:SetText("法术：" .. cx)
			else
				local a5 = "目标：" .. x;
				jJ["HealTargetFrame"]:SetText(a5)
				jJ["HealSpellFrame"]:SetText("法术：" .. cx)
			end
		end
	end;
	AutoHelp.SetTipText = lm;
	local function ln(lo)
		if jJ["HealDebugFrame"] and lo then
			jJ["HealDebugFrame"]:SetText("提示：" .. (lo or "nil"))
		end
	end;
	AutoHelp.SetDebugText = ln;
	local function lp(cd)
		if jK["HealFollowFrame"] then
			if cd then
				jK["HEAL_STATUS_AUTOFOLLOW_BUTTON"]:SetText("跟随:" .. cd)
				jK["HealFollowFrame"]:SetText("跟随：" .. cd)
			else
				jK["HEAL_STATUS_AUTOFOLLOW_BUTTON"]:SetText("自动跟随")
				jK["HealFollowFrame"]:SetText("跟随：停止跟随")
			end
		end
	end;
	AutoHelp.SetFollowText = lp;
	local function lq()
		if jK["HealStatFrame"] then
			if AutoHelp.HealStat.totalHeal == 0 then
				jK["HealStatFrame"]:SetText("过量比例: -")
			else
				jK["HealStatFrame"]:SetText("过量比例:" .. ceil(AutoHelp.HealStat.overHeal / AutoHelp.HealStat.totalHeal * 100) .. "%")
			end
		end
	end;
	AutoHelp.RefreshHealStat = lq;
	local function lr(jS, ls)
		local lt = ""
		local b7 = tostring(jS)
		local lu = string.len(b7)
		if ls == nil then
			ls = ","
		end;
		ls = tostring(ls)
		for i = 1, lu do
			lt = string.char(string.byte(b7, lu + 1 - i)) .. lt;
			if Modulo(i, 3) == 0 then
				if lu - i ~= 0 then
					lt = "," .. lt
				end
			end
		end;
		return lt
	end;
	local function lv(self, jN)
		local a5 = "\124cff00ff00\n总施法：" .. AutoHelp.HealStat.spellNum .. "，暴击：" .. AutoHelp.HealStat.critNum;
		if AutoHelp.HealStat.spellNum == 0 then
			a5 = a5 .. "，暴击率：-，过量：-\n"
		else
			a5 = a5 .. "，暴击：" .. ceil(AutoHelp.HealStat.critNum / AutoHelp.HealStat.spellNum * 100) .. "%，过量："
			a5 = a5 .. ceil(AutoHelp.HealStat.overHeal / AutoHelp.HealStat.totalHeal * 100) .. "%\n"
		end;
		a5 = a5 .. "总治疗量：" .. lr(AutoHelp.HealStat.totalHeal, ",") .. "\n"
		a5 = a5 .. "有效治疗：" .. lr(AutoHelp.HealStat.totalHeal - AutoHelp.HealStat.overHeal, ",") .. "\n"
		a5 = a5 .. "过量治疗：" .. lr(AutoHelp.HealStat.overHeal, ",") .. "\n\n"
		a5 = a5 .. "战斗施法：" .. AutoHelp.HealStat.combatSpellNum .. "，暴击：" .. AutoHelp.HealStat.combatCritNum;
		if AutoHelp.HealStat.combatSpellNum == 0 then
			a5 = a5 .. "，暴击率：-  ，过量：-\n"
		else
			a5 = a5 .. "暴击：" .. ceil(AutoHelp.HealStat.combatCritNum / AutoHelp.HealStat.combatSpellNum * 100) .. "%，过量："
			a5 = a5 .. ceil(AutoHelp.HealStat.combatOverHeal / AutoHelp.HealStat.combatTotalHeal * 100) .. "%\n"
		end;
		a5 = a5 .. "战斗治疗：" .. lr(AutoHelp.HealStat.combatTotalHeal, ",") .. "\n"
		a5 = a5 .. "有效治疗：" .. lr(AutoHelp.HealStat.combatTotalHeal - AutoHelp.HealStat.combatOverHeal, ",") .. "\n"
		a5 = a5 .. "过量治疗：" .. lr(AutoHelp.HealStat.combatOverHeal, ",") .. "\n"
		a5 = a5 .. "\124r\124cfff00000打断次数：" .. lr(AutoHelp.HealStat.interruptNum, ",") .. "\124r\n"
		GameTooltip:SetOwner(self)
		GameTooltip:SetText("治疗统计显示")
		GameTooltip:AddLine(tostring(a5), 1, 1, 1)
		GameTooltip:Show()
	end;
	AutoHelp.OnShowHealStats = lv;
	AutoHelp.castinfo = {}
	function AutoHelp.StopAction()
		if not AutoHelp.castinfo.spellName then
			return
		end;
		local lh = AutoHelp.GetActionKey("KEY_STOPCAST")
		if l2 ~= lh then
			HEAL_TIMERS["HEAL_TARGET"] = 0.1;
			l5(l0(), 1, lh)
			if AutoHelp.castinfo.targetInfo then
				lm("停止施法 " .. AutoHelp.castinfo.spellName, AutoHelp.castinfo.targetInfo["name"])
			else
				lm("停止施法 " .. AutoHelp.castinfo.spellName, "无")
			end
		end
	end;
	function BuildUnitInfo(b8)
		if not UnitExists(b8) then
			return nil
		end;
		local tInfo = {}
		local lw, lx = UnitName(b8)
		tInfo["unit"] = b8;
		tInfo["healthmax"] = UnitHealthMax(b8)
		tInfo["health"] = UnitHealth(b8)
		tInfo["name"] = lw;
		tInfo["level"] = UnitLevel(b8)
		tInfo["factoin"] = UnitFactionGroup(b8)
		tInfo["className"], tInfo["class"], tInfo["classId"] = UnitClass(b8)
		tInfo["powertype"] = UnitPowerType(b8)
		tInfo["power"] = UnitPower(b8)
		tInfo["previousPower"] = tInfo["power"]
		tInfo["powermax"] = UnitPowerMax(b8)
		tInfo["dead"] = UnitIsDeadOrGhost(b8) and not UnitIsFeignDeath(b8)
		tInfo["FeignDeath"] = tFeignDeath;
		tInfo["charmed"] = UnitIsCharmed(b8) and UnitCanAttack("player", b8)
		tInfo["fullName"] = (lx or "") ~= "" and lw .. "-" .. lx or lw;
		tInfo["raidIcon"] = GetRaidTargetIndex(b8)
		tInfo["visible"] = UnitIsVisible(b8)
		tInfo["baseRange"] = UnitInRange(b8) or "player" == b8;
		tInfo["hasDebuff"] = false;
		tInfo["hp"] = tInfo["health"] / tInfo["healthmax"]
		tInfo["mp"] = tInfo["power"] / tInfo["powermax"]
		tInfo["lost"] = tInfo["healthmax"] - tInfo["health"]
		tInfo["afk"] = UnitIsAFK(b8)
		tInfo["connected"] = UnitIsConnected(b8)
		tInfo["guid"] = UnitGUID(b8)
		tInfo["isFriend"] = UnitCanAssist("player", b8)
		tInfo["canAttack"] = UnitCanAttack("player", b8)
		tInfo["targetKey"] = 1;
		return tInfo
	end;
	local function ly(tInfo, p, lz)
		local lh, action = AutoHelp.GetActionKey(p)
		if lh == 0 or action == nil then
			AutoHelp.DoActionIdle("错误的动作ID:" .. p, "错误的动作ID:" .. p)
			return
		end;
		if action["comkey"] then
			if InCombatLockdown() then
				AutoHelp.DoActionIdle("战斗状态错误的动作ID:" .. p, "战斗状态错误的动作ID:" .. p)
				return
			end;
			local k8 = action["actionbutton"]
			if action["target"] and not AutoHelp.ChangeHealTarget then
				k8:SetAttribute("macrotext", action["macro"] .. "\n/targetlasttarget\n/cleartarget\n/targetlasttarget")
			else
				k8:SetAttribute("macrotext", action["macro"])
			end
		end;
		local lA = action["spellTime"]
		local cx = action["spellName"]
		local lB = action["desc"]
		if lA > 0 then
			HEAL_TIMERS["HEAL_TARGET"] = lA
		else
			HEAL_TIMERS["HEAL_TARGET"] = 1
		end;
		if tInfo == "target" then
			tInfo = BuildUnitInfo(tInfo)
			lz = tInfo["health"]
		end;
		if not tInfo then
			return
		end;
		local l7 = tInfo["targetKey"]
		l5(l0(), l7, lh)
		if lz then
			lm(lB .. " 【\124cfff00000" .. lz .. "\124r】", tInfo["name"], tInfo)
		else
			lm(lB, tInfo["name"], tInfo)
		end
	end;
	AutoHelp.doAction = ly;
	local function lC(lD)
		local l7 = lD["targetKey"]
		l5(l0(), l7, 99)
		HEAL_TIMERS["HEAL_TARGET"] = 0.2;
		AutoHelp.SetTipText("选择目标", lD["name"], lD)
		AutoHelp.SetDebugText("选择目标")
	end;
	AutoHelp.targetAction = lC;
	local function lE(lF, l7)
		lm(lF, l7)
		l5(0, 0, 0)
		if UnitAffectingCombat("player") then
			HEAL_TIMERS["HEAL_TARGET"] = 0.05
		elseif AutoHelp.AssistUnit then
			HEAL_TIMERS["HEAL_TARGET"] = 0.1
		else
			HEAL_TIMERS["HEAL_TARGET"] = 0.5
		end;
		AutoHelp.SetDebugText("无模块启动，等待中")
	end;
	AutoHelp.DoActionIdle = lE;
	local function lG(b8, p)
		local lh, action = AutoHelp.GetActionKey(p)
		if not lh or lh == 0 or not action or not b8 then
			return false
		end;
		if action["comkey"] and InCombatLockdown() then
			return false
		end;
		if action["auraByPlayer"] then
			if action["debuffName"] and AutoHelp.UnitHasDebuffByPlayer(b8, action["debuffName"]) then
				return false
			end;
			if action["auraName"] and AutoHelp.UnitHasBuffByPlayer(b8, action["auraName"]) then
				return false
			end
		else
			if action["debuffName"] and AutoHelp.UnitHasDebuff(b8, action["debuffName"]) then
				return false
			end;
			if action["auraName"] and AutoHelp.UnitHasBuff(b8, action["auraName"]) then
				return false
			end
		end;
		if action["itemId"] then
			if AutoHelp.GetItemCount(action["itemId"]) > 0 and AutoHelp.IsItemCooldown(action["itemId"]) then
				return true
			end
		elseif action["spellId"] then
			local cx = action["spellName"]
			local lH, lI = IsUsableSpell(cx)
			local lJ, cn, eF = GetSpellCooldown(cx)
			if lH and not lI and cn == 0 and eF == 1 and canSpellRange(cx, b8) then
				return true
			end
		else
			return true
		end
	end;
	function AutoHelp.CanCastSpell(b8, p)
		return lG(b8, p)
	end;
	function AutoHelp.HasSpell(cx)
		local lH, lI = IsUsableSpell(cx)
		return lH
	end;
	function AutoHelp.IsSpellCooldown(cx)
		local lJ, cn, eF = GetSpellCooldown(cx)
		if cn == 0 and eF == 1 then
			return true
		end;
		return false
	end;
	function AutoHelp.IsItemCooldown(kq)
		local bv, cn, lK = GetItemCooldown(kq)
		return cn == 0 and lK == 1
	end;
	function GetSpellCooldownTime(cx)
		local lJ, cn, eF = GetSpellCooldown(cx)
		if cn == 0 and eF == 1 then
			return 0
		end;
		if cn and cn > 0 then
			local lL = lJ + cn - GetTime()
			if AutoHelp.UseSpellQueueWindow then
				lL = lL - AutoHelp.SpellQueueWindow
			end;
			if lL <= 0 then
				return 0
			else
				return lL
			end
		end;
		return 9999
	end;
	AutoHelp.GetSpellCooldownTime = GetSpellCooldownTime;
	local function lM(lN)
		local min = GetTime()
		local lO, lP = UnitAttackSpeed("player")
		if lP then
			return
		end;
		HEAL_LAST_ATTACKING = GetTime() + lO
	end;
	AutoHelp.HEAL_OnAttack = lM;
	local function lQ()
		if HEAL_LAST_ATTACKING == nil then
			return false
		end;
		if HEAL_LAST_ATTACKING >= GetTime() then
			return true
		end;
		HEAL_LAST_ATTACKING = nil;
		return false
	end;
	AutoHelp.IsAttacking = lQ;
	local function lR(tInfo)
		return tInfo and not HEAL_IsBlackList(tInfo["unit"]) and tInfo["connected"] and not tInfo["dead"] and not tInfo["FeignDeath"] and not (UnitIsCharmed(tInfo["unit"]) and UnitCanAttack("player", tInfo["unit"]))
	end;
	AutoHelp.CanActionUnit = lR;
	function AutoHelp.GetSpellInfo(ca)
		local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(ca)
		if not lV then
			AutoHelp.Debug("\124ffff0000Invalid call to GetSpellInfo for spellID: \124r" .. ca)
			return nil
		else
			return cd, lS, lT, lU, ib, iG, lV
		end
	end;
	function AutoHelp.GetSpellName(ca)
		return AutoHelp.GetSpellInfo(ca) or ""
	end;
	local lW = {}
	if not AutoHelp.Debug then
		local function lX(a1, lY)
			SendChatMessage(a1, "WHISPER", DEFAULT_CHAT_FRAME.language, lY)
		end;
		AutoHelp.SendWhisper = lX;
		local function lZ(a1, l_, x)
			if a1 == nil then
				a1 = "nil msg"
			end;
			if l_ then
				SendChatMessage(a1, l_, DEFAULT_CHAT_FRAME.language, x)
				return
			end;
			DEFAULT_CHAT_FRAME:AddMessage("\124c0000ffff" .. a1)
			table.insert(lW, a1)
		end;
		AutoHelp.SendChatMsg = lZ;
		local function m0(a1)
			AutoHelp.SendChatMsg(a1)
		end;
		AutoHelp.Debug = m0;
		function AutoHelp.SaveDebug()
			SetConfig("DEBUGS", lW)
			print("Debugs saved.")
		end;
		local m1;
		local function m2(a1, tInfo)
			if m1 ~= a1 then
				m1 = a1;
				AutoHelp.SendChatMsg(a1)
			end
		end;
		AutoHelp.Info = m2;
		local function m3(a1)
			if a1 then
				AutoHelp.SendChatMsg(a1)
			end
		end;
		AutoHelp.Info2 = m3;
		local function m4(a1)
			DEFAULT_CHAT_FRAME:AddMessage(a1)
		end;
		AutoHelp.Log = m4;
		local function m5(a1)
			AutoHelp.Log("\124cff0000ff" .. a1 .. "\124r")
			AutoHelp.Log(a1)
			AutoHelp.Log(debugstack())
		end;
		AutoHelp.Error = m5
	end;
	function Modulo(m6, m7)
		return m6 - math.floor(m6 / m7) * m7
	end;
	function AutoHelp.GetItemInfo(kq)
		return GetItemInfo(kq)
	end;
	function AutoHelp.GetItemCount(kq)
		return GetItemCount(kq)
	end;
	function AutoHelp.FindBagFreeSpace()
		local m8;
		for i = 4, 0, - 1 do
			for m9 = 1, GetContainerNumSlots(i) do
				if not GetContainerItemLink(i, m9) then
					return i, m9
				end
			end
		end
	end;
	function AutoHelp.FindBagItem(cd)
		for i = 0, 4 do
			for m9 = 1, GetContainerNumSlots(i) do
				if string.find(GetContainerItemLink(i, m9) or "", cd, 1, 1) then
					return i, m9
				end
			end
		end
	end;
	function AutoHelp.EquipByName(cd, ma)
		local cp, js = AutoHelp.FindBagItem(cd)
		local mb, mc = AutoHelp.FindBagFreeSpace()
		if cp and mb then
			PickupInventoryItem(ma)
			PickupContainerItem(mb, mc)
			PickupContainerItem(cp, js)
			EquipCursorItem(ma)
		end
	end;
	function AutoHelp.GetMainHandEquipments()
		local md = {}
		local _, _, eL, _ = string.find(GetInventoryItemLink("player", 16) or "", "item:(%d+).+%[(.+)%]")
		local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm = GetItemInfo(eL or "")
		if me then
			md[# md + 1] = {
				itemName = me,
				itemId = eL,
				itemIcon = mm,
				itemLevel = mg
			}
		end;
		for i = 0, 4 do
			for m9 = 1, GetContainerNumSlots(i) do
				itemLink = GetContainerItemLink(i, m9)
				if itemLink then
					local _, _, eL, _ = string.find(GetContainerItemLink(i, m9) or "", "item:(%d+).+%[(.+)%]")
					local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm = GetItemInfo(eL or "")
					if ml == "INVTYPE_WEAPONMAINHAND" or ml == "INVTYPE_WEAPON" then
						md[# md + 1] = {
							itemName = me,
							itemId = eL,
							itemIcon = mm,
							itemLevel = mg
						}
					end
				end
			end
		end;
		return md
	end;
	function AutoHelp.GetOffHandEquipments()
		local md = {}
		local _, _, eL, _ = string.find(GetInventoryItemLink("player", 17) or "", "item:(%d+).+%[(.+)%]")
		local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm = GetItemInfo(eL or "")
		if me then
			md[# md + 1] = {
				itemName = me,
				itemId = eL,
				itemIcon = mm,
				itemLevel = mg
			}
		end;
		for i = 0, 4 do
			for m9 = 1, GetContainerNumSlots(i) do
				itemLink = GetContainerItemLink(i, m9)
				if itemLink then
					local _, _, eL, _ = string.find(GetContainerItemLink(i, m9) or "", "item:(%d+).+%[(.+)%]")
					local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm = GetItemInfo(eL or "")
					if ml == "INVTYPE_SHIELD" or ml == "INVTYPE_2HWEAPON" or ml == "INVTYPE_WEAPON" then
						md[# md + 1] = {
							itemName = me,
							itemId = eL,
							itemIcon = mm,
							itemLevel = mg
						}
					end
				end
			end
		end;
		return md
	end;
	function AutoHelp.MainHandIsWeapon()
		local _, _, eL, _ = string.find(GetInventoryItemLink("player", 16) or "", "item:(%d+).+%[(.+)%]")
		local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm = GetItemInfo(eL or "")
		if me and (mi == "武器" or mi == "Weapon") then
			return true
		end;
		return false
	end;
	function AutoHelp.OffHandIsWeapon()
		local _, _, eL, _ = string.find(GetInventoryItemLink("player", 17) or "", "item:(%d+).+%[(.+)%]")
		local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm = GetItemInfo(eL or "")
		if me and (mi == "武器" or mi == "Weapon") then
			return true
		end;
		return false
	end;
	function AutoHelp.GetAllBagsFoods()
		local md = {}
		for i = 0, 4 do
			for m9 = 1, GetContainerNumSlots(i) do
				itemLink = GetContainerItemLink(i, m9)
				if itemLink then
					local _, _, eL, _ = string.find(GetContainerItemLink(i, m9) or "", "item:(%d+).+%[(.+)%]")
					local me, itemLink, mf, mg, mh, mi, mj, mk, ml, mm, mn, mo, mp = GetItemInfo(eL or "")
					if mo == 0 and mp == 0 and not Contains(me, "药水") and not Contains(me, "药剂") and not Contains(me, "绷带") then
						md[me] = eL
					end
				end
			end
		end;
		return md
	end;
	AutoHelp.Equipment10 = nil;
	AutoHelp.Equipment13 = nil;
	AutoHelp.Equipment14 = nil;
	AutoHelp.Equipment4 = nil;
	AutoHelp.UseEquipmentMacro = nil;
	function AutoHelp.GetUsableEquipmentsMacro()
		local mq = ""
		for i = 1, 18 do
			local lJ, cn, lK = GetInventoryItemCooldown("player", i)
			if lK == 1 then
				local cd = GetItemInfo(GetInventoryItemLink("player", i))
				if i == 10 then
					AutoHelp.Equipment10 = true;
					AutoHelp.UseEquipmentMacro = AutoHelp.UseEquipmentMacro .. "\n/use 13"
				end;
				if i == 13 then
					AutoHelp.Equipment13 = true;
					AutoHelp.UseEquipmentMacro = AutoHelp.UseEquipmentMacro .. "\n/use 13"
				end;
				if i == 14 then
					AutoHelp.Equipment13 = true;
					AutoHelp.UseEquipmentMacro = AutoHelp.UseEquipmentMacro .. "\n/use 14"
				end;
				if i == 4 then
					AutoHelp.Equipment4 = true;
					AutoHelp.UseEquipmentMacro = AutoHelp.UseEquipmentMacro .. "\n/use 4"
				end
			end
		end;
		if AutoHelp.UseEquipmentMacro ~= "" then
			AutoHelp.UseEquipmentMacro = USESP_MACRO_PRE .. USESP_MACRO_PRE .. USESP_MACRO_AFTER
		end
	end;
	function AutoHelp.CanUseSP()
		local lJ, cn, lK;
		lJ, cn, lK = GetInventoryItemCooldown("player", 10)
		if lK == 1 and lJ == 0 then
			return 10
		end;
		lJ, cn, lK = GetInventoryItemCooldown("player", 13)
		if lK == 1 and lJ == 0 then
			return 13
		end;
		lJ, cn, lK = GetInventoryItemCooldown("player", 14)
		if lK == 1 and lJ == 0 then
			return 14
		end;
		if AutoHelp.isWotlk then
			local _, mr, ms = UnitRace("player")
			if AutoHelp.playerRaceId == 2 then
				local lJ, cn, eF = GetSpellCooldown(20572)
				if cn == 0 and eF == 1 then
					return 1
				end
			elseif AutoHelp.playerRaceId == 8 then
				local lJ, cn, eF = GetSpellCooldown(26297)
				if cn == 0 and eF == 1 then
					return 1
				end
			end
		end;
		return 0
	end;
	function AutoHelp.CanYaodaiBomb()
		local lJ, cn, lK;
		lJ, cn, lK = GetInventoryItemCooldown("player", 6)
		if lK == 1 and lJ == 0 then
			return true
		end;
		return false
	end;
	function AutoHelp.GetPlayerTalent()
		local b2 = {}
		for eH = 1, GetNumTalentTabs() do
			local jS = 0;
			for i = 1, GetNumTalents(eH) do
				local cd, _, _, _, eI = GetTalentInfo(eH, i)
				if cd then
					jS = jS + eI;
					b2[cd] = eI
				end
			end;
			b2[eH] = jS
		end;
		return b2
	end;
	function GetTalentSpent(cd)
		local cx = cd;
		if type(cd) == "number" then
			cx = GetSpellInfo(cd)
		end;
		if cx then
			return AutoHelp.HEAL_PLAYER_TALENTS[cx] or 0
		end;
		return 0
	end;
	function battleQueueStatus()
		local mt, mu, gs, mv, mw, mx, my = GetBattlefieldStatus(1)
		local mz = 0;
		if mt == "none" then
			mz = 0
		elseif mt == "queued" then
			mz = 1
		elseif mt == "confirm" then
			mz = 2
		elseif mt == "active" then
			mz = 3
		end;
		return mz
	end;
	function AutoHelp.TryUseCritAction(tInfo, mA, mB, ak, mC)
		local mD = AutoHelp.TryUseAction(tInfo, mA)
		mC = mC or false;
		ak = ak or 0;
		if mD then
			AutoHelp.AddNextAction(tInfo, mB, ak, mC)
			return mD
		else
			return AutoHelp.TryUseAction(tInfo, mB, ak, mC)
		end
	end;
	function AutoHelp.UseMoveAction(p, lg)
		local lh, action = AutoHelp.GetActionKey(p)
		if not action or not action["moveaction"] then
			return false
		end;
		local l7 = action["commandKey"]
		local kY = kM(lg)
		AutoHelp.MoveFrame.texture:SetColorTexture(kY[1], kY[2], kY[3], 1)
		l5(l0(), l7, 1)
	end;
	local mE;
	local mF;
	local function mG(p)
		local mH = HEAL_RAID["player"]
	end;
	local function mI(mJ)
		if not mJ or type(mJ) ~= "table" then
			return false
		end;
		for _, mK in pairs(mJ) do
			local lJ, cn, eF = GetSpellCooldown(mK)
			if cn == 0 and eF == 1 then
				return true
			end
		end;
		return false
	end;
	AutoHelp.CanUseCrits = mI;
	function AutoHelp.TryUseAction(tInfo, p)
		local lh, action = AutoHelp.GetActionKey(p)
		if not action then
			return false
		end;
		if not AutoHelp.CanUseAction(tInfo, p) then
			return false
		end;
		local mL = false;
		if action["sp"] then
			if AutoHelp.CanUseSP() > 0 or mI(action["critSpells"]) then
				local mH = HEAL_RAID["player"]
				local mM = mH["Auras"][57723] or mH["Auras"][57724]
				local mN = mH["Auras"][32182] or mH["Auras"][2825]
				local mO = GetStatus("STATUS_爆发嗜血") and (mN or mM and not mN) or GetStatus("STATUS_爆发自动")
				if mO and UnitLevel("target") == - 1 then
					lh, action = AutoHelp.GetActionKey(p .. "饰品爆发")
					mL = true
				end
			end
		end;
		if AutoHelp.isWotlk then
			if not mL and action["ys"] and not GetCombatValue("usedyaosui") then
				if InCombatLockdown() and GetStatus("STATUS_爆发喝药") and UnitLevel("target") == - 1 then
					local mH = HEAL_RAID["player"]
					local mN = mH["Auras"][32182] or mH["Auras"][2825]
					if mN then
						local mP = AutoHelp.GetItemCount(40211) > 0 and AutoHelp.IsItemCooldown(40211)
						local mQ = AutoHelp.GetItemCount(40212) > 0 and AutoHelp.IsItemCooldown(40212)
						local mR = AutoHelp.GetItemCount(40093) > 0 and AutoHelp.IsItemCooldown(40093)
						if action["ys"] == 1 and mP or action["ys"] == 3 and (mP or mR) or action["ys"] == 2 and (mQ or mP) then
							lh, action = AutoHelp.GetActionKey(p .. "药水爆发")
							mL = true;
							SetCombatValue("usedyaosui", true)
						end
					end
				end
			end;
			if not mL and action["bomb"] then
				if UnitLevel("target") == - 1 and GetStatus("STATUS_自动炸弹") and AutoHelp.GetItemCount(41119) > 0 and AutoHelp.IsItemCooldown(41119) then
					lh, action = AutoHelp.GetActionKey(p .. "邪铁炸弹")
				elseif AutoHelp.CanYaodaiBomb() then
					lh, action = AutoHelp.GetActionKey(p .. "腰带炸弹")
				end
			end
		end;
		if action["comkey"] then
			if InCombatLockdown() then
				AutoHelp.Debug("战斗状态错误的动作ID:" .. p)
				return false
			end;
			if p == "KEY_DRINKING" and mE and action["LastUsableId"] ~= mE then
				action["desc"] = GetItemInfo(mE)
				action["spellName"] = GetItemInfo(mE)
				action["macro"] = "/use " .. GetItemInfo(mE)
				action["spellTime"] = 5;
				action["LastUsableId"] = mE;
				if AutoHelp.RefreshAction then
					AutoHelp.RefreshAction(action)
				end
			end;
			if p == "KEY_EATING" and mF and action["LastUsableId"] ~= mF then
				action["desc"] = GetItemInfo(mF)
				action["spellName"] = GetItemInfo(mF)
				action["macro"] = "/use " .. GetItemInfo(mF)
				action["spellTime"] = 5;
				action["LastUsableId"] = mF;
				if AutoHelp.RefreshAction then
					AutoHelp.RefreshAction(action)
				end
			end;
			if p == "吃喝" and (action["LastUsableWaterId"] ~= mE or action["LastUsableFoodId"] ~= mF) then
				action["desc"] = GetItemInfo(mF)
				action["spellName"] = GetItemInfo(mF)
				action["macro"] = "/use " .. GetItemInfo(mE) .. "\n/use " .. GetItemInfo(mF)
				action["spellTime"] = 5;
				action["LastUsableWaterId"] = mE;
				action["LastUsableFoodId"] = mF;
				if AutoHelp.RefreshAction then
					AutoHelp.RefreshAction(action)
				end
			end
		end;
		if action["spellTime"] > 0 then
			HEAL_TIMERS["HEAL_TARGET"] = action["spellTime"]
		else
			HEAL_TIMERS["HEAL_TARGET"] = 1
		end;
		if AutoHelp.IsDrinking() or AutoHelp.IsEating() then
			DoEmote("stand")
		end;
		if action["command"] or action["wowaction"] then
			l5(l0(), 99, action["commandKey"])
		else
			l5(l0(), tInfo["targetKey"], lh)
		end;
		local mS, mT = getHealthLost(tInfo)
		local bN = action["baseHealAmount"]
		local lB = action["desc"]
		if bN and mS > 0 then
			lm(lB .. " 【\124cfff00000" .. - mS .. "/\124cff00ff00+" .. bN .. "\124r】", tInfo["name"], tInfo)
		else
			lm(lB, tInfo["name"], tInfo)
		end;
		AutoHelp.SavedLastAction = action;
		AutoHelp.SavedLastTime = GetTime()
		AutoHelp.LastAction = action;
		AutoHelp.LastTarget = tInfo;
		AutoHelp.LastDesc = lB;
		AutoHelp.LastTime = GetTime()
		AutoHelp.BotAction = true;
		return true
	end;
	function AutoHelp.CanUseAction(tInfo, p)
		local lh, action = AutoHelp.GetActionKey(p)
		if not action then
			return false
		end;
		if not tInfo or not ("player" == tInfo["unit"] or "target" == tInfo["unit"] or "mouseover" == tInfo["unit"] or "targettarget" == tInfo["unit"] or UnitInRange(tInfo["unit"])) then
			return false
		end;
		if UnitHasVehicleUI(tInfo["unit"]) or not UnitExists(tInfo["unit"]) or not UnitIsVisible(tInfo["unit"]) then
			return false
		end;
		if action["command"] or action["wowaction"] then
			return true
		end;
		if action["pet"] then
			if not UnitExists("pet") or UnitIsDead("pet") or IsSpellInRange(action["spellName"], "pet") ~= 1 then
				return false
			end
		end;
		if HEAL_IsBlackList(tInfo["unit"]) or not tInfo["connected"] or tInfo["FeignDeath"] or UnitIsCharmed(tInfo["unit"]) and UnitCanAttack("player", tInfo["unit"]) or UnitInVehicle(tInfo["unit"]) and UnitHasVehicleUI(tInfo["unit"]) then
			return false
		end;
		if p ~= AutoHelp.RESCURIT_KEY and tInfo["dead"] or p == RESCURIT_KEY and not tInfo["dead"] then
			return false
		end;
		if action["stopMoving"] and AutoHelp.IsMoving then
			local mU = AutoHelp.CanMoveSpell and AutoHelp.CanMoveSpell(tInfo, p)
			if not mU then
				return false
			end
		end;
		if action["comkey"] and InCombatLockdown() then
			return false
		end;
		if p == "KEY_DRINKING" then
			local mV = jy("USEWATER")
			if not mV or GetItemCount(mV) == 0 or not IsUsableItem(mV) then
				mV = AutoHelp.GetUsableWater()
			end;
			if mV and AutoHelp.GetItemCount(mV) > 0 and AutoHelp.IsItemCooldown(mV) then
				mE = mV;
				if not AutoHelp.UnitHasBuff(tInfo["unit"], GetItemSpell(mE)) then
					return true
				end
			end;
			return false
		elseif p == "KEY_EATING" then
			local mW = jy("USEFOOD")
			if not mW or GetItemCount(mW) == 0 or not IsUsableItem(mW) then
				mW = AutoHelp.GetUsableFood()
			end;
			if mW and AutoHelp.GetItemCount(mW) > 0 and AutoHelp.IsItemCooldown(mW) then
				mF = mW;
				if not AutoHelp.UnitHasBuff(tInfo["unit"], GetItemSpell(mF)) then
					return true
				end
			end;
			return false
		elseif p == "吃喝" then
			local mV = jy("USEWATER")
			if not mV or GetItemCount(mV) == 0 or not IsUsableItem(mV) then
				mV = AutoHelp.GetUsableWater()
			end;
			local mW = jy("USEFOOD")
			if not mW or GetItemCount(mW) == 0 or not IsUsableItem(mW) then
				mW = AutoHelp.GetUsableFood()
			end;
			if mV and AutoHelp.GetItemCount(mV) > 0 and AutoHelp.IsItemCooldown(mV) then
				mE = mV
			end;
			if mW and AutoHelp.GetItemCount(mW) > 0 and AutoHelp.IsItemCooldown(mW) then
				mF = mW
			end;
			if mE and mF then
				return true
			end;
			return false
		end;
		if action["debuffName"] or action["auraName"] or not action["fastSpell"] then
			if AutoHelp.IsCastingSpell(p) then
				return false
			end
		end;
		if action["delayTime"] and AutoHelp.SavedLastAction then
			if AutoHelp.SavedLastAction["name"] == action["name"] and GetTime() - AutoHelp.SavedLastTime < action["delayTime"] then
				return false
			end
		end;
		if action["debuffName"] then
			local b8 = tInfo["unit"]
			local lL = AutoHelp.GetDebuffRemainTime(b8, action["debuffName"], action["debuffByPlayer"])
			local jS = AutoHelp.GetUnitDebuffNum(b8, action["debuffName"])
			if action["debuffNum"] and action["debuffRT"] then
				if jS >= action["debuffNum"] and lL >= action["debuffRT"] then
					return false
				end
			end;
			if action["debuffRT"] and not action["debuffNum"] then
				if lL >= action["debuffRT"] then
					return false
				end
			end;
			if action["debuffNum"] and not action["debuffRT"] then
				if jS >= action["debuffNum"] then
					return false
				end
			end;
			if not action["debuffRT"] and not action["debuffNum"] then
				if action["debuffByPlayer"] then
					if type(action["debuffName"]) == "number" and AutoHelp.UnitHasDebuffByPlayer(b8, action["debuffName"]) or type(action["debuffName"]) == "table" and AutoHelp.UnitHasDebuffByPlayer(b8, unpack(action["debuffName"])) or type(action["debuffName"]) == "string" and AutoHelp.UnitHasDebuffByPlayer(b8, strsplit(" ", action["debuffName"])) then
						return false
					end
				else
					if type(action["debuffName"]) == "number" and AutoHelp.UnitHasDebuff(b8, action["debuffName"]) or type(action["debuffName"]) == "table" and AutoHelp.UnitHasDebuff(b8, unpack(action["debuffName"])) or type(action["debuffName"]) == "string" and AutoHelp.UnitHasDebuff(b8, strsplit(" ", action["debuffName"])) then
						return false
					end
				end
			end
		end;
		if action["auraName"] then
			local lL = AutoHelp.GetBuffRemainTime(tInfo["unit"], action["auraName"], action["auraByPlayer"])
			local jS = AutoHelp.GetUnitBuffNum(tInfo["unit"], action["auraName"])
			if action["auraRT"] and action["auraNum"] then
				if jS >= action["auraNum"] and lL >= action["auraRT"] then
					return false
				end
			end;
			if action["auraRT"] and not action["auraNum"] then
				if lL >= action["auraRT"] then
					return false
				end
			end;
			if action["auraNum"] and not action["auraRT"] then
				if jS >= action["auraNum"] then
					return false
				end
			end;
			if not action["auraRT"] and not action["auraNum"] then
				if action["auraByPlayer"] then
					if type(action["auraName"]) == "number" and AutoHelp.UnitHasBuffByPlayer(tInfo["unit"], action["auraName"]) or type(action["auraName"]) == "table" and AutoHelp.UnitHasBuffByPlayer(tInfo["unit"], unpack(action["auraName"])) or type(action["auraName"]) == "string" and AutoHelp.UnitHasBuffByPlayer(tInfo["unit"], strsplit(" ", action["auraName"])) then
						return false
					end
				else
					if type(action["auraName"]) == "number" and AutoHelp.UnitHasBuff(tInfo["unit"], action["auraName"]) or type(action["auraName"]) == "table" and AutoHelp.UnitHasBuff(tInfo["unit"], unpack(action["auraName"])) or type(action["auraName"]) == "string" and AutoHelp.UnitHasBuff(tInfo["unit"], strsplit(" ", action["auraName"])) then
						return false
					end
				end
			end
		end;
		if action["needAuraId"] then
			if not (type(action["needAuraId"]) == "number" and AutoHelp.UnitHasBuff(tInfo["unit"], action["needAuraId"]) or type(action["needAuraId"]) == "table" and AutoHelp.UnitHasBuff(tInfo["unit"], unpack(action["needAuraId"])) or type(action["needAuraId"]) == "string" and AutoHelp.UnitHasBuff(tInfo["unit"], strsplit(" ", action["needAuraId"]))) then
				return false
			end
		end;
		if action["needPlayerAura"] then
			if not (type(action["needPlayerAura"]) == "number" and AutoHelp.UnitHasBuff("player", action["needAuraId"]) or type(action["needAuraId"]) == "table" and AutoHelp.UnitHasBuff("player", unpack(action["needAuraId"])) or type(action["needAuraId"]) == "string" and AutoHelp.UnitHasBuff("player", strsplit(" ", action["needAuraId"]))) then
				return false
			end
		end;
		if action["needDebuffId"] then
			if not (type(action["needDebuffId"]) == "number" and AutoHelp.UnitHasDebuff(tInfo["unit"], action["needDebuffId"]) or type(action["needDebuffId"]) == "table" and AutoHelp.UnitHasDebuff(tInfo["unit"], unpack(action["needDebuffId"])) or type(action["needDebuffId"]) == "string" and AutoHelp.UnitHasDebuff(tInfo["unit"], strsplit(" ", action["needDebuffId"]))) then
				return false
			end
		end;
		if action["stance"] then
			local mX = GetShapeshiftForm()
			local ex = false;
			for _, mY in pairs(action["stance"]) do
				if mY == mX then
					ex = true;
					break
				end
			end;
			if not ex then
				return false
			end
		end;
		if action["nostance"] then
			local mX = GetShapeshiftForm()
			local ex = false;
			for _, mY in pairs(action["nostance"]) do
				if mY == mX then
					ex = true;
					break
				end
			end;
			if ex then
				return false
			end
		end;
		if action["itemId"] then
			if type(action["itemId"]) == "table" then
				for _, bi in ipairs(action["itemId"]) do
					if AutoHelp.GetItemCount(bi) > 0 and AutoHelp.IsItemCooldown(bi) then
						return true
					end
				end
			else
				if AutoHelp.GetItemCount(action["itemId"]) > 0 and AutoHelp.IsItemCooldown(action["itemId"]) then
					return true
				end
			end
		elseif action["spellId"] then
			local lH, lI = IsUsableSpell(action["spellId"])
			if not Contains(action["spellName"], "真言术：盾") and not lH then
				return false
			end;
			local lJ, cn, eF = GetSpellCooldown(action["spellId"])
			local mZ = false;
			if lJ == 0 and eF == 1 then
				mZ = true
			end;
			if lJ > 0 and cn > 0 and AutoHelp.UseSpellQueueWindow then
				local lL = cn - (GetTime() - lJ) - AutoHelp.SpellQueueWindow;
				if lL <= 0 then
					mZ = true
				end
			end;
			local d_;
			local m_ = GetSpellInfo(action["spellId"]) or action["spellName"]
			if action["pet"] then
				d_ = IsSpellInRange(m_, "pet")
			else
				if action["target"] and tInfo["unit"] ~= "player" then
					d_ = IsSpellInRange(m_, tInfo["unit"])
				else
					d_ = 1
				end
			end;
			if not lI and mZ and ("player" == tInfo["unit"] or 1 == d_) then
				return true
			else
				return false
			end
		else
			return true
		end
	end;
	function AutoHelp.GetManaCost(ca)
		local n0 = GetSpellPowerCost(ca)
		if n0 then
			for _, n1 in pairs(n0) do
				if n1.name == "MANA" then
					return n1.cost
				end
			end
		end
	end;
	local USESP_MACRO_PRE;
	local USESP_MACRO_AFTER;
	if AutoHelp.isWotlk then
		USESP_MACRO_PRE = "/run sfx=GetCVar(\'Sound_EnableSFX\');\n" .. "/console Sound_EnableSFX 0\n"
		USESP_MACRO_AFTER = "/run UIErrorsFrame:Clear()\n" .. "/run SetCVar(\'Sound_EnableSFX\',sfx);\n"
	else
		USESP_MACRO_PRE = "/run sfx=GetCVar(\'Sound_EnableErrorSpeech\');\n" .. "/console Sound_EnableErrorSpeech 0\n"
		USESP_MACRO_AFTER = "/run UIErrorsFrame:Clear()\n" .. "/run SetCVar(\'Sound_EnableErrorSpeech\',sfx);\n"
	end;
	local n2 = "/stopcasting\n"
	local function n3(n4)
		local n5, md = AutoHelp.GetSpellBooks()
		if type(n4) == "number" and n5[n4] then
			return n5[n4]
		end;
		if type(n4) ~= "table" then
			return nil
		end;
		for i = # n4, 1, - 1 do
			local bi = n4[i]
			if type(bi) == "table" then
				bi = bi[2]
			end;
			if n5[bi] then
				return n5[bi], i
			end
		end
	end;
	local function n6(cx)
		local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(cx)
		if cd then
			local im = {}
			im.spellName = cd;
			im.rank = lS;
			im.icon = lT;
			im.castingTime = lU;
			im.minRange = ib;
			im.maxRange = iG;
			im.spellId = lV;
			return im
		end
	end;
	AutoHelp.GetUsableSpellId = n3;
	AutoHelp.GetUsableSpell = n6;
	local n7 = ""
	local _, _, ms = UnitRace("player")
	if ms == 2 then
		n7 = "/use " .. GetSpellInfo(20572) .. "\n"
	elseif ms == 8 then
		n7 = "/use " .. GetSpellInfo(26297) .. "\n"
	end;
	AutoHelp.CommandKeys = {}
	AutoHelp.MoveKeys = {}
	local n8 = {
		{
			["name"] = "KEY_STOPCAST",
			["macro"] = "/stopcasting",
			["spellName"] = "stopcasting",
			["spellTime"] = 0.2,
			["target"] = false,
			["desc"] = "stopcasting"
		},
		{
			["name"] = "KEY_STOPATTACK",
			["macro"] = "/stopattack",
			["spellName"] = "stopattack",
			["spellTime"] = 0.2,
			["target"] = false,
			["desc"] = "stopattack"
		},
		{
			["name"] = "KEY_STARTATTACK",
			["macro"] = "/startattack",
			["spellTime"] = 0.2,
			["desc"] = "startattack"
		},
		{
			["name"] = "目标互动",
			["command"] = "INTERACTTARGET",
			["wkey"] = "[",
			["akey"] = "{[}",
			["spellName"] = "与目标互动",
			["spellTime"] = 1,
			["desc"] = "与目标互动"
		},
		{
			["name"] = "协助目标",
			["macro"] = "/assist @target",
			["spellName"] = "协助目标",
			["spellTime"] = 0.5,
			["desc"] = "协助目标"
		},
		{
			["name"] = "协助宠物",
			["macro"] = "/assist pet",
			["spellName"] = "协助宠物",
			["spellTime"] = 0.5,
			["desc"] = "协助宠物"
		},
		{
			["name"] = "选中目标",
			["macro"] = "/target @target",
			["spellName"] = "选中目标",
			["spellTime"] = 1,
			["desc"] = "选中目标"
		},
		{
			["name"] = "选择上一个敌方目标",
			["command"] = "TARGETLASTHOSTILE",
			["wkey"] = "\\",
			["akey"] = "{\\}",
			["spellName"] = "选择上一个敌方目标",
			["spellTime"] = 1,
			["desc"] = "选择上一个敌方目标"
		},
		{
			["name"] = "清除目标",
			["macro"] = "/cleartarget",
			["spellName"] = "清除目标",
			["spellTime"] = 0.5,
			["target"] = false,
			["desc"] = "清除目标"
		},
		{
			["name"] = "跳跃",
			["wowaction"] = true,
			["akey"] = "{Space}",
			["spellName"] = "跳跃",
			["spellTime"] = 0.5,
			["desc"] = "跳跃"
		},
		{
			["name"] = "停止移动",
			["wowaction"] = true,
			["akey"] = "{Up}{Down}",
			["spellName"] = "停止移动",
			["spellTime"] = 0.2,
			["desc"] = "停止移动"
		},
		{
			["name"] = "寻找目标",
			["wowaction"] = true,
			["akey"] = "{tab}",
			["spellName"] = "寻找目标",
			["spellTime"] = 0.5,
			["desc"] = "寻找目标"
		},
		{
			["name"] = "移动搜索",
			["wowaction"] = true,
			["akey"] = "{Up down}=3000={Up up}{Right down}{Up down}=200={Up up}{Right up}",
			["spellName"] = "移动搜索",
			["spellTime"] = 4,
			["desc"] = "移动搜索"
		},
		{
			["name"] = "防止暂离",
			["wowaction"] = true,
			["akey"] = "{Up down}=100={Up up}{Down down}=200={Down up}",
			["spellName"] = "防止暂离",
			["spellTime"] = 1,
			["desc"] = "防止暂离"
		},
		{
			["name"] = "左转45度",
			["wowaction"] = true,
			["akey"] = "{Left down}=250={Left up}",
			["spellName"] = "左转45度",
			["spellTime"] = 0.3,
			["desc"] = "左转45度"
		},
		{
			["name"] = "右转45度",
			["wowaction"] = true,
			["akey"] = "{Right down}=250={Right up}",
			["spellName"] = "右转45度",
			["spellTime"] = 0.3,
			["desc"] = "右转45度"
		},
		{
			["name"] = "转身90度",
			["wowaction"] = true,
			["akey"] = "{Right down}=500={Right up}",
			["spellName"] = "转身90度",
			["spellTime"] = 0.6,
			["desc"] = "转身90度"
		},
		{
			["name"] = "转身",
			["wowaction"] = true,
			["akey"] = "{Right down}=1000={Right up}",
			["spellName"] = "转身",
			["spellTime"] = 1,
			["desc"] = "转身"
		},
		{
			["name"] = "后退",
			["wowaction"] = true,
			["akey"] = "{Down down}=1000={Down up}",
			["spellName"] = "后退",
			["spellTime"] = 1,
			["desc"] = "后退"
		},
		{
			["name"] = "后跳",
			["wowaction"] = true,
			["akey"] = "{Space}{Down down}=1000={Down up}",
			["spellName"] = "后跳",
			["spellTime"] = 1,
			["desc"] = "后跳"
		},
		{
			["name"] = "左移",
			["wowaction"] = true,
			["akey"] = "{a down}=1000={a up}",
			["spellName"] = "左移",
			["spellTime"] = 1,
			["desc"] = "左移"
		},
		{
			["name"] = "右移",
			["wowaction"] = true,
			["akey"] = "{d down}=1000={d up}",
			["spellName"] = "右移",
			["spellTime"] = 1,
			["desc"] = "右移"
		},
		{
			["name"] = "StartRun",
			["moveaction"] = true,
			["movecommand"] = "STARTAUTORUN",
			["wkey"] = "RALT-[",
			["akey"] = "{RALT down}{[}{RALT up}"
		},
		{
			["name"] = "StopRun",
			["moveaction"] = true,
			["movecommand"] = "STOPAUTORUN",
			["wkey"] = "RALT-]",
			["akey"] = "{RALT down}{]}{RALT up}"
		},
		{
			["name"] = "KEY_DRINKING",
			["comkey"] = true,
			["spellName"] = "喝水",
			["spellTime"] = 5,
			["desc"] = "喝水",
			["stopFollow"] = true,
			["canInterrupt"] = false,
			["stopMoving"] = true
		},
		{
			["name"] = "KEY_EATING",
			["comkey"] = true,
			["spellName"] = "吃面包",
			["spellTime"] = 5,
			["desc"] = "吃面包",
			["stopFollow"] = true,
			["canInterrupt"] = false,
			["stopMoving"] = true
		},
		{
			["name"] = "吃喝",
			["comkey"] = true,
			["spellName"] = "吃面包+喝水",
			["spellTime"] = 5,
			["desc"] = "吃面包+喝水",
			["stopFollow"] = true,
			["canInterrupt"] = false,
			["stopMoving"] = true
		},
		{
			["name"] = "吃糖",
			["itemId"] = {
				5512,
				5511,
				5509,
				5510,
				9421,
				22103,
				36889,
				36892
			},
			["spellTime"] = 0.2
		},
		{
			["name"] = "喝红",
			["itemId"] = {
				118,
				858,
				929,
				1710,
				3928,
				13446,
				39671,
				33447
			},
			["spellTime"] = 0.2
		},
		{
			["name"] = "狂野魔法药水",
			["itemId"] = 40212,
			["spellTime"] = 0.2
		},
		{
			["name"] = "速度药水",
			["itemId"] = 40211,
			["spellTime"] = 0.2
		},
		{
			["name"] = "不灭药水",
			["itemId"] = 40093,
			["spellTime"] = 0.2
		},
		{
			["name"] = "喝蓝",
			["itemId"] = 33448,
			["spellTime"] = 0.2
		},
		{
			["name"] = "KEY_AUTOBATTLE",
			["macro"] = "/click BattlegroundType1\n/click BattlefieldFrameJoinButton",
			["spellName"] = "AUTOBATTLE",
			["spellTime"] = 3,
			["desc"] = "自动排战场"
		},
		{
			["name"] = "KEY_JOINBATTLE",
			["macro"] = "/click PVPReadyDialogEnterBattleButton",
			["spellName"] = "JOINBATTLE",
			["spellTime"] = 3,
			["desc"] = "自动进入战场"
		},
		{
			["name"] = "KEY_STARTFOLLOW",
			["macro"] = "/stopcasting\n/run FollowUnit(AutoHelp.FOLLOW_UNIT)",
			["spellName"] = "AUTOFOLLOW",
			["spellTime"] = 1,
			["desc"] = "自动跟随"
		},
		{
			["name"] = "KEY_STOPFOLLOW",
			["macro"] = "/run FollowUnit('player')",
			["spellName"] = "STOPFOLLOW",
			["spellTime"] = 1,
			["desc"] = "停止跟随"
		},
		{
			["name"] = "reload",
			["macro"] = "/reload",
			["spellName"] = "reload",
			["spellTime"] = 3,
			["desc"] = "重载界面"
		}
	}
	function AutoHelp.LoopActionKeys(n9)
		local na = {}
		local n5, md = AutoHelp.GetSpellBooks()
		local function nb(n4, bi)
			if not n4 then
				return
			end;
			for _, ca in ipairs(n4) do
				if ca == bi then
					return true
				end
			end
		end;
		local function nc(action)
			local nd = {}
			for al, hK in pairs(action) do
				if type(hK) == "table" then
					nd[al] = {}
					for ne, nf in pairs(hK) do
						nd[al][ne] = nf
					end
				else
					nd[al] = hK
				end
			end;
			return nd
		end;
		local function ng(action, cd, ca, nh, ni)
			local nd = nc(action)
			local nj = nh.castName;
			nd["name"] = cd;
			nd["spellId"] = ca;
			nd["castName"] = nh.castName;
			if ni then
				nd["spellName"] = nh.castName
			else
				nd["spellName"] = GetSpellInfo(ca)
				nj = nd["spellName"]
			end;
			local nk = false;
			if action["useError"] then
				userError = true
			end;
			local nl = ""
			if AutoHelp.playerClass == "WARRIOR" or AutoHelp.playerClass == "HUNTER" or AutoHelp.playerClass == "ROGUE" then
				nl = ""
			end;
			if action["useCrit"] then
				for _, ne in pairs(action["useCrit"]) do
					if GetSpellInfo(ne) then
						nk = true;
						nl = nl .. "/cast " .. ne .. "\n"
					end
				end
			end;
			if action["crits"] then
				for _, ne in pairs(action["crits"]) do
					if GetSpellInfo(ne) then
						if not nd["critSpells"] then
							nd["critSpells"] = {}
						end;
						nd["critSpells"][# nd["critSpells"] + 1] = ne
					end
				end
			end;
			if action["useSP"] then
				nk = true;
				nl = nl .. "/use 10\n"
				nl = nl .. "/use 13\n"
				nl = nl .. "/use 14\n"
			end;
			if AutoHelp.isWotlk then
				if action["useRace"] or action["useSP"] then
					nk = true;
					local _, mr, ms = UnitRace("player")
					if ms == 2 and GetSpellInfo(20572) then
						nk = true;
						nl = nl .. "/use " .. GetSpellInfo(20572) .. "\n"
					elseif ms == 8 and GetSpellInfo(26297) then
						nk = true;
						nl = nl .. "/use " .. GetSpellInfo(26297) .. "\n"
					end
				end
			end;
			if action["attack"] then
				nl = nl .. "/startattack\n"
			end;
			if AutoHelp.isWotlk then
				if action["useYS"] == 1 then
					nk = true;
					nl = nl .. "/use [combat]" .. (GetItemInfo(40211) or "加速药水") .. "\n"
				end;
				if action["useYS"] == 2 then
					nk = true;
					nl = nl .. "/use [combat]" .. (GetItemInfo(40211) or "加速药水") .. "\n"
					nl = nl .. "/use [combat]" .. (GetItemInfo(40212) or "狂野魔法药水") .. "\n"
				end;
				if AutoHelp.talent and (AutoHelp.talent == "冰霜" or AutoHelp.talent == "鲜血") or AutoHelp.playerClass == "WARRIOR" then
					if action["useYS"] == 3 then
						nk = true;
						nl = nl .. "/use [combat]" .. (GetItemInfo(40093) or "不灭药水") .. "\n"
						nl = nl .. "/use [combat]" .. (GetItemInfo(40211) or "加速药水") .. "\n"
					end
				else
					if action["useYS"] == 3 then
						nk = true;
						nl = nl .. "/use [combat]" .. (GetItemInfo(40211) or "加速药水") .. "\n"
						nl = nl .. "/use [combat]" .. (GetItemInfo(40093) or "不灭药水") .. "\n"
					end
				end
			end;
			if action["changeStance"] and AutoHelp.NOSTANCES then
				nl = nl .. "/cast " .. AutoHelp.NOSTANCES[action["changeStance"]] .. "\n"
			end;
			if action["macro"] then
				nl = nl .. action["macro"] .. "\n"
			else
				if action["target"] == true then
					nl = nl .. "/cast [target=@target] " .. nj .. "\n"
				else
					nl = nl .. "/cast " .. nj .. "\n"
				end
			end;
			if AutoHelp.isWotlk then
				local nm = GetItemInfo(41119) or "萨隆邪铁炸弹"
				if action["useBomb"] then
					nk = true;
					nl = nl .. "/use [@player]" .. nm .. "\n"
				end;
				if action["useYDBomb"] then
					nk = true;
					nl = nl .. "/use [@player] 6\n"
				end
			end;
			if nk then
				nl = USESP_MACRO_PRE .. nl .. USESP_MACRO_AFTER
			end;
			nd["macro"] = nl .. (action["afterMacro"] or "")
			if nh.castingTime > 0 then
				nd["stopMoving"] = true;
				nd["spellTime"] = nh.castingTime / 1000;
				if cd == "KEY_MOUNT" then
					nd["spellTime"] = nd["spellTime"] + 1
				end
			elseif not action["spellTime"] then
				nd["spellTime"] = 1
			end;
			nd["desc"] = nh.castName;
			nd["icon"] = nh.icon;
			nd["powerCost"] = AutoHelp.GetManaCost(ca) or 0;
			nd["maxRange"] = nh.maxRange;
			nd["minRange"] = nh.minRange;
			nd["rank"] = nh.rank;
			nd["skillType"] = nh.skillType;
			nd["castingTime"] = nh.castingTime;
			nd["spellSubName"] = nh.spellSubName;
			return nd
		end;
		for i = 1, # n8 do
			tinsert(n9, n8[i])
		end;
		for i = 1, # n9 do
			local action = n9[i]
			if action["spellId"] then
				local cx = action["name"]
				if type(action["spellId"]) == "number" then
					cx = action["spellId"]
				end;
				if action["spellName"] then
					cx = action["spellName"]
				end;
				local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(cx)
				if cd then
					action["spellId"] = lV;
					if action["auraNameCID"] then
						action["auraName"] = cd
					end;
					if action["auraNameCID2"] then
						action["auraName"] = cd;
						action["auraByPlayer"] = true
					end;
					if action["debuffNameCID"] then
						action["debuffName"] = cd
					end;
					if action["debuffNameCID2"] then
						action["debuffName"] = cd;
						action["debuffByPlayer"] = true
					end;
					if cd == "军马" or cd == "战马" then
						local nd = nc(action)
						nd["desc"] = cd;
						nd["spellName"] = cd;
						nd["macro"] = "/cast " .. cd;
						nd["spellTime"] = 5;
						na[# na + 1] = nd
					else
						local nn, no = n3(action["spellId"])
						if nn then
							if action["spellSplit"] then
								local n5, md = AutoHelp.GetSpellBooks()
								local bq = md[cx]
								if bq and # bq > 1 then
									for np, nh in ipairs(bq) do
										local nd = ng(action, action["name"] .. np, nh.spellId, nh, true)
										nd["rankNo"] = np;
										na[# na + 1] = nd
									end
								end
							end;
							local nd = ng(action, action["name"], nn.spellId, nn, true)
							na[# na + 1] = nd;
							local nq = action["name"]
							if action["sp"] then
								action["name"] = nq .. "饰品爆发"
								action["useSP"] = true;
								if action["crits"] then
									action["useCrit"] = action["crits"]
								end;
								local nd = ng(action, action["name"], nn.spellId, nn, true)
								na[# na + 1] = nd;
								action["useSP"] = nil;
								action["useCrit"] = nil
							end;
							if AutoHelp.isWotlk then
								if action["ys"] then
									action["name"] = nq .. "药水爆发"
									action["useYS"] = action["ys"]
									local nd = ng(action, action["name"], nn.spellId, nn, true)
									na[# na + 1] = nd;
									action["useYS"] = nil
								end;
								if action["bomb"] then
									action["name"] = nq .. "邪铁炸弹"
									action["useBomb"] = true;
									local nd = ng(action, action["name"], nn.spellId, nn, true)
									na[# na + 1] = nd;
									action["useBomb"] = nil;
									action["name"] = nq .. "腰带炸弹"
									action["useYDBomb"] = true;
									local nd = ng(action, action["name"], nn.spellId, nn, true)
									na[# na + 1] = nd;
									action["useYDBomb"] = nil
								end
							end
						end
					end
				end
			elseif action["itemId"] then
				local nd = nc(action)
				if type(nd["itemId"]) == "table" then
					if not nd["macro"] then
						local mq = ""
						local cd = ""
						for _, bi in ipairs(nd["itemId"]) do
							cd = GetItemInfo(bi)
							if cd then
								mq = "\n/use " .. cd .. mq;
								nd["itemName"] = cd
							end
						end;
						nd["macro"] = mq;
						if not nd["spellTime"] then
							nd["spellTime"] = 0.2
						end
					else
						nd["itemName"] = nd["name"]
					end;
					nd["desc"] = action["name"]
					na[# na + 1] = nd
				else
					local cd = AutoHelp.GetItemInfo(nd["itemId"])
					if cd then
						nd["itemName"] = cd;
						if not nd["macro"] then
							nd["macro"] = "/use " .. cd
						end;
						if not nd["spellTime"] then
							nd["spellTime"] = 0.2
						end;
						nd["desc"] = cd;
						na[# na + 1] = nd
					end
				end
			elseif action["name"] == "KEY_DRINKING" then
				local nd = nc(action)
				nd["desc"] = GetItemInfo(8079) or "魔法晶水"
				nd["spellName"] = GetItemInfo(8079) or "魔法晶水"
				nd["macro"] = "/use " .. (GetItemInfo(8079) or "魔法晶水")
				nd["spellTime"] = 5;
				na[# na + 1] = nd
			elseif action["name"] == "KEY_EATING" then
				local nd = nc(action)
				nd["desc"] = GetItemInfo(8076) or "魔法甜面包"
				nd["spellName"] = GetItemInfo(8076) or "魔法甜面包"
				nd["macro"] = "/use " .. (GetItemInfo(8076) or "魔法甜面包")
				nd["spellTime"] = 5;
				na[# na + 1] = nd
			elseif action["name"] == "吃喝" then
				local nd = nc(action)
				nd["macro"] = "/use " .. (GetItemInfo(8076) or "魔法甜面包") .. "\n/use " .. (GetItemInfo(8079) or "魔法甜面包")
				nd["spellTime"] = 5;
				na[# na + 1] = nd
			elseif action["command"] and action["wkey"] and action["akey"] then
				AutoHelp.CommandKeys[# AutoHelp.CommandKeys + 1] = {
					name = action["name"],
					desc = action["desc"],
					command = action["command"],
					wkey = action["wkey"],
					akey = action["akey"]
				}
				local nd = nc(action)
				nd["commandKey"] = # AutoHelp.CommandKeys;
				nd["akey"] = nil;
				nd["wkey"] = nil;
				na[# na + 1] = nd
			elseif action["wowaction"] and action["akey"] then
				AutoHelp.CommandKeys[# AutoHelp.CommandKeys + 1] = {
					name = action["name"],
					desc = action["desc"],
					akey = action["akey"]
				}
				local nd = nc(action)
				nd["commandKey"] = # AutoHelp.CommandKeys;
				nd["akey"] = nil;
				nd["wkey"] = nil;
				na[# na + 1] = nd
			elseif action["moveaction"] and action["akey"] then
				AutoHelp.MoveKeys[# AutoHelp.MoveKeys + 1] = {
					name = action["name"],
					desc = action["desc"],
					akey = action["akey"],
					wkey = action["wkey"],
					movecommand = action["movecommand"]
				}
				local nd = nc(action)
				nd["commandKey"] = # AutoHelp.MoveKeys;
				nd["akey"] = nil;
				nd["wkey"] = nil;
				nd["spellName"] = action["name"]
				nd["desc"] = action["name"]
				na[# na + 1] = nd
			else
				na[# na + 1] = nc(action)
			end
		end;
		AutoHelp.ACTIONKEY_NAMES = {}
		for l6, action in ipairs(na) do
			if AutoHelp.ACTIONKEY_NAMES[action["name"]] ~= nil then
				AutoHelp.Debug("Wrong key " .. action["name"] .. "," .. action["desc"])
			end;
			action["actionkey"] = l6;
			AutoHelp.ACTIONKEY_NAMES[action["name"]] = action
		end;
		if not AutoHelp.isRetail then
			AutoHelp.RecalcActionHealAmount(na)
		end;
		return na
	end;
	function AutoHelp.CalcHealAmount(action, tInfo)
		if action["healType"] == 1 and AutoHelp.LibHealComm.CalculateHealing then
			local _, bN = AutoHelp.LibHealComm.CalculateHealing(nil, action["spellId"], tInfo["unit"])
			return bN
		end;
		if action["healType"] == 2 and AutoHelp.LibHealComm.CalculateHealing and AutoHelp.LibHealComm.CalculateHotHealing then
			local nr = 0;
			local _, bN = AutoHelp.LibHealComm.CalculateHealing(nil, action["spellId"], "player")
			nr = bN;
			local _, ns, d7 = AutoHelp.LibHealComm.CalculateHotHealing(nil, action["spellId"], "player")
			if type(bN) == "table" then
				for _, nt in pairs(bN) do
					nr = nr + nt
				end
			else
				nr = nr + ns * d7
			end;
			return nr
		end;
		if action["healType"] == 3 and AutoHelp.LibHealComm.CalculateHotHealing then
			local _, bN, d7 = AutoHelp.LibHealComm.CalculateHotHealing(nil, action["spellId"], tInfo["unit"])
			local nr = 0;
			if type(bN) == "table" then
				for _, nt in pairs(bN) do
					nr = nr + nt
				end
			else
				nr = bN * d7
			end;
			return nr
		end;
		return action["baseHealAmount"] or 0
	end;
	local aI = 15;
	local aJ = 1;
	local aK = 2;
	local aL = 4;
	local aM = 8;
	local aN = 16;
	local nu = {}
	function AutoHelp.RecalcActionHealAmount(nv)
		local n5, md = AutoHelp.GetSpellBooks()
		local nw = {}
		local nx = {}
		local ny = {}
		for i = 1, # nv do
			local action = nv[i]
			if action["healType"] == 1 and AutoHelp.LibHealComm.CalculateHealing then
				local nz, bN, bF = AutoHelp.LibHealComm.CalculateHealing(nil, action["spellId"], "player")
				local nA = bN;
				if nz == aK then
					nA = bN * bF
				elseif nz == aJ then
					nA = bN
				end;
				action["baseHealAmount"] = nA;
				nw[# nw + 1] = i;
				nx[# nx + 1] = i;
				ny[# ny + 1] = i;
				AutoHelp.SetHealAmount(action["name"], nA)
			end;
			if action["healType"] == 2 and AutoHelp.LibHealComm.CalculateHealing and AutoHelp.LibHealComm.CalculateHotHealing then
				local nr = 0;
				local _, bN = AutoHelp.LibHealComm.CalculateHealing(nil, action["spellId"], "player")
				nr = bN;
				local _, ns, d7 = AutoHelp.LibHealComm.CalculateHotHealing(nil, action["spellId"], "player")
				if type(bN) == "table" then
					for _, nt in pairs(bN) do
						nr = nr + nt
					end
				else
					nr = nr + ns * d7
				end;
				action["baseHealAmount"] = nr;
				action["totalTicks"] = d7;
				nw[# nw + 1] = i;
				nx[# nx + 1] = i;
				ny[# ny + 1] = i;
				AutoHelp.SetHealAmount(action["name"], action["baseHealAmount"])
			end;
			if action["healType"] == 3 and AutoHelp.LibHealComm.CalculateHotHealing then
				local _, bN, d7 = AutoHelp.LibHealComm.CalculateHotHealing(nil, action["spellId"], "player")
				local nr = 0;
				if type(bN) == "table" then
					for _, nt in pairs(bN) do
						nr = nr + nt
					end
				else
					nr = bN * d7
				end;
				action["baseHealAmount"] = nr;
				action["totalTicks"] = d7;
				nw[# nw + 1] = i;
				nx[# nx + 1] = i;
				ny[# ny + 1] = i;
				AutoHelp.SetHealAmount(action["name"], action["baseHealAmount"])
			end;
			if (action["healType"] == 4 or action["healType"] == 5) and action["_baseHealAmount"] then
				action["baseHealAmount"] = 0
			end
		end
	end;
	function AutoHelp.AddHealSpellList(nB, cx, nC)
		local n5, md = AutoHelp.GetSpellBooks()
		local bq = md[cx]
		if bq then
			if # bq >= 1 then
				table.insert(nB, 1, cx)
				for i = # bq - 1, 1, - 1 do
					if i >= nC then
						table.insert(nB, 1, cx .. i)
					end
				end
			end
		end
	end;
	function AutoHelp.EquipmentChanged()
		if not AutoHelp.isRetail then
			AutoHelp.RecalcActionHealAmount(AutoHelp.HEAL_ACTION_KEYS)
		end
	end;
	function AutoHelp.UnitBuff(nD, ...)
		local b8 = nD;
		if type(nD) == "table" then
			b8 = nD["unit"]
		end;
		if not b8 then
			return
		end;
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitBuff(b8, i)
			if not cx then
				return
			end;
			for al = 1, select("#", ...) do
				local bi = select(al, ...)
				if tostring(ca) == tostring(bi) or cx == tostring(bi) then
					return cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ
				end
			end
		end
	end;
	function AutoHelp.UnitHasBuffByPlayer(b8, ...)
		local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = AutoHelp.UnitBuff(b8, ...)
		if cx and nH == "player" then
			return true
		end;
		return false
	end;
	function AutoHelp.UnitHasDebuffByPlayer(b8, ...)
		local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = AutoHelp.UnitDebuff(b8, ...)
		if cx and nH == "player" then
			return true
		end;
		return false
	end;
	function AutoHelp.UnitCanBuff(b8, nR)
		local nS, nT, nU, nV, nW, nX, nY = GetSpellInfo(nR)
		if not nS then
			return false
		end;
		local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = AutoHelp.UnitBuff(b8, nR)
		if not cx then
			return true
		end;
		return false
	end;
	function AutoHelp.UnitHasBuff(b8, ...)
		local cd = AutoHelp.UnitBuff(b8, ...)
		if cd then
			return true
		else
			return false
		end
	end;
	function AutoHelp.GetBuffRemainTime(b8, nZ, n_)
		if type(b8) == "table" then
			b8 = b8["unit"]
		end;
		if not b8 then
			return 0
		end;
		if type(nZ) == Integer then
			nZ = GetSpellInfo(nZ)
		end;
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitBuff(b8, i)
			if not cx then
				return 0
			end;
			if (nZ == cx or nZ == ca) and nG then
				if n_ and nH == "player" then
					return nG - GetTime()
				end;
				if not n_ then
					return nG - GetTime()
				end
			end
		end;
		return 0
	end;
	function AutoHelp.GetDebuffRemainTime(b8, nZ, n_)
		if type(b8) == "table" then
			b8 = b8["unit"]
		end;
		if not b8 then
			return 0
		end;
		if type(nZ) == Integer then
			nZ = GetSpellInfo(nZ)
		end;
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitDebuff(b8, i)
			if not cx then
				return 0
			end;
			if (nZ == cx or nZ == ca) and nG then
				if n_ and nH == "player" then
					return nG - GetTime()
				end;
				if not n_ then
					return nG - GetTime()
				end
			end
		end;
		return 0
	end;
	function AutoHelp.UnitDebuff(nD, ...)
		local b8 = nD;
		if type(nD) == "table" then
			b8 = nD["unit"]
		end;
		if not b8 then
			return
		end;
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitDebuff(b8, i)
			if not cx then
				return
			end;
			for al = 1, select("#", ...) do
				local bi = select(al, ...)
				if tostring(ca) == tostring(bi) or cx == tostring(bi) then
					return cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ
				end
			end
		end
	end;
	function AutoHelp.UnitHasDebuff(b8, ...)
		local cd = AutoHelp.UnitDebuff(b8, ...)
		if cd then
			return true
		else
			return false
		end
	end;
	function AutoHelp.UnitHasDebuffs(b8, jG)
		for i, cd in pairs(jG) do
			if AutoHelp.UnitDebuff(b8, cd) then
				return true
			end
		end
	end;
	function AutoHelp.GetUnitDebuffTypeNum(b8, o0)
		local o1 = 0;
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitDebuff(b8, i)
			if not cx then
				break
			end;
			if nF == o0 then
				o1 = o1 + 1
			end
		end;
		return o1
	end;
	function AutoHelp.GetUnitBuffNum(b8, nR)
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitBuff(b8, i)
			if not cx then
				break
			end;
			if cx == nR or nR == ca then
				if nE > 0 then
					return nE
				else
					return 1
				end
			end
		end;
		return 0
	end;
	function AutoHelp.GetUnitDebuffNum(b8, jF)
		for i = 1, ju do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL, nM, nN, nO, nP, nQ = UnitDebuff(b8, i)
			if not cx then
				break
			end;
			if cx == jF or jF == ca then
				if nE > 0 then
					return nE
				else
					return 1
				end
			end
		end;
		return 0
	end;
	function AutoHelp.GetUnitMagicDebuffNum(b8)
		return AutoHelp.GetUnitDebuffTypeNum(b8, "Magic")
	end;
	function AutoHelp.GetUnitDiseaseDebuffNum(b8)
		return AutoHelp.GetUnitDebuffTypeNum(b8, "Disease")
	end;
	function AutoHelp.GetUnitPoisonDebuffNum(b8)
		return AutoHelp.GetUnitDebuffTypeNum(b8, "Poison")
	end;
	function AutoHelp.GetUnitCurseDebuffNum(b8)
		return AutoHelp.GetUnitDebuffTypeNum(b8, "Curse")
	end;
	function AutoHelp.HasTrackingBuff(jZ)
		for i = 0, 40 do
			local cd, o2, o3, type, o4, aH = C_Minimap.GetTrackingInfo(i)
			if cd == jZ then
				return o3
			end
		end;
		return false
	end;
	function AutoHelp.SetTrackingBuff(jZ)
		for i = 0, 40 do
			local cd, o2, o3, type, o4, aH = C_Minimap.GetTrackingInfo(i)
			if cd == jZ then
				C_Minimap.SetTracking(i, true)
			end
		end
	end;
	local o5 = {
		43523,
		43518,
		34062,
		22018,
		30703,
		8079,
		8078,
		8077,
		3772,
		2136,
		2288,
		5350,
		1205,
		1645,
		8766,
		1708,
		1179,
		159
	}
	local o6 = {
		44750
	}
	function AutoHelp.GetUsableWater()
		local cf = UnitLevel("player")
		for i = 1, # o5 do
			if AutoHelp.GetItemCount(o5[i]) > 0 then
				local me, itemLink, mf, mg, mh, mi, mj, mk, o7, o8, o9 = GetItemInfo(o5[i])
				if me and mh and cf >= mh and IsUsableItem(o5[i]) then
					return o5[i]
				end
			end
		end;
		for i = 1, # o6 do
			if AutoHelp.GetItemCount(o6[i]) > 0 then
				local me, itemLink, mf, mg, mh, mi, mj, mk, o7, o8, o9 = GetItemInfo(o6[i])
				if me and mh and cf >= mh and IsUsableItem(o6[i]) then
					return o6[i]
				end
			end
		end
	end;
	function AutoHelp.IsDrinking(b8)
		if not b8 then
			b8 = "player"
		end;
		return AutoHelp.UnitHasBuff(b8, "喝水") or AutoHelp.UnitHasBuff(b8, "饮水") or AutoHelp.UnitHasBuff(b8, "饮用")
	end;
	function AutoHelp.IsEating(b8)
		if not b8 then
			b8 = "player"
		end;
		return AutoHelp.UnitHasBuff(b8, "进食")
	end;
	function AutoHelp.IsMounted()
		return IsMounted()
	end;
	local oa = {
		43523,
		43518,
		34062,
		22019,
		22895,
		117,
		8076,
		8075,
		1487,
		1114,
		1113,
		5349,
		2070,
		4536,
		1131,
		4601,
		1127,
		4542,
		4541,
		4540,
		33449,
		8950,
		4544
	}
	function AutoHelp.GetUsableFood()
		local cf = UnitLevel("player")
		for i = 1, # oa do
			if AutoHelp.GetItemCount(oa[i]) > 0 then
				local me, itemLink, mf, mg, mh, mi, mj, mk, o7, o8, o9 = GetItemInfo(oa[i])
				if me and mh and cf >= mh and IsUsableItem(oa[i]) then
					return oa[i]
				end
			end
		end
	end;
	function AutoHelp.HasMagicWater()
		return AutoHelp.GetUsableWater()
	end;
	function AutoHelp.HasMagicFood()
		return AutoHelp.GetUsableFood()
	end;
	local function i3()
		local _, _, i4, i5 = GetSpellTabInfo(GetNumSpellTabs())
		return i4 + i5
	end;
	local function ob(js, k4)
		local lL = {}
		string.gsub(js, '[^' .. k4 .. ']+', function(oc)
			table.insert(lL, oc)
		end)
		return lL
	end;
	function AutoHelp.CheckAllItems()
		local ja, s = pcall(function()
			GetItemSpell(5350)
			GetItemSpell(5349)
			GetItemInfo(8079)
			GetItemInfo(8076)
			GetItemInfo(41119)
			GetItemInfo(40211)
			GetItemInfo(40212)
			AutoHelp.GetUsableWater()
			AutoHelp.GetUsableFood()
		end)
		if not ja and s then
			print("捕获到错误:", s)
		end;
		AutoHelp.SPELLISOK = true
	end;
	local od;
	local oe;
	local function of(og)
		if AutoHelp.isWotlk then
			if not od or og then
				local showranks = GetCVar("ShowAllSpellRanks")
				if showranks == "0" then
					SetCVar("ShowAllSpellRanks", "1")
				end;
				od = {}
				oe = {}
				lastName = ""
				lastRank = 0;
				for i = 1, i3() do
					local cx, spellSubName = GetSpellBookItemName(i, BOOKTYPE_SPELL)
					if not cx then
						break
					end;
					local cd, lS, lT, lU, ib, iG, ca = GetSpellInfo(cx)
					if cd then
						od[ca] = {}
						od[ca].spellName = cx;
						od[ca].spellSubName = spellSubName;
						od[ca].skillType = skillType;
						od[ca].spellId = ca;
						od[ca].castingTime = lU;
						od[ca].minRange = ib;
						od[ca].maxRange = iG;
						od[ca].icon = lT;
						od[ca].rank = lS;
						if lastName ~= cx then
							lastName = cx;
							lastRank = 1
						else
							lastRank = lastRank + 1
						end;
						if lS == nil then
							od[ca].rank = lastRank
						end;
						od[ca].castName = cx;
						if not oe[cx] then
							oe[cx] = {}
						end;
						oe[cx][# oe[cx] + 1] = od[ca]
					end
				end
			end;
			SetCVar("ShowAllSpellRanks", showranks)
			return od, oe
		else
			if not od or og then
				local showranks = GetCVar("ShowAllSpellRanks")
				if showranks == "0" then
					SetCVar("ShowAllSpellRanks", "1")
				end;
				od = {}
				oe = {}
				lastName = ""
				lastRank = 0;
				for i = 1, i3() do
					local skillType, oh = GetSpellBookItemInfo(i, BOOKTYPE_SPELL)
					local cx, lS, lT, lU, ib, iG, ca = GetSpellInfo(oh)
					if cx then
						od[ca] = {}
						od[ca].spellName = cx;
						od[ca].spellSubName = spellSubName;
						od[ca].skillType = skillType;
						od[ca].spellId = ca;
						od[ca].castingTime = lU;
						od[ca].minRange = ib;
						od[ca].maxRange = iG;
						od[ca].icon = lT;
						od[ca].rank = lS;
						local spellSubName = GetSpellSubtext(ca)
						if spellSubName and spellSubName ~= "" then
							od[ca].castName = cx .. "(" .. spellSubName .. ")"
						else
							od[ca].castName = cx
						end;
						if lastName ~= cx and spellSubName then
							lastName = cx;
							lastRank = 1
						else
							lastRank = lastRank + 1
						end;
						if lS == nil then
							od[ca].rank = lastRank
						end;
						if not oe[cx] then
							oe[cx] = {}
						end;
						oe[cx][# oe[cx] + 1] = od[ca]
					end
				end
			end;
			SetCVar("ShowAllSpellRanks", showranks)
			return od, oe
		end
	end;
	function AutoHelp.GetSpellBooks(og)
		return of(og)
	end;
	function AutoHelp.GetSpellBookItem(ca)
		local n5, md = AutoHelp.GetSpellBooks()
		if type(ca) == "string" then
			return md[ca]
		else
			return n5[ca]
		end
	end;
	function getMoneyTotal()
		return GetMoney()
	end;
	function getPlayerLevel(b8)
		local cf = UnitLevel(b8)
		return cf
	end;
	function getPlayerClass(b8)
		local oi, oj, np = UnitClass(b8)
		if np == nil then
			return 0
		end;
		return np
	end;
	NoDur = {
		[2] = false,
		[4] = false,
		[11] = false,
		[12] = false,
		[13] = false,
		[14] = false,
		[15] = false,
		[19] = false
	}
	Nakie = false;
	function Naked()
		Nakie = true;
		local ok = {}
		NakedInv = {}
		for ol = 0, 4 do
			ok[ol] = 0;
			for k4 = 1, GetContainerNumSlots(ol) do
				if not GetContainerItemInfo(ol, k4) then
					ok[ol] = ok[ol] + 1
				end
			end
		end;
		for i = 1, 19 do
			if not NoDur[i] then
				PickupInventoryItem(i)
				if CursorHasItem() then
					d = false;
					for ol = 0, 4 do
						if ok[ol] > 0 then
							local _, a = string.find(GetInventoryItemLink("player", i), "|h", 3)
							local cp = string.find(GetInventoryItemLink("player", i), "|h", a)
							local cd = string.sub(GetInventoryItemLink("player", i), a + 2, cp - 2)
							NakedInv[cd] = 1;
							if ol == 0 then
								PutItemInBackpack()
							else
								PutItemInBag(19 + ol)
							end;
							ok[ol] = ok[ol] - 1;
							d = true;
							break
						end
					end;
					if not d then
						AutoEquipCursorItem()
						break
					end
				end
			end
		end
	end;
	function Dressed()
		Nakie = false;
		for ol = 0, 4 do
			for k4 = 1, GetContainerNumSlots(ol) do
				if GetContainerItemLink(ol, k4) then
					local _, a = string.find(GetContainerItemLink(ol, k4), "|h", 3)
					local cp = string.find(GetContainerItemLink(ol, k4), "|h", a)
					local cd = string.sub(GetContainerItemLink(ol, k4), a + 2, cp - 2)
					if NakedInv[cd] == 1 then
						PickupContainerItem(ol, k4)
						AutoEquipCursorItem()
					end
				end
			end
		end
	end;
	function AutoHelp.DressSlot(om, me)
		for ol = 0, 4 do
			for k4 = 1, GetContainerNumSlots(ol) do
				if GetContainerItemLink(ol, k4) then
					local _, a = string.find(GetContainerItemLink(ol, k4), "|h", 3)
					local cp = string.find(GetContainerItemLink(ol, k4), "|h", a)
					local cd = string.sub(GetContainerItemLink(ol, k4), a + 2, cp - 2)
					if me == cd then
						PickupContainerItem(ol, k4)
						EquipCursorItem(om)
					end
				end
			end
		end
	end;
	function NakedToggle()
		if Nakie == true then
			Dressed()
		else
			Naked()
		end
	end;
	function AutoHelp.UnitInMeleeRange(on)
		local oo;
		if GetItemInfo(8149) then
			oo = IsItemInRange(8149, on)
		end;
		return UnitExists(on) and UnitIsVisible(on) and oo
	end;
	function getUnitIds()
		if IsInRaid() then
			return "raid", "raidpet"
		elseif IsInGroup() then
			return "party", "partypet"
		else
			return "player", "pet"
		end
	end;
	HEAL_GROUP_TYPE_SOLO = 0;
	HEAL_GROUP_TYPE_PARTY = 1;
	HEAL_GROUP_TYPE_RAID = 2;
	AutoHelp.PLAYER_RAID_ID = nil;
	local function op()
		return IsInRaid() and 2 or IsInGroup() and 1 or 0
	end;
	local function oq(os)
		if not os then
			return 1
		end;
		if os == "player" then
			os = AutoHelp.PLAYER_RAID_ID
		end;
		local ot = os:match("^party(%d+)$")
		local ou = os:match("^raid(%d+)$")
		if ot then
			return ot
		elseif ou then
			return ou
		else
			return 1
		end
	end;
	function getPlayerRaidUnit()
		local ov;
		if HEAL_GROUP_TYPE_RAID == op() then
			for ow = 1, 40 do
				ov = "raid" .. ow;
				if UnitIsUnit("player", ov) then
					return ov
				end
			end
		end;
		return "player"
	end;
	function GetRaidUnit(ox)
		if not ox then
			return nil
		end;
		local lD = HEAL_RAID[ox]
		if lD ~= nil then
			return lD
		end;
		if HEAL_RAID_NAMES[ox] ~= nil then
			return HEAL_RAID[HEAL_RAID_NAMES[ox]]
		end;
		local oy = UnitName(ox)
		if HEAL_RAID_NAMES[oy] ~= nil then
			return HEAL_RAID[HEAL_RAID_NAMES[oy]]
		end;
		return nil
	end;
	function AutoHelp.GetUnitGroup(os)
		if not os then
			return 0
		elseif HEAL_GROUP_TYPE_RAID == op() then
			return select(3, GetRaidRosterInfo(oq(os))) or 1
		else
			return 1
		end
	end;
	function GetTargetOrEnmysTarget()
		if not UnitExists("target") and not UnitExists("focus") then
			return nil
		end;
		if UnitInParty("target") or UnitInRaid("target") then
			return GetRaidUnit("target")
		end;
		if UnitIsEnemy("player", "target") and (UnitInParty("targettarget") or UnitInRaid("targettarget")) then
			return GetRaidUnit("targettarget")
		end;
		if UnitIsUnit("player", "target") or UnitIsUnit("player", "targettarget") then
			return HEAL_RAID["player"]
		end;
		if UnitInParty("focus") or UnitInRaid("focus") then
			return GetRaidUnit("focus")
		end;
		if UnitIsUnit("player", "focus") or UnitIsUnit("player", "focustarget") then
			return HEAL_RAID["player"]
		end;
		return nil
	end;
	function GetTargetsEnemy()
		if not UnitExists("targettarget") then
			return nil
		end;
		if UnitCanAttack("player", "targettarget") and not UnitIsDead("targettarget") then
			return BuildUnitInfo("targettarget")
		end
	end;
	function FindBossTargets()
		local d2 = {}
		for oz, tInfo in pairs(HEAL_RAID) do
			if UnitExists(oz .. "target") and UnitLevel(oz .. "target") == - 1 then
				local cd = UnitExists(oz .. "targettarget") and UnitName(oz .. "targettarget")
				local oz = HEAL_RAID_NAMES[cd]
				local tInfo = HEAL_RAID[oz]
				if tInfo and tInfo["role"] == "MAINTANK" then
					local fZ = false;
					for _, h4 in ipairs(d2) do
						if h4 == cd then
							fZ = true
						end
					end;
					if not fZ then
						d2[# d2 + 1] = cd
					end
				end
			end
		end;
		return d2
	end;
	local oA = {
		"boss1",
		"boss2",
		"boss3",
		"boss4",
		"boss5",
		"boss6",
		"boss7",
		"boss8",
		"boss9",
		"boss10",
		"mouseover",
		"target",
		"focus",
		"focustarget",
		"targettarget",
		"mouseovertarget",
		"party1target",
		"party2target",
		"party3target",
		"party4target",
		"raid1target",
		"raid2target",
		"raid3target",
		"raid4target",
		"raid5target",
		"raid6target",
		"raid7target",
		"raid8target",
		"raid9target",
		"raid10target",
		"raid11target",
		"raid12target",
		"raid13target",
		"raid14target",
		"raid15target",
		"raid16target",
		"raid17target",
		"raid18target",
		"raid19target",
		"raid20target",
		"raid21target",
		"raid22target",
		"raid23target",
		"raid24target",
		"raid25target",
		"raid26target",
		"raid27target",
		"raid28target",
		"raid29target",
		"raid30target",
		"raid31target",
		"raid32target",
		"raid33target",
		"raid34target",
		"raid35target",
		"raid36target",
		"raid37target",
		"raid38target",
		"raid39target",
		"raid40target",
		"nameplate1",
		"nameplate2",
		"nameplate3",
		"nameplate4",
		"nameplate5",
		"nameplate6",
		"nameplate7",
		"nameplate8",
		"nameplate9",
		"nameplate10",
		"nameplate11",
		"nameplate12",
		"nameplate13",
		"nameplate14",
		"nameplate15",
		"nameplate16",
		"nameplate17",
		"nameplate18",
		"nameplate19",
		"nameplate20"
	}
	local function oB(oC)
		local oD = GetCVar("nameplateShowEnemies")
		if oD ~= "1" then
			InitNameplates(41)
		end;
		local d2 = {}
		local nE = 0;
		for _, b8 in ipairs(oA) do
			if UnitExists(b8) and not UnitIsDead(b8) and UnitCanAttack("player", b8) then
				local b6 = UnitGUID(b8)
				if b6 and not d2[b6] then
					d2[b6] = true;
					local oE, oF = AutoHelp.GetRange(b8)
					if oF and oF <= (oC or AutoHelp.NAMEPLATES_MAXDISTANCE or 10) then
						nE = nE + 1
					end
				end
			end
		end;
		return nE
	end;
	AutoHelp.getNumberTargets = oB;
	local function oG(jS)
		return GetStatus("HEAL_STATUS_AOE") and oB() >= jS or GetStatus("STATUS_始终AOE")
	end;
	AutoHelp.IsForceAOE = oG;
	function AutoHelp.GetCIDFromGUID(b6)
		if b6 then
			local type, _, oH, _, _, oI, oJ = strsplit("-", b6 or "")
			if type and (type == "Creature" or type == "Vehicle" or type == "Pet") then
				return tonumber(oI)
			elseif type and (type == "Player" or type == "Item") then
				return tonumber(oH)
			end
		end;
		return 0
	end;
	function AutoHelp.GetColorName(tInfo)
		if not tInfo then
			return ""
		end;
		if tInfo["class"] == "WARRIOR" then
			return "\124cffC79C6E" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "PALADIN" then
			return "\124cffF58CBA" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "HUNTER" then
			return "\124cffABD473" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "ROGUE" then
			return "\124cffFFF569" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "PRIEST" then
			return "\124cffFFFFFF" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "MAGE" then
			return "\124cff69CCF0" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "WARLOCK" then
			return "\124cff9482C9" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "DRUID" then
			return "\124cffFF7D0A" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "SHAMAN" then
			return "\124cffF58CBA" .. tInfo["name"] .. "\124r"
		elseif tInfo["class"] == "DEATHKNIGHT" then
			return "\124cffC41F3B" .. tInfo["name"] .. "\124r"
		end;
		return ""
	end;
	function AutoHelp.GetBossTarget(b6)
		if UnitGUID("target") == b6 then
			return GetRaidUnit(UnitName("targettarget"))
		end;
		for oz, tInfo in pairs(HEAL_RAID) do
			if UnitGUID(oz .. "target") == b6 then
				return GetRaidUnit(UnitName(oz .. "targettarget"))
			end
		end;
		for i = 1, 40 do
			if UnitGUID("nameplate" .. i) == b6 then
				return GetRaidUnit(UnitName("nameplate" .. i .. "target"))
			end
		end;
		return nil
	end;
	local oK = {
		["永恒之眼"] = {
			28859
		},
		["纳克萨玛斯"] = {
			15956,
			15953,
			15952,
			15932,
			15931,
			16028,
			15928,
			15990,
			15989,
			16060,
			16063,
			16064,
			16065,
			30549,
			16061,
			15936,
			16011,
			15954
		},
		["黑曜石圣殿"] = {
			28860,
			30451,
			30452,
			30449
		},
		["阿尔卡冯的宝库"] = {
			31125,
			33993,
			35013,
			38433
		},
		["奥杜尔"] = {
			33288,
			33293,
			32865,
			33186,
			33432,
			32930,
			32867,
			32927,
			32857,
			33118,
			32845,
			32926,
			33271,
			32914,
			32915,
			32913,
			32906,
			33113,
			33515,
			32871
		},
		["奥妮克希亚的巢穴"] = {
			10184
		},
		["十字军的试炼"] = {
			34564,
			34458,
			34451,
			34459,
			34448,
			34449,
			34445,
			34456,
			34447,
			34441,
			34454,
			34444,
			34455,
			34450,
			34453,
			34461,
			34460,
			34469,
			34467,
			34468,
			34471,
			34465,
			34466,
			34473,
			34472,
			34470,
			34463,
			34474,
			34475,
			34780,
			34796,
			35144,
			34799,
			34797,
			34497,
			34496
		},
		["晶红圣所"] = {
			39751,
			39863,
			39747,
			39746
		},
		["冰冠堡垒"] = {
			36853,
			36789,
			37970,
			37972,
			37973,
			37955,
			36597,
			37813,
			36855,
			37215,
			37540,
			36612,
			36626,
			36678,
			36627
		}
	}
	local oL = {}
	do
		for k5, n4 in pairs(oK) do
			for _, bi in ipairs(n4) do
				oL[bi] = true
			end
		end
	end;
	function AutoHelp.IsBossTarget()
		local b6 = UnitGUID("target")
		if b6 then
			local oI = AutoHelp.GetCIDFromGUID(b6)
			if oL[oI] then
				return true
			end
		end;
		return false
	end;
	local oM = {
		"nameplate1",
		"nameplate2",
		"nameplate3",
		"nameplate4",
		"nameplate5",
		"nameplate6",
		"nameplate7",
		"nameplate8",
		"nameplate9",
		"nameplate10",
		"nameplate11",
		"nameplate12",
		"nameplate13",
		"nameplate14",
		"nameplate15",
		"nameplate16",
		"nameplate17",
		"nameplate18",
		"nameplate19",
		"nameplate20",
		"nameplate21",
		"nameplate22",
		"nameplate23",
		"nameplate24",
		"nameplate25",
		"nameplate26",
		"nameplate27",
		"nameplate28",
		"nameplate29",
		"nameplate30",
		"nameplate31",
		"nameplate32",
		"nameplate33",
		"nameplate34",
		"nameplate35",
		"nameplate36",
		"nameplate37",
		"nameplate38",
		"nameplate39",
		"nameplate40"
	}
	function FindEnemyUnit(cd)
		for _, ho in ipairs(oM) do
			local oN = UnitName(ho)
			if oN == cd then
				return ho
			end
		end
	end;
	function MouseoverIsTarget()
		return UnitExists("mouseover") and UnitGUID("target") == UnitGUID("mouseover")
	end;
	function MouseoverIsTank()
		if UnitExists("mouseover") then
			local b6 = UnitGUID("mouseover")
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["role"] == "MAINTANK" and UnitGUID(oz) == b6 then
					return true
				end
			end
		end
	end;
	function MouseoverCanAttack()
		return UnitExists("mouseover") and UnitCanAttack("player", "mouseover")
	end;
	function InitNameplates(oC)
		if type(oC) == "number" and oC > 0 then
			SetCVar("nameplateShowEnemies", "1")
			SetCVar("nameplateMaxDistance", oC)
		else
			SetCVar("nameplateShowEnemies", "0")
			SetCVar("nameplateMaxDistance", nil)
		end
	end;
	function GetRaidHealthMax()
		local o1 = 0;
		for oz, lD in pairs(HEAL_RAID) do
			if lD["connected"] and not lD["dead"] then
				o1 = o1 + lD["healthmax"]
			end
		end;
		return o1
	end;
	function GetRaidCurrentHealth()
		local o1 = 0;
		for oz, lD in pairs(HEAL_RAID) do
			if lD["connected"] and not lD["dead"] then
				o1 = o1 + lD["health"]
			end
		end;
		return o1
	end;
	function GetRaidHealthPercent()
		local oO = 0;
		local o1 = 0;
		for oz, lD in pairs(HEAL_RAID) do
			if lD["connected"] and not lD["dead"] then
				oO = oO + lD["health"]
				o1 = o1 + lD["healthmax"]
			end
		end;
		return oO / o1
	end;
	function GetRaidPowerPercent()
		local oO = 0;
		local o1 = 0;
		for oz, lD in pairs(HEAL_RAID) do
			if lD["connected"] and not lD["dead"] then
				if lD["class"] == "PALADIN" or lD["class"] == "HUNTER" or lD["class"] == "PRIEST" or lD["class"] == "MAGE" or lD["class"] == "WARLOCK" or lD["class"] == "DRUID" then
					oO = oO + lD["power"]
					o1 = o1 + lD["powermax"]
				end
			end
		end;
		return oO / o1
	end;
	function GetRaidHealthLost()
		local oO = 0;
		local o1 = 0;
		for oz, lD in pairs(HEAL_RAID) do
			if lD["connected"] and not lD["dead"] then
				oO = oO + lD["health"]
				o1 = o1 + lD["healthmax"]
			end
		end;
		return o1 - oO
	end;
	function GetRaidHealthStatus()
		local oP = 0;
		local oQ = 0;
		local oR = 0;
		local oS = 0;
		local oT = 0;
		local oU = 0;
		local oV = {}
		for oz, lD in pairs(HEAL_RAID) do
			if lD["connected"] and not lD["dead"] then
				oP = oP + lD["health"]
				oQ = oQ + lD["healthmax"]
				local oW, oX = UnitPowerType(lD["unit"])
				if oX == "MANA" then
					oR = oR + lD["power"]
					oS = oS + lD["powermax"]
				end;
				if lD["role"] == "HEALER" then
					oT = oT + lD["power"]
					oU = oU + lD["powermax"]
				end
			end
		end;
		return oP, oQ, oR, oS, oT, oU, oV
	end;
	function GetPartyHealStatus()
		local oP = 0;
		local oQ = 0;
		local oY = 0;
		local oZ = 0;
		for oz, tInfo in pairs(HEAL_RAID_GROUPS) do
			oY = oY + 1;
			if tInfo["connected"] and not tInfo["dead"] and (UnitInRange(tInfo["unit"]) or "player" == tInfo["unit"]) then
				oP = oP + tInfo["health"]
				oQ = oQ + tInfo["healthmax"]
				oZ = oZ + 1
			end
		end;
		return oP, oQ, oY, oZ
	end;
	function getHealthLost(lD)
		if not lD then
			return 0, 0
		end;
		local oO = lD["health"]
		local o_ = lD["healthmax"]
		return o_ - oO, oO / o_
	end;
	function canSpellRange(cx, b8)
		return "player" == b8 or IsSpellInRange(cx, b8) == 1
	end;
	function isInRange(os)
		local lD = HEAL_RAID[os]
		if lD ~= nil then
			return lD["range"]
		end;
		return false
	end;
	function AutoHelp.GetUnitInComingHeals(os, p0, cn)
		if not os then
			return 0
		end;
		cn = cn or 2;
		if AutoHelp.LibHealComm then
			local p1 = UnitGUID(os)
			if p0 then
				local p2 = UnitGUID(p0)
				return (AutoHelp.LibHealComm:GetHealAmount(p1, AutoHelp.LibHealComm.ALL_HEALS, GetTime() + cn, p2) or 0) * (AutoHelp.LibHealComm:GetHealModifier(p1) or 1)
			else
				return (AutoHelp.LibHealComm:GetHealAmount(p1, AutoHelp.LibHealComm.ALL_HEALS, GetTime() + cn) or 0) * (AutoHelp.LibHealComm:GetHealModifier(p1) or 1)
			end
		else
			return 0
		end
	end;
	function AutoHelp.GetOthersHealAmount(os, cn)
		if not os then
			return 0
		end;
		cn = cn or 3;
		if AutoHelp.LibHealComm then
			local p1 = UnitGUID(os)
			return (AutoHelp.LibHealComm:GetOthersHealAmount(p1, AutoHelp.LibHealComm.ALL_HEALS, GetTime() + cn) or 0) * (AutoHelp.LibHealComm:GetHealModifier(p1) or 1)
		else
			return 0
		end
	end;
	function AutoHelp.GetMyHealAmount(os, cn)
		if not os then
			return 0
		end;
		cn = cn or 3;
		if AutoHelp.LibHealComm then
			local p1 = UnitGUID(os)
			local p2 = UnitGUID("player")
			return (AutoHelp.LibHealComm:GetHealAmount(p1, AutoHelp.LibHealComm.ALL_HEALS, GetTime() + cn, p2) or 0) * (AutoHelp.LibHealComm:GetHealModifier(p1) or 1)
		else
			return 0
		end
	end;
	local p3 = {
		"恢复",
		"回春",
		"愈合"
	}
	function AutoHelp.GetUnitComingHP(tInfo, cn, p4)
		if not cn then
			cn = 2.99
		end;
		p4 = p4 or 30;
		if tInfo["role"] == "MAINTANK" then
			p4 = 6
		end;
		local p5 = AutoHelp.GetOthersHealAmount(tInfo["unit"], cn)
		local p6 = AutoHelp.GetMyHealAmount(tInfo["unit"], p4)
		p5 = p5 + p6;
		if p5 == 0 then
			if AutoHelp.UnitHasBuff(tInfo["unit"], unpack(p3)) then
				p5 = 400
			end
		end;
		local p7, p8 = (tInfo["health"] + p5) / tInfo["healthmax"], tInfo["healthmax"] - tInfo["health"] - p5;
		if p7 > 1 then
			p7 = 1
		end;
		if p8 < 0 then
			p8 = 0
		end;
		return p7, p8
	end;
	function HEAL_AddSpellBlackList(oz, p9)
		HEAL_SPELL_BLACKLIST[oz] = p9
	end;
	function HEAL_IsSpellBlackList(oz)
		return HEAL_SPELL_BLACKLIST[oz] ~= nil and HEAL_SPELL_BLACKLIST[oz] > 0
	end;
	function HEAL_IsBlackList(oz)
		local tInfo = HEAL_RAID[oz]
		return HEAL_SPELL_BLACKLIST[oz] ~= nil and HEAL_SPELL_BLACKLIST[oz] > 0 or tInfo ~= nil and tInfo["BLACKLIST"] == true
	end;
	function hasFirstHealList()
		for oz, tInfo in pairs(HEAL_RAID) do
			if tInfo["FIRSTLIST"] then
				return true
			end
		end;
		return false
	end;
	function AutoHelp.HasTanks()
		for oz, cd in pairs(HEAL_RAID_TANKS) do
			return true
		end;
		return false
	end;
	local pa = "NONE"
	local je = GetLocale()
	if je == "zhCN" or je == "zhTW" then
		pa = "无"
	end;
	function AutoHelp.CreateBuffList(pb)
		local n5, md = AutoHelp.GetSpellBooks()
		local pc = {}
		for _, jZ in ipairs(pb) do
			if jZ["name"] == pa then
				local pd = {}
				pd["name"] = jZ["name"]
				pd["title"] = jZ["name"]
				pd["time"] = 0;
				pd["ispower"] = false;
				pd["ShortClassName"] = jZ["name"]
				pd["AutoStatus"] = jZ["AutoStatus"]
				pc[# pc + 1] = pd
			else
				local pe = AutoHelp.GetUsableSpell(jZ["name"])
				if pe then
					local pd = {}
					pd["name"] = jZ["name"]
					pd["time"] = jZ["time"]
					pd["ispower"] = jZ["ispower"]
					pd["icon"] = pe.icon;
					pd["title"] = "\124T" .. pe.icon .. ":12:12\124t" .. pe.spellName;
					pd["ShortClassName"] = "\124T" .. pe.icon .. ":12:12\124t"
					pd["AutoStatus"] = jZ["AutoStatus"]
					pc[# pc + 1] = pd
				end
			end
		end;
		return pc
	end;
	function AutoHelp.GetLagTime()
		return select(4, GetNetStats()) / 1000
	end;
	local ke = fkbase;
	local function pf()
		local b5 = select(2, UnitClass("player"))
		if ke and ke.v then
			if b5 == "PALADIN" then
				ke.v(ke.PaladinConfig)
			elseif b5 == "PRIEST" then
				ke.v(ke.PriestConfig)
			elseif b5 == "MAGE" then
				ke.v(ke.MageConfig)
			elseif b5 == "DRUID" then
				ke.v(ke.DruidConfig)
			elseif b5 == "ROGUE" then
				ke.v(ke.RogueConfig)
			elseif b5 == "HUNTER" then
				ke.v(ke.HunterConfig)
			elseif b5 == "SHAMAN" then
				ke.v(ke.ShamanConfig)
			elseif b5 == "WARRIOR" then
				ke.v(ke.WarriorConfig)
			end;
			ke.v(ke.HealHelp)
		end
	end;
	function AutoHelp:Target(b8)
	end;
	AutoHelp.TargetUnit = AutoHelp.Target;
	local pg = nil;
	function AutoHelp.GetPlayerInfo()
		if pg == nil then
			pg = CreateFrame("EditBox", nil, UIParent)
			pg:SetPoint("TOP", 0, 130)
			pg:SetSize(900, 50)
			pg:SetFont(ChatFontNormal:GetFont())
			pg:SetAutoFocus(true)
			pg:SetMultiLine(false)
			pg:SetScript("OnEscapePressed", function()
				pg:Hide()
			end)
			local ph = false;
			pg:SetScript("OnKeyDown", function(_, p)
				if p == "C" and IsControlKeyDown() then
					pg:SetAutoFocus(true)
					ph = true
				end
			end)
			pg:SetScript("OnKeyUp", function(_, p)
				pg:Hide()
			end)
			pg:Hide()
		end;
		local im = AutoHelp.playerName .. "|" .. AutoHelp.playerLevel .. "|" .. AutoHelp.playerClassName .. "|" .. GetMinimapZoneText()
		pg:SetText(im)
		pg:Show()
		pg:HighlightText()
	end;
	pf()
	local function pi(pj)
		for ma = 1, 120 do
			local pk, bi, o4 = GetActionInfo(ma)
			if pk == "macro" and bi == pj then
				return true
			end
		end
	end;
	function ClearOldAHMacros()
		for i = 0 + select(1, GetNumMacros()), 1, - 1 do
			local cd, lT, pl = GetMacroInfo(i)
			if cd and cd:sub(1, 2) == "AH" then
				DeleteMacro(i)
			end
		end;
		for i = 120 + select(2, GetNumMacros()), 121, - 1 do
			local cd, lT, pl = GetMacroInfo(i)
			if cd and cd:sub(1, 2) == "AH" then
				DeleteMacro(i)
			end
		end
	end;
	function FindOrCreateMacro(cd, lT, pl, pm, pn, p, po)
		if lT == nil then
			lT = "INV_MISC_QUESTIONMARK"
		end;
		local pp = GetMacroIndexByName(cd)
		if pp == 0 then
			local pq, pr = GetNumMacros()
			local ps = true;
			if pr >= 18 then
				ps = false
			end;
			if pq < 120 then
				pp = CreateMacro(cd, lT, pl, ps)
				pn = true
			else
				AutoHelp.Debug("####您的宏位置满了, 请删除不用的宏,用来创建职业宏!####")
			end
		else
			pp = EditMacro(cd, cd, lT, pl, 1, 1)
		end;
		if pm ~= nil and pm > 0 and not pi(pp) then
			PickupMacro(pp)
			PlaceAction(pm)
			ClearCursor()
		end;
		if p ~= nil then
			SetBinding(p, po)
		end;
		return pp
	end;
	function fmttxt(b7, pt)
		if b7 == nil then
			b7 = " "
		end;
		local pu = pt - string.len(b7)
		for i = 1, pu do
			b7 = b7 .. " "
		end;
		return b7
	end;
	do
		local pv = {}
		local pw = 1;
		local px = 0;
		function AutoHelp.AddAction(jp)
			px = px + 1;
			pv[px] = jp
		end;
		function AutoHelp.GetNextAction()
			if pw > px then
				pw = 1;
				px = 0;
				return nil
			end;
			local jp = pv[pw]
			pv[pw] = nil;
			pw = pw + 1;
			return jp
		end;
		function AutoHelp.ClearAction()
			while AutoHelp.GetNextAction() do
			end
		end;
		function AutoHelp.HasAction()
			return pw <= px
		end
	end;
	do
		local py = {}
		local pz = 0;
		local pA = - 1;
		local pB = {}
		pB.Add = function(jp)
			pA = pA + 1;
			py[pA] = jp
		end;
		pB.Get = function()
			if pz > pA then
				pz = 0;
				pA = - 1;
				return nil
			end;
			local jp = py[pz]
			py[pz] = nil;
			pz = pz + 1;
			return jp
		end;
		pB.Clear = function()
			while pB.Get() do
			end
		end;
		pB.Has = function()
			return pz <= pA
		end;
		AutoHelp.MoveQueue = pB
	end;
	MOVE_DOWN = 1;
	MOVE_UP = 2;
	do
		local pC = {}
		local pD;
		pC.IsRunning = function()
			return IsPlayerMoving()
		end;
		pC.StartRun = function()
			if not pD or not IsPlayerMoving() then
				AutoHelp.TryMoveAction("StartRun")
				pD = true
			end
		end;
		pC.StopRun = function()
			if pD or IsPlayerMoving() then
				AutoHelp.TryMoveAction("StopRun")
				pD = false
			end
		end;
		pC.Foward = function(minsec)
			AutoHelp.TryMoveAction("Foward", minsec)
		end;
		pC.Back = function(minsec)
			AutoHelp.TryMoveAction("Back", minsec)
		end;
		pC.Jump = function()
			AutoHelp.TryMoveAction("Jump", minsec)
		end;
		pC.LeftTurn = function(minsec)
			AutoHelp.TryMoveAction("LeftTurn", minsec)
		end;
		pC.RightTurn = function(minsec)
			AutoHelp.TryMoveAction("RightTurn", minsec)
		end;
		pC.LeftMove = function(minsec)
			AutoHelp.TryMoveAction("LeftMove", minsec)
		end;
		pC.RightMove = function(minsec)
			AutoHelp.TryMoveAction("RightMove", minsec)
		end;
		AutoHelp.WalkRoute = pC
	end;
	local pE = 3.14159;
	local function pF(pG, pH, pI, pJ)
		local pK = math.atan2(pJ - pH, pG - pI)
		pK = pK + math.pi;
		pK = pK - math.pi * 0.5;
		if pK < 0 then
			pK = pK + math.pi * 2
		end;
		if pK > math.pi * 2 then
			pK = pK - math.pi * 2
		end;
		return pK
	end;
	local function pL(pM)
		if pM > math.pi then
			pM = (math.pi * 2 - pM) * - 1
		end;
		if pM < - math.pi then
			pM = math.pi * 2 - pM * - 1
		end;
		return pM
	end;
	local function pN(pI, pJ)
		local pG, pH, ex = jw:GetPlayerWorldPosition()
		local hn, hm = jw:GetWorldVector(ex, pG, pH, pI, pJ)
		local pO = hn - GetPlayerFacing()
		pO = pL(pO)
		local pP = pO / math.pi * 1000;
		return hm, math.ceil(pP)
	end;
	local pQ = {}
	function AutoHelp.SavePos()
		local pG, pH, ex = jw:GetPlayerWorldPosition()
		pQ[1] = pG;
		pQ[2] = pH;
		pQ[3] = ex;
		SetConfig("savepos", pQ)
		print("Save position:", pG, pH, ex)
	end;
	local pR = 0;
	function AutoHelp.MoveTo(pI, pJ)
		if not AutoHelp.MoveHasDone then
			return false
		end;
		local pS = GetPlayerFacing()
		if pS == nil then
			return false
		end;
		local hm, pP = pN(pI, pJ)
		print("distance=", hm)
		if hm <= 1 then
			print("stop walk")
			AutoHelp.WalkRoute.StopRun()
			return true
		end;
		if pP < 0 then
			pP = math.ceil(math.abs(pP))
			if pP > 100 then
				print("right=", pP)
				if IsPlayerMoving() then
					AutoHelp.WalkRoute.StopRun()
				else
					AutoHelp.WalkRoute.RightTurn(pP)
				end;
				return false
			end
		else
			pP = math.ceil(math.abs(pP))
			if pP > 100 then
				print("left=", pP)
				if IsPlayerMoving() then
					AutoHelp.WalkRoute.StopRun()
				else
					AutoHelp.WalkRoute.LeftTurn(pP)
				end;
				return false
			end
		end;
		if hm > 1 and not AutoHelp.WalkRoute.IsRunning() then
			print("start walk")
			AutoHelp.WalkRoute.StartRun()
			return false
		end;
		pR = pR + 1;
		if pR > 30 then
			AutoHelp.WalkRoute.Jump()
			pR = 0
		end
	end;
	function AutoHelp.StartWalkRoute()
		AutoHelp.WalkStarted = not AutoHelp.WalkStarted;
		if not AutoHelp.WalkStarted then
			AutoHelp.WalkRoute.StopRun()
		end;
		print(AutoHelp.WalkStarted)
	end;
	function AutoHelp.WalkRouteStart()
		print("WALKROUTESTART")
		local pQ = jy("savepos")
		local pI, pJ, ex = pQ[1], pQ[2], pQ[3]
		print("RouteStart", pI, pJ)
		if AutoHelp.MoveTo(pI, pJ) then
			AutoHelp.WalkStarted = false;
			return true
		end;
		return false
	end;
	function AutoHelp.TestDis()
		local pT = 1.499;
		local a5 = ""
		local pU = 0;
		local pV = 0;
		local pW = 0;
		local pX = 0;
		local pO = 0;
		local pY, pZ = 0, 0;
		local p_ = C_Map.GetBestMapForUnit("player")
		local gW, y = C_Map.GetPlayerMapPosition(p_, "player"):GetXY()
		local q0, q1 = C_Map.GetPlayerMapPosition(p_, 'target'):GetXY()
		gW = gW * 100;
		y = y * 100;
		q0 = q0 * 100;
		q1 = q1 * 100;
		pY = (gW - q0) * pT;
		pZ = y - q1;
		pU = (pY * pY + pZ * pZ) ^ 0.5;
		local q2 = select(1, UnitDistanceSquared('target'))
		pV = q2 ^ 0.5;
		pO = pV / pU;
		function ComputeDistance(q3, q4)
			local q5, q6, _, q7 = UnitPosition(q3)
			local q1, q0, _, q8 = UnitPosition(q4)
			return ((q0 - q6) ^ 2 + (q1 - q5) ^ 2) ^ 0.5
		end;
		function ComputeDistance2(q3, q4)
			local q5, q6, _, q7 = UnitPosition(q3)
			local q1, q0, _, q8 = UnitPosition(q4)
			return ((q0 - q6) ^ 2 + (q1 - q5) ^ 2) ^ 0.5
		end;
		pW = ComputeDistance('player', 'target')
		pX = ComputeDistance2('player', 'target')
		a5 = a5 .. "player х:" .. gW .. " y:" .. y .. "\n"
		a5 = a5 .. "target х:" .. q0 .. " y:" .. q1 .. "\n"
		a5 = a5 .. "coords_dist:" .. pU .. " yards:" .. pV .. " coeff=" .. pO .. "\n"
		a5 = a5 .. "coords to yards: " .. math.floor(pU * pO * 100) / 100 .. "\n"
		a5 = a5 .. "dist3: " .. pW .. "\n"
		a5 = a5 .. "dist4: " .. pX .. "\n"
		return a5
	end;
	function RandomNum(q9, qa)
		return math.random(q9, qa)
	end;
	local qb = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	local function qc(fj)
		local h4 = {}
		for _, gW in pairs(fj) do
			local kO, cp = '', gW;
			for i = 8, 1, - 1 do
				kO = kO .. (cp % 2 ^ i - cp % 2 ^ (i - 1) > 0 and '1' or '0')
			end;
			h4[# h4 + 1] = kO
		end;
		h4[# h4 + 1] = '0000'
		local kO = {}
		table.concat(h4):gsub('%d%d%d?%d?%d?%d?', function(gW)
			if # gW < 6 then
				return nil
			end;
			local jg = 0;
			for i = 1, 6 do
				jg = jg + (gW:sub(i, i) == '1' and 2 ^ (6 - i) or 0)
			end;
			kO[# kO + 1] = qb:sub(jg + 1, jg + 1)
		end)
		kO[# kO + 1] = ({
			'',
			'==',
			'='
		})[# fj % 3 + 1]
		return table.concat(kO)
	end;
	local function qd(fj)
		fj = string.gsub(fj, '[^' .. qb .. '=]', '')
		local h4 = {}
		fj:gsub('.', function(gW)
			if gW == '=' then
				return ''
			end;
			local kO, k5 = '', qb:find(gW) - 1;
			for i = 6, 1, - 1 do
				kO = kO .. (k5 % 2 ^ i - k5 % 2 ^ (i - 1) > 0 and '1' or '0')
			end;
			return kO
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(gW)
			if # gW ~= 8 then
				return nil
			end;
			local jg = 0;
			for i = 1, 8 do
				jg = jg + (gW:sub(i, i) == '1' and 2 ^ (8 - i) or 0)
			end;
			h4[# h4 + 1] = jg
		end)
		return h4
	end;
	local qe, qf, qg = bit.band, bit.bxor, bit.rshift;
	local qh = {0,1996959894,3993919788,2567524794,124634137,1886057615,3915621685,2657392035,249268274,2044508324,3772115230,2547177864,162941995,2125561021,3887607047,2428444049,498536548,1789927666,4089016648,2227061214,450548861,1843258603,4107580753,2211677639,325883990,1684777152,4251122042,2321926636,335633487,1661365465,4195302755,2366115317,997073096,1281953886,3579855332,2724688242,1006888145,1258607687,3524101629,2768942443,901097722,1119000684,3686517206,2898065728,853044451,1172266101,3705015759,2882616665,651767980,1373503546,3369554304,3218104598,565507253,1454621731,3485111705,3099436303,671266974,1594198024,3322730930,2970347812,795835527,1483230225,3244367275,3060149565,1994146192,31158534,2563907772,4023717930,1907459465,112637215,2680153253,3904427059,2013776290,251722036,2517215374,3775830040,2137656763,141376813,2439277719,3865271297,1802195444,476864866,2238001368,4066508878,1812370925,453092731,2181625025,4111451223,1706088902,314042704,2344532202,4240017532,1658658271,366619977,2362670323,4224994405,1303535960,984961486,2747007092,3569037538,1256170817,1037604311,2765210733,3554079995,1131014506,879679996,2909243462,3663771856,1141124467,855842277,2852801631,3708648649,1342533948,654459306,3188396048,3373015174,1466479909,544179635,3110523913,3462522015,1591671054,702138776,2966460450,3352799412,1504918807,783551873,3082640443,3233442989,3988292384,2596254646,62317068,1957810842,3939845945,2647816111,81470997,1943803523,3814918930,2489596804,225274430,2053790376,3826175755,2466906013,167816743,2097651377,4027552580,2265490386,503444072,1762050814,4150417245,2154129355,426522225,1852507879,4275313526,2312317920,282753626,1742555852,4189708143,2394877945,397917763,1622183637,3604390888,2714866558,953729732,1340076626,3518719985,2797360999,1068828381,1219638859,3624741850,2936675148,906185462,1090812512,3747672003,2825379669,829329135,1181335161,3412177804,3160834842,628085408,1382605366,3423369109,3138078467,570562233,1426400815,3317316542,2998733608,733239954,1555261956,3268935591,3050360625,752459403,1541320221,2607071920,3965973030,1969922972,40735498,2617837225,3943577151,1913087877,83908371,2512341634,3803740692,2075208622,213261112,2463272603,3855990285,2094854071,198958881,2262029012,4057260610,1759359992,534414190,2176718541,4139329115,1873836001,414664567,2282248934,4279200368,1711684554,285281116,2405801727,4167216745,1634467795,376229701,2685067896,3608007406,1308918612,956543938,2808555105,3495958263,1231636301,1047427035,2932959818,3654703836,1088359270,936918000,2847714899,3736837829,1202900863,817233897,3183342108,3401237130,1404277552,615818150,3134207493,3453421203,1423857449,601450431,3009837614,3294710456,1567103746,711928724,3020668471,3272380065,1510334235,755167117}
	local function qi(h4)
		local qj, qk = 4294967295, # h4;
		for i = 1, qk do
			qj = qf(qg(qj, 8), qh[qe(qf(qj, h4[i]), 255) + 1])
		end;
		return qf(qj, - 1)
	end;
	local function ql(js)
		if type(js) ~= 'string' then
			return {}
		end;
		local kO = {}
		for i = 1, string.len(js) do
			kO[# kO + 1] = string.byte(js, i)
		end;
		return kO
	end;
	local function qm(js)
		if type(js) ~= 'table' then
			return ''
		end;
		local h4 = {}
		for _, jg in pairs(js) do
			h4[# h4 + 1] = string.char(jg)
		end;
		return table.concat(h4)
	end;
	local function qn()
		local qo = GetSpellBonusDamage(3)
		local qp = GetSpellBonusDamage(4)
		local qq = GetSpellBonusDamage(5)
		local qr = GetSpellBonusDamage(6)
		local qs = GetSpellBonusDamage(7)
		local qt = {
			qo,
			qp,
			qq,
			qr,
			qs
		}
		local qu = math.max(unpack(qt))
		local qv = GetInventoryItemID("player", 18)
		if qv == 45270 then
			sx = 396
		else
			sx = 0
		end;
		local qw = 1;
		local qx = 1;
		local qy = false;
		if AutoHelp.UnitHasBuff("player", 464972) then
			qw = 1.15
		else
			qw = 1.15;
			AutoHelp.Debug("\124cfff00000当前处于奥杜尔副本外, 模拟计算加上15%增伤!\124r")
		end;
		if AutoHelp.UnitHasBuff("player", 54043) then
			qx = 1.03
		end;
		local qz = {
			head = 39545,
			shoulders = 39548,
			chest = 39547,
			gloves = 39544,
			legs = 39546,
			head2 = 40467,
			shoulders2 = 40470,
			chest2 = 40469,
			gloves2 = 40466,
			legs2 = 40468
		}
		local qA = 0;
		local kq = GetInventoryItemID("player", 1)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 3)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 5)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 7)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 10)
		if qz[kq] then
			qA = qA + 1
		end;
		if qA >= 2 then
			t7 = 0.1
		else
			t7 = 0
		end;
		local qB = 1;
		if AutoHelp.Glyphs[54845] then
			qB = 1.3
		end;
		local qC = 6;
		if AutoHelp.HEAL_PLAYER_TALENTS[GetSpellInfo(57865)] == 1 then
			qC = 7
		end;
		local qD = (215 + (qu + sx) * 0.2) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qE = (172 + (qu + sx) * 0.2) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qF = (124 + (qu + sx) * 0.11) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qG = (90 + (qu + sx) * 0.01) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qH = 62 * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		AutoHelp.Debug("当前法术强度: " .. qu .. ", 虫群伤害:")
		AutoHelp.Debug("========================")
		AutoHelp.Debug("7级   " .. floor(qD) .. "  [" .. floor(qD / qC) .. "/跳]")
		AutoHelp.Debug("6级   " .. floor(qE) .. "  [" .. floor(qE / qC) .. "/跳]")
		AutoHelp.Debug("5级   " .. floor(qF) .. "  [" .. floor(qF / qC) .. "/跳]")
		AutoHelp.Debug("4级   " .. floor(qG) .. "  [" .. floor(qG / qC) .. "/跳]")
		AutoHelp.Debug("3级   " .. floor(qH) .. "   [" .. floor(qH / qC) .. "/跳]")
		AutoHelp.Debug("========================")
		AutoHelp.Debug("10H修星建议[使用虫群等级]:")
		local qI = {
			qE * 2,
			qD + qE,
			qD * 2,
			qD * 2 + qH,
			qD + qE + qG,
			qD * 2 + qG,
			qD + qE + qF,
			qD + qD + qF,
			qE * 3,
			qD * 3
		}
		local qJ = {
			"66",
			"76",
			"77",
			"773",
			"764",
			"774",
			"765",
			"775",
			"666",
			"777"
		}
		local fZ = 0;
		for i = 1, # qI do
			local qK = floor(qI[i])
			if qK > 18000 and qK < 21000 then
				fZ = fZ + 1;
				if qJ[i] == "66" or qJ[i] == "77" or qJ[i] == "666" or qJ[i] == "777" then
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. " \124cffFFF569[建议选择]\124r")
				else
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. "\124r")
				end
			end
		end;
		if fZ == 0 then
			AutoHelp.Debug("您的法术强度太低,无法完成10H修星!")
		end;
		AutoHelp.Debug("=======================")
		AutoHelp.Debug("25H修星建议[使用虫群等级]:")
		local qL = {
			qD * 2 + qF * 2,
			qD * 2 + qE + qF,
			qD * 3 + qF,
			qD + qE * 3,
			qD * 2 + qE * 2,
			qD * 3 + qE,
			qD * 4
		}
		local qJ = {
			"7755",
			"7765",
			"7775",
			"7666",
			"7766",
			"7776",
			"7777"
		}
		local fZ = 0;
		for i = 1, # qL do
			local qK = floor(qL[i])
			if qK > 36000 and qK < 40000 then
				fZ = fZ + 1;
				if qJ[i] == "7755" or qJ[i] == "7666" or qJ[i] == "7777" then
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. " \124cffFFF569[建议选择]\124r")
				else
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. "\124r")
				end
			end
		end;
		if fZ == 0 then
			AutoHelp.Debug("您的法术强度太低,无法25H完成修星!")
		end
	end;
	local function qM()
		local qo = GetSpellBonusDamage(3)
		local qp = GetSpellBonusDamage(4)
		local qq = GetSpellBonusDamage(5)
		local qr = GetSpellBonusDamage(6)
		local qs = GetSpellBonusDamage(7)
		local qt = {
			qo,
			qp,
			qq,
			qr,
			qs
		}
		local qu = math.max(unpack(qt))
		local qv = GetInventoryItemID("player", 18)
		if qv == 45270 then
			sx = 396
		else
			sx = 0
		end;
		local qw = 1;
		local qx = 1;
		local qy = false;
		if AutoHelp.UnitHasBuff("player", 464972) then
			qw = 1.15
		else
			qw = 1.15;
			AutoHelp.Debug("\124cfff00000当前处于奥杜尔副本外, 模拟计算加上15%增伤!\124r")
		end;
		if AutoHelp.UnitHasBuff("player", 54043) then
			qx = 1.03
		end;
		local qz = {
			head = 39545,
			shoulders = 39548,
			chest = 39547,
			gloves = 39544,
			legs = 39546,
			head2 = 40467,
			shoulders2 = 40470,
			chest2 = 40469,
			gloves2 = 40466,
			legs2 = 40468
		}
		local qA = 0;
		local kq = GetInventoryItemID("player", 1)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 3)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 5)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 7)
		if qz[kq] then
			qA = qA + 1
		end;
		local kq = GetInventoryItemID("player", 10)
		if qz[kq] then
			qA = qA + 1
		end;
		if qA >= 2 then
			t7 = 0.1
		else
			t7 = 0
		end;
		local qB = 1;
		if AutoHelp.Glyphs[54845] then
			qB = 1.3
		end;
		local qC = 6;
		if AutoHelp.HEAL_PLAYER_TALENTS[GetSpellInfo(57865)] == 1 then
			qC = 7
		end;
		local qD = (215 + (qu + sx) * 0.2) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qE = (172 + (qu + sx) * 0.2) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qF = (124 + (qu + sx) * 0.11) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qG = (90 + (qu + sx) * 0.01) * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		local qH = 62 * qB * 1.06 * 1.04 * qC * qw * qx * (1 + t7)
		AutoHelp.Debug("当前法术强度: " .. qu .. ", 虫群伤害:")
		AutoHelp.Debug("========================")
		AutoHelp.Debug("7级   " .. floor(qD) .. "  [" .. floor(qD / qC) .. "/跳]")
		AutoHelp.Debug("6级   " .. floor(qE) .. "  [" .. floor(qE / qC) .. "/跳]")
		AutoHelp.Debug("5级   " .. floor(qF) .. "  [" .. floor(qF / qC) .. "/跳]")
		AutoHelp.Debug("4级   " .. floor(qG) .. "  [" .. floor(qG / qC) .. "/跳]")
		AutoHelp.Debug("3级   " .. floor(qH) .. "   [" .. floor(qH / qC) .. "/跳]")
		AutoHelp.Debug("========================")
		AutoHelp.Debug("10H修星建议[使用虫群等级]:")
		local qI = {
			qE * 2,
			qD + qE,
			qD * 2,
			qD * 2 + qH,
			qD + qE + qG,
			qD * 2 + qG,
			qD + qE + qF,
			qD + qD + qF,
			qE * 3,
			qD * 3
		}
		local qJ = {
			"66",
			"76",
			"77",
			"773",
			"764",
			"774",
			"765",
			"775",
			"666",
			"777"
		}
		local fZ = 0;
		for i = 1, # qI do
			local qK = floor(qI[i])
			if qK > 18000 and qK < 21000 then
				fZ = fZ + 1;
				if qJ[i] == "66" or qJ[i] == "77" or qJ[i] == "666" or qJ[i] == "777" then
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. " \124cffFFF569[建议选择]\124r")
				else
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. "\124r")
				end
			end
		end;
		if fZ == 0 then
			AutoHelp.Debug("您的法术强度太低,无法完成10H修星!")
		end;
		AutoHelp.Debug("=======================")
		AutoHelp.Debug("25H修星建议[使用虫群等级]:")
		local qL = {
			qD * 2 + qF * 2,
			qD * 2 + qE + qF,
			qD * 3 + qF,
			qD + qE * 3,
			qD * 2 + qE * 2,
			qD * 3 + qE,
			qD * 4
		}
		local qJ = {
			"7755",
			"7765",
			"7775",
			"7666",
			"7766",
			"7776",
			"7777"
		}
		local fZ = 0;
		for i = 1, # qL do
			local qK = floor(qL[i])
			if qK > 36000 and qK < 40000 then
				fZ = fZ + 1;
				if qJ[i] == "7755" or qJ[i] == "7666" or qJ[i] == "7777" then
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. " \124cffFFF569[建议选择]\124r")
				else
					AutoHelp.Debug("\124cff00ff00#" .. fZ .. ": " .. qJ[i] .. ", 伤害: " .. qK .. "\124r")
				end
			end
		end;
		if fZ == 0 then
			AutoHelp.Debug("您的法术强度太低,无法25H完成修星!")
		end
	end;
	if b5 == "DRUID" then
		AutoHelp.XiuXingHelp = qn
	end;
	if b5 == "WARLOCK" then
		AutoHelp.XiuXingHelp = qM
	end
end;
jf()
if AutoHelp.isWotlk then
	local function qN()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {
			[1] = GetSpellInfo(19750),
			[2] = GetSpellInfo(635),
			[5] = GetSpellInfo(7328)
		}
		AutoHelp.RESCURIT_NAME = GetSpellInfo(7328)
		AutoHelp.RESCURIT_KEY = "救赎"
		AutoHelp.CAN_RESCURIT = true;
		AutoHelp.CAN_HEAL = true;
		AutoHelp.CAN_BUFF = true;
		AutoHelp.CAN_DISPEL = true;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 1;
		AutoHelp.AttackRange = 2;
		AutoHelp.DispelMagicKey = GetSpellInfo(4987)
		AutoHelp.DispelDiseaseKey = GetSpellInfo(4987)
		AutoHelp.DispelPoisonKey = GetSpellInfo(4987)
		if not GetSpellInfo(AutoHelp.DispelDiseaseKey) then
			AutoHelp.DispelDiseaseKey = GetSpellInfo(1152)
			AutoHelp.DispelPoisonKey = GetSpellInfo(1152)
		end;
		AutoHelp.CommingHealWindow = 1.5;
		AutoHelp.CommingHotWindow = 1.5;
		AutoHelp.LastHealTeamAction = {}
		local function qO(jI)
			local kH = jy("HEALMODE")
			if kH == "惩戒" or kH == "防护" then
				return
			end;
			if jI then
				AutoHelp.ShowItem("HEAL_STATUS_主动开怪2")
				AutoHelp.ShowItem("STATUS_目标互动2")
				AutoHelp.ShowItem("STATUS_自动寻怪2")
				AutoHelp.ShowItem("STATUS_自动拾取2")
				AutoHelp.ShowItems("normal")
				AutoHelp.ResizePanel()
			else
				AutoHelp.HideItem("HEAL_STATUS_主动开怪2")
				AutoHelp.HideItem("STATUS_目标互动2")
				AutoHelp.HideItem("STATUS_自动寻怪2")
				AutoHelp.HideItem("STATUS_自动拾取2")
				AutoHelp.HideItems("normal")
				AutoHelp.ResizePanel()
			end
		end;
		local n9 = {
			{
				name = "圣光术",
				spellId = true,
				["target"] = true,
				["useCrit"] = {
					"神恩术",
					"神启"
				},
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "圣光闪现",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "神圣震击",
				spellId = true,
				["healType"] = 1,
				["target"] = true,
				["useCrit"] = {
					"神恩术",
					"神启"
				},
				["fastSpell"] = true
			},
			{
				name = "圣洁护盾",
				spellId = true,
				["target"] = true,
				["auraNameCID2"] = true,
				["auraRT"] = 2
			},
			{
				name = "牺牲之手",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "正义盾击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "神圣之盾",
				spellId = true,
				["auraNameCID"] = true,
				["auraRT"] = 1.5
			},
			{
				name = "复仇者之盾",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "正义之锤",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "十字军打击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "神圣风暴",
				spellId = true,
				["attack"] = true
			},
			{
				name = "清算之手",
				spellId = true,
				["target"] = true
			},
			{
				name = "正义防御",
				spellId = true,
				["target"] = true
			},
			{
				name = "神圣恳求",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "神圣恳求2",
				spellId = 54428,
				["auraName"] = "神圣恳求",
				["macro"] = "/cast 复仇之怒\n/cast 神圣恳求\n"
			},
			{
				name = "焦点牺牲",
				spellId = 6940,
				["auraName"] = "牺牲之手",
				["macro"] = "/cast [target=focus,exists,nodead,help] 牺牲之手\n"
			},
			{
				name = "光环掌握",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "圣盾术",
				spellId = true,
				["debuffName"] = 25771
			},
			{
				name = "圣佑术",
				spellId = true,
				["debuffName"] = 25771
			},
			{
				name = "保护之手",
				spellId = true,
				["target"] = true,
				["debuffName"] = 25771
			},
			{
				name = "拯救之手",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "自由之手",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "圣光道标",
				spellId = true,
				["target"] = true,
				["auraNameCID2"] = true,
				["auraRT"] = 2
			},
			{
				name = "复仇之怒",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "公正审判",
				spellId = true,
				["target"] = true,
				["macro"] = "/cast [target=@target,harm][target=targettarget,harm]公正审判"
			},
			{
				name = "圣光审判",
				spellId = true,
				["target"] = true,
				["macro"] = "/cast [target=@target,harm][target=targettarget,harm]圣光审判"
			},
			{
				name = "智慧审判",
				spellId = true,
				["target"] = true,
				["macro"] = "/cast [target=@target,harm][target=targettarget,harm]智慧审判"
			},
			{
				name = "审判",
				spellId = true,
				["target"] = true,
				["spellName"] = "审判",
				["macro"] = "/cast [target=@target,harm][target=targettarget,harm]审判"
			},
			{
				name = "光明圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "智慧圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "正义圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "公正圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "命令圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "复仇圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "腐蚀圣印",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "虔诚光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "惩戒光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "专注光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "暗影抗性光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "冰霜抗性光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "火焰抗性光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "十字军光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "制裁之锤",
				spellId = true,
				["target"] = true
			},
			{
				name = "圣疗术",
				spellId = true,
				["target"] = true,
				["debuffName"] = 25771
			},
			{
				name = "救赎",
				spellId = true,
				["comkey"] = true,
				["target"] = true
			},
			{
				name = "正义之怒",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "感知亡灵",
				spellId = true
			},
			{
				name = "驱邪术",
				spellId = true,
				["target"] = true
			},
			{
				name = "超度邪恶",
				spellId = true,
				["target"] = true
			},
			{
				name = "神圣干涉",
				spellId = true,
				["target"] = true
			},
			{
				name = "清洁术",
				spellId = true,
				["target"] = true
			},
			{
				name = "纯净术",
				spellId = true,
				["target"] = true
			},
			{
				name = "愤怒之锤",
				spellId = true,
				["target"] = true
			},
			{
				name = "神圣愤怒",
				spellId = true
			},
			{
				name = "战马",
				spellId = true,
				["comkey"] = true,
				["auraNameCID"] = true,
				["spellTime"] = 4
			},
			{
				name = "军马",
				spellId = true,
				["comkey"] = true,
				["auraNameCID"] = true,
				["spellTime"] = 4
			},
			{
				name = "奉献",
				spellId = true
			},
			{
				name = "神恩术",
				spellId = true
			},
			{
				name = "忏悔",
				spellId = true
			},
			{
				name = "强效王者祝福",
				spellId = true,
				["target"] = true
			},
			{
				name = "强效庇护祝福",
				spellId = true,
				["target"] = true
			},
			{
				name = "强效智慧祝福",
				spellId = true,
				["target"] = true
			},
			{
				name = "强效力量祝福",
				spellId = true,
				["target"] = true
			},
			{
				name = "力量祝福",
				spellId = true,
				["target"] = true,
				["auraName"] = "强效力量祝福"
			},
			{
				name = "智慧祝福",
				spellId = true,
				["target"] = true,
				["auraName"] = "强效智慧祝福"
			},
			{
				name = "王者祝福",
				spellId = true,
				["target"] = true,
				["auraName"] = "强效王者祝福"
			},
			{
				name = "强效光明祝福",
				spellId = true,
				["target"] = true
			},
			{
				name = "光明祝福",
				spellId = true,
				["target"] = true,
				["auraName"] = "强效光明祝福"
			},
			{
				name = "庇护祝福",
				spellId = true,
				["target"] = true,
				["auraName"] = "强效庇护祝福"
			},
			{
				name = "神圣牺牲",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				["name"] = "取消牺牲",
				["macro"] = "/cancelaura 神圣牺牲",
				["spellTime"] = 0.5,
				["desc"] = "取消牺牲"
			}
		}
		local pa = "NONE"
		local je = GetLocale()
		if je == "zhCN" or je == "zhTW" then
			pa = "无"
		end;
		local qP = {
			{
				["name"] = "无"
			},
			{
				["name"] = "强效王者祝福",
				["time"] = 5,
				["ispower"] = true,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "强效智慧祝福",
				["time"] = 5,
				["ispower"] = true,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "强效力量祝福",
				["time"] = 5,
				["ispower"] = true,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "强效庇护祝福",
				["time"] = 5,
				["ispower"] = true,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "强效光明祝福",
				["time"] = 5,
				["ispower"] = true,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "王者祝福",
				["time"] = 1,
				["ispower"] = false,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "智慧祝福",
				["time"] = 1,
				["ispower"] = false,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "力量祝福",
				["time"] = 1,
				["ispower"] = false,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "庇护祝福",
				["time"] = 1,
				["ispower"] = false,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			},
			{
				["name"] = "光明祝福",
				["time"] = 1,
				["ispower"] = false,
				["AutoStatus"] = "HEAL_STATUS_AUTOBUFF"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.ClassBuffList = AutoHelp.CreateBuffList(qP)
			AutoHelp.DefaultMode = "治疗"
			AutoHelp.ModeDefaultSetting = {
				["STATUS_治疗模式"] = true,
				["HEAL_STATUS_FIRSTDISPAL"] = false,
				["HEAL_OVERHEAL_VALUE"] = 98,
				["HEAL_STATUS_AUTOHEAL"] = true,
				["HEAL_AUTO_VALUE"] = 90,
				["HEAL_STATUS_FIRSTTANK"] = true,
				["HEAL_FIRSTTANK_VALUE"] = 60,
				["ONLYHEALTARGET"] = false,
				["ONLYHEALTARGET_ALWAYSHEAL"] = false,
				["ONLYHEALTARGET_USETOPHEAL"] = false,
				["HEAL_STATUS_ONEHEAL"] = false,
				["HEAL_STATUS_PROTECT_WARRIOR"] = false,
				["HEAL_STATUS_PROTECT_PALADIN"] = false,
				["HEAL_STATUS_PROTECT_DRUID"] = true,
				["HEAL_STATUS_PROTECT_WARLOCK"] = true,
				["HEAL_STATUS_PROTECT_MAGE"] = true,
				["HEAL_STATUS_PROTECT_PRIEST"] = true,
				["HEAL_STATUS_PROTECT_ROGUE"] = true,
				["HEAL_STATUS_PROTECT_HUNTER"] = true,
				["HEAL_STATUS_PROTECT_SHAMAN"] = true,
				["HEAL_STATUS_PROTECT_DEATHKNIGHT"] = false,
				["HEAL_STATUS_FIRSTHEALSELF"] = true,
				["HEAL_STATUS_HOLYTHERAPYSELF"] = true,
				["HEAL_STATUS_SHIELDSELF"] = true,
				["OverHealValue"] = 100,
				["OverHealType"] = "OVERHEALNORMAL",
				["HEAL_STATUS_AUTOCHOOSE"] = true,
				["HEALKEYS"] = {
					"神圣震击",
					"圣光闪现",
					"圣光术"
				},
				["MOVEHEALKEYS"] = {
					"神圣震击"
				}
			}
			AutoHelp.HEAL_MODES = {
				["治疗"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_神圣恳求"] = true,
					["HEAL_STATUS_DAOBIAO"] = true,
					["HEAL_STATUS_KEEPSEAL"] = AutoHelp.isWotlk,
					["HEAL_STATUS_KEEPJUDGE"] = AutoHelp.isWotlk,
					["HEAL_STATUS_圣洁护盾"] = true,
					["HEAL_OVERHEAL_VALUE"] = 98,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569已设置为系统缺省【治疗模式】，本模式追求最大化治疗和相对最小化过量治疗。\124r"
				},
				["全程圣光术"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_神圣恳求"] = true,
					["HEAL_STATUS_DAOBIAO"] = true,
					["HEAL_STATUS_KEEPSEAL"] = true,
					["HEAL_STATUS_KEEPJUDGE"] = true,
					["HEAL_STATUS_圣洁护盾"] = true,
					["HEAL_OVERHEAL_VALUE"] = 98,
					["HEAL_STATUS_PROTECT"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["HEALKEYS"] = {
						"圣光术",
						"神圣震击"
					},
					["modetip"] = "\124cffFFF569已设置为【全程圣光术模式】。\124r"
				},
				["打怪"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_主动开怪"] = true,
					["STATUS_目标互动"] = true,
					["HEAL_AUTO_VALUE"] = 50,
					["HEAL_STATUS_正义之怒"] = false,
					["HEALKEYS"] = {
						"圣光闪现",
						"神圣震击",
						"圣光术"
					},
					["modetip"] = "\124cffFFF569已设置为【打怪】模式。\124r"
				},
				["防护"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["STATUS_目标互动"] = false,
					["HEAL_STATUS_主动开怪"] = false,
					["HEAL_STATUS_圣洁护盾"] = true,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_SHIELDSELF"] = false,
					["HEAL_STATUS_神圣恳求"] = true,
					["modetip"] = "\124cffFFF569已设置为【防护】坦克模式。\124r"
				},
				["惩戒"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_圣洁护盾"] = true,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["modetip"] = "\124cffFFF569已设置为【惩戒】输出模式。\124r"
				},
				["英雄将军"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_AUTOHEAL"] = true,
					["HEAL_AUTO_VALUE"] = 60,
					["HEAL_STATUS_FIRSTTANK"] = true,
					["HEAL_FIRSTTANK_VALUE"] = 70,
					["HEAL_STATUS_PROTECT"] = false,
					["HEAL_STATUS_DISPALSELF"] = false,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["HEAL_OVERHEAL_VALUE"] = 90,
					["HEAL_STATUS_FIRSTHEALSELF"] = true,
					["HEAL_STATUS_PROTECTSELF"] = false,
					["HEAL_STATUS_神圣恳求"] = false,
					["HEAL_STATUS_目标审判"] = false,
					["HEAL_STATUS_DAOBIAO"] = false,
					["HEAL_STATUS_KEEPSEAL"] = false,
					["HEAL_STATUS_KEEPJUDGE"] = false,
					["HEAL_STATUS_圣洁护盾"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569设置为【ULD将军刷坦模式】，只治疗坦克，且只在坦克血量低于70%的时候开始刷血，且只用圣光闪现刷血，节省蓝量。\124r",
					["HEALKEYS"] = {
						"圣光闪现"
					}
				}
			}
			if AutoHelp.isWotlk then
				AutoHelp.ModeList = {
					{
						text = "治疗模式",
						notCheckable = true,
						isTitle = true
					},
					{
						text = "\124cff00ff00治疗\124r",
						name = "治疗",
						tooltipTitle = "治疗",
						tooltipText = "标准模式使用系统缺省设置进行治疗。"
					},
					{
						text = "\124cffFFFFFF打怪\124r",
						name = "打怪",
						tooltipTitle = "打怪",
						tooltipText = "升级练级时使用,尽量减少自我治疗的频率"
					},
					{
						text = "\124cffFFFFFF全程圣光术\124r",
						name = "全程圣光术",
						tooltipTitle = "圣光术治疗",
						tooltipText = "全程使用大圣光进行治疗，走位时会使用神圣震击+瞬发圣光闪现治疗，建议奥杜尔、toc、icc副本使用此模式"
					},
					{
						text = "英雄将军",
						name = "英雄将军",
						tooltipTitle = "英雄将军",
						tooltipText = "\124cffFFF569设置为【ULD英雄将军模式】，只治疗坦克，且只在坦克血量低于70%的时候开始刷血，且只用圣光闪现刷血，节省蓝量。\124r"
					},
					{
						text = "输出模式",
						notCheckable = true,
						isTitle = true
					},
					{
						text = "\124cff00ff00防护\124r",
						name = "防护",
						tooltipTitle = "防护",
						tooltipText = "坦克模式"
					},
					{
						text = "\124cff00ff00惩戒\124r",
						name = "惩戒",
						tooltipTitle = "惩戒",
						tooltipText = "惩戒骑输出模式"
					}
				}
			else
				AutoHelp.ModeList = {
					{
						text = "治疗模式",
						notCheckable = true,
						isTitle = true
					},
					{
						text = "\124cff00ff00治疗\124r",
						name = "治疗",
						tooltipTitle = "治疗",
						tooltipText = "标准模式使用系统缺省设置进行治疗。"
					},
					{
						text = "\124cffFFFFFF打怪\124r",
						name = "打怪",
						tooltipTitle = "打怪",
						tooltipText = "升级练级时使用,尽量减少自我治疗的频率"
					},
					{
						text = "输出模式",
						notCheckable = true,
						isTitle = true
					},
					{
						text = "\124cff00ff00防护\124r",
						name = "防护",
						tooltipTitle = "防护",
						tooltipText = "坦克模式"
					},
					{
						text = "\124cff00ff00惩戒\124r",
						name = "惩戒",
						tooltipTitle = "惩戒",
						tooltipText = "惩戒骑输出模式"
					}
				}
			end;
			AutoHelp.STAND_HEAL_SPELLS = {
				"圣光闪现",
				"圣光术",
				"神圣震击"
			}
			AutoHelp.MOVE_HEAL_SPELLS = {
				"神圣震击"
			}
			AutoHelp.PANELHEIGHT = 435;
			AutoHelp.PANELWIDTH = 160;
			AutoHelp.SEAL_SPELLS = {}
			AutoHelp.JUDGE_SPELLS = {}
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00辅助功能设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTDISPAL",
						["value"] = false,
						["title"] = "\124cffFFF569先驱\124r",
						["tipTitle"] = "优先驱散",
						["tip"] = "优先驱散，驱散将优先加血，现在版本加入队友有血量低于50%依然先加血，以阻止一直在驱散而不加血的问题。\n\n\124cff00ff00对于频繁产生负面效果时，建议关闭此选项提高治疗量\n优先驱散选中效果将高于治疗\124r",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISMAGIC",
						["value"] = true,
						["title"] = "魔",
						["tipTitle"] = "驱散魔法",
						["tip"] = "驱散魔法效果，自动驱散魔法效果\n\n\124cff00ff00自动使用清洁术驱散目标魔法效果\124r",
						["point"] = 55,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISPOSION",
						["value"] = true,
						["title"] = "毒",
						["tipTitle"] = "驱散中毒",
						["tip"] = "驱散中毒效果，自动驱散中毒效果\n\n\124cff00ff00自动使用清洁术驱散目标中毒效果\nZUG哈卡建议关闭中毒驱散\124r",
						["point"] = 90,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISSICK",
						["value"] = true,
						["title"] = "病",
						["tipTitle"] = "驱散疾病",
						["tip"] = "驱散疾病效果，自动驱散疾病效果\n\n\124cff00ff00自动使用清洁术驱散目标疾病效果\124r",
						["point"] = 125,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "TANKBUFFNAME",
						["hide"] = true,
						["value"] = 1,
						["title"] = "坦克祝福设置，隐藏不显示",
						["tip"] = "xxx",
						["point"] = 0,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AUTOBUFF",
						["value"] = true,
						["title"] = "祝福",
						["tipTitle"] = "自动给职业祝福",
						["tip"] = "在设定好职业祝福之后，开启此选项\n\n\124cff00ff00缺省强效祝福提前2分钟自动补，普通祝福提前1分钟自动补\124r",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "buffbutton",
						["id"] = "WARRIOR",
						["value"] = 1,
						["title"] = "战士",
						["tip"] = "xxx",
						["point"] = 80,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "PALADIN",
						["value"] = 1,
						["title"] = "骑士",
						["tip"] = "xxx",
						["point"] = 120,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "PRIEST",
						["value"] = 1,
						["title"] = "牧师",
						["tip"] = "xxx",
						["point"] = 0,
						["nextpos"] = true
					},
					{
						["type"] = "buffbutton",
						["id"] = "MAGE",
						["value"] = 1,
						["title"] = "法师",
						["tip"] = "xxx",
						["point"] = 40,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "WARLOCK",
						["value"] = 1,
						["title"] = "术士",
						["tip"] = "xxx",
						["point"] = 80,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "DRUID",
						["value"] = 1,
						["title"] = "小德",
						["tip"] = "xxx",
						["point"] = 120,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "SHAMAN",
						["value"] = 1,
						["title"] = "萨满",
						["tip"] = "xxx",
						["point"] = 0,
						["nextpos"] = true
					},
					{
						["type"] = "buffbutton",
						["id"] = "DEATHKNIGHT",
						["value"] = 1,
						["title"] = "死骑",
						["tip"] = "xxx",
						["point"] = 40,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "HUNTER",
						["value"] = 1,
						["title"] = "猎人",
						["tip"] = "xxx",
						["point"] = 80,
						["nextpos"] = false
					},
					{
						["type"] = "buffbutton",
						["id"] = "ROGUE",
						["value"] = 1,
						["title"] = "盗贼",
						["tip"] = "xxx",
						["point"] = 120,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_KEEPSEAL",
						["value"] = true,
						["title"] = "圣印",
						["tip"] = "\124cff00ff00保持自己圣印状态，失效会自动补上\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_KEEPSEALBUTTON",
						["title"] = "选择保持圣印",
						["tipTitle"] = "圣印选择",
						["tip"] = "设置给自己上的圣印，消失将自动补上\n\n\124cff00ff00奶骑建议选择智慧圣印。",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["create"] = function(kl)
							local kp = jy("KEEPSEAL_TITLE")
							if kp then
								kl:SetText(kp)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupListMenu("选择圣印", "HEAL_STATUS_KEEPSEAL", "KEEPSEAL", kl, AutoHelp.SEAL_SPELLS, jy("KEEPSEAL"))
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_KEEPJUDGE",
						["value"] = true,
						["title"] = "审判",
						["tip"] = "保持当前目标（敌对）或者队友目标的目标（敌对）释放圣印，失效会自动补上\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_KEEPJUDGEBUTTON",
						["title"] = "选择审判技能",
						["tipTitle"] = "审判选择",
						["tip"] = "自动补齐目标（敌对）审判效果上\n\n\124cff00ff00奶骑建议选择圣光审判，所有职业包括法系职业攻击都会回血，回血量也计入治疗量。\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(kl)
							local kp = jy("KEEPJUDGE_TITLE")
							if kp then
								kl:SetText(kp)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupListMenu("选择审判", "HEAL_STATUS_KEEPJUDGE", "KEEPJUDGE", kl, AutoHelp.JUDGE_SPELLS, jy("KEEPJUDGE"))
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DAOBIAO",
						["value"] = true,
						["title"] = "道标",
						["tip"] = "\124cff00ff00保持选定队友的道标，在道标还有2秒的时候会自动给设定队友补上道标\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_DAOBIAOUNIT",
						["title"] = "选择道标",
						["tipTitle"] = "道标队友选择",
						["tip"] = "选择队友后按本按钮，将自动设置该队友为圣光道标目标，如果没有目标则清楚圣光道标目标\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动补道标\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["create"] = function(kl)
							local cd = jy("HEAL_STATUS_DAOBIAOUNIT")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo == nil and jy("HEAL_STATUS_DAOBIAOUNIT") == "无" then
								AutoHelp.Debug("要设置道标目标请先选择队友！")
								return
							end;
							if tInfo ~= nil then
								SetConfig("HEAL_STATUS_DAOBIAOUNIT", tInfo["name"])
								for _, im in pairs(HEAL_RAID) do
									if im["name"] == tInfo["name"] then
										im["DAOBIAOLIST"] = true
									else
										im["DAOBIAOLIST"] = false
									end
								end;
								AutoHelp.Debug("设置圣光道标目标：" .. tInfo["name"])
							else
								SetConfig("HEAL_STATUS_DAOBIAOUNIT", "无")
								for _, im in pairs(HEAL_RAID) do
									im["DAOBIAOLIST"] = false
								end;
								AutoHelp.Debug("清除圣光道标目标。")
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_圣洁护盾",
						["value"] = true,
						["title"] = "圣盾",
						["tip"] = "\124cff00ff00保持当前目标一直维持圣洁护盾效果，失效会自动补上，如果没有选择人员勾选此项，则保持自我圣洁护盾\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_HUDUNUNIT",
						["title"] = "选择圣洁护盾",
						["tipTitle"] = "圣洁护盾队友选择",
						["tip"] = "选择队友之后点击本按钮，将设定自动为该保持圣洁护盾，如果不选择队友，将保持自己的圣洁护盾。\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动补圣洁护盾\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["create"] = function(kl)
							local cd = jy("HEAL_STATUS_HUDUNUNIT")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo ~= nil then
								SetConfig("HEAL_STATUS_HUDUNUNIT", tInfo["name"])
								for _, im in pairs(HEAL_RAID) do
									if im["name"] == tInfo["name"] then
										im["HUDUNLIST"] = true
									else
										im["HUDUNLIST"] = false
									end
								end;
								AutoHelp.Debug("设置圣洁护盾目标：" .. tInfo["name"])
							else
								SetConfig("HEAL_STATUS_HUDUNUNIT", "无")
								for _, im in pairs(HEAL_RAID) do
									im["HUDUNLIST"] = false
								end;
								AutoHelp.Debug("清除圣洁护盾目标。")
							end
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_神圣牺牲",
						["title"] = "大牺",
						["tipTitle"] = "神圣牺牲（大牺牲）",
						["tip"] = "施放神圣牺牲（团队减伤）\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("神圣牺牲")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_光环掌握",
						["title"] = "光掌",
						["tipTitle"] = "光环掌握",
						["tip"] = "施放光环掌握",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("光环掌握")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_牺牲之手",
						["title"] = "牺牲",
						["tipTitle"] = "目标牺牲之手",
						["tip"] = "对目标施放牺牲之手，会自动施放无敌或者圣佑以减伤",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("圣盾术/圣佑术/牺牲之手")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_焦点牺牲",
						["title"] = "焦牺",
						["tipTitle"] = "焦点目标牺牲之手",
						["tip"] = "对焦点目标施放无敌（或者圣佑）牺牲",
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("圣盾术/圣佑术/焦点牺牲")
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_主动攻击",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cff00ff00启动攻击\124r",
						["tip"] = "如果团队血量不需要治疗时,有敌方目标且在战斗就开始攻击模式",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							qO(hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主动开怪2",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cfff00000主动开怪\124r",
						["tip"] = "选择此项，非战斗中可以主动攻击选中的敌对目标，不选择此项，即使有主动攻击，也不会进入战斗状态（攻击敌对目标）\124r",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "防护" and kH ~= "惩戒" then
								SetConfig("HEAL_STATUS_主动开怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_目标互动2",
						["value"] = false,
						["hitRect"] = - 30,
						["title"] = "\124cffFFF569互动\124r",
						["tip"] = "自动与目标互动，比如距离过远自动靠近目标，并攻击\n不选择目标互动，必须手动移动到攻击位置，才开始自动攻击",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "防护" and kH ~= "惩戒" then
								SetConfig("STATUS_目标互动", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动寻怪2",
						["value"] = false,
						["title"] = "\124cffFFF569寻怪\124r",
						["tip"] = "自动升级使用，站在某个地方，自动寻找怪物攻击",
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "防护" and kH ~= "惩戒" then
								SetConfig("STATUS_自动寻怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动拾取2",
						["value"] = false,
						["title"] = "\124cffFFF569拾取\124r",
						["tip"] = "自动升级使用，杀死怪物后自动拾取",
						["point"] = 105,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "防护" and kH ~= "惩戒" then
								SetConfig("STATUS_自动拾取", hK)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING2",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tipTitle"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在枭兽模式下为缺省勾选，建议治疗模式不要选择。",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "惩戒",
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动炸弹",
						["value"] = true,
						["title"] = "炸弹",
						["tipTitle"] = "萨隆邪铁炸弹",
						["tip"] = "在技能中绑定[萨隆邪铁炸弹]/腰带钴质破片炸弹, 小怪使用腰带炸弹, 骷髅级别BOSS才卡CD使用萨隆邪铁炸弹, 请在背包保留足够的炸弹。\n\n\124cff00ff00萨隆邪铁炸弹只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "惩戒,防护",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自我驱散",
						["value"] = true,
						["title"] = "自我驱散",
						["tipTitle"] = "自我优先驱散",
						["tip"] = "第一时间自我驱散, 只驱散自己, 如果需要团队驱散, 请选择上面的优先驱散",
						["hitRect"] = - 60,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "防护",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("HEAL_STATUS_DISMAGIC", true)
								SetConfig("HEAL_STATUS_DISPOSION", true)
								SetConfig("HEAL_STATUS_DISSICK", true)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tipTitle"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在枭兽模式下为缺省勾选，建议治疗模式不要选择。",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "惩戒",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FASTHEAL",
						["value"] = true,
						["title"] = "自疗",
						["tipTitle"] = "瞬发圣闪治疗自己",
						["tip"] = "当自己血量低于设定值，利用天赋触发战争艺术瞬发圣光闪现给自己加血，缺省设置40%",
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "惩戒",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["title"] = "AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果怪物数量大于等于2个，将自动启动AOE技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jy("HEALMODE") == "惩戒" or jy("HEALMODE") == "防护" then
								if jI then
									if AutoHelp.HasActionKey("命令圣印") then
										SetConfig("KEEPSEAL", "命令圣印")
									end;
									SetConfig("ATTACK_防护_奉献", true)
									SetConfig("ATTACK_惩戒_奉献", true)
								else
									if AutoHelp.HasActionKey("复仇圣印") then
										SetConfig("KEEPSEAL", "复仇圣印")
									end;
									if AutoHelp.HasActionKey("腐蚀圣印") then
										SetConfig("KEEPSEAL", "腐蚀圣印")
									end
								end
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_清算之手",
						["value"] = true,
						["title"] = "嘲讽",
						["tip"] = "使用清算之手自动嘲讽当前目标, 开战时或者目标的目标不是你且不是其他坦克时(目标OT), 才会自动使用嘲讽技能.  \n\n\124cff00ff00对于boss战选择此项是个很好的开怪习惯, 嘲讽本身自带伤害, 且不会被OT. 此功能也是OT之后第一时间嘲讽boss. 对于有些不吃嘲讽boss请勿使用!\124r",
						["hitRect"] = - 20,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "防护",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_正义防御",
						["value"] = true,
						["title"] = "群嘲",
						["tip"] = "使用正义防御自动嘲讽攻击队友目标, 如果嘲讽处于cd状态, 会自动使用正义防御.",
						["hitRect"] = - 20,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "防护",
						["version"] = "wlk"
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING_NORMAL",
						["value"] = "\124cff00ff00技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "normal"
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_SHIELDSELF",
						["value"] = true,
						["title"] = "自动无敌",
						["tip"] = "当自己血量低于设定值，自动自我无敌，缺省设置35%（0.35）",
						["hitRect"] = - 40,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer,惩戒"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_SHIELDSELF",
						["value"] = 35,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer,惩戒"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_PROTECTSELF",
						["value"] = true,
						["title"] = "保护",
						["tip"] = "当自己血量低于设定值，自动自我保护祝福\n\n\124cff00ff00只有在无敌CD中，才触发此选项\124r",
						["point"] = 25,
						["nextpos"] = true,
						["mode"] = "healer,惩戒"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_HOLYTHERAPYSELF",
						["value"] = true,
						["title"] = "圣疗",
						["tip"] = "当自己血量低于设定值，自动自我圣疗\n\n\124cff00ff00只有在无敌和保护CD中，才触发此选项\124r",
						["point"] = 85,
						["nextpos"] = false,
						["mode"] = "healer,惩戒"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动牺牲",
						["value"] = false,
						["title"] = "自动牺牲",
						["tip"] = "当队友血量过低于35%且自身血量高于60%，自动使用牺牲之手分担伤害，可以设置自动牺牲之手的血量阀值",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_牺牲血量",
						["value"] = 35,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTHEALSELF",
						["value"] = true,
						["title"] = "优先自疗",
						["tip"] = "当自己血量低于设定值，优先治疗自己，缺省设置50%（0.5）",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_FIRSTHEALSELF",
						["value"] = 50,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_取消牺牲",
						["value"] = true,
						["title"] = "取消分担",
						["tip"] = "施放神圣牺牲（大牺牲、减伤）之后，自动取消小队伤害分担。",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("神圣牺牲") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_团队通告",
						["value"] = false,
						["title"] = "团队通告",
						["tip"] = "施放神圣牺牲（大牺牲、减伤）之后，自动在团队或者小队通告。",
						["point"] = 80,
						["hitRect"] = - 30,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("神圣牺牲") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_饰品爆发",
						["value"] = true,
						["title"] = "饰品爆发",
						["tip"] = "当团队总血量低于设定值时，自动开启饰品、工程手套等爆发进行加血，缺省设置70%。\n\n\124cff00ff00如果有工程手套、主动饰品等，会根据设定团队血量自动开启。如果需要自己控制饰品及工程手套开启，可自己做宏 \n\n/use 13\n/use 14\n/use 10\n/use 种族天赋\124r",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_饰品爆发值",
						["value"] = 70,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_神圣恳求",
						["value"] = true,
						["title"] = "神圣恳求",
						["tip"] = "选择此项，将在战斗开始后蓝量低于70%时，自动卡CD使用神圣恳求\n\n\124cff00ff00选择此项将会保持骑士最佳回蓝效果\124r",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_复仇之怒",
						["value"] = false,
						["title"] = "复仇之怒",
						["tip"] = "选择此项，开启神圣恳求时，同时开启复仇之怒。\124r\n\n\124cff00ff00如果需要随时无敌小牺牲，不要勾选此项。\124r",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_目标审判",
						["hitRect"] = - 150,
						["value"] = false,
						["title"] = "保持目标审判效果",
						["tip"] = "保持目标审判效果，例如光明审批用于团队回血。",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_道标切换",
						["hitRect"] = - 150,
						["value"] = true,
						["title"] = "自动切换坦克道标",
						["tip"] = "如果BOSS战开始后, 自动切换当前BOSS目标坦克为道标目标。\n\n\124cff00ff00此功能可以节省切换道标时间, 比如奥杜尔观星战中, 始终保持BOSS当前坦克的道标。\124r",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk"
					}
				}
			}
			local qQ = {
				{
					{
						"奶骑_圣光审判",
						"圣光审判",
						true,
						"审判",
						"normal",
						"卡CD使用审批技能打伤害。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"奶骑_奉献",
						"奉献",
						true,
						"奉献",
						"normal",
						"在攻击范围奉献，会自动判定敌人是否在近战范围。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"奶骑_愤怒之锤",
						"愤怒之锤",
						true,
						"愤锤",
						"normal",
						"在敌人血量少于20%后，优先使用愤怒之锤进行攻击。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"奶骑_神圣震击",
						"神圣震击",
						true,
						"震击",
						"normal",
						"在攻击范围内对敌人使用神圣震击。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"奶骑_正义盾击",
						"正义盾击",
						true,
						"盾击",
						"normal",
						"卡CD使用审批技能打伤害。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"奶骑_驱邪术",
						"驱邪术",
						true,
						"驱邪",
						"normal",
						"其他技能cd时，使用驱邪术攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"奶骑_神圣愤怒",
						"神圣愤怒",
						false,
						"愤怒",
						"normal",
						"如果攻击敌人是亡灵或者恶魔，使用此技能。\n\n\124cff00ff00只有在主动攻击选择后才会生效。即使选择了此项，目标非亡灵或者恶魔也不会释放此技能\124r"
					}
				},
				{
					{
						"防护_圣光审判",
						"圣光审判",
						true,
						"审判",
						"防护",
						"卡CD使用审批技能打伤害。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_神圣之盾",
						"神圣之盾",
						true,
						"圣盾",
						"防护",
						"保持神圣之盾提高格挡几率减伤。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_奉献",
						"奉献",
						true,
						"奉献",
						"防护",
						"在攻击范围奉献，会自动判定敌人是否在近战范围。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_愤怒之锤",
						"愤怒之锤",
						true,
						"愤锤",
						"防护",
						"在敌人血量少于20%后，优先使用愤怒之锤进行攻击。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_正义之锤",
						"正义之锤",
						true,
						"正锤",
						"防护",
						"使用正义之锤攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_正义盾击",
						"正义盾击",
						true,
						"盾击",
						"防护",
						"卡CD使用审批技能打伤害。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_复仇者之盾",
						"复仇者之盾",
						false,
						"飞盾",
						"防护",
						"使用复仇者之盾攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_正义之怒",
						"正义之怒",
						true,
						"正义",
						"防护",
						"开启正义之怒"
					},
					{
						"防护_圣洁护盾",
						"圣洁护盾",
						true,
						"护盾",
						"防护",
						"保持自身圣洁护盾"
					},
					{
						"防护_神圣恳求",
						"神圣恳求",
						true,
						"恳求",
						"防护",
						"开启神圣恳求回蓝"
					},
					{
						"防护_驱邪术",
						"驱邪术",
						false,
						"驱邪",
						"防护",
						"其他技能cd时，使用驱邪术攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"防护_神圣愤怒",
						"神圣愤怒",
						false,
						"愤怒",
						"防护",
						"如果攻击敌人是亡灵或者恶魔，使用此技能。\n\n\124cff00ff00只有在主动攻击选择后才会生效。即使选择了此项，目标非亡灵或者恶魔也不会释放此技能\124r"
					}
				},
				{
					{
						"惩戒_圣光审判",
						"圣光审判",
						true,
						"审判",
						"惩戒",
						"卡CD使用审批技能打伤害。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_奉献",
						"奉献",
						true,
						"奉献",
						"惩戒",
						"在攻击范围奉献，会自动判定敌人是否在近战范围。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_愤怒之锤",
						"愤怒之锤",
						true,
						"愤锤",
						"惩戒",
						"在敌人血量少于20%后，优先使用愤怒之锤进行攻击。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_十字军打击",
						"十字军打击",
						true,
						"十字",
						"惩戒",
						"用十字打击攻击攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_神圣风暴",
						"神圣风暴",
						true,
						"风暴",
						"惩戒",
						"用神圣风暴攻击攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_清算之手",
						"清算之手",
						true,
						"清算",
						"惩戒",
						"如果惩戒骑插了清算雕文,卡CD使用此打伤害。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_复仇之怒",
						"复仇之怒",
						true,
						"翅膀",
						"惩戒",
						"复仇之怒"
					},
					{
						"惩戒_驱邪术",
						"驱邪术",
						true,
						"驱邪",
						"惩戒",
						"其他技能cd时，使用驱邪术攻击敌人。\n\n\124cff00ff00只有在主动攻击选择后才会生效。\124r"
					},
					{
						"惩戒_神圣愤怒",
						"神圣愤怒",
						false,
						"愤怒",
						"惩戒",
						"如果攻击敌人是亡灵或者恶魔，使用此技能。\n\n\124cff00ff00只有在主动攻击选择后才会生效。即使选择了此项，目标非亡灵或者恶魔也不会释放此技能\124r"
					},
					{
						"惩戒_圣洁护盾",
						"圣洁护盾",
						false,
						"护盾",
						"惩戒",
						"保持自身圣洁护盾"
					},
					{
						"惩戒_神圣恳求",
						"神圣恳求",
						true,
						"恳求",
						"惩戒",
						"开启神圣恳求回蓝"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local o1 = # AutoHelp.PANEL_CONFIG["healer"]
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 3 == 1 then
							point = 5;
							kf = true
						elseif jS % 3 == 2 then
							point = 55;
							kf = false
						else
							point = 105;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "ATTACK_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tipTitle"] = qS[2],
							["tip"] = qS[2],
							["point"] = point,
							["nextpos"] = kf,
							["mode"] = qS[5]
						}
						if qS[6] then
							eS["tip"] = qS[6]
						end;
						if jS == 1 then
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], o1 + jS, eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if kH == "防护" then
				AutoHelp.NAMEPLATES_MAXDISTANCE = 12
			elseif kH == "惩戒" then
				AutoHelp.NAMEPLATES_MAXDISTANCE = 12
			else
				AutoHelp.NAMEPLATES_MAXDISTANCE = 40
			end;
			local qT = not (kH == "防护" or kH == "惩戒")
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or qT and Contains(bn.mode, "healer") or not qT and Contains(bn.mode, "attack") then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			if qT then
				qO(GetStatus("STATUS_主动攻击"))
			end;
			AutoHelp.ResizePanel()
		end;
		local function qU(qV)
			tInfo = GetRaidUnit(qV.destName)
			if tInfo then
				if AutoHelp.CanUseAction(tInfo, "圣光闪现") then
					AutoHelp.StopAction()
					AutoHelp.AddNextAction(tInfo, "圣光闪现", 0, true)
					AutoHelp.AddNextAction(tInfo, "圣光术", 0, false)
					AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"] .. ", ACTION:" .. AutoHelp.GetActionSpellName("圣光闪现"))
				end
			end
		end;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_HEALBOSSTARGET") then
				return
			end;
			local tInfo;
			if qV.spellId == 24573 or qV.spellId == 16856 then
				qU(qV)
			end;
			if qV.event == "SPELL_CAST_START" and qV.spellId == 22539 then
				tInfo = AutoHelp.GetBossTarget(qV.sourceGUID)
				if tInfo then
					if AutoHelp.CanUseAction(tInfo, "圣光术") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "圣光术", 0, true)
						AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"] .. ", ACTION:" .. AutoHelp.GetActionSpellName("圣光术"))
					elseif AutoHelp.CanUseAction(tInfo, "圣光闪现") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "圣光闪现", 0.5, true)
						AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"] .. ", ACTION(Delay 0.5s):" .. AutoHelp.GetActionSpellName("圣光闪现"))
					end
				end
			end;
			if qV.event == "SPELL_CAST_START" and qV.spellId == 24314 then
				tInfo = AutoHelp.GetBossTarget(qV.sourceGUID)
				if tInfo then
					if AutoHelp.CanUseAction(tInfo, "圣光术") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "圣光术", 0, true)
						AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"] .. ", ACTION:" .. AutoHelp.GetActionSpellName("圣光术"))
					elseif AutoHelp.CanUseAction(tInfo, "圣光闪现") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "圣光闪现", 1, true)
						AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"] .. ", ACTION(Delay 1s):" .. AutoHelp.GetActionSpellName("圣光闪现"))
					end
				end
			end;
			if qV.event == "SPELL_CAST_START" and qV.spellId == 24314 then
				if UnitName("player") == qV.destName then
					AutoHelp.StopAction()
					AutoHelp.SetStopAction(8, GetSpellInfo(24314) .. "，停止动作")
				end
			end;
			if qV.event == "SPELL_AURA_APPLIED" and qV.spellId == 26613 then
				qU(qV)
			end;
			if qV.event == "SPELL_AURA_APPLIED" and qV.spellId == 26180 then
				tInfo = GetRaidUnit(qV.destName)
				if tInfo and tInfo["role"] == "MAINTANK" then
					if AutoHelp.CanUseAction(tInfo, "清洁术") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "清洁术", 0, true)
						AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"] .. ", ACTION:" .. AutoHelp.GetActionSpellName("清洁术"))
					end
				end
			end;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 55593 then
				AutoHelp.SetStopHealAction(16, GetSpellInfo(55593) .. "，停止治疗")
			end;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 27808 then
				tInfo = GetRaidUnit(qV.destName)
				if tInfo and tInfo["unit"] ~= "player" then
					AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"])
					if AutoHelp.CanUseAction(tInfo, "神圣震击") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "神圣震击", 0, true)
					elseif AutoHelp.CanUseAction(tInfo, "圣光闪现") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "圣光闪现", 0, true)
					else
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "圣光术", 0, true)
					end
				end
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.SpellCastSuccess(fq, ca, cx, fu, qX, qY)
			if cx == "神圣牺牲" or cx == "牺牲之手" or cx == "光环掌握" then
				if GetStatus("HEAL_STATUS_团队通告") then
					if fu then
						AutoHelp.SendChatMsg(">>>" .. (fq or "") .. "已释放【" .. (cx or "") .. "】=>" .. (fu or "") .. "<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
					else
						AutoHelp.SendChatMsg(">>>" .. (fq or "") .. "已释放【" .. (cx or "") .. "】<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
					end
				end
			end
		end;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
			local cx = GetSpellInfo(ca)
			if ho == "player" then
				if cx == "神圣牺牲" then
					if GetStatus("HEAL_STATUS_取消牺牲") then
						AutoHelp.AddNextAction(HEAL_RAID["player"], "取消牺牲", 0)
						AutoHelp.Debug(">>已经取消神圣牺牲小队伤害分担！")
					end
				end
			end
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.HasActionKey("神圣牺牲") then
				local pj = FindOrCreateMacro("AH神圣牺牲", nil, "#showtooltips 神圣牺牲\n/stopcasting\n/ahcast 神圣牺牲\n", 1)
			end;
			if AutoHelp.HasActionKey("光环掌握") then
				local pj = FindOrCreateMacro("AH光环掌握", nil, "#showtooltips 光环掌握\n/stopcasting\n/cast 光环掌握\n", 2)
			end;
			if AutoHelp.HasActionKey("牺牲之手") then
				local pj = FindOrCreateMacro("AH无敌牺牲", nil, "#showtooltips 牺牲之手\n/stopcasting\n/ahcast 圣盾术/牺牲之手\n")
			end;
			if AutoHelp.HasActionKey("牺牲之手") then
				local pj = FindOrCreateMacro("AH焦点牺牲", nil, "#showtooltips 牺牲之手\n/stopcasting\n/ahcast 圣盾术/焦点牺牲\n")
			end;
			if AutoHelp.HasActionKey("保护之手") then
				local pj = FindOrCreateMacro("AH保护之手", nil, "#showtooltips 保护之手\n/stopcasting\n/ahcast 保护之手\n")
			end;
			if AutoHelp.HasActionKey("拯救之手") then
				local pj = FindOrCreateMacro("AH拯救之手", nil, "#showtooltips 拯救之手\n/stopcasting\n/ahcast 拯救之手\n")
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 53)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 54)
		end;
		function AutoHelp.AddNextCastAction(qZ)
			for al, p in ipairs(qZ) do
				if p == "焦点牺牲" then
					if HEAL_RAID_NAMES[UnitName("focus")] == "player" then
						AutoHelp.Debug("焦点为自己，不能给自己牺牲之手！")
						return false
					end;
					if not UnitExists("focus") or not HEAL_RAID_NAMES[UnitName("focus")] then
						AutoHelp.Debug("请先设置焦点，再使用焦点无敌牺牲！")
						return false
					end
				end;
				if p == "牺牲之手" then
					if HEAL_RAID_NAMES[UnitName("target")] == "player" then
						AutoHelp.Debug("目标为自己，不能给自己牺牲之手！")
						return false
					end;
					if not UnitExists("target") or not HEAL_RAID_NAMES[UnitName("target")] then
						AutoHelp.Debug("请选择队友/团队目标后使用无敌牺牲！")
						return false
					end
				end;
				if p == "神圣牺牲" then
					if AutoHelp.GroupsNum == 1 then
						AutoHelp.Debug("必须在队伍或者团队中使用神圣牺牲")
						return false
					end
				end
			end;
			return true
		end;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("HEAL_STATUS_DAOBIAOUNIT", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_DAOBIAOUNIT"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			AutoHelp.RegisterKeyCallback("HEAL_STATUS_HUDUNUNIT", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_HUDUNUNIT"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			AutoHelp.RegisterKeyCallback("KEEPSEAL", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_KEEPSEALBUTTON"]
				if k8 then
					local action = AutoHelp.GetAction(hK)
					local kp = "\124T" .. action["icon"] .. ":14:14\124t" .. hK;
					k8:SetText(kp)
				end
			end)
			local q_ = {
				"智慧圣印",
				"光明圣印",
				"正义圣印",
				"公正圣印",
				"复仇圣印",
				"命令圣印",
				"腐蚀圣印"
			}
			for _, cd in pairs(q_) do
				if AutoHelp.HasActionKey(cd) then
					AutoHelp.SEAL_SPELLS[# AutoHelp.SEAL_SPELLS + 1] = cd
				end
			end;
			local q_ = {
				"圣光审判",
				"智慧审判",
				"公正审判"
			}
			for _, cd in pairs(q_) do
				if AutoHelp.HasActionKey(cd) then
					AutoHelp.JUDGE_SPELLS[# AutoHelp.JUDGE_SPELLS + 1] = cd
				end
			end;
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
		end;
		function AutoHelp.ClassLoaded()
			local r0 = jy("KEEPSEAL")
			if (not r0 or r0 == "无") and AutoHelp.HasActionKey("智慧圣印") then
				r0 = "智慧圣印"
				local kp = "\124T135960:14:14\124t" .. r0;
				SetConfig("KEEPSEAL", "智慧圣印")
				SetConfig("KEEPSEAL_TITLE", kp)
				AutoHelp.SettingItems["HEAL_STATUS_KEEPSEALBUTTON"]:SetText(kp)
			end;
			local r1 = jy("KEEPJUDGE")
			if (not r1 or r1 == "无") and AutoHelp.HasActionKey("圣光审判") then
				r1 = "圣光审判"
				local kp = "\124T135959:14:14\124t" .. r1;
				SetConfig("KEEPJUDGE", "圣光审判")
				SetConfig("KEEPJUDGE_TITLE", kp)
				AutoHelp.SettingItems["HEAL_STATUS_KEEPJUDGEBUTTON"]:SetText(kp)
			end
		end;
		function AutoHelp.CanMoveSpell(tInfo, p)
			return p == "圣光闪现" and AutoHelp.UnitHasBuff("player", "圣光灌注")
		end;
		local function r2()
			local lw = jy("HEAL_STATUS_DAOBIAOUNIT")
			if InCombatLockdown() and AutoHelp.encounterID > 0 and jy("HEAL_STATUS_道标切换") then
				local d2 = FindBossTargets()
				local fZ = false;
				if # d2 > 0 then
					if lw and lw ~= "无" then
						for i, r3 in pairs(d2) do
							if r3 == lw then
								fZ = true
							end
						end
					end;
					if not fZ or not lw or lw == "无" then
						lw = d2[1]
					end
				end
			end;
			return lw
		end;
		local function r4(mH, targetInfo)
			local r5 = targetInfo and targetInfo["canAttack"]
			local r6 = not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or UnitAffectingCombat("player") or UnitAffectingCombat("target")
			local mT, r7 = mH["hp"], mH["mp"]
			local r8 = mH["groupNo"]
			local r9 = AutoHelp.IsDrinking() and r7 < 0.90 or AutoHelp.IsEating() and mT < 0.9;
			if GetStatus("ONLYHEALTARGET") and r6 then
				local tInfo = GetTargetOrEnmysTarget()
				if tInfo and IsValidEmergency(tInfo) and not tInfo["dead"] then
					if not AutoHelp.IsMoving and GetStatus("ONLYHEALTARGET_ALWAYSHEAL") then
						if AutoHelp.TryUseAction(tInfo, "圣光术") then
							AutoHelp.DONT_INTERRUPT = true;
							AutoHelp.DebugText = "当前目标治疗启动/最高法术"
							return true
						end
					end;
					tInfo["ahp"], tInfo["alost"] = AutoHelp.GetUnitComingHP(tInfo, AutoHelp.CommingHealWindow)
					if GetStatus("ONLYHEALTARGET_ALWAYSHEAL") or tInfo["ahp"] <= GetStatusNumber("HEAL_AUTO_VALUE") / 100 then
						if AutoHelp.AutoHealTeam(tInfo) then
							AutoHelp.DONT_INTERRUPT = true;
							AutoHelp.DebugText = "当前目标治疗启动"
							return true
						end
					end
				end
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_SHIELDSELF") and mT <= GetStatusNumber("HEAL_VALUE_SHIELDSELF") / 100 then
				if AutoHelp.TryUseAction(mH, "圣盾术") then
					AutoHelp.DebugText = "自我危机处理：无敌"
					return true
				end;
				if AutoHelp.TryUseAction(mH, "圣佑术") then
					AutoHelp.DebugText = "自我危机处理：圣佑术"
					return true
				end;
				if AutoHelp.TryUseAction(mH, "神圣震击") then
					AutoHelp.DebugText = "自我危机处理：震击"
					return true
				end;
				if AutoHelp.UnitHasBuff(mH["unit"], GetSpellInfo("圣光灌注")) and AutoHelp.TryUseAction(mH, "圣光闪现") then
					AutoHelp.DebugText = "自我危机处理：瞬发圣光闪现"
					return true
				end;
				if GetStatus("HEAL_STATUS_PROTECTSELF") then
					local ra = InCombatLockdown() and HEAL_RAID_ATTACKED_UNITS["player"]
					if ra and AutoHelp.TryUseAction(mH, "保护之手") then
						AutoHelp.DebugText = "自我危机处理：保护之手"
						return true
					end
				end;
				if AutoHelp.isWotlk then
					if GetStatus("HEAL_STATUS_HOLYTHERAPYSELF") and AutoHelp.TryUseAction(mH, "圣疗术") then
						AutoHelp.DebugText = "自我危机处理：圣疗术"
						return true
					end
				end
			end;
			if GetStatus("HEAL_STATUS_饰品爆发") and AutoHelp.RaidHealthPct <= (GetStatusNumber("HEAL_VALUE_饰品爆发值") or 60) and AutoHelp.CanUseSP() > 0 then
				if AutoHelp.TryUseAction(mH, "饰品爆发") then
					return true
				end
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_FIRSTHEALSELF") and mT <= (GetStatusNumber("HEAL_VALUE_FIRSTHEALSELF") or 40) / 100 and AutoHelp.AutoHealTeam(mH) then
				AutoHelp.DebugText = "自我危机处理：加血"
				return true
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_DAOBIAO") then
				local lw = r2()
				if lw and lw ~= "无" then
					local oz = HEAL_RAID_NAMES[lw]
					if not oz then
						SetConfig("HEAL_STATUS_DAOBIAOUNIT", "无")
					else
						if jy("HEAL_STATUS_DAOBIAOUNIT") ~= lw then
							SetConfig("HEAL_STATUS_DAOBIAOUNIT", lw)
							AutoHelp.Debug(">>自动设置BOSS目标为当前道标:" .. lw)
						end;
						if UnitLevel(oz) > 60 and AutoHelp.TryUseAction(HEAL_RAID[oz], "圣光道标") then
							AutoHelp.DebugText = "保持圣光道标"
							return true
						end
					end
				end
			end;
			if GetStatus("HEAL_STATUS_KEEPSEAL") then
				local r0 = jy("KEEPSEAL")
				if r0 and r0 ~= "无" and not AutoHelp.UnitHasBuff("player", r0) and AutoHelp.TryUseAction(mH, r0) then
					AutoHelp.DebugText = "保持圣印"
					return true
				end
			end;
			local j7 = battleQueueStatus() == 3 or InCombatLockdown()
			if j7 and GetStatus("HEAL_STATUS_KEEPJUDGE") and jy("KEEPJUDGE") then
				local rb = AutoHelp.HEAL_PLAYER_TALENTS["纯洁审判"] > 0;
				local tInfo = targetInfo;
				if targetInfo and not r5 then
					tInfo = GetTargetsEnemy()
				end;
				if tInfo and tInfo["canAttack"] then
					if rb and not AutoHelp.UnitHasBuff("player", "纯洁审判") or GetStatus("HEAL_STATUS_目标审判") and not AutoHelp.UnitHasDebuff(tInfo["unit"], jy("KEEPJUDGE")) then
						if AutoHelp.TryUseAction(tInfo, jy("KEEPJUDGE")) then
							AutoHelp.DebugText = "审判目标[" .. jy("KEEPJUDGE")
							return true
						end
					end
				end
			end
		end;
		local function rc(mH, targetInfo)
			local r5 = targetInfo and targetInfo["canAttack"]
			local r6 = not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or UnitAffectingCombat("player") or UnitAffectingCombat("target")
			local mT, r7 = mH["hp"], mH["mp"]
			local r8 = mH["groupNo"]
			local r9 = AutoHelp.IsDrinking() and r7 < 0.90 or AutoHelp.IsEating() and mT < 0.9;
			local kH = jy("HEALMODE")
			if kH == "惩戒" then
				if InCombatLockdown() and GetStatus("HEAL_STATUS_FIRSTHEALSELF") and mT <= GetStatusNumber("HEAL_VALUE_FIRSTHEALSELF") / 100 then
					if AutoHelp.UnitHasBuff("player", 59578) and AutoHelp.TryUseAction(mH, "圣光闪现") then
						AutoHelp.DebugText = "自我危机处理：瞬发圣光闪现"
						return true
					end
				end;
				if InCombatLockdown() and GetStatus("HEAL_STATUS_SHIELDSELF") and mT <= GetStatusNumber("HEAL_VALUE_SHIELDSELF") / 100 then
					if AutoHelp.UnitHasBuff("player", 59578) and AutoHelp.TryUseAction(mH, "圣光闪现") then
						AutoHelp.DebugText = "自我危机处理：瞬发圣光闪现"
						return true
					end;
					if AutoHelp.TryUseAction(mH, "圣盾术") then
						AutoHelp.DebugText = "自我危机处理：无敌"
						return true
					end;
					if AutoHelp.TryUseAction(mH, "圣佑术") then
						AutoHelp.DebugText = "自我危机处理：圣佑术"
						return true
					end;
					if AutoHelp.isWotlk then
						if GetStatus("HEAL_STATUS_HOLYTHERAPYSELF") and AutoHelp.TryUseAction(mH, "圣疗术") then
							AutoHelp.DebugText = "自我危机处理：圣疗术"
							return true
						end
					end;
					if GetStatus("HEAL_STATUS_PROTECTSELF") then
						local ra = InCombatLockdown() and HEAL_RAID_ATTACKED_UNITS["player"]
						if ra and AutoHelp.TryUseAction(mH, "保护之手") then
							AutoHelp.DebugText = "自我危机处理：保护之手"
							return true
						end
					end
				end
			end;
			if GetStatus("HEAL_STATUS_KEEPSEAL") and jy("KEEPSEAL") and not AutoHelp.UnitHasBuff("player", jy("KEEPSEAL")) and AutoHelp.TryUseAction(mH, jy("KEEPSEAL")) then
				return true
			end
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
			if not GetStatus("STATUS_治疗模式") then
				return rc(mH, targetInfo)
			else
				return r4(mH, targetInfo)
			end
		end;
		function AutoHelp.DoCommonAction(mH)
			if not GetStatus("STATUS_治疗模式") then
				if InCombatLockdown() then
				end;
				if GetStatus("ATTACK_防护_正义之怒") and jy("HEALMODE") == "防护" and AutoHelp.TryUseAction(mH, "正义之怒") then
					return true
				end
			else
				if InCombatLockdown() then
					if GetStatus("HEAL_STATUS_神圣恳求") and mH["mp"] < 0.7 then
						if GetStatus("HEAL_STATUS_复仇之怒") and AutoHelp.TryUseAction(mH, "神圣恳求2") or AutoHelp.TryUseAction(mH, "神圣恳求") then
							AutoHelp.DebugText = "神圣恳求回蓝"
							return true
						end
					end;
					if GetStatus("HEAL_STATUS_圣洁护盾") then
						local lw = jy("HEAL_STATUS_HUDUNUNIT")
						if (lw == "无" or lw == nil) and AutoHelp.TryUseAction(mH, "圣洁护盾") then
							return true
						end;
						local oz = HEAL_RAID_NAMES[lw]
						if not oz then
							SetConfig("HEAL_STATUS_HUDUNUNIT", "无")
						else
							local tInfo = HEAL_RAID[oz]
							if AutoHelp.TryUseAction(tInfo, "圣洁护盾") then
								AutoHelp.DebugText = "保持圣洁护盾"
								return true
							end
						end
					end
				end
			end
		end;
		local function rd(re)
			if not GetStatus("HEAL_STATUS_PROTECT") then
				return false
			end;
			if GetStatus("HEAL_STATUS_PROTECT_WARRIOR") and re == "WARRIOR" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_PALADIN") and re == "PALADIN" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_HUNTER") and re == "HUNTER" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_ROGUE") and re == "ROGUE" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_PRIEST") and re == "PRIEST" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_MAGE") and re == "MAGE" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_WARLOCK") and re == "WARLOCK" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_DRUID") and re == "DRUID" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_SHAMAN") and re == "SHAMAN" then
				return true
			end;
			if GetStatus("HEAL_STATUS_PROTECT_DEATHKNIGHT") and re == "DEATHKNIGHT" then
				return true
			end;
			return false
		end;
		function AutoHelp.HotTeam(tInfo, rf)
			if not tInfo then
				AutoHelp.Debug("HotTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			local rg = tInfo;
			if AutoHelp.UnitHasBuffByPlayer(tInfo["unit"], 53563) and rf ~= nil and tInfo ~= rf then
				rg = rf
			end;
			if AutoHelp.UnitHasBuff("player", "圣光灌注") and AutoHelp.TryUseAction(rg, "圣光闪现") then
				return true
			end;
			if AutoHelp.HasMoveKey("神圣震击") and AutoHelp.TryUseAction(rg, "神圣震击") then
				return true
			end;
			local ra = InCombatLockdown() and HEAL_RAID_ATTACKED_UNITS[tInfo["unit"]]
			if GetStatus("HEAL_STATUS_PROTECTSELF") and ra and mT <= GetStatusNumber("HEAL_VALUE_PROTECT") / 100 and UnitAffectingCombat(tInfo["unit"]) and rd(tInfo["class"]) and tInfo["role"] ~= "MAINTANK" then
				if AutoHelp.TryUseAction(tInfo, "保护之手") then
					return true
				end
			end;
			if AutoHelp.isWotlk then
				if InCombatLockdown() and tInfo["name"] ~= mH["name"] then
					if GetStatus("HEAL_STATUS_HOLYTHERAPYSELF") and mT < 0.25 and AutoHelp.TryUseAction(rg, "圣疗术") then
						AutoHelp.DebugText = "危机处理：圣疗术"
						return true
					end;
					if GetStatus("HEAL_STATUS_自动牺牲") and mT < GetStatusNumber("HEAL_VALUE_牺牲血量") / 100 and mH["hp"] > 0.6 then
						if AutoHelp.TryUseAction(tInfo, "牺牲之手") then
							return true
						end
					end
				end
			end;
			local rh = AutoHelp.GetMoveHealingAction(tInfo)
			if rh and AutoHelp.TryUseAction(rg, rh) then
				return true
			end
		end;
		function AutoHelp.HealTeam(tInfo, rf)
			if not tInfo then
				AutoHelp.Debug("HealTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			local rg = tInfo;
			if AutoHelp.UnitHasBuffByPlayer(tInfo["unit"], 53563) and rf ~= nil and tInfo ~= rf then
				rg = rf
			end;
			local ra = InCombatLockdown() and HEAL_RAID_ATTACKED_UNITS[tInfo["unit"]]
			if GetStatus("HEAL_STATUS_PROTECTSELF") and ra and mT <= GetStatusNumber("HEAL_VALUE_PROTECT") / 100 and UnitAffectingCombat(tInfo["unit"]) and rd(tInfo["class"]) and tInfo["role"] ~= "MAINTANK" then
				if AutoHelp.TryUseAction(tInfo, "保护之手") then
					return true
				end
			end;
			if AutoHelp.UnitHasBuff("player", "圣光灌注") and AutoHelp.TryUseAction(rg, "圣光闪现") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("神圣震击") and mT < 0.6 and AutoHelp.TryUseAction(rg, "神圣震击") then
				return true
			end;
			if AutoHelp.isWotlk then
				if InCombatLockdown() and tInfo["name"] ~= mH["name"] then
					if mT < 0.25 and AutoHelp.TryUseAction(rg, "圣疗术") then
						AutoHelp.DebugText = "危机处理：圣疗术"
						return true
					end;
					if GetStatus("HEAL_STATUS_自动牺牲") and mT < GetStatusNumber("HEAL_VALUE_牺牲血量") / 100 and mH["hp"] > 0.6 then
						if AutoHelp.TryUseAction(tInfo, "牺牲之手") then
							return true
						end
					end
				end
			end;
			if AutoHelp.UnitHasBuff("player", "治疗入定") and AutoHelp.TryUseAction(rg, "圣光术") then
				return true
			end;
			local ri = AutoHelp.GetHealingAction(tInfo)
			if ri and AutoHelp.TryUseAction(rg, ri) then
				return true
			end
		end;
		function AutoHelp.AutoHealTeam(tInfo)
			if AutoHelp.IsMoving then
				return AutoHelp.HotTeam(tInfo)
			else
				return AutoHelp.HealTeam(tInfo)
			end
		end;
		local function rj(tInfo)
			if GetStatus("HEAL_STATUS_DISMAGIC") and tInfo["hasMagic"] and AutoHelp.DispelMagicKey then
				local rk = AutoHelp.UnitHasDebuffs(tInfo["unit"], AutoHelp.DontDispelMagics)
				if not rk and AutoHelp.TryUseAction(tInfo, AutoHelp.DispelMagicKey) then
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_DISPOSION") and tInfo["hasPoison"] and AutoHelp.DispelPoisonKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelPoisonKey) then
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_DISSICK") and tInfo["hasDisease"] and AutoHelp.DispelDiseaseKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelDiseaseKey) then
					return true
				end
			end
		end;
		function AutoHelp.DoDispelAction()
			if not GetStatus("HEAL_STATUS_DISMAGIC") and not GetStatus("HEAL_STATUS_DISSICK") and not GetStatus("HEAL_STATUS_DISPOSION") then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["hasDebuff"] and AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] then
					if tInfo["role"] == "MAINTANK" and rj(tInfo) then
						AutoHelp.DebugText = "驱散坦克"
						return true
					end;
					if tInfo["unit"] == "player" and rj(tInfo) then
						AutoHelp.DebugText = "驱散自己"
						return true
					end;
					if rj(tInfo) then
						AutoHelp.DebugText = "驱散团队"
						return true
					end
				end
			end
		end;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, r7 = mH["hp"], mH["mp"] * 100;
			local rl = mH["power"]
			local rm = targetInfo and targetInfo["hp"] <= 0.2;
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local ib, iG = AutoHelp.GetRange("target")
			local function ro()
				local rp = r7 <= 10;
				local rq = iG <= 2;
				if GetStatus("ATTACK_防护_正义之怒") and AutoHelp.TryUseAction(mH, "正义之怒") then
					return true
				end;
				if UnitCanAttack("player", "target") and not UnitIsUnit("player", "targettarget") and not UnitIsPVP("target") then
					if GetStatus("STATUS_清算之手") then
						local tInfo = GetRaidUnit("targettarget")
						if not tInfo or tInfo and tInfo["role"] ~= "MAINTANK" then
							if AutoHelp.TryUseAction(targetInfo, "清算之手") then
								return true
							end
						end
					end;
					if GetStatus("STATUS_正义防御") then
						local tInfo = GetRaidUnit("targettarget")
						if tInfo and tInfo["role"] ~= "MAINTANK" then
							if AutoHelp.TryUseAction(tInfo, "正义防御") then
								return true
							end
						end
					end
				end;
				if GetStatus("STATUS_自我驱散") and mH["hasDebuff"] and rj(mH) then
					return true
				end;
				if GetStatus("ATTACK_防护_愤怒之锤") and not rp and rm and AutoHelp.TryUseAction(targetInfo, "愤怒之锤") then
					return true
				end;
				if GetStatus("ATTACK_防护_神圣恳求") and AutoHelp.TryUseAction(mH, "神圣恳求") then
					AutoHelp.DebugText = "神圣恳求回蓝"
					return true
				end;
				if GetStatus("ATTACK_防护_神圣愤怒") and (UnitCreatureType(targetInfo["unit"]) == "亡灵" or UnitCreatureType(targetInfo["unit"]) == "恶魔") and not rp and rq and AutoHelp.TryUseAction(mH, "神圣愤怒") then
					return true
				end;
				if GetStatus("ATTACK_防护_复仇者之盾") and not rp and AutoHelp.TryUseAction(targetInfo, "复仇者之盾") then
					return true
				end;
				if GetStatus("ATTACK_防护_圣光审判") and jy("KEEPJUDGE") and AutoHelp.TryUseAction(targetInfo, jy("KEEPJUDGE")) then
					return true
				end;
				if GetStatus("HEAL_STATUS_AOE") and AutoHelp.getNumberTargets() >= 2 then
					if GetStatus("ATTACK_防护_正义之锤") and AutoHelp.TryUseAction(targetInfo, "正义之锤") then
						return true
					end;
					if GetStatus("ATTACK_防护_奉献") and not rp and iG <= 2 and AutoHelp.TryUseAction(mH, "奉献") then
						return true
					end;
					if GetStatus("ATTACK_防护_正义盾击") and AutoHelp.TryUseAction(targetInfo, "正义盾击") then
						return true
					end;
					if GetStatus("ATTACK_防护_神圣之盾") and rq and AutoHelp.TryUseAction(mH, "神圣之盾") then
						return true
					end
				else
					if GetStatus("ATTACK_防护_正义盾击") and AutoHelp.TryUseAction(targetInfo, "正义盾击") then
						return true
					end;
					if GetStatus("ATTACK_防护_奉献") and not rp and iG <= 2 and AutoHelp.TryUseAction(mH, "奉献") then
						return true
					end;
					if GetStatus("ATTACK_防护_正义之锤") and AutoHelp.TryUseAction(targetInfo, "正义之锤") then
						return true
					end;
					if GetStatus("ATTACK_防护_神圣之盾") and rq and AutoHelp.TryUseAction(mH, "神圣之盾") then
						return true
					end
				end;
				if GetStatus("ATTACK_防护_圣洁护盾") and AutoHelp.TryUseAction(mH, "圣洁护盾") then
					return true
				end;
				if GetStatus("ATTACK_防护_驱邪术") and AutoHelp.TryUseAction(targetInfo, "驱邪术") then
					return true
				end
			end;
			local function rr()
				local rq = iG <= 2;
				if GetStatus("ATTACK_奶骑_正义之怒") and AutoHelp.TryUseAction(mH, "正义之怒") then
					return true
				end;
				if GetStatus("ATTACK_奶骑_奉献") and rq and AutoHelp.TryUseAction(mH, "奉献") then
					return true
				end;
				if GetStatus("ATTACK_奶骑_神圣愤怒") and (UnitCreatureType(targetInfo["unit"]) == "亡灵" or UnitCreatureType(targetInfo["unit"]) == "恶魔") and rq and AutoHelp.TryUseAction(mH, "神圣愤怒") then
					return true
				end;
				if GetStatus("ATTACK_奶骑_圣光审判") and jy("KEEPJUDGE") and AutoHelp.TryUseAction(targetInfo, jy("KEEPJUDGE")) then
					return true
				end;
				if GetStatus("ATTACK_奶骑_神圣震击") and AutoHelp.TryUseAction(targetInfo, "神圣震击") then
					return true
				end;
				if GetStatus("ATTACK_奶骑_愤怒之锤") and rm and AutoHelp.TryUseAction(targetInfo, "愤怒之锤") then
					return true
				end;
				if GetStatus("ATTACK_奶骑_正义盾击") and AutoHelp.TryUseAction(targetInfo, "正义盾击") then
					return true
				end;
				if GetStatus("ATTACK_奶骑_驱邪术") and AutoHelp.TryUseAction(targetInfo, "驱邪术") then
					return true
				end;
				if GetStatus("HEAL_STATUS_KEEPJUDGE") and jy("KEEPJUDGE") and AutoHelp.TryUseAction(targetInfo, jy("KEEPJUDGE")) then
					AutoHelp.DebugText = "审判目标[" .. jy("KEEPJUDGE")
					return true
				end
			end;
			local function rs()
				local rq = iG <= 2;
				if GetStatus("ATTACK_惩戒_正义之怒") and AutoHelp.TryUseAction(mH, "正义之怒") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_复仇之怒") and rn and AutoHelp.TryUseAction(mH, "复仇之怒") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_圣洁护盾") and AutoHelp.TryUseAction(mH, "圣洁护盾") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_神圣恳求") and r7 <= 0.5 and AutoHelp.TryUseAction(mH, "神圣恳求") then
					return true
				end;
				if AutoHelp.UnitHasBuff("player", 59578) and GetStatus("HEAL_STATUS_FASTHEAL") and mT <= 0.4 and AutoHelp.TryUseAction(mH, "圣光闪现") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_神圣愤怒") and (UnitCreatureType(targetInfo["unit"]) == "亡灵" or UnitCreatureType(targetInfo["unit"]) == "恶魔") and rq and AutoHelp.TryUseAction(mH, "神圣愤怒") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_清算之手") and AutoHelp.Glyphs[405004] and AutoHelp.TryUseAction(targetInfo, "清算之手") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_愤怒之锤") and rm and AutoHelp.TryUseAction(targetInfo, "愤怒之锤") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_圣光审判") and iG > 2 and jy("KEEPJUDGE") and AutoHelp.TryUseAction(targetInfo, jy("KEEPJUDGE")) then
					return true
				end;
				if GetStatus("ATTACK_惩戒_十字军打击") and AutoHelp.TryUseAction(targetInfo, "十字军打击") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_圣光审判") and jy("KEEPJUDGE") and AutoHelp.TryUseAction(targetInfo, jy("KEEPJUDGE")) then
					return true
				end;
				if GetStatus("ATTACK_惩戒_神圣风暴") and iG <= 5 and AutoHelp.TryUseAction(mH, "神圣风暴") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_奉献") and rq and AutoHelp.TryUseAction(mH, "奉献") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_驱邪术") and AutoHelp.UnitHasBuff("player", 59578) and AutoHelp.TryUseAction(targetInfo, "驱邪术") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_神圣愤怒") and (UnitCreatureType(targetInfo["unit"]) == "亡灵" or UnitCreatureType(targetInfo["unit"]) == "恶魔") and rq and AutoHelp.TryUseAction(mH, "神圣愤怒") then
					return true
				end;
				if GetStatus("ATTACK_惩戒_驱邪术") and AutoHelp.TryUseAction(targetInfo, "驱邪术") then
					return true
				end
			end;
			local kH = jy("HEALMODE")
			if kH == "防护" then
				if ro() then
					return true
				end;
				return
			end;
			if kH == "惩戒" then
				if rs() then
					return true
				end;
				return
			end;
			if rr() then
				return true
			end
		end
	end;
	if PlayerIsClass("PALADIN") then
		AutoHelp.ClassConfig = qN
	end
end;
if AutoHelp.isWotlk then
	local function rt()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {
			[1] = GetSpellInfo(2061),
			[2] = GetSpellInfo(2060),
			[3] = GetSpellInfo(2054),
			[4] = GetSpellInfo(2050)
		}
		AutoHelp.RESCURIT_name = GetSpellInfo(2006)
		AutoHelp.RESCURIT_KEY = GetSpellInfo(2006)
		AutoHelp.CAN_RESCURIT = true;
		AutoHelp.CAN_HEAL = true;
		AutoHelp.CAN_BUFF = true;
		AutoHelp.CAN_DISPEL = true;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 2;
		AutoHelp.AttackRange = 30;
		AutoHelp.DispelMagicKey = GetSpellInfo(527)
		AutoHelp.DispelDiseaseKey = GetSpellInfo(552)
		if not GetSpellInfo(AutoHelp.DispelDiseaseKey) then
			AutoHelp.DispelDiseaseKey = GetSpellInfo(528)
		end;
		local function ru(hK, jI)
			if jI then
				if hK ~= "单体" then
					SetConfig("STATUS_单体输出", false)
				end;
				if hK ~= "自动" then
					SetConfig("STATUS_自动输出", false)
				end
			end
		end;
		AutoHelp.CommingHealWindow = 2.99;
		AutoHelp.LastHealTeamAction = {}
		AutoHelp.LastMoveHealTeamAction = {}
		local rv = nil;
		local function co(a, cp)
			return (a + cp) / 2
		end;
		local function qO(jI)
			if jy("HEALMODE") == "暗影" then
				return
			end;
			if jI then
				SetConfig("HEAL_STATUS_主动开怪2", false)
				SetConfig("STATUS_目标互动2", false)
				SetConfig("STATUS_自动寻怪2", false)
				SetConfig("STATUS_自动拾取2", false)
				AutoHelp.ShowItem("HEAL_STATUS_主动开怪2")
				AutoHelp.ShowItem("STATUS_目标互动2")
				AutoHelp.ShowItem("STATUS_自动寻怪2")
				AutoHelp.ShowItem("STATUS_自动拾取2")
				AutoHelp.ShowItems("normal")
				AutoHelp.ResizePanel()
			else
				AutoHelp.HideItem("HEAL_STATUS_主动开怪2")
				AutoHelp.HideItem("STATUS_目标互动2")
				AutoHelp.HideItem("STATUS_自动寻怪2")
				AutoHelp.HideItem("STATUS_自动拾取2")
				AutoHelp.HideItems("normal")
				AutoHelp.ResizePanel()
			end
		end;
		local n9 = {
			{
				name = "射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "惩击",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "快速治疗",
				spellId = true,
				["target"] = true,
				["useSP"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "次级治疗术",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "治疗术",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "联结治疗",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "治疗之环",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "守护之魂",
				spellId = true,
				["target"] = true
			},
			{
				name = "强效治疗术",
				spellId = true,
				["target"] = true,
				["useSP"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "苦修",
				spellId = true,
				["target"] = true,
				["useSP"] = true,
				["healType"] = 1
			},
			{
				name = "治疗祷言",
				spellId = true,
				["target"] = true,
				["useSP"] = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "愈合祷言",
				spellId = true,
				["target"] = true,
				["useSP"] = true,
				["healType"] = 4
			},
			{
				name = "绝望祷言",
				spellId = true,
				["healType"] = 1,
				["fastSpell"] = true
			},
			{
				name = "恢复",
				spellId = true,
				["target"] = true,
				["healType"] = 3,
				["auraNameCID2"] = true,
				["fastSpell"] = true
			},
			{
				name = "真言术：盾",
				spellId = true,
				["target"] = true,
				["healType"] = 4,
				["fastSpell"] = true
			},
			{
				name = "暗言术：痛",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "暗言术：痛鼠标指向",
				spellId = true,
				["spellName"] = "暗言术：痛",
				["macro"] = "/cast [@mouseover,exists,harm]暗言术：痛"
			},
			{
				name = "暗言术：痛2",
				spellId = true,
				["spellName"] = "暗言术：痛",
				["target"] = true
			},
			{
				name = "暗言术：灭",
				spellId = true,
				["target"] = true
			},
			{
				name = "渐隐术",
				spellId = true
			},
			{
				name = "复活术",
				spellId = true,
				["comkey"] = true,
				["target"] = true
			},
			{
				name = "心灵震爆",
				spellId = true,
				["target"] = true,
				["useCrit"] = {
					"心灵专注"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "心灵之火",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "心灵尖啸",
				spellId = true
			},
			{
				name = "祛病术",
				spellId = true,
				["target"] = true
			},
			{
				name = "驱除疾病",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true,
				["fastSpell"] = true
			},
			{
				name = "驱散魔法",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "回馈",
				spellId = true
			},
			{
				name = "防护恐惧结界",
				spellId = true,
				["target"] = true
			},
			{
				name = "噬灵疫病",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "暗影守卫",
				spellId = true
			},
			{
				name = "神圣之火",
				spellId = true
			},
			{
				name = "安抚心灵",
				spellId = true
			},
			{
				name = "束缚亡灵",
				spellId = true
			},
			{
				name = "心灵视界",
				spellId = true
			},
			{
				name = "法力燃烧",
				spellId = true
			},
			{
				name = "精神控制",
				spellId = true
			},
			{
				name = "漂浮术",
				spellId = true,
				["target"] = true
			},
			{
				name = "真言术：韧",
				spellId = true,
				["target"] = true,
				["auraName"] = "坚韧祷言"
			},
			{
				name = "坚韧祷言",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "心灵专注",
				spellId = true
			},
			{
				name = "神圣新星",
				spellId = true,
				["healType"] = 5,
				["powerPercent"] = 0.1
			},
			{
				name = "精神鞭笞",
				spellId = true,
				["target"] = true,
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "神圣之灵",
				spellId = true,
				["target"] = true,
				["auraName"] = "精神祷言"
			},
			{
				name = "精神祷言",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "暗影防护",
				spellId = true,
				["target"] = true,
				["auraName"] = "暗影防护祷言"
			},
			{
				name = "暗影防护祷言",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "暗影魔",
				spellId = true,
				["target"] = true
			},
			{
				name = "沉默",
				spellId = true
			},
			{
				name = "吸血鬼的拥抱",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "吸血鬼之触",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["debuffRT"] = 1.0,
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "吸血鬼之触鼠标",
				spellId = true,
				["spellName"] = "吸血鬼之触",
				["macro"] = "/cast [@mouseover,exists,harm]吸血鬼之触"
			},
			{
				name = "精神灼烧",
				spellId = true,
				["target"] = true,
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "能量灌注",
				spellId = true,
				["target"] = true
			},
			{
				name = "消散",
				spellId = true
			},
			{
				name = "痛苦压制",
				spellId = true,
				["spellName"] = "痛苦压制",
				["macro"] = "/cast [help,nodead][target=targettarget,help,nodead] 痛苦压制\n"
			},
			{
				name = "焦点痛苦压制",
				spellId = true,
				["spellName"] = "痛苦压制",
				["macro"] = "/cast [target=focus,exists,nodead,help] 痛苦压制\n"
			},
			{
				name = "群体驱散",
				spellId = true,
				["macro"] = "/cast [@cursor]群体驱散\n"
			},
			{
				name = "光明之泉",
				spellId = true
			},
			{
				name = "暗影形态",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "神圣赞美诗",
				spellId = true,
				["auraNameCID"] = true,
				["useCrit"] = {
					"心灵专注"
				}
			},
			{
				name = "希望圣歌",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				["name"] = "选中镜像",
				["macro"] = "/targetexact 裹体之网\n/targetexact 镜像\n/cast [exists]精神鞭笞\n",
				["spellName"] = "选中镜像",
				["spellTime"] = 1,
				["desc"] = "选中镜像"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "治疗"
			AutoHelp.ModeDefaultSetting = {
				["STATUS_治疗模式"] = true,
				["STATUS_主动攻击"] = false,
				["HEAL_STATUS_FIRSTDISPAL"] = false,
				["HEAL_STATUS_DISMAGIC"] = true,
				["HEAL_STATUS_DISSICK"] = true,
				["HEAL_STATUS_DISPALSELF"] = false,
				["HEAL_STATUS_DISPALTANK"] = false,
				["HEAL_STATUS_TDISPALGROUP"] = true,
				["HEAL_STATUS_AUTOINTERRUPT_OVERHEAL"] = false,
				["HEAL_OVERHEAL_VALUE"] = 98,
				["HEAL_STATUS_AUTOHEAL"] = true,
				["HEAL_AUTO_VALUE"] = 90,
				["HEAL_STATUS_FIRSTTANK"] = true,
				["HEAL_FIRSTTANK_VALUE"] = 60,
				["ALWAYSMANABOOM"] = false,
				["ONLYDAOYAN"] = false,
				["HEAL_STATUS_ONEHEAL"] = false,
				["OverHealValue"] = 100,
				["OverHealType"] = "OVERHEALNORMAL",
				["HEAL_STATUS_AUTOCHOOSE"] = true,
				["HEAL_STATUS_PROTECT"] = true,
				["HEAL_VALUE_PROTECT"] = 30,
				["HEAL_STATUS_PROTECT_WARRIOR"] = true,
				["HEAL_STATUS_PROTECT_PALADIN"] = true,
				["HEAL_STATUS_PROTECT_DRUID"] = true,
				["HEAL_STATUS_PROTECT_WARLOCK"] = true,
				["HEAL_STATUS_PROTECT_MAGE"] = true,
				["HEAL_STATUS_PROTECT_PRIEST"] = true,
				["HEAL_STATUS_PROTECT_ROGUE"] = true,
				["HEAL_STATUS_PROTECT_HUNTER"] = true,
				["HEAL_STATUS_PROTECT_SHAMAN"] = true,
				["HEAL_STATUS_PROTECT_DEATHKNIGHT"] = true,
				["HEALKEYS"] = {
					"真言术：盾",
					"苦修",
					"快速治疗",
					"恢复",
					"愈合祷言",
					"治疗之环"
				},
				["MOVEHEALKEYS"] = {
					"真言术：盾",
					"恢复",
					"愈合祷言",
					"治疗之环"
				}
			}
			if GetSpellInfo("强效治疗术") then
				rv = "强效治疗术"
			elseif GetSpellInfo("治疗术") then
				rv = "治疗术"
			else
				rv = "次级治疗术"
			end;
			if UnitLevel("player") < 70 then
				table.insert(AutoHelp.ModeDefaultSetting["HEALKEYS"], 1, rv)
			end;
			AutoHelp.HEAL_MODES = {
				["治疗"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_无脑补盾"] = true,
					["HEAL_STATUS_坦克套盾"] = true,
					["HEAL_STATUS_全团套盾"] = false,
					["HEAL_STATUS_无脑恢复"] = false,
					["HEAL_STATUS_坦克恢复"] = false,
					["HEAL_STATUS_全团恢复"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569已设置为系统缺省【治疗模式】。\124r",
					["HEAL_STATUS_恢复"] = true
				},
				["无脑套盾"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_无脑补盾"] = true,
					["HEAL_STATUS_坦克套盾"] = true,
					["HEAL_STATUS_全团套盾"] = true,
					["HEAL_STATUS_无脑恢复"] = false,
					["HEAL_STATUS_坦克恢复"] = true,
					["HEAL_STATUS_全团恢复"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569全程无脑套盾+愈合祷言, WCL99分治疗手法。。\124r",
					["HEALKEYS"] = {
						"真言术：盾",
						"苦修",
						"快速治疗",
						"恢复",
						"愈合祷言",
						"治疗之环"
					},
					["MOVEHEALKEYS"] = {
						"真言术：盾",
						"恢复",
						"愈合祷言",
						"治疗之环"
					}
				},
				["神圣牧师"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_无脑补盾"] = false,
					["HEAL_STATUS_坦克套盾"] = false,
					["HEAL_STATUS_全团套盾"] = false,
					["HEAL_STATUS_无脑恢复"] = true,
					["HEAL_STATUS_坦克恢复"] = true,
					["HEAL_STATUS_全团恢复"] = true,
					["HEAL_STATUS_苦修"] = false,
					["HEAL_STATUS_恢复"] = true,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569全程无脑套盾+愈合祷言, WCL99分治疗手法。。\124r",
					["HEALKEYS"] = {
						"快速治疗",
						"恢复",
						"愈合祷言",
						"治疗之环"
					},
					["MOVEHEALKEYS"] = {
						"恢复",
						"愈合祷言",
						"治疗之环"
					}
				},
				["打怪"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_主动开怪"] = true,
					["STATUS_目标互动"] = true,
					["HEAL_AUTO_VALUE"] = 50,
					["modetip"] = "\124cffFFF569已设置为【打怪模式】\124r"
				},
				["暗影"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_协助坦克"] = true,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_DISPALSELF"] = true,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["HEAL_STATUS_FIRSTDISPAL"] = false,
					["HEAL_STATUS_DISMAGIC"] = false,
					["HEAL_STATUS_DISSICK"] = false,
					["modetip"] = "\124cffFFF569已设置为【暗牧】\124r"
				},
				["将军英雄"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_无脑补盾"] = false,
					["HEAL_STATUS_AUTOHEAL"] = true,
					["HEAL_AUTO_VALUE"] = 60,
					["HEAL_STATUS_FIRSTTANK"] = true,
					["HEAL_FIRSTTANK_VALUE"] = 70,
					["HEAL_STATUS_PROTECT"] = false,
					["HEAL_STATUS_DISPALSELF"] = false,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["HEAL_STATUS_FIRSTHEALSELF"] = false,
					["HEAL_STATUS_HOLYTHERAPYSELF"] = false,
					["HEAL_STATUS_PROTECTSELF"] = false,
					["HEAL_STATUS_SHIELDSELF"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569设置为【ULD将军刷坦模式】，且只在坦克血量低于70%的时候开始刷血，节省蓝量。\124r",
					["HEALKEYS"] = {
						"真言术：盾",
						"苦修",
						"快速治疗",
						"恢复",
						"治疗之环"
					},
					["MOVEHEALKEYS"] = {
						"真言术：盾",
						"恢复",
						"治疗之环"
					}
				}
			}
			AutoHelp.ModeList = {
				{
					text = "治疗模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00治疗\124r",
					name = "治疗",
					tooltipTitle = "治疗",
					tooltipText = "标准模式使用系统缺省设置进行治疗。"
				},
				{
					text = "\124cff00ff00无脑套盾\124r",
					name = "无脑套盾",
					tooltipTitle = "无脑套盾",
					tooltipText = "全程无脑套盾加愈合祷言, WCL毛分治疗手法。"
				},
				{
					text = "\124cffFFFFFF打怪\124r",
					name = "打怪",
					tooltipTitle = "打怪",
					tooltipText = "尽量减少自我治疗的频率"
				},
				{
					text = "将军英雄",
					name = "将军英雄",
					tooltipTitle = "将军英雄",
					tooltipText = "\124cffFFF569设置为【ULD将军英雄刷坦模式】，只治疗坦克，且只在坦克血量低于70%的时候开始刷血。\124r"
				},
				{
					text = "\124cff00ff00神圣牧师\124r",
					name = "神圣牧师",
					tooltipTitle = "神圣牧师",
					tooltipText = "使用神圣天赋进行治疗。"
				},
				{
					text = "输出模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cffFFFFFF暗影\124r",
					name = "暗影",
					tooltipTitle = "暗影",
					tooltipText = "开启暗牧输出模式，不进行自我治疗"
				}
			}
			AutoHelp.STAND_HEAL_SPELLS = {
				"苦修",
				"快速治疗",
				"恢复",
				"真言术：盾",
				"神圣新星",
				"愈合祷言",
				"联结治疗",
				"治疗之环"
			}
			table.insert(AutoHelp.STAND_HEAL_SPELLS, 1, rv)
			AutoHelp.MOVE_HEAL_SPELLS = {
				"恢复",
				"真言术：盾",
				"愈合祷言",
				"治疗之环"
			}
			AutoHelp.PANELHEIGHT = 440;
			AutoHelp.PANELWIDTH = 160;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00辅助功能设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTDISPAL",
						["value"] = false,
						["title"] = "\124cff00ff00优先驱散\124r",
						["tip"] = "优先驱散，驱散将优先加血，现在版本加入队友有血量低于50%依然先加血，以阻止一直在驱散而不加血的问题。\n\n\124cff00ff00对于频繁产生负面效果时，建议关闭此选项提高治疗量\124r",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISMAGIC",
						["value"] = true,
						["title"] = "魔",
						["tipTitle"] = "驱散魔法",
						["tip"] = "驱散魔法效果，自动驱散魔法效果\n\n\124cff00ff00自动使用清洁术驱散目标魔法效果\124r",
						["point"] = 85,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISSICK",
						["value"] = true,
						["title"] = "病",
						["tipTitle"] = "驱散疾病",
						["tip"] = "驱散疾病效果，自动驱散疾病效果\n\n\124cff00ff00自动使用清洁术驱散目标疾病效果\124r",
						["point"] = 120,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_耐力",
						["value"] = true,
						["title"] = "耐力",
						["tipTitle"] = "耐力BUFF",
						["tip"] = "自动给团队中的小队上耐力",
						["point"] = 5,
						["hitRect"] = - 20,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("真言术：韧") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_精神",
						["value"] = true,
						["title"] = "精",
						["tipTitle"] = "精神BUFF",
						["tip"] = "给团队中的小队上精神",
						["point"] = 50,
						["hitRect"] = - 10,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("神圣之灵") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_暗抗",
						["value"] = false,
						["title"] = "暗",
						["tipTitle"] = "防护暗影BUFF",
						["tip"] = "给团队中的小队上暗抗",
						["point"] = 80,
						["hitRect"] = - 10,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("暗影防护") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_强效",
						["value"] = false,
						["title"] = "强效",
						["tipTitle"] = "使用强效耐力精神",
						["tip"] = "给团队中的小队上强效耐力/强效精神，不选缺省上小耐力小精神",
						["point"] = 110,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("坚韧祷言") and not AutoHelp.HasActionKey("暗影防护祷言") and not AutoHelp.HasActionKey("精神祷言") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_能量灌注",
						["hide"] = not AutoHelp.HasActionKey("能量灌注"),
						["value"] = true,
						["title"] = "灌注",
						["tip"] = "\124cff00ff00自动给队友上能量灌注，会卡CD给选定队友能量灌注, 如果要暂停可以暂时取消直到需要灌注再勾选。\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("能量灌注") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_GUANZHU_UNIT",
						["hide"] = not AutoHelp.HasActionKey("能量灌注"),
						["title"] = "选择能量灌注队友",
						["tipTitle"] = "能量灌注队友选择",
						["tip"] = "在设定好队伍/团队人员之后，将自动在给队友上能量灌注，如果没有选择，不会给自己能量灌注。",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(kl)
							local cd = jy("能量灌注")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo == nil and jy("能量灌注") == "无" then
								AutoHelp.Debug("要设置能量灌注目标请先选择队友！")
								return
							end;
							if tInfo ~= nil then
								local oW, oX = UnitPowerType(tInfo["unit"])
								if oX ~= "MANA" then
									AutoHelp.Debug("无法给[" .. tInfo["className"] .. "]能量灌注:" .. tInfo["name"])
									return
								end;
								SetConfig("能量灌注", tInfo["name"])
								AutoHelp.Debug("设置灌注目标：" .. tInfo["name"])
							else
								SetConfig("能量灌注", "无")
								AutoHelp.Debug("清除灌注目标。")
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_心灵之火",
						["value"] = true,
						["title"] = "心灵之火",
						["tip"] = "自动给自己上心灵之火",
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("心灵之火") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_暗影魔",
						["value"] = true,
						["title"] = "暗影魔",
						["tip"] = "自动释放暗影魔攻击当前目标或者队友的目标敌人，回蓝。缺省设置自身蓝量低于30%施放暗影魔。",
						["point"] = 85,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("暗影魔") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_无脑补盾",
						["value"] = false,
						["title"] = "无脑补盾",
						["tip"] = "依次给队友补盾, 优先级高于治疗加血。\n如果承担抬血刷T的职责, 可以暂时不勾选进行队友加血。\n\n选择此项, 也将同时给当前TANK卡CD上愈合祷言。\n\n\124cff00ff00WLK版本戒律牧套盾是高分治疗神器！！\124r",
						["point"] = 5,
						["hitRect"] = - 50,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("真言术：盾") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_坦克套盾",
						["value"] = true,
						["title"] = "坦",
						["tip"] = "保持给坦克套盾，如果不选择此项，即使选择全团补盾，也将不会自动给坦克补盾，这是为了保证在接下来的AOE时刻，全团同时破盾回蓝，而不会被坦克提前破盾影响破盾回蓝。",
						["point"] = 85,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("真言术：盾") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_全团套盾",
						["value"] = false,
						["title"] = "团",
						["tip"] = "保持给全团套盾",
						["point"] = 120,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("真言术：盾") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_无脑恢复",
						["value"] = true,
						["title"] = "无脑恢复",
						["tip"] = "依次给队友上恢复, 优先级高于其他治疗循环。\n如果承担抬血刷T的职责, 可以暂时不勾选进行队友加血。\n\n选择此项, 也将同时给当前TANK卡CD上愈合祷言。\n\n\124cff00ff00WLK神圣牧师使用！！\124r",
						["point"] = 5,
						["hitRect"] = - 50,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("恢复") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_坦克恢复",
						["value"] = true,
						["title"] = "坦",
						["tip"] = "保持给坦克恢复",
						["point"] = 85,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("恢复") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_全团恢复",
						["value"] = false,
						["title"] = "团",
						["tip"] = "保持给全团恢复",
						["point"] = 120,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("恢复") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_恢复",
						["hide"] = not AutoHelp.HasActionKey("恢复"),
						["value"] = true,
						["title"] = "恢复血量",
						["tip"] = "当治疗目标血量低于设定值，使用恢复，缺省设置80%",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("恢复") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_恢复血量",
						["hide"] = not AutoHelp.HasActionKey("恢复"),
						["value"] = 80,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_苦修",
						["hide"] = not AutoHelp.HasActionKey("苦修"),
						["value"] = true,
						["title"] = "苦修血量",
						["tip"] = "当治疗目标血量低于设定值，使用苦修，缺省设置60%",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("苦修") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_苦修血量",
						["hide"] = not AutoHelp.HasActionKey("苦修"),
						["value"] = 60,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_神圣赞美诗",
						["title"] = "团血",
						["tipTitle"] = "神圣赞美诗（团队抬血）",
						["tip"] = "施放神圣赞美诗（团队抬血）\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = true,
						["mode"] = "healer",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("神圣赞美诗") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("神圣赞美诗")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_希望圣歌",
						["title"] = "团蓝",
						["tipTitle"] = "希望圣歌（团队回蓝）",
						["tip"] = "施放希望圣歌（团队回蓝）\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("希望圣歌") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("希望圣歌")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_痛苦压制",
						["title"] = "压制",
						["tipTitle"] = "目标痛苦压制",
						["tip"] = "对目标施放痛苦压制，请选择目标（如坦克）后点击本按钮。\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("痛苦压制") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("痛苦压制")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_焦点痛苦压制",
						["title"] = "焦压",
						["tipTitle"] = "焦点目标焦点痛苦压制",
						["tip"] = "对焦点目标施放焦点痛苦压制，请先设置焦点，点击本按钮。\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = false,
						["mode"] = "healer",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("痛苦压制") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("焦点痛苦压制")
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_主动攻击",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cff00ff00启动攻击\124r",
						["tip"] = "如果团队血量不需要治疗时,有敌方目标且在战斗就开始攻击模式",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							qO(hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主动开怪2",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cfff00000主动开怪\124r",
						["tip"] = "选择此项，非战斗中可以主动攻击选中的敌对目标，不选择此项，即使有主动攻击，也不会进入战斗状态（攻击敌对目标）\124r",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							if jy("HEALMODE") ~= "暗影" then
								SetConfig("HEAL_STATUS_主动开怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_目标互动2",
						["value"] = false,
						["hitRect"] = - 30,
						["title"] = "\124cffFFF569互动\124r",
						["tip"] = "自动与目标互动，比如距离过远自动靠近目标，并攻击\n不选择目标互动，必须手动移动到攻击位置，才开始自动攻击",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							if jy("HEALMODE") ~= "暗影" then
								SetConfig("STATUS_目标互动", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动寻怪2",
						["value"] = false,
						["title"] = "\124cffFFF569寻怪\124r",
						["tip"] = "自动升级使用，站在某个地方，自动寻找怪物攻击",
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							if jy("HEALMODE") ~= "暗影" then
								SetConfig("STATUS_自动寻怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动拾取2",
						["value"] = false,
						["title"] = "\124cffFFF569拾取\124r",
						["tip"] = "自动升级使用，杀死怪物后自动拾取",
						["point"] = 105,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							if jy("HEALMODE") ~= "暗影" then
								SetConfig("STATUS_自动拾取", hK)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING2",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_镜像蛛网",
						["value"] = true,
						["title"] = "镜像",
						["tipTitle"] = "镜像蛛网",
						["tip"] = "当目进入有镜像或者蛛网的副本时，自动优先打镜像和蛛网裹体",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["create"] = function(ko)
							if AutoHelp.playerLevel < 80 then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tipTitle"] = "协助坦克[随机副本]",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_多目标痛",
						["value"] = false,
						["title"] = "多痛",
						["tipTitle"] = "鼠标指向上痛",
						["tip"] = "鼠标指向非当前敌对目标时自动上痛。\n\n\124cff00ff00适合多目标提高伤害，比如Xt002鼠标指向火花会自动给火花上痛，左右手皆可指向目标保持多目标痛。\124r",
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["hide"] = not AutoHelp.HasActionKey("精神灼烧"),
						["title"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果怪物数量大于等于3个，将自动启动精神灼烧技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能！\124r",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("精神灼烧") then
								ko:Disable()
							end
						end,
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_暗影_精神灼烧", true)
							else
								SetConfig("STATUS_暗影_精神灼烧", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_始终AOE",
						["value"] = false,
						["title"] = "始终AOE",
						["tip"] = "一直使用AOE技能进行攻击。",
						["hitRect"] = - 30,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_暗影_精神灼烧", true)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_神圣赞美诗2",
						["title"] = "团血",
						["tipTitle"] = "神圣赞美诗（团队抬血）",
						["tip"] = "施放神圣赞美诗（团队抬血）\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("神圣赞美诗") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("神圣赞美诗")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_希望圣歌2",
						["title"] = "团蓝",
						["tipTitle"] = "希望圣歌（团队回蓝）",
						["tip"] = "施放希望圣歌（团队回蓝）\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("希望圣歌") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("希望圣歌")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_消散2",
						["title"] = "消散",
						["tipTitle"] = "消散",
						["tip"] = "施放消散\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("消散") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("消散")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_暗影魔2",
						["title"] = "影魔",
						["tipTitle"] = "暗影魔",
						["tip"] = "施放暗影魔\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("暗影魔") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("暗影魔")
						end
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTHEALSELF",
						["value"] = true,
						["title"] = "优先自疗",
						["tip"] = "当自己血量低于设定值，优先治疗自己，缺省设置60%",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_FIRSTHEALSELF",
						["value"] = 60,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_团队通告",
						["value"] = false,
						["title"] = "团队通告",
						["tip"] = "通告赞美诗、唱歌、压制等大技能。",
						["point"] = 5,
						["hitRect"] = - 50,
						["nextpos"] = true
					}
				}
			}
			local qQ = {
				{
					{
						"暗影_射击",
						"射击",
						true,
						"魔杖攻击",
						"暗影"
					},
					{
						"暗影_吸血鬼的拥抱",
						"吸血鬼的拥抱",
						true,
						"吸血鬼拥",
						"暗影"
					},
					{
						"暗影_吸血鬼之触",
						"吸血鬼之触",
						true,
						"吸血鬼触",
						"暗影"
					},
					{
						"暗影_噬灵疫病",
						"噬灵疫病",
						true,
						"噬灵疫病",
						"暗影"
					},
					{
						"暗影_暗言术：痛",
						"暗言术：痛",
						true,
						"暗言术痛",
						"暗影"
					},
					{
						"暗影_心灵震爆",
						"心灵震爆",
						true,
						"心灵震爆",
						"暗影"
					},
					{
						"暗影_精神鞭笞",
						"精神鞭笞",
						true,
						"精神鞭笞",
						"暗影"
					},
					{
						"暗影_精神灼烧",
						"精神灼烧",
						true,
						"精神灼烧",
						"暗影"
					},
					{
						"暗影_暗言术：灭",
						"暗言术：灭",
						false,
						"暗言术灭",
						"暗影"
					}
				},
				{
					{
						"治疗_射击",
						"射击",
						true,
						"魔杖攻击",
						"normal"
					},
					{
						"治疗_吸血鬼之触",
						"吸血鬼之触",
						true,
						"吸血鬼触",
						"normal"
					},
					{
						"治疗_噬灵疫病",
						"噬灵疫病",
						true,
						"噬灵疫病",
						"normal"
					},
					{
						"治疗_暗言术：痛",
						"暗言术：痛",
						true,
						"暗言术痛",
						"normal"
					},
					{
						"治疗_心灵震爆",
						"心灵震爆",
						true,
						"心灵震爆",
						"normal"
					},
					{
						"治疗_精神鞭笞",
						"精神鞭笞",
						true,
						"精神鞭笞",
						"normal"
					},
					{
						"治疗_精神灼烧",
						"精神灼烧",
						true,
						"精神灼烧",
						"normal"
					},
					{
						"治疗_惩击",
						"惩击",
						false,
						"惩击",
						"normal"
					},
					{
						"治疗_苦修",
						"苦修",
						false,
						"苦修",
						"normal"
					},
					{
						"治疗_神圣之火",
						"神圣之火",
						false,
						"神圣之火",
						"normal"
					},
					{
						"治疗_神圣新星",
						"神圣新星",
						false,
						"神圣新星",
						"normal"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local jS = # AutoHelp.PANEL_CONFIG["healer"]
				local rw = 0;
				if jS % 2 == 1 then
					rw = 1
				end;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 2 == rw then
							point = 5;
							kf = true
						else
							point = 80;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tip"] = qS[4],
							["point"] = point,
							["nextpos"] = kf,
							["mode"] = qS[5]
						}
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], jS + 1, eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if kH == "暗影" then
				AutoHelp.NAMEPLATES_MAXDISTANCE = 36
			else
				AutoHelp.NAMEPLATES_MAXDISTANCE = 40
			end;
			local qT = kH ~= "暗影"
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or qT and Contains(bn.mode, "healer") or not qT and Contains(bn.mode, "attack") then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			if qT then
				qO(GetStatus("STATUS_主动攻击"))
			end;
			AutoHelp.ResizePanel()
		end;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_HEALBOSSTARGET") then
				return
			end;
			local tInfo;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 55593 then
				AutoHelp.SetStopHealAction(16, GetSpellInfo(55593) .. "，停止治疗")
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.InstanceChanged(cd, eu, rx, ry, rz, rA, rB, gs, rC, rD)
		end;
		function AutoHelp.SpellCastSuccess(fq, ca, cx, fu, qX, qY)
			if cx == "神圣赞美诗" or cx == "希望圣歌" or cx == "痛苦压制" then
				if GetStatus("HEAL_STATUS_团队通告") then
					if fu then
						AutoHelp.SendChatMsg(">>>" .. (fq or "") .. "已释放【" .. (cx or "") .. "】=>" .. (fu or "") .. "<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
					else
						AutoHelp.SendChatMsg(">>>" .. (fq or "") .. "已释放【" .. (cx or "") .. "】<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
					end
				end
			end
		end;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
			local cx = GetSpellInfo(ca)
			if ho == "player" then
			end;
			if cx == "神圣赞美诗" or cx == "希望圣歌" or cx == "痛苦压制" then
				if GetStatus("HEAL_STATUS_团队通告") then
				end
			end
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.HasActionKey("神圣赞美诗") then
				local pj = FindOrCreateMacro("AH神圣赞美诗", nil, "#showtooltips 神圣赞美诗\n/stopcasting\n/ahcast 神圣赞美诗\n", 1)
			end;
			if AutoHelp.HasActionKey("希望圣歌") then
				local pj = FindOrCreateMacro("AH希望圣歌", nil, "#showtooltips 希望圣歌\n/stopcasting\n/ahcast 希望圣歌\n", 2)
			end;
			if AutoHelp.HasActionKey("痛苦压制") then
				local pj = FindOrCreateMacro("AH痛苦压制", nil, "#showtooltips 痛苦压制\n/stopcasting\n/ahcast 痛苦压制\n")
			end;
			if AutoHelp.HasActionKey("治疗祷言") then
				local pj = FindOrCreateMacro("AH治疗祷言", nil, "#showtooltips 治疗祷言\n/stopcasting\n/ahcast 治疗祷言\n")
			end;
			if AutoHelp.HasActionKey("群体驱散") then
				local pj = FindOrCreateMacro("AH群体驱散", nil, "#showtooltips 群体驱散\n/stopcasting\n/ahcast 群体驱散\n")
			end;
			if AutoHelp.HasActionKey("痛苦压制") then
				local pj = FindOrCreateMacro("AH焦点痛苦压制", nil, "#showtooltips 痛苦压制\n/stopcasting\n/ahcast 焦点痛苦压制\n")
			end;
			AutoHelp.Debug("赞美诗/希望圣歌/痛苦压制等功能性宏已经被创建, 请按照需要将这些宏拖到合适的位置!")
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52)
			FindOrCreateMacro("治疗模式", nil, "#showtooltips 快速治疗\n/run AutoHelp.SetMode(\"治疗\")\n/run AutoHelp.SetHealAll(true,90)\n/run AutoHelp.SetHealTank(true, 60)\n/run AutoHelp.SetHealTarget(false, 95)\n")
			FindOrCreateMacro("套盾模式", nil, "#showtooltips 真言术：盾\n/run AutoHelp.SetMode(\"无脑套盾\")\n/run AutoHelp.SetHealAll(true,90)\n/run AutoHelp.SetHealTank(true, 60)\n/run AutoHelp.SetHealTarget(false, 90)\n")
			FindOrCreateMacro("神圣模式", nil, "#showtooltips 恢复\n/run AutoHelp.SetMode(\"神圣牧师\")\n/run AutoHelp.SetHealAll(true,90)\n/run AutoHelp.SetHealTank(true, 60)\n/run AutoHelp.SetHealTarget(false, 90)\n")
		end;
		function AutoHelp.AddNextCastAction(qZ)
			for al, p in ipairs(qZ) do
				if p == "焦点痛苦压制" then
					if not UnitExists("focus") or not HEAL_RAID_NAMES[UnitName("focus")] then
						AutoHelp.Debug("未设置队友为焦点目标，不能使用焦点痛苦压制！")
						return false
					end
				end;
				if p == "痛苦压制" then
					if not UnitExists("target") then
						AutoHelp.Debug("请选择队友或者敌对目标施放痛苦压制！")
						return false
					end
				end
			end;
			return true
		end;
		local rE = false;
		function AutoHelp.SpellDamageAction(fm, aj, fu, ca, cx, amount)
			if cx == "精神鞭笞" and not GetStatus("HEAL_STATUS_PAUSE") then
				local rF = AutoHelp.IsSpellCooldown(GetSpellInfo(8092))
				local rG = AutoHelp.GetDebuffRemainTime("target", GetSpellInfo(2944), true)
				local rH = AutoHelp.GetDebuffRemainTime("target", GetSpellInfo(34914), true)
				if (rF or rG == 0 or rH == 0) and AutoHelp.castinfo.channeling and AutoHelp.castinfo.spellName == cx then
					if AutoHelp.castinfo.endTime and AutoHelp.castinfo.endTime - GetTime() >= 0.5 then
						AutoHelp.ForceBreakSpell = true;
						rE = true;
						HEAL_TIMERS["HEAL_TARGET"] = 0.001
					end
				end
			end
		end;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("能量灌注", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_GUANZHU_UNIT"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
		end;
		local function rI(tInfo)
			return not AutoHelp.UnitHasBuff(tInfo["unit"], "真言术：盾") and not AutoHelp.UnitHasDebuff(tInfo["unit"], "虚弱灵魂")
		end;
		local function r4(mH, targetInfo)
			if InCombatLockdown() and GetStatus("HEAL_STATUS_FIRSTHEALSELF") and mH["hp"] <= (GetStatusNumber("HEAL_VALUE_FIRSTHEALSELF") or 60) / 100 then
				AutoHelp.DebugText = "自我危机处理"
				if (AutoHelp.HasMoveKey("真言术：盾") or AutoHelp.HasStopMoveKey("真言术：盾")) and rI(mH) and AutoHelp.TryUseAction(mH, "真言术：盾") then
					return true
				end;
				if AutoHelp.TryUseAction(mH, "苦修") then
					return true
				end;
				if AutoHelp.TryUseAction(mH, "治疗之环") then
					return true
				end;
				if AutoHelp.TryUseAction(mH, "绝望祷言") then
					return true
				end;
				if AutoHelp.AutoHealTeam(mH) then
					return true
				end;
				if AutoHelp.TryUseAction(mH, "恢复") then
					return true
				end;
				if AutoHelp.TryUseAction(mH, "快速治疗") then
					return true
				end;
				AutoHelp.DebugText = ""
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_FIRSTDISPAL") and AutoHelp.DoDispelAction and AutoHelp.DoDispelAction() then
				return true
			end;
			if InCombatLockdown() and (GetStatus("HEAL_STATUS_无脑补盾") or GetStatus("HEAL_STATUS_无脑恢复")) then
				local rJ;
				for oz, tInfo in pairs(HEAL_RAID_TANKS) do
					if AutoHelp.IsValidEmergency(tInfo) then
						if UnitExists(oz .. "target") and UnitCanAttack("player", oz .. "target") and UnitIsUnit(oz, oz .. "targettarget") then
							if not AutoHelp.UnitHasBuffByPlayer(tInfo["unit"], "愈合祷言") and (AutoHelp.HasMoveKey("愈合祷言") or AutoHelp.HasStopMoveKey("愈合祷言")) then
								if AutoHelp.TryUseAction(tInfo, "愈合祷言") then
									return true
								end
							end
						else
							rJ = tInfo
						end
					end
				end;
				if rJ then
					if not AutoHelp.UnitHasBuffByPlayer(rJ["unit"], "愈合祷言") and (AutoHelp.HasMoveKey("愈合祷言") or AutoHelp.HasStopMoveKey("愈合祷言")) then
						if AutoHelp.TryUseAction(rJ, "愈合祷言") then
							return true
						end
					end
				end
			end;
			if (not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or InCombatLockdown()) and GetStatus("HEAL_STATUS_无脑补盾") and (GetStatus("HEAL_STATUS_坦克套盾") or GetStatus("HEAL_STATUS_全团套盾")) then
				if GetStatus("HEAL_STATUS_坦克套盾") then
					for oz, tInfo in pairs(HEAL_RAID_TANKS) do
						if AutoHelp.IsValidEmergency(tInfo) and rI(tInfo) then
							if AutoHelp.TryUseAction(tInfo, "真言术：盾") then
								return true
							end
						end
					end
				end;
				local rK = {}
				for oz, tInfo in pairs(HEAL_RAID) do
					rK[# rK + 1] = tInfo
				end;
				table.sort(rK, function(rL, rM)
					return rL["hp"] < rM["hp"]
				end)
				if GetStatus("HEAL_STATUS_全团套盾") then
					for _, tInfo in ipairs(rK) do
						if tInfo["role"] ~= "MAINTANK" and AutoHelp.IsValidEmergency(tInfo) and rI(tInfo) then
							if AutoHelp.TryUseAction(tInfo, "真言术：盾") then
								return true
							end
						end
					end
				end
			end;
			if (not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or InCombatLockdown()) and GetStatus("HEAL_STATUS_无脑恢复") and (GetStatus("HEAL_STATUS_坦克恢复") or GetStatus("HEAL_STATUS_全团恢复")) then
				for oz, tInfo in pairs(HEAL_RAID_TANKS) do
					if AutoHelp.IsValidEmergency(tInfo) and AutoHelp.TryUseAction(tInfo, "恢复") then
						return true
					end
				end;
				local rK = {}
				for oz, tInfo in pairs(HEAL_RAID) do
					rK[# rK + 1] = tInfo
				end;
				table.sort(rK, function(rL, rM)
					return rL["hp"] < rM["hp"]
				end)
				if GetStatus("HEAL_STATUS_全团恢复") then
					for _, tInfo in ipairs(rK) do
						if AutoHelp.IsValidEmergency(tInfo) and AutoHelp.TryUseAction(tInfo, "恢复") then
							return true
						end
					end
				end
			end
		end;
		local function rc(mH, targetInfo)
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
			if InCombatLockdown() and GetStatus("HEAL_STATUS_能量灌注") then
				local lw = jy("能量灌注")
				if lw ~= "无" and lw ~= nil then
					local oz = HEAL_RAID_NAMES[lw]
					if not oz then
						SetConfig("能量灌注", "无")
					else
						local tInfo = HEAL_RAID[oz]
						local oW, oX = UnitPowerType(oz)
						if oX == "MANA" and AutoHelp.TryUseAction(tInfo, "能量灌注") then
							AutoHelp.DebugText = "能量灌注"
							return true
						end
					end
				end
			end;
			if GetStatus("HEAL_STATUS_心灵之火") and AutoHelp.TryUseAction(mH, "心灵之火") then
				AutoHelp.DebugText = "保持心灵之火"
				return true
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_暗影魔") and mH["mp"] <= 0.30 and UnitLevel("target") == - 1 then
				local r5 = AutoHelp.TargetInfo and AutoHelp.TargetInfo["canAttack"]
				local tInfo = AutoHelp.TargetInfo;
				if AutoHelp.TargetInfo and not r5 then
					tInfo = GetTargetsEnemy()
				end;
				if tInfo and tInfo["canAttack"] then
					if AutoHelp.TryUseAction(tInfo, "暗影魔") then
						AutoHelp.DebugText = "暗影魔回蓝"
						return true
					end
				end
			end;
			if not GetStatus("STATUS_治疗模式") then
				return rc(mH, targetInfo)
			else
				return r4(mH, targetInfo)
			end
		end;
		local function rN(p)
			for oz, tInfo in pairs(HEAL_RAID) do
				if AutoHelp.UnitHasBuffByPlayer(oz, p) then
					return true
				end
			end;
			return false
		end;
		function AutoHelp.DoCommonAction(mH)
		end;
		function AutoHelp.DoTeamBuff()
			if not GetStatus("HEAL_STATUS_耐力") and not GetStatus("HEAL_STATUS_精神") and not GetStatus("HEAL_STATUS_暗抗") then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if GetStatus("HEAL_STATUS_耐力") and GetStatus("HEAL_STATUS_强效") and AutoHelp.UnitCanBuff(tInfo["unit"], "坚韧祷言") and AutoHelp.GetItemCount("虔诚蜡烛") > 0 then
					if AutoHelp.TryUseAction(tInfo, "坚韧祷言") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_耐力") and AutoHelp.UnitCanBuff(tInfo["unit"], "真言术：韧") then
					if AutoHelp.TryUseAction(tInfo, "真言术：韧") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_精神") and GetStatus("HEAL_STATUS_强效") and AutoHelp.UnitCanBuff(tInfo["unit"], "精神祷言") and AutoHelp.GetItemCount("虔诚蜡烛") > 0 then
					if AutoHelp.TryUseAction(tInfo, "精神祷言") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_精神") and AutoHelp.UnitCanBuff(tInfo["unit"], "神圣之灵") then
					if AutoHelp.TryUseAction(tInfo, "神圣之灵") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_暗抗") and GetStatus("HEAL_STATUS_强效") and AutoHelp.UnitCanBuff(tInfo["unit"], "暗影防护祷言") and AutoHelp.GetItemCount("虔诚蜡烛") > 0 then
					if AutoHelp.TryUseAction(tInfo, "暗影防护祷言") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_暗抗") and AutoHelp.UnitCanBuff(tInfo["unit"], "暗影防护") then
					if AutoHelp.TryUseAction(tInfo, "暗影防护") then
						return true
					end
				end
			end
		end;
		function AutoHelp.HotTeam(tInfo)
			if not tInfo then
				AutoHelp.Debug("HotTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			if AutoHelp.HasMoveKey("治疗之环") and AutoHelp.TryUseAction(tInfo, "治疗之环") then
				return true
			end;
			if jy("HEALMODE") ~= "神圣牧师" then
				if AutoHelp.HasMoveKey("真言术：盾") and rI(tInfo) and AutoHelp.TryUseAction(tInfo, "真言术：盾") then
					return true
				end
			end;
			if not rN("愈合祷言") and AutoHelp.HasMoveKey("愈合祷言") and AutoHelp.TryUseAction(tInfo, "愈合祷言") then
				return true
			end;
			local jS = jy("HEAL_VALUE_恢复血量") or 80;
			local rO = not GetStatus("HEAL_STATUS_恢复") or GetStatus("HEAL_STATUS_恢复") and mT <= jS / 100;
			if AutoHelp.HasMoveKey("恢复") and rO and AutoHelp.TryUseAction(tInfo, "恢复") then
				return true
			end
		end;
		function AutoHelp.HealTeam(tInfo)
			if not tInfo then
				AutoHelp.Debug("HealTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			if AutoHelp.HasStopMoveKey("治疗之环") and AutoHelp.TryUseAction(tInfo, "治疗之环") then
				return true
			end;
			if jy("HEALMODE") ~= "神圣牧师" then
				if AutoHelp.HasStopMoveKey("真言术：盾") and rI(tInfo) and AutoHelp.TryUseAction(tInfo, "真言术：盾") then
					return true
				end
			end;
			if not rN("愈合祷言") and AutoHelp.HasStopMoveKey("愈合祷言") and AutoHelp.TryUseAction(tInfo, "愈合祷言") then
				return true
			end;
			local jS = jy("HEAL_VALUE_苦修血量") or 60;
			local rO = not GetStatus("HEAL_STATUS_苦修") or GetStatus("HEAL_STATUS_苦修") and mT <= jS / 100;
			if AutoHelp.HasStopMoveKey("苦修") and rO and AutoHelp.TryUseAction(tInfo, "苦修") then
				return true
			end;
			jS = jy("HEAL_VALUE_恢复血量") or 80;
			rO = not GetStatus("HEAL_STATUS_恢复") or GetStatus("HEAL_STATUS_恢复") and mT <= jS / 100;
			if AutoHelp.HasStopMoveKey("恢复") and rO and AutoHelp.TryUseAction(tInfo, "恢复") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("快速治疗") and AutoHelp.TryUseAction(tInfo, "快速治疗") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("强效治疗术") and AutoHelp.TryUseAction(tInfo, "强效治疗术") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("治疗术") and AutoHelp.TryUseAction(tInfo, "治疗术") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("次级治疗术") and AutoHelp.TryUseAction(tInfo, "次级治疗术") then
				return true
			end
		end;
		function AutoHelp.AutoHealTeam(tInfo)
			if AutoHelp.IsMoving then
				return AutoHelp.HotTeam(tInfo)
			else
				return AutoHelp.HealTeam(tInfo)
			end
		end;
		local function rj(tInfo)
			if GetStatus("HEAL_STATUS_DISSICK") and tInfo["hasDisease"] and AutoHelp.DispelDiseaseKey then
				if AutoHelp.DispelDiseaseKey == GetSpellInfo(552) then
					if not AutoHelp.UnitHasBuff(tInfo["unit"], AutoHelp.DispelDiseaseKey) and AutoHelp.TryUseAction(tInfo, AutoHelp.DispelDiseaseKey) then
						return true
					end
				elseif AutoHelp.TryUseAction(tInfo, AutoHelp.DispelDiseaseKey) then
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_DISMAGIC") and tInfo["hasMagic"] and AutoHelp.DispelMagicKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelMagicKey) then
					return true
				end
			end
		end;
		function AutoHelp.DoDispelAction()
			if not GetStatus("HEAL_STATUS_DISSICK") and not GetStatus("HEAL_STATUS_DISMAGIC") then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["hasDebuff"] and AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] then
					if rj(tInfo) then
						AutoHelp.DebugText = "驱散团队"
						return true
					end
				end
			end
		end;
		local function rP(l7)
			local mK = GetSpellCritChance(6)
			local cg = GetSpellBonusDamage(6)
			if not l7 then
				l7 = "target"
			end;
			for i = 1, 255 do
				local _, _, nE, _, _, _, rQ, _, _, ca = UnitDebuff(l7, i)
				if not ca then
					break
				end;
				if ca == 22959 or ca == 17800 then
					mK = mK + 5
				end;
				if ca == 54499 or ca == 30708 then
					mK = mK + 3
				end;
				if ca == 57970 then
					if UnitInParty(rQ) then
						mK = mK + 3
					end
				end
			end;
			local _, _, _, _, _, _, rR = UnitDamage("player")
			local rS = rR;
			local d = 100 * rS * (100 - mK) / 100 + 100 * rS * 2 * mK / 100;
			return d
		end;
		local rT = nil;
		local rU;
		function AutoHelp.DoAttackAction(mH)
			local mT, r7 = mH["hp"], mH["mp"] * 100;
			local ib, iG = AutoHelp.GetRange("target")
			local rV = GetStatus("HEAL_STATUS_AOE") and AutoHelp.getNumberTargets() >= 3 or GetStatus("STATUS_始终AOE")
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local function rW()
				if not AutoHelp.KillJX then
					return false
				end;
				local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
				if not rX and InCombatLockdown() and GetStatus("HEAL_STATUS_镜像蛛网") then
					if FindEnemyUnit("镜像") or FindEnemyUnit("裹体之网") then
						AutoHelp.Debug(">>有镜像或者蛛网裹体需要击杀")
						if AutoHelp.TryUseAction(mH, "选中镜像") then
							return true
						end
					end
				end;
				return false
			end;
			local function rY()
				if not AutoHelp.UnitHasBuff("player", "暗影形态") and AutoHelp.TryUseAction(mH, "暗影形态") then
					return true
				end;
				if rW() then
					return true
				end;
				if rE then
					rE = false
				else
					if AutoHelp.IsCastingSpell(GetSpellInfo(15407)) or AutoHelp.IsCastingSpell(GetSpellInfo(48045)) then
						return false
					end
				end;
				if rV and GetStatus("STATUS_暗影_精神灼烧") and not AutoHelp.IsMoving then
					if AutoHelp.TryUseAction(targetInfo, "精神灼烧") then
						return true
					end
				end;
				if GetStatus("STATUS_暗影_吸血鬼的拥抱") and AutoHelp.TryUseAction(mH, "吸血鬼的拥抱") then
					return true
				end;
				if GetStatus("STATUS_暗影_噬灵疫病") and AutoHelp.TryUseAction(targetInfo, "噬灵疫病") then
					return true
				end;
				local rZ = AutoHelp.IsCastingSpell("吸血鬼之触")
				if GetStatus("STATUS_暗影_吸血鬼之触") and not rZ and AutoHelp.TryUseAction(targetInfo, "吸血鬼之触") then
					return true
				end;
				if GetStatus("STATUS_暗影_暗言术：痛") then
					local eI = GetTalentSpent(15257)
					if eI > 0 then
						local lL = AutoHelp.GetUnitBuffNum(mH["unit"], GetSpellInfo(15257))
						if lL >= 5 and AutoHelp.TryUseAction(targetInfo, "暗言术：痛") then
							SetCombatValue(UnitGUID("target"), rP("target"))
							return true
						end
					else
						if AutoHelp.TryUseAction(targetInfo, "暗言术：痛") then
							return true
						end
					end;
					if UnitLevel("target") == - 1 and AutoHelp.UnitHasDebuffByPlayer("target", GetSpellInfo(589)) then
						local r_ = GetCombatNumber(UnitGUID("target"))
						local s0 = rP("target")
						if r_ == 0 then
							SetCombatValue(UnitGUID("target"), s0)
						else
							if r_ ~= 0 and s0 > r_ + 2 then
								if AutoHelp.TryUseAction(targetInfo, "暗言术：痛2") then
									AutoHelp.Debug(">>重补暗言术：痛, 收益增加(" .. floor(r_) .. "=>" .. floor(s0) .. ")")
									SetCombatValue(UnitGUID("target"), s0)
									return true
								end
							end
						end
					end
				end;
				if GetStatus("STATUS_多目标痛") and not MouseoverIsTarget() and UnitCanAttack("player", "mouseover") then
					local s1, s2 = AutoHelp.GetRange("mouseover")
					local s3 = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(589), true)
					local rH = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(34914), true)
					if not AutoHelp.IsMoving and GetStatus("STATUS_暗影_吸血鬼之触") and rH == 0 and not rZ and AutoHelp.TryUseAction(mH, "吸血鬼之触鼠标") then
						return true
					end;
					if GetStatus("STATUS_暗影_暗言术：痛") and s2 <= 36 and s3 == 0 and AutoHelp.TryUseAction(mH, "暗言术：痛鼠标指向") then
						SetCombatValue(UnitGUID("target"), rP("mouseover"))
						return true
					end
				end;
				if not AutoHelp.IsMoving and GetStatus("STATUS_暗影_心灵震爆") and AutoHelp.TryUseAction(targetInfo, "心灵震爆") then
					return true
				end;
				if not AutoHelp.IsMoving and GetStatus("STATUS_暗影_精神鞭笞") and AutoHelp.TryUseAction(targetInfo, "精神鞭笞") then
					return true
				end;
				if GetStatus("STATUS_暗影_暗言术：灭") and AutoHelp.TryUseAction(targetInfo, "暗言术：灭") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("STATUS_暗影_射击") and not IsAutoRepeatSpell("射击") and not AutoHelp.IsMoving and GetInventoryItemLink("player", 18) and AutoHelp.TryUseAction(targetInfo, "射击") then
					return true
				end;
				if InCombatLockdown() and not IsAutoRepeatSpell("射击") and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function rs()
				if rW() then
					return true
				end;
				if rV and GetStatus("STATUS_治疗_精神灼烧") and not AutoHelp.IsMoving then
					if AutoHelp.TryUseAction(targetInfo, "精神灼烧") then
						return true
					end
				end;
				if GetStatus("STATUS_治疗_吸血鬼的拥抱") and AutoHelp.TryUseAction(mH, "吸血鬼的拥抱") then
					return true
				end;
				if GetStatus("STATUS_治疗_噬灵疫病") and AutoHelp.TryUseAction(targetInfo, "噬灵疫病") then
					return true
				end;
				local rZ = AutoHelp.IsCastingSpell("吸血鬼之触")
				if not AutoHelp.IsMoving and GetStatus("STATUS_治疗_吸血鬼之触") and not rZ and AutoHelp.TryUseAction(targetInfo, "吸血鬼之触") then
					return true
				end;
				if GetStatus("STATUS_治疗_暗言术：痛") then
					local eI = GetTalentSpent(15257)
					if eI > 0 then
						local lL = AutoHelp.GetUnitBuffNum(mH["unit"], GetSpellInfo(15257))
						if lL >= 5 and AutoHelp.TryUseAction(targetInfo, "暗言术：痛") then
							return true
						end
					else
						if AutoHelp.TryUseAction(targetInfo, "暗言术：痛") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_治疗_心灵震爆") and AutoHelp.TryUseAction(targetInfo, "心灵震爆") then
					return true
				end;
				if GetStatus("STATUS_治疗_精神鞭笞") and AutoHelp.TryUseAction(targetInfo, "精神鞭笞") then
					return true
				end;
				if GetStatus("STATUS_治疗_暗言术：灭") and AutoHelp.TryUseAction(targetInfo, "暗言术：灭") then
					return true
				end;
				if not AutoHelp.UnitHasBuff("player", "暗影形态") then
					if GetStatus("STATUS_治疗_神圣新星") and AutoHelp.TryUseAction(mH, "神圣新星") then
						return true
					end;
					if GetStatus("STATUS_治疗_苦修") and AutoHelp.TryUseAction(targetInfo, "苦修") then
						return true
					end;
					if not AutoHelp.IsMoving and GetStatus("STATUS_治疗_神圣之火") and AutoHelp.TryUseAction(targetInfo, "神圣之火") then
						return true
					end;
					if not AutoHelp.IsMoving and GetStatus("STATUS_治疗_惩击") and AutoHelp.TryUseAction(targetInfo, "惩击") then
						return true
					end
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("STATUS_治疗_射击") and not IsAutoRepeatSpell("射击") and not AutoHelp.IsMoving and GetInventoryItemLink("player", 18) and AutoHelp.TryUseAction(targetInfo, "射击") then
					return true
				end;
				if InCombatLockdown() and not IsAutoRepeatSpell("射击") and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			if jy("HEALMODE") == "暗影" then
				if rY() then
					return true
				end
			else
				if rs() then
					return true
				end
			end
		end
	end;
	if PlayerIsClass("PRIEST") then
		AutoHelp.ClassConfig = rt
	end
end;
if AutoHelp.isWotlk then
	local function s4()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {
			[1] = GetSpellInfo(5185),
			[2] = GetSpellInfo(8936)
		}
		AutoHelp.RESCURIT_NAME = GetSpellInfo(50769)
		AutoHelp.RESCURIT_KEY = GetSpellInfo(50769)
		AutoHelp.CAN_RESCURIT = true;
		AutoHelp.CAN_HEAL = true;
		AutoHelp.CAN_BUFF = true;
		AutoHelp.CAN_DISPEL = true;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 1;
		AutoHelp.AttackRange = 2;
		AutoHelp.DispelPoisonKey = "驱毒术"
		if not GetSpellInfo("驱毒术") then
			AutoHelp.DispelPoisonKey = GetSpellInfo(8946)
		end;
		AutoHelp.DispelCurseKey = GetSpellInfo(2782)
		AutoHelp.CommingHealWindow = 1.9;
		local function ru(hK, jI)
			if jI then
				if hK ~= "单体" then
					SetConfig("STATUS_单体输出", false)
				end;
				if hK ~= "自动" then
					SetConfig("STATUS_自动输出", false)
				end
			end
		end;
		local function s5()
			if GetStatus("STATUS_单体输出") then
				return "单体"
			end;
			if GetStatus("STATUS_自动输出") then
				return "自动"
			end
		end;
		local s6 = "moonkin"
		local function qO(jI)
			local kH = jy("HEALMODE")
			if mdoe == "野性(熊)" or kH == "平衡(鸟)" or kH == "野性(猫)" then
				return
			end;
			if jI then
				AutoHelp.ShowItem("HEAL_STATUS_主动开怪2")
				AutoHelp.ShowItem("STATUS_目标互动2")
				AutoHelp.ShowItem("STATUS_自动寻怪2")
				AutoHelp.ShowItem("STATUS_自动拾取2")
				AutoHelp.ShowItems("normal")
				AutoHelp.ResizePanel()
			else
				AutoHelp.HideItem("HEAL_STATUS_主动开怪2")
				AutoHelp.HideItem("STATUS_目标互动2")
				AutoHelp.HideItem("STATUS_自动寻怪2")
				AutoHelp.HideItem("STATUS_自动拾取2")
				AutoHelp.HideItems("normal")
				AutoHelp.ResizePanel()
			end
		end;
		AutoHelp.LastHealTeamAction = {}
		AutoHelp.LastMoveHealTeamAction = {}
		AutoHelp.STANCE_SPELLS = {}
		local n9 = {
			{
				name = "野性印记",
				spellId = true,
				["target"] = true,
				["auraName"] = "野性赐福"
			},
			{
				name = "野性赐福",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "荆棘术",
				spellId = true,
				["target"] = true
			},
			{
				name = "治疗之触",
				spellId = true,
				["useSP"] = true,
				["healType"] = 1,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "愈合",
				spellId = true,
				["useSP"] = true,
				["healType"] = 2,
				["target"] = true,
				["auraNameCID2"] = true,
				["fastSpell"] = true
			},
			{
				name = "滋养",
				spellId = true,
				["useSP"] = true,
				["healType"] = 1,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "生命绽放",
				spellId = true,
				["healType"] = 3,
				["auraNameCID2"] = true,
				["auraNum"] = 3,
				["auraRT"] = 1.5,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "野性成长",
				spellId = true,
				["healType"] = 3,
				["auraNameCID2"] = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "回春术",
				spellId = true,
				["useSP"] = true,
				["healType"] = 3,
				["auraNameCID2"] = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "愤怒",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "宁静",
				spellId = true
			},
			{
				name = "复生",
				spellId = true,
				["target"] = true
			},
			{
				name = "起死回生",
				spellId = true,
				["comkey"] = true,
				["target"] = true
			},
			{
				name = "激活",
				spellId = true,
				["auraNameCID"] = true,
				["target"] = true
			},
			{
				name = "月火术",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "解除诅咒",
				spellId = true,
				["target"] = true
			},
			{
				name = "消毒术",
				spellId = true,
				["target"] = true
			},
			{
				name = "驱毒术",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "低吼",
				spellId = true,
				["target"] = true
			},
			{
				name = "重殴",
				spellId = true,
				["target"] = true
			},
			{
				name = "猛击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "割伤",
				spellId = true,
				["target"] = true,
				["debuffNameCID"] = true,
				["debuffNum"] = 5,
				["debuffRT"] = 2.1,
				["attack"] = true
			},
			{
				name = "挫志咆哮",
				spellId = true
			},
			{
				name = "挑战咆哮",
				spellId = true
			},
			{
				name = "激怒",
				spellId = true
			},
			{
				name = "狂暴回复",
				spellId = true
			},
			{
				name = "精灵之火",
				spellId = true,
				["target"] = true,
				["debuffNameCID"] = true
			},
			{
				name = "精灵之火（野性）",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "裂伤（熊）",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "裂伤（豹）",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "横扫（熊）",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "野性冲锋 - 熊",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "野性冲锋 - 豹",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "狂暴",
				spellId = true,
				["auraNameCID"] = true,
				["useSP"] = true
			},
			{
				name = "星火术",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "虫群",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "虫群鼠标指向",
				spellId = true,
				["spellName"] = "虫群",
				["macro"] = "/cast [@mouseover,exists,harm]虫群"
			},
			{
				name = "飓风",
				spellId = true,
				["macro"] = "/cast [@cursor,nochanneling:飓风]飓风\n",
				["fastSpell"] = true
			},
			{
				name = "飓风鼠标指向",
				spellId = 48467,
				["macro"] = "/cast [@cursor,nochanneling:飓风]飓风\n",
				["fastSpell"] = true
			},
			{
				name = "飓风鼠标点击",
				spellId = 48467,
				["macro"] = "/cast [nochanneling:飓风]飓风\n",
				["fastSpell"] = true
			},
			{
				name = "台风",
				spellId = true
			},
			{
				name = "星辰坠落",
				spellId = true,
				["sp"] = true
			},
			{
				name = "熊形态",
				spellId = true
			},
			{
				name = "巨熊形态",
				spellId = true
			},
			{
				name = "水栖形态",
				spellId = true
			},
			{
				name = "猎豹形态",
				spellId = true
			},
			{
				name = "枭兽形态",
				spellId = true
			},
			{
				name = "生命之树",
				spellId = true
			},
			{
				name = "飞行形态",
				spellId = true
			},
			{
				name = "迅捷治愈",
				spellId = true,
				["healType"] = 6,
				["target"] = true
			},
			{
				name = "自然迅捷",
				spellId = true
			},
			{
				name = "树皮术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "生存本能",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "撕碎",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "斜掠",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "毁灭",
				spellId = true,
				["target"] = true
			},
			{
				name = "突袭",
				spellId = true,
				["target"] = true
			},
			{
				name = "野蛮咆哮",
				spellId = true
			},
			{
				name = "爪击",
				spellId = true,
				["target"] = true
			},
			{
				name = "凶猛撕咬",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "割碎",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "割裂",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["attack"] = true
			},
			{
				name = "横扫（豹）",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "猛虎之怒",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "大迅捷",
				spellId = true,
				["spellName"] = "自然迅捷",
				["target"] = true,
				["macro"] = "/cast 自然迅捷\n/cast [target=@target]治疗之触\n"
			},
			{
				name = "自然之力",
				spellId = true,
				["spellName"] = "自然之力",
				["macro"] = "/cast [@player]自然之力\n/petdefensive\n/petattack",
				["useSP"] = true
			},
			{
				["name"] = "选中镜像",
				["macro"] = "/targetexact 裹体之网\n/targetexact 镜像\n/cast [exists]月火术\n",
				["spellName"] = "选中镜像",
				["spellTime"] = 1,
				["desc"] = "选中镜像"
			},
			{
				name = "旋风",
				spellId = true,
				["target"] = true
			},
			{
				name = "纠缠根须",
				spellId = true,
				["target"] = true
			},
			{
				name = "自然之握",
				spellId = true
			},
			{
				name = "畏缩",
				spellId = true
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "治疗"
			AutoHelp.ModeDefaultSetting = {
				["STATUS_治疗模式"] = true,
				["HEAL_STATUS_FIRSTDISPAL"] = false,
				["HEAL_STATUS_DISCURSE"] = true,
				["HEAL_STATUS_DISPOSION"] = true,
				["HEAL_STATUS_DISPALSELF"] = true,
				["HEAL_STATUS_DISPALTANK"] = true,
				["HEAL_STATUS_TDISPALGROUP"] = true,
				["HEAL_OVERHEAL_VALUE"] = 98,
				["HEAL_STATUS_AUTOHEAL"] = true,
				["HEAL_AUTO_VALUE"] = 90,
				["HEAL_STATUS_FIRSTTANK"] = true,
				["HEAL_FIRSTTANK_VALUE"] = 60,
				["HEAL_STATUS_AUTOCHOOSE"] = true,
				["HEALKEYS"] = {
					"滋养",
					"野性成长",
					"愈合",
					"回春术",
					"生命绽放",
					"迅捷治愈"
				},
				["MOVEHEALKEYS"] = {
					"野性成长",
					"回春术",
					"迅捷治愈",
					"生命绽放"
				},
				["HEAL_STATUS_ONEHEAL"] = false,
				["OverHealValue"] = 100,
				["OverHealType"] = "OVERHEALNORMAL"
			}
			AutoHelp.HEAL_MODES = {
				["治疗"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_DISPALGROUP"] = true,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_FIRSTHEALSELF"] = true,
					["HEAL_STATUS_自动激活"] = true,
					["HEAL_STATUS_预补回春"] = true,
					["HEAL_STATUS_节能绽放"] = true,
					["HEAL_STATUS_镜像蛛网"] = false,
					["STATUS_自动输出"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569【治疗模式】，本模式追求最大化治疗和相对最小化过量治疗。\124r"
				},
				["无脑回春"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_DISPALGROUP"] = true,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_FIRSTHEALSELF"] = true,
					["HEAL_STATUS_自动激活"] = true,
					["HEAL_STATUS_预补回春"] = true,
					["HEAL_STATUS_坦克回春"] = true,
					["HEAL_STATUS_全团回春"] = true,
					["HEAL_STATUS_节能绽放"] = true,
					["HEAL_STATUS_镜像蛛网"] = false,
					["STATUS_自动输出"] = false,
					["HEALKEYS"] = {
						"野性成长",
						"回春术",
						"生命绽放",
						"迅捷治愈"
					},
					["MOVEHEALKEYS"] = {
						"野性成长",
						"回春术",
						"迅捷治愈",
						"生命绽放"
					},
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569【无脑回春】适合团刷, 优先给掉血队友迅捷治愈/野性成长/回春术, 然后全团预补回春术。\124r"
				},
				["打怪"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = true,
					["HEAL_AUTO_VALUE"] = 50,
					["modetip"] = "\124cffFFF569已设置为【打怪模式】，减少自我加血。\124r"
				},
				["野性(熊)"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_自动激活"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_DISPALSELF"] = false,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["modetip"] = "\124cffFFF569已设置为【野性(熊)】，不进行自我加血。\124r"
				},
				["DPS模式"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_自动激活"] = false,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_DISPALSELF"] = true,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["modetip"] = "\124cffFFF569已设置为【DPS模式】，不进行自我加血。\124r"
				},
				["野性(猫)"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_自动激活"] = false,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_DISPALSELF"] = true,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["modetip"] = "\124cffFFF569已设置为【野性(猫)】，不进行自我加血。\124r"
				},
				["平衡(鸟)"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_自动激活"] = true,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_DISPALSELF"] = true,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["HEAL_STATUS_预补回春"] = false,
					["HEAL_STATUS_节能绽放"] = false,
					["HEAL_STATUS_镜像蛛网"] = true,
					["STATUS_自动输出"] = true,
					["modetip"] = "\124cffFFF569已设置为【平衡(鸟)】，不进行自我加血。\124r"
				},
				["将军英雄"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_AUTOHEAL"] = true,
					["HEAL_AUTO_VALUE"] = 50,
					["HEAL_STATUS_FIRSTTANK"] = true,
					["HEAL_FIRSTTANK_VALUE"] = 70,
					["HEAL_STATUS_FIRSTTARGET"] = false,
					["HEAL_FIRSTPROTECT_VALUE"] = 90,
					["HEAL_STATUS_DISPALSELF"] = false,
					["HEAL_STATUS_DISPALTANK"] = false,
					["HEAL_STATUS_DISPALGROUP"] = false,
					["HEAL_STATUS_FIRSTHEALSELF"] = true,
					["HEAL_STATUS_自动激活"] = false,
					["HEAL_STATUS_预补回春"] = false,
					["HEAL_STATUS_节能绽放"] = false,
					["HEAL_STATUS_镜像蛛网"] = false,
					["HEAL_STATUS_协助坦克"] = false,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569设置为【ULD将军刷坦模式】，只在坦克血量低于70%的时候开始刷血，且只用回春和野性成长给团队刷血，节省蓝量。\124r",
					["HEALKEYS"] = {
						"回春术",
						"野性成长"
					},
					["MOVEHEALKEYS"] = {
						"野性成长",
						"回春术"
					}
				}
			}
			AutoHelp.ModeList = {
				{
					text = "治疗模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00治疗\124r",
					name = "治疗",
					tooltipTitle = "治疗",
					tooltipText = "标准模式使用系统缺省设置进行治疗。"
				},
				{
					text = "\124cff00ff00无脑回春\124r",
					name = "无脑回春",
					tooltipTitle = "无脑回春",
					tooltipText = "依次给全团上回春术治疗方式。"
				},
				{
					text = "将军英雄",
					name = "将军英雄",
					tooltipTitle = "将军英雄",
					tooltipText = "\124cffFFF569设置为【ULD将军英雄模式】，只在坦克血量低于70%的时候开始刷血，且只用回春和野性成长给团队刷血，节省蓝量。\124r"
				},
				{
					text = "输出模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cffFFFFFF野性(熊)\124r",
					name = "野性(熊)",
					tooltipTitle = "野性(熊)",
					tooltipText = "野性(熊)"
				},
				{
					text = "\124cffFFFFFF野性(猫)\124r",
					name = "野性(猫)",
					tooltipTitle = "野性(猫)",
					tooltipText = "以猎豹形态进行攻击"
				},
				{
					text = "\124cffFFFFFF平衡(鸟)\124r",
					name = "平衡(鸟)",
					tooltipTitle = "平衡(鸟)",
					tooltipText = "平衡(鸟)"
				}
			}
			AutoHelp.STAND_HEAL_SPELLS = {
				"滋养",
				"野性成长",
				"愈合",
				"回春术",
				"生命绽放",
				"治疗之触",
				"迅捷治愈"
			}
			if not GetSpellInfo("滋养") then
				table.insert(AutoHelp.ModeDefaultSetting["HEALKEYS"], "治疗之触")
			end;
			AutoHelp.MOVE_HEAL_SPELLS = {
				"回春术",
				"野性成长",
				"生命绽放",
				"迅捷治愈"
			}
			AutoHelp.PANELHEIGHT = 490;
			AutoHelp.PANELWIDTH = 160;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00辅助功能设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTDISPAL",
						["value"] = false,
						["title"] = "优先驱散",
						["tip"] = "优先驱散，驱散将优先加血，目前版本已加入队友有血量低于50%依然先加血，以阻止一直在驱散而不加血的问题。\n\n\124cff00ff00对于频繁产生负面效果时，建议关闭此选项提高治疗量\n\124r",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["mode"] = "healer,moonkin",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey(AutoHelp.DispelPoisonKey) and not AutoHelp.HasActionKey(AutoHelp.DispelCurseKey) then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISCURSE",
						["value"] = true,
						["title"] = "诅",
						["tip"] = "驱散诅咒效果，自动驱散诅咒效果\n\n\124cff00ff00自动使用清洁术驱散目标诅咒效果\124r",
						["point"] = 85,
						["hitRect"] = - 10,
						["nextpos"] = false,
						["mode"] = "healer,moonkin",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey(AutoHelp.DispelCurseKey) then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISSICK",
						["value"] = true,
						["title"] = "毒",
						["tip"] = "驱散中毒效果，自动驱散中毒效果\n\n\124cff00ff00自动使用清洁术驱散目标中毒效果\124r",
						["point"] = 120,
						["hitRect"] = - 10,
						["nextpos"] = false,
						["mode"] = "healer,moonkin",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey(AutoHelp.DispelPoisonKey) then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_野性印记",
						["value"] = true,
						["title"] = "爪子",
						["tip"] = "自动给队友上野性印记/野性赐福",
						["point"] = 5,
						["hitRect"] = - 20,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("野性赐福") and not AutoHelp.HasActionKey("野性印记") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_荆棘术",
						["value"] = false,
						["title"] = "荆棘",
						["tip"] = "给队友上荆棘术",
						["point"] = 55,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("荆棘术") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_野性赐福",
						["value"] = false,
						["title"] = "赐福",
						["tip"] = "给队友上野性赐福（大爪子），不选缺省上小爪子",
						["point"] = 105,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("野性赐福") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动激活",
						["value"] = true,
						["title"] = "激活",
						["tip"] = "战斗中自动给设定目标激活,激活缺省蓝量是30%[设置中设定],如果没有选择队友,则自动给自己激活",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer,moonkin",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("激活") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_自动激活",
						["title"] = "激活目标",
						["tipTitle"] = "自动给队友/自己[激活]",
						["tip"] = "\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动在目标蓝量低于设定值时激活\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer,moonkin",
						["create"] = function(kl)
							local cd = jy("激活目标")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo == nil and jy("激活目标") == "无" then
								AutoHelp.Debug("要设置激活目标请先选择队友！")
								return
							end;
							if tInfo ~= nil then
								local oW, oX = UnitPowerType(tInfo["unit"])
								if oX ~= "MANA" then
									AutoHelp.Debug("无法给[" .. tInfo["className"] .. "]激活:" .. tInfo["name"])
									return
								end;
								SetConfig("激活目标", tInfo["name"])
								AutoHelp.Debug("设置激活目标：" .. tInfo["name"])
							else
								SetConfig("激活目标", "无")
								AutoHelp.Debug("清除激活目标,缺省为自己激活。")
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_滋养血量",
						["value"] = true,
						["title"] = "滋养血量",
						["tip"] = "当治疗目标血量低于设定值，可以使用滋养法术直接治疗，缺省设置60%\n\n如果法术没有选择滋养，此设置无效！",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("滋养") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_滋养血量",
						["hide"] = not AutoHelp.HasActionKey("滋养"),
						["value"] = 60,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_预补回春",
						["value"] = true,
						["title"] = "\124cff00ff00预补回春\124r",
						["tipTitle"] = "预补回春",
						["tip"] = "在战斗中，如果没有需要治疗的队友时，自动给队友补回春，顺序是tank、近战dps、dps、治疗这样的顺序。团本奶德团刷利器。",
						["point"] = 5,
						["width"] = 80,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("回春术") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_坦克回春",
						["value"] = true,
						["title"] = "坦",
						["tip"] = "战斗中，在没有治疗压力的时候，预先给坦克补回春",
						["point"] = 85,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("回春术") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_全团回春",
						["value"] = false,
						["title"] = "团",
						["tip"] = "战斗中，如果治疗空闲中，预先给全团补回春",
						["point"] = 120,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("回春术") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_三花绽放",
						["hitRect"] = - 80,
						["value"] = false,
						["title"] = "\124cff00ff00保持目标三花\124r",
						["tip"] = "保持选定目标队友/当前boss目标/焦点三层生命绽放，一般选择在坦克极限加血时选择. \124cff00ff00选择坦克/设置焦点/选择BOSS会一直给坦克保持三层生命绽放加血\124r",
						["point"] = 5,
						["offset"] = 22,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_节能绽放",
						["value"] = true,
						["title"] = "\124cff00ff00节能绽放\124r",
						["tipTitle"] = "节能绽放",
						["tip"] = "如果出现清晰预兆天赋产生的节能施法，立即对目标使用生命绽放，以换取回蓝",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not GetTalentSpent("清晰预兆") and not AutoHelp.HasActionKey("生命绽放") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动变树",
						["value"] = true,
						["title"] = "生命之树",
						["tip"] = "战斗中开始治疗时,自动变成树人。",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("生命之树") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_主动攻击", false)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING2",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_镜像蛛网",
						["value"] = true,
						["title"] = "镜像",
						["tip"] = "当目进入有镜像或者蛛网的副本时，自动优先打镜像和蛛网裹体",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在输出模式下勾选，建议治疗模式不要选择。",
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_多目标痛",
						["value"] = false,
						["title"] = "多虫",
						["tipTitle"] = "鼠标指向上虫群",
						["tip"] = "鼠标指向非当前敌对目标时自动上虫群。\n\n\124cff00ff00适合多目标提高伤害，比如Xt002鼠标指向火花会自动给火花上虫群，左右手皆可指向目标保持多目标虫群, 如果有T8套装会增加瞬发星火术。\124r",
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "moonkin"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动炸弹",
						["value"] = true,
						["title"] = "炸弹",
						["tipTitle"] = "萨隆邪铁炸弹",
						["tip"] = "在技能中绑定[萨隆邪铁炸弹]/腰带钴质破片炸弹, 小怪使用腰带炸弹, 骷髅级别BOSS才卡CD使用萨隆邪铁炸弹, 请在背包保留足够的炸弹。\n\n\124cff00ff00萨隆邪铁炸弹只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "cat,bear"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["title"] = "\124cffFFF569AOE\124r",
						["tipTitle"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果怪物数量大于等于3个，将自动启动AOE技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["fnc"] = function(jI)
							local kH = jy("HEALMODE")
							if jI then
								if kH == "平衡(鸟)" then
									SetConfig("ATTACK_STATUS_鸟_飓风", true)
								end;
								if kH == "治疗" then
									SetConfig("ATTACK_STATUS_人_飓风", true)
									SetConfig("ATTACK_STATUS_人_台风", true)
								end;
								if kH == "野性(猫)" then
									SetConfig("ATTACK_STATUS_猫_横扫", true)
								end;
								if kH == "野性(熊)" then
									SetConfig("ATTACK_STATUS_熊_横扫", true)
								end
							else
								if kH == "平衡(鸟)" then
									SetConfig("ATTACK_STATUS_鸟_飓风", false)
								end;
								if kH == "治疗" then
									SetConfig("ATTACK_STATUS_人_飓风", false)
									SetConfig("ATTACK_STATUS_人_台风", false)
								end;
								if kH == "野性(猫)" then
									SetConfig("ATTACK_STATUS_猫_横扫", false)
								end;
								if kH == "野性(熊)" then
									SetConfig("ATTACK_STATUS_熊_横扫", false)
								end
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_指向施法",
						["value"] = true,
						["title"] = "指向",
						["tipTitle"] = "鼠标指向施法",
						["tip"] = "自动施放飓风时鼠标指向需要AOE的位置即可。\n\n\124cff00ff00指向位置必须有敌对目标或者坦克.\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "moonkin",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_点击施法", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_点击施法",
						["value"] = false,
						["title"] = "点击",
						["tipTitle"] = "鼠标点击施法",
						["tip"] = "自动施放飓风时, 会出现蓝色位置圈, 需要用鼠标点击目标位置才会继续施放。\n\n\124cff00ff00点击施法会停滞后续自动施法, 只有点击目标位置后, 才能继续运行!\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "moonkin",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_指向施法", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_始终AOE",
						["value"] = false,
						["title"] = "始终AOE",
						["tip"] = "一直使用AOE技能进行攻击,比如在打左右手的时候,无法找背,使用横扫技能攻击。",
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "cat,bear",
						["fnc"] = function(jI)
							if jI then
								SetConfig("ATTACK_STATUS_猫_横扫", true)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_星辰坠落",
						["title"] = "星坠",
						["tipTitle"] = "施放星辰坠落",
						["tip"] = "星辰坠落，范围AOE\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = true,
						["mode"] = "moonkin",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("星辰坠落") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("星辰坠落")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_自然之力",
						["title"] = "树人",
						["tipTitle"] = "施放自然之力（树人）",
						["tip"] = "自然之力（树人）。\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = false,
						["mode"] = "moonkin",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("自然之力") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("自然之力")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_复生",
						["title"] = "战复",
						["tipTitle"] = "战复队友",
						["tip"] = "战复队友，需要选中队友。\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "moonkin",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("复生") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("复生")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_修星",
						["value"] = false,
						["title"] = "修星",
						["tipTitle"] = "奥杜尔修星提示",
						["tip"] = "\124cfff00000暂时不能自动释放技能,请手动释放技能!!!!!\n请务必注意点击坍缩星之前,暂停AutoHelp,否则会自动攻击坍缩星!!!\124r\n\n\n自动选择合适虫群等级修星, 坍缩星出现后, 请挨个选择坍缩星以便自动释放虫群技能(自动选择等级)。\n\n\124cff00ff00自动修星不会自动选择坍缩星, 请在虫群即将结束后重新选择坍缩星自动补虫群, 如需手动修星, 请勿勾选此选项!\124r",
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = false,
						["mode"] = "moonkin",
						["fnc"] = function(kl)
							AutoHelp.XiuXingHelp()
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_主动攻击",
						["value"] = true,
						["hitRect"] = - 40,
						["title"] = "\124cff00ff00启动攻击\124r",
						["tip"] = "如果团队血量不需要治疗时,有敌方目标且在战斗就开始攻击模式",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							qO(hK)
							if hK then
								SetConfig("STATUS_自动变树", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主动开怪2",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cfff00000主动开怪\124r",
						["tip"] = "选择此项，非战斗中可以主动攻击选中的敌对目标，不选择此项，即使有主动攻击，也不会进入战斗状态（攻击敌对目标）\124r",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if mdoe ~= "野性(熊)" and kH ~= "平衡(鸟)" and kH ~= "野性(猫)" then
								SetConfig("HEAL_STATUS_主动开怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_目标互动2",
						["value"] = false,
						["hitRect"] = - 30,
						["title"] = "\124cffFFF569互动\124r",
						["tip"] = "自动与目标互动，比如距离过远自动靠近目标，并攻击\n不选择目标互动，必须手动移动到攻击位置，才开始自动攻击",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if mdoe ~= "野性(熊)" and kH ~= "平衡(鸟)" and kH ~= "野性(猫)" then
								SetConfig("STATUS_目标互动", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动寻怪2",
						["value"] = false,
						["title"] = "\124cffFFF569寻怪\124r",
						["tip"] = "自动升级使用，站在某个地方，自动寻找怪物攻击",
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if mdoe ~= "野性(熊)" and kH ~= "平衡(鸟)" and kH ~= "野性(猫)" then
								SetConfig("STATUS_自动寻怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动拾取2",
						["value"] = false,
						["title"] = "\124cffFFF569拾取\124r",
						["tip"] = "自动升级使用，杀死怪物后自动拾取",
						["point"] = 105,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if mdoe ~= "野性(熊)" and kH ~= "平衡(鸟)" and kH ~= "野性(猫)" then
								SetConfig("STATUS_自动拾取", hK)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING_NORMAL",
						["value"] = "\124cff00ff00技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "normal"
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_激活值",
						["value"] = true,
						["title"] = "激活蓝量",
						["tip"] = "战斗中蓝量低于设定值时，激活设定队友或自己",
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("激活") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_激活值",
						["value"] = 30,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("激活") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTHEALSELF",
						["value"] = true,
						["title"] = "优先自疗",
						["tip"] = "当自己血量低于设定值，优先治疗自己，缺省设置50%",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_FIRSTHEALSELF",
						["value"] = 50,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_树皮术",
						["hide"] = not AutoHelp.HasActionKey("树皮术"),
						["value"] = true,
						["title"] = "自动树皮",
						["tip"] = "当自己血量低于设定值，自动使用减伤技能:树皮术",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_树皮术",
						["hide"] = not AutoHelp.HasActionKey("树皮术"),
						["value"] = 35,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_生存本能",
						["hide"] = not AutoHelp.HasActionKey("生存本能"),
						["value"] = true,
						["title"] = "生存本能",
						["tip"] = "当自己血量低于设定值，自动使用减伤技能:生存本能.",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_生存本能",
						["hide"] = not AutoHelp.HasActionKey("生存本能"),
						["value"] = 30,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_团队通告",
						["value"] = false,
						["title"] = "团队通告战复",
						["tip"] = "在战斗中，复活队友后，自动在团队或者小队通告。",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("复生") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_饰品爆发",
						["value"] = true,
						["title"] = "饰品爆发",
						["tip"] = "当团队总血量低于设定值时，自动开启饰品、工程手套等爆发进行加血，缺省设置70%。\n\n\124cff00ff00如果有工程手套、主动饰品等，会根据设定团队血量自动开启。如果需要自己控制饰品及工程手套开启，可自己做宏 \n\n/use 13\n/use 14\n/use 10\n/use 种族天赋\124r",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_饰品爆发值",
						["value"] = 70,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					}
				}
			}
			local qQ = {
				{
					{
						"人_精灵之火",
						"精灵之火",
						true,
						"精火",
						"normal"
					},
					{
						"人_月火术",
						"月火术",
						true,
						"月火",
						"normal"
					},
					{
						"人_愤怒",
						"愤怒",
						true,
						"愤怒",
						"normal"
					},
					{
						"人_星火术",
						"星火术",
						true,
						"星火",
						"normal"
					},
					{
						"人_虫群",
						"虫群",
						true,
						"虫群",
						"normal"
					},
					{
						"人_飓风",
						"飓风",
						false,
						"飓风",
						"normal"
					},
					{
						"人_台风",
						"台风",
						false,
						"台风",
						"normal"
					},
					{
						"人_星辰坠落",
						"星辰坠落",
						true,
						"星落",
						"normal"
					},
					{
						"人_自然之力",
						"自然之力",
						true,
						"树人",
						"normal"
					}
				},
				{
					{
						"熊_自动变形",
						"巨熊形态",
						true,
						"变熊",
						"bear"
					},
					{
						"熊_精灵之火",
						"精灵之火（野性）",
						true,
						"精火",
						"bear"
					},
					{
						"熊_冲锋",
						"野性冲锋 - 熊",
						true,
						"冲锋",
						"bear"
					},
					{
						"熊_挫志咆哮",
						"挫志咆哮",
						true,
						"挫志",
						"bear"
					},
					{
						"熊_割伤",
						"割伤",
						true,
						"割伤",
						"bear"
					},
					{
						"熊_裂伤",
						"裂伤（熊）",
						true,
						"裂伤",
						"bear"
					},
					{
						"熊_横扫",
						"横扫（熊）",
						true,
						"横扫",
						"bear"
					},
					{
						"熊_重殴",
						"重殴",
						true,
						"重殴",
						"bear"
					},
					{
						"熊_狂暴",
						"狂暴",
						true,
						"狂暴",
						"bear"
					}
				},
				{
					{
						"猫_自动变形",
						"猎豹形态",
						true,
						"变猫",
						"cat"
					},
					{
						"猫_精灵之火",
						"精灵之火（野性）",
						true,
						"精火",
						"cat"
					},
					{
						"猫_冲锋",
						"野性冲锋 - 豹",
						true,
						"冲锋",
						"cat"
					},
					{
						"猫_野蛮咆哮",
						"野蛮咆哮",
						true,
						"咆哮",
						"cat"
					},
					{
						"猫_猛虎之怒",
						"猛虎之怒",
						true,
						"猛虎",
						"cat"
					},
					{
						"猫_狂暴",
						"狂暴",
						true,
						"狂暴",
						"cat"
					},
					{
						"猫_裂伤",
						"裂伤（豹）",
						true,
						"裂伤",
						"cat"
					},
					{
						"猫_撕碎",
						"撕碎",
						true,
						"撕碎",
						"cat"
					},
					{
						"猫_斜掠",
						"斜掠",
						true,
						"斜掠",
						"cat"
					},
					{
						"猫_割裂",
						"割裂",
						true,
						"割裂",
						"cat"
					},
					{
						"猫_凶猛撕咬",
						"凶猛撕咬",
						false,
						"撕咬",
						"cat"
					},
					{
						"猫_横扫",
						"横扫（豹）",
						false,
						"横扫",
						"cat"
					}
				},
				{
					{
						"鸟_精灵之火",
						"精灵之火",
						true,
						"精火",
						"moonkin"
					},
					{
						"鸟_月火术",
						"月火术",
						true,
						"月火",
						"moonkin"
					},
					{
						"鸟_愤怒",
						"愤怒",
						true,
						"愤怒",
						"moonkin"
					},
					{
						"鸟_星火术",
						"星火术",
						true,
						"星火",
						"moonkin"
					},
					{
						"鸟_虫群",
						"虫群",
						true,
						"虫群",
						"moonkin"
					},
					{
						"鸟_星辰坠落",
						"星辰坠落",
						true,
						"星落",
						"moonkin"
					},
					{
						"鸟_飓风",
						"飓风",
						false,
						"飓风",
						"moonkin"
					},
					{
						"鸟_台风",
						"台风",
						false,
						"台风",
						"moonkin"
					},
					{
						"鸟_自然之力",
						"自然之力",
						true,
						"树人",
						"moonkin"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local o1 = # AutoHelp.PANEL_CONFIG["healer"]
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 3 == 1 then
							point = 5;
							kf = true
						elseif jS % 3 == 2 then
							point = 55;
							kf = false
						else
							point = 105;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "ATTACK_STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tipTitle"] = qS[2],
							["tip"] = qS[2],
							["point"] = point,
							["nextpos"] = kf,
							["stance"] = qS[5],
							["mode"] = qS[5]
						}
						if qS[6] then
							eS["tip"] = qS[6]
						end;
						if jS == 1 then
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], o1 + jS, eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			local mX = "healer"
			if kH == "野性(熊)" then
				mX = "bear"
				AutoHelp.NAMEPLATES_MAXDISTANCE = 12;
				AutoHelp.AttackType = 1;
				AutoHelp.AttackRange = 2;
				SetConfig("HEAL_STATUS_快速施法", false)
				AutoHelp.CAN_HEAL = false;
				AutoHelp.CAN_BUFF = true;
				AutoHelp.CAN_DISPEL = false
			elseif kH == "野性(猫)" then
				mX = "cat"
				AutoHelp.NAMEPLATES_MAXDISTANCE = 12;
				AutoHelp.AttackType = 1;
				AutoHelp.AttackRange = 2;
				SetConfig("HEAL_STATUS_快速施法", false)
				AutoHelp.CAN_HEAL = false;
				AutoHelp.CAN_BUFF = true;
				AutoHelp.CAN_DISPEL = false
			elseif kH == "平衡(鸟)" then
				mX = "moonkin"
				AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
				AutoHelp.AttackType = 2;
				AutoHelp.AttackRange = 30;
				SetConfig("HEAL_STATUS_快速施法", true)
				AutoHelp.CAN_HEAL = false;
				AutoHelp.CAN_BUFF = true;
				AutoHelp.CAN_DISPEL = true
			else
				mX = "healer"
				AutoHelp.NAMEPLATES_MAXDISTANCE = 30;
				AutoHelp.AttackType = 2;
				AutoHelp.AttackRange = 30;
				SetConfig("HEAL_STATUS_快速施法", true)
			end;
			if mX == "bear" or mX == "cat" or mX == "moonkin" then
			else
			end;
			local qT = not (mX == "bear" or mX == "cat" or mX == "moonkin")
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, mX) or qT and (Contains(bn.mode, "healer") or Contains(bn.mode, "normal")) or not qT and Contains(bn.mode, "attack") then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			if qT then
				qO(GetStatus("STATUS_主动攻击"))
			end;
			AutoHelp.ResizePanel()
		end;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_HEALBOSSTARGET") then
				return
			end;
			local tInfo;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 55593 then
				AutoHelp.Debug(GetSpellInfo(55593) .. "，停止治疗16秒...")
				AutoHelp.SetStopHealAction(16, GetSpellInfo(55593) .. "，停止治疗")
			end;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 27808 then
				tInfo = GetRaidUnit(qV.destName)
				if tInfo and tInfo["unit"] ~= "player" then
					AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"])
					if AutoHelp.TryUseAction(tInfo, "回春术") then
						return true
					end;
					if AutoHelp.TryUseAction(tInfo, "愈合") then
						return true
					end;
					if AutoHelp.TryUseAction(tInfo, "野性成长") then
						return true
					end
				end
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.SpellCastSuccess(fq, ca, cx, fu, qX, qY)
			if cx == "复生" then
				if GetStatus("HEAL_STATUS_团队通告") then
					if fu then
						AutoHelp.SendChatMsg(">>>" .. (fq or "") .. "已释放【" .. (cx or "") .. "】=>" .. (fu or "") .. "<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
					else
						AutoHelp.SendChatMsg(">>>" .. (fq or "") .. "已释放【" .. (cx or "") .. "】<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
					end
				end
			end
		end;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.HasActionKey("宁静") then
				local pj = FindOrCreateMacro("AH宁静", nil, "#showtooltips 宁静\n/stopcasting\n/ahcast 宁静\n")
			end;
			if AutoHelp.HasActionKey("复生") then
				local pj = FindOrCreateMacro("AH复生", nil, "#showtooltips 复生\n/stopcasting\n/ahcast 复生\n")
			end;
			if AutoHelp.HasActionKey("飓风") then
				local pj = FindOrCreateMacro("AH飓风", nil, "#showtooltips 飓风\n/stopcasting\n/ahcast 飓风\n", 109)
			end;
			if AutoHelp.HasActionKey("台风") then
				local pj = FindOrCreateMacro("AH台风", nil, "#showtooltips 台风\n/stopcasting\n/ahcast 台风\n", 110)
			end;
			if AutoHelp.HasActionKey("星辰坠落") then
				local pj = FindOrCreateMacro("AH星辰坠落", nil, "#showtooltips 星辰坠落\n/stopcasting\n/ahcast 星辰坠落\n")
			end;
			if AutoHelp.HasActionKey("自然之力") then
				local pj = FindOrCreateMacro("AH自然之力", nil, "#showtooltips 自然之力\n/stopcasting\n/ahcast 自然之力\n")
			end;
			if AutoHelp.HasActionKey("复生") then
				local pj = FindOrCreateMacro("AH复生", nil, "#showtooltips 复生\n/stopcasting\n/ahcast 复生\n", 49)
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52)
			AutoHelp.Debug("功能性宏已经被创建, 请按照需要将这些宏拖到合适的按钮位置!")
			FindOrCreateMacro("治疗模式", nil, "#showtooltips 治疗之触\n/run AutoHelp.SetMode(\"治疗\")\n/run AutoHelp.SetHealAll(true,90)\n/run AutoHelp.SetHealTank(true, 60)\n/run AutoHelp.SetHealTarget(false, 90)\n")
			FindOrCreateMacro("回春模式", nil, "#showtooltips 回春术\n/run AutoHelp.SetMode(\"无脑回春\")\n/run AutoHelp.SetHealAll(true,90)\n/run AutoHelp.SetHealTank(true, 60)\n/run AutoHelp.SetHealTarget(false, 90)\n")
		end;
		function AutoHelp.AddNextCastAction(qZ)
			for al, p in ipairs(qZ) do
				if p == "复生" and AutoHelp.IsSpellCooldown("复生") then
					if not UnitIsDead("target") then
						AutoHelp.Debug("目标未死亡，不能战复！")
						return false
					end;
					if HEAL_RAID_NAMES[UnitName("target")] == "player" then
						AutoHelp.Debug("不能战复自己，请选择战复队友！")
						return false
					end;
					if not UnitExists("target") or not HEAL_RAID_NAMES[UnitName("target")] then
						AutoHelp.Debug("请选择队友/团队目标后使用战复【复生】！")
						return false
					end
				end
			end;
			return true
		end;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("激活目标", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_BUTTON_自动激活"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			AutoHelp.RegisterKeyCallback("HEAL_STATUS_ZHANFANGUNIT", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_ZHANFANGUNIT"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			local q_ = {
				"熊形态",
				"巨熊形态",
				"水栖形态",
				"猎豹形态",
				"旅行形态",
				"生命之树",
				"飞行形态"
			}
			for _, cd in pairs(q_) do
				if AutoHelp.HasActionKey(cd) then
					AutoHelp.STANCE_SPELLS[# AutoHelp.STANCE_SPELLS + 1] = cd
				end
			end;
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
		end;
		function AutoHelp.CanMoveSpell(tInfo, p)
			return (p == "治疗之触" or p == "愈合" or p == "滋养") and AutoHelp.UnitHasBuff("player", "自然迅捷")
		end;
		local function s7(tInfo)
			if AutoHelp.CanUseAction(HEAL_RAID["player"], "自然迅捷") and AutoHelp.CanUseAction(tInfo, "治疗之触") and AutoHelp.TryUseAction(HEAL_RAID["player"], "大迅捷") then
				return true
			end
		end;
		local function r4(mH, targetInfo)
			local r5 = targetInfo and targetInfo["canAttack"]
			local r6 = not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or UnitAffectingCombat("player") or UnitAffectingCombat("target")
			local mT, r7 = mH["hp"], mH["mp"]
			local oW, oX = UnitPowerType("player")
			local r8 = mH["groupNo"]
			local r9 = AutoHelp.IsDrinking() and r7 < 0.90 or AutoHelp.IsEating() and mT < 0.9;
			if GetStatus("ONLYHEALTARGET") and r6 then
				local tInfo = GetTargetOrEnmysTarget()
				if tInfo and IsValidEmergency(tInfo) and not tInfo["dead"] then
				end
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_FIRSTHEALSELF") and mT <= GetStatusNumber("HEAL_VALUE_FIRSTHEALSELF") / 100 then
				if AutoHelp.TryUseAction(mH, "树皮术") then
					AutoHelp.DebugText = "自我危机处理：树皮术"
					return true
				end;
				if s7(mH) then
					AutoHelp.DebugText = "自我危机处理：大迅捷"
					return true
				end;
				if AutoHelp.AutoHealTeam(mH) then
					AutoHelp.DebugText = "自我危机处理：加血"
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_饰品爆发") and AutoHelp.RaidHealthPct <= (GetStatusNumber("HEAL_VALUE_饰品爆发值") or 60) and AutoHelp.CanUseSP() > 0 then
				if AutoHelp.TryUseAction(mH, "饰品爆发") then
					return true
				end
			end;
			if (not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or InCombatLockdown()) and GetStatus("HEAL_STATUS_三花绽放") then
				local tInfo = GetTargetOrEnmysTarget()
				if not tInfo or not AutoHelp.IsValidEmergency(tInfo) then
					local d2 = FindBossTargets()
					if # d2 > 0 then
						tInfo = GetRaidUnit(d2[1])
					end
				end;
				if tInfo and AutoHelp.IsValidEmergency(tInfo) then
					local jS = AutoHelp.GetUnitBuffNum(tInfo["unit"], "生命绽放")
					if (jS == 3 or jS < 3 and tInfo["hp"] >= 0.7) and AutoHelp.TryUseAction(tInfo, "生命绽放") then
						AutoHelp.DebugText = "保持三层生命绽放"
						return true
					end
				end
			end
		end;
		local function rc(mH, targetInfo)
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
			if InCombatLockdown() and GetStatus("HEAL_STATUS_自动激活") then
				local s8 = jy("激活目标")
				local s9;
				if s8 == nil or s8 == "无" then
					s9 = "player"
				else
					s9 = HEAL_RAID_NAMES[s8]
				end;
				if s9 then
					local tInfo = HEAL_RAID[s9]
					local oW, oX = UnitPowerType(s9)
					local jp = GetStatus("HEAL_STATUS_激活值") and (GetStatusNumber("HEAL_VALUE_激活值") / 100 or 0.3) or 0.3;
					if oX == "MANA" and tInfo["mp"] <= jp then
						if AutoHelp.TryUseAction(tInfo, "激活") then
							AutoHelp.DebugText = "自动激活"
							return true
						end
					end
				end
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_树皮术") and mH["hp"] <= (GetStatusNumber("HEAL_VALUE_树皮术") / 100 or 0.35) then
				if AutoHelp.TryUseAction(mH, "树皮术") then
					return true
				end
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_生存本能") and mH["hp"] <= (GetStatusNumber("HEAL_VALUE_生存本能") / 100 or 0.3) then
				if AutoHelp.TryUseAction(mH, "生存本能") then
					return true
				end
			end;
			if not GetStatus("STATUS_治疗模式") then
				return rc(mH, targetInfo)
			else
				if InCombatLockdown() and GetStatus("STATUS_自动变树") and not AutoHelp.UnitHasBuff("player", 33891) and AutoHelp.HasActionKey("生命之树") then
					if AutoHelp.TryUseAction(mH, "生命之树") then
						return true
					end
				end;
				return r4(mH, targetInfo)
			end
		end;
		function AutoHelp.DoCommonAction(mH)
			if not GetStatus("STATUS_治疗模式") then
			else
				local sa = GetSpellCooldownTime("野性成长")
				if InCombatLockdown() and sa == 0 and GetStatus("HEAL_STATUS_预补回春") and (AutoHelp.HasMoveKey("野性成长") or AutoHelp.HasStopMoveKey("野性成长")) then
					local tInfo = GetTargetOrEnmysTarget()
					if not tInfo or not AutoHelp.IsValidEmergency(tInfo) then
						local d2 = FindBossTargets()
						if # d2 > 0 then
							tInfo = GetRaidUnit(d2[1])
						end
					end;
					if tInfo and AutoHelp.IsValidEmergency(tInfo) then
						if AutoHelp.TryUseAction(tInfo, "野性成长") then
							return true
						end
					end
				end;
				if (not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or InCombatLockdown()) and GetStatus("HEAL_STATUS_预补回春") then
					local sb, sc, sd, rg;
					for oz, tInfo in pairs(HEAL_RAID) do
						if AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] and AutoHelp.CanUseAction(tInfo, "回春术") then
							if tInfo["role"] == "MAINTANK" then
								sb = tInfo;
								break
							end;
							if tInfo["class"] == "WARRIOR" or tInfo["class"] == "ROGUE" or tInfo["class"] == "SHAMAN" or tInfo["class"] == "DEATHKNIGHT" then
								sc = tInfo
							end;
							if tInfo["class"] == "HUNTER" or tInfo["class"] == "MAGE" or tInfo["class"] == "WARLOCK" or tInfo["class"] == "DRUID" then
								sd = tInfo
							end;
							rg = tInfo
						end
					end;
					if GetStatus("HEAL_STATUS_坦克回春") then
						if sb and AutoHelp.TryUseAction(sb, "回春术") then
							return true
						end
					end;
					if GetStatus("HEAL_STATUS_全团回春") then
						if sb and AutoHelp.TryUseAction(sb, "回春术") then
							return true
						end;
						if sc and AutoHelp.TryUseAction(sc, "回春术") then
							return true
						end;
						if sd and AutoHelp.TryUseAction(sd, "回春术") then
							return true
						end;
						if rg and AutoHelp.TryUseAction(rg, "回春术") then
							return true
						end
					end
				end
			end
		end;
		function AutoHelp.DoTeamBuff()
			if not GetStatus("HEAL_STATUS_野性印记") and not GetStatus("HEAL_STATUS_荆棘术") and not GetStatus("HEAL_STATUS_野性赐福") then
				return false
			end;
			if InCombatLockdown() then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if GetStatus("HEAL_STATUS_野性赐福") and AutoHelp.UnitCanBuff(tInfo["unit"], "野性赐福") and AutoHelp.GetBuffRemainTime(tInfo["unit"], "野性赐福") == 0 then
					if AutoHelp.TryUseAction(tInfo, "野性赐福") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_野性印记") and AutoHelp.UnitCanBuff(tInfo["unit"], "野性印记") and AutoHelp.GetBuffRemainTime(tInfo["unit"], "野性印记") == 0 then
					if AutoHelp.TryUseAction(tInfo, "野性印记") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_荆棘术") and AutoHelp.UnitCanBuff(tInfo["unit"], "荆棘术") and AutoHelp.GetBuffRemainTime(tInfo["unit"], "荆棘术") == 0 then
					if AutoHelp.TryUseAction(tInfo, "荆棘术") then
						return true
					end
				end
			end
		end;
		function AutoHelp.HotTeam(tInfo)
			if not tInfo then
				AutoHelp.Debug("HotTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			if InCombatLockdown() and mT <= 0.35 and s7(tInfo) then
				AutoHelp.DebugText = "危机处理：自然迅捷"
				return true
			end;
			if GetStatus("HEAL_STATUS_节能绽放") and AutoHelp.UnitHasBuff("player", "节能施法") then
				if AutoHelp.TryUseAction(tInfo, "生命绽放") then
					return true
				end
			end;
			if AutoHelp.HasMoveKey("迅捷治愈") and (AutoHelp.UnitHasBuff(tInfo["unit"], "回春术") or AutoHelp.UnitHasBuff(tInfo["unit"], "愈合")) and AutoHelp.TryUseAction(tInfo, "迅捷治愈") then
				return true
			end;
			if AutoHelp.HasMoveKey("野性成长") and AutoHelp.TryUseAction(tInfo, "野性成长") then
				return true
			end;
			if AutoHelp.HasMoveKey("回春术") and AutoHelp.TryUseAction(tInfo, "回春术") then
				return true
			end;
			if AutoHelp.HasMoveKey("生命绽放") and AutoHelp.TryUseAction(tInfo, "生命绽放") then
				return true
			end
		end;
		function AutoHelp.HealTeam(tInfo)
			if not tInfo then
				AutoHelp.Debug("HealTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			if InCombatLockdown() and mT <= 0.35 and s7(tInfo) then
				AutoHelp.DebugText = "危机处理：自然迅捷"
				return true
			end;
			if GetStatus("HEAL_STATUS_节能绽放") and AutoHelp.UnitHasBuff("player", "节能施法") then
				if AutoHelp.TryUseAction(tInfo, "生命绽放") then
					return true
				end
			end;
			if AutoHelp.HasStopMoveKey("迅捷治愈") and (AutoHelp.UnitHasBuff(tInfo["unit"], "回春术") or AutoHelp.UnitHasBuff(tInfo["unit"], "愈合")) and AutoHelp.TryUseAction(tInfo, "迅捷治愈") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("野性成长") and AutoHelp.TryUseAction(tInfo, "野性成长") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("回春术") and AutoHelp.TryUseAction(tInfo, "回春术") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("愈合") and AutoHelp.TryUseAction(tInfo, "愈合") then
				return true
			end;
			local jp = (GetStatus("STATUS_滋养血量") and GetStatusNumber("VALUE_滋养血量") or 60) / 100;
			if AutoHelp.HasStopMoveKey("滋养") and mT <= jp and AutoHelp.TryUseAction(tInfo, "滋养") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("治疗之触") and AutoHelp.TryUseAction(tInfo, "治疗之触") then
				return true
			end
		end;
		function AutoHelp.AutoHealTeam(tInfo)
			if AutoHelp.IsMoving then
				return AutoHelp.HotTeam(tInfo)
			else
				return AutoHelp.HealTeam(tInfo)
			end
		end;
		local function rj(tInfo)
			if GetStatus("HEAL_STATUS_DISPOSION") and tInfo["hasPoison"] and AutoHelp.DispelPoisonKey then
				if AutoHelp.DispelPoisonKey == "驱毒术" then
					if not AutoHelp.UnitHasBuff(tInfo["unit"], AutoHelp.DispelPoisonKey) and AutoHelp.TryUseAction(tInfo, AutoHelp.DispelPoisonKey) then
						return true
					end
				elseif AutoHelp.TryUseAction(tInfo, AutoHelp.DispelPoisonKey) then
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_DISCURSE") and tInfo["hasCurse"] and AutoHelp.DispelCurseKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelCurseKey) then
					return true
				end
			end
		end;
		function AutoHelp.DoDispelAction()
			local se = jy("HEALMODE")
			if se == "野性(熊)" or se == "野性(猫)" then
				return false
			end;
			if not GetStatus("HEAL_STATUS_DISPOSION") and not GetStatus("HEAL_STATUS_DISCURSE") then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["hasDebuff"] and AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] then
					if tInfo["role"] == "MAINTANK" and rj(tInfo) then
						AutoHelp.DebugText = "驱散坦克"
						return true
					end;
					if tInfo["unit"] == "player" and rj(tInfo) then
						AutoHelp.DebugText = "驱散自己"
						return true
					end;
					if rj(tInfo) then
						AutoHelp.DebugText = "驱散团队"
						return true
					end
				end
			end
		end;
		local sf = 0;
		local sg = 0;
		function AutoHelp.Player_Regen_Enabled()
			sf = 0;
			sg = 0
		end;
		function AutoHelp.Player_Regen_Disabled()
		end;
		local sh = false;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, r7 = mH["hp"], mH["mp"] * 100;
			local oW, oX = UnitPowerType("player")
			local si = UnitPower("player")
			local r5 = targetInfo and targetInfo["canAttack"]
			local rm = targetInfo and targetInfo["hp"] <= 0.2;
			local sj = AutoHelp.castinfo.nextSwing;
			local sk = GetShapeshiftForm()
			local kH = jy("HEALMODE")
			local ib, iG = AutoHelp.GetRange("target")
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local function rW()
				if not AutoHelp.KillJX then
					return false
				end;
				local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
				if not rX and InCombatLockdown() and (kH ~= "治疗" and GetStatus("HEAL_STATUS_镜像蛛网") or kH == "治疗" and GetStatus("HEAL_STATUS_镜像蛛网2")) then
					if FindEnemyUnit("镜像") or FindEnemyUnit("裹体之网") then
						AutoHelp.Debug(">>有镜像或者蛛网裹体需要击杀")
						if AutoHelp.TryUseAction(mH, "选中镜像") then
							return true
						end
					end
				end;
				return false
			end;
			local function sl()
				local sm = AutoHelp.UnitHasBuff("player", "月蚀")
				local sn = AutoHelp.UnitHasBuff("player", "日蚀")
				local sf, sg = GetCombatValue("MoonStatus") or 0, GetCombatValue("SunStatus") or 0;
				if sk ~= 5 and AutoHelp.TryUseAction(mH, "枭兽形态") then
					return true
				end;
				if rW() then
					return true
				end;
				if GetStatus("STATUS_点击施法") and SpellIsTargeting() then
					return false
				end;
				if GetStatus("ATTACK_STATUS_鸟_精灵之火") and AutoHelp.TryUseAction(targetInfo, "精灵之火") then
					return true
				end;
				if rn then
					if GetStatus("ATTACK_STATUS_鸟_自然之力") and AutoHelp.TryUseAction(mH, "自然之力") then
						return true
					end
				end;
				if GetStatus("ATTACK_STATUS_鸟_星辰坠落") and rn and AutoHelp.TryUseAction(mH, "星辰坠落") then
					return true
				end;
				if GetStatus("HEAL_STATUS_AOE") then
					local so = MouseoverIsTank() or MouseoverCanAttack()
					local sq = AutoHelp.getNumberTargets()
					local sr = sq >= 3 and so;
					if GetStatus("STATUS_指向施法") and sr then
						if GetStatus("ATTACK_STATUS_鸟_飓风") and AutoHelp.TryUseAction(mH, "飓风鼠标指向") then
							return true
						end
					end;
					if GetStatus("STATUS_点击施法") and sq >= 3 then
						if GetStatus("ATTACK_STATUS_鸟_飓风") and AutoHelp.TryUseAction(mH, "飓风鼠标点击") then
							return true
						end
					end
				end;
				if GetStatus("ATTACK_STATUS_鸟_星火术") and AutoHelp.UnitHasBuff("player", 64823) and AutoHelp.TryUseAction(targetInfo, "星火术") then
					AutoHelp.Debug(">>T8四件套特效：瞬发星火术！")
					return true
				end;
				if GetStatus("ATTACK_STATUS_鸟_虫群") and AutoHelp.TryUseAction(targetInfo, "虫群") then
					return true
				end;
				if GetStatus("STATUS_多目标痛") and not MouseoverIsTarget() and UnitCanAttack("player", "mouseover") then
					local s1, s2 = AutoHelp.GetRange("mouseover")
					local ss = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(5570), true)
					if GetStatus("ATTACK_STATUS_鸟_虫群") and s2 <= 36 and ss == 0 and AutoHelp.TryUseAction(mH, "虫群鼠标指向") then
						return true
					end
				end;
				if GetStatus("ATTACK_STATUS_鸟_月火术") and not sm and AutoHelp.TryUseAction(targetInfo, "月火术") then
					return true
				end;
				if sm then
					sf = 1;
					sg = 0;
					SetCombatValue("MoonStatus", sf)
					SetCombatValue("SunStatus", sg)
				end;
				if sn then
					sf = 0;
					sg = 1;
					SetCombatValue("MoonStatus", sf)
					SetCombatValue("SunStatus", sg)
				end;
				if GetStatus("ATTACK_STATUS_鸟_星火术") and sf == 1 and AutoHelp.TryUseAction(targetInfo, "星火术") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_鸟_愤怒") and sg == 1 and AutoHelp.TryUseAction(targetInfo, "愤怒") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_鸟_愤怒") and (sf == 0 and sg == 0 or sg == 1) and AutoHelp.TryUseAction(targetInfo, "愤怒") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_鸟_星火术") and AutoHelp.TryUseAction(targetInfo, "星火术") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_鸟_愤怒") and AutoHelp.TryUseAction(targetInfo, "愤怒") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if InCombatLockdown() and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function st()
				local su = AutoHelp.UnitHasBuff("player", 16870)
				local sv = AutoHelp.UnitHasBuff("player", 50334)
				local sw = 0;
				local function sy(jp)
					return si - sw - jp >= 0 or su
				end;
				if GetStatus("ATTACK_STATUS_熊_自动变形") and sk ~= 1 and AutoHelp.TryUseAction(mH, "巨熊形态") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_熊_精灵之火") then
					if not AutoHelp.UnitHasDebuffByPlayer("target", "精灵之火（野性）") then
						if AutoHelp.TryUseAction(targetInfo, "精灵之火（野性）") then
							return true
						end
					elseif AutoHelp.Glyphs[413895] then
						if not su and AutoHelp.TryUseAction(targetInfo, "精灵之火（野性）") then
							return true
						end
					end
				end;
				if GetStatus("ATTACK_STATUS_熊_冲锋") and sy(5) and AutoHelp.TryUseAction(targetInfo, "野性冲锋 - 熊") then
					return true
				end;
				local sz = AutoHelp.GetDebuffRemainTime("target", "挫志咆哮")
				if GetStatus("ATTACK_STATUS_熊_挫志咆哮") and sy(10) and sz <= 3 and AutoHelp.TryUseAction(mH, "挫志咆哮") then
					return true
				end;
				if sv and GetStatus("ATTACK_STATUS_熊_裂伤") and sy(15) and AutoHelp.TryUseAction(targetInfo, "裂伤（熊）") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_熊_狂暴") and AutoHelp.TryUseAction(mH, "狂暴") then
					return true
				end;
				if GetStatus("STATUS_始终AOE") and GetStatus("ATTACK_STATUS_熊_横扫") and sy(15) then
					if AutoHelp.TryUseAction(targetInfo, "横扫（熊）") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_AOE") and GetStatus("ATTACK_STATUS_熊_横扫") and sy(15) then
					local sq = AutoHelp.getNumberTargets()
					if sq >= 2 then
						if AutoHelp.TryUseAction(targetInfo, "横扫（熊）") then
							return true
						end
					end
				end;
				if GetStatus("ATTACK_STATUS_熊_裂伤") and sy(15) and AutoHelp.TryUseAction(targetInfo, "裂伤（熊）") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_熊_割伤") and sy(13) and AutoHelp.TryUseAction(targetInfo, "割伤") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_熊_重殴") and not sj and sy(55) and AutoHelp.TryUseAction(targetInfo, "重殴") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_熊_横扫") and sy(45) and AutoHelp.TryUseAction(targetInfo, "横扫（熊）") then
					return true
				end;
				if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function sA()
				local sB = GetComboPoints("player", "target")
				local su = AutoHelp.UnitHasBuff("player", 16870)
				local sv = AutoHelp.UnitHasBuff("player", 50334)
				local sC = AutoHelp.UnitHasBuff("player", 50213)
				local sD = AutoHelp.GetDebuffRemainTime("target", "割裂", true)
				local sE = AutoHelp.GetBuffRemainTime("player", 52610, true)
				local sF = AutoHelp.GetDebuffRemainTime("target", 48566, true)
				local sw = 0;
				local sG = false;
				if HEAL_ATTACK_NOTBACK_TIME and GetTime() - HEAL_ATTACK_NOTBACK_TIME < 2 then
					sG = true
				end;
				local function sy(jp)
					if sv then
						jp = jp / 2
					end;
					return si - sw - jp >= 0 or su
				end;
				if GetStatus("ATTACK_STATUS_猫_自动变形") and sk ~= 3 and AutoHelp.TryUseAction(mH, "猎豹形态") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_猫_精灵之火") then
					if not AutoHelp.UnitHasDebuffByPlayer("target", "精灵之火（野性）") then
						if AutoHelp.TryUseAction(targetInfo, "精灵之火（野性）") then
							return true
						end
					elseif AutoHelp.Glyphs[413895] then
						if not su and si <= 85 and not (sB == 5 and sD == 0) and AutoHelp.TryUseAction(targetInfo, "精灵之火（野性）") then
							return true
						end
					end
				end;
				if GetStatus("ATTACK_STATUS_猫_冲锋") and sy(10) and AutoHelp.TryUseAction(targetInfo, "野性冲锋 - 豹") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_猫_裂伤") and sy(40) and sF <= 2 and AutoHelp.TryUseAction(targetInfo, "裂伤（豹）") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_猫_野蛮咆哮") and sB > 0 and sy(25) and (sE <= 2 or sD <= 10 and sE <= sD + 4) then
					if AutoHelp.TryUseAction(mH, "野蛮咆哮") then
						return true
					end
				end;
				if not sv and GetStatus("ATTACK_STATUS_猫_猛虎之怒") and si <= 40 and AutoHelp.TryUseAction(mH, "猛虎之怒") then
					return true
				end;
				if sC and GetStatus("ATTACK_STATUS_猫_狂暴") and rn and AutoHelp.TryUseAction(mH, "狂暴") then
					return true
				end;
				if GetStatus("STATUS_始终AOE") and GetStatus("ATTACK_STATUS_猫_横扫") then
					if sE <= 5 and sB == 0 then
						if GetStatus("ATTACK_STATUS_猫_裂伤") and sy(40) and AutoHelp.TryUseAction(targetInfo, "裂伤（豹）") then
							return true
						end;
						if GetStatus("ATTACK_STATUS_猫_斜掠") and sy(35) and AutoHelp.TryUseAction(targetInfo, "斜掠") then
							return true
						end
					end;
					if sy(45) and AutoHelp.TryUseAction(targetInfo, "横扫（豹）") then
						return true
					end;
					return false
				end;
				if GetStatus("HEAL_STATUS_AOE") and GetStatus("ATTACK_STATUS_猫_横扫") then
					local sq = AutoHelp.getNumberTargets()
					if sq >= 3 then
						if sE <= 5 and sB == 0 then
							if GetStatus("ATTACK_STATUS_猫_裂伤") and sy(40) and AutoHelp.TryUseAction(targetInfo, "裂伤（豹）") then
								return true
							end;
							if GetStatus("ATTACK_STATUS_猫_斜掠") and sy(35) and AutoHelp.TryUseAction(targetInfo, "斜掠") then
								return true
							end
						end;
						if sy(45) and AutoHelp.TryUseAction(targetInfo, "横扫（豹）") then
							return true
						end;
						return false
					end
				end;
				if GetStatus("ATTACK_STATUS_猫_割裂") and sy(30) and sB == 5 and AutoHelp.TryUseAction(targetInfo, "割裂") then
					return true
				end;
				if sG then
					if su and GetStatus("ATTACK_STATUS_猫_裂伤") and sy(40) and AutoHelp.TryUseAction(targetInfo, "裂伤（豹）") then
						return true
					end
				else
					if su and GetStatus("ATTACK_STATUS_猫_撕碎") and sy(42) and AutoHelp.TryUseAction(targetInfo, "撕碎") then
						return true
					end
				end;
				if GetStatus("ATTACK_STATUS_猫_斜掠") and sy(35) and AutoHelp.TryUseAction(targetInfo, "斜掠") then
					return true
				end;
				if sB == 5 then
					if sG then
						if GetStatus("ATTACK_STATUS_猫_裂伤") and sy(70) and AutoHelp.TryUseAction(targetInfo, "裂伤（豹）") then
							return true
						end
					else
						if GetStatus("ATTACK_STATUS_猫_撕碎") and sy(80) and AutoHelp.TryUseAction(targetInfo, "撕碎") then
							return true
						end
					end
				else
					if sG then
						if GetStatus("ATTACK_STATUS_猫_裂伤") and sy(40) and AutoHelp.TryUseAction(targetInfo, "裂伤（豹）") then
							return true
						end
					else
						if GetStatus("ATTACK_STATUS_猫_撕碎") and sy(42) and AutoHelp.TryUseAction(targetInfo, "撕碎") then
							return true
						end
					end
				end;
				if GetStatus("ATTACK_STATUS_猫_凶猛撕咬") and sy(35) then
					if sE >= 14 and sD >= 10 and sB == 5 and AutoHelp.TryUseAction(targetInfo, "凶猛撕咬") then
						return true
					end
				end;
				if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function sH()
				if rW() then
					return true
				end;
				local sm = AutoHelp.UnitHasBuff("player", "月蚀")
				local sn = AutoHelp.UnitHasBuff("player", "日蚀")
				local sf, sg = GetCombatValue("MoonStatus") or 0, GetCombatValue("SunStatus") or 0;
				if GetTalentSpent("大地与月亮") >= 1 then
					if GetStatus("ATTACK_STATUS_人_愤怒") and not AutoHelp.UnitHasDebuffByPlayer(targetInfo["unit"], "大地与月亮") and AutoHelp.TryUseAction(targetInfo, "愤怒") then
						return true
					end
				end;
				if GetStatus("ATTACK_STATUS_人_星辰坠落") and AutoHelp.TryUseAction(mH, "星辰坠落") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_人_飓风") then
					local so = MouseoverIsTank() or MouseoverCanAttack()
					local sq = AutoHelp.getNumberTargets()
					local sr = sq >= 3 and so;
					if sr and GetStatus("ATTACK_STATUS_人_飓风") and not AutoHelp.IsMoving and AutoHelp.TryUseAction(mH, "飓风") then
						return true
					end
				end;
				if GetStatus("ATTACK_STATUS_人_星火术") and AutoHelp.UnitHasBuff("player", 64823) and AutoHelp.TryUseAction(targetInfo, "星火术") then
					AutoHelp.Debug(">>T8四件套特效：瞬发星火术！")
					return true
				end;
				if GetStatus("ATTACK_STATUS_人_精灵之火") and AutoHelp.TryUseAction(targetInfo, "精灵之火") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_人_虫群") and AutoHelp.TryUseAction(targetInfo, "虫群") then
					return true
				end;
				if GetStatus("ATTACK_STATUS_人_自然之力") and AutoHelp.TryUseAction(mH, "自然之力") then
					return true
				end;
				local sm = AutoHelp.UnitHasBuff("player", "月蚀")
				local sn = AutoHelp.UnitHasBuff("player", "日蚀")
				if GetStatus("ATTACK_STATUS_人_月火术") and not sm and AutoHelp.TryUseAction(targetInfo, "月火术") then
					return true
				end;
				if sm then
					sf = 1;
					sg = 0;
					SetCombatValue("MoonStatus", sf)
					SetCombatValue("SunStatus", sg)
				end;
				if sn then
					sf = 0;
					sg = 1;
					SetCombatValue("MoonStatus", sf)
					SetCombatValue("SunStatus", sg)
				end;
				if (sf == 0 and sg == 0 or sg == 1) and AutoHelp.TryUseAction(targetInfo, "愤怒") then
					return true
				end;
				if sf == 1 and AutoHelp.TryUseAction(targetInfo, "星火术") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if InCombatLockdown() and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			if not InCombatLockdown() then
				sf = 0;
				sg = 0
			end;
			if jy("HEALMODE") == "野性(熊)" then
				if st() then
					return true
				end
			end;
			if jy("HEALMODE") == "野性(猫)" then
				if sA() then
					return true
				end
			end;
			if jy("HEALMODE") == "平衡(鸟)" then
				if sl() then
					return true
				end
			end;
			if jy("HEALMODE") == "治疗" or jy("HEALMODE") == "打怪模式" then
				if sH() then
					return true
				end
			end
		end
	end;
	if PlayerIsClass("DRUID") then
		AutoHelp.ClassConfig = s4
	end
end;
if AutoHelp.isWotlk then
	local function sI()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {}
		AutoHelp.CAN_RESCURIT = false;
		AutoHelp.CAN_HEAL = false;
		AutoHelp.CAN_BUFF = true;
		AutoHelp.CAN_DISPEL = true;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 2;
		AutoHelp.AttackRange = 30;
		AutoHelp.DispelCurseKey = GetSpellInfo(475)
		AutoHelp.CommingHealWindow = 0;
		local sJ = "冰法"
		local function sK(hK, jI)
			if jI then
				if hK ~= "熔岩护甲" then
					SetConfig("STATUS_熔岩护甲", false)
				end;
				if hK ~= "法师护甲" then
					SetConfig("STATUS_法师护甲", false)
				end;
				if hK ~= "冰甲术" then
					SetConfig("STATUS_冰甲术", false)
				end;
				if hK ~= "霜甲术" then
					SetConfig("STATUS_霜甲术", false)
				end
			end
		end;
		local function sL()
			if GetStatus("STATUS_熔岩护甲") then
				return "熔岩护甲"
			end;
			if GetStatus("STATUS_法师护甲") then
				return "法师护甲"
			end;
			if GetStatus("STATUS_冰甲术") then
				return "冰甲术"
			end;
			if GetStatus("STATUS_霜甲术") then
				return "霜甲术"
			end
		end;
		local function sM(hK, jI)
			if jI then
				if hK ~= "点击施法" then
					SetConfig("STATUS_点击施法", false)
				end;
				if hK ~= "指向施法" then
					SetConfig("STATUS_指向施法", false)
				end;
				if hK ~= "身边施法" then
					SetConfig("STATUS_身边施法", false)
				end
			end
		end;
		local function sN()
			if GetStatus("STATUS_点击施法") then
				return "点击施法"
			end;
			if GetStatus("STATUS_指向施法") then
				return "指向施法"
			end;
			if GetStatus("STATUS_身边施法") then
				return "身边施法"
			end
		end;
		local n9 = {
			{
				name = "射击",
				spellId = true,
				["target"] = true
			},
			{
				["name"] = "KEY_USEBAOSHI",
				["itemId"] = 8008,
				["target"] = false
			},
			{
				["name"] = "KEY_USEBAOSHI2",
				["itemId"] = 8007,
				["target"] = false
			},
			{
				name = "奥术智慧",
				spellId = true,
				["target"] = true,
				["auraName"] = "奥术光辉"
			},
			{
				name = "火球术",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "霜火之箭",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "造水术",
				spellId = true
			},
			{
				name = "寒冰箭",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "造食术",
				spellId = true
			},
			{
				name = "火焰冲击",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "活动炸弹",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "活动炸弹鼠标指向",
				spellId = true,
				["spellName"] = "活动炸弹",
				["macro"] = "/cast [@mouseover,exists,harm]活动炸弹"
			},
			{
				name = "炎爆术",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				}
			},
			{
				name = "冲击波",
				spellId = true
			},
			{
				name = "龙息术",
				spellId = true
			},
			{
				name = "烈焰风暴",
				spellId = true,
				["spellName"] = "烈焰风暴",
				["macro"] = "/cast 烈焰风暴\n",
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "烈焰风暴_指向",
				spellId = true,
				["spellName"] = "烈焰风暴",
				["macro"] = "/cast [@cursor] 烈焰风暴\n",
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "烈焰风暴_身边",
				spellId = true,
				["spellName"] = "烈焰风暴",
				["macro"] = "/cast [@player] 烈焰风暴\n",
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "烈焰风暴2",
				spellId = true,
				["macro"] = "/cast  烈焰风暴(等级 5)\n"
			},
			{
				name = "暴风雪",
				spellId = true,
				["macro"] = "/cast 暴风雪\n",
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "暴风雪_指向",
				spellId = true,
				["spellName"] = "暴风雪",
				["macro"] = "/cast [@cursor,nochanneling:暴风雪] 暴风雪\n",
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "暴风雪_身边",
				spellId = true,
				["spellName"] = "暴风雪",
				["macro"] = "/cast [@player,nochanneling:暴风雪] 暴风雪\n",
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "燃烧",
				spellId = true
			},
			{
				name = "镜像",
				spellId = true
			},
			{
				name = "冰冷血脉",
				spellId = true
			},
			{
				name = "隐形术",
				spellId = true
			},
			{
				name = GetSpellInfo(475),
				spellId = true,
				["target"] = true
			},
			{
				name = "专注魔法",
				spellId = true,
				["target"] = true,
				["auraNameCID2"] = true
			},
			{
				name = "冰枪术",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "灼烧",
				spellId = true,
				["target"] = true
			},
			{
				name = "奥术飞弹",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"燃烧",
					"冰冷血脉",
					"奥术强化"
				},
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "变形术",
				spellId = true,
				["target"] = true
			},
			{
				name = "冰霜新星",
				spellId = true
			},
			{
				name = "魔法抑制",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "缓落术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "魔爆术",
				spellId = true
			},
			{
				name = "侦测魔法",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "魔法增效",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "传送：幽暗城",
				spellId = {
					{
						20,
						3563
					}
				}
			},
			{
				name = "法力护盾",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "防护火焰结界",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "唤醒",
				spellId = true
			},
			{
				name = "传送：奥格瑞玛",
				spellId = true
			},
			{
				name = "传送：暴风城",
				spellId = true
			},
			{
				name = "传送：铁炉堡",
				spellId = true
			},
			{
				name = "闪现术",
				spellId = true
			},
			{
				name = "防护冰霜结界",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "法术反制",
				spellId = true
			},
			{
				name = "冰锥术",
				spellId = true
			},
			{
				name = "制造魔法玛瑙",
				spellId = true
			},
			{
				name = "传送：雷霆崖",
				spellId = true
			},
			{
				name = "传送：达纳苏斯",
				spellId = true
			},
			{
				name = "熔岩护甲",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "霜甲术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "冰甲术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "法师护甲",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "制造魔法翡翠",
				spellId = {
					{
						38,
						3552
					}
				}
			},
			{
				name = "传送门：暴风城",
				spellId = {
					{
						40,
						10059
					}
				}
			},
			{
				name = "传送门：幽暗城",
				spellId = {
					{
						40,
						11418
					}
				}
			},
			{
				name = "传送门：奥格瑞玛",
				spellId = {
					{
						40,
						11417
					}
				}
			},
			{
				name = "传送门：铁炉堡",
				spellId = {
					{
						40,
						11416
					}
				}
			},
			{
				name = "制造魔法黄水晶",
				spellId = {
					{
						48,
						10053
					}
				}
			},
			{
				name = "传送门：达纳苏斯",
				spellId = {
					{
						50,
						11419
					}
				}
			},
			{
				name = "传送门：雷霆崖",
				spellId = {
					{
						50,
						11420
					}
				}
			},
			{
				name = "奥术光辉",
				spellId = {
					{
						56,
						23028
					}
				},
				["target"] = true
			},
			{
				name = "制造法力宝石",
				spellId = true
			},
			{
				name = "急速冷却",
				spellId = {
					{
						- 1,
						12472
					}
				}
			},
			{
				name = "气定神闲",
				spellId = {
					{
						- 1,
						12043
					}
				}
			},
			{
				name = "寒冰屏障",
				spellId = {
					{
						- 1,
						11958
					}
				}
			},
			{
				name = "奥术强化",
				spellId = {
					{
						- 1,
						12042
					}
				}
			},
			{
				name = "寒冰护体",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				["name"] = "选中镜像",
				["macro"] = "/targetexact 裹体之网\n/targetexact 镜像\n/cast [exists]冰枪术\n",
				["spellName"] = "选中镜像",
				["spellTime"] = 1,
				["desc"] = "选中镜像"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "火法"
			AutoHelp.ModeDefaultSetting = {
				["HEAL_STATUS_START"] = true,
				["STATUS_主动攻击"] = true,
				["STATUS_治疗模式"] = false,
				["HEAL_STATUS_FIRSTDISPAL"] = true
			}
			AutoHelp.HEAL_MODES = {
				["火法"] = {
					["modetip"] = "\124cffFFF569设置为【火法】。\124r"
				},
				["冰法"] = {
					["modetip"] = "\124cffFFF569设置为【冰法】。\124r"
				},
				["奥法"] = {
					["modetip"] = "\124cffFFF569设置为【奥法】。\124r"
				},
				["将军英雄模式"] = {
					["modetip"] = "\124cffFFF569设置为【将军模式】。\124r"
				}
			}
			AutoHelp.ModeList = {
				{
					text = "输出模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00火法\124r",
					name = "火法",
					tooltipTitle = "火法",
					tooltipText = "使用火法"
				},
				{
					text = "\124cffFFFFFF冰法\124r",
					name = "冰法",
					tooltipTitle = "冰法",
					tooltipText = "使用冰法"
				}
			}
			AutoHelp.PANELHEIGHT = 490;
			AutoHelp.PANELWIDTH = 160;
			local ki = AutoHelp.PANELHEIGHT or 490;
			local kj = AutoHelp.PANELWIDTH or 160;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00基础设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_奥术智慧",
						["value"] = true,
						["title"] = "\124T135932:14:14\124t",
						["tipTitle"] = "智力BUFF",
						["tip"] = "自动给团队/队伍上智力",
						["point"] = 0,
						["hitRect"] = - 20,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_奥术光辉",
						["value"] = false,
						["title"] = "\124T135869:14:14\124t",
						["tipTitle"] = "使用强效智力（奥术光辉）",
						["tip"] = "给团队中的小队上强效智力",
						["point"] = 40,
						["hitRect"] = - 20,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISCURSE",
						["value"] = true,
						["title"] = "解除诅咒",
						["tip"] = "优先驱散，驱散将优先DPS\n\n\124cff00ff00对于频繁产生负面效果时，建议关闭此选项提高DPS\n优先驱散选中效果将高于DPS\124r",
						["point"] = 80,
						["hitRect"] = - 30,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey(GetSpellInfo(475)) then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_熔岩护甲",
						["value"] = true,
						["title"] = "\124T132221:14:14\124t",
						["tip"] = "自动熔岩护甲",
						["point"] = 0,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("熔岩护甲") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							sK("熔岩护甲", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_法师护甲",
						["value"] = false,
						["title"] = "\124T135991:14:14\124t",
						["tip"] = "自动法师护甲",
						["point"] = 40,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("法师护甲") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							sK("法师护甲", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_冰甲术",
						["value"] = false,
						["title"] = "\124T135843:14:14\124t",
						["tip"] = "自动冰甲术",
						["point"] = 80,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("冰甲术") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							sK("冰甲术", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_霜甲术",
						["value"] = false,
						["title"] = "\124T135843:14:14\124t",
						["tip"] = "自动霜甲术",
						["point"] = 120,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("霜甲术") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							sK("霜甲术", hK)
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_专注魔法",
						["value"] = true,
						["title"] = "专注",
						["tip"] = "\124cff00ff00自动给队友上专注魔法。\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("专注魔法") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_专注目标",
						["title"] = "选择专注魔法队友",
						["tipTitle"] = "专注魔法队友选择",
						["tip"] = "在设定好队伍/团队人员之后，将自动在给队友上专注魔法。",
						["width"] = 100,
						["height"] = 22,
						["point"] = 55,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(kl)
							local cd = jy("专注目标")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo["unit"] == "player" then
								AutoHelp.Debug("不能给自己专注魔法！")
								return
							end;
							if tInfo == nil and jy("专注目标") == "无" then
								AutoHelp.Debug("要设置专注目标请先选择队友！")
								return
							end;
							if tInfo ~= nil then
								SetConfig("专注目标", tInfo["name"])
								AutoHelp.Debug("设置专注目标：" .. tInfo["name"])
							else
								SetConfig("专注目标", "无")
								AutoHelp.Debug("清除专注目标。")
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在枭兽模式下为缺省勾选，建议治疗模式不要选择。",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_镜像蛛网",
						["value"] = true,
						["title"] = "镜像",
						["tip"] = "当目进入有镜像或者蛛网的副本时，自动优先打镜像和蛛网裹体",
						["point"] = 55,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动唤醒",
						["value"] = true,
						["title"] = "唤醒",
						["tip"] = "战斗中蓝量低于设定值时10%，自动唤醒回蓝",
						["point"] = 110,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("唤醒") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_多目标痛",
						["value"] = false,
						["title"] = "多目标活动炸弹",
						["tipTitle"] = "多目标保持活动炸弹",
						["tip"] = "鼠标指向非当前敌对目标时自动上活动炸弹。\n\n\124cff00ff00适合多目标提高伤害，比如Xt002鼠标指向火花会自动给火花上活动炸弹，左右手皆可指向目标保持多目标活活动炸弹。\124r",
						["hitRec"] = - 50,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "火法",
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("活动炸弹") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在枭兽模式下为缺省勾选，建议治疗模式不要选择。",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "classic",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动唤醒",
						["value"] = true,
						["title"] = "唤醒",
						["tip"] = "战斗中蓝量低于设定值时10%，自动唤醒回蓝",
						["point"] = 110,
						["nextpos"] = false,
						["version"] = "classic",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("唤醒") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = false,
						["title"] = "\124cffFFF569AOE：\124r",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果怪物数量大于等于3个，将自动启动AOE技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["point"] = 5,
						["nextpos"] = true,
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_火法_冲击波", true)
								SetConfig("STATUS_火法_烈焰风暴", true)
								SetConfig("STATUS_火法_龙息术", true)
								SetConfig("STATUS_火法_暴风雪", true)
							else
								SetConfig("STATUS_火法_冲击波", false)
								SetConfig("STATUS_火法_烈焰风暴", false)
								SetConfig("STATUS_火法_龙息术", false)
								SetConfig("STATUS_火法_暴风雪", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_指向施法",
						["value"] = true,
						["title"] = "指",
						["tipTitle"] = "指向施法",
						["tip"] = "需要AOE时，鼠标指向需要AOE的位置即可。",
						["point"] = 60,
						["nextpos"] = false,
						["fnc"] = function(hK)
							sM("指向施法", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_点击施法",
						["value"] = false,
						["title"] = "点",
						["tipTitle"] = "点击施法",
						["tip"] = "需要AOE时，需要用鼠标点击目标位置。",
						["point"] = 95,
						["nextpos"] = false,
						["fnc"] = function(hK)
							sM("点击施法", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_身边施法",
						["value"] = false,
						["title"] = "近",
						["tipTitle"] = "角色为中心施法",
						["tip"] = "需要AOE时，将会以人物为中心施放暴风雪/烈焰风暴/龙息等技能。",
						["point"] = 125,
						["nextpos"] = false,
						["fnc"] = function(hK)
							sM("身边施法", hK)
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_寒冰屏障",
						["title"] = "冰箱",
						["tipTitle"] = "寒冰屏障",
						["tip"] = "寒冰屏障\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = 80,
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("寒冰屏障") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("寒冰屏障")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_唤醒",
						["title"] = "唤醒",
						["tipTitle"] = "唤醒",
						["tip"] = "唤醒 \n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = 80,
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("唤醒") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("唤醒")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_爆发",
						["title"] = "爆发",
						["tipTitle"] = "开启爆发/饰品等",
						["tip"] = "开启爆发[燃烧/冰冷血脉/奥术强化], 工程手套/饰品\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = 80,
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("爆发")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_爆发喝药",
						["title"] = "爆药",
						["tipTitle"] = "开启爆发/饰品并喝药等",
						["tip"] = "开启爆发[燃烧/冰冷血脉/奥术强化], 工程手套/饰品/狂野魔法药水\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = 80,
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("爆发喝药")
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00攻击技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动隐身",
						["value"] = false,
						["title"] = "OT隐身",
						["tip"] = "当对BOSS仇恨高于设定值时，自动使用隐身消除仇恨，缺省设置仇恨高于90%时使用",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_仇恨值",
						["value"] = 90,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["version"] = "wlk"
					}
				}
			}
			local qQ = {
				{},
				{
					{
						"火法_射击",
						"射击",
						true,
						"魔杖攻击",
						"火法"
					},
					{
						"火法_霜火之箭",
						"霜火之箭",
						true,
						"霜火之箭",
						"火法"
					},
					{
						"火法_火球术",
						"火球术",
						false,
						"火球术",
						"火法"
					},
					{
						"火法_活动炸弹",
						"活动炸弹",
						true,
						"活动炸弹",
						"火法"
					},
					{
						"火法_炎爆术",
						"炎爆术",
						true,
						"炎爆术",
						"火法"
					},
					{
						"火法_灼烧",
						"灼烧",
						true,
						"灼烧",
						"火法"
					},
					{
						"火法_镜像",
						"镜像",
						true,
						"镜像",
						"火法"
					},
					{
						"火法_火焰冲击",
						"火焰冲击",
						true,
						"火焰冲击",
						"火法"
					},
					{
						"火法_冲击波",
						"冲击波",
						true,
						"冲击波",
						"火法"
					},
					{
						"火法_烈焰风暴",
						"烈焰风暴",
						true,
						"烈焰风暴",
						"火法"
					},
					{
						"火法_龙息术",
						"龙息术",
						true,
						"龙息术",
						"火法"
					},
					{
						"火法_暴风雪",
						"暴风雪",
						true,
						"暴风雪",
						"火法"
					}
				},
				{
					{
						"冰法_射击",
						"射击",
						true,
						"魔杖攻击",
						"冰法"
					},
					{
						"冰法_寒冰箭",
						"寒冰箭",
						true,
						"寒冰箭",
						"冰法"
					},
					{
						"冰法_冰枪术",
						"冰枪术",
						true,
						"冰枪术",
						"冰法"
					},
					{
						"冰法_霜火之箭",
						"霜火之箭",
						true,
						"霜火之箭",
						"冰法"
					},
					{
						"冰法_火球术",
						"火球术",
						true,
						"火球术",
						"冰法"
					},
					{
						"冰法_火焰冲击",
						"火焰冲击",
						true,
						"火焰冲击",
						"冰法"
					},
					{
						"冰法_冲击波",
						"冲击波",
						true,
						"冲击波",
						"冰法"
					},
					{
						"冰法_暴风雪",
						"暴风雪",
						true,
						"暴风雪",
						"冰法"
					}
				},
				{
					{
						"奥法_奥术飞弹",
						"奥术飞弹",
						true,
						"暂时不支持奥法循环!!",
						"奥法"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 2 == 1 then
							point = 5;
							kf = true
						else
							point = 80;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tip"] = qS[4],
							["point"] = point,
							["nextpos"] = kf,
							["stance"] = qS[5],
							["mode"] = qS[5]
						}
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if kH == "火法" then
				if GetTalentSpent("强化火球术") > 0 then
					AutoHelp.Debug("强化火球术，自动选择火球术作为填充技能")
					SetConfig("STATUS_火法_火球术", true)
					SetConfig("STATUS_火法_霜火之箭", false)
				elseif AutoHelp.HasActionKey("霜火之箭") then
					SetConfig("STATUS_火法_火球术", false)
					SetConfig("STATUS_火法_霜火之箭", true)
				end
			end;
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or bn.mode == "attack" then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			AutoHelp.ResizePanel()
		end;
		local sO = false;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") then
				return
			end;
			if qV.event == "SPELL_AURA_APPLIED" and qV.spellId == 62692 then
				AutoHelp.Debug(">>进入奥杜尔将军战，停止自动换醒！")
				SetConfig("HEAL_STATUS_自动唤醒", false)
			end;
			if qV.event == "SPELL_AURA_REMOVED" and qV.spellId == 62692 then
				AutoHelp.Debug(">>奥杜尔将军战结束，恢复自动换醒！")
				SetConfig("HEAL_STATUS_自动唤醒", true)
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.RegisterBossEvent()
		end;
		local sP = 0;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
			if ho == "player" then
				local cx = GetSpellInfo(ca)
				if cx == "烈焰风暴" then
					sP = GetTime()
				end
			end
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.isWotlk then
				if AutoHelp.HasActionKey("寒冰屏障") then
					local pj = FindOrCreateMacro("A冰箱", nil, "#showtooltips 寒冰屏障\n/stopcasting\n/ahcast 寒冰屏障\n", 1)
				end;
				if AutoHelp.HasActionKey("唤醒") then
					local pj = FindOrCreateMacro("A唤醒", nil, "#showtooltips 唤醒\n/stopcasting\n/ahcast 唤醒\n", 2)
				end;
				if AutoHelp.HasActionKey("烈焰风暴") then
					local pj = FindOrCreateMacro("A烈焰风暴", nil, "#showtooltips 烈焰风暴\n/stopcasting\n/ahcast 烈焰风暴\n")
				end;
				if AutoHelp.HasActionKey("暴风雪") then
					local pj = FindOrCreateMacro("A暴风雪", nil, "#showtooltips 暴风雪\n/stopcasting\n/ahcast 暴风雪\n")
				end
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52)
		end;
		function AutoHelp.AddNextCastAction(qZ)
			return true
		end;
		function AutoHelp.SpellDamageAction(fm, aj, fu, ca, cx, amount)
		end;
		function AutoHelp.ThreatChanged(mt, sQ, sR, sS)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_自动隐身") then
				return
			end;
			local jp = GetStatusNumber("HEAL_VALUE_仇恨值") or 90;
			if mt >= 2 then
				AutoHelp.Debug(">>>>你OT了，请使用隐身消除仇恨！")
			end;
			if mt == 1 and sQ >= jp then
				AutoHelp.Debug(">>>>仇恨过高:" .. sQ .. "%，请使用隐身消除仇恨！")
			end
		end;
		function AutoHelp.EncounterStart(sT, sU, rx, sV)
			if sT == 1130 or sT == 757 then
				return
			end
		end;
		function AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
			if sT == 1130 or sT == 757 then
				return
			end
		end;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("专注目标", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_BUTTON_专注目标"]
				if k8 then
					k8:SetText(hK)
				end
			end)
		end;
		function AutoHelp.CanMoveSpell(tInfo, p)
			return p == "炎爆术" and AutoHelp.UnitHasBuff("player", "法术连击")
		end;
		function AutoHelp.DoTeamBuff()
			if not GetStatus("HEAL_STATUS_奥术光辉") and not GetStatus("HEAL_STATUS_奥术智慧") then
				return false
			end;
			if InCombatLockdown() then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if GetStatus("HEAL_STATUS_奥术光辉") and AutoHelp.UnitCanBuff(tInfo["unit"], "奥术光辉") and AutoHelp.GetBuffRemainTime(tInfo["unit"], "奥术光辉") == 0 then
					if AutoHelp.TryUseAction(tInfo, "奥术光辉") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_奥术智慧") and AutoHelp.UnitCanBuff(tInfo["unit"], "奥术智慧") and AutoHelp.GetBuffRemainTime(tInfo["unit"], "奥术智慧") == 0 then
					if AutoHelp.TryUseAction(tInfo, "奥术智慧") then
						return true
					end
				end
			end
		end;
		local sW = {
			["5504"] = "5350",
			["5505"] = "2288",
			["5506"] = "2136",
			["6127"] = "3772",
			["10138"] = "8077",
			["10139"] = "8078",
			["10140"] = "8079",
			["37420"] = "30703",
			["27090"] = "22018"
		}
		local sX = {
			["587"] = "5349",
			["597"] = "1113",
			["990"] = "1114",
			["6129"] = "1487",
			["10144"] = "8075",
			["10145"] = "8076",
			["28612"] = "22895",
			["33717"] = "22019"
		}
		function AutoHelp.DoUrgentAction(mH, targetInfo)
			local sY = sL()
			if sY and AutoHelp.TryUseAction(mH, sY) then
				return true
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_专注魔法") then
				local lw = jy("专注目标")
				if lw ~= "无" and lw ~= nil then
					local oz = HEAL_RAID_NAMES[lw]
					if not oz then
						SetConfig("专注目标", "无")
					else
						local tInfo = HEAL_RAID[oz]
						if tInfo and AutoHelp.IsValidEmergency(tInfo) and AutoHelp.TryUseAction(tInfo, "专注魔法") then
							AutoHelp.DebugText = "专注魔法"
							return true
						end
					end
				end
			end
		end;
		local sZ = false;
		local s_ = false;
		function AutoHelp.DoUncombatAction(mH)
			local jS;
			if GetStatus("STATUS_自动做水") then
				local t0 = AutoHelp.GetAction("造水术")
				local t1 = t0 and sW[tostring(t0["spellId"])]
				if t1 then
					jS = AutoHelp.GetItemCount(t1)
					if jS <= GetStatusNumber("HEAL_VALUE_MINDRINK") then
						sZ = true
					end;
					if jS >= GetStatusNumber("HEAL_VALUE_MAXDRINK") then
						sZ = false
					end;
					if sZ and AutoHelp.TryUseAction(mH, "造水术") then
						return true
					end
				end
			end;
			if GetStatus("STATUS_自动做水") then
				local t2 = AutoHelp.GetAction("造食术")
				local t3 = t2 and sX[tostring(t2["spellId"])]
				if t3 then
					jS = AutoHelp.GetItemCount(t3)
					if jS <= GetStatusNumber("HEAL_VALUE_MINFOOD") then
						s_ = true
					end;
					if jS >= GetStatusNumber("HEAL_VALUE_MAXFOOD") then
						s_ = false
					end;
					if s_ and AutoHelp.TryUseAction(mH, "造食术") then
						return true
					end
				end
			end;
			if GetStatus("HEAL_STATUS_MAKEBAOSHI") then
				jS = AutoHelp.GetItemCount(8008)
				if jS == 0 and AutoHelp.TryUseAction(mH, "KEY_MAKEBAOSHI") then
					return true
				end;
				jS = AutoHelp.GetItemCount(8007)
				if jS == 0 and AutoHelp.TryUseAction(mH, "KEY_MAKEBAOSHI2") then
					return true
				end
			end;
			return false
		end;
		local function rj(tInfo)
			if GetStatus("HEAL_STATUS_DISCURSE") and tInfo["hasCurse"] and AutoHelp.DispelCurseKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelCurseKey) then
					return true
				end
			end
		end;
		function AutoHelp.DoDispelAction()
			if not GetStatus("HEAL_STATUS_DISCURSE") or not AutoHelp.HasActionKey("解除诅咒") then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["hasDebuff"] and AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] and rj(tInfo) then
					AutoHelp.DebugText = "驱散团队"
					return true
				end
			end
		end;
		local eJ = GetInventorySlotInfo("RangedSlot")
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, r7 = mH["hp"], mH["mp"]
			local t4 = IsSpellInRange(GetSpellInfo(5019), targetInfo["unit"]) == 1;
			local t5 = AutoHelp.UnitInMeleeRange(targetInfo["unit"])
			local t6 = CheckInteractDistance(targetInfo["unit"], 4) and not t4 and not t5;
			local t8 = CheckInteractDistance(targetInfo["unit"], 4) and not t4;
			local t9 = not CheckInteractDistance(targetInfo["unit"], 4) and not t4;
			local ta = IsPetAttackActive()
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local ib, iG = AutoHelp.GetRange("target")
			local function rW()
				if not AutoHelp.KillJX then
					return false
				end;
				local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
				if not rX and InCombatLockdown() and GetStatus("HEAL_STATUS_镜像蛛网") then
					if FindEnemyUnit("镜像") or FindEnemyUnit("裹体之网") then
						if AutoHelp.TryUseAction(mH, "选中镜像") then
							AutoHelp.Debug(">>有镜像或者蛛网裹体，优先击杀！")
							return true
						end
					end
				end;
				return false
			end;
			local function tb()
				if GetStatus("STATUS_点击施法") and SpellIsTargeting() then
					return false
				end;
				if GetStatus("HEAL_STATUS_自动唤醒") and r7 <= 0.1 and AutoHelp.TryUseAction(mH, "唤醒") then
					return true
				end;
				if GetStatus("HEAL_STATUS_AOE") then
					local sq = AutoHelp.getNumberTargets()
					if sq >= 3 then
						local tc = sN()
						if GetStatus("STATUS_冰法_冲击波") and iG <= 5 and AutoHelp.TryUseAction(mH, "冲击波") then
							return true
						end;
						if tc == "点击施法" then
							if GetStatus("STATUS_冰法_暴风雪") and AutoHelp.TryUseAction(mH, "暴风雪") then
								return true
							end
						elseif tc == "指向施法" then
							local so = MouseoverIsTank() or MouseoverCanAttack()
							if GetStatus("STATUS_冰法_暴风雪") and so and AutoHelp.TryUseAction(mH, "暴风雪_指向") then
								return true
							end
						elseif tc == "身边施法" then
							if GetStatus("STATUS_冰法_暴风雪") and t5 and AutoHelp.TryUseAction(mH, "暴风雪_身边") then
								return true
							end
						end
					end
				end;
				if GetStatus("STATUS_冰法_冰枪术") and AutoHelp.UnitHasBuff("player", "寒冰指") and AutoHelp.TryUseAction(targetInfo, "冰枪术") then
					return true
				end;
				if GetStatus("STATUS_冰法_霜火之箭") and AutoHelp.UnitHasBuff("player", "冷却思维") and AutoHelp.TryUseAction(targetInfo, "霜火之箭") then
					return true
				end;
				if GetStatus("STATUS_冰法_火球术") and AutoHelp.UnitHasBuff("player", "冷却思维") and AutoHelp.TryUseAction(targetInfo, "火球术") then
					return true
				end;
				if GetStatus("STATUS_冰法_寒冰箭") and AutoHelp.TryUseAction(targetInfo, "寒冰箭") then
					return true
				end;
				if GetStatus("STATUS_冰法_火焰冲击") and AutoHelp.TryUseAction(targetInfo, "火焰冲击") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("STATUS_冰法_射击") and not IsAutoRepeatSpell("射击") and not AutoHelp.IsMoving and GetInventoryItemLink("player", 18) and AutoHelp.TryUseAction(targetInfo, "射击") then
					return true
				end;
				if InCombatLockdown() and not IsAutoRepeatSpell("射击") and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function td()
				if GetStatus("STATUS_点击施法") and SpellIsTargeting() then
					return false
				end;
				if GetStatus("STATUS_火法_活动炸弹") and AutoHelp.TryUseAction(targetInfo, "活动炸弹") then
					return true
				end;
				if GetStatus("STATUS_多目标痛") and not MouseoverIsTarget() and UnitCanAttack("player", "mouseover") then
					local s1, s2 = AutoHelp.GetRange("mouseover")
					local te = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(44457), true)
					if GetStatus("STATUS_火法_活动炸弹") and s2 <= 35 and te == 0 and AutoHelp.TryUseAction(mH, "活动炸弹鼠标指向") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_自动唤醒") and r7 <= 0.1 and rn and AutoHelp.TryUseAction(mH, "唤醒") then
					return true
				end;
				if GetStatus("HEAL_STATUS_AOE") then
					local sq = AutoHelp.getNumberTargets()
					if sq >= 3 then
						local tc = sN()
						if tc == "点击施法" then
							if GetStatus("STATUS_火法_冲击波") and t5 and AutoHelp.TryUseAction(mH, "冲击波") then
								return true
							end;
							if GetStatus("STATUS_火法_烈焰风暴") and GetTime() - sP >= 6 and AutoHelp.TryUseAction(mH, "烈焰风暴") then
								return true
							end;
							if GetStatus("STATUS_火法_龙息术") and t5 and AutoHelp.TryUseAction(mH, "龙息术") then
								return true
							end;
							if GetStatus("STATUS_火法_暴风雪") and AutoHelp.TryUseAction(mH, "暴风雪") then
								return true
							end
						elseif tc == "指向施法" then
							local so = MouseoverIsTank() or MouseoverCanAttack()
							if GetStatus("STATUS_火法_冲击波") and t5 and AutoHelp.TryUseAction(mH, "冲击波") then
								return true
							end;
							if GetStatus("STATUS_火法_烈焰风暴") and so and GetTime() - sP >= 6 and AutoHelp.TryUseAction(mH, "烈焰风暴_指向") then
								return true
							end;
							if GetStatus("STATUS_火法_龙息术") and t5 and AutoHelp.TryUseAction(mH, "龙息术") then
								return true
							end;
							if GetStatus("STATUS_火法_暴风雪") and so and AutoHelp.TryUseAction(mH, "暴风雪_指向") then
								return true
							end
						elseif tc == "身边施法" then
							if GetStatus("STATUS_火法_冲击波") and t5 and AutoHelp.TryUseAction(mH, "冲击波") then
								return true
							end;
							if GetStatus("STATUS_火法_烈焰风暴") and t5 and GetTime() - sP >= 6 and AutoHelp.TryUseAction(mH, "烈焰风暴_身边") then
								return true
							end;
							if GetStatus("STATUS_火法_龙息术") and t5 and AutoHelp.TryUseAction(mH, "龙息术") then
								return true
							end;
							if GetStatus("STATUS_火法_暴风雪") and t5 and AutoHelp.TryUseAction(mH, "暴风雪_身边") then
								return true
							end
						end
					end
				end;
				if GetStatus("STATUS_火法_镜像") and rn and AutoHelp.TryUseAction(mH, "镜像") then
					return true
				end;
				if GetStatus("STATUS_火法_炎爆术") and AutoHelp.UnitHasBuff("player", "法术连击") and AutoHelp.TryUseAction(targetInfo, "炎爆术") then
					return true
				end;
				local tf = AutoHelp.UnitHasDebuff("target", "强化灼烧") or AutoHelp.UnitHasDebuff("target", "暗影掌握")
				if GetStatus("STATUS_火法_灼烧") and not tf and AutoHelp.TryUseAction(targetInfo, "灼烧") then
					return true
				end;
				if GetStatus("STATUS_火法_霜火之箭") and AutoHelp.TryUseAction(targetInfo, "霜火之箭") then
					return true
				end;
				if GetStatus("STATUS_火法_火球术") and AutoHelp.TryUseAction(targetInfo, "火球术") then
					return true
				end;
				if GetStatus("STATUS_火法_火焰冲击") and AutoHelp.TryUseAction(targetInfo, "火焰冲击") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("STATUS_火法_射击") and not IsAutoRepeatSpell("射击") and not AutoHelp.IsMoving and GetInventoryItemLink("player", 18) and AutoHelp.TryUseAction(targetInfo, "射击") then
					return true
				end;
				if InCombatLockdown() and not IsAutoRepeatSpell("射击") and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function tg()
			end;
			if rW() then
				return true
			end;
			local kH = jy("HEALMODE") or "冰法"
			if kH == "冰法" then
				if tb() then
					return true
				end
			end;
			if kH == "火法" then
				if td() then
					return true
				end
			end;
			if kH == "奥法" then
				if tg() then
					return true
				end
			end
		end
	end;
	if PlayerIsClass("MAGE") then
		AutoHelp.ClassConfig = sI
	end
end;
if AutoHelp.isWotlk then
	local function th()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {}
		AutoHelp.CAN_RESCURIT = false;
		AutoHelp.CAN_HEAL = false;
		AutoHelp.CAN_BUFF = false;
		AutoHelp.CAN_DISPEL = false;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 10;
		AutoHelp.AttackType = 1;
		AutoHelp.AttackRange = 2;
		AutoHelp.CommingHealWindow = 0;
		AutoHelp.NOSTANCES = {
			GetSpellInfo(2457),
			GetSpellInfo(71),
			GetSpellInfo(2458)
		}
		local sJ = "狂暴战"
		local function ti(hK, jI)
			if jI then
				if hK ~= "命令怒吼" then
					SetConfig("STATUS_命令怒吼", false)
				end;
				if hK ~= "战斗怒吼" then
					SetConfig("STATUS_战斗怒吼", false)
				end
			end
		end;
		local function tj()
			if GetStatus("STATUS_命令怒吼") then
				return "命令怒吼"
			end;
			if GetStatus("STATUS_战斗怒吼") then
				return "战斗怒吼"
			end
		end;
		local n9 = {
			{
				name = "英勇打击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "战斗姿态",
				spellId = true,
				["nostance"] = {
					1
				}
			},
			{
				name = "冲锋",
				spellId = true,
				["target"] = true,
				["spellName"] = "冲锋",
				["stance"] = {
					1
				},
				["macro"] = "/cast [nostance:1]战斗姿态\n/cast 冲锋\n/cast 英勇投掷\n"
			},
			{
				name = "防御冲锋",
				spellId = true,
				["target"] = true,
				["spellName"] = "冲锋",
				["stance"] = {
					1,
					2,
					3
				},
				["macro"] = "/cast 冲锋\n/cast 英勇投掷\n"
			},
			{
				name = "防御拦截",
				spellId = true,
				["spellName"] = "拦截",
				["stance"] = {
					1,
					2,
					3
				},
				["target"] = true,
				["macro"] = "/cast 拦截\n/cast 英勇投掷\n"
			},
			{
				name = "拦截",
				spellId = true,
				["stance"] = {
					3
				},
				["target"] = true,
				["macro"] = "/cast 拦截\n/cast 英勇投掷\n"
			},
			{
				name = "防御援护",
				spellId = true,
				["spellName"] = "援护",
				["stance"] = {
					1,
					2,
					3
				},
				["target"] = true,
				["macro"] = "/cast 援护\n"
			},
			{
				name = "撕裂",
				spellId = true,
				["debuffNameCID2"] = true,
				["stance"] = {
					1,
					2
				},
				["target"] = true
			},
			{
				name = "狂暴撕裂",
				spellId = true,
				["spellName"] = "撕裂",
				["target"] = true,
				["macro"] = "/cast [nostance:1]战斗姿态\n/cast 撕裂\n"
			},
			{
				name = "碎裂投掷",
				spellId = true,
				["target"] = true,
				["macro"] = "/cast 碎裂投掷\n/cleartarget\n/targetlasttarget\n/startattack\n"
			},
			{
				name = "英勇投掷",
				spellId = true,
				["target"] = true,
				["macro"] = "/cast 英勇投掷\n/cleartarget\n/targetlasttarget\n/startattack\n"
			},
			{
				name = "雷霆一击",
				spellId = true,
				["stance"] = {
					1,
					2
				},
				["debuffNameCID"] = true
			},
			{
				name = "利刃风暴",
				spellId = true
			},
			{
				name = "断筋",
				spellId = true,
				["debuffNameCID"] = true,
				["stance"] = {
					1,
					3
				},
				["target"] = true,
				["attack"] = true
			},
			{
				name = "嘲讽",
				spellId = true,
				["stance"] = {
					2
				},
				["target"] = true
			},
			{
				name = "破甲攻击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "压制",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "防御姿态",
				spellId = true,
				["nostance"] = {
					2
				}
			},
			{
				name = "血性狂暴",
				spellId = true
			},
			{
				name = "盾击",
				spellId = true,
				["target"] = true
			},
			{
				name = "挫志怒吼",
				spellId = true,
				["debuffNameCID"] = true
			},
			{
				name = "命令怒吼",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "战斗怒吼",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "复仇",
				spellId = true,
				["stance"] = {
					2
				},
				["attack"] = true
			},
			{
				name = "盾牌格挡",
				spellId = true,
				["stance"] = {
					2
				},
				["attack"] = true
			},
			{
				name = "惩戒痛击",
				spellId = true,
				["stance"] = {
					1,
					2
				},
				["attack"] = true
			},
			{
				name = "缴械",
				spellId = true,
				["target"] = true,
				["stance"] = {
					2
				}
			},
			{
				name = "反击风暴",
				spellId = true,
				["stance"] = {
					1
				}
			},
			{
				name = "顺劈斩",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "破胆怒吼",
				spellId = true
			},
			{
				name = "斩杀",
				spellId = true,
				["target"] = true,
				["stance"] = {
					1,
					3
				},
				["attack"] = true
			},
			{
				name = "挑战怒吼",
				spellId = true
			},
			{
				name = "盾墙",
				spellId = true,
				["stance"] = {
					2
				}
			},
			{
				name = "猛击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 3
			},
			{
				name = "狂暴姿态",
				spellId = true,
				["nostance"] = {
					3
				}
			},
			{
				name = "狂暴之怒",
				spellId = true
			},
			{
				name = "旋风斩",
				spellId = true,
				["stance"] = {
					3
				},
				["attack"] = true,
				["sp"] = true,
				["ys"] = 3
			},
			{
				name = "拳击",
				spellId = true,
				["target"] = true,
				["stance"] = {
					3
				}
			},
			{
				name = "焦点拳击",
				spellId = true,
				["spellName"] = "拳击",
				["macro"] = "/cast [nostance:3]狂暴姿态\n/cast [target=focus,exists,nodead]拳击;拳击\n",
				["spellTime"] = 0.2,
				["desc"] = "焦点拳击打断"
			},
			{
				name = "焦点盾击",
				spellId = true,
				["spellName"] = "盾击",
				["macro"] = "/cast [nostance:2]防御姿态\n/cast [target=focus,exists,nodead]盾击;盾击\n",
				["spellTime"] = 0.2,
				["desc"] = "焦点盾击打断"
			},
			{
				name = "鲁莽",
				spellId = true,
				["stance"] = {
					3
				}
			},
			{
				name = "刺耳怒吼",
				spellId = true
			},
			{
				name = "破釜沉舟",
				spellId = true
			},
			{
				name = "横扫攻击",
				spellId = true,
				["stance"] = {
					1,
					3
				}
			},
			{
				name = "死亡之愿",
				spellId = true,
				["stance"] = {
					3
				}
			},
			{
				name = "震荡猛击",
				spellId = true
			},
			{
				name = "嗜血",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 3
			},
			{
				name = "致死打击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 3
			},
			{
				name = "盾牌猛击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "震荡波",
				spellId = true,
				["attack"] = true
			},
			{
				name = "毁灭打击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 3
			},
			{
				["name"] = "开始攻击",
				["macro"] = "/startattack\n",
				["spellName"] = "startattack",
				["spellTime"] = 0.2,
				["target"] = false,
				["desc"] = "startattack"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "狂暴战"
			AutoHelp.ModeDefaultSetting = {
				["HEAL_STATUS_START"] = true,
				["STATUS_主动攻击"] = true,
				["STATUS_治疗模式"] = false
			}
			AutoHelp.HEAL_MODES = {
				["武器战"] = {
					["modetip"] = "\124cffFFF569已设置为【武器战】。\124r"
				},
				["狂暴战"] = {
					["modetip"] = "\124cffFFF569已设置为【狂暴战】。\124r"
				},
				["防战"] = {
					["modetip"] = "\124cffFFF569已设置为【坦克模式】。\124r"
				}
			}
			AutoHelp.ModeList = {
				{
					text = "基本模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00狂暴战\124r",
					name = "狂暴战",
					tooltipTitle = "狂暴战",
					tooltipText = "狂暴战"
				},
				{
					text = "\124cff00ff00武器战\124r",
					name = "武器战",
					tooltipTitle = "武器战",
					tooltipText = "武器战。"
				},
				{
					text = "\124cffFFFFFF防战\124r",
					name = "防战",
					tooltipTitle = "防战",
					tooltipText = "防战"
				}
			}
			AutoHelp.PANELHEIGHT = 490;
			AutoHelp.PANELWIDTH = 160;
			local ki = AutoHelp.PANELHEIGHT or 490;
			local kj = AutoHelp.PANELWIDTH or 160;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00辅助功能设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "怒吼：",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_命令怒吼",
						["value"] = true,
						["title"] = "命令",
						["tip"] = "保持命令怒吼（战斗中）",
						["point"] = 60,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("命令怒吼") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							ti("命令怒吼", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_战斗怒吼",
						["value"] = false,
						["title"] = "战斗",
						["tip"] = "战斗中，保持目标战斗怒吼",
						["point"] = 110,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("战斗怒吼") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							ti("战斗怒吼", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_战斗怒吼",
						["value"] = true,
						["title"] = "战斗",
						["tip"] = "战斗中，保持目标战斗怒吼",
						["point"] = 60,
						["nextpos"] = false,
						["version"] = "classic",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("战斗怒吼") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							ti("战斗怒吼", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_AUTOINTERUPT",
						["value"] = true,
						["title"] = "自动打断",
						["tip"] = "使用脚踢技能, 自动打断当前目标/焦点目标, 设置里面可以设置打断读条比例, 缺省读条20%打断。如果需要补断, 比如将军可以设置70%补断。\n\n\124cff00ff00如果需要手动打断, 请不要勾选此项, 比如25人将军打断任务。",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_AUTOINTERUPT",
						["value"] = 20,
						["point"] = 100,
						["nextpos"] = false,
						["percent"] = "%"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_KEEPPOWER",
						["value"] = false,
						["title"] = "保留怒气",
						["tip"] = "使用技能之前至少保留怒气值，缺省是10点怒气(拳击打断怒气)，可根据经验自行调整。\n\n\124cff00ff00比如在奥杜尔将军战中，要始终保留用来打断的10怒气打断，勾选此项。",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_KEEPPOWER",
						["value"] = 10,
						["point"] = 100,
						["percent"] = "",
						["nextpos"] = false
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n\124cff00ff00此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。\124r",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动炸弹",
						["value"] = true,
						["title"] = "邪铁炸弹",
						["tip"] = "在技能中绑定[萨隆邪铁炸弹]/腰带钴质破片炸弹, 小怪使用腰带炸弹, 骷髅级别BOSS才卡CD使用萨隆邪铁炸弹, 请在背包保留足够的炸弹。\n\n\124cff00ff00萨隆邪铁炸弹只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 60,
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n\124cff00ff00此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。\124r",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "自动爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 60,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "classic",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["title"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果身边8码范围怪物数量大于等于2个，将自动启动顺劈群攻技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("顺劈斩") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_狂暴战_顺劈斩", true)
								SetConfig("STATUS_武器战_顺劈斩", true)
								SetConfig("STATUS_防战_顺劈斩", true)
								SetConfig("STATUS_防战_震荡波", true)
							else
								SetConfig("STATUS_狂暴战_顺劈斩", false)
								SetConfig("STATUS_武器战_顺劈斩", false)
								SetConfig("STATUS_防战_顺劈斩", false)
								SetConfig("STATUS_防战_震荡波", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_始终AOE",
						["value"] = false,
						["title"] = "始终AOE",
						["tip"] = "一直使用AOE技能进行攻击,比如在打左右手的时候始终使用顺劈和旋风斩技能。",
						["hitRect"] = - 30,
						["point"] = 80,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("顺劈斩") then
								ko:Disable()
							end
						end,
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_狂暴战_顺劈斩", true)
								SetConfig("STATUS_武器战_顺劈斩", true)
								SetConfig("STATUS_防战_顺劈斩", true)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					}
				},
				["setting"] = {}
			}
			local qQ = {
				{
					{
						"武器战_冲锋",
						"冲锋",
						true,
						"冲锋",
						"武器战"
					},
					{
						"武器战_拦截",
						"拦截",
						true,
						"拦截",
						"武器战"
					},
					{
						"武器战_撕裂",
						"撕裂",
						true,
						"撕裂",
						"武器战"
					},
					{
						"武器战_鲁莽",
						"鲁莽",
						true,
						"鲁莽",
						"武器战"
					},
					{
						"武器战_破甲攻击",
						"破甲攻击",
						true,
						"破甲攻击",
						"武器战"
					},
					{
						"武器战_英勇打击",
						"英勇打击",
						true,
						"英勇打击",
						"武器战"
					},
					{
						"武器战_横扫攻击",
						"横扫攻击",
						true,
						"横扫攻击",
						"武器战"
					},
					{
						"武器战_顺劈斩",
						"顺劈斩",
						true,
						"顺劈斩",
						"武器战"
					},
					{
						"武器战_压制",
						"压制",
						true,
						"压制",
						"武器战"
					},
					{
						"武器战_致死打击",
						"致死打击",
						true,
						"致死打击",
						"武器战"
					},
					{
						"武器战_猛击",
						"猛击",
						true,
						"猛击",
						"武器战"
					},
					{
						"武器战_斩杀",
						"斩杀",
						true,
						"斩杀",
						"武器战"
					},
					{
						"武器战_血性狂暴",
						"血性狂暴",
						true,
						"血性狂暴",
						"武器战"
					},
					{
						"武器战_碎裂投掷",
						"碎裂投掷",
						true,
						"碎裂投掷",
						"武器战"
					},
					{
						"武器战_雷霆一击",
						"雷霆一击",
						true,
						"雷霆一击",
						"武器战"
					},
					{
						"武器战_利刃风暴",
						"利刃风暴",
						true,
						"利刃风暴",
						"武器战"
					}
				},
				{
					{
						"狂暴战_冲锋",
						"冲锋",
						true,
						"冲锋",
						"狂暴战"
					},
					{
						"狂暴战_拦截",
						"拦截",
						true,
						"拦截",
						"狂暴战"
					},
					{
						"狂暴战_碎裂投掷",
						"碎裂投掷",
						true,
						"碎裂投掷",
						"狂暴战"
					},
					{
						"狂暴战_英勇投掷",
						"英勇投掷",
						true,
						"英勇投掷",
						"狂暴战"
					},
					{
						"狂暴战_死亡之愿",
						"死亡之愿",
						true,
						"死亡之愿",
						"狂暴战"
					},
					{
						"狂暴战_鲁莽",
						"鲁莽",
						true,
						"鲁莽",
						"狂暴战"
					},
					{
						"狂暴战_嗜血",
						"嗜血",
						true,
						"嗜血",
						"狂暴战"
					},
					{
						"狂暴战_旋风斩",
						"旋风斩",
						true,
						"旋风斩",
						"狂暴战"
					},
					{
						"狂暴战_破甲攻击",
						"破甲攻击",
						false,
						"破甲攻击",
						"狂暴战"
					},
					{
						"狂暴战_英勇打击",
						"英勇打击",
						true,
						"英勇打击",
						"狂暴战"
					},
					{
						"狂暴战_顺劈斩",
						"顺劈斩",
						true,
						"顺劈斩",
						"狂暴战"
					},
					{
						"狂暴战_猛击",
						"猛击",
						true,
						"猛击",
						"狂暴战"
					},
					{
						"狂暴战_斩杀",
						"斩杀",
						true,
						"斩杀",
						"狂暴战"
					},
					{
						"狂暴战_血性狂暴",
						"血性狂暴",
						true,
						"血性狂暴",
						"狂暴战"
					}
				},
				{
					{
						"防战_冲锋",
						"冲锋",
						false,
						"冲锋",
						"防战"
					},
					{
						"防战_拦截",
						"拦截",
						false,
						"拦截",
						"防战"
					},
					{
						"防战_破甲攻击",
						"破甲攻击",
						true,
						"破甲攻击",
						"防战"
					},
					{
						"防战_挫志怒吼",
						"挫志怒吼",
						true,
						"挫志怒吼",
						"防战"
					},
					{
						"防战_雷霆一击",
						"雷霆一击",
						true,
						"雷霆一击",
						"防战"
					},
					{
						"防战_震荡波",
						"震荡波",
						true,
						"震荡波",
						"防战"
					},
					{
						"防战_顺劈斩",
						"顺劈斩",
						true,
						"顺劈斩",
						"防战"
					},
					{
						"防战_英勇打击",
						"英勇打击",
						true,
						"英勇打击",
						"防战"
					},
					{
						"防战_血性狂暴",
						"血性狂暴",
						true,
						"血性狂暴",
						"防战"
					},
					{
						"防战_盾牌猛击",
						"盾牌猛击",
						true,
						"盾牌猛击",
						"防战"
					},
					{
						"防战_毁灭打击",
						"毁灭打击",
						true,
						"毁灭打击",
						"防战"
					},
					{
						"防战_复仇",
						"复仇",
						true,
						"复仇",
						"防战"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 2 == 1 then
							point = 5;
							kf = true
						else
							point = 80;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tip"] = qS[4],
							["point"] = point,
							["nextpos"] = kf,
							["stance"] = qS[5],
							["mode"] = qS[5]
						}
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if kH == nil then
				return
			end;
			if sJ ~= nil and sJ ~= kH and AutoHelp.playerLevel >= 55 then
				AutoHelp.Debug("\124cfff00000##错误的输出设置：您当前天赋为" .. sJ .. ",输出方式为" .. kH .. "!\124r")
			end;
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or bn.mode == "attack" then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			AutoHelp.ResizePanel()
		end;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") then
				return
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.RegisterBossEvent()
		end;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
		end;
		function AutoHelp.SPELL_AURA_APPLIED(tInfo, tk, nZ)
		end;
		function AutoHelp.SPELL_AURA_REMOVED(tInfo, tk, nZ)
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.HasActionKey("拳击") then
				FindOrCreateMacro("焦点打断", nil, "#showtooltips 拳击\n/cast [target=focus,exists,nodead]拳击;拳击\n", 1)
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52)
		end;
		function AutoHelp.SpellDamageAction(fm, aj, fu, ca, cx, amount)
		end;
		function AutoHelp.ThreatChanged(mt, sQ, sR, sS)
		end;
		function AutoHelp.EncounterStart(sT, sU, rx, sV)
		end;
		function AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
		end;
		function AutoHelp.ClassInit()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			if AutoHelp.playerLevel >= 60 then
				local tl, tm, tn = AutoHelp.HEAL_PLAYER_TALENTS[1] or 0, AutoHelp.HEAL_PLAYER_TALENTS[2] or 0, AutoHelp.HEAL_PLAYER_TALENTS[3] or 0;
				local kH = jy("HEALMODE")
				if tl > tm and tl > tn then
					sJ = "武器战"
					AutoHelp.talent = "武器战"
				end;
				if tm > tl and tm > tn then
					sJ = "狂暴战"
					AutoHelp.talent = "狂暴战"
				end;
				if tn > tl and tn > tm then
					sJ = "防战"
					AutoHelp.talent = "防战"
				end;
				if kH == nil then
					SetConfig("HEALMODE", sJ)
				end
			end;
			SetConfig("HEAL_STATUS_快速施法", false)
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
		end;
		function AutoHelp.DoUncombatAction(mH)
		end;
		function AutoHelp.DoCommonAction(mH)
		end;
		function AutoHelp.DoInterrupt(mH, b8, cd, to, tp, ca)
			local ib, iG = AutoHelp.GetRange(b8)
			if iG <= 2 and UnitPower("player") >= 10 then
				if b8 == "target" and AutoHelp.TryUseAction(AutoHelp.TargetInfo, "焦点拳击") then
					return true
				end;
				if b8 == "focus" and AutoHelp.TryUseAction(mH, "焦点拳击") then
					return true
				end
			end
		end;
		local rU;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, si = mH["hp"], UnitPower("player")
			local rm = targetInfo and targetInfo["hp"] <= 0.20;
			local sj = AutoHelp.castinfo.nextSwing;
			local ib, iG = AutoHelp.GetRange("target")
			local tq = GetShapeshiftForm()
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local sB = GetComboPoints("player", "target")
			local sw = GetStatus("STATUS_KEEPPOWER") and GetStatusNumber("VALUE_KEEPPOWER") or 0;
			if sw >= 50 then
				SetConfig("VALUE_KEEPPOWER", 10)
			end;
			local sq = AutoHelp.getNumberTargets()
			local function sy(jp)
				return si - sw - jp >= 0
			end;
			local function tr(cx)
				local ts = 0;
				sp = GetSpellPowerCost(cx) and GetSpellPowerCost(cx)[1]
				if sp then
					ts = sp.cost
				end;
				return si - sw - ts >= 0
			end;
			local function tt()
				local rV = GetStatus("HEAL_STATUS_AOE") and AutoHelp.getNumberTargets() >= 2 or GetStatus("STATUS_始终AOE")
				if rV then
					if GetStatus("STATUS_武器战_顺劈斩") and not sj and tr("顺劈斩") and AutoHelp.TryUseAction(targetInfo, "顺劈斩") then
						return true
					end;
					if GetStatus("STATUS_武器战_横扫攻击") and AutoHelp.TryUseAction(mH, "横扫攻击") then
						return true
					end
				else
					if GetStatus("STATUS_武器战_英勇打击") and si >= 30 and not sj and tr("英勇打击") and AutoHelp.TryUseAction(targetInfo, "英勇打击") then
						return true
					end
				end;
				if AutoHelp.InCooldown then
					return false
				end;
				if GetStatus("STATUS_武器战_冲锋") and ib >= 8 and iG <= 30 and AutoHelp.TryUseAction(targetInfo, "冲锋") then
					return true
				end;
				if GetStatus("STATUS_武器战_拦截") and ib >= 8 and iG <= 25 and si >= 10 then
					if tq ~= 3 and AutoHelp.TryUseAction(mH, "狂暴姿态") then
						return true
					end;
					if AutoHelp.TryUseAction(targetInfo, "拦截") then
						return true
					end
				end;
				if tq ~= 1 and AutoHelp.TryUseAction(mH, "战斗姿态") then
					return true
				end;
				if GetStatus("STATUS_武器战_碎裂投掷") and UnitLevel("target") == - 1 and AutoHelp.TryUseAction(targetInfo, "碎裂投掷") then
					return true
				end;
				if GetStatus("STATUS_武器战_撕裂") and AutoHelp.TryUseAction(targetInfo, "撕裂") then
					return true
				end;
				if GetStatus("STATUS_武器战_血性狂暴") and si <= 90 and AutoHelp.TryUseAction(mH, "血性狂暴") then
					return true
				end;
				if rV then
					if GetStatus("STATUS_武器战_利刃风暴") and iG <= 5 and AutoHelp.TryUseAction(mH, "利刃风暴") then
						return true
					end;
					if sq >= 3 and GetStatus("STATUS_武器战_雷霆一击") and iG <= 8 and AutoHelp.TryUseAction(targetInfo, "雷霆一击") then
						return true
					end;
					if GetStatus("STATUS_武器战_横扫攻击") and AutoHelp.TryUseAction(mH, "横扫攻击") then
						return true
					end;
					if GetStatus("STATUS_武器战_顺劈斩") and not sj and AutoHelp.TryUseAction(targetInfo, "顺劈斩") then
						return true
					end
				end;
				local lL = AutoHelp.GetDebuffRemainTime(targetInfo["unit"], "破甲攻击")
				local jS = AutoHelp.GetUnitDebuffNum(targetInfo["unit"], "破甲攻击")
				local tu = AutoHelp.UnitHasDebuff(targetInfo["unit"], "破甲")
				if GetStatus("STATUS_武器战_破甲攻击") and not tu then
					if (lL < 3 or jS < 5) and AutoHelp.TryUseAction(targetInfo, "破甲攻击") then
						return true
					end
				end;
				if GetStatus("STATUS_武器战_利刃风暴") and iG <= 5 and AutoHelp.TryUseAction(mH, "利刃风暴") then
					return true
				end;
				local tv = AutoHelp.UnitHasBuff("player", 68051) or IsUsableSpell("压制")
				if GetStatus("STATUS_武器战_压制") and tv and sy(5) and AutoHelp.TryUseAction(targetInfo, "压制") then
					return true
				end;
				local tw = AutoHelp.UnitHasBuff("player", 52437) or rm;
				if GetStatus("STATUS_武器战_斩杀") and tw and si >= 40 and sy(30) and AutoHelp.TryUseAction(targetInfo, "斩杀") then
					return true
				end;
				if GetStatus("STATUS_武器战_致死打击") and tr("致死打击") and AutoHelp.TryUseAction(targetInfo, "致死打击") then
					return true
				end;
				if GetStatus("STATUS_武器战_英勇打击") and si >= 60 and not sj and tr("英勇打击") and AutoHelp.TryUseAction(targetInfo, "英勇打击") then
					return true
				end;
				if GetStatus("STATUS_武器战_猛击") and si >= 50 and tr("猛击") and AutoHelp.TryUseAction(targetInfo, "猛击") then
					return true
				end;
				local tx = GetStatus("STATUS_武器战_破甲攻击") and not tu and jS < 5;
				if GetStatus("STATUS_武器战_鲁莽") and not tx and rn and AutoHelp.TryUseAction(targetInfo, "鲁莽") then
					return true
				end
			end;
			local function ty()
				local rV = GetStatus("HEAL_STATUS_AOE") and AutoHelp.getNumberTargets() >= 2 or GetStatus("STATUS_始终AOE")
				if rV then
					if GetStatus("STATUS_狂暴战_顺劈斩") and not sj and tr("顺劈斩") and AutoHelp.TryUseAction(targetInfo, "顺劈斩") then
						return true
					end
				else
					if GetStatus("STATUS_狂暴战_英勇打击") and not sj and sy(30) and AutoHelp.TryUseAction(targetInfo, "英勇打击") then
						return true
					end
				end;
				if AutoHelp.InCooldown then
					return false
				end;
				if GetStatus("STATUS_狂暴战_冲锋") and not InCombatLockdown() and ib >= 8 and iG <= 25 then
					if tq ~= 1 and AutoHelp.TryUseAction(mH, "战斗姿态") then
						return true
					end;
					if AutoHelp.TryUseAction(targetInfo, "冲锋") then
						return true
					end
				end;
				if tq ~= 3 and AutoHelp.TryUseAction(mH, "狂暴姿态") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_拦截") and ib >= 8 and iG <= 25 and AutoHelp.TryUseAction(targetInfo, "拦截") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_血性狂暴") and si <= 90 and iG <= 20 and AutoHelp.TryUseAction(mH, "血性狂暴") then
					return true
				end;
				local lL = AutoHelp.GetDebuffRemainTime(targetInfo["unit"], "破甲攻击")
				local jS = AutoHelp.GetUnitDebuffNum(targetInfo["unit"], "破甲攻击")
				local tu = AutoHelp.UnitHasDebuff(targetInfo["unit"], "破甲")
				if GetStatus("STATUS_狂暴战_破甲攻击") and not tu and UnitLevel("target") == - 1 then
					if (lL <= 3 or jS < 5) and AutoHelp.TryUseAction(targetInfo, "破甲攻击") then
						return true
					end
				end;
				local tx = GetStatus("STATUS_狂暴战_破甲攻击") and not tu and UnitLevel("target") == - 1 and jS < 5;
				if GetStatus("STATUS_狂暴战_死亡之愿") and not tx and rn and AutoHelp.TryUseAction(targetInfo, "死亡之愿") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_鲁莽") and not tx and rn and mM and AutoHelp.TryUseAction(targetInfo, "鲁莽") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_碎裂投掷") and tr("碎裂投掷") and not tx and UnitLevel("target") == - 1 and AutoHelp.TryUseAction(targetInfo, "碎裂投掷") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_旋风斩") and rV and tr("旋风斩") and iG <= 8 and AutoHelp.TryUseAction(mH, "旋风斩") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_嗜血") and tr("嗜血") and AutoHelp.TryUseAction(targetInfo, "嗜血") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_旋风斩") and si >= sw and tr("旋风斩") and iG <= 8 and AutoHelp.TryUseAction(mH, "旋风斩") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_猛击") and si >= sw and AutoHelp.UnitHasBuff("player", 46916) and tr("猛击") and AutoHelp.TryUseAction(targetInfo, "猛击") then
					return true
				end;
				if GetStatus("STATUS_狂暴战_斩杀") and rm and si >= sw and sy(30) and AutoHelp.TryUseAction(targetInfo, "斩杀") then
					return true
				end;
				local tz = GetCombatValue("tz") or 0;
				if GetStatus("STATUS_狂暴战_英勇投掷") and tz == 0 and AutoHelp.TryUseAction(targetInfo, "英勇投掷") then
					SetCombatValue("tz", 1)
					return true
				end
			end;
			local function tA()
				local rV = GetStatus("HEAL_STATUS_AOE") and sq >= 2 or GetStatus("STATUS_始终AOE")
				if AutoHelp.InCooldown then
					if rV then
						if GetStatus("STATUS_防战_顺劈斩") and not sj and sy(30) and AutoHelp.TryUseAction(targetInfo, "顺劈斩") then
							return true
						end
					else
						if GetStatus("STATUS_防战_英勇打击") and not sj and sy(30) and AutoHelp.TryUseAction(targetInfo, "英勇打击") then
							return true
						end
					end;
					return false
				end;
				if tq ~= 2 and AutoHelp.TryUseAction(mH, "防御姿态") then
					return true
				end;
				if GetStatus("STATUS_防战_冲锋") and ib >= 8 and iG <= 25 then
					if AutoHelp.TryUseAction(targetInfo, "防御冲锋") then
						return true
					end
				end;
				if GetStatus("STATUS_防战_拦截") and ib >= 8 and iG <= 25 then
					if AutoHelp.TryUseAction(targetInfo, "防御拦截") then
						return true
					end
				end;
				if GetStatus("STATUS_防战_血性狂暴") and si <= 90 and iG <= 20 and AutoHelp.TryUseAction(mH, "血性狂暴") then
					return true
				end;
				local lL = AutoHelp.GetDebuffRemainTime(targetInfo["unit"], "挫志怒吼")
				if GetStatus("STATUS_防战_挫志怒吼") and lL <= 3 and tr("挫志怒吼") and iG <= 10 and AutoHelp.TryUseAction(mH, "挫志怒吼") then
					return true
				end;
				if rV then
					if GetStatus("STATUS_防战_顺劈斩") and not sj and tr("顺劈斩") and AutoHelp.TryUseAction(targetInfo, "顺劈斩") then
						return true
					end;
					if GetStatus("STATUS_防战_震荡波") and tr("震荡波") and iG <= 8 and AutoHelp.TryUseAction(mH, "震荡波") then
						return true
					end;
					if GetStatus("STATUS_防战_雷霆一击") and tr("雷霆一击") and iG <= 8 and AutoHelp.TryUseAction(mH, "雷霆一击") then
						return true
					end
				end;
				local lL = AutoHelp.GetDebuffRemainTime(targetInfo["unit"], "破甲攻击")
				local jS = AutoHelp.GetUnitDebuffNum(targetInfo["unit"], "破甲攻击")
				local tu = AutoHelp.UnitHasDebuff(targetInfo["unit"], "破甲")
				if AutoHelp.HasActionKey("毁灭打击") then
					if GetStatus("STATUS_防战_毁灭打击") and (lL <= 3 or jS < 5) and tr("毁灭打击") and AutoHelp.TryUseAction(targetInfo, "毁灭打击") then
						return true
					end
				else
					if GetStatus("STATUS_防战_破甲攻击") and not tu then
						if (lL <= 3 or jS < 5) and AutoHelp.TryUseAction(targetInfo, "破甲攻击") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_防战_盾牌猛击") and (AutoHelp.UnitHasBuff("player", 50227) or tr("盾牌猛击")) and AutoHelp.TryUseAction(targetInfo, "盾牌猛击") then
					return true
				end;
				if GetStatus("STATUS_防战_复仇") and tr("复仇") and AutoHelp.TryUseAction(targetInfo, "复仇") then
					return true
				end;
				local lL = AutoHelp.GetDebuffRemainTime(targetInfo["unit"], "雷霆一击")
				if GetStatus("STATUS_防战_雷霆一击") and lL <= 3 and tr("雷霆一击") and iG <= 8 and AutoHelp.TryUseAction(mH, "雷霆一击") then
					return true
				end;
				if GetStatus("STATUS_防战_毁灭打击") and tr("毁灭打击") and AutoHelp.TryUseAction(targetInfo, "毁灭打击") then
					return true
				end
			end;
			local tB = tj()
			if tB and si >= 10 and AutoHelp.TryUseAction(mH, tB) then
				return true
			end;
			if jy("HEALMODE") == "武器战" then
				if tt() then
					return true
				end
			end;
			if jy("HEALMODE") == "狂暴战" then
				if ty() then
					return true
				end
			end;
			if jy("HEALMODE") == "防战" then
				if tA() then
					return true
				end
			end;
			if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
				return true
			end
		end
	end;
	if PlayerIsClass("WARRIOR") then
		AutoHelp.ClassConfig = th
	end
end;
if AutoHelp.isWotlk then
	local function tC()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		ahenv["影袭"] = GetSpellInfo(1752)
		AutoHelp.INTERRUPT_SPELLNAMES = {}
		AutoHelp.CAN_RESCURIT = false;
		AutoHelp.CAN_HEAL = false;
		AutoHelp.CAN_BUFF = false;
		AutoHelp.CAN_DISPEL = false;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 15;
		AutoHelp.AttackType = 1;
		AutoHelp.AttackRange = 2;
		AutoHelp.CommingHealWindow = 0;
		local sJ = "战斗贼"
		local n9 = {
			{
				name = ahenv["影袭"],
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "刺骨",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "毁伤",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "出血",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "毒伤",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "血之饥渴",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "锁喉",
				spellId = true,
				["target"] = true,
				["debuffNameCID"] = true
			},
			{
				name = "刀扇",
				spellId = true,
				["attack"] = true,
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "杀戮盛筵",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true
			},
			{
				name = "嫁祸诀窍",
				spellId = true,
				["target"] = true,
				["auraNameCID"] = true
			},
			{
				name = "取消嫁祸",
				["macro"] = "/cancelaura [nostealth,combat]嫁祸诀窍\n",
				["spellTime"] = 0.2,
				["desc"] = "取消嫁祸"
			},
			{
				name = "潜行",
				spellId = true
			},
			{
				name = "搜索",
				spellId = true
			},
			{
				name = "背刺",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["useError"] = true,
				["spellTime"] = 0.4
			},
			{
				name = "凿击",
				spellId = true,
				["target"] = true
			},
			{
				name = "闪避",
				spellId = true
			},
			{
				name = "疾跑",
				spellId = true
			},
			{
				name = "闷棍",
				spellId = true,
				["target"] = true
			},
			{
				name = "切割",
				spellId = true
			},
			{
				name = "脚踢",
				spellId = true,
				["target"] = true
			},
			{
				name = "焦点打断",
				spellId = true,
				["spellName"] = "脚踢",
				["macro"] = "/cast [target=focus,exists,nodead]脚踢;脚踢\n",
				["spellTime"] = 0.5,
				["desc"] = "焦点脚踢打断"
			},
			{
				name = "破甲",
				spellId = true,
				["attack"] = true,
				["target"] = true,
				["debuffNameCID"] = true,
				["debuffRT"] = 2
			},
			{
				name = "绞喉",
				spellId = true,
				["attack"] = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "佯攻",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "伏击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "主手上毒",
				spellId = 43231,
				["auraName"] = "速效药膏",
				["macro"] = "/cast 速效药膏\n/cast 16\n"
			},
			{
				name = "割裂",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["attack"] = true
			},
			{
				name = "消失",
				spellId = true
			},
			{
				name = "偷袭",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "肾击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "致盲",
				spellId = true,
				["target"] = true
			},
			{
				name = "还击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "鬼魅攻击",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "冷血",
				spellId = true
			},
			{
				name = "伺机待发",
				spellId = true
			},
			{
				name = "出血",
				spellId = true,
				["target"] = true,
				["attack"] = true
			},
			{
				name = "冲动",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "剑刃乱舞",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				["name"] = "开始攻击",
				["macro"] = "/startattack\n",
				["spellName"] = "startattack",
				["spellTime"] = 0.2,
				["target"] = false,
				["desc"] = "startattack"
			},
			{
				name = "预谋",
				spellId = true
			},
			{
				name = "暗影斗篷",
				spellId = true
			},
			{
				["name"] = "选中镜像",
				["macro"] = "/targetexact 裹体之网\n/targetexact 镜像\n/cast [exists]投掷\n",
				["spellName"] = "选中镜像",
				["spellTime"] = 1,
				["desc"] = "选中镜像"
			},
			{
				["name"] = "武器上毒",
				["macro"] = "/use [@none] 致命药膏\n/use 16\n/click StaticPopup1Button1\n",
				["spellTime"] = 5,
				["desc"] = "武器上毒"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			if AutoHelp.isWotlk then
				AutoHelp.DefaultMode = "刺杀贼"
			else
				AutoHelp.DefaultMode = "战斗贼"
			end;
			AutoHelp.ModeDefaultSetting = {
				["HEAL_STATUS_START"] = true,
				["STATUS_主动攻击"] = true,
				["STATUS_治疗模式"] = false
			}
			AutoHelp.HEAL_MODES = {
				["刺杀贼"] = {
					["modetip"] = "\124cffFFF569已设置为系统缺省【刺杀贼】。\124r"
				},
				["战斗贼"] = {
					["modetip"] = "\124cffFFF569已设置为【战斗贼】。\124r"
				},
				["敏锐贼"] = {
					["modetip"] = "\124cffFFF569已设置为【敏锐贼】。\124r"
				}
			}
			AutoHelp.ModeList = {
				{
					text = "输出模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00刺杀贼\124r",
					name = "刺杀贼",
					tooltipTitle = "刺杀贼",
					tooltipText = "使用刺杀天赋。"
				},
				{
					text = "\124cff00ff00战斗贼\124r",
					name = "战斗贼",
					tooltipTitle = "战斗贼",
					tooltipText = "使用战斗天赋"
				},
				{
					text = "\124cffFFFFFF敏锐贼\124r",
					name = "敏锐贼",
					tooltipTitle = "敏锐贼",
					tooltipText = "使用敏锐天赋"
				}
			}
			AutoHelp.PANELHEIGHT = 490;
			AutoHelp.PANELWIDTH = 160;
			local ki = AutoHelp.PANELHEIGHT or 490;
			local kj = AutoHelp.PANELWIDTH or 160;
			AutoHelp.POSION_SPELLS = {}
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00辅助功能设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_嫁祸诀窍",
						["value"] = true,
						["title"] = "嫁祸",
						["tip"] = "\124cff00ff00自动嫁祸给队友，一般自动选择坦克。\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("嫁祸诀窍") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_嫁祸诀窍",
						["title"] = "选择嫁祸目标",
						["tipTitle"] = "嫁祸队友选择",
						["tip"] = "\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动嫁祸\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(kl)
							local cd = jy("嫁祸诀窍")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo == nil and jy("嫁祸诀窍") == "无" then
								AutoHelp.Debug("要设置道标目标请先选择队友！")
								return
							end;
							if tInfo ~= nil then
								SetConfig("嫁祸诀窍", tInfo["name"])
								AutoHelp.Debug("设置嫁祸诀窍目标：" .. tInfo["name"])
							else
								SetConfig("嫁祸诀窍", "无")
								AutoHelp.Debug("清除嫁祸诀窍目标。")
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主手毒药",
						["value"] = true,
						["title"] = "主手",
						["tip"] = "\124cff00ff00保持给主手武器上毒药，失效会自动补上\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_BUTTON_主手毒药",
						["title"] = "选择主手毒药",
						["tipTitle"] = "毒药选择",
						["tip"] = "自动为主手武器上毒, 一般刺杀/战斗主手上致命毒药. \n\n\124cff00ff00设置给主手武器上的毒药，消失将自动补上\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["create"] = function(kl)
							local kp = jy("主手毒药")
							if kp then
								kl:SetText(kp)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupItemListMenu("选择毒药", "HEAL_STATUS_主手毒药", "主手毒药", kl, AutoHelp.POSION_SPELLS, jy("主手毒药"))
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_副手毒药",
						["value"] = true,
						["title"] = "副手",
						["tip"] = "自动为副手武器上毒, 一般刺杀/战斗主手上速效毒药. \124cff00ff00保持给副手武器上毒药，失效会自动补上\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_BUTTON_副手毒药",
						["title"] = "选择副手毒药",
						["tipTitle"] = "毒药选择",
						["tip"] = "\n\n\124cff00ff00设置给副手武器上的毒药，消失将自动补上\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["create"] = function(kl)
							local kp = jy("副手毒药")
							if kp then
								kl:SetText(kp)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupItemListMenu("选择毒药", "HEAL_STATUS_副手毒药", "副手毒药", kl, AutoHelp.POSION_SPELLS, jy("副手毒药"))
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_AUTOINTERUPT",
						["value"] = true,
						["title"] = "自动打断",
						["tip"] = "使用脚踢技能, 自动打断当前目标/焦点目标,设置里面可以设置打断读条比例, 缺省读条20%打断。如果需要补断, 比如将军可以设置70%补断。\n\n\124cff00ff00如果需要手动打断, 请不要勾选此项, 比如25人将军打断任务。",
						["point"] = 5,
						["hitRect"] = - 50,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_AUTOINTERUPT",
						["value"] = 20,
						["point"] = 100,
						["nextpos"] = false,
						["percent"] = "%"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_KEEPPOWER",
						["value"] = false,
						["title"] = "保留能量",
						["tip"] = "使用技能之前至少保留能量值，缺省是25点能量，可根据经验自行调整。\n\n\124cff00ff00比如在奥杜尔将军战中，要始终保留用来打断的25能量，勾选此项。",
						["point"] = 5,
						["hitRect"] = - 50,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_KEEPPOWER",
						["value"] = 25,
						["point"] = 100,
						["percent"] = "",
						["nextpos"] = false
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n\124cff00ff00此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。\124r",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动炸弹",
						["value"] = true,
						["title"] = "邪铁炸弹",
						["tip"] = "在技能中绑定[萨隆邪铁炸弹]/腰带钴质破片炸弹, 小怪使用腰带炸弹, 骷髅级别BOSS才卡CD使用萨隆邪铁炸弹, 请在背包保留足够的炸弹。\n\n\124cff00ff00萨隆邪铁炸弹只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 60,
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["create"] = function(ko)
							if UnitLevel("player") <= 75 then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n\124cff00ff00此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。\124r",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "自动爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "classic",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["title"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果身边8码范围怪物数量大于等于3个，将自动启动刀扇技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("刀扇") then
								ko:Disable()
							end
						end,
						["version"] = "wlk",
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_战斗贼_刀扇", true)
								SetConfig("STATUS_刺杀贼_刀扇", true)
							else
								SetConfig("STATUS_战斗贼_刀扇", false)
								SetConfig("STATUS_刺杀贼_刀扇", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_取消嫁祸仇恨",
						["value"] = true,
						["title"] = "取消仇恨",
						["tipTitle"] = "取消嫁祸仇恨转移",
						["tip"] = "对目标嫁祸诀窍时，第一时间取消仇恨转移buff，不会让被嫁祸目标增加仇恨，如果对T使用嫁祸诀窍，不要勾选此选项。\n\n系统会根据嫁祸对象是否为TANK判定一次，如果是坦克不取消嫁祸仇恨转移。",
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("嫁祸诀窍") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "JUDGE_TIP5",
						["value"] = "\124cff00ff00攻击设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动佯攻",
						["value"] = true,
						["title"] = "自动佯攻",
						["tip"] = "当对BOSS仇恨高于设定值时，自动使用佯攻消除仇恨，缺省设置仇恨高于90%时使用",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_仇恨值",
						["value"] = 90,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_补毒药",
						["value"] = true,
						["title"] = "补毒药时间",
						["tip"] = "在脱战时，根据毒药剩余时间自动补毒药，以免boss战斗忘记毒药，缺省是5分钟，打团本可以改成10分钟。",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_毒药时间",
						["value"] = 5,
						["point"] = 100,
						["percent"] = "分",
						["nextpos"] = false
					}
				}
			}
			local qQ = {
				{
					{
						"战斗贼_疾跑",
						"疾跑",
						true,
						"疾跑",
						"战斗贼"
					},
					{
						"战斗贼_切割",
						"切割",
						true,
						"切割",
						"战斗贼"
					},
					{
						"战斗贼_破甲",
						"破甲",
						true,
						"破甲",
						"战斗贼"
					},
					{
						"战斗贼_刺骨",
						"刺骨",
						true,
						"刺骨",
						"战斗贼"
					},
					{
						"战斗贼_锁喉",
						"锁喉",
						true,
						"锁喉",
						"战斗贼"
					},
					{
						"战斗贼_割裂",
						"割裂",
						true,
						"割裂",
						"战斗贼"
					},
					{
						"战斗贼_冲动",
						"冲动",
						true,
						"冲动",
						"战斗贼"
					},
					{
						"战斗贼_剑刃乱舞",
						"剑刃乱舞",
						true,
						"剑刃乱舞",
						"战斗贼"
					},
					{
						"战斗贼_杀戮盛筵",
						"杀戮盛筵",
						true,
						"杀戮盛筵",
						"战斗贼"
					},
					{
						"战斗贼_影袭",
						ahenv["影袭"],
						true,
						ahenv["影袭"],
						"战斗贼"
					},
					{
						"战斗贼_刀扇",
						"刀扇",
						true,
						"刀扇",
						"战斗贼"
					}
				},
				{
					{
						"刺杀贼_疾跑",
						"疾跑",
						true,
						"疾跑",
						"刺杀贼"
					},
					{
						"刺杀贼_切割",
						"切割",
						true,
						"切割",
						"刺杀贼"
					},
					{
						"刺杀贼_锁喉",
						"锁喉",
						true,
						"锁喉",
						"刺杀贼"
					},
					{
						"刺杀贼_血之饥渴",
						"血之饥渴",
						true,
						"血之饥渴",
						"刺杀贼"
					},
					{
						"刺杀贼_破甲",
						"破甲",
						false,
						"破甲",
						"刺杀贼"
					},
					{
						"刺杀贼_割裂",
						"割裂",
						false,
						"割裂",
						"刺杀贼"
					},
					{
						"刺杀贼_毁伤",
						"毁伤",
						true,
						"毁伤",
						"刺杀贼"
					},
					{
						"刺杀贼_毒伤",
						"毒伤",
						true,
						"毒伤",
						"刺杀贼"
					},
					{
						"刺杀贼_刀扇",
						"刀扇",
						true,
						"刀扇",
						"刺杀贼"
					}
				},
				{
					{
						"敏锐贼_切割",
						"切割",
						false,
						"敏锐贼现在不支持!!",
						"敏锐贼"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 2 == 1 then
							point = 5;
							kf = true
						else
							point = 80;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tip"] = qS[4],
							["point"] = point,
							["nextpos"] = kf,
							["mode"] = qS[5]
						}
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], eS)
						jS = jS + 1
					end
				end
			end
		end;
		local tD = GetItemInfo(43231)
		local tE = GetItemInfo(43233)
		function AutoHelp.ModeChanged(kH)
			if kH == nil then
				return
			end;
			if sJ ~= nil and sJ ~= kH and AutoHelp.playerLevel >= 55 then
				AutoHelp.Debug("\124cfff00000##错误的输出设置：您当前天赋为" .. sJ .. ",输出方式为" .. kH .. "!\124r")
			end;
			if kH == "刺杀贼" then
				SetConfig("主手毒药", tE)
				AutoHelp.SettingItems["HEAL_STATUS_BUTTON_主手毒药"]:SetText(tE)
				SetConfig("副手毒药", tD)
				AutoHelp.SettingItems["HEAL_STATUS_BUTTON_副手毒药"]:SetText(tD)
			end;
			if kH == "战斗贼" then
				SetConfig("主手毒药", tD)
				AutoHelp.SettingItems["HEAL_STATUS_BUTTON_主手毒药"]:SetText(tD)
				SetConfig("副手毒药", tE)
				AutoHelp.SettingItems["HEAL_STATUS_BUTTON_副手毒药"]:SetText(tE)
				if GetTalentSpent("强化刺骨") > 0 then
					SetConfig("STATUS_战斗贼_割裂", false)
					SetConfig("STATUS_战斗贼_刺骨", true)
				end;
				if GetTalentSpent("鲜血飞溅") > 0 then
					SetConfig("STATUS_战斗贼_割裂", true)
					SetConfig("STATUS_战斗贼_刺骨", true)
				end
			end;
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or bn.mode == "attack" then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			AutoHelp.ResizePanel()
		end;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") then
				return
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.RegisterBossEvent()
		end;
		local tF;
		function AutoHelp.SPELL_AURA_APPLIED(tInfo, tk, nZ)
			if tInfo and tInfo["unit"] == "player" and tk == 59628 then
				if GetStatus("HEAL_STATUS_取消嫁祸仇恨") and tF and tF["role"] ~= "MAINTANK" then
					tF = nil;
					AutoHelp.AddNextAction(tInfo, "取消嫁祸", 0)
					AutoHelp.Debug(">>取消嫁祸诀窍仇恨转移！")
				end
			end
		end;
		function AutoHelp.SPELL_AURA_REMOVED(tInfo, tk, nZ)
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.HasActionKey("脚踢") then
				FindOrCreateMacro("焦点打断", nil, "#showtooltips 脚踢\n/cast [target=focus,exists,nodead]脚踢;脚踢\n", 53)
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51, true)
			if AutoHelp.isWotlk then
				FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52, true)
			end
		end;
		function AutoHelp.SpellDamageAction(fm, aj, fu, ca, cx, amount)
		end;
		function AutoHelp.ThreatChanged(mt, sQ, sR, sS)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_自动佯攻") then
				return
			end;
			local jp = GetStatusNumber("HEAL_VALUE_仇恨值") or 90;
			if mt >= 2 then
				if GetStatus("HEAL_STATUS_自动佯攻") then
					AutoHelp.AddCastAction("佯攻")
					AutoHelp.Debug(">>>>你OT了，自动佯攻！")
				else
					AutoHelp.Debug(">>>>你OT了，请使用佯攻技能消除仇恨！")
				end
			end;
			if mt == 1 and sQ >= jp then
				if GetStatus("HEAL_STATUS_自动佯攻") then
					AutoHelp.AddCastAction("佯攻")
					AutoHelp.Debug(">>>>仇恨过高:" .. sQ .. "%，自动佯攻！")
				else
					AutoHelp.Debug(">>>>仇恨过高:" .. sQ .. "%，请使用佯攻技能消除仇恨！")
				end
			end
		end;
		function AutoHelp.EncounterStart(sT, sU, rx, sV)
		end;
		function AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
		end;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("嫁祸诀窍", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_BUTTON_嫁祸诀窍"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			local tG = {
				{
					43231,
					43230,
					21927,
					8928,
					8927,
					8926,
					6950,
					6949,
					6947
				},
				{
					43233,
					43232,
					22054,
					22053,
					20844,
					8985,
					8984,
					2893,
					2892
				},
				{
					43235,
					43234,
					22055,
					10922,
					10921,
					10920,
					10918,
					2893,
					2892
				},
				{
					43237,
					21835
				},
				{
					3775
				},
				{
					5237
				}
			}
			for i, tH in ipairs(tG) do
				for _, bi in ipairs(tH) do
					local me, itemLink, mf, mg, mh, mi, mj, mk, o7, o8, o9 = GetItemInfo(bi)
					if me and AutoHelp.playerLevel >= mh then
						AutoHelp.POSION_SPELLS[# AutoHelp.POSION_SPELLS + 1] = me;
						if i == 1 then
							tD = me
						end;
						if i == 2 then
							tE = me
						end;
						break
					end
				end
			end;
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			if AutoHelp.playerLevel >= 10 then
				local tI, tJ, tK = AutoHelp.HEAL_PLAYER_TALENTS[1] or 0, AutoHelp.HEAL_PLAYER_TALENTS[2] or 0, AutoHelp.HEAL_PLAYER_TALENTS[3] or 0;
				local kH = jy("HEALMODE")
				if tI > tJ and tI > tK then
					sJ = "刺杀贼"
				end;
				if tJ > tI and tJ > tK then
					sJ = "战斗贼"
				end;
				if tK > tI and tK > tJ then
					sJ = "敏锐贼"
				end;
				if kH == nil then
					SetConfig("HEALMODE", sJ, true)
				end
			end;
			SetConfig("HEAL_STATUS_快速施法", false)
		end;
		function AutoHelp.ClassLoaded()
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
		end;
		local tL = 0;
		local tM = 0;
		function AutoHelp.DoUncombatAction(mH)
			local tN, tO = jy("主手毒药"), jy("副手毒药")
			local tP, tQ, _, tR, tS, tT, _, tU = GetWeaponEnchantInfo()
			local lL = GetStatus("HEAL_STATUS_补毒药") and GetStatusNumber("HEAL_VALUE_毒药时间") or 5;
			if GetStatus("HEAL_STATUS_主手毒药") and tN ~= nil and tN ~= "无" and GetTime() - tL > 8 then
				if AutoHelp.GetItemCount(tN) > 0 then
					if not tP or tQ <= lL * 60 * 1000 then
						local lh, action = AutoHelp.GetActionKey("武器上毒")
						action["macro"] = "/use [@none] " .. tN .. "\n/use 16\n/click StaticPopup1Button1\n"
						AutoHelp.RefreshAction(action)
						if AutoHelp.TryUseAction(mH, "武器上毒") then
							tL = GetTime()
							return true
						end
					end
				end
			end;
			if GetStatus("HEAL_STATUS_副手毒药") and tO ~= nil and tO ~= "无" and GetTime() - tM > 8 then
				if AutoHelp.GetItemCount(tO) > 0 then
					if not tS or tT <= lL * 60 * 1000 then
						local lh, action = AutoHelp.GetActionKey("武器上毒")
						action["macro"] = "/use [@none] " .. tO .. "\n/use 17\n/click StaticPopup1Button1\n"
						AutoHelp.RefreshAction(action)
						if AutoHelp.TryUseAction(mH, "武器上毒") then
							tM = GetTime()
							return true
						end
					end
				end
			end;
			return false
		end;
		function AutoHelp.DoInterrupt(mH, b8, cd, to, tp, ca)
			local ib, iG = AutoHelp.GetRange(b8)
			if iG <= 2 and UnitPower("player") >= 25 then
				if b8 == "target" and AutoHelp.TryUseAction(AutoHelp.TargetInfo, "脚踢") then
					return true
				end;
				if b8 == "focus" and AutoHelp.TryUseAction(mH, "焦点打断") then
					return true
				end
			end
		end;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, si = mH["hp"], UnitPower("player")
			local ib, iG = AutoHelp.GetRange("target")
			local sB = GetComboPoints("player", "target")
			local sw = GetStatus("STATUS_KEEPPOWER") and GetStatusNumber("VALUE_KEEPPOWER") or 0;
			if sw >= 50 then
				SetConfig("VALUE_KEEPPOWER", 25)
			end;
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local function tV(cx)
				local ts = 0;
				local sp = GetSpellPowerCost(cx) and GetSpellPowerCost(cx)[1]
				if sp then
					ts = sp.cost
				end;
				return si - sw - ts >= 0
			end;
			local function sy(jp)
				return si - sw - jp >= 0
			end;
			local function tW()
				if GetStatus("HEAL_STATUS_嫁祸诀窍") and sy(15) then
					local s8 = HEAL_RAID_NAMES[jy("嫁祸诀窍")]
					if s8 then
						local tInfo = HEAL_RAID[s8]
						local oE, oF = AutoHelp.GetRange(tInfo["unit"])
						if oF ~= nil then
							if tInfo and oF <= 20 and AutoHelp.TryUseAction(tInfo, "嫁祸诀窍") then
								tF = tInfo;
								return true
							end
						end
					end
				end;
				if GetStatus("STATUS_刺杀贼_疾跑") and GetStatus("STATUS_目标互动") then
					if AutoHelp.IsMoving and iG >= 20 then
						if AutoHelp.TryUseAction(mH, "疾跑") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_刺杀贼_锁喉") and IsStealthed() and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "锁喉") then
					return true
				end;
				if not AutoHelp.UnitHasBuff("player", "血之饥渴") then
					if not IsUsableSpell("血之饥渴") then
						if sB >= 1 and tV("割裂") and AutoHelp.TryUseAction(targetInfo, "割裂") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_刺杀贼_血之饥渴") and tV("血之饥渴") and IsUsableSpell("血之饥渴") and not AutoHelp.UnitHasBuff("player", "血之饥渴") and AutoHelp.TryUseAction(targetInfo, "血之饥渴") then
					return true
				end;
				if GetStatus("HEAL_STATUS_AOE") and GetStatus("STATUS_刺杀贼_刀扇") and iG <= 8 then
					local sq = AutoHelp.getNumberTargets()
					if sq >= 3 then
						if sy(50) and AutoHelp.TryUseAction(mH, "刀扇") then
							return true
						end
					end
				end;
				local tX = AutoHelp.GetBuffRemainTime("player", GetSpellInfo(6774))
				if GetStatus("STATUS_刺杀贼_切割") and tX <= 2 and sB > 0 and tV("切割") and AutoHelp.TryUseAction(mH, "切割") then
					return true
				end;
				if GetStatus("STATUS_刺杀贼_破甲") and sB >= 1 and (UnitLevel("target") == - 1 or UnitLevel("target") >= 81) and AutoHelp.TryUseAction(targetInfo, "破甲") then
					return true
				end;
				if GetStatus("STATUS_刺杀贼_毒伤") and sB >= 3 and si >= 80 and AutoHelp.TryUseAction(targetInfo, "毒伤") then
					return true
				end;
				if GetStatus("STATUS_刺杀贼_毁伤") and sB < 3 and tV("毁伤") and AutoHelp.TryUseAction(targetInfo, "毁伤") then
					return true
				end
			end;
			local function tY()
				if GetStatus("HEAL_STATUS_嫁祸诀窍") and sy(15) then
					local s8 = HEAL_RAID_NAMES[jy("嫁祸诀窍")]
					if s8 then
						local tInfo = HEAL_RAID[s8]
						local oE, oF = AutoHelp.GetRange(tInfo["unit"])
						if tInfo and oF <= 20 and AutoHelp.TryUseAction(tInfo, "嫁祸诀窍") then
							tF = tInfo;
							return true
						end
					end
				end;
				if GetStatus("STATUS_战斗贼_疾跑") and GetStatus("STATUS_目标互动") then
					if AutoHelp.IsMoving and iG >= 20 then
						if AutoHelp.TryUseAction(mH, "疾跑") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_战斗贼_冲动") and si < 40 and iG <= 2 and rn and AutoHelp.TryUseAction(mH, "冲动") then
					return true
				end;
				if GetStatus("STATUS_战斗贼_剑刃乱舞") and tV("剑刃乱舞") and iG <= 2 and rn and AutoHelp.TryUseAction(mH, "剑刃乱舞") then
					return true
				end;
				if GetStatus("HEAL_STATUS_AOE") and GetStatus("STATUS_战斗贼_刀扇") and iG <= 8 then
					local sq = AutoHelp.getNumberTargets()
					if sq >= 3 then
						if sy(50) and AutoHelp.TryUseAction(mH, "刀扇") then
							return true
						end
					end
				end;
				local tX = AutoHelp.GetBuffRemainTime("player", GetSpellInfo(6774))
				if GetStatus("STATUS_战斗贼_切割") and tX <= 2 and sB > 0 and sy(25) and AutoHelp.TryUseAction(mH, "切割") then
					return true
				end;
				if GetStatus("STATUS_战斗贼_破甲") and sB >= 1 and (UnitLevel("target") == - 1 or UnitLevel("target") >= 81) and AutoHelp.TryUseAction(targetInfo, "破甲") then
					return true
				end;
				if GetStatus("STATUS_战斗贼_杀戮盛筵") and si <= 50 and rn and AutoHelp.TryUseAction(mH, "杀戮盛筵") then
					return true
				end;
				if GetStatus("STATUS_战斗贼_割裂") and sB == 5 and sy(25) and AutoHelp.TryUseAction(targetInfo, "割裂") then
					return true
				end;
				if GetStatus("STATUS_战斗贼_刺骨") and sB == 5 and sy(35) and AutoHelp.TryUseAction(targetInfo, "刺骨") then
					return true
				end;
				if GetStatus("STATUS_战斗贼_影袭") and (sB < 5 or si >= 90) and sy(40) and AutoHelp.TryUseAction(targetInfo, ahenv["影袭"]) then
					return true
				end
			end;
			local function tZ()
			end;
			if jy("HEALMODE") == "刺杀贼" then
				if tW() then
					return true
				end
			end;
			if jy("HEALMODE") == "战斗贼" then
				if tY() then
					return true
				end
			end;
			if jy("HEALMODE") == "敏锐贼" then
				if tZ() then
					return true
				end
			end;
			if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
				return true
			end
		end
	end;
	if PlayerIsClass("ROGUE") then
		AutoHelp.ClassConfig = tC
	end
end;
if AutoHelp.isWotlk then
	local function t_()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {}
		AutoHelp.SS_DOGS = {}
		AutoHelp.CAN_RESCURIT = false;
		AutoHelp.CAN_HEAL = false;
		AutoHelp.CAN_BUFF = false;
		AutoHelp.CAN_DISPEL = false;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 2;
		AutoHelp.AttackRange = 30;
		AutoHelp.CommingHealWindow = 0;
		local sJ = nil;
		local function u0(hK, jI)
			if jI then
				if hK ~= "元素诅咒" then
					SetConfig("STATUS_元素诅咒", false)
				end;
				if hK ~= "痛苦诅咒" then
					SetConfig("STATUS_痛苦诅咒", false)
				end;
				if hK ~= "语言诅咒" then
					SetConfig("STATUS_语言诅咒", false)
				end;
				if hK ~= "虚弱诅咒" then
					SetConfig("STATUS_虚弱诅咒", false)
				end;
				if hK ~= "厄运诅咒" then
					SetConfig("STATUS_厄运诅咒", false)
				end
			end
		end;
		local function u1()
			if GetStatus("STATUS_元素诅咒") then
				return "元素诅咒"
			end;
			if GetStatus("STATUS_痛苦诅咒") then
				return "痛苦诅咒"
			end;
			if GetStatus("STATUS_语言诅咒") then
				return "语言诅咒"
			end;
			if GetStatus("STATUS_虚弱诅咒") then
				return "虚弱诅咒"
			end;
			if GetStatus("STATUS_厄运诅咒") then
				return "厄运诅咒"
			end
		end;
		local n9 = {
			{
				name = "射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "侦测隐形",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "制造治疗石",
				spellId = true
			},
			{
				name = "制造法术石",
				spellId = true
			},
			{
				name = "制造火焰石",
				spellId = true
			},
			{
				name = "制造灵魂石",
				spellId = true
			},
			{
				name = "召唤仪式",
				spellId = true
			},
			{
				name = "召唤地狱猎犬",
				spellId = true
			},
			{
				name = "召唤夜魔",
				spellId = true
			},
			{
				name = "召唤小鬼",
				spellId = true
			},
			{
				name = "召唤恶魔卫士",
				spellId = true
			},
			{
				name = "召唤虚空行者",
				spellId = true
			},
			{
				name = "召唤魅魔",
				spellId = true
			},
			{
				name = "地狱火",
				spellId = true,
				["spellName"] = "地狱火",
				["macro"] = "/cast [@cursor]地狱火\n/petattack\n",
				["useSP"] = true
			},
			{
				name = "地狱火身边",
				spellId = true,
				["spellName"] = "地狱火",
				["macro"] = "/cast [@player]地狱火\n/petattack\n",
				["useSP"] = true
			},
			{
				name = "地狱火点击",
				spellId = true,
				["spellName"] = "地狱火",
				["macro"] = "/cast 地狱火\n",
				["useSP"] = true
			},
			{
				name = "恶魔变形",
				spellId = true,
				["auraNameCID"] = true,
				["useSP"] = true
			},
			{
				name = "恶魔支配",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "恶魔冲锋",
				spellId = true,
				["target"] = true
			},
			{
				name = "恶魔法阵：召唤",
				spellId = true
			},
			{
				name = "恶魔法阵：传送",
				spellId = true
			},
			{
				name = "暗影防护结界",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "灵魂仪式",
				spellId = true
			},
			{
				name = "灵魂碎裂",
				spellId = true
			},
			{
				name = "灵魂链接",
				spellId = true
			},
			{
				name = "生命通道",
				spellId = true
			},
			{
				name = "恶魔皮肤",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "邪甲术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "魔甲术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "魔息术",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "恶魔增效",
				spellId = true
			},
			{
				name = "暗影箭",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "暗影箭鼠标",
				spellId = true,
				["spellName"] = "暗影箭",
				["macro"] = "/cast [@mouseover,exists,harm]暗影箭",
				["fastSpell"] = true
			},
			{
				name = "暗影箭鼠标1",
				spellId = true,
				["spellName"] = "暗影箭",
				["macro"] = "/cast [@mouseover,exists,harm]暗影箭(等级 1)"
			},
			{
				name = "献祭",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "生命虹吸",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "燃烧",
				spellId = true,
				["target"] = true,
				["sp"] = true
			},
			{
				name = "混乱之箭",
				spellId = true,
				["target"] = true
			},
			{
				name = "腐蚀术",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["sp"] = true
			},
			{
				name = "腐蚀术鼠标",
				spellId = true,
				["spellName"] = "腐蚀术",
				["macro"] = "/cast [@mouseover,exists,harm]腐蚀术"
			},
			{
				name = "腐蚀术2",
				spellId = true,
				["spellName"] = "腐蚀术",
				["target"] = true
			},
			{
				name = "虚弱诅咒",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "痛苦诅咒",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "痛苦诅咒鼠标",
				spellId = true,
				["spellName"] = "痛苦诅咒",
				["macro"] = "/cast [@mouseover,exists,harm]痛苦诅咒"
			},
			{
				name = "元素诅咒",
				spellId = true,
				["target"] = true,
				["debuffNameCID"] = true
			},
			{
				name = "厄运诅咒",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "语言诅咒",
				spellId = true,
				["target"] = true,
				["debuffNameCID"] = true
			},
			{
				name = "地狱烈焰",
				spellId = true
			},
			{
				name = "暗影烈焰",
				spellId = true
			},
			{
				name = "火焰之雨",
				spellId = true
			},
			{
				name = "灵魂之火",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true
			},
			{
				name = "献祭光环",
				spellId = true,
				["sp"] = true
			},
			{
				name = "灼热之痛",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "烧尽",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true
			},
			{
				name = "吸取法力",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "吸取灵魂",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "吸取生命",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "恐惧嚎叫",
				spellId = true
			},
			{
				name = "死亡缠绕",
				spellId = true,
				["target"] = true
			},
			{
				name = "恐惧",
				spellId = true,
				["target"] = true
			},
			{
				name = "生命分流",
				spellId = true
			},
			{
				name = "生命分流1",
				spellId = 1454,
				["spellName"] = "生命分流",
				["macro"] = "/cast 生命分流(等级 1)\n"
			},
			{
				name = "腐蚀之种",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "腐蚀之种2",
				spellId = true,
				["spellName"] = "腐蚀之种",
				["target"] = true,
				["macro"] = "/targetenemy\n/cast [exists]腐蚀之种\n/targetlasttarget\n",
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "鬼影缠身",
				spellId = true,
				["target"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "痛苦无常",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["sp"] = true
			},
			{
				["name"] = "法术石附魔",
				["macro"] = "/use [@none] 完美法术石\n/use 16\n/click StaticPopup1Button1\n",
				["spellTime"] = 5,
				["desc"] = "武器附魔法术石"
			},
			{
				["name"] = "选中镜像",
				["macro"] = "/targetexact 裹体之网\n/targetexact 镜像\n/cast [exists]吸取生命\n/petattack\n",
				["spellName"] = "选中镜像",
				["spellTime"] = 1,
				["desc"] = "选中镜像"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "痛苦"
			AutoHelp.ModeDefaultSetting = {
				["HEAL_STATUS_START"] = true,
				["STATUS_主动攻击"] = true,
				["STATUS_治疗模式"] = false
			}
			AutoHelp.HEAL_MODES = {
				["恶魔"] = {
					["modetip"] = "\124cffFFF569已设置为【恶魔】。\124r"
				},
				["痛苦"] = {
					["STATUS_痛苦诅咒"] = true,
					["modetip"] = "\124cffFFF569已设置为【痛苦】。\124r"
				},
				["毁灭"] = {
					["modetip"] = "\124cffFFF569已设置为【毁灭】。\124r"
				},
				["将军英雄模式"] = {
					["modetip"] = "\124cffFFF569已设置为【将军模式】。\124r"
				}
			}
			AutoHelp.ModeList = {
				{
					text = "输出模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00痛苦\124r",
					name = "痛苦",
					tooltipTitle = "痛苦",
					tooltipText = "使用痛苦天赋"
				},
				{
					text = "\124cff00ff00恶魔\124r",
					name = "恶魔",
					tooltipTitle = "恶魔",
					tooltipText = "使用恶魔天赋。"
				},
				{
					text = "\124cff00ff00毁灭\124r",
					name = "毁灭",
					tooltipTitle = "毁灭",
					tooltipText = "使用毁灭天赋"
				}
			}
			AutoHelp.PANELHEIGHT = 490;
			AutoHelp.PANELWIDTH = 160;
			local ki = AutoHelp.PANELHEIGHT or 490;
			local kj = AutoHelp.PANELWIDTH or 160;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00诅咒选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_元素诅咒",
						["value"] = false,
						["title"] = "\124cffFFF569元\124r",
						["tipTitle"] = "元素诅咒",
						["tip"] = "对目标上元素诅咒",
						["point"] = 5,
						["hitRect"] = - 20,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("元素诅咒") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							u0("元素诅咒", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_痛苦诅咒",
						["value"] = false,
						["title"] = "\124cffFFF569痛\124r",
						["tipTitle"] = "痛苦诅咒",
						["tip"] = "对目标上痛苦诅咒",
						["point"] = 35,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("痛苦诅咒") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							u0("痛苦诅咒", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_语言诅咒",
						["value"] = false,
						["title"] = "\124cffFFF569语\124r",
						["tipTitle"] = "语言诅咒",
						["tip"] = "对目标上语言诅咒",
						["point"] = 65,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("语言诅咒") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							u0("语言诅咒", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_虚弱诅咒",
						["value"] = false,
						["title"] = "\124cffFFF569虚\124r",
						["tipTitle"] = "虚弱诅咒",
						["tip"] = "对目标上虚弱诅咒",
						["point"] = 95,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("虚弱诅咒") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							u0("虚弱诅咒", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_厄运诅咒",
						["value"] = false,
						["title"] = "\124cffFFF569厄\124r",
						["tipTitle"] = "厄运诅咒",
						["tip"] = "对目标上厄运诅咒",
						["point"] = 125,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("厄运诅咒") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							u0("厄运诅咒", hK)
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动换蓝",
						["value"] = true,
						["title"] = "换蓝",
						["tip"] = "战斗中蓝量低于设定值时20%，自动使用生命分流换蓝",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("生命分流") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_镜像蛛网",
						["value"] = true,
						["title"] = "镜像",
						["tip"] = "当目进入有镜像或者蛛网的副本时，自动优先打镜像和蛛网裹体",
						["point"] = 60,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在枭兽模式下为缺省勾选，建议治疗模式不要选择。",
						["point"] = 110,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_吸取碎片",
						["value"] = false,
						["title"] = "吸取碎片",
						["tipTitle"] = "使用吸取灵魂收集碎片",
						["tip"] = "当背包碎片低于设定值时(20)自动使用吸取灵魂收集碎片。\n\n\124cff00ff00此功能只对小怪使用, 自动解决恶魔术碎片不足问题, 不会对团本boss生效, 放心使用\124r",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_多目标痛",
						["value"] = false,
						["title"] = "多目标痛",
						["tipTitle"] = "多目标保持腐蚀术/痛苦诅咒",
						["tip"] = "鼠标指向非当前敌对目标时自动上痛苦诅咒和腐蚀术。\n\n\124cff00ff00适合多目标提高伤害，比如Xt002鼠标指向火花会自动给火花上腐蚀和痛苦诅咒，左右手皆可指向目标保持多目标腐蚀术和痛苦诅咒。\124r",
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。\n\n此功能只在枭兽模式下为缺省勾选，建议治疗模式不要选择。",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动换蓝",
						["value"] = true,
						["title"] = "自动换蓝",
						["tip"] = "战斗中蓝量低于设定值时20%，自动使用生命分流换蓝",
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "classic",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("生命分流") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_吸取碎片",
						["value"] = true,
						["title"] = "吸取碎片",
						["tipTitle"] = "使用吸取灵魂收集碎片",
						["tip"] = "当背包碎片低于设定值时(20)自动使用吸取灵魂收集碎片。后面设定目标血量百分比开始吸取灵魂石！\n\n\124cff00ff00此功能只对小怪使用, 自动解决碎片不足问题, 不会对团本boss生效, 放心使用\124r",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_吸取碎片",
						["value"] = 50,
						["point"] = 100,
						["nextpos"] = false,
						["version"] = "classic",
						["percent"] = "%"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_吸取生命",
						["value"] = false,
						["title"] = "吸取生命",
						["tipTitle"] = "使用吸取生命回血",
						["tip"] = "当自身血量低于设定值时候，使用吸取生命回血，适合SOLO打怪使用！\n\n\124cff00ff00此功能只对小怪使用, 不会对团本boss生效, 放心使用\124r",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_吸取生命",
						["value"] = 50,
						["point"] = 100,
						["nextpos"] = false,
						["percent"] = "%",
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = false,
						["title"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果怪物数量大于等于3个，将自动启动AOE技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("腐蚀之种") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_痛苦_腐蚀之种", true)
								SetConfig("STATUS_恶魔_腐蚀之种", true)
								SetConfig("STATUS_毁灭_腐蚀之种", true)
							else
								SetConfig("STATUS_痛苦_腐蚀之种", false)
								SetConfig("STATUS_恶魔_腐蚀之种", false)
								SetConfig("STATUS_毁灭_腐蚀之种", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_始终AOE",
						["value"] = false,
						["title"] = "始终AOE",
						["tip"] = "一直使用AOE技能进行攻击。",
						["hitRect"] = - 30,
						["point"] = 80,
						["nextpos"] = false,
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_痛苦_腐蚀之种", true)
								SetConfig("STATUS_恶魔_腐蚀之种", true)
								SetConfig("STATUS_毁灭_腐蚀之种", true)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00攻击技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_召唤法阵",
						["title"] = "召唤",
						["tipTitle"] = "恶魔法阵：召唤",
						["tip"] = "恶魔法阵：召唤\n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = true,
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("恶魔法阵：召唤") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("恶魔法阵：召唤")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_传送法阵",
						["title"] = "传送",
						["tipTitle"] = "恶魔法阵：传送",
						["tip"] = "恶魔法阵：传送 \n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("恶魔法阵：传送") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("恶魔法阵：传送")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_灵魂碎裂",
						["title"] = "碎裂",
						["tipTitle"] = "灵魂碎裂",
						["tip"] = "灵魂碎裂 \n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("灵魂碎裂") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("灵魂碎裂")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_地狱火",
						["title"] = "地狱",
						["tipTitle"] = "召唤地狱火",
						["tip"] = "召唤地狱火 \n\n\124cff00ff00此处仅提供一种快捷按钮方式，可以将AutoHelp自动创建的宏拖到快捷栏进行操作。\124r",
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("地狱火身边") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("地狱火身边")
						end
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "STATUS_治疗石",
						["value"] = true,
						["title"] = "治疗石",
						["tip"] = "自动做糖",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_灵魂石",
						["value"] = true,
						["title"] = "灵魂石",
						["tip"] = "自动制灵魂石",
						["point"] = 80,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_武器附魔",
						["value"] = true,
						["title"] = "武器附魔",
						["tip"] = "制造法术石，并自动附魔",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_法术石",
						["value"] = true,
						["title"] = "\124cffFF7D0A法\124r",
						["tip"] = "制造法术石，并自动附魔",
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "wlk",
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_火焰石", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_火焰石",
						["value"] = false,
						["title"] = "\124cffFF7D0A火\124r",
						["tip"] = "制造火焰石，并自动附魔",
						["point"] = 120,
						["nextpos"] = false,
						["version"] = "wlk",
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_法术石", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_召唤宝宝",
						["value"] = true,
						["title"] = "召唤",
						["tip"] = "不在战斗时，自动召唤宝宝。",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_宠物名称",
						["title"] = "召唤宠物",
						["tipTitle"] = "选择自动召唤宠物",
						["tip"] = "选择自动召唤宠物",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["create"] = function(kl)
							local kp = jy("SSDOGNAME")
							if kp then
								kl:SetText(kp)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.PopupListMenu2("选择宝宝名称", "HEAL_STATUS_宠物名称", "SSDOGNAME", kl, AutoHelp.SS_DOGS, jy("SSDOGNAME"))
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动碎裂",
						["value"] = true,
						["title"] = "仇恨碎裂",
						["tip"] = "当对BOSS仇恨高于设定值时，自动使用碎裂消除仇恨，缺省设置仇恨高于90%时使用",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_仇恨值",
						["value"] = 90,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_团队通告",
						["value"] = false,
						["title"] = "团队通告",
						["tip"] = "通告自己大技能给团队, SS为绑定灵魂石给其他人。",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_斩杀痛苦诅咒",
						["value"] = true,
						["title"] = "斩杀阶段补痛苦诅咒",
						["tip"] = "痛苦术士斩杀阶段, 吸魂伤害最大, 根据您自己的需求是否补痛苦诅咒。",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["mode"] = "痛苦",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_斩杀痛苦无常",
						["value"] = false,
						["title"] = "斩杀阶段补痛苦无常",
						["tip"] = "痛苦术士斩杀阶段, 吸魂伤害最大, 根据您自己的需求是否补痛苦无常。",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true,
						["mode"] = "痛苦",
						["version"] = "wlk"
					}
				}
			}
			local qQ = {
				{
					{
						"恶魔_邪甲术",
						"邪甲术",
						true,
						"邪甲术",
						"恶魔"
					},
					{
						"恶魔_暗影箭",
						"暗影箭",
						true,
						"暗影箭",
						"恶魔"
					},
					{
						"恶魔_献祭",
						"献祭",
						true,
						"献祭",
						"恶魔"
					},
					{
						"恶魔_腐蚀术",
						"腐蚀术",
						true,
						"腐蚀术",
						"恶魔"
					},
					{
						"恶魔_灵魂之火",
						"灵魂之火",
						true,
						"灵魂之火",
						"恶魔"
					},
					{
						"恶魔_恶魔增效",
						"恶魔增效",
						true,
						"恶魔增效",
						"恶魔"
					},
					{
						"恶魔_烧尽",
						"烧尽",
						true,
						"烧尽",
						"恶魔"
					},
					{
						"恶魔_恶魔变形",
						"恶魔变形",
						true,
						"恶魔变形",
						"恶魔"
					},
					{
						"恶魔_恶魔冲锋",
						"恶魔冲锋",
						false,
						"恶魔冲锋",
						"恶魔"
					},
					{
						"恶魔_献祭光环",
						"献祭光环",
						true,
						"献祭光环",
						"恶魔"
					},
					{
						"恶魔_暗影烈焰",
						"暗影烈焰",
						true,
						"暗影烈焰",
						"恶魔"
					},
					{
						"恶魔_腐蚀之种",
						"腐蚀之种",
						false,
						"腐蚀之种",
						"恶魔"
					}
				},
				{
					{
						"痛苦_邪甲术",
						"邪甲术",
						true,
						"邪甲术",
						"痛苦"
					},
					{
						"痛苦_鬼影缠身",
						"鬼影缠身",
						true,
						"鬼影缠身",
						"痛苦"
					},
					{
						"痛苦_腐蚀术",
						"腐蚀术",
						true,
						"腐蚀术",
						"痛苦"
					},
					{
						"痛苦_痛苦无常",
						"痛苦无常",
						true,
						"痛苦无常",
						"痛苦"
					},
					{
						"痛苦_暗影箭",
						"暗影箭",
						true,
						"暗影箭",
						"痛苦"
					},
					{
						"痛苦_吸取灵魂",
						"吸取灵魂",
						true,
						"吸取灵魂",
						"痛苦"
					},
					{
						"痛苦_暗影烈焰",
						"暗影烈焰",
						false,
						"暗影烈焰",
						"痛苦"
					},
					{
						"痛苦_腐蚀之种",
						"腐蚀之种",
						false,
						"腐蚀之种",
						"痛苦"
					}
				},
				{
					{
						"毁灭_邪甲术",
						"邪甲术",
						true,
						"邪甲术",
						"毁灭"
					},
					{
						"毁灭_献祭",
						"献祭",
						true,
						"献祭",
						"毁灭"
					},
					{
						"毁灭_燃烧",
						"燃烧",
						true,
						"燃烧",
						"毁灭"
					},
					{
						"毁灭_烧尽",
						"烧尽",
						true,
						"烧尽",
						"毁灭"
					},
					{
						"毁灭_混乱之箭",
						"混乱之箭",
						true,
						"混乱之箭",
						"毁灭"
					},
					{
						"毁灭_腐蚀术",
						"腐蚀术",
						true,
						"腐蚀术",
						"毁灭"
					},
					{
						"毁灭_暗影烈焰",
						"暗影烈焰",
						false,
						"暗影烈焰",
						"毁灭"
					},
					{
						"毁灭_腐蚀之种",
						"腐蚀之种",
						false,
						"腐蚀之种",
						"毁灭"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 2 == 1 then
							point = 5;
							kf = true
						else
							point = 80;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tip"] = qS[4],
							["point"] = point,
							["nextpos"] = kf,
							["stance"] = qS[5],
							["mode"] = qS[5]
						}
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if kH == nil then
				return
			end;
			if sJ ~= nil and sJ ~= kH and AutoHelp.playerLevel >= 55 then
				AutoHelp.Debug("\124cfff00000##错误的输出设置：您当前天赋为" .. sJ .. ",输出方式为" .. kH .. "!\124r")
			end;
			if kH == "恶魔" then
				if AutoHelp.HasActionKey("召唤恶魔卫士") then
					SetConfig("SSDOGNAME", "召唤恶魔卫士")
				end;
				if AutoHelp.HasActionKey("痛苦诅咒") then
					SetConfig("STATUS_痛苦诅咒", true)
				end;
				SetConfig("STATUS_法术石", true)
			elseif kH == "痛苦" then
				if AutoHelp.HasActionKey("召唤地狱猎犬") then
					SetConfig("SSDOGNAME", "召唤地狱猎犬")
				end;
				if AutoHelp.HasActionKey("痛苦诅咒") then
					SetConfig("STATUS_痛苦诅咒", true)
				end;
				SetConfig("STATUS_法术石", true)
			elseif kH == "毁灭" then
				if AutoHelp.HasActionKey("召唤小鬼") then
					SetConfig("SSDOGNAME", "召唤小鬼")
				end;
				if AutoHelp.HasActionKey("厄运诅咒") then
					SetConfig("STATUS_厄运诅咒", true)
				end;
				SetConfig("STATUS_火焰石", true)
			end;
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or bn.mode == "attack" then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			AutoHelp.ResizePanel()
		end;
		local sO = false;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") then
				return
			end;
			if qV.event == "SPELL_AURA_APPLIED" and qV.spellId == 62692 then
			end;
			if qV.event == "SPELL_AURA_REMOVED" and qV.spellId == 62692 then
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.RegisterBossEvent()
		end;
		function AutoHelp.SpellCastSuccess(fq, ca, cx, fu, qX, qY)
			if cx == "灵魂石复活" and GetStatus("HEAL_STATUS_团队通告") then
				if fu then
					AutoHelp.SendChatMsg((fq or "") .. "【" .. (cx or "") .. "】=>" .. (fu or ""), IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
				end
			end
		end;
		function AutoHelp.AutoCreateMacro()
			ClearOldAHMacros()
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51, true)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52, true)
		end;
		local rE = false;
		function AutoHelp.SpellDamageAction(fm, aj, fu, ca, cx, amount)
			if not AutoHelp.isWotlk then
				return
			end;
			if cx == "吸取灵魂" and AutoHelp.TargetInfo and AutoHelp.TargetInfo["hp"] <= 0.25 and AutoHelp.castinfo.channeling and AutoHelp.castinfo.spellName == cx then
				local u2 = AutoHelp.IsSpellCooldown("鬼影缠身")
				local u3 = AutoHelp.GetDebuffRemainTime("target", "鬼影缠身", true)
				local u4 = AutoHelp.GetDebuffRemainTime("target", "腐蚀术", true)
				local u5 = AutoHelp.GetDebuffRemainTime("target", "暗影之拥", true)
				if u2 or u3 == 0 or u4 <= 3 or u5 <= 1.5 then
					AutoHelp.ForceBreakSpell = true;
					SetCombatValue("ForceBreakSpell", 1)
					HEAL_TIMERS["HEAL_TARGET"] = 0.001
				end
			end
		end;
		function AutoHelp.ThreatChanged(mt, sQ, sR, sS)
			if not AutoHelp.isWotlk then
				return
			end;
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_自动碎裂") and not AutoHelp.IsSpellCooldown("灵魂碎裂") then
				return
			end;
			local jp = GetStatusNumber("HEAL_VALUE_仇恨值") or 90;
			if mt >= 2 then
				if GetStatus("HEAL_STATUS_自动碎裂") then
					AutoHelp.AddCastAction("灵魂碎裂")
					AutoHelp.Debug(">>>>你OT了，自动使用碎裂！")
				else
					AutoHelp.Debug(">>>>你OT了，请使用碎裂消除仇恨！")
				end
			end;
			if mt == 1 and sQ >= jp then
				if GetStatus("HEAL_STATUS_自动碎裂") then
					AutoHelp.AddCastAction("灵魂碎裂")
					AutoHelp.Debug(">>>>仇恨过高:" .. math.floor(sQ) .. "%，自动使用碎裂！")
				else
					AutoHelp.Debug(">>>>仇恨过高:" .. math.floor(sQ) .. "%，请使用碎裂消除仇恨！")
				end
			end
		end;
		function AutoHelp.EncounterStart(sT, sU, rx, sV)
		end;
		function AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
		end;
		function AutoHelp.ClassInit()
			local u6 = {
				"召唤恶魔卫士",
				"召唤地狱猎犬",
				"召唤夜魔",
				"召唤小鬼",
				"召唤虚空行者",
				"召唤魅魔"
			}
			for _, cd in pairs(u6) do
				if AutoHelp.HasActionKey(cd) then
					AutoHelp.SS_DOGS[# AutoHelp.SS_DOGS + 1] = cd
				end
			end;
			AutoHelp.RegisterKeyCallback("SSDOGNAME", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_宠物名称"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			if AutoHelp.playerLevel >= 55 then
				local u7, u8, u9 = AutoHelp.HEAL_PLAYER_TALENTS[1] or 0, AutoHelp.HEAL_PLAYER_TALENTS[2] or 0, AutoHelp.HEAL_PLAYER_TALENTS[3] or 0;
				local kH = jy("HEALMODE")
				if u7 > u8 and u7 > u9 then
					sJ = "痛苦"
				end;
				if u8 > u7 and u8 > u9 then
					sJ = "恶魔"
				end;
				if u9 > u7 and u9 > u8 then
					sJ = "毁灭"
				end;
				if kH == nil then
					SetConfig("HEALMODE", sJ)
				end
			end
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
		end;
		local ua = {
			5512,
			5511,
			5509,
			5510,
			9421,
			22103,
			36889,
			36892
		}
		local ub = {
			5232,
			16892,
			16893,
			16895,
			16896,
			22116,
			36895
		}
		local uc = {
			41191,
			41192,
			41193,
			41194,
			41195,
			41196
		}
		local ud = {
			41170,
			41169,
			41171,
			41172,
			40773,
			41173,
			41174
		}
		local function ue(bq)
			for i = # bq, 1, - 1 do
				if AutoHelp.GetItemCount(bq[i]) > 0 then
					return bq[i]
				end
			end
		end;
		function AutoHelp.DoUncombatAction(mH)
			if GetStatus("STATUS_治疗石") and AutoHelp.GetItemCount(6265) > 0 then
				if not ue(ua) and AutoHelp.TryUseAction(mH, "制造治疗石") then
					return true
				end
			end;
			if GetStatus("STATUS_灵魂石") and AutoHelp.GetItemCount(6265) > 0 then
				if not ue(ub) and AutoHelp.TryUseAction(mH, "制造灵魂石") then
					return true
				end
			end;
			if AutoHelp.isWotlk then
				if GetStatus("STATUS_武器附魔") and (GetStatus("STATUS_法术石") or GetStatus("STATUS_火焰石")) and AutoHelp.GetItemCount(6265) > 0 then
					local uf;
					local ug = "制造法术石"
					if GetStatus("STATUS_法术石") then
						uf = ue(uc)
						ug = "制造法术石"
					else
						uf = ue(ud)
						ug = "制造火焰石"
					end;
					if not uf and AutoHelp.TryUseAction(mH, ug) then
						return true
					end;
					local tP, tQ, _, tR, tS, tT, _, tU = GetWeaponEnchantInfo()
					if (not tP or tQ <= 5 * 60 * 1000) and uf then
						local uh = GetItemInfo(uf)
						local lh, action = AutoHelp.GetActionKey("法术石附魔")
						action["macro"] = "/use [@none] " .. uh .. "\n/use 16\n/click StaticPopup1Button1\n"
						AutoHelp.RefreshAction(action)
						if AutoHelp.TryUseAction(mH, "法术石附魔") then
							return true
						end
					end
				end
			end;
			if AutoHelp.HasActionKey("邪甲术") and AutoHelp.TryUseAction(mH, "邪甲术") then
				return true
			end;
			if not AutoHelp.HasActionKey("邪甲术") and AutoHelp.HasActionKey("魔甲术") and AutoHelp.TryUseAction(mH, "魔甲术") then
				return true
			end;
			if not AutoHelp.HasActionKey("邪甲术") and not AutoHelp.HasActionKey("魔甲术") and AutoHelp.HasActionKey("恶魔皮肤") and AutoHelp.TryUseAction(mH, "恶魔皮肤") then
				return true
			end;
			if not AutoHelp.IsMoving then
				local ui = jy("SSDOGNAME")
				if GetStatus("HEAL_STATUS_召唤宝宝") and not HEAL_PET_ISDEAD and not UnitExists('pet') and not UnitIsDead("pet") and ui ~= nil then
					if (ui == "召唤小鬼" or ui ~= "召唤小鬼" and AutoHelp.GetItemCount(6265) > 0) and AutoHelp.TryUseAction(mH, jy("SSDOGNAME")) then
						return true
					end
				end
			end;
			if GetStatus("HEAL_STATUS_自动换蓝") and mH["mp"] <= 0.8 and mH["hp"] >= 0.5 and AutoHelp.TryUseAction(mH, "生命分流") then
				return true
			end;
			return false
		end;
		local function rP()
			local mK = GetSpellCritChance(6)
			local cg = GetSpellBonusDamage(6)
			for i = 1, 255 do
				local _, _, nE, _, _, _, rQ, _, _, ca = UnitDebuff("target", i)
				if not ca then
					break
				end;
				if ca == 22959 or ca == 17800 then
					mK = mK + 5
				end;
				if ca == 54499 then
					mK = mK + 3
				end;
				if ca == 57970 then
					if UnitInParty(rQ) then
						mK = mK + 3
					end
				end
			end;
			local _, _, _, _, _, _, rR = UnitDamage("player")
			local rS = rR;
			local uj = UnitHealthMax("target")
			local uk = UnitHealth("target")
			local ul = 0;
			if uj and uj > 0 then
				ul = uk * 100 / uj
			end;
			if ul <= 35 then
				rS = rS + 0.12
			end;
			local d = 100 * rS * (100 - mK) / 100 + 100 * rS * 2 * mK / 100;
			return d
		end;
		local um = 0;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, r7 = mH["hp"], mH["mp"]
			local rm = targetInfo and targetInfo["hp"] <= 0.25;
			local ib, iG = AutoHelp.GetRange("target")
			local rV = GetStatus("HEAL_STATUS_AOE") and AutoHelp.getNumberTargets() >= 3 or GetStatus("STATUS_始终AOE")
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local function rW()
				if not AutoHelp.KillJX then
					return false
				end;
				local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
				if not rX and InCombatLockdown() and GetStatus("HEAL_STATUS_镜像蛛网") then
					if FindEnemyUnit("镜像") or FindEnemyUnit("裹体之网") then
						if AutoHelp.TryUseAction(mH, "选中镜像") then
							AutoHelp.Debug(">>有镜像或者蛛网裹体，优先击杀！")
							return true
						end
					end
				end;
				return false
			end;
			local function un()
				if GetStatus("STATUS_恶魔_邪甲术") and AutoHelp.TryUseAction(mH, "邪甲术") then
					return true
				end;
				if GetStatus("HEAL_STATUS_自动换蓝") and r7 <= 0.15 and mT >= 0.35 and AutoHelp.TryUseAction(mH, "生命分流") then
					return true
				end;
				if AutoHelp.Glyphs[63320] and (AutoHelp.GetBuffRemainTime("player", "生命分流") <= 5 or not AutoHelp.UnitBuff("player", "生命分流")) and AutoHelp.TryUseAction(mH, "生命分流1") then
					return true
				end;
				if GetStatus("STATUS_吸取碎片") and AutoHelp.GetItemCount(6265) < 20 and UnitLevel("target") ~= - 1 then
					if AutoHelp.TryUseAction(targetInfo, "吸取灵魂") then
						return true
					end
				end;
				if GetStatus("STATUS_恶魔_恶魔增效") and UnitExists('pet') and not UnitIsDead("pet") then
					local uo = UnitCreatureFamily("pet")
					if uo and (uo == "恶魔卫士" or uo == "小鬼" or uo == "地狱猎犬" or uo == "虚空行者" or uo == "魅魔" or uo == "梦魇") then
						if AutoHelp.TryUseAction(mH, "恶魔增效") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_恶魔_恶魔变形") and rn and AutoHelp.TryUseAction(mH, "恶魔变形") then
					return true
				end;
				if GetStatus("STATUS_恶魔_恶魔冲锋") and ib >= 8 and iG <= 25 and AutoHelp.UnitHasBuff("player", "恶魔变形") and AutoHelp.TryUseAction(targetInfo, "恶魔冲锋") then
					return true
				end;
				if GetStatus("STATUS_恶魔_献祭光环") and iG <= 8 and AutoHelp.UnitHasBuff("player", "恶魔变形") and AutoHelp.TryUseAction(mH, "献祭光环") then
					return true
				end;
				if GetStatus("STATUS_恶魔_暗影烈焰") and iG <= 8 and AutoHelp.TryUseAction(mH, "暗影烈焰") then
					return true
				end;
				if rV and GetStatus("STATUS_恶魔_腐蚀之种") and not AutoHelp.IsMoving then
					if AutoHelp.TryUseAction(targetInfo, "腐蚀之种") then
						return true
					end
				end;
				if GetStatus("STATUS_多目标痛") and not MouseoverIsTarget() and UnitCanAttack("player", "mouseover") then
					local s1, s2 = AutoHelp.GetRange("mouseover")
					local u4 = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(172), true)
					local up = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(980), true)
					if GetStatus("STATUS_痛苦_腐蚀术") and s2 <= 30 and u4 == 0 and AutoHelp.TryUseAction(mH, "腐蚀术鼠标") then
						return true
					end;
					local uq = AutoHelp.UnitHasBuff("player", "灭杀")
					local ur = UnitHealth("mouseover") / UnitHealthMax("mouseover")
					if GetStatus("STATUS_痛苦_暗影箭") and s2 <= 30 and not AutoHelp.UnitHasBuff("player", "灭杀") and ur <= 0.35 and AutoHelp.TryUseAction(mH, "暗影箭鼠标1") then
						return true
					end
				end;
				if u1() then
					local us = u1()
					local ut = AutoHelp.UnitHasDebuffByPlayer("target", GetSpellInfo(603))
					if not ut and us and AutoHelp.TryUseAction(targetInfo, us) then
						return true
					end
				end;
				if GetStatus("STATUS_恶魔_腐蚀术") and AutoHelp.TryUseAction(targetInfo, "腐蚀术") then
					return true
				end;
				if GetStatus("STATUS_恶魔_献祭") and AutoHelp.TryUseAction(targetInfo, "献祭") then
					return true
				end;
				if GetStatus("STATUS_恶魔_灵魂之火") and AutoHelp.UnitHasBuff("player", "灭杀") and AutoHelp.TryUseAction(targetInfo, "灵魂之火") then
					return true
				end;
				if GetStatus("STATUS_恶魔_烧尽") then
					local uu = AutoHelp.GetUnitBuffNum("player", "熔火之心")
					if uu > 0 then
						local uv = AutoHelp.castinfo.casting and AutoHelp.castinfo.spellName == "烧尽" and uu == 1;
						if not uv and AutoHelp.TryUseAction(targetInfo, "烧尽") then
							return true
						end
					end
				end;
				if GetStatus("STATUS_恶魔_暗影箭") and AutoHelp.TryUseAction(targetInfo, "暗影箭") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("HEAL_STATUS_自动换蓝") and r7 <= 0.8 and mT >= 0.5 and AutoHelp.TryUseAction(mH, "生命分流") then
					return true
				end
			end;
			local function uw()
				if GetCombatNumber("ForceBreakSpell") == 1 then
					SetCombatValue("ForceBreakSpell", 0)
				else
					if AutoHelp.IsCastingSpell(GetSpellInfo(1120)) then
						return false
					end
				end;
				local u5 = AutoHelp.GetDebuffRemainTime("target", "暗影之拥", true)
				if GetStatus("STATUS_痛苦_邪甲术") and AutoHelp.TryUseAction(mH, "邪甲术") then
					return true
				end;
				if u5 <= 2 and u5 > 0 then
					if GetStatus("STATUS_痛苦_鬼影缠身") and AutoHelp.TryUseAction(targetInfo, "鬼影缠身") then
						return true
					end
				end;
				if GetStatus("HEAL_STATUS_自动换蓝") and r7 <= 0.10 and mT >= 0.35 and AutoHelp.TryUseAction(mH, "生命分流") then
					return true
				end;
				if AutoHelp.Glyphs[63320] and (AutoHelp.GetBuffRemainTime("player", "生命分流") <= 5 or not AutoHelp.UnitBuff("player", "生命分流")) and AutoHelp.TryUseAction(mH, "生命分流1") then
					return true
				end;
				if GetStatus("STATUS_吸取碎片") and AutoHelp.GetItemCount(6265) < 20 and UnitLevel("target") ~= - 1 then
					if AutoHelp.TryUseAction(targetInfo, "吸取灵魂") then
						return true
					end
				end;
				if GetStatus("STATUS_痛苦_暗影烈焰") and iG <= 5 and AutoHelp.TryUseAction(mH, "暗影烈焰") then
					return true
				end;
				if rV and GetStatus("STATUS_痛苦_腐蚀之种") and not AutoHelp.IsMoving then
					if AutoHelp.TryUseAction(targetInfo, "腐蚀之种") then
						return true
					end
				end;
				if GetStatus("STATUS_多目标痛") and not MouseoverIsTarget() and UnitCanAttack("player", "mouseover") then
					local s1, s2 = AutoHelp.GetRange("mouseover")
					local u4 = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(172), true)
					local up = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(980), true)
					if GetStatus("STATUS_痛苦_腐蚀术") and s2 <= 30 and u4 == 0 and AutoHelp.TryUseAction(mH, "腐蚀术鼠标") then
						return true
					end;
					if s2 <= 30 and up == 0 and AutoHelp.TryUseAction(mH, "痛苦诅咒鼠标") then
						return true
					end
				end;
				if GetStatus("STATUS_痛苦_暗影箭") and not AutoHelp.UnitHasDebuff("target", 17800) and not rm and AutoHelp.TryUseAction(targetInfo, "暗影箭") then
					return true
				end;
				if GetStatus("STATUS_痛苦_鬼影缠身") and AutoHelp.TryUseAction(targetInfo, "鬼影缠身") then
					return true
				end;
				if GetStatus("STATUS_斩杀痛苦无常") and rm or not rm then
					if GetStatus("STATUS_痛苦_痛苦无常") and not rm and AutoHelp.TryUseAction(targetInfo, "痛苦无常") then
						return true
					end
				end;
				if GetStatus("STATUS_斩杀痛苦诅咒") and rm or not rm then
					local us = u1() or "痛苦诅咒"
					local ut = AutoHelp.UnitHasDebuffByPlayer("target", GetSpellInfo(603))
					if not ut and us and AutoHelp.TryUseAction(targetInfo, us) then
						return true
					end
				end;
				if GetStatus("STATUS_痛苦_腐蚀术") and AutoHelp.TryUseAction(targetInfo, "腐蚀术") then
					if UnitLevel("target") == - 1 then
						SetCombatValue(UnitGUID("target"), rP())
					end;
					return true
				end;
				if GetStatus("STATUS_痛苦_腐蚀术") and UnitLevel("target") == - 1 and AutoHelp.UnitHasDebuffByPlayer("target", GetSpellInfo(172)) then
					local r_ = GetCombatNumber(UnitGUID("target"))
					local s0 = rP()
					if r_ == 0 then
						SetCombatValue(UnitGUID("target"), s0)
					else
						if r_ ~= 0 and s0 > r_ + 2 then
							if AutoHelp.TryUseAction(targetInfo, "腐蚀术2") then
								AutoHelp.Debug(">>重补腐蚀术, 收益增加(" .. floor(r_) .. "=>" .. floor(s0) .. ")")
								SetCombatValue(UnitGUID("target"), s0)
								return true
							end
						end
					end
				end;
				if GetStatus("STATUS_痛苦_暗影箭") and AutoHelp.UnitHasBuff("player", "暗影冥思") and AutoHelp.TryUseAction(targetInfo, "暗影箭") then
					AutoHelp.Debug(">>夜幕天赋触发瞬发暗影箭.")
					return true
				end;
				if GetStatus("STATUS_痛苦_吸取灵魂") and rm and AutoHelp.TryUseAction(targetInfo, "吸取灵魂") then
					return true
				end;
				if GetStatus("STATUS_痛苦_暗影箭") and AutoHelp.TryUseAction(targetInfo, "暗影箭") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("HEAL_STATUS_自动换蓝") and r7 <= 0.8 and mT >= 0.5 and AutoHelp.TryUseAction(mH, "生命分流") then
					return true
				end
			end;
			local function ux()
				if GetStatus("STATUS_毁灭_邪甲术") and AutoHelp.TryUseAction(mH, "邪甲术") then
					return true
				end;
				if GetStatus("HEAL_STATUS_自动换蓝") and r7 <= 0.10 and mT >= 0.35 and AutoHelp.TryUseAction(mH, "生命分流") then
					return true
				end;
				if AutoHelp.Glyphs[63320] and (AutoHelp.GetBuffRemainTime("player", "生命分流") <= 5 or not AutoHelp.UnitBuff("player", "生命分流")) and AutoHelp.TryUseAction(mH, "生命分流1") then
					return true
				end;
				if GetStatus("STATUS_吸取碎片") and AutoHelp.GetItemCount(6265) < 20 and UnitLevel("target") ~= - 1 then
					if AutoHelp.TryUseAction(targetInfo, "吸取灵魂") then
						return true
					end
				end;
				if GetStatus("STATUS_毁灭_暗影烈焰") and iG <= 8 and AutoHelp.TryUseAction(mH, "暗影烈焰") then
					return true
				end;
				if rV and GetStatus("STATUS_毁灭_腐蚀之种") and not AutoHelp.IsMoving then
					if AutoHelp.TryUseAction(targetInfo, "腐蚀之种") then
						return true
					end
				end;
				if GetStatus("STATUS_多目标痛") and not MouseoverIsTarget() and UnitCanAttack("player", "mouseover") then
					local s1, s2 = AutoHelp.GetRange("mouseover")
					local u4 = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(172), true)
					local up = AutoHelp.GetDebuffRemainTime("mouseover", GetSpellInfo(980), true)
					if GetStatus("STATUS_痛苦_腐蚀术") and s2 <= 30 and u4 == 0 and AutoHelp.TryUseAction(mH, "腐蚀术鼠标") then
						return true
					end;
					if s2 <= 30 and up == 0 and AutoHelp.TryUseAction(mH, "痛苦诅咒鼠标") then
						return true
					end
				end;
				if u1() then
					local us = u1() or "厄运诅咒"
					local ut = AutoHelp.UnitHasDebuffByPlayer("target", GetSpellInfo(603))
					if not ut and us and AutoHelp.TryUseAction(targetInfo, us) then
						return true
					end
				end;
				if GetStatus("STATUS_毁灭_献祭") and AutoHelp.TryUseAction(targetInfo, "献祭") then
					return true
				end;
				if GetStatus("STATUS_毁灭_燃烧") and AutoHelp.TryUseAction(targetInfo, "燃烧") then
					return true
				end;
				if GetStatus("STATUS_毁灭_混乱之箭") and AutoHelp.TryUseAction(targetInfo, "混乱之箭") then
					return true
				end;
				if GetStatus("STATUS_毁灭_烧尽") and AutoHelp.TryUseAction(targetInfo, "烧尽") then
					return true
				end;
				if GetStatus("STATUS_痛苦_腐蚀术") and AutoHelp.TryUseAction(targetInfo, "腐蚀术") then
					return true
				end;
				if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
					StopAttack()
				end;
				if GetStatus("HEAL_STATUS_自动换蓝") and r7 <= 0.8 and mT >= 0.5 and AutoHelp.TryUseAction(mH, "生命分流") then
					return true
				end
			end;
			if not AutoHelp.IsMoving then
				if GetStatus("HEAL_STATUS_召唤宝宝") and not UnitExists('pet') then
					local ui = jy("SSDOGNAME")
					if ui ~= nil and AutoHelp.TryUseAction(mH, "恶魔支配") then
						return true
					end;
					if ui ~= nil and AutoHelp.UnitHasBuff("player", "恶魔支配") and AutoHelp.TryUseAction(mH, ui) then
						return true
					end
				end
			end;
			if rW() then
				return true
			end;
			if jy("HEALMODE") == "恶魔" then
				if un() then
					return true
				end
			end;
			if jy("HEALMODE") == "痛苦" then
				if uw() then
					return true
				end
			end;
			if jy("HEALMODE") == "毁灭" then
				if ux() then
					return true
				end
			end;
			if iG > 2 and IsPlayerAttacking(targetInfo["unit"]) then
				StopAttack()
			end;
			if GetStatus("STATUS_治疗_射击") and not IsAutoRepeatSpell("射击") and not AutoHelp.IsMoving and AutoHelp.TryUseAction(targetInfo, "射击") then
				return true
			end;
			if InCombatLockdown() and not IsAutoRepeatSpell("射击") and not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
				return true
			end
		end
	end;
	if PlayerIsClass("WARLOCK") then
		AutoHelp.ClassConfig = t_
	end
end;
if AutoHelp.isWotlk then
	local function uy()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {}
		AutoHelp.CAN_RESCURIT = false;
		AutoHelp.CAN_HEAL = false;
		AutoHelp.CAN_BUFF = false;
		AutoHelp.CAN_DISPEL = false;
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 2;
		AutoHelp.AttackRange = 30;
		AutoHelp.ZUIZONG_SPELLS = {}
		AutoHelp.DINCHI_SPELLS = {}
		AutoHelp.SHOUHU_SPELLS = {}
		AutoHelp.CommingHealWindow = 0;
		AutoHelp.NOSTANCES = {}
		local function uz(hK, jI)
			if jI then
				if hK ~= "灵猴守护" then
					SetConfig("STATUS_灵猴守护", false)
				end;
				if hK ~= "雄鹰守护" then
					SetConfig("STATUS_雄鹰守护", false)
				end;
				if hK ~= "龙鹰守护" then
					SetConfig("STATUS_龙鹰守护", false)
				end;
				if hK ~= "猎豹守护" then
					SetConfig("STATUS_猎豹守护", false)
				end;
				if hK ~= "野兽守护" then
					SetConfig("STATUS_野兽守护", false)
				end;
				if hK ~= "豹群守护" then
					SetConfig("STATUS_豹群守护", false)
				end;
				if hK ~= "野性守护" then
					SetConfig("STATUS_野性守护", false)
				end;
				if hK ~= "蝰蛇守护" then
					SetConfig("STATUS_蝰蛇守护", false)
				end
			end
		end;
		local function uA()
			if GetStatus("STATUS_灵猴守护") then
				return "灵猴守护"
			end;
			if GetStatus("STATUS_雄鹰守护") then
				return "雄鹰守护"
			end;
			if GetStatus("STATUS_猎豹守护") then
				return "猎豹守护"
			end;
			if GetStatus("STATUS_野兽守护") then
				return "野兽守护"
			end;
			if GetStatus("STATUS_豹群守护") then
				return "豹群守护"
			end;
			if GetStatus("STATUS_野性守护") then
				return "野性守护"
			end;
			if GetStatus("STATUS_龙鹰守护") then
				return "龙鹰守护"
			end;
			if GetStatus("STATUS_蝰蛇守护") then
				return "蝰蛇守护"
			end
		end;
		local function ru(hK, jI)
			if jI then
				if hK ~= "单体" then
					SetConfig("STATUS_单体输出", false)
				end;
				if hK ~= "自动" then
					SetConfig("STATUS_自动输出", false)
				end
			end
		end;
		local function s5()
			if GetStatus("STATUS_单体输出") then
				return "单体"
			end;
			if GetStatus("STATUS_自动输出") then
				return "自动"
			end
		end;
		local n9 = {
			{
				name = "宠物攻击",
				macro = "/petattack",
				spellName = "宠物攻击",
				spellTime = 0.5,
				desc = ""
			},
			{
				name = "自动射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "攻击",
				spellId = true,
				["target"] = true
			},
			{
				name = "猛禽一击",
				spellId = true,
				["target"] = true
			},
			{
				name = "猫鼬撕咬",
				spellId = true,
				["target"] = true
			},
			{
				name = "灵猴守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "雄鹰守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "猎豹守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "野性守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "豹群守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "野兽守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "蝰蛇守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "龙鹰守护",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "奥术射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "稳固射击",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "猎人印记",
				spellId = true,
				["target"] = true,
				["debuffNameCID"] = true
			},
			{
				name = "震荡射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "爆炸射击",
				spellId = true,
				["target"] = true,
				["macro"] = "/castsequence reset=2,target 爆炸射击,爆炸射击(等级 3)",
				["fastSpell"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "爆炸射击3",
				spellId = 60052,
				["target"] = true,
				["fastSpell"] = true
			},
			{
				name = "黑箭",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "杀戮射击",
				spellId = true,
				["target"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "奇美拉射击",
				spellId = true,
				["target"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "宁神射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "治疗宠物",
				spellId = true,
				["pet"] = true,
				["petCID"] = true
			},
			{
				name = "跟随",
				spellId = true,
				["macro"] = "/PetFollow"
			},
			{
				name = "假死",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "复活宠物",
				spellId = true
			},
			{
				name = "驯服野兽",
				spellId = true
			},
			{
				name = "追踪人型生物",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪野兽",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪亡灵",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪隐藏生物",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪元素生物",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪恶魔",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪巨人",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "追踪龙类",
				spellId = true,
				["trackingNameCID"] = true
			},
			{
				name = "急速射击",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "多重射击",
				spellId = true,
				["target"] = true
			},
			{
				name = "陷阱发射器：爆炸陷阱",
				spellId = true,
				["macro"] = "/cast [@cursor,nochanneling:陷阱发射器：爆炸陷阱]陷阱发射器：爆炸陷阱\n"
			},
			{
				name = "爆炸陷阱鼠标指向",
				spellId = 425777,
				["macro"] = "/cast [@cursor,nochanneling:陷阱发射器：爆炸陷阱]陷阱发射器：爆炸陷阱\n"
			},
			{
				name = "爆炸陷阱鼠标点击",
				spellId = 425777,
				["macro"] = "/cast [nochanneling:陷阱发射器：爆炸陷阱]陷阱发射器：爆炸陷阱\n"
			},
			{
				name = "乱射",
				spellId = true,
				["macro"] = "/cast [@cursor,nochanneling:乱射] 乱射\n",
				["fastSpell"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "乱射鼠标指向",
				spellId = 58434,
				["macro"] = "/cast [@cursor,nochanneling:乱射] 乱射\n",
				["fastSpell"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "乱射鼠标点击",
				spellId = 58434,
				["macro"] = "/cast [nochanneling:乱射] 乱射\n",
				["fastSpell"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "瞄准射击",
				spellId = true,
				["target"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "误导",
				spellId = true,
				["target"] = true
			},
			{
				name = "毒蛇钉刺",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true,
				["crits"] = {
					"杀戮命令"
				},
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "毒蝎钉刺",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "蝰蛇钉刺",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "翼龙钉刺",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "喂养宠物",
				spellId = true,
				["pet"] = true
			},
			{
				name = "解散野兽",
				spellId = true
			},
			{
				name = "召唤宠物",
				spellId = true
			},
			{
				name = "强击光环",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				["name"] = "选中镜像",
				["macro"] = "/targetexact 裹体之网\n/targetexact 镜像\n/cast [exists]攻击\n/cast [exists]奥术射击\n/cast [exists]瞄准射击\n/petattack\n",
				["spellName"] = "选中镜像",
				["spellTime"] = 1,
				["desc"] = "选中镜像"
			}
		}
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "生存"
			AutoHelp.ModeDefaultSetting = {
				["HEAL_STATUS_START"] = true,
				["STATUS_主动攻击"] = true,
				["STATUS_治疗模式"] = false
			}
			AutoHelp.HEAL_MODES = {
				["生存"] = {
					["modetip"] = "\124cffFFF569已设置为系统缺省【生存】猎人。\124r"
				},
				["射击"] = {
					["modetip"] = "\124cffFFF569已设置为【射击】。\124r"
				},
				["野兽控制"] = {
					["modetip"] = "\124cffFFF569已设置为【野兽控制】。\124r"
				}
			}
			AutoHelp.ModeList = {
				{
					text = "输出模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00生存\124r",
					name = "生存",
					tooltipTitle = "生存猎人",
					tooltipText = "使用生存天赋。"
				},
				{
					text = "\124cffFFFFFF射击\124r",
					name = "射击",
					tooltipTitle = "射击猎人",
					tooltipText = "使用射击天赋"
				},
				{
					text = "\124cffFFFFFF野兽控制\124r",
					name = "野兽控制",
					tooltipTitle = "野兽控制",
					tooltipText = "使用野兽控制天赋"
				}
			}
			AutoHelp.PANELHEIGHT = 460;
			AutoHelp.PANELWIDTH = 160;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_蝰蛇回蓝",
						["value"] = true,
						["title"] = "回蓝",
						["tip"] = "当自己蓝量低于设定值，自动开启蝰蛇守护回蓝，当蓝量高于设定值时，自动切换回先前设定的守护，缺省值为8%开始回蓝，70%回蓝结束",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "wlk",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("蝰蛇守护") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_镜像蛛网",
						["value"] = true,
						["title"] = "镜像",
						["tip"] = "当目进入有镜像或者蛛网的副本时，自动优先打镜像和蛛网裹体",
						["point"] = 60,
						["nextpos"] = false,
						["version"] = "wlk",
						["create"] = function(ko)
							if AutoHelp.playerLevel < 80 then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象",
						["point"] = 110,
						["nextpos"] = false,
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象",
						["point"] = 5,
						["nextpos"] = true,
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_蝰蛇回蓝",
						["value"] = true,
						["title"] = "自动回蓝",
						["tip"] = "当自己蓝量低于设定值，自动开启蝰蛇守护回蓝，当蓝量高于设定值时，自动切换回先前设定的守护，缺省值为8%开始回蓝，70%回蓝结束",
						["point"] = 80,
						["nextpos"] = false,
						["version"] = "classic",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("蝰蛇守护") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["title"] = "\124cffFFF569AOE\124r",
						["tipTitle"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE(乱射)功能，如果怪物数量大于等于3个，将自动启动AOE技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能. 如果技能选择了爆炸陷阱发射器, 请自动将鼠标指向目标位置!\124r",
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("乱射") then
								ko:Disable()
							end
						end,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_生存_乱射", true)
								SetConfig("STATUS_生存_多重射击", true)
								SetConfig("STATUS_射击_乱射", true)
								SetConfig("STATUS_射击_多重射击", true)
								SetConfig("STATUS_野兽控制_乱射", true)
								SetConfig("STATUS_野兽控制_多重射击", true)
							else
								SetConfig("STATUS_生存_乱射", false)
								SetConfig("STATUS_生存_多重射击", false)
								SetConfig("STATUS_射击_乱射", false)
								SetConfig("STATUS_射击_多重射击", false)
								SetConfig("STATUS_野兽控制_乱射", false)
								SetConfig("STATUS_野兽控制_多重射击", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_指向施法",
						["value"] = true,
						["title"] = "指向",
						["tipTitle"] = "鼠标指向施法",
						["tip"] = "自动施放飓风时鼠标指向需要AOE的位置即可。\n\n\124cff00ff00指向位置必须有敌对目标或者坦克.\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("乱射") then
								ko:Disable()
							end
						end,
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_点击施法", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_点击施法",
						["value"] = false,
						["title"] = "点击",
						["tipTitle"] = "鼠标点击施法",
						["tip"] = "自动施放飓风时, 会出现蓝色位置圈, 需要用鼠标点击目标位置才会继续施放。\n\n\124cff00ff00点击施法会停滞后续自动施法, 只有点击目标位置后, 才能继续运行!\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("乱射") then
								ko:Disable()
							end
						end,
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_指向施法", false)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00守护选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_猎豹守护",
						["value"] = false,
						["title"] = "\124cffFFF569豹\124r",
						["tip"] = "自动切换猎豹守护",
						["point"] = 0,
						["hitRect"] = - 20,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("猎豹守护") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							uz("猎豹守护", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_豹群守护",
						["value"] = false,
						["title"] = "\124cffFFF569群\124r",
						["tip"] = "自动切换豹群守护",
						["point"] = 40,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("豹群守护") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							uz("豹群守护", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_雄鹰守护",
						["value"] = false,
						["title"] = "\124cffFFF569雄\124r",
						["tip"] = "自动切换雄鹰守护",
						["point"] = 80,
						["hide"] = AutoHelp.HasActionKey("龙鹰守护"),
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("雄鹰守护") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							uz("雄鹰守护", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_龙鹰守护",
						["value"] = true,
						["title"] = "\124cffFFF569龙\124r",
						["tip"] = "自动切换龙鹰守护",
						["point"] = 80,
						["hide"] = not AutoHelp.HasActionKey("龙鹰守护"),
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("龙鹰守护") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							uz("龙鹰守护", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_蝰蛇守护",
						["value"] = false,
						["title"] = "\124cffFFF569蝰\124r",
						["tip"] = "自动切换蝰蛇守护",
						["point"] = 120,
						["hitRect"] = - 20,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("蝰蛇守护") then
								ko:Disable()
							end
						end,
						["fnc"] = function(hK)
							uz("蝰蛇守护", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_误导",
						["value"] = true,
						["title"] = "误导",
						["tip"] = "\124cff00ff00自动误导给队友，一般自动误导给当前坦克\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true
					},
					{
						["type"] = "button",
						["id"] = "HEAL_STATUS_误导对象",
						["title"] = "选择误导",
						["tipTitle"] = "误导队友选择",
						["tip"] = "\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动误导\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["create"] = function(kl)
							local cd = jy("误导对象")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo == nil and jy("误导对象") == "无" then
								AutoHelp.Debug("要设置误导目标请先选择队友！")
								return
							end;
							if tInfo ~= nil then
								if tInfo["unit"] == "player" then
									AutoHelp.Debug("不能设置自己为误导目标！")
									return
								end;
								SetConfig("误导对象", tInfo["name"])
								AutoHelp.Debug("设置误导目标：" .. tInfo["name"])
							else
								SetConfig("误导对象", "无")
								AutoHelp.Debug("清除误导目标。")
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00攻击技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					}
				},
				["setting"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00宠物设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_复活宠物",
						["value"] = false,
						["title"] = "复活宠物",
						["tip"] = "非战斗中，自动复活宠物",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_召唤宠物",
						["value"] = false,
						["title"] = "召唤宠物",
						["tip"] = "非战斗中，自动召唤宠物",
						["point"] = 80,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_治疗宠物",
						["value"] = true,
						["title"] = "治疗宠物",
						["tip"] = "战斗中，自动治疗宠物",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_召回宠物",
						["value"] = true,
						["hide"] = true,
						["title"] = "召回宠物",
						["tip"] = "战斗中，如果宠物血量过低，自动召回宠物",
						["point"] = 80,
						["nextpos"] = false
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING2",
						["value"] = "\124cff00ff00猎人设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_蝰蛇回蓝",
						["value"] = true,
						["title"] = "回蓝",
						["tip"] = "当自己蓝量低于设定值，自动开启蝰蛇守护回蓝，当蓝量高于设定值时，自动切换回先前设定的守护，缺省值为5%开始回蓝，70%回蓝结束",
						["point"] = 8,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_回蓝开始值",
						["value"] = 8,
						["point"] = 70,
						["width"] = 30,
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_回蓝结束值",
						["value"] = 70,
						["point"] = 110,
						["width"] = 30,
						["percent"] = "%",
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_自动假死",
						["value"] = false,
						["title"] = "OT假死",
						["tip"] = "当对BOSS仇恨高于设定值时，自动使用假死消除仇恨，缺省设置仇恨高于90%时使用",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_仇恨值",
						["value"] = 90,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false
					}
				}
			}
			local qQ = {
				{
					{
						"生存_猎人印记",
						"猎人印记",
						false,
						"印记",
						"生存"
					},
					{
						"生存_猛禽一击",
						"猛禽一击",
						true,
						"猛禽",
						"生存"
					},
					{
						"生存_猫鼬撕咬",
						"猫鼬撕咬",
						true,
						"猫鼬",
						"生存"
					},
					{
						"生存_杀戮射击",
						"杀戮射击",
						true,
						"杀戮",
						"生存"
					},
					{
						"生存_毒蛇钉刺",
						"毒蛇钉刺",
						true,
						"毒蛇",
						"生存"
					},
					{
						"生存_爆炸射击",
						"爆炸射击",
						true,
						"爆炸",
						"生存"
					},
					{
						"生存_稳固射击",
						"稳固射击",
						true,
						"稳固",
						"生存"
					},
					{
						"生存_瞄准射击",
						"瞄准射击",
						true,
						"瞄准",
						"生存"
					},
					{
						"生存_多重射击",
						"多重射击",
						true,
						"多重",
						"生存"
					},
					{
						"生存_爆炸陷阱",
						"陷阱发射器：爆炸陷阱",
						true,
						"爆陷",
						"生存"
					},
					{
						"生存_乱射",
						"乱射",
						false,
						"乱射",
						"生存"
					},
					{
						"生存_黑箭",
						"黑箭",
						false,
						"黑箭",
						"生存"
					},
					{
						"生存_急速射击",
						"急速射击",
						true,
						"急速",
						"生存"
					}
				},
				{
					{
						"射击_猎人印记",
						"猎人印记",
						false,
						"印记",
						"射击"
					},
					{
						"射击_强击光环",
						"强击光环",
						true,
						"光环",
						"射击"
					},
					{
						"射击_猛禽一击",
						"猛禽一击",
						true,
						"猛禽",
						"射击"
					},
					{
						"射击_猫鼬撕咬",
						"猫鼬撕咬",
						true,
						"猫鼬",
						"射击"
					},
					{
						"射击_杀戮射击",
						"杀戮射击",
						true,
						"杀戮",
						"射击"
					},
					{
						"射击_毒蛇钉刺",
						"毒蛇钉刺",
						true,
						"毒蛇",
						"射击"
					},
					{
						"射击_奥术射击",
						"奥术射击",
						true,
						"奥术",
						"射击"
					},
					{
						"射击_稳固射击",
						"稳固射击",
						true,
						"稳固",
						"射击"
					},
					{
						"射击_奇美拉射击",
						"奇美拉射击",
						true,
						"奇射",
						"射击"
					},
					{
						"射击_瞄准射击",
						"瞄准射击",
						true,
						"瞄准",
						"射击"
					},
					{
						"射击_多重射击",
						"多重射击",
						true,
						"多重",
						"射击"
					},
					{
						"射击_爆炸陷阱",
						"陷阱发射器：爆炸陷阱",
						true,
						"爆陷",
						"射击"
					},
					{
						"射击_乱射",
						"乱射",
						false,
						"乱射",
						"射击"
					},
					{
						"射击_急速射击",
						"急速射击",
						true,
						"急速",
						"射击"
					}
				},
				{
					{
						"野兽控制_猎人印记",
						"猎人印记",
						false,
						"印记",
						"野兽控制"
					},
					{
						"野兽控制_猛禽一击",
						"猛禽一击",
						true,
						"猛禽",
						"野兽控制"
					},
					{
						"野兽控制_猫鼬撕咬",
						"猫鼬撕咬",
						true,
						"猫鼬",
						"野兽控制"
					},
					{
						"野兽控制_杀戮射击",
						"杀戮射击",
						true,
						"杀戮",
						"野兽控制"
					},
					{
						"野兽控制_毒蛇钉刺",
						"毒蛇钉刺",
						true,
						"毒蛇",
						"野兽控制"
					},
					{
						"野兽控制_奥术射击",
						"奥术射击",
						true,
						"奥术",
						"野兽控制"
					},
					{
						"野兽控制_稳固射击",
						"稳固射击",
						true,
						"稳固",
						"野兽控制"
					},
					{
						"野兽控制_奇美拉射击",
						"奇美拉射击",
						true,
						"奇射",
						"野兽控制"
					},
					{
						"野兽控制_瞄准射击",
						"瞄准射击",
						true,
						"瞄准",
						"野兽控制"
					},
					{
						"野兽控制_多重射击",
						"多重射击",
						true,
						"多重",
						"野兽控制"
					},
					{
						"野兽控制_爆炸陷阱",
						"陷阱发射器：爆炸陷阱",
						true,
						"爆陷",
						"野兽控制"
					},
					{
						"野兽控制_乱射",
						"乱射",
						false,
						"乱射",
						"野兽控制"
					},
					{
						"野兽控制_急速射击",
						"急速射击",
						true,
						"急速",
						"野兽控制"
					}
				}
			}
			if not GetSpellInfo("爆炸射击") then
				table.insert(qQ[1], 6, {
					"生存_奥术射击",
					"奥术射击",
					true,
					"奥术",
					"生存"
				})
			end;
			for _, qR in pairs(qQ) do
				local jS = 1;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 3 == 1 then
							point = 5;
							kf = true
						elseif jS % 3 == 2 then
							point = 55;
							kf = false
						else
							point = 105;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tipTitle"] = qS[2],
							["tip"] = qS[2],
							["point"] = point,
							["nextpos"] = kf,
							["stance"] = qS[5],
							["mode"] = qS[5]
						}
						if qS[6] then
							eS["tip"] = qS[6]
						end;
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if kH == nil then
				return
			end;
			for bi, bn in pairs(AutoHelp.SettingItems) do
				if bn.mode then
					if Contains(bn.mode, kH) or bn.mode == "attack" then
						bn:Show()
					else
						bn:Hide()
					end
				end
			end;
			AutoHelp.ResizePanel()
		end;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
			local cx = GetSpellInfo(ca)
			if ho == "player" then
				if cx == "神圣牺牲" then
					if GetStatus("HEAL_STATUS_取消牺牲") then
						AutoHelp.AddNextAction(HEAL_RAID["player"], "取消牺牲", 0)
						AutoHelp.Debug(">>已经取消神圣牺牲小队伤害分担！")
					end
				end
			end;
			if cx == "神圣牺牲" or cx == "光环掌握" then
				if GetStatus("HEAL_STATUS_通告牺牲") then
					AutoHelp.SendChatMsg(">>>" .. UnitName(ho) .. "已释放【" .. cx .. "】<<<", IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or IsInRaid() and "RAID" or IsInGroup() and "PARTY")
				end
			end
		end;
		function AutoHelp.AutoCreateMacro()
			if AutoHelp.HasActionKey("乱射") then
				local pj = FindOrCreateMacro("AH乱射", nil, "#showtooltips 乱射\n/stopcasting\n/ahcast 乱射\n", 1)
			end;
			if AutoHelp.HasActionKey("陷阱发射器：爆炸陷阱") then
				local pj = FindOrCreateMacro("AH爆炸陷阱", nil, "#showtooltips 陷阱发射器：爆炸陷阱\n/stopcasting\n/ahcast 陷阱发射器：爆炸陷阱\n", 2)
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52)
			AutoHelp.Debug("乱射/发射爆炸陷阱(鼠标指向)宏已经被创建, 请按照需要将这些宏拖到合适的按钮位置!")
		end;
		function AutoHelp.ThreatChanged(mt, sQ, sR, sS)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_自动假死") then
				return
			end;
			local jp = GetStatusNumber("HEAL_VALUE_仇恨值") or 90;
			if mt >= 2 then
				if GetStatus("HEAL_STATUS_自动假死") then
					AutoHelp.AddCastAction("假死")
					AutoHelp.Debug(">>>>你OT了，自动使用假死！")
				else
					AutoHelp.Debug(">>>>你OT了，请使用假死消除仇恨！")
				end
			end;
			if mt == 1 and sQ >= jp then
				if GetStatus("HEAL_STATUS_自动假死") then
					AutoHelp.AddCastAction("假死")
					AutoHelp.Debug(">>>>仇恨过高:" .. sQ .. "%，自动使用假死！")
				else
					AutoHelp.Debug(">>>>仇恨过高:" .. sQ .. "%，请使用假死消除仇恨！")
				end
			end
		end;
		function AutoHelp.EncounterStart(sT, sU, rx, sV)
			if sT == 1130 or sT == 757 then
				AutoHelp.Debug(">>>奥尔加隆之战开始，自动禁止AOE技能！！！")
				SaveConfigValue("HEAL_STATUS_AOE", false)
			end
		end;
		function AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
			if sT == 1130 or sT == 757 then
				AutoHelp.Debug(">>>奥尔加隆之战结束，自动恢复AOE技能！！！")
				RestoreConfigValue("HEAL_STATUS_AOE")
			end
		end;
		local uB = nil;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("误导对象", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_STATUS_误导对象"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			AutoHelp.RegisterKeyCallback("STATUS_生存_黑箭", function(jI)
				if jI then
					SetConfig("STATUS_生存_爆炸陷阱", false)
				end
			end)
			AutoHelp.RegisterKeyCallback("STATUS_生存_爆炸陷阱", function(jI)
				if jI then
					SetConfig("STATUS_生存_黑箭", false)
				end
			end)
			if AutoHelp.isWotlk then
				if AutoHelp.HEAL_PLAYER_TALENTS[GetSpellInfo(52788)] > 0 then
					local uC = {
						"追踪人型生物",
						"追踪野兽",
						"追踪亡灵",
						"追踪隐藏生物",
						"追踪元素生物",
						"追踪恶魔",
						"追踪巨人",
						"追踪龙类"
					}
					local uD = false;
					for _, cd in pairs(uC) do
						if AutoHelp.HasActionKey(cd) and AutoHelp.HasTrackingBuff(cd) then
							uD = true
						end
					end;
					if not uD then
						for i = # uC, 1, - 1 do
							local cd = uC[i]
							if AutoHelp.HasActionKey(cd) then
								AutoHelp.SetTrackingBuff(cd)
								AutoHelp.Debug(">>自动设置追踪对象:" .. cd .. ", 提高5%伤害[强化追踪]!")
								break
							end
						end
					end
				end
			end
		end;
		local uE;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
			local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
			if not rX and InCombatLockdown() and GetStatus("HEAL_STATUS_镜像蛛网") then
				if FindEnemyUnit("镜像") or FindEnemyUnit("裹体之网") then
					AutoHelp.Debug(">>有镜像或者蛛网裹体需要击杀")
					if AutoHelp.TryUseAction(mH, "选中镜像") then
						return true
					end
				end
			end
		end;
		local uF = false;
		function AutoHelp.Player_Regen_Enabled()
			if not GetStatus("HEAL_STATUS_PAUSE") and GetStatus("HEAL_STATUS_蝰蛇回蓝") and AutoHelp.HasActionKey("蝰蛇守护") and not AutoHelp.UnitHasBuff("player", "蝰蛇守护") then
				local mH = HEAL_RAID["player"]
				local mT, r7 = mH["hp"], mH["mp"]
				if r7 <= 0.9 and AutoHelp.TryUseAction(mH, "蝰蛇守护") then
					uF = true
				end
			end
		end;
		function AutoHelp.Player_Regen_Disabled()
			if GetStatus("HEAL_STATUS_蝰蛇回蓝") and AutoHelp.HasActionKey("蝰蛇守护") and AutoHelp.UnitHasBuff("player", "蝰蛇守护") then
				local mH = HEAL_RAID["player"]
				local mT, r7 = mH["hp"], mH["mp"]
				if r7 >= 0.5 then
					uF = false
				end
			end
		end;
		function AutoHelp.DoCommonAction(mH)
			if IsMounted() or IsFlying() then
				return false
			end;
			local mT, r7 = mH["hp"], mH["mp"]
			local uG, uH = GetStatusNumber("HEAL_VALUE_回蓝开始值") / 100 or 0.08, GetStatusNumber("HEAL_VALUE_回蓝结束值") / 100 or 0.6;
			if GetStatus("HEAL_STATUS_蝰蛇回蓝") and AutoHelp.HasActionKey("蝰蛇守护") and not AutoHelp.UnitHasBuff("player", "蝰蛇守护") then
				if r7 <= uG and AutoHelp.TryUseAction(mH, "蝰蛇守护") then
					uF = true;
					return true
				end
			end;
			if uF and (r7 >= 0.95 or r7 >= uH and InCombatLockdown()) then
				uF = false
			end;
			if uF and AutoHelp.AssistUnit and UnitAffectingCombat(AutoHelp.AssistUnit) and not InCombatLockdown() and r7 >= 0.5 then
				uF = false
			end;
			local uI = uA()
			if not uF and uI and uI ~= "无" and not (IsMounted() or IsFlying()) then
				if not AutoHelp.UnitHasBuff("player", uI) and AutoHelp.TryUseAction(mH, uI) then
					return true
				end
			end;
			local uJ, uK = HasPetUI()
			if UnitExists("pet") and not UnitIsDead("pet") then
				local uL = UnitHealth("playerpet") / UnitHealthMax("playerpet")
				if GetStatus("HEAL_STATUS_治疗宠物") and uL <= 0.7 and not AutoHelp.UnitHasBuff("playerpet", "治疗宠物") and AutoHelp.TryUseAction(mH, "治疗宠物") then
					return true
				end
			end;
			if InCombatLockdown() and GetStatus("HEAL_STATUS_误导") then
				local lw = jy("误导对象")
				if lw and lw ~= "无" then
					local oz = HEAL_RAID_NAMES[lw]
					if not oz or oz == "player" then
						SetConfig("误导对象", "无")
					else
						if not AutoHelp.UnitHasBuff("player", "误导") and AutoHelp.TryUseAction(HEAL_RAID[oz], "误导") then
							AutoHelp.DebugText = "自动误导"
							return true
						end
					end
				end
			end
		end;
		function AutoHelp.DoUncombatAction(mH)
			if not AutoHelp.IsMoving then
				if GetStatus("HEAL_STATUS_召唤宠物") and not HEAL_PET_ISDEAD and not UnitExists('pet') and not UnitIsDead("pet") and AutoHelp.TryUseAction(mH, "召唤宠物") then
					return true
				end;
				if GetStatus("HEAL_STATUS_复活宠物") and HEAL_PET_ISDEAD and AutoHelp.TryUseAction(mH, "复活宠物") then
					HEAL_PET_ISDEAD = false;
					return true
				end
			end
		end;
		local rU;
		local uM;
		local uN;
		local uO;
		local uP;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, r7 = mH["hp"], mH["mp"] * 100;
			local uQ = IsPlayerAttacking(targetInfo["unit"])
			local rm = targetInfo and targetInfo["hp"] <= 0.2;
			local sj = AutoHelp.castinfo.nextSwing;
			local t4 = IsSpellInRange(GetSpellInfo(75), targetInfo["unit"]) == 1;
			local t5 = AutoHelp.UnitInMeleeRange(targetInfo["unit"])
			local t6 = CheckInteractDistance(targetInfo["unit"], 4) and not t4 and not t5;
			local t8 = CheckInteractDistance(targetInfo["unit"], 4) and not t4;
			local t9 = not CheckInteractDistance(targetInfo["unit"], 4) and not t4;
			local ib, iG = AutoHelp.GetRange("target")
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local function uR()
				local so = MouseoverIsTank() or MouseoverCanAttack()
				local sq = AutoHelp.getNumberTargets()
				local sr = sq >= 3 and so;
				if GetStatus("STATUS_点击施法") and SpellIsTargeting() then
					return false
				end;
				if GetStatus("STATUS_生存_猎人印记") and (AutoHelp.IsInRaid and UnitLevel("target") == - 1) then
					local uS = uP == UnitGUID(targetInfo["unit"]) and uO ~= nil and GetTime() <= uO + 30;
					if not uS and AutoHelp.TryUseAction(targetInfo, "猎人印记") then
						uO = GetTime()
						uP = UnitGUID(targetInfo["unit"])
						return true
					end
				end;
				if t5 and not t4 and not IsAutoRepeatSpell("自动射击") then
					if GetStatus("STATUS_生存_猛禽一击") and not sj and AutoHelp.TryUseAction(targetInfo, "猛禽一击") then
						return true
					end;
					if GetStatus("STATUS_生存_猫鼬撕咬") and not sj and AutoHelp.TryUseAction(targetInfo, "猫鼬撕咬") then
						return true
					end;
					if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
						return true
					end
				end;
				if t4 then
					if rm and GetStatus("STATUS_生存_杀戮射击") and AutoHelp.TryUseAction(targetInfo, "杀戮射击") then
						return true
					end;
					if GetStatus("STATUS_生存_急速射击") and rn and AutoHelp.TryUseAction(mH, "急速射击") then
						return true
					end;
					if GetStatus("STATUS_生存_爆炸陷阱") then
						if GetStatus("STATUS_点击施法") then
							if not SpellIsTargeting() and AutoHelp.TryUseAction(mH, "爆炸陷阱鼠标点击") then
								return true
							end
						elseif so then
							if AutoHelp.TryUseAction(mH, "爆炸陷阱鼠标指向") then
								return true
							end
						end
					elseif GetStatus("STATUS_生存_黑箭") then
						if AutoHelp.TryUseAction(targetInfo, "黑箭") then
							return true
						end
					end;
					if AutoHelp.GetDebuffRemainTime("target", "爆炸陷阱效果", true) >= 10 and AutoHelp.GetSpellCooldownTime("黑箭") == 0 then
						if AutoHelp.TryUseAction(targetInfo, "黑箭") then
							return true
						end
					end;
					if GetStatus("HEAL_STATUS_AOE") then
						if GetStatus("STATUS_指向施法") and sr then
							if GetStatus("STATUS_生存_乱射") and AutoHelp.TryUseAction(mH, "乱射鼠标指向") then
								return true
							end
						end;
						if GetStatus("STATUS_点击施法") and sq >= 3 then
							if not SpellIsTargeting() and GetStatus("STATUS_生存_乱射") and AutoHelp.TryUseAction(mH, "乱射鼠标点击") then
								return true
							end
						end
					end;
					if GetStatus("STATUS_生存_爆炸射击") and AutoHelp.TryUseAction(targetInfo, "爆炸射击") then
						return true
					end;
					if GetStatus("STATUS_生存_毒蛇钉刺") then
						local uS = uN == UnitGUID(targetInfo["unit"]) and uM ~= nil and GetTime() <= uM + 15;
						if not uS and AutoHelp.TryUseAction(targetInfo, "毒蛇钉刺") then
							uM = GetTime()
							uN = UnitGUID(targetInfo["unit"])
							return true
						end
					end;
					if GetStatus("STATUS_生存_多重射击") and (not GetStatus("STATUS_生存_瞄准射击") or sq >= 2) and AutoHelp.TryUseAction(targetInfo, "多重射击") then
						return true
					end;
					if GetStatus("STATUS_生存_瞄准射击") and AutoHelp.TryUseAction(targetInfo, "瞄准射击") then
						return true
					end;
					local _, action = AutoHelp.GetActionKey("稳固射击")
					if action and IsCurrentSpell(action["spellId"]) then
						AutoHelp.ForceBreakSpell = true;
						return false
					else
						AutoHelp.ForceBreakSpell = false
					end;
					local uT = GetStatus("STATUS_生存_爆炸射击") and AutoHelp.GetSpellCooldownTime("爆炸射击") >= 1 or not GetStatus("STATUS_生存_爆炸射击")
					local uU = not rm or rm and (GetStatus("STATUS_生存_杀戮射击") and AutoHelp.GetSpellCooldownTime("杀戮射击") >= 1 or not GetStatus("STATUS_生存_杀戮射击"))
					if GetStatus("STATUS_生存_稳固射击") and not AutoHelp.IsMoving and uT and uU and AutoHelp.TryUseAction(targetInfo, "稳固射击") then
						AutoHelp.ForceBreakSpell = true;
						return true
					end;
					if GetStatus("STATUS_生存_奥术射击") and AutoHelp.TryUseAction(targetInfo, "奥术射击") then
						return true
					end;
					if not IsAutoRepeatSpell("自动射击") and AutoHelp.TryUseAction(targetInfo, "攻击") then
						return true
					end
				end
			end;
			local function uV()
				local so = MouseoverIsTank() or MouseoverCanAttack()
				local sq = AutoHelp.getNumberTargets()
				local sr = sq >= 3 and so;
				if GetStatus("STATUS_点击施法") and SpellIsTargeting() then
					return false
				end;
				if GetStatus("STATUS_射击_猎人印记") then
					local uS = uP == UnitGUID(targetInfo["unit"]) and uO ~= nil and GetTime() <= uO + 30;
					if not uS and AutoHelp.TryUseAction(targetInfo, "猎人印记") then
						uO = GetTime()
						uP = UnitGUID(targetInfo["unit"])
						return true
					end
				end;
				if t5 and not t4 and not IsAutoRepeatSpell("自动射击") then
					if GetStatus("STATUS_射击_猛禽一击") and not sj and AutoHelp.TryUseAction(mH, "猛禽一击") then
						return true
					end;
					if GetStatus("STATUS_射击_猫鼬撕咬") and not sj and AutoHelp.TryUseAction(targetInfo, "猫鼬撕咬") then
						return true
					end;
					if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
						return true
					end
				end;
				if t4 then
					if rm and GetStatus("STATUS_射击_杀戮射击") and AutoHelp.TryUseAction(targetInfo, "杀戮射击") then
						return true
					end;
					if GetStatus("STATUS_射击_急速射击") and rn and AutoHelp.TryUseAction(mH, "急速射击") then
						return true
					end;
					if GetStatus("STATUS_射击_爆炸陷阱") then
						if GetStatus("STATUS_指向施法") and so then
							local s1, s2 = AutoHelp.GetRange("mouseover")
							if s2 and s2 <= 40 and AutoHelp.TryUseAction(targetInfo, "爆炸陷阱鼠标指向") then
								return true
							end
						end;
						if GetStatus("STATUS_点击施法") then
							if not SpellIsTargeting() and AutoHelp.TryUseAction(targetInfo, "爆炸陷阱鼠标点击") then
								return true
							end
						end
					end;
					if GetStatus("HEAL_STATUS_AOE") then
						if GetStatus("STATUS_指向施法") and sr then
							if GetStatus("STATUS_射击_乱射") and AutoHelp.TryUseAction(targetInfo, "乱射鼠标指向") then
								return true
							end
						end;
						if GetStatus("STATUS_点击施法") and sq >= 3 then
							if not SpellIsTargeting() and GetStatus("STATUS_射击_乱射") and AutoHelp.TryUseAction(targetInfo, "乱射鼠标点击") then
								return true
							end
						end
					end;
					if GetStatus("STATUS_射击_奇美拉射击") and AutoHelp.TryUseAction(targetInfo, "奇美拉射击") then
						return true
					end;
					if GetStatus("STATUS_射击_毒蛇钉刺") then
						local uS = uN == UnitGUID(targetInfo["unit"]) and uM ~= nil and GetTime() <= uM + 15;
						if not uS and AutoHelp.TryUseAction(targetInfo, "毒蛇钉刺") then
							uM = GetTime()
							uN = UnitGUID(targetInfo["unit"])
							return true
						end
					end;
					if GetStatus("STATUS_射击_多重射击") and (not GetStatus("STATUS_射击_瞄准射击") or sq >= 2) and AutoHelp.TryUseAction(targetInfo, "多重射击") then
						return true
					end;
					if GetStatus("STATUS_射击_瞄准射击") and AutoHelp.TryUseAction(targetInfo, "瞄准射击") then
						return true
					end;
					if GetStatus("STATUS_射击_奥术射击") and AutoHelp.TryUseAction(targetInfo, "奥术射击") then
						return true
					end;
					if GetStatus("STATUS_射击_稳固射击") and not AutoHelp.IsMoving and AutoHelp.TryUseAction(targetInfo, "稳固射击") then
						return true
					end;
					if not IsAutoRepeatSpell("自动射击") and AutoHelp.TryUseAction(targetInfo, "攻击") then
						return true
					end
				end
			end;
			local function uW()
				local so = MouseoverIsTank() or MouseoverCanAttack()
				local sq = AutoHelp.getNumberTargets()
				local sr = sq >= 3 and so;
				if GetStatus("STATUS_点击施法") and SpellIsTargeting() then
					return false
				end;
				if GetStatus("STATUS_野兽控制_猎人印记") or UnitLevel("target") == - 1 then
					local uS = uP == UnitGUID(targetInfo["unit"]) and uO ~= nil and GetTime() <= uO + 30;
					if not uS and AutoHelp.TryUseAction(targetInfo, "猎人印记") then
						uO = GetTime()
						uP = UnitGUID(targetInfo["unit"])
						return true
					end
				end;
				if t5 and not t4 and not IsAutoRepeatSpell("自动射击") then
					if GetStatus("STATUS_野兽控制_猛禽一击") and not sj and AutoHelp.TryUseAction(targetInfo, "猛禽一击") then
						return true
					end;
					if GetStatus("STATUS_野兽控制_猫鼬撕咬") and not sj and AutoHelp.TryUseAction(targetInfo, "猫鼬撕咬") then
						return true
					end;
					if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
						return true
					end
				end;
				if t4 then
					if rm and GetStatus("STATUS_野兽控制_杀戮射击") and AutoHelp.TryUseAction(targetInfo, "杀戮射击") then
						return true
					end;
					if GetStatus("STATUS_野兽控制_急速射击") and rn and AutoHelp.TryUseAction(mH, "急速射击") then
						return true
					end;
					if GetStatus("STATUS_野兽控制_爆炸陷阱") then
						if GetStatus("STATUS_指向施法") and so then
							local s1, s2 = AutoHelp.GetRange("mouseover")
							if s2 and s2 <= 40 and AutoHelp.TryUseAction(targetInfo, "爆炸陷阱鼠标指向") then
								return true
							end
						end;
						if GetStatus("STATUS_点击施法") then
							if not SpellIsTargeting() and AutoHelp.TryUseAction(targetInfo, "爆炸陷阱鼠标点击") then
								return true
							end
						end
					end;
					if GetStatus("HEAL_STATUS_AOE") then
						if GetStatus("STATUS_指向施法") and sr then
							if GetStatus("STATUS_野兽控制_乱射") and AutoHelp.TryUseAction(targetInfo, "乱射鼠标指向") then
								return true
							end
						end;
						if GetStatus("STATUS_点击施法") and sq >= 3 then
							if not SpellIsTargeting() and GetStatus("STATUS_野兽控制_乱射") and AutoHelp.TryUseAction(targetInfo, "乱射鼠标点击") then
								return true
							end
						end
					end;
					if GetStatus("STATUS_野兽控制_毒蛇钉刺") then
						local uS = uN == UnitGUID(targetInfo["unit"]) and uM ~= nil and GetTime() <= uM + 15;
						if not uS and AutoHelp.TryUseAction(targetInfo, "毒蛇钉刺") then
							uM = GetTime()
							uN = UnitGUID(targetInfo["unit"])
							return true
						end
					end;
					if GetStatus("STATUS_野兽控制_奥术射击") and AutoHelp.TryUseAction(targetInfo, "奥术射击") then
						return true
					end;
					if GetStatus("STATUS_野兽控制_多重射击") and AutoHelp.TryUseAction(targetInfo, "多重射击") then
						return true
					end;
					if GetStatus("STATUS_野兽控制_稳固射击") and not AutoHelp.IsMoving and AutoHelp.TryUseAction(targetInfo, "稳固射击") then
						return true
					end;
					if not IsAutoRepeatSpell("自动射击") and AutoHelp.TryUseAction(targetInfo, "攻击") then
						return true
					end
				end
			end;
			local kH = jy("HEALMODE")
			if kH == "生存" then
				if uR() then
					return true
				end
			elseif kH == "射击" then
				if uV() then
					return true
				end
			elseif kH == "野兽控制" then
				if uW() then
					return true
				end
			end
		end
	end;
	if PlayerIsClass("HUNTER") then
		AutoHelp.ClassConfig = uy
	end
end;
if AutoHelp.isWotlk then
	local function uX()
		local jB = AutoHelp.RegisterKeyCallback;
		local jJ = AutoHelp.HealButtons;
		local jK = AutoHelp.SettingItems;
		local SetConfig = AutoHelp.SetConfig;
		local jy = AutoHelp.GetConfig;
		AutoHelp.INTERRUPT_SPELLNAMES = {
			[1] = GetSpellInfo(547),
			[2] = GetSpellInfo(8004),
			[3] = GetSpellInfo(2008),
			[4] = GetSpellInfo(1064)
		}
		AutoHelp.RESCURIT_NAME = GetSpellInfo(2008)
		AutoHelp.RESCURIT_KEY = GetSpellInfo(2008)
		AutoHelp.CAN_RESCURIT = true;
		AutoHelp.CAN_HEAL = true;
		AutoHelp.CAN_BUFF = true;
		AutoHelp.CAN_DISPEL = true;
		AutoHelp.TUTENG_SPELLS = {}
		local sJ = "治疗"
		AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
		AutoHelp.NAMEPLATES_MAXDISTANCE = 36;
		AutoHelp.AttackType = 1;
		AutoHelp.AttackRange = 2;
		AutoHelp.DispelDiseaseKey = GetSpellInfo(526)
		AutoHelp.DispelPoisonKey = GetSpellInfo(526)
		AutoHelp.DispelCurseKey = nil;
		if GetSpellInfo(GetSpellInfo(51886)) then
			AutoHelp.DispelDiseaseKey = GetSpellInfo(51886)
			AutoHelp.DispelPoisonKey = GetSpellInfo(51886)
			AutoHelp.DispelCurseKey = GetSpellInfo(51886)
		end;
		AutoHelp.CommingHealWindow = 1.5;
		AutoHelp.CommingHotWindow = 1.5;
		AutoHelp.LastHealTeamAction = {}
		local uY = {
			"冰封武器",
			"火舌武器",
			"石化武器",
			"大地生命武器"
		}
		local uZ = "元素"
		local function qO(jI)
			local kH = jy("HEALMODE")
			if kH == "增强" or kH == "元素" then
				return
			end;
			if jI then
				AutoHelp.ShowItem("HEAL_STATUS_主动开怪2")
				AutoHelp.ShowItem("STATUS_目标互动2")
				AutoHelp.ShowItem("STATUS_自动寻怪2")
				AutoHelp.ShowItem("STATUS_自动拾取2")
				AutoHelp.ShowItems(uZ)
				AutoHelp.ResizePanel()
			else
				AutoHelp.HideItem("HEAL_STATUS_主动开怪2")
				AutoHelp.HideItem("STATUS_目标互动2")
				AutoHelp.HideItem("STATUS_自动寻怪2")
				AutoHelp.HideItem("STATUS_自动拾取2")
				AutoHelp.HideItems(uZ)
				AutoHelp.ResizePanel()
			end
		end;
		local u_;
		if GetSpellInfo(GetSpellInfo(2825)) then
			u_ = GetSpellInfo(2825)
		elseif GetSpellInfo(32182) then
			u_ = GetSpellInfo(32182)
		else
			u_ = "嗜血"
		end;
		local n9 = {
			{
				name = "治疗波",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true,
				["useSP"] = true
			},
			{
				name = "次级治疗波",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["fastSpell"] = true,
				["useSP"] = true
			},
			{
				name = "治疗链",
				spellId = true,
				["target"] = true,
				["healType"] = 1,
				["useSP"] = true
			},
			{
				name = "激流",
				spellId = true,
				["healType"] = 2,
				["target"] = true,
				["auraNameCID2"] = true,
				["useSP"] = true
			},
			{
				name = "大迅捷",
				spellId = true,
				["spellName"] = "自然迅捷",
				["target"] = true,
				["macro"] = "/cast 自然迅捷\n/cast [target=@target]治疗波\n"
			},
			{
				name = "自然迅捷",
				spellId = true
			},
			{
				name = "潮汐之力",
				spellId = true
			},
			{
				name = "元素掌握",
				spellId = true
			},
			{
				name = "闪电箭",
				spellId = true,
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "增强闪电箭",
				spellId = true,
				["spellName"] = "闪电箭",
				["target"] = true,
				["fastSpell"] = true,
				["sp"] = true,
				["ys"] = 1
			},
			{
				name = "雷霆风暴",
				spellId = true,
				["target"] = true
			},
			{
				name = "先祖之魂",
				spellId = true,
				["comkey"] = true,
				["target"] = true
			},
			{
				name = "驱毒术",
				spellId = true,
				["target"] = true
			},
			{
				name = "大地之盾",
				spellId = true,
				["target"] = true,
				["auraNameCID2"] = true
			},
			{
				name = "水之护盾",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "闪电之盾",
				spellId = true,
				["auraNameCID"] = true
			},
			{
				name = "净化灵魂",
				spellId = true,
				["target"] = true
			},
			{
				name = "野性狼魂",
				spellId = true,
				["useSP"] = true,
				["ys"] = 1
			},
			{
				name = "萨满之怒",
				spellId = true
			},
			{
				name = "烈焰震击",
				spellId = true,
				["target"] = true,
				["debuffNameCID2"] = true
			},
			{
				name = "熔岩爆裂",
				spellId = true,
				["target"] = true,
				["sp"] = true,
				["ys"] = 2
			},
			{
				name = "火焰新星",
				spellId = true
			},
			{
				name = "雷霆风暴",
				spellId = true
			},
			{
				name = "闪电链",
				spellId = true,
				["target"] = true,
				["sp"] = true
			},
			{
				name = "风暴打击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "熔岩猛击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true,
				["bomb"] = true,
				["ys"] = 1
			},
			{
				name = "冰封武器",
				spellId = true
			},
			{
				name = "火舌武器",
				spellId = true
			},
			{
				name = "火舌武器2",
				spellId = true,
				["spellName"] = "火舌武器(等级 9)",
				["macro"] = "/cast 火舌武器(等级 9)\n"
			},
			{
				name = "石化武器",
				spellId = true
			},
			{
				name = "大地生命武器",
				spellId = true
			},
			{
				name = "风怒武器",
				spellId = true
			},
			{
				name = "元素的召唤",
				spellId = true
			},
			{
				name = "先祖的召唤",
				spellId = true
			},
			{
				name = "灵魂的召唤",
				spellId = true
			},
			{
				name = "地缚图腾",
				spellId = true
			},
			{
				name = "火元素图腾",
				spellId = true,
				["useSP"] = true
			},
			{
				name = "灼热图腾",
				spellId = true
			},
			{
				name = "熔岩图腾",
				spellId = true
			},
			{
				name = "石爪图腾",
				spellId = true
			},
			{
				name = "土元素图腾",
				spellId = true
			},
			{
				name = "大地之力图腾",
				spellId = true
			},
			{
				name = "岗哨图腾",
				spellId = true
			},
			{
				name = "抗寒图腾",
				spellId = true
			},
			{
				name = "抗火图腾",
				spellId = true
			},
			{
				name = "根基图腾",
				spellId = true
			},
			{
				name = "火舌图腾",
				spellId = true
			},
			{
				name = "石肤图腾",
				spellId = true
			},
			{
				name = "空气之怒图腾",
				spellId = true
			},
			{
				name = "自然抗性图腾",
				spellId = true
			},
			{
				name = "风怒图腾",
				spellId = true
			},
			{
				name = "法力之泉图腾",
				spellId = true
			},
			{
				name = "法力之潮图腾",
				spellId = true
			},
			{
				name = "天怒图腾",
				spellId = true
			},
			{
				name = GetSpellInfo(32182),
				spellId = true
			},
			{
				name = GetSpellInfo(2825),
				spellId = true
			},
			{
				name = "幽灵狼",
				spellId = true
			},
			{
				name = "视界术",
				spellId = true
			},
			{
				name = "星界传送",
				spellId = true
			},
			{
				name = "水上行走",
				spellId = true
			},
			{
				name = "水下呼吸",
				spellId = true
			},
			{
				name = "风剪",
				spellId = true,
				["target"] = true
			},
			{
				name = "冰霜震击",
				spellId = true,
				["target"] = true
			},
			{
				name = "大地震击",
				spellId = true,
				["target"] = true,
				["attack"] = true,
				["sp"] = true
			},
			{
				name = "净化术",
				spellId = true,
				["target"] = true
			},
			{
				name = "妖术",
				spellId = true,
				["target"] = true
			},
			{
				name = "焦点风剪",
				spellId = true,
				["spellName"] = "风剪",
				["macro"] = "/cast [target=focus,exists,nodead]风剪;风剪\n",
				["spellTime"] = 0.2,
				["desc"] = "焦点风剪打断"
			}
		}
		if not IsUsableSpell("火舌武器(等级 9)") then
			for _, action in pairs(n9) do
				if action["name"] == "火舌武器2" then
					action["spellName"] = "火舌武器"
					action["macro"] = "/cast 火舌武器"
				end
			end
		end;
		function AutoHelp.GetActionStartKeys()
			return n9
		end;
		function AutoHelp.LoadActionKeys()
			AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
			AutoHelp.DefaultMode = "治疗"
			AutoHelp.ModeDefaultSetting = {
				["STATUS_治疗模式"] = true,
				["STATUS_主动攻击"] = false,
				["HEAL_STATUS_FIRSTDISPAL"] = false,
				["HEAL_STATUS_DISPALSELF"] = true,
				["HEAL_STATUS_DISPALTANK"] = true,
				["HEAL_STATUS_DISPALGROUP"] = true,
				["HEAL_OVERHEAL_VALUE"] = 98,
				["HEAL_STATUS_AUTOHEAL"] = true,
				["HEAL_AUTO_VALUE"] = 90,
				["HEAL_STATUS_FIRSTTANK"] = true,
				["HEAL_FIRSTTANK_VALUE"] = 60,
				["HEAL_STATUS_FIRSTTARGET"] = false,
				["HEAL_FIRSTPROTECT_VALUE"] = 90,
				["ONLYHEALTARGET"] = false,
				["ONLYHEALTARGET_ALWAYSHEAL"] = false,
				["ONLYHEALTARGET_USETOPHEAL"] = false,
				["HEAL_STATUS_ONEHEAL"] = false,
				["HEAL_STATUS_FIRSTHEALSELF"] = true,
				["OverHealValue"] = 100,
				["OverHealType"] = "OVERHEALNORMAL",
				["HEAL_STATUS_AUTOCHOOSE"] = true,
				["HEALKEYS"] = {
					"次级治疗波",
					"治疗链",
					"激流"
				},
				["MOVEHEALKEYS"] = {
					"激流"
				}
			}
			if AutoHelp.playerLevel <= 70 then
				table.insert(AutoHelp.ModeDefaultSetting["HEALKEYS"], 1, "治疗波")
			end;
			AutoHelp.HEAL_MODES = {
				["治疗"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_主动开怪"] = false,
					["HEAL_STATUS_主动开怪2"] = false,
					["HEAL_STATUS_水之护盾"] = true,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569已设置为系统缺省【治疗模式】，本模式追求最大化治疗和相对最小化过量治疗。\124r"
				},
				["治疗[5人本]"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_主动开怪"] = false,
					["HEAL_STATUS_主动开怪2"] = false,
					["HEAL_STATUS_AUTOHEAL"] = true,
					["HEAL_AUTO_VALUE"] = 70,
					["HEAL_STATUS_FIRSTTANK"] = true,
					["HEAL_FIRSTTANK_VALUE"] = 70,
					["HEAL_STATUS_FIRSTTARGET"] = true,
					["HEAL_FIRSTPROTECT_VALUE"] = 80,
					["HEAL_STATUS_水之护盾"] = true,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569已设置为系统缺省【治疗模式】，本模式追求最大化治疗和相对最小化过量治疗。\124r"
				},
				["打怪"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_主动开怪"] = true,
					["HEAL_STATUS_主动开怪2"] = false,
					["STATUS_目标互动"] = true,
					["HEAL_AUTO_VALUE"] = 50,
					["modetip"] = "\124cffFFF569已设置为【打怪模式】，减少自我加血频率。\124r"
				},
				["元素"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_闪电之盾"] = true,
					["modetip"] = "\124cffFFF569已设置为【元素】，不进行自我加血。\124r"
				},
				["增强"] = {
					["STATUS_治疗模式"] = false,
					["STATUS_主动攻击"] = true,
					["HEAL_STATUS_AUTOHEAL"] = false,
					["HEAL_STATUS_FIRSTTANK"] = false,
					["HEAL_STATUS_闪电之盾"] = true,
					["modetip"] = "\124cffFFF569已设置为【增强】，不进行自我加血。\124r"
				},
				["将军英雄"] = {
					["STATUS_治疗模式"] = true,
					["STATUS_主动攻击"] = false,
					["HEAL_STATUS_AUTOHEAL"] = true,
					["HEAL_AUTO_VALUE"] = 50,
					["HEAL_STATUS_FIRSTTANK"] = true,
					["HEAL_FIRSTTANK_VALUE"] = 70,
					["HEAL_OVERHEAL_VALUE"] = 90,
					["HEAL_STATUS_FIRSTHEALSELF"] = true,
					["OverHealType"] = "OVERHEALNORMAL",
					["modetip"] = "\124cffFFF569设置为【ULD将军刷坦模式】，只治疗坦克，且只在坦克血量低于70%的时候开始刷血，节省蓝量。\124r",
					["HEALKEYS"] = {
						"次级治疗波"
					}
				}
			}
			AutoHelp.ModeList = {
				{
					text = "治疗模式",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cff00ff00治疗\124r",
					name = "治疗",
					tooltipTitle = "治疗",
					tooltipText = "标准模式使用系统缺省设置进行治疗。"
				},
				{
					text = "\124cffFFFFFF治疗[5人本]\124r",
					name = "治疗[5人本]",
					tooltipTitle = "治疗[5人本]",
					tooltipText = "5人随机副本低烈度治疗。"
				},
				{
					text = "将军英雄",
					name = "将军英雄",
					tooltipTitle = "将军英雄模式",
					tooltipText = "\124cffFFF569设置为【ULD将军英雄刷坦模式】，只治疗坦克，且只在坦克血量低于70%的时候开始刷血，且只用圣光闪现刷血，节省蓝量。\124r"
				},
				{
					text = "输出",
					notCheckable = true,
					isTitle = true
				},
				{
					text = "\124cffFFFFFF元素\124r",
					name = "元素",
					tooltipTitle = "元素",
					tooltipText = "不进行自我治疗"
				},
				{
					text = "\124cffFFFFFF增强\124r",
					name = "增强",
					tooltipTitle = "增强",
					tooltipText = "不进行自我治疗"
				}
			}
			AutoHelp.STAND_HEAL_SPELLS = {
				"治疗波",
				"次级治疗波",
				"治疗链",
				"激流"
			}
			AutoHelp.MOVE_HEAL_SPELLS = {
				"激流"
			}
			AutoHelp.PANELHEIGHT = 460;
			AutoHelp.PANELWIDTH = 160;
			AutoHelp.ONEPANEL = true;
			AutoHelp.PANEL_CONFIG = {
				["healer"] = {
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING3",
						["value"] = "\124cff00ff00辅助功能设置\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTDISPAL",
						["value"] = false,
						["title"] = "\124cffFFF569先驱\124r",
						["tipTitle"] = "优先驱散",
						["tip"] = "优先驱散，驱散将优先加血，现在版本加入队友有血量低于50%依然先加血，以阻止一直在驱散而不加血的问题。\n\n\124cff00ff00对于频繁产生负面效果时，建议关闭此选项提高治疗量\n优先驱散选中效果将高于治疗\124r",
						["point"] = 5,
						["hitRect"] = - 30,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISCURSE",
						["value"] = true,
						["title"] = "诅",
						["tip"] = "驱散诅咒效果，自动驱散诅咒效果\n\n\124cff00ff00自动使用驱毒术驱散目标诅咒效果\124r",
						["point"] = 55,
						["hitRect"] = - 10,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey(AutoHelp.DispelCurseKey) then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISPOSION",
						["value"] = true,
						["title"] = "毒",
						["tipTitle"] = "驱散中毒",
						["tip"] = "驱散中毒效果，自动驱散中毒效果\n\n\124cff00ff00自动使用清洁术驱散目标中毒效果\nZUG哈卡建议关闭中毒驱散\124r",
						["point"] = 90,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_DISSICK",
						["value"] = true,
						["title"] = "病",
						["tipTitle"] = "驱散疾病",
						["tip"] = "驱散疾病效果，自动驱散疾病效果\n\n\124cff00ff00自动使用清洁术驱散目标疾病效果\124r",
						["point"] = 125,
						["hitRect"] = - 10,
						["nextpos"] = false
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_水之护盾",
						["value"] = true,
						["title"] = "水之护盾",
						["tip"] = "保持自己水之护盾",
						["point"] = 5,
						["hitRect"] = - 60,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("水之护盾") then
								ko:Disable()
							end
						end,
						["fnc"] = function(jI)
							if jI then
								SetConfig("HEAL_STATUS_闪电之盾", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_闪电之盾",
						["value"] = true,
						["title"] = "闪电之盾",
						["tip"] = "保持自己闪电之盾",
						["point"] = 80,
						["hitRect"] = - 60,
						["nextpos"] = false,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("闪电之盾") then
								ko:Disable()
							end
						end,
						["fnc"] = function(jI)
							if jI then
								SetConfig("HEAL_STATUS_水之护盾", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_AUTOINTERUPT",
						["value"] = true,
						["title"] = "自动打断",
						["tip"] = "使用风剪技能, 自动打断当前目标/焦点目标,设置里面可以设置打断读条比例, 缺省读条20%打断。如果需要补断, 比如将军可以设置70%补断。\n\n\124cff00ff00如果需要手动打断, 请不要勾选此项, 比如25人将军打断任务。",
						["point"] = 5,
						["hitRect"] = - 50,
						["nextpos"] = true
					},
					{
						["type"] = "editbox",
						["id"] = "VALUE_AUTOINTERUPT",
						["value"] = 20,
						["point"] = 100,
						["nextpos"] = false,
						["percent"] = "%"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_大地之盾",
						["value"] = true,
						["title"] = "地盾",
						["tip"] = "\124cff00ff00保持当标一直维持大地之盾效果，失效会自动补上\124r",
						["point"] = 5,
						["offset"] = 22,
						["hitRect"] = - 25,
						["nextpos"] = true,
						["mode"] = "healer",
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("大地之盾") then
								ko:Disable()
							end
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_大地之盾",
						["title"] = "选择大地之盾",
						["tipTitle"] = "大地之盾队友选择",
						["tip"] = "选择队友之后点击本按钮，将设定自动为该保持大地之盾。\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动补大地之盾\124r",
						["width"] = 100,
						["height"] = 25,
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["create"] = function(kl)
							local cd = jy("大地之盾")
							if cd then
								kl:SetText(cd)
							else
								kl:SetText("无")
							end
						end,
						["fnc"] = function(kl)
							local tInfo = GetRaidUnit("target")
							if tInfo ~= nil then
								SetConfig("大地之盾", tInfo["name"])
								AutoHelp.Debug("设置大地之盾目标：" .. tInfo["name"])
							else
								SetConfig("大地之盾", "无")
								AutoHelp.Debug("清除大地之盾目标。")
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00副本特殊功能\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动炸弹",
						["value"] = true,
						["title"] = "邪铁炸弹",
						["tip"] = "在技能中绑定[萨隆邪铁炸弹]/腰带钴质破片炸弹, 小怪使用腰带炸弹, 骷髅级别BOSS才卡CD使用萨隆邪铁炸弹, 请在背包保留足够的炸弹。\n\n\124cff00ff00萨隆邪铁炸弹只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 60,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "增强",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 30,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发嗜血", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发嗜血",
						["value"] = false,
						["title"] = AutoHelp.SXNAME,
						["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
						["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
						["hitRect"] = - 30,
						["point"] = 60,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_爆发自动", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发喝药",
						["value"] = true,
						["title"] = "嗑药",
						["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
						["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
						["hitRect"] = - 30,
						["point"] = 110,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_协助坦克",
						["value"] = true,
						["title"] = "协助坦克",
						["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack",
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_爆发自动",
						["value"] = true,
						["title"] = "爆发",
						["tipTitle"] = "饰品/大技能自动开启",
						["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
						["hitRect"] = - 60,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack",
						["version"] = "classic"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_AOE",
						["value"] = true,
						["title"] = "自动AOE",
						["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果怪物数量大于等于3个，将自动启动AOE技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
						["hitRect"] = - 60,
						["point"] = 5,
						["nextpos"] = true,
						["create"] = function(ko)
							if not AutoHelp.HasActionKey("闪电链") then
								ko:Disable()
							end
						end,
						["mode"] = "attack",
						["fnc"] = function(hK)
							if hK then
								SetConfig("STATUS_增强_熔岩图腾", true)
								SetConfig("STATUS_增强_闪电链", true)
								SetConfig("STATUS_元素_熔岩图腾", true)
								SetConfig("STATUS_元素_火焰新星", true)
								SetConfig("STATUS_元素_闪电链", true)
							else
								SetConfig("STATUS_增强_熔岩图腾", false)
								SetConfig("STATUS_增强_闪电链", false)
								SetConfig("STATUS_元素_熔岩图腾", false)
								SetConfig("STATUS_元素_火焰新星", false)
								SetConfig("STATUS_元素_闪电链", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_始终AOE",
						["value"] = false,
						["title"] = "始终AOE",
						["tip"] = "一直使用AOE技能进行攻击,比如在打左右手的时候始终使用闪电链。",
						["hitRect"] = - 30,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "attack",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_增强_熔岩图腾", true)
								SetConfig("STATUS_增强_闪电链", true)
								SetConfig("STATUS_元素_熔岩图腾", true)
								SetConfig("STATUS_元素_闪电链", true)
								SetConfig("STATUS_元素_火焰新星", true)
							elseif not GetStatus("HEAL_STATUS_AOE") then
								SetConfig("STATUS_增强_熔岩图腾", false)
								SetConfig("STATUS_增强_闪电链", false)
								SetConfig("STATUS_元素_熔岩图腾", false)
								SetConfig("STATUS_元素_火焰新星", false)
								SetConfig("STATUS_元素_闪电链", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_主动攻击",
						["value"] = true,
						["hitRect"] = - 40,
						["title"] = "\124cff00ff00启动攻击\124r",
						["tip"] = "如果团队血量不需要治疗时,有敌方目标且在战斗就开始攻击模式",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							qO(hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_主动开怪2",
						["value"] = false,
						["hitRect"] = - 40,
						["title"] = "\124cfff00000主动开怪\124r",
						["tip"] = "选择此项，非战斗中可以主动攻击选中的敌对目标，不选择此项，即使有主动攻击，也不会进入战斗状态（攻击敌对目标）\124r",
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "增强" and kH ~= "元素" then
								SetConfig("HEAL_STATUS_主动开怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_目标互动2",
						["value"] = false,
						["hitRect"] = - 30,
						["title"] = "\124cffFFF569互动\124r",
						["tip"] = "自动与目标互动，比如距离过远自动靠近目标，并攻击\n不选择目标互动，必须手动移动到攻击位置，才开始自动攻击",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "增强" and kH ~= "元素" then
								SetConfig("STATUS_目标互动", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动寻怪2",
						["value"] = false,
						["title"] = "\124cffFFF569寻怪\124r",
						["tip"] = "自动升级使用，站在某个地方，自动寻找怪物攻击",
						["point"] = 55,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "增强" and kH ~= "元素" then
								SetConfig("STATUS_自动寻怪", hK)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_自动拾取2",
						["value"] = false,
						["title"] = "\124cffFFF569拾取\124r",
						["tip"] = "自动升级使用，杀死怪物后自动拾取",
						["point"] = 105,
						["nextpos"] = false,
						["mode"] = "healer",
						["fnc"] = function(hK)
							local kH = jy("HEALMODE")
							if kH ~= "增强" and kH ~= "元素" then
								SetConfig("STATUS_自动拾取", hK)
							end
						end
					},
					{
						["type"] = "fontstring",
						["id"] = "ATTACK_OTHER_SETTING",
						["value"] = "\124cff00ff00攻击技能选择\124r",
						["width"] = 140,
						["height"] = 25,
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "attack"
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_召唤图腾",
						["title"] = "图腾",
						["tipTitle"] = "召唤图腾",
						["tip"] = "召唤设定好的图腾:元素的召唤/先祖的召唤/灵魂的召唤,根据设定召唤",
						["width"] = 40,
						["point"] = 0,
						["nextpos"] = true,
						["mode"] = "元素,增强",
						["version"] = "wlk",
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("元素的召唤")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_火元素图腾",
						["title"] = "火爹",
						["tipTitle"] = "召唤火爹",
						["tip"] = "召唤火元素图腾,施放火爹参加战斗",
						["width"] = 40,
						["point"] = 40,
						["nextpos"] = false,
						["mode"] = "元素,增强",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("火元素图腾") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("火元素图腾")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_野性狼魂",
						["title"] = "狼魂",
						["tipTitle"] = "召唤幽灵狼战斗",
						["tip"] = "召唤幽灵狼加入战斗",
						["width"] = 40,
						["point"] = 80,
						["nextpos"] = false,
						["mode"] = "元素,增强",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey("野性狼魂") then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction("野性狼魂")
						end
					},
					{
						["type"] = "button",
						["id"] = "HEAL_BUTTON_英勇",
						["title"] = u_,
						["tipTitle"] = u_,
						["tip"] = "施放" .. u_,
						["width"] = 40,
						["point"] = 120,
						["nextpos"] = false,
						["mode"] = "元素,增强",
						["version"] = "wlk",
						["create"] = function(kl)
							if not AutoHelp.HasActionKey(u_) then
								kl:Disable()
							end
						end,
						["fnc"] = function(kl)
							AutoHelp.AddCastAction(u_)
						end
					}
				},
				["setting"] = {
					{
						["type"] = "checkbox",
						["id"] = "STATUS_武器附魔",
						["value"] = true,
						["title"] = "\124cff00ff00自动武器附魔\124r",
						["tip"] = "自动给武器临时附魔",
						["point"] = 5,
						["nextpos"] = true
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_火舌武器",
						["value"] = true,
						["title"] = "\124cffFF7D0A火\124r",
						["tip"] = "自动给武器附魔[火舌武器]",
						["hitRect"] = - 20,
						["point"] = 20,
						["nextpos"] = true,
						["fnc"] = function(hK)
							ToggleStatus(uY, "火舌武器", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_冰封武器",
						["value"] = false,
						["title"] = "\124cffFF7D0A冰\124r",
						["tip"] = "自动给武器附魔冰封武器",
						["hitRect"] = - 20,
						["point"] = 50,
						["nextpos"] = false,
						["fnc"] = function(hK)
							ToggleStatus(uY, "冰封武器", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_石化武器",
						["value"] = false,
						["title"] = "\124cffFF7D0A石\124r",
						["tip"] = "自动给武器附魔石化武器",
						["hitRect"] = - 20,
						["point"] = 80,
						["nextpos"] = false,
						["fnc"] = function(hK)
							ToggleStatus(uY, "石化武器", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_大地生命武器",
						["value"] = false,
						["title"] = "\124cffFF7D0A地\124r",
						["tip"] = "自动给武器附魔[大地生命武器]",
						["hitRect"] = - 20,
						["point"] = 110,
						["nextpos"] = false,
						["fnc"] = function(hK)
							ToggleStatus(uY, "大地生命武器", hK)
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FIRSTHEALSELF",
						["value"] = true,
						["title"] = "优先自疗",
						["tip"] = "当自己血量低于设定值，优先治疗自己，缺省设置50%（0.5）",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "healer"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_FIRSTHEALSELF",
						["value"] = 40,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "healer"
					},
					{
						["type"] = "checkbox",
						["id"] = "HEAL_STATUS_FASTHEAL",
						["value"] = true,
						["title"] = "瞬发自疗",
						["tip"] = "当自己血量低于设定值，利用5层旋涡武器的瞬发治疗技能给自己加血，缺省设置35%",
						["point"] = 5,
						["nextpos"] = true,
						["mode"] = "增强",
						["version"] = "wlk"
					},
					{
						["type"] = "editbox",
						["id"] = "HEAL_VALUE_FASTHEAL",
						["value"] = 35,
						["point"] = 100,
						["percent"] = "%",
						["nextpos"] = false,
						["mode"] = "增强",
						["version"] = "wlk"
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_瞬发治疗波",
						["value"] = true,
						["title"] = "\124cffFF7D0A治疗波\124r",
						["tip"] = "利用瞬发治疗波给自己加血",
						["point"] = 20,
						["nextpos"] = true,
						["mode"] = "增强",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_瞬发治疗链", false)
							end
						end
					},
					{
						["type"] = "checkbox",
						["id"] = "STATUS_瞬发治疗链",
						["value"] = false,
						["title"] = "\124cffFF7D0A治疗链\124r",
						["tip"] = "利用瞬发治疗链给自己加血",
						["point"] = 90,
						["nextpos"] = false,
						["mode"] = "增强",
						["version"] = "wlk",
						["fnc"] = function(jI)
							if jI then
								SetConfig("STATUS_瞬发治疗波", false)
							end
						end
					}
				}
			}
			local qQ = {
				{
					{
						"增强_烈焰震击",
						"烈焰震击",
						true,
						"烈焰震击",
						"增强"
					},
					{
						"增强_熔岩猛击",
						"熔岩猛击",
						true,
						"熔岩猛击",
						"增强"
					},
					{
						"增强_闪电箭",
						"闪电箭",
						true,
						"闪电箭",
						"增强"
					},
					{
						"增强_闪电链",
						"闪电链",
						false,
						"闪电链",
						"增强"
					},
					{
						"增强_风暴打击",
						"风暴打击",
						true,
						"风暴打击",
						"增强"
					},
					{
						"增强_大地震击",
						"大地震击",
						true,
						"大地震击",
						"增强"
					},
					{
						"增强_火焰新星",
						"火焰新星",
						true,
						"火焰新星",
						"增强"
					},
					{
						"增强_灼热图腾",
						"灼热图腾",
						true,
						"灼热图腾",
						"增强"
					},
					{
						"增强_熔岩图腾",
						"熔岩图腾",
						false,
						"熔岩图腾",
						"增强"
					},
					{
						"增强_萨满之怒",
						"萨满之怒",
						true,
						"萨满之怒",
						"增强"
					},
					{
						"增强_火元素图腾",
						"火元素图腾",
						false,
						"火元素",
						"增强"
					},
					{
						"增强_野性狼魂",
						"野性狼魂",
						true,
						"野性狼魂",
						"增强"
					}
				},
				{
					{
						"元素_烈焰震击",
						"烈焰震击",
						true,
						"烈焰震击",
						"元素"
					},
					{
						"元素_熔岩爆裂",
						"熔岩爆裂",
						true,
						"熔岩爆裂",
						"元素"
					},
					{
						"元素_元素掌握",
						"元素掌握",
						true,
						"元素掌握",
						"元素"
					},
					{
						"元素_雷霆风暴",
						"雷霆风暴",
						false,
						"雷霆风暴",
						"元素"
					},
					{
						"元素_闪电箭",
						"闪电箭",
						true,
						"闪电箭",
						"元素"
					},
					{
						"元素_闪电链",
						"闪电链",
						true,
						"闪电链",
						"元素"
					},
					{
						"元素_熔岩图腾",
						"熔岩图腾",
						false,
						"熔岩图腾",
						"元素"
					},
					{
						"元素_火焰新星",
						"火焰新星",
						false,
						"火焰新星",
						"元素"
					},
					{
						"元素_火元素图腾",
						"火元素图腾",
						false,
						"火图腾",
						"元素"
					}
				}
			}
			for _, qR in pairs(qQ) do
				local jS = # AutoHelp.PANEL_CONFIG["healer"]
				local rw = 0;
				if jS % 2 == 1 then
					rw = 1
				end;
				for _, qS in pairs(qR) do
					local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
					if cd and AutoHelp.HasActionKey(qS[2]) then
						local point, kf;
						if jS % 2 == rw then
							point = 5;
							kf = true
						else
							point = 80;
							kf = false
						end;
						local eS = {
							["type"] = "checkbox",
							["id"] = "STATUS_" .. qS[1],
							["value"] = qS[3],
							["title"] = qS[4],
							["tip"] = qS[4],
							["point"] = point,
							["nextpos"] = kf,
							["mode"] = qS[5]
						}
						if jS == 1 then
							eS["base"] = true
						end;
						table.insert(AutoHelp.PANEL_CONFIG["healer"], jS + 1, eS)
						jS = jS + 1
					end
				end
			end
		end;
		function AutoHelp.ModeChanged(kH)
			if sJ ~= nil and sJ ~= kH and AutoHelp.playerLevel >= 55 then
				AutoHelp.Debug("\124cfff00000##错误的输出设置：您当前天赋为" .. sJ .. ",输出方式为" .. kH .. "!\124r")
			end;
			if kH == "元素" then
				SetConfig("STATUS_火舌武器", true)
				SetConfig("HEAL_STATUS_水之护盾", true)
				AutoHelp.AttackType = 2;
				AutoHelp.AttackRange = 30
			elseif kH == "增强" then
				SetConfig("STATUS_火舌武器", true)
				SetConfig("HEAL_STATUS_闪电之盾", true)
				AutoHelp.AttackType = 1;
				AutoHelp.AttackRange = 2
			else
				SetConfig("STATUS_大地生命武器", true)
				SetConfig("HEAL_STATUS_水之护盾", true)
				AutoHelp.AttackType = 2;
				AutoHelp.AttackRange = 30
			end;
			if kH == "元素" or kH == "增强" then
				uZ = kH
			else
				uZ = "元素"
			end;
			local qT = not (kH == "元素" or kH == "增强")
			for bi, bn in pairs(AutoHelp.SettingItems) do
				while true do
					if bn.mode then
						if qT and bn.mode == uZ then
							bn:Show()
							break
						end;
						if Contains(bn.mode, kH) or qT and Contains(bn.mode, "healer") or not qT and Contains(bn.mode, "attack") then
							bn:Show()
							break
						end;
						bn:Hide()
					end;
					break
				end
			end;
			if qT then
				qO(GetStatus("STATUS_主动攻击"))
			end;
			AutoHelp.ResizePanel()
		end;
		local function qW(qV)
			if GetStatus("HEAL_STATUS_PAUSE") or not GetStatus("HEAL_STATUS_HEALBOSSTARGET") then
				return
			end;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 55593 then
				AutoHelp.SetStopHealAction(16, GetSpellInfo(55593) .. "，停止治疗")
			end;
			if qV.event == "SPELL_CAST_SUCCESS" and qV.spellId == 27808 then
				tInfo = GetRaidUnit(qV.destName)
				if tInfo and tInfo["unit"] ~= "player" then
					AutoHelp.Debug(AutoHelp.GetSpellName(qV.spellId) .. tInfo["name"])
					if AutoHelp.CanUseAction(tInfo, "激流") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "激流", 0, true)
					elseif AutoHelp.CanUseAction(tInfo, "次级治疗波") then
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "次级治疗波", 0, true)
					else
						AutoHelp.StopAction()
						AutoHelp.AddNextAction(tInfo, "治疗波", 0, true)
					end
				end
			end
		end;
		AutoHelp.HandlerBossEvent = qW;
		function AutoHelp.OnSpellSucceeded(ho, fR, ca)
		end;
		function AutoHelp.AutoCreateMacro(og)
			if jy("HEALMODE") == "增强" then
				if AutoHelp.HasActionKey("元素的召唤") then
					local pj = FindOrCreateMacro("元素的召唤", nil, "#showtooltips  元素的召唤\n/stopcasting\n/ahcast 元素的召唤\n", 1)
				end;
				if AutoHelp.HasActionKey("火元素图腾") then
					local pj = FindOrCreateMacro("火元素", nil, "#showtooltips 火元素图腾\n/stopcasting\n/ahcast 火元素图腾\n", 2)
				end;
				if AutoHelp.HasActionKey(u_) then
					local pj = FindOrCreateMacro(u_, nil, "#showtooltips " .. u_ .. "\n/stopcasting\n/ahcast " .. u_ .. "\n", 3)
				end;
				if AutoHelp.HasActionKey("野性狼魂") then
					local pj = FindOrCreateMacro("野性狼魂", nil, "#showtooltips 野性狼魂\n/stopcasting\n/ahcast 野性狼魂\n", 4)
				end;
				if AutoHelp.HasActionKey("灼热图腾") then
					local pj = FindOrCreateMacro("灼热图腾", nil, "#showtooltips  灼热图腾\n/stopcasting\n/ahcast 灼热图腾\n", 61)
				end;
				if AutoHelp.HasActionKey("熔岩图腾") then
					local pj = FindOrCreateMacro("熔岩图腾", nil, "#showtooltips  熔岩图腾\n/stopcasting\n/ahcast 熔岩图腾\n", 62)
				end
			end;
			if jy("HEALMODE") == "元素" then
				if AutoHelp.HasActionKey("元素的召唤") then
					local pj = FindOrCreateMacro("元素的召唤", nil, "#showtooltips  元素的召唤\n/stopcasting\n/ahcast 元素的召唤\n", 1)
				end;
				if AutoHelp.HasActionKey("火元素图腾") then
					local pj = FindOrCreateMacro("火元素", nil, "#showtooltips 火元素图腾\n/stopcasting\n/ahcast 火元素图腾\n", 2)
				end;
				if AutoHelp.HasActionKey(u_) then
					local pj = FindOrCreateMacro(u_, nil, "#showtooltips " .. u_ .. "\n/stopcasting\n/ahcast " .. u_ .. "\n", 3)
				end
			end;
			if jy("HEALMODE") == "治疗" then
				if AutoHelp.HasActionKey("元素的召唤") then
					local pj = FindOrCreateMacro("元素的召唤", nil, "#showtooltips  元素的召唤\n/stopcasting\n/ahcast 元素的召唤\n", 1)
				end;
				if AutoHelp.HasActionKey("火元素图腾") then
					local pj = FindOrCreateMacro("火元素", nil, "#showtooltips 火元素图腾\n/stopcasting\n/ahcast 火元素图腾\n", 2)
				end;
				if AutoHelp.HasActionKey(u_) then
					local pj = FindOrCreateMacro(u_, nil, "#showtooltips " .. u_ .. "\n/stopcasting\n/ahcast " .. u_ .. "\n", 3)
				end
			end;
			if AutoHelp.HasActionKey("风剪") then
				local pj = FindOrCreateMacro("焦点打断", nil, "#showtooltips  风剪\n/stopcasting\n/cast [target=focus,harm,exists][harm][target=targettarget, harm] 风剪\n", 63, true)
			end;
			FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51, true)
			FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52, true)
		end;
		function AutoHelp.AddNextCastAction(qZ)
			return true
		end;
		function AutoHelp.ClassInit()
			AutoHelp.RegisterKeyCallback("大地之盾", function(hK)
				local k8 = AutoHelp.SettingItems["HEAL_BUTTON_大地之盾"]
				if k8 then
					k8:SetText(hK)
				end
			end)
			local q_ = {
				"元素的召唤",
				"先祖的召唤",
				"灵魂的召唤"
			}
			for _, cd in pairs(q_) do
				if AutoHelp.HasActionKey(cd) then
					AutoHelp.TUTENG_SPELLS[# AutoHelp.TUTENG_SPELLS + 1] = cd
				end
			end;
			AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
			if AutoHelp.playerLevel >= 55 then
				local v0, v1, v2 = AutoHelp.HEAL_PLAYER_TALENTS[1] or 0, AutoHelp.HEAL_PLAYER_TALENTS[2] or 0, AutoHelp.HEAL_PLAYER_TALENTS[3] or 0;
				local kH = jy("HEALMODE")
				if v0 > v1 and v0 > v2 then
					sJ = "元素"
				end;
				if v1 > v0 and v1 > v2 then
					sJ = "增强"
				end;
				if v2 > v0 and v2 > v1 then
					sJ = "恢复"
				end;
				if kH == nil then
					SetConfig("HEALMODE", sJ)
				end
			end
		end;
		local v3 = {
			["FIRE"] = {
				GetSpellInfo(58744)
			},
			["EARTH"] = {
				GetSpellInfo(58646),
				GetSpellInfo(58754)
			},
			["WATER"] = {
				GetSpellInfo(58740),
				GetSpellInfo(587777)
			},
			["AIR"] = {
				GetSpellInfo(58750),
				GetSpellInfo(8515),
				GetSpellInfo(8178),
				GetSpellInfo(6495),
				GetSpellInfo(2895)
			}
		}
		local function v4()
			for v = 1, MAX_TOTEMS do
				local v5, v6, bv, cn, lT = GetTotemInfo(v)
				if v5 and v6 ~= "" and bv and cn then
					return true
				end
			end;
			return false
		end;
		local function v7(v)
			local v5, v6, bv, cn, v8 = GetTotemInfo(v)
			if v5 and v6 ~= "" and bv > 0 then
				return v6
			end
		end;
		local function v9(cd)
			for v = 1, MAX_TOTEMS do
				local v6 = v7(v)
				if Contains(v6, cd) then
					return true
				end
			end;
			return false
		end;
		local function va()
			return v7(1) ~= nil
		end;
		local function vb()
			local cd = v7(2)
			if cd then
				if Contains(cd, "大地之力") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(58646)) then
					return false
				end;
				if Contains(cd, "石肤图腾") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(58754)) then
					return false
				end
			end;
			return cd ~= nil
		end;
		local function vc()
			local cd = v7(3)
			if cd then
				if Contains(cd, "法力之泉") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(58777)) then
					return false
				end
			end;
			return cd ~= nil
		end;
		local function vd()
			local cd = v7(4)
			if cd then
				if Contains(cd, "自然抗性") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(58750)) then
					return false
				end;
				if Contains(cd, "风怒图腾") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(8515)) then
					return false
				end;
				if Contains(cd, "根基图腾") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(8178)) then
					return false
				end;
				if Contains(cd, "岗哨图腾") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(6495)) then
					return false
				end;
				if Contains(cd, "空气之怒图腾") and not AutoHelp.UnitHasBuff("player", GetSpellInfo(2895)) then
					return false
				end
			end;
			return cd ~= nil
		end;
		local function r4(mH, targetInfo)
			if GetStatus("HEAL_STATUS_FIRSTHEALSELF") and mH["hp"] <= (GetStatusNumber("HEAL_VALUE_FIRSTHEALSELF") or 40) / 100 and AutoHelp.AutoHealTeam(mH) then
				AutoHelp.DebugText = "自我危机处理：加血"
				return true
			end
		end;
		function AutoHelp.CanMoveSpell(tInfo, p)
			return (p == "治疗波" or p == "治疗链" or p == "次级治疗波") and AutoHelp.UnitHasBuff("player", "自然迅捷")
		end;
		local function s7(tInfo)
			if AutoHelp.CanUseAction(HEAL_RAID["player"], "自然迅捷") and AutoHelp.CanUseAction(tInfo, "治疗波") and AutoHelp.TryUseAction(tInfo, "大迅捷") then
				return true
			end
		end;
		local function rc(mH, targetInfo)
		end;
		function AutoHelp.DoUrgentAction(mH, targetInfo)
			if GetStatus("HEAL_STATUS_大地之盾") then
				local lw = jy("大地之盾")
				if lw and lw ~= "无" then
					local tInfo = HEAL_RAID[HEAL_RAID_NAMES[lw]]
					if not tInfo then
						SetConfig("大地之盾", "无")
					else
						if AutoHelp.TryUseAction(tInfo, "大地之盾") then
							AutoHelp.DebugText = "保持大地之盾"
							return true
						end
					end
				end
			end;
			if jy("HEAL_STATUS_水之护盾") and not AutoHelp.UnitHasBuff("player", "水之护盾") and AutoHelp.TryUseAction(mH, "水之护盾") then
				AutoHelp.DebugText = "保持水盾"
				return true
			end;
			if jy("HEAL_STATUS_闪电之盾") and not AutoHelp.UnitHasBuff("player", "闪电之盾") and AutoHelp.TryUseAction(mH, "闪电之盾") then
				AutoHelp.DebugText = "闪电之盾"
				return true
			end;
			if not GetStatus("STATUS_治疗模式") then
				return rc(mH, targetInfo)
			else
				return r4(mH, targetInfo)
			end
		end;
		local function ve(vf)
			local vg = GetToggleStatus(uY)
			if GetStatus("STATUS_武器附魔") and vg ~= nil then
				local tP, tQ, _, tR, tS, tT, _, tU = GetWeaponEnchantInfo()
				if AutoHelp.MainHandIsWeapon() and (not tP or tQ <= vf * 60 * 1000) then
					if vg == "火舌武器" and jy("HEALMODE") == "增强" and AutoHelp.HasActionKey(vg .. "2") then
						if AutoHelp.TryUseAction(HEAL_RAID["player"], vg .. "2") then
							return true
						end
					else
						if (tR ~= 3780 or tR == 3780 and tU == 3780) and AutoHelp.TryUseAction(HEAL_RAID["player"], vg) then
							return true
						end
					end
				end;
				if AutoHelp.OffHandIsWeapon() and (not tS or tT <= vf * 60 * 1000) then
					if AutoHelp.TryUseAction(HEAL_RAID["player"], vg) then
						return true
					end
				end
			end
		end;
		function AutoHelp.DoUncombatAction(mH)
			return false
		end;
		function AutoHelp.DoCommonAction(mH)
			if GetStatus("STATUS_武器附魔") then
				local h4 = 5;
				if AutoHelp.isClassic then
					h4 = 0
				end;
				if InCombatLockdown() then
					h4 = 0
				end;
				if ve(h4) then
					return true
				end
			end;
			if not GetStatus("STATUS_治疗模式") then
				if InCombatLockdown() then
				end
			else
				if InCombatLockdown() then
				end
			end
		end;
		function AutoHelp.HotTeam(tInfo, rf)
			if not tInfo then
				AutoHelp.Debug("HotTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			if InCombatLockdown() and mT <= 0.4 and s7(tInfo) then
				AutoHelp.DebugText = "危机处理：自然迅捷"
				return true
			end;
			if AutoHelp.HasMoveKey("激流") and AutoHelp.TryUseAction(tInfo, "激流") then
				return true
			end
		end;
		function AutoHelp.HealTeam(tInfo)
			if not tInfo then
				AutoHelp.Debug("HealTeam错误的tInfo，请检查程序！")
				return
			end;
			local mH = HEAL_RAID["player"]
			local mT, mS = tInfo["ahp"], tInfo["alost"]
			if InCombatLockdown() and mT <= 0.4 and s7(tInfo) then
				AutoHelp.DebugText = "危机处理：自然迅捷"
				return true
			end;
			if AutoHelp.HasStopMoveKey("激流") and AutoHelp.TryUseAction(tInfo, "激流") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("治疗链") and AutoHelp.TryUseAction(tInfo, "治疗链") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("次级治疗波") and AutoHelp.TryUseAction(tInfo, "次级治疗波") then
				return true
			end;
			if AutoHelp.HasStopMoveKey("治疗波") and AutoHelp.TryUseAction(tInfo, "治疗波") then
				return true
			end
		end;
		function AutoHelp.AutoHealTeam(tInfo)
			if AutoHelp.IsMoving then
				return AutoHelp.HotTeam(tInfo)
			else
				return AutoHelp.HealTeam(tInfo)
			end
		end;
		local function rj(tInfo)
			if GetStatus("HEAL_STATUS_DISCURSE") and tInfo["hasCurse"] and AutoHelp.DispelCurseKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelCurseKey) then
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_DISPOSION") and tInfo["hasPoison"] and AutoHelp.DispelPoisonKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelPoisonKey) then
					return true
				end
			end;
			if GetStatus("HEAL_STATUS_DISSICK") and tInfo["hasDisease"] and AutoHelp.DispelDiseaseKey then
				if AutoHelp.TryUseAction(tInfo, AutoHelp.DispelDiseaseKey) then
					return true
				end
			end
		end;
		function AutoHelp.DoDispelAction()
			if not GetStatus("HEAL_STATUS_DISCURSE") and not GetStatus("HEAL_STATUS_DISSICK") and not GetStatus("HEAL_STATUS_DISPOSION") then
				return false
			end;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["hasDebuff"] and AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] then
					if tInfo["role"] == "MAINTANK" and rj(tInfo) then
						AutoHelp.DebugText = "驱散坦克"
						return true
					end;
					if tInfo["unit"] == "player" and rj(tInfo) then
						AutoHelp.DebugText = "驱散自己"
						return true
					end;
					if rj(tInfo) then
						AutoHelp.DebugText = "驱散团队"
						return true
					end
				end
			end
		end;
		local vh = nil;
		function AutoHelp.ErrorMessageHandle(f3)
			if f3 == "距离太远。" then
				if AutoHelp.LastAction and AutoHelp.LastAction["name"] == "火焰新星" and GetTime() - AutoHelp.LastTime < 1 then
					vh = GetTime()
				end
			end
		end;
		function AutoHelp.DoInterrupt(mH, b8, cd, to, tp, ca)
			local ib, iG = AutoHelp.GetRange(b8)
			if iG <= 25 and AutoHelp.TryUseAction(mH, "焦点风剪") then
				return true
			end
		end;
		function AutoHelp.DoAttackAction(mH, targetInfo)
			local mT, r7 = mH["hp"], mH["mp"]
			local ib, iG = AutoHelp.GetRange("target")
			local rV = AutoHelp.IsForceAOE(2)
			local mM = mH["Auras"][57723] or mH["Auras"][57724]
			local mN = mH["Auras"][32182] or mH["Auras"][2825]
			local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
			local function rW()
				if not AutoHelp.KillJX then
					return false
				end;
				local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
				if not rX and InCombatLockdown() and GetStatus("HEAL_STATUS_镜像蛛网") then
					if FindEnemyUnit("镜像") or FindEnemyUnit("裹体之网") then
						if AutoHelp.TryUseAction(mH, "选中镜像") then
							AutoHelp.Debug(">>有镜像或者蛛网裹体，优先击杀！")
							return true
						end
					end
				end;
				return false
			end;
			local function vi()
				if rn then
					if GetStatus("STATUS_元素_火元素图腾") and AutoHelp.TryUseAction(mH, "火元素图腾") then
						vh = nil;
						return true
					end;
					if GetStatus("STATUS_元素_元素掌握") and AutoHelp.TryUseAction(mH, "元素掌握") then
						return true
					end
				end;
				if rV then
					if GetStatus("STATUS_元素_熔岩图腾") and not va() and iG <= 10 then
						if AutoHelp.TryUseAction(mH, "熔岩图腾") then
							return true
						end
					end;
					if GetStatus("STATUS_元素_火焰新星") and v9(GetSpellInfo(58734)) and iG <= 20 then
						if AutoHelp.TryUseAction(mH, "火焰新星") then
							return true
						end
					end;
					if GetStatus("STATUS_元素_闪电链") and AutoHelp.TryUseAction(targetInfo, "闪电链") then
						return true
					end;
					if GetStatus("STATUS_元素_雷霆风暴") and iG <= 10 and AutoHelp.TryUseAction(mH, "雷霆风暴") then
						return true
					end
				end;
				if GetStatus("STATUS_元素_烈焰震击") and AutoHelp.TryUseAction(targetInfo, "烈焰震击") then
					return true
				end;
				if GetStatus("STATUS_元素_元素掌握") and rn and AutoHelp.TryUseAction(mH, "元素掌握") then
					return true
				end;
				if GetStatus("STATUS_元素_熔岩爆裂") and AutoHelp.GetDebuffRemainTime(targetInfo["unit"], "烈焰震击", true) >= 2 and AutoHelp.TryUseAction(targetInfo, "熔岩爆裂") then
					return true
				end;
				if GetStatus("STATUS_元素_雷霆风暴") and iG <= 10 and AutoHelp.TryUseAction(mH, "雷霆风暴") then
					return true
				end;
				if rV and GetStatus("STATUS_元素_闪电链") and AutoHelp.TryUseAction(targetInfo, "闪电链") then
					return true
				end;
				if GetStatus("STATUS_元素_闪电箭") and AutoHelp.TryUseAction(targetInfo, "闪电箭") then
					return true
				end
			end;
			local function vj()
				local vk = AutoHelp.GetUnitBuffNum("player", 53817) == 5;
				local vl = false;
				if vh and GetTime() - vh < 2 then
					vl = true
				end;
				if vk and GetStatus("HEAL_STATUS_FASTHEAL") and mT <= (GetStatusNumber("HEAL_VALUE_FASTHEAL") or 35) / 100 then
					local vm = GetSpellInfo(331)
					if GetStatus("STATUS_瞬发治疗链") then
						vm = GetSpellInfo(1064)
					end;
					if AutoHelp.TryUseAction(mH, vm) then
						return true
					end
				end;
				if rn then
					if iG <= 2 then
						if GetStatus("STATUS_增强_火元素图腾") and AutoHelp.TryUseAction(mH, "火元素图腾") then
							vh = nil;
							return true
						end;
						if GetStatus("STATUS_增强_野性狼魂") and AutoHelp.TryUseAction(mH, "野性狼魂") then
							return true
						end
					end
				end;
				if r7 <= 0.6 and GetStatus("STATUS_增强_萨满之怒") and AutoHelp.TryUseAction(mH, "萨满之怒") then
					return true
				end;
				if GetStatus("STATUS_增强_烈焰震击") and not IsInErrorFace() and AutoHelp.TryUseAction(targetInfo, "烈焰震击") then
					return true
				end;
				if rV then
					aoe = true;
					if vk and GetStatus("STATUS_增强_闪电链") and AutoHelp.TryUseAction(targetInfo, "闪电链") then
						return true
					end;
					if GetStatus("STATUS_增强_熔岩图腾") and (not va() or v9("灼热图腾") or vl) and iG <= 8 then
						if AutoHelp.TryUseAction(mH, "熔岩图腾") then
							vh = nil;
							return true
						end
					end;
					if va() and not vl and GetStatus("STATUS_增强_火焰新星") then
						if AutoHelp.TryUseAction(mH, "火焰新星") then
							return true
						end
					end
				end;
				if not AutoHelp.IsMoving then
					if GetStatus("STATUS_增强_熔岩图腾") and (not va() or vl) and iG <= 5 and AutoHelp.TryUseAction(mH, "熔岩图腾") then
						vh = nil;
						return true
					end;
					if GetStatus("STATUS_增强_灼热图腾") and (not va() or vl) and iG <= 5 and AutoHelp.TryUseAction(mH, "灼热图腾") then
						vh = nil;
						return true
					end
				end;
				if vk and rV and GetStatus("STATUS_增强_闪电链") and AutoHelp.TryUseAction(targetInfo, "闪电链") then
					return true
				end;
				if vk and GetStatus("STATUS_增强_闪电箭") and AutoHelp.TryUseAction(targetInfo, "闪电箭") then
					return true
				end;
				if GetStatus("STATUS_增强_风暴打击") and not IsInErrorFace() and AutoHelp.TryUseAction(targetInfo, "风暴打击") then
					return true
				end;
				if GetStatus("STATUS_增强_大地震击") and not IsInErrorFace() and AutoHelp.TryUseAction(targetInfo, "大地震击") then
					return true
				end;
				if va() and not vl and GetStatus("STATUS_增强_火焰新星") and AutoHelp.TryUseAction(mH, "火焰新星") then
					return true
				end;
				if GetStatus("STATUS_增强_熔岩猛击") and not IsInErrorFace() and AutoHelp.TryUseAction(targetInfo, "熔岩猛击") then
					return true
				end;
				if not IsPlayerAttacking("target") and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
					return true
				end
			end;
			local function vn()
				if AutoHelp.getNumberTargets() >= 2 and GetStatus("STATUS_元素_闪电链") then
					if AutoHelp.TryUseAction(targetInfo, "闪电链") then
						return true
					end
				end;
				if GetStatus("STATUS_元素_烈焰震击") and AutoHelp.TryUseAction(targetInfo, "烈焰震击") then
					return true
				end;
				if GetStatus("STATUS_元素_熔岩爆裂") and AutoHelp.GetBuffRemainTime(targetInfo["unit"], "烈焰震击") <= 1.5 and AutoHelp.TryUseAction(targetInfo, "熔岩爆裂") then
					return true
				end;
				if GetStatus("STATUS_元素_雷霆风暴") and AutoHelp.TryUseAction(mH, "雷霆风暴") then
					return true
				end;
				if GetStatus("STATUS_元素_闪电箭") and AutoHelp.TryUseAction(targetInfo, "闪电箭") then
					return true
				end
			end;
			local kH = jy("HEALMODE")
			if kH == "元素" then
				if vi() then
					return true
				end
			end;
			if kH == "增强" then
				if vj() then
					return true
				end
			end;
			if kH == "治疗" then
				if vn() then
					return true
				end
			end
		end
	end;
	if PlayerIsClass("SHAMAN") then
		AutoHelp.ClassConfig = uX
	end
end;
local function vo()
	local jB = AutoHelp.RegisterKeyCallback;
	local jJ = AutoHelp.HealButtons;
	local jK = AutoHelp.SettingItems;
	local SetConfig = AutoHelp.SetConfig;
	local jy = AutoHelp.GetConfig;
	ahenv.DeathCoil = GetSpellInfo(47541)
	ahenv.IcyTouch = GetSpellInfo(45477)
	ahenv.PlagueStrike = GetSpellInfo(45462)
	ahenv.BloodStrike = GetSpellInfo(45902)
	ahenv.BloodBoil = GetSpellInfo(48721)
	ahenv.DeathandDecay = GetSpellInfo(43265)
	ahenv.HornofWinter = GetSpellInfo(57330)
	ahenv.BoneShield = GetSpellInfo(49222)
	ahenv.GhoulFrenzy = GetSpellInfo(63560)
	ahenv.RaiseDead = GetSpellInfo(46584)
	ahenv.BloodTap = GetSpellInfo(45529)
	ahenv.EmpowerRuneWeapon = GetSpellInfo(47568)
	ahenv.SummonGargoyle = GetSpellInfo(49206)
	ahenv.ArmyoftheDead = GetSpellInfo(42650)
	ahenv.BloodPresence = GetSpellInfo(48266)
	ahenv.IcyPresence = GetSpellInfo(48263)
	ahenv.UnholyPresence = GetSpellInfo(48265)
	ahenv.BlackMagicWeapon = GetSpellInfo(59626)
	ahenv.BerserkWeapon = GetSpellInfo(59620)
	ahenv.Pestilence = GetSpellInfo(50842)
	ahenv.ScourgeStrike = GetSpellInfo(55090)
	ahenv.UnholyStrengthWeapon = GetSpellInfo(53365)
	ahenv.FrostFever = GetSpellInfo(55095)
	ahenv.BloodPlague = GetSpellInfo(55078)
	ahenv.Desolation = GetSpellInfo(66803)
	ahenv.FrostStrike = GetSpellInfo(55268)
	ahenv.FreezingFog = GetSpellInfo(59052)
	ahenv.KillingMachine = GetSpellInfo(51123)
	ahenv.HowlingBlast = GetSpellInfo(49184)
	ahenv.UnbreakableArmor = GetSpellInfo(51271)
	AutoHelp.INTERRUPT_SPELLNAMES = {}
	AutoHelp.CAN_RESCURIT = false;
	AutoHelp.CAN_HEAL = false;
	AutoHelp.CAN_BUFF = false;
	AutoHelp.CAN_DISPEL = false;
	AutoHelp.NAMEPLATES_SHOWENEMIES = 1;
	AutoHelp.NAMEPLATES_MAXDISTANCE = 20;
	AutoHelp.AttackType = 1;
	AutoHelp.AttackRange = 2;
	AutoHelp.CommingHealWindow = 0;
	AutoHelp.NOSTANCES = {}
	local function vp(hK, jI)
		if jI then
			if hK ~= "红脸" then
				SetConfig("STATUS_REDFACE", false)
			end;
			if hK ~= "绿脸" then
				SetConfig("STATUS_GREENFACE", false)
			end;
			if hK ~= "冰脸" then
				SetConfig("STATUS_ICEFACE", false)
			end
		end
	end;
	local function vq()
		if GetStatus("STATUS_REDFACE") then
			return "红脸"
		end;
		if GetStatus("STATUS_GREENFACE") then
			return "绿脸"
		end;
		if GetStatus("STATUS_ICEFACE") then
			return "冰脸"
		end
	end;
	local sJ = "冰霜"
	local n9 = {
		{
			name = "传染",
			spellId = true,
			["target"] = true,
			["attack"] = true
		},
		{
			name = "天灾契约",
			spellId = true
		},
		{
			name = "活力分流",
			spellId = true
		},
		{
			name = "冰封之韧",
			spellId = true
		},
		{
			name = "吸血鬼之血",
			spellId = true
		},
		{
			name = "反魔法护罩",
			spellId = true
		},
		{
			name = "绞袭",
			spellId = true,
			["target"] = true
		},
		{
			name = "血液沸腾",
			spellId = true
		},
		{
			name = "鲜血打击",
			spellId = true,
			["target"] = true,
			["attack"] = true,
			["sp"] = true,
			["bomb"] = true,
			["ys"] = 3
		},
		{
			name = "鲜血灵气",
			spellId = true
		},
		{
			name = "黑暗命令",
			spellId = true,
			["target"] = true
		},
		{
			name = "冰冷触摸",
			spellId = true,
			["target"] = true,
			["attack"] = true
		},
		{
			name = "冰霜之路",
			spellId = true,
			["auraNameCID"] = true
		},
		{
			name = "冰霜灵气",
			spellId = true,
			["auraNameCID"] = true
		},
		{
			name = "寒冬号角",
			spellId = true,
			["auraNameCID"] = true
		},
		{
			name = "寒冬号角2",
			spellId = true,
			["spellName"] = "寒冬号角"
		},
		{
			name = "寒冰锁链",
			spellId = true,
			["target"] = true,
			["debuffCID"] = true
		},
		{
			name = "心灵冰冻",
			spellId = true,
			["target"] = true
		},
		{
			name = "焦点心灵冰冻",
			spellId = true,
			["spellName"] = "心灵冰冻",
			["macro"] = "/cast [target=focus,exists,nodead]心灵冰冻;心灵冰冻\n",
			["spellTime"] = 0.2,
			["desc"] = "焦点心灵冰冻断"
		},
		{
			name = "湮没",
			spellId = true,
			["target"] = true,
			["attack"] = true,
			["sp"] = true,
			["bomb"] = true,
			["ys"] = 3
		},
		{
			name = "冰霜打击",
			spellId = true,
			["target"] = true,
			["attack"] = true
		},
		{
			name = "凛风冲击",
			spellId = true
		},
		{
			name = "符文打击",
			spellId = true,
			["target"] = true
		},
		{
			name = "符文武器增效",
			spellId = true
		},
		{
			name = "铜墙铁壁",
			spellId = true,
			["target"] = true
		},
		{
			name = "邪恶狂热",
			spellId = true,
			["target"] = true
		},
		{
			name = "亡者复生",
			spellId = true
		},
		{
			name = "亡者大军",
			spellId = true
		},
		{
			name = "凋零缠绕",
			spellId = true,
			["target"] = true
		},
		{
			name = "召唤石像鬼",
			spellId = true
		},
		{
			name = "复活盟友",
			spellId = true
		},
		{
			name = "暗影打击",
			spellId = true,
			["target"] = true,
			["attack"] = true,
			["sp"] = true,
			["bomb"] = true,
			["ys"] = 3
		},
		{
			name = "枯萎凋零",
			spellId = true,
			["macro"] = "/cast [@player]枯萎凋零\n"
		},
		{
			name = "死亡之握",
			spellId = true,
			["target"] = true
		},
		{
			name = "灵界打击",
			spellId = true,
			["target"] = true,
			["attack"] = true,
			["sp"] = true,
			["bomb"] = true,
			["ys"] = 3
		},
		{
			name = "符文分流",
			spellId = true
		},
		{
			name = "白骨之盾",
			spellId = true,
			["auraNameCID"] = true
		},
		{
			name = "邪恶灵气",
			spellId = true,
			["auraNameCID"] = true
		},
		{
			name = "食尸鬼狂乱",
			spellId = true,
			["auraNameCID"] = true
		},
		{
			name = "黑锋之门",
			spellId = true
		}
	}
	function AutoHelp.GetActionStartKeys()
		return n9
	end;
	function AutoHelp.LoadActionKeys()
		AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
		AutoHelp.HEAL_ACTION_KEYS = AutoHelp.LoopActionKeys(n9)
		AutoHelp.DefaultMode = "冰霜"
		AutoHelp.ModeDefaultSetting = {
			["HEAL_STATUS_START"] = true,
			["STATUS_主动攻击"] = true,
			["STATUS_治疗模式"] = false
		}
		AutoHelp.HEAL_MODES = {
			["冰霜"] = {
				["modetip"] = "\124cffFFF569已设置为系统缺省【冰霜】。\124r"
			},
			["邪恶"] = {
				["modetip"] = "\124cffFFF569已设置为【邪恶】。\124r"
			},
			["鲜血"] = {
				["modetip"] = "\124cffFFF569已设置为【鲜血】。\124r"
			},
			["红脸邪恶"] = {
				["modetip"] = "\124cffFFF569已设置为【红脸邪恶】。\124r"
			},
			["绿脸邪恶"] = {
				["modetip"] = "\124cffFFF569已设置为【绿脸邪恶】。\124r"
			}
		}
		AutoHelp.ModeList = {
			{
				text = "输出模式",
				notCheckable = true,
				isTitle = true
			},
			{
				text = "\124cff00ff00冰霜\124r",
				name = "冰霜",
				tooltipTitle = "冰霜",
				tooltipText = "使用冰霜技能。"
			},
			{
				text = "\124cff00ff00邪恶\124r",
				name = "邪恶",
				tooltipTitle = "邪恶",
				tooltipText = "使用邪恶技能"
			},
			{
				text = "\124cffFFFFFF鲜血\124r",
				name = "鲜血",
				tooltipTitle = "鲜血",
				tooltipText = "使用鲜血技能"
			}
		}
		AutoHelp.PANELHEIGHT = 420;
		AutoHelp.PANELWIDTH = 160;
		AutoHelp.PANEL_CONFIG = {
			["healer"] = {
				{
					["type"] = "fontstring",
					["id"] = "ATTACK_OTHER_SETTING3",
					["value"] = "\124cff00ff00辅助功能设置\124r",
					["width"] = 140,
					["height"] = 25,
					["point"] = 5,
					["nextpos"] = true
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_邪恶狂热",
					["value"] = true,
					["title"] = "狂热",
					["tip"] = "\124cff00ff00自动队友邪恶狂热，一般选择给DPS最高的近战。\124r",
					["point"] = 5,
					["offset"] = 22,
					["hitRect"] = - 25,
					["nextpos"] = true,
					["mode"] = "鲜血",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("邪恶狂热") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "button",
					["id"] = "BUTTON_邪恶狂热",
					["title"] = "选择狂热目标",
					["tipTitle"] = "邪恶狂热队友选择",
					["tip"] = "\n\n\124cff00ff00在设定好队伍/团队人员之后，将自动给邪恶狂热给队友, 不选择给自己\124r",
					["width"] = 100,
					["height"] = 25,
					["point"] = 55,
					["nextpos"] = false,
					["mode"] = "鲜血",
					["create"] = function(kl)
						local cd = jy("邪恶狂热")
						if cd then
							kl:SetText(cd)
						else
							kl:SetText("无")
						end
					end,
					["fnc"] = function(kl)
						local tInfo = GetRaidUnit("target")
						if tInfo == nil and jy("邪恶狂热") == "无" then
							AutoHelp.Debug("要设置道标目标请先选择队友！")
							return
						end;
						if tInfo ~= nil then
							SetConfig("邪恶狂热", tInfo["name"])
							AutoHelp.Debug("设置邪恶狂热目标：" .. tInfo["name"])
						else
							SetConfig("邪恶狂热", "无")
							AutoHelp.Debug("清除邪恶狂热目标。")
						end
					end
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_AUTOINTERUPT",
					["value"] = true,
					["title"] = "自动打断",
					["tip"] = "使用心灵冰冻技能, 自动打断当前目标/焦点目标, 设置里面可以设置打断读条比例, 缺省读条20%打断。如果需要补断, 比如将军可以设置70%补断.\n\n\124cff00ff00如果需要手动打断, 请不要勾选此项, 比如25人将军打断任务。",
					["point"] = 5,
					["hitRect"] = - 50,
					["nextpos"] = true
				},
				{
					["type"] = "editbox",
					["id"] = "VALUE_AUTOINTERUPT",
					["value"] = 20,
					["point"] = 100,
					["nextpos"] = false,
					["percent"] = "%"
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_黑暗命令",
					["value"] = true,
					["title"] = "自动嘲讽",
					["tip"] = "使用黑暗命令自动嘲讽当前目标(开怪或者OT)",
					["hitRect"] = - 40,
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血"
				},
				{
					["type"] = "fontstring",
					["id"] = "ATTACK_OTHER_SETTING",
					["value"] = "\124cff00ff00副本特殊功能\124r",
					["width"] = 140,
					["height"] = 25,
					["point"] = 5,
					["nextpos"] = true
				},
				{
					["type"] = "checkbox",
					["id"] = "HEAL_STATUS_协助坦克",
					["value"] = true,
					["title"] = "协助坦克",
					["tip"] = "当目进入随机副本时，自动设置坦克为协助攻击对象。团本此功能不会生效. \n\n\124cff00ff00此功能只在输出模式下为缺省勾选，建议治疗模式不要选择。\124r",
					["hitRect"] = - 60,
					["point"] = 5,
					["nextpos"] = true
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_自动炸弹",
					["value"] = true,
					["title"] = "邪铁炸弹",
					["tip"] = "在技能中绑定[萨隆邪铁炸弹]/腰带钴质破片炸弹, 小怪使用腰带炸弹, 骷髅级别BOSS才卡CD使用萨隆邪铁炸弹, 请在背包保留足够的炸弹。\n\n\124cff00ff00萨隆邪铁炸弹只在目标为骷髅级BOSS时才触发！\124r",
					["hitRect"] = - 60,
					["point"] = 80,
					["nextpos"] = false
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_爆发自动",
					["value"] = true,
					["title"] = "爆发",
					["tipTitle"] = "饰品/大技能自动开启",
					["tip"] = "职业爆发技能卡CD释放, 工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00此选项为懒人选择,不浪费任何爆发技能！\124r",
					["hitRect"] = - 30,
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "attack",
					["fnc"] = function(jI)
						if jI then
							SetConfig("STATUS_爆发嗜血", false)
						end
					end
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_爆发嗜血",
					["value"] = false,
					["title"] = AutoHelp.SXNAME,
					["tipTitle"] = "饰品/大技能在" .. AutoHelp.SXNAME .. "时开启",
					["tip"] = AutoHelp.SXNAME .. "时开启职业技能,使用工程手套/饰品/种族技能[兽人血性狂怒, 巨魔狂暴]。\n\n\124cff00ff00英勇/嗜血开启爆发后, 会在BOSS战中卡CD继续释放爆发技能和饰品！\124r",
					["hitRect"] = - 30,
					["point"] = 60,
					["nextpos"] = false,
					["mode"] = "attack",
					["fnc"] = function(jI)
						if jI then
							SetConfig("STATUS_爆发自动", false)
						end
					end
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_爆发喝药",
					["value"] = true,
					["title"] = "嗑药",
					["tipTitle"] = AutoHelp.SXNAME .. "开启后喝药",
					["tip"] = AutoHelp.SXNAME .. "时吃爆发药剂[狂野魔法药水/加速药水], 请在背包保留足够的药剂。\n\n\124cff00ff00此功能只在目标为骷髅级BOSS时才触发！\124r",
					["hitRect"] = - 30,
					["point"] = 110,
					["nextpos"] = false,
					["mode"] = "attack"
				},
				{
					["type"] = "checkbox",
					["id"] = "HEAL_STATUS_AOE",
					["value"] = true,
					["title"] = "自动AOE",
					["tip"] = "程序根据战斗中敌对目标数量，自动选择单体或者AOE功能，如果身边8码范围怪物数量大于等于2个，将自动启动顺劈群攻技能进行AOE。\n\n\124cff00ff00单个目标，不会触发AOE技能，如果需要全力输出boss，可以不选择！\124r",
					["point"] = 5,
					["nextpos"] = true,
					["fnc"] = function(hK)
						if hK then
							SetConfig("STATUS_冰霜_血液沸腾", true)
							SetConfig("STATUS_邪恶_传染", true)
						else
							SetConfig("STATUS_冰霜_血液沸腾", false)
							SetConfig("STATUS_邪恶_传染", false)
						end
					end
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_始终AOE",
					["value"] = false,
					["title"] = "始终AOE",
					["tip"] = "一直使用AOE技能进行攻击,比如在打左右手的时候始终使用AOE技能。",
					["hitRect"] = - 30,
					["point"] = 80,
					["nextpos"] = false,
					["fnc"] = function(jI)
						if jI then
							SetConfig("STATUS_冰霜_血液沸腾", true)
						end
					end
				},
				{
					["type"] = "fontstring",
					["id"] = "ATTACK_OTHER_SETTING",
					["value"] = "\124cff00ff00攻击技能选择\124r",
					["width"] = 140,
					["height"] = 25,
					["point"] = 5,
					["nextpos"] = true
				}
			},
			["setting"] = {
				{
					["type"] = "fontstring",
					["id"] = "ATTACK_SAVE_SETTING",
					["value"] = "\124cff00ff00危机技能设置\124r",
					["width"] = 140,
					["height"] = 25,
					["point"] = 5,
					["nextpos"] = true
				},
				{
					["type"] = "checkbox",
					["id"] = "HEAL_STATUS_灵打血量",
					["hide"] = not AutoHelp.HasActionKey("灵界打击"),
					["hitRect"] = - 60,
					["value"] = true,
					["title"] = "灵界打击",
					["tip"] = "当自身血量低于设定值后, 优先使用灵界打击回血，缺省设置80%\n\n\124cff00ff00只有技能选择了灵界打击, 此设置才会生效!\124r",
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("灵界打击") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "editbox",
					["id"] = "HEAL_VALUE_灵打血量",
					["hide"] = not AutoHelp.HasActionKey("灵界打击"),
					["value"] = 70,
					["point"] = 100,
					["percent"] = "%",
					["nextpos"] = false,
					["mode"] = "鲜血"
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_符文分流",
					["hide"] = not AutoHelp.HasActionKey("符文分流"),
					["hitRect"] = - 60,
					["value"] = true,
					["title"] = "符文分流",
					["tip"] = "当自身血量低于设定值后, 自动使用符文分流回血，缺省设置20%\n\n\124cff00ff00只有技能选择了符文分流, 此设置才会生效!\124r",
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("符文分流") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "editbox",
					["id"] = "VALUE_符文分流",
					["hide"] = not AutoHelp.HasActionKey("符文分流"),
					["value"] = 60,
					["point"] = 100,
					["percent"] = "%",
					["nextpos"] = false,
					["mode"] = "鲜血"
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_反魔法护罩",
					["hide"] = not AutoHelp.HasActionKey("反魔法护罩"),
					["hitRect"] = - 60,
					["value"] = true,
					["title"] = "魔法护罩",
					["tip"] = "当自身血量低于设定值后, 自动使用反魔法护罩减伤，缺省设置20%\n\n\124cff00ff00只有技能选择了反魔法护罩, 此设置才会生效!\124r",
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血,冰霜,邪恶",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("反魔法护罩") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "editbox",
					["id"] = "VALUE_反魔法护罩",
					["hide"] = not AutoHelp.HasActionKey("反魔法护罩"),
					["value"] = 50,
					["point"] = 100,
					["percent"] = "%",
					["nextpos"] = false,
					["mode"] = "鲜血,冰霜,邪恶"
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_吸血鬼之血",
					["hide"] = not AutoHelp.HasActionKey("吸血鬼之血"),
					["hitRect"] = - 60,
					["value"] = true,
					["title"] = "吸血鬼血",
					["tip"] = "当自身血量低于设定值后, 自动使用吸血鬼之血减伤，缺省设置20%\n\n\124cff00ff00只有技能选择了吸血鬼之血, 此设置才会生效!\124r",
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("吸血鬼之血") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "editbox",
					["id"] = "VALUE_吸血鬼之血",
					["hide"] = not AutoHelp.HasActionKey("吸血鬼之血"),
					["value"] = 35,
					["point"] = 100,
					["percent"] = "%",
					["nextpos"] = false,
					["mode"] = "鲜血"
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_天灾契约",
					["hide"] = not AutoHelp.HasActionKey("天灾契约"),
					["hitRect"] = - 60,
					["value"] = true,
					["title"] = "天灾契约",
					["tip"] = "当自身血量低于设定值后, 自动使用天灾契约回血，缺省设置20%\n\n\124cff00ff00只有技能选择了天灾契约, 此设置才会生效!\124r",
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("天灾契约") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "editbox",
					["id"] = "VALUE_天灾契约",
					["hide"] = not AutoHelp.HasActionKey("天灾契约"),
					["value"] = 20,
					["point"] = 100,
					["percent"] = "%",
					["nextpos"] = false,
					["mode"] = "鲜血"
				},
				{
					["type"] = "checkbox",
					["id"] = "STATUS_冰封之韧",
					["hide"] = not AutoHelp.HasActionKey("冰封之韧"),
					["hitRect"] = - 60,
					["value"] = true,
					["title"] = "冰封之韧",
					["tip"] = "当自身血量低于设定值后, 自动使用冰封之韧减伤，缺省设置20%\n\n\124cff00ff00只有技能选择了冰封之韧, 此设置才会生效!\124r",
					["point"] = 5,
					["nextpos"] = true,
					["mode"] = "鲜血,冰霜,邪恶",
					["create"] = function(ko)
						if not AutoHelp.HasActionKey("冰封之韧") then
							ko:Disable()
						end
					end
				},
				{
					["type"] = "editbox",
					["id"] = "VALUE_冰封之韧",
					["hide"] = not AutoHelp.HasActionKey("冰封之韧"),
					["value"] = 35,
					["point"] = 100,
					["percent"] = "%",
					["nextpos"] = false,
					["mode"] = "鲜血,冰霜,邪恶"
				}
			}
		}
		local qQ = {
			{
				{
					"鲜血_寒冬号角",
					"寒冬号角",
					true,
					"号角",
					"鲜血"
				},
				{
					"鲜血_灵界打击",
					"灵界打击",
					true,
					"灵打",
					"鲜血"
				},
				{
					"鲜血_符文打击",
					"符文打击",
					true,
					"符打",
					"鲜血"
				},
				{
					"鲜血_冰冷触摸",
					"冰冷触摸",
					true,
					"冰触",
					"鲜血"
				},
				{
					"鲜血_暗影打击",
					"暗影打击",
					true,
					"暗打",
					"鲜血"
				},
				{
					"鲜血_鲜血打击",
					"鲜血打击",
					true,
					"血打",
					"鲜血"
				},
				{
					"鲜血_心脏打击",
					"心脏打击",
					true,
					"心打",
					"鲜血"
				},
				{
					"鲜血_活力分流",
					"活力分流",
					true,
					"活分",
					"鲜血"
				},
				{
					"鲜血_凋零缠绕",
					"凋零缠绕",
					true,
					"缠绕",
					"鲜血"
				},
				{
					"鲜血_传染",
					"传染",
					true,
					"传染",
					"鲜血"
				},
				{
					"鲜血_枯萎凋零",
					"枯萎凋零",
					true,
					"凋零",
					"鲜血"
				},
				{
					"鲜血_血液沸腾",
					"血液沸腾",
					true,
					"血沸",
					"鲜血"
				},
				{
					"鲜血_死亡之握",
					"死亡之握",
					true,
					"死握",
					"鲜血"
				}
			},
			{
				{
					"冰霜_亡者复生",
					"亡者复生",
					true,
					"复生",
					"冰霜"
				},
				{
					"冰霜_亡者大军",
					"亡者大军",
					true,
					"大军",
					"冰霜"
				},
				{
					"冰霜_寒冬号角",
					"寒冬号角",
					true,
					"号角",
					"冰霜"
				},
				{
					"冰霜_铜墙铁壁",
					"铜墙铁壁",
					true,
					"铜墙",
					"冰霜"
				},
				{
					"冰霜_反魔法护罩",
					"反魔法护罩",
					true,
					"魔罩",
					"冰霜"
				},
				{
					"冰霜_活力分流",
					"活力分流",
					true,
					"分流",
					"冰霜"
				},
				{
					"冰霜_鲜血打击",
					"鲜血打击",
					true,
					"血打",
					"冰霜"
				},
				{
					"冰霜_血液沸腾",
					"血液沸腾",
					true,
					"血沸",
					"冰霜"
				},
				{
					"冰霜_冰冷触摸",
					"冰冷触摸",
					true,
					"冰触",
					"冰霜"
				},
				{
					"冰霜_暗影打击",
					"暗影打击",
					true,
					"暗打",
					"冰霜"
				},
				{
					"冰霜_湮没",
					"湮没",
					true,
					"湮没",
					"冰霜"
				},
				{
					"冰霜_冰霜打击",
					"冰霜打击",
					true,
					"冰打",
					"冰霜"
				},
				{
					"冰霜_符文武器增效",
					"符文武器增效",
					true,
					"符武",
					"冰霜"
				},
				{
					"冰霜_凛风冲击",
					"凛风冲击",
					true,
					"凛风",
					"冰霜"
				},
				{
					"冰霜_传染",
					"传染",
					true,
					"传染",
					"冰霜"
				}
			},
			{
				{
					"邪恶_白骨之盾",
					"白骨之盾",
					true,
					"骨盾",
					"邪恶"
				},
				{
					"邪恶_亡者复生",
					"亡者复生",
					true,
					"复生",
					"邪恶"
				},
				{
					"邪恶_反魔法护罩",
					"反魔法护罩",
					true,
					"魔罩",
					"邪恶"
				},
				{
					"邪恶_食尸鬼狂乱",
					"食尸鬼狂乱",
					true,
					"狂乱",
					"邪恶"
				},
				{
					"邪恶_寒冬号角",
					"寒冬号角",
					true,
					"号角",
					"邪恶"
				},
				{
					"邪恶_活力分流",
					"活力分流",
					true,
					"分流",
					"邪恶"
				},
				{
					"邪恶_鲜血打击",
					"鲜血打击",
					true,
					"血打",
					"邪恶"
				},
				{
					"邪恶_冰冷触摸",
					"冰冷触摸",
					true,
					"冰触",
					"邪恶"
				},
				{
					"邪恶_暗影打击",
					"暗影打击",
					true,
					"暗打",
					"邪恶"
				},
				{
					"邪恶_枯萎凋零",
					"枯萎凋零",
					true,
					"凋零",
					"邪恶"
				},
				{
					"邪恶_凋零缠绕",
					"凋零缠绕",
					true,
					"缠绕",
					"邪恶"
				},
				{
					"邪恶_符文武器增效",
					"符文武器增效",
					true,
					"符武",
					"邪恶"
				},
				{
					"邪恶_血液沸腾",
					"血液沸腾",
					true,
					"血沸",
					"邪恶"
				},
				{
					"邪恶_传染",
					"传染",
					true,
					"传染",
					"邪恶"
				},
				{
					"邪恶_召唤石像鬼",
					"召唤石像鬼",
					true,
					"天鬼",
					"邪恶"
				},
				{
					"邪恶_亡者大军",
					"亡者大军",
					true,
					"大军",
					"邪恶"
				}
			}
		}
		for _, qR in pairs(qQ) do
			local jS = 1;
			for _, qS in pairs(qR) do
				local cd, lS, lT, lU, ib, iG, lV = GetSpellInfo(qS[2])
				if cd and AutoHelp.HasActionKey(qS[2]) then
					local point, kf;
					if jS % 3 == 1 then
						point = 5;
						kf = true
					elseif jS % 3 == 2 then
						point = 55;
						kf = false
					else
						point = 105;
						kf = false
					end;
					local eS = {
						["type"] = "checkbox",
						["id"] = "STATUS_" .. qS[1],
						["value"] = qS[3],
						["title"] = qS[4],
						["tipTitle"] = qS[2],
						["tip"] = qS[2],
						["point"] = point,
						["nextpos"] = kf,
						["stance"] = qS[5],
						["mode"] = qS[5]
					}
					if qS[6] then
						eS["tip"] = qS[6]
					end;
					if jS == 1 then
						eS["base"] = true
					end;
					table.insert(AutoHelp.PANEL_CONFIG["healer"], eS)
					jS = jS + 1
				end
			end
		end
	end;
	function AutoHelp.ModeChanged(kH)
		if kH == nil then
			return
		end;
		if sJ ~= nil and sJ ~= kH and AutoHelp.playerLevel >= 55 then
		end;
		if kH == "红脸邪恶" or kH == "绿脸邪恶" then
			kH = "邪恶"
		end;
		for bi, bn in pairs(AutoHelp.SettingItems) do
			if bn.mode then
				if Contains(bn.mode, kH) or bn.mode == "attack" then
					bn:Show()
				else
					bn:Hide()
				end
			end
		end;
		AutoHelp.ResizePanel()
	end;
	local function qW(qV)
		if GetStatus("HEAL_STATUS_PAUSE") then
			return
		end
	end;
	AutoHelp.HandlerBossEvent = qW;
	function AutoHelp.RegisterBossEvent()
	end;
	function AutoHelp.OnSpellSucceeded(ho, fR, ca)
		if ca == 49206 then
		end
	end;
	function AutoHelp.SPELL_AURA_APPLIED(tInfo, tk, nZ)
	end;
	function AutoHelp.SPELL_AURA_REMOVED(tInfo, tk, nZ)
	end;
	function AutoHelp.AutoCreateMacro()
		local kH = jy("HEALMODE")
		if kH == "邪恶" then
			if AutoHelp.HasActionKey("亡者大军") then
				FindOrCreateMacro("大军", nil, "#showtooltips 亡者大军\n/ahcast 亡者大军\n", 1)
			end;
			if AutoHelp.HasActionKey("心灵冰冻") then
				FindOrCreateMacro("焦点打断", nil, "#showtooltips 心灵冰冻\n/cast [target=focus,exists,nodead]心灵冰冻;心灵冰冻\n", 2)
			end;
			if AutoHelp.HasActionKey("召唤石像鬼") then
				FindOrCreateMacro("天鬼", nil, "#showtooltips 召唤石像鬼\n/ahcast 召唤石像鬼\n", 3)
			end
		end;
		if kH == "冰霜" then
			if AutoHelp.HasActionKey("亡者大军") then
				FindOrCreateMacro("大军", nil, "#showtooltips 亡者大军\n/ahcast 亡者大军\n", 1)
			end;
			if AutoHelp.HasActionKey("心灵冰冻") then
				FindOrCreateMacro("焦点打断", nil, "#showtooltips 心灵冰冻\n/cast [target=focus,exists,nodead]心灵冰冻;心灵冰冻\n", 2)
			end
		end;
		if kH == "鲜血" then
			if AutoHelp.HasActionKey("亡者大军") then
				FindOrCreateMacro("大军", nil, "#showtooltips 亡者大军\n/ahcast 亡者大军\n", 1)
			end;
			if AutoHelp.HasActionKey("心灵冰冻") then
				FindOrCreateMacro("焦点打断", nil, "#showtooltips 心灵冰冻\n/cast [target=focus,exists,nodead]心灵冰冻;心灵冰冻\n", 2)
			end;
			if AutoHelp.HasActionKey("冰冷触摸") then
				FindOrCreateMacro("开怪6冰", nil, "#showtooltips 冰冷触摸\n/ahcast 冰冷触摸/冰冷触摸/活力分流/冰冷触摸/符文武器增效/冰冷触摸/冰冷触摸/冰冷触摸\n", 3)
			end
		end;
		FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
		FindOrCreateMacro("AOE切换", 136116, "/run AutoHelp.ToggleAOE()\n", 52)
	end;
	function AutoHelp.SpellDamageAction(fm, aj, fu, ca, cx, amount)
	end;
	function AutoHelp.ThreatChanged(mt, sQ, sR, sS)
	end;
	function AutoHelp.EncounterStart(sT, sU, rx, sV)
	end;
	function AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
	end;
	function AutoHelp.ClassInit()
		AutoHelp.RegisterKeyCallback("邪恶狂热", function(hK)
			local k8 = AutoHelp.SettingItems["BUTTON_邪恶狂热"]
			if k8 then
				k8:SetText(hK)
			end
		end)
		AutoHelp.HEAL_PLAYER_TALENTS = AutoHelp.GetPlayerTalent()
		if AutoHelp.playerLevel >= 10 then
			local vr, vs, vt = AutoHelp.HEAL_PLAYER_TALENTS[1] or 0, AutoHelp.HEAL_PLAYER_TALENTS[2] or 0, AutoHelp.HEAL_PLAYER_TALENTS[3] or 0;
			local kH = jy("HEALMODE")
			if vr > vs and vr > vt then
				sJ = "鲜血"
				AutoHelp.talent = "鲜血"
			end;
			if vs > vr and vs > vt then
				sJ = "冰霜"
				AutoHelp.talent = "冰霜"
			end;
			if vt > vr and vt > vs then
				sJ = "邪恶"
				AutoHelp.talent = "邪恶"
			end;
			if kH == nil then
				SetConfig("HEALMODE", sJ, true)
			end
		end;
		SetConfig("HEAL_STATUS_快速施法", false)
	end;
	function AutoHelp.DoUrgentAction(mH, targetInfo)
	end;
	function AutoHelp.DoUncombatAction(mH)
	end;
	function AutoHelp.DoCommonAction(mH)
	end;
	function AutoHelp.DoInterrupt(mH, b8, cd, to, tp, ca)
		local ib, iG = AutoHelp.GetRange(b8)
		if iG <= 2 and AutoHelp.TryUseAction(mH, "焦点心灵冰冻") then
			return true
		end
	end;
	local function vu(vv)
		local itemLink = GetInventoryItemLink("player", vv)
		if itemLink then
			local vw = select(3, strfind(itemLink, "|H(.+)|h"))
			local _, kq, vx, vy = strsplit(":", vw)
			return tonumber(kq), tonumber(vx), tonumber(vy)
		end
	end;
	local function vz()
		local ke, vA, vB = UnitAttackPower("player")
		local vC = ke + vA;
		local vD, vE, vA, vB = UnitStat("player", 1)
		local b7, lt, vF = 0, 0, 0;
		local vG = (select(5, GetTalentInfo(2, 2)) * 2 + select(5, GetTalentInfo(3, 3))) * 0.01;
		ahenv.st1 = false;
		ahenv.st2 = false;
		ahenv.gbk = false;
		ahenv.bm = false;
		ahenv.ta = false;
		if AutoHelp.UnitHasBuff("player", 58646) then
			ahenv.st1 = true
		end;
		if AutoHelp.UnitHasBuff("player", 57623) then
			ahenv.st2 = true
		end;
		if AutoHelp.UnitHasBuff("player", 25898) or AutoHelp.UnitHasBuff("player", 20217) then
			ahenv.gbk = true
		end;
		if AutoHelp.UnitHasBuff("player", 47436) or AutoHelp.UnitHasBuff("player", 48934) or AutoHelp.UnitHasBuff("player", 48932) then
			ahenv.bm = true
		end;
		if AutoHelp.UnitHasBuff("player", 30809) or AutoHelp.UnitHasBuff("player", 19506) then
			ahenv.ta = true
		end;
		if AutoHelp.UnitHasBuff("player", 53365) then
			b7 = math.ceil(vD - vD / 1.15)
		end;
		if AutoHelp.UnitHasBuff("player", 60229) then
			lt = math.ceil(300 * (1 + vG))
		end;
		if AutoHelp.UnitHasBuff("player", 67773) then
			vF = math.ceil(510 * (1 + vG))
		end;
		if AutoHelp.UnitHasBuff("player", 67708) then
			vF = math.ceil(450 * (1 + vG))
		end;
		local vH = 0;
		if ahenv.gbk == true then
			vH = b7 + lt + vF - (b7 + lt + vF) / 1.1
		end;
		ahenv.Initap = vC - (b7 + lt + vF) * 2 - vH;
		return ahenv.Initap
	end;
	ahenv.group = 0;
	function AutoHelp.Player_Regen_Enabled()
		ahenv.group = 0
	end;
	function AutoHelp.Player_Regen_Disabled()
	end;
	local function vI(v)
		local lJ, cn, vJ = GetRuneCooldown(v)
		if vJ then
			return 0
		else
			return lJ + cn - GetTime()
		end
	end;
	local rU = GetTime()
	function AutoHelp.DoAttackAction(mH, targetInfo)
		local mT, si = mH["hp"], UnitPower("player")
		local tq = GetShapeshiftForm()
		local sj = AutoHelp.castinfo.nextSwing;
		local ib, iG = AutoHelp.GetRange("target")
		local ta = IsPetAttackActive()
		local mM = mH["Auras"][57723] or mH["Auras"][57724]
		local mN = mH["Auras"][32182] or mH["Auras"][2825]
		local rn = (AutoHelp.IsInRaid and UnitLevel("target") == - 1 or not AutoHelp.IsInRaid) and (GetStatus("STATUS_爆发嗜血") and mM or GetStatus("STATUS_爆发自动"))
		local vK = vI(1)
		local vL = vI(2)
		local vM = vI(3)
		local vN = vI(4)
		local vO = vI(5)
		local vP = vI(6)
		local vQ = GetRuneType(1)
		local vR = GetRuneType(2)
		local vS = GetRuneType(3)
		local vT = GetRuneType(4)
		local vU = GetRuneType(5)
		local vV = GetRuneType(6)
		local cp, k5, vW, vX;
		if vK > vL then
			cp = vL
		else
			cp = vK
		end;
		if vM > vN then
			k5 = vM
		else
			k5 = vN
		end;
		if vO > vP then
			vW = vO
		else
			vW = vP
		end;
		local vY = vK == 0 and vL == 0 and vM == 0 and vN == 0 and vO == 0 and vP == 0;
		vX = math.max(cp, k5, vW)
		local function vZ()
			local v_ = AutoHelp.GetBuffRemainTime("player", ahenv.UnbreakableArmor)
			local w0 = GetSpellCooldownTime(ahenv.UnbreakableArmor)
			local w1 = AutoHelp.GetBuffRemainTime("player", ahenv.KillingMachine)
			local w2 = AutoHelp.GetBuffRemainTime("player", ahenv.FreezingFog)
			local w3 = AutoHelp.GetDebuffRemainTime("target", ahenv.BloodPlague, true)
			local w4 = AutoHelp.GetDebuffRemainTime("target", ahenv.FrostFever, true)
			local w5 = math.min(w3, w4)
			local w6 = (vK == 0 and 1 or 0) + (vL == 0 and 1 or 0) + (vM == 0 and 1 or 0) + (vN == 0 and 1 or 0) + (vO == 0 and 1 or 0) + (vP == 0 and 1 or 0)
			if not AutoHelp.UnitHasBuff("player", ahenv.BloodPresence) and AutoHelp.TryUseAction(mH, ahenv.BloodPresence) then
				return true
			end;
			if GetStatus("STATUS_冰封之韧") then
				local jp = (jy("VALUE_冰封之韧") or 35) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "冰封之韧") then
					return true
				end
			end;
			if GetStatus("STATUS_反魔法护罩") and si >= 20 then
				local jp = (jy("VALUE_反魔法护罩") or 50) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "反魔法护罩") then
					return true
				end
			end;
			if GetStatus("STATUS_冰霜_符文武器增效") and mM and w6 <= 2 and rn then
				if AutoHelp.TryUseAction(mH, "符文武器增效") then
					return true
				end
			end;
			if w5 > 10 and vK > 0 and vL > 0 then
				if GetStatus("STATUS_冰霜_活力分流") and AutoHelp.TryUseAction(mH, "活力分流") then
					return true
				end
			end;
			if GetStatus("STATUS_冰霜_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角") then
				return true
			end;
			if GetStatus("STATUS_冰霜__反魔法护罩") and rn and (mT <= 0.9 or mM) and AutoHelp.TryUseAction(mH, "反魔法护罩") then
				return true
			end;
			if GetStatus("STATUS_冰霜_冰冷触摸") and w4 == 0 and AutoHelp.TryUseAction(targetInfo, "冰冷触摸") then
				return true
			end;
			if GetStatus("STATUS_冰霜_暗影打击") and w3 == 0 and AutoHelp.TryUseAction(targetInfo, "暗影打击") then
				return true
			end;
			if AutoHelp.IsForceAOE(3) then
				if GetStatus("STATUS_冰霜_传染") and w5 > 0 and (floor(w4) ~= floor(w3) or w5 <= 5) and AutoHelp.TryUseAction(targetInfo, "传染") then
					return true
				end;
				if w5 > 0 then
					if GetStatus("STATUS_冰霜_凛风冲击") and AutoHelp.TryUseAction(mH, "凛风冲击") then
						return true
					end
				end;
				if vK == 0 and vL == 0 or vK == 0 and vL > 0 and w5 > vL + 1.5 or vL == 0 and vK > 0 and w5 > vK + 1.5 then
					if GetStatus("STATUS_冰霜_血液沸腾") and AutoHelp.TryUseAction(mH, "血液沸腾") then
						return true
					end
				end
			end;
			if GetStatus("STATUS_冰霜_传染") and w5 <= 5 and w5 > 0 and AutoHelp.TryUseAction(targetInfo, "传染") then
				return true
			end;
			if GetStatus("STATUS_冰霜_铜墙铁壁") and rn and iG <= 2 and AutoHelp.TryUseAction(mH, "铜墙铁壁") then
				return true
			end;
			if (AutoHelp.Glyphs[60200] or AutoHelp.GetItemCount(37201) > 0) and rn and not UnitExists("pet") then
				if GetStatus("STATUS_冰霜_亡者复生") and AutoHelp.TryUseAction(mH, "亡者复生") then
					return true
				end
			end;
			if (vM == 0 or vN == 0) and (vO == 0 or vP == 0) or vK == 0 and vQ == 4 and (vL == 0 and vR == 4) and w5 > 10 or (vK == 0 and vQ == 4 and vL < w5 - 2 or vL == 0 and vR == 4 and vK < w5 - 2) and (vM == 0 or vN == 0 or vO == 0 or vP == 0) then
				if GetStatus("STATUS_冰霜_湮没") and AutoHelp.TryUseAction(targetInfo, "湮没") then
					return true
				end
			end;
			if w2 > 0 then
				if GetStatus("STATUS_冰霜_凛风冲击") and AutoHelp.TryUseAction(mH, "凛风冲击") then
					return true
				end
			end;
			if GetStatus("STATUS_冰霜_冰霜打击") and w1 and AutoHelp.TryUseAction(targetInfo, "冰霜打击") then
				return true
			end;
			if GetStatus("STATUS_冰霜_冰霜打击") and si >= 70 and AutoHelp.TryUseAction(targetInfo, "冰霜打击") then
				return true
			end;
			if vK == 0 and vL == 0 and (vQ == 1 or vR == 1) or vK == 0 and vL > 0 and w5 > vL + 2 and (vQ == 1 or w5 > 10) or vL == 0 and vK > 0 and w5 > vK + 2 and (vR == 1 or w5 > 10) then
				if GetStatus("STATUS_冰霜_鲜血打击") and AutoHelp.TryUseAction(targetInfo, "鲜血打击") then
					return true
				end
			end;
			if GetStatus("STATUS_冰霜_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角2") then
				return true
			end
		end;
		local function w7()
			local dX = GetCombatValue("group") or 0;
			local jS = GetCombatValue("num") or 0;
			local mt = GetCombatValue("status") or 0;
			local w8 = GetTalentSpent(GetSpellInfo(50391)) == 0;
			local w9 = 0;
			if AutoHelp.HasActionKey(ahenv.DeathCoil) then
				w9 = GetSpellPowerCost(ahenv.DeathCoil)[1].cost
			end;
			local wa = 0;
			if AutoHelp.HasActionKey(ahenv.SummonGargoyle) then
				wa = GetSpellPowerCost(ahenv.SummonGargoyle)[1].cost
			end;
			local w3 = AutoHelp.GetDebuffRemainTime("target", ahenv.BloodPlague, true)
			local w4 = AutoHelp.GetDebuffRemainTime("target", ahenv.FrostFever, true)
			local wb = AutoHelp.GetBuffRemainTime("player", ahenv.Desolation)
			local wc = GetSpellCooldownTime(ahenv.DeathandDecay)
			local wd = GetSpellCooldownTime(ahenv.SummonGargoyle)
			local we = AutoHelp.GetBuffRemainTime("pet", ahenv.GhoulFrenzy)
			local wf = AutoHelp.GetBuffRemainTime("player", ahenv.BoneShield)
			local wg = AutoHelp.UnitHasBuff("player", ahenv.BloodPresence)
			local wh = AutoHelp.UnitHasBuff("player", ahenv.UnholyPresence)
			local wi = AutoHelp.UnitHasBuff("player", ahenv.IcyPresence)
			local wj = AutoHelp.UnitHasBuff("player", 53365) or AutoHelp.UnitHasBuff("player", 71227)
			local wk = AutoHelp.UnitHasBuff("player", 60229)
			if GetStatus("STATUS_冰封之韧") then
				local jp = (jy("VALUE_冰封之韧") or 35) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "冰封之韧") then
					return true
				end
			end;
			if GetStatus("STATUS_反魔法护罩") and si >= 20 then
				local jp = (jy("VALUE_反魔法护罩") or 50) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "反魔法护罩") then
					return true
				end
			end;
			if not UnitExists("pet") and (AutoHelp.Glyphs[60200] or AutoHelp.GetItemCount(37201) > 0) then
				if GetStatus("STATUS_邪恶_亡者复生") and AutoHelp.TryUseAction(mH, "亡者复生") then
					return true
				end
			end;
			if GetStatus("STATUS_邪恶_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角") then
				return true
			end;
			if GetStatus("STATUS_邪恶_召唤石像鬼") and wh and wj and rn and (mN or not mN and mM) and AutoHelp.TryUseAction(mH, "召唤石像鬼") then
				return true
			end;
			if GetStatus("STATUS_邪恶_亡者大军") and wd > 0 and rn and (mN or not mN and mM) and AutoHelp.TryUseAction(mH, "亡者大军") then
				return true
			end;
			if vX > 0 and wd <= 10 and rn then
				if GetStatus("STATUS_邪恶_符文武器增效") and AutoHelp.TryUseAction(mH, "符文武器增效") then
					return true
				end
			end;
			if GetStatus("STATUS_邪恶_反魔法护罩") and rn and (mT <= 0.9 or mM) and AutoHelp.TryUseAction(mH, "反魔法护罩") then
				return true
			end;
			if (wj or wk) and si >= w9 and (si >= wa + w9 and wd < 6 or wd >= 6) or si >= 90 then
				if GetStatus("STATUS_邪恶_凋零缠绕") and AutoHelp.TryUseAction(targetInfo, "凋零缠绕") then
					return true
				end
			end;
			if dX == 0 then
				if GetStatus("STATUS_邪恶_天灾打击") and AutoHelp.TryUseAction(targetInfo, "天灾打击") then
					SetCombatValue("started", true)
					SetCombatValue("group", 2)
					return true
				end;
				if GetStatus("STATUS_邪恶_冰冷触摸") and AutoHelp.TryUseAction(targetInfo, "冰冷触摸") then
					SetCombatValue("started", true)
					SetCombatValue("group", 1)
					return true
				end
			end;
			local wl = vq()
			if dX == 1 then
				if not wh and (GetTalentSpent(GetSpellInfo(50391)) == 0 and wd <= 5 and mN or GetTalentSpent(GetSpellInfo(50391)) == 2 or wd >= 150) then
					if AutoHelp.TryUseAction(mH, ahenv.UnholyPresence) then
						SetCombatValue("group", 2)
						return true
					end
				end;
				if wf <= 10 and w3 > 7 then
					if GetStatus("STATUS_邪恶_白骨之盾") and AutoHelp.TryUseAction(mH, "白骨之盾") then
						SetCombatValue("group", 2)
						return true
					end
				end;
				if we <= 10 and w3 > 0 then
					if GetStatus("STATUS_邪恶_食尸鬼狂乱") and AutoHelp.TryUseAction(mH, "食尸鬼狂乱") then
						SetCombatValue("group", 2)
						return true
					end
				end;
				if GetStatus("STATUS_邪恶_暗影打击") and AutoHelp.TryUseAction(targetInfo, "暗影打击") then
					SetCombatValue("group", 2)
					return true
				end
			end;
			if dX == 2 then
				if not wg and GetTalentSpent(GetSpellInfo(50391)) == 0 and wd < 150 then
					if AutoHelp.TryUseAction(mH, ahenv.BloodPresence) then
						SetCombatValue("group", 3)
						return true
					end
				end;
				if AutoHelp.IsForceAOE(2) and w3 > 0 and w4 > 0 then
					if GetStatus("STATUS_邪恶_传染") and AutoHelp.TryUseAction(targetInfo, "传染") then
						SetCombatValue("group", 3)
						return true
					end
				end;
				if wb >= 10 then
					if GetStatus("STATUS_邪恶_血液沸腾") and AutoHelp.TryUseAction(mH, "血液沸腾") then
						SetCombatValue("group", 3)
						return true
					end
				end;
				if GetStatus("STATUS_邪恶_鲜血打击") and AutoHelp.TryUseAction(targetInfo, "鲜血打击") then
					SetCombatValue("group", 3)
					return true
				end
			end;
			if dX == 3 then
				if GetStatus("STATUS_邪恶_枯萎凋零") and AutoHelp.HasActionKey("枯萎凋零") and iG <= 5 and wc <= 3 then
					if AutoHelp.TryUseAction(mH, "枯萎凋零") then
						SetCombatValue("group", 0)
						return true
					end;
					return false
				end;
				SetCombatValue("group", 0)
			end;
			if vY then
				SetCombatValue("group", 0)
			end;
			if GetStatus("STATUS_邪恶_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角2") then
				return true
			end
		end;
		local function wm()
			local v_ = AutoHelp.GetBuffRemainTime("player", ahenv.UnbreakableArmor)
			local w1 = AutoHelp.GetBuffRemainTime("player", ahenv.KillingMachine)
			local w2 = AutoHelp.GetBuffRemainTime("player", ahenv.FreezingFog)
			local w3 = AutoHelp.GetDebuffRemainTime("target", ahenv.BloodPlague, true)
			local w4 = AutoHelp.GetDebuffRemainTime("target", ahenv.FrostFever, true)
			local w5 = math.min(w3, w4)
			local dX = GetCombatValue("group") or 0;
			if not AutoHelp.UnitHasBuff("player", ahenv.IcyPresence) and AutoHelp.TryUseAction(mH, ahenv.IcyPresence) then
				return true
			end;
			if GetStatus("STATUS_冰封之韧") then
				local jp = (jy("VALUE_冰封之韧") or 35) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "冰封之韧") then
					return true
				end
			end;
			if GetStatus("STATUS_吸血鬼之血") then
				local jp = (jy("VALUE_吸血鬼之血") or 35) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "吸血鬼之血") then
					return true
				end
			end;
			if GetStatus("STATUS_符文分流") then
				local jp = (jy("VALUE_符文分流") or 60) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "符文分流") then
					return true
				end
			end;
			if GetStatus("STATUS_反魔法护罩") and si >= 20 then
				local jp = (jy("VALUE_反魔法护罩") or 50) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "反魔法护罩") then
					return true
				end
			end;
			if GetStatus("STATUS_天灾契约") and si >= 40 then
				local jp = (jy("VALUE_天灾契约") or 30) / 100;
				local wn = GetSpellCooldownTime("天灾契约")
				local wo = GetSpellCooldownTime("亡者复生")
				if wn == 0 and mT <= jp then
					if wo == 0 and (AutoHelp.Glyphs[60200] or AutoHelp.GetItemCount(37201) > 0) then
						if AutoHelp.TryUseAction(mH, "亡者复生") then
							return true
						end
					end;
					if wo > 150 and AutoHelp.TryUseAction(mH, "天灾契约") then
						return true
					end
				end
			end;
			if UnitCanAttack("player", "target") and not UnitIsUnit("player", "targettarget") and not UnitIsPVP("target") then
				if GetStatus("STATUS_黑暗命令") then
					local tInfo = GetRaidUnit("targettarget")
					if not tInfo or tInfo and tInfo["role"] ~= "MAINTANK" then
						if AutoHelp.TryUseAction(targetInfo, "黑暗命令") then
							return true
						end
					end
				end
			end;
			if GetStatus("STATUS_鲜血_死亡之握") and iG >= 5 and UnitLevel("target") ~= - 1 then
				local tInfo = GetRaidUnit("targettarget")
				if (not tInfo or tInfo and tInfo["role"] ~= "MAINTANK") and AutoHelp.TryUseAction(targetInfo, "死亡之握") then
					return true
				end
			end;
			if AutoHelp.IsForceAOE(3) then
				if GetStatus("STATUS_鲜血_传染") and w5 > 0 and floor(w4) ~= floor(w3) and AutoHelp.TryUseAction(targetInfo, "传染") then
					return true
				end;
				if GetStatus("STATUS_鲜血_枯萎凋零") and iG <= 5 and AutoHelp.TryUseAction(mH, "枯萎凋零") then
					return true
				end
			end;
			if dX < 6 and rn then
				if iG <= 20 then
					if GetStatus("STATUS_鲜血_冰冷触摸") and AutoHelp.TryUseAction(targetInfo, "冰冷触摸") then
						SetCombatValue("group", dX + 1)
						return true
					end;
					if GetStatus("STATUS_鲜血_活力分流") and AutoHelp.TryUseAction(mH, "活力分流") then
						return true
					end;
					if GetStatus("STATUS_邪恶_符文武器增效") and rn and UnitLevel("target") == - 1 and AutoHelp.TryUseAction(mH, "符文武器增效") then
						return true
					end
				end
			end;
			local sj = AutoHelp.castinfo and AutoHelp.castinfo.nextSwing;
			if GetStatus("STATUS_鲜血_符文打击") and IsUsableSpell("符文打击") and not sj and si > 60 and iG <= 2 and AutoHelp.TryUseAction(targetInfo, "符文打击") then
				return true
			end;
			if GetStatus("STATUS_鲜血_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角") then
				return true
			end;
			if GetStatus("STATUS_鲜血_冰冷触摸") and w4 == 0 and AutoHelp.TryUseAction(targetInfo, "冰冷触摸") then
				return true
			end;
			if GetStatus("STATUS_鲜血_暗影打击") and w3 == 0 and AutoHelp.TryUseAction(targetInfo, "暗影打击") then
				return true
			end;
			local wp = AutoHelp.GetBuffRemainTime("player", GetSpellInfo(64859))
			local wq = GetTalentSpent(GetSpellInfo(55226)) >= 1;
			if wq and (wp <= 2 or (vK <= 2 and vL == 0 or vK == 0 and vL <= 2)) then
				if AutoHelp.IsForceAOE(3) then
					if GetStatus("STATUS_鲜血_传染") and w5 <= 5 and w5 > 0 and AutoHelp.TryUseAction(targetInfo, "传染") then
						return true
					end;
					if GetStatus("STATUS_鲜血_血液沸腾") and AutoHelp.TryUseAction(targetInfo, "血液沸腾") then
						return true
					end
				else
					if AutoHelp.Glyphs[63334] then
						if GetStatus("STATUS_鲜血_传染") and w5 <= 3 and w5 > 0 and AutoHelp.TryUseAction(targetInfo, "传染") then
							return true
						end
					end;
					if GetStatus("STATUS_鲜血_鲜血打击") and AutoHelp.TryUseAction(targetInfo, "鲜血打击") then
						return true
					end
				end
			end;
			if vK >= 4 and vL >= 4 then
				if GetStatus("STATUS_鲜血_活力分流") and AutoHelp.TryUseAction(mH, "活力分流") then
					return true
				end
			end;
			if GetStatus("STATUS_鲜血_灵界打击") then
				if (vM == 0 and vS ~= 4 or vN == 0 and vT ~= 4) and (vO == 0 and vU ~= 4 or vP == 0 and vV ~= 4) then
					local jp = GetStatus("HEAL_STATUS_灵打血量") and (jy("HEAL_VALUE_灵打血量") or 70) / 100 or 0.7;
					if mT <= jp and AutoHelp.TryUseAction(targetInfo, "灵界打击") then
						return true
					end
				end
			end;
			if vO == 0 or vP == 0 or vM == 0 and vS == 4 or vN == 0 and vT == 4 or vK == 0 and vL == 0 and (vQ == 4 or vR == 4) then
				if GetStatus("STATUS_鲜血_冰冷触摸") and AutoHelp.TryUseAction(targetInfo, "冰冷触摸") then
					return true
				end
			end;
			if vK == 0 and vQ ~= 4 and vL == 0 and vR ~= 4 then
				if AutoHelp.IsForceAOE(3) then
					if GetStatus("STATUS_鲜血_血液沸腾") and AutoHelp.TryUseAction(targetInfo, "血液沸腾") then
						return true
					end
				else
					if GetStatus("STATUS_鲜血_鲜血打击") and AutoHelp.TryUseAction(targetInfo, "鲜血打击") then
						return true
					end
				end
			end;
			if GetStatus("STATUS_邪恶狂热") then
				local s8 = HEAL_RAID_NAMES[jy("邪恶狂热")]
				if s8 then
					local tInfo = HEAL_RAID[s8]
					local oE, oF = AutoHelp.GetRange(tInfo["unit"])
					if oF ~= nil then
						if tInfo and oF <= 30 and AutoHelp.TryUseAction(tInfo, "邪恶狂热") then
							return true
						end
					end
				end
			end;
			if AutoHelp.IsForceAOE(3) then
				if GetStatus("STATUS_鲜血_传染") and (floor(w4) ~= floor(w3) or w5 <= 5) and AutoHelp.TryUseAction(targetInfo, "传染") then
					return true
				end
			end;
			if GetStatus("STATUS_鲜血_凋零缠绕") and si >= 80 and AutoHelp.TryUseAction(targetInfo, "凋零缠绕") then
				return true
			end;
			if GetStatus("STATUS_鲜血_暗影打击") and (vM == 0 and vN == 0) and AutoHelp.TryUseAction(targetInfo, "暗影打击") then
				return true
			end
		end;
		local function wr()
			local dX = GetCombatValue("group") or 0;
			local w9 = 0;
			if AutoHelp.HasActionKey(ahenv.DeathCoil) then
				w9 = GetSpellPowerCost(ahenv.DeathCoil)[1].cost
			end;
			local wa = 0;
			if AutoHelp.HasActionKey(ahenv.SummonGargoyle) then
				wa = GetSpellPowerCost(ahenv.SummonGargoyle)[1].cost
			end;
			local w3 = AutoHelp.GetDebuffRemainTime("target", ahenv.BloodPlague, true)
			local w4 = AutoHelp.GetDebuffRemainTime("target", ahenv.FrostFever, true)
			local wb = AutoHelp.GetBuffRemainTime("player", ahenv.Desolation)
			local wc = GetSpellCooldownTime(ahenv.DeathandDecay)
			local wd = GetSpellCooldownTime(ahenv.SummonGargoyle)
			local we = AutoHelp.GetBuffRemainTime("pet", ahenv.GhoulFrenzy)
			local wf = AutoHelp.GetBuffRemainTime("player", ahenv.BoneShield)
			local wg = AutoHelp.UnitHasBuff("player", ahenv.BloodPresence)
			local wh = AutoHelp.UnitHasBuff("player", ahenv.UnholyPresence)
			local wi = AutoHelp.UnitHasBuff("player", ahenv.IcyPresence)
			local wj = AutoHelp.UnitHasBuff("player", 53365) or AutoHelp.UnitHasBuff("player", 71227)
			local wk = AutoHelp.UnitHasBuff("player", 60229)
			if GetStatus("STATUS_冰封之韧") then
				local jp = (jy("VALUE_冰封之韧") or 35) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "冰封之韧") then
					return true
				end
			end;
			if GetStatus("STATUS_反魔法护罩") and si >= 20 then
				local jp = (jy("VALUE_反魔法护罩") or 50) / 100;
				if mT <= jp and AutoHelp.TryUseAction(mH, "反魔法护罩") then
					return true
				end
			end;
			if not UnitExists("pet") and (AutoHelp.Glyphs[60200] or AutoHelp.GetItemCount(37201) > 0) then
				if GetStatus("STATUS_邪恶_亡者复生") and AutoHelp.TryUseAction(mH, "亡者复生") then
					return true
				end
			end;
			if GetStatus("STATUS_邪恶_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角") then
				return true
			end;
			if GetStatus("STATUS_邪恶_召唤石像鬼") and wh and wj and rn and (mN or not mN and mM) and AutoHelp.TryUseAction(mH, "召唤石像鬼") then
				return true
			end;
			if GetStatus("STATUS_邪恶_亡者大军") and wd > 0 and rn and (mN or not mN and mM) and AutoHelp.TryUseAction(mH, "亡者大军") then
				return true
			end;
			if vX > 0 and wd <= 10 and rn then
				if GetStatus("STATUS_邪恶_符文武器增效") and AutoHelp.TryUseAction(mH, "符文武器增效") then
					return true
				end
			end;
			if GetStatus("STATUS_邪恶_反魔法护罩") and rn and (mT <= 0.9 or mM) and AutoHelp.TryUseAction(mH, "反魔法护罩") then
				return true
			end;
			if (wj or wk) and si >= w9 and (not mN or wd > 6) or si >= 90 then
				if GetStatus("STATUS_邪恶_凋零缠绕") and AutoHelp.TryUseAction(targetInfo, "凋零缠绕") then
					return true
				end
			end;
			if dX == 0 then
				if GetStatus("STATUS_邪恶_天灾打击") and AutoHelp.TryUseAction(targetInfo, "天灾打击") then
					SetCombatValue("started", true)
					SetCombatValue("group", 2)
					return true
				end;
				if GetStatus("STATUS_邪恶_冰冷触摸") and AutoHelp.TryUseAction(targetInfo, "冰冷触摸") then
					SetCombatValue("started", true)
					SetCombatValue("group", 1)
					return true
				end
			end;
			local wl = vq()
			if dX == 1 then
				if not wh and (GetTalentSpent(GetSpellInfo(50391)) == 0 and wd <= 5 and mN or GetTalentSpent(GetSpellInfo(50391)) == 2) then
					if AutoHelp.TryUseAction(mH, ahenv.UnholyPresence) then
						SetCombatValue("group", 2)
						return true
					end
				end;
				if wf <= 10 and w3 > 7 then
					if GetStatus("STATUS_邪恶_白骨之盾") and AutoHelp.TryUseAction(mH, "白骨之盾") then
						SetCombatValue("group", 2)
						return true
					end
				end;
				if we <= 5 and w3 > 0 then
					if GetStatus("STATUS_邪恶_食尸鬼狂乱") and AutoHelp.TryUseAction(mH, "食尸鬼狂乱") then
						SetCombatValue("group", 2)
						return true
					end
				end;
				if GetStatus("STATUS_邪恶_暗影打击") and AutoHelp.TryUseAction(targetInfo, "暗影打击") then
					SetCombatValue("group", 2)
					return true
				end
			end;
			if dX == 2 then
				if not wg and GetTalentSpent(GetSpellInfo(50391)) == 0 and wd > 5 and wd < 150 then
					if AutoHelp.TryUseAction(mH, ahenv.BloodPresence) then
						SetCombatValue("group", 3)
						return true
					end
				end;
				if AutoHelp.IsForceAOE(2) and w3 > 0 and w4 > 0 then
					if GetStatus("STATUS_邪恶_传染") and AutoHelp.TryUseAction(targetInfo, "传染") then
						SetCombatValue("group", 3)
						return true
					end
				end;
				if wb >= 10 then
					if GetStatus("STATUS_邪恶_血液沸腾") and AutoHelp.TryUseAction(mH, "血液沸腾") then
						SetCombatValue("group", 3)
						return true
					end
				end;
				if GetStatus("STATUS_邪恶_鲜血打击") and AutoHelp.TryUseAction(targetInfo, "鲜血打击") then
					SetCombatValue("group", 3)
					return true
				end
			end;
			if dX == 3 then
				if GetStatus("STATUS_邪恶_枯萎凋零") and AutoHelp.HasActionKey("枯萎凋零") and iG <= 5 and wc <= 3 then
					if AutoHelp.TryUseAction(mH, "枯萎凋零") then
						SetCombatValue("group", 0)
						return true
					end;
					return false
				end;
				SetCombatValue("group", 0)
			end;
			if vY then
				SetCombatValue("group", 0)
			end;
			if GetStatus("STATUS_邪恶_寒冬号角") and AutoHelp.TryUseAction(mH, "寒冬号角2") then
				return true
			end
		end;
		if jy("HEALMODE") == "冰霜" then
			if vZ() then
				return true
			end
		end;
		if jy("HEALMODE") == "邪恶" then
			if w7() then
				return true
			end
		end;
		if jy("HEALMODE") == "鲜血" then
			if wm() then
				return true
			end
		end;
		if jy("HEALMODE") == "红脸邪恶" then
			if DoRedFaceAttack() then
				return true
			end
		end;
		if jy("HEALMODE") == "绿脸邪恶" then
			if wm() then
				return true
			end
		end;
		if not IsPlayerAttacking("target") and iG <= 2 and rU < GetTime() - 2 and AutoHelp.TryUseAction(targetInfo, "KEY_STARTATTACK") then
			rU = GetTime()
			return true
		end
	end
end;
if PlayerIsClass("DEATHKNIGHT") then
	AutoHelp.ClassConfig = vo
end;
local function ws()
	local b5 = select(2, UnitClass("player"))
	local jd = AUTOHELP_L;
	if not AutoHelp then
		AutoHelp = {}
	end;
	if not AutoHelp.Config then
		AutoHelp.Config = {}
	end;
	AutoHelp.version = 201;
	local jq = AutoHelp.config;
	local jB = AutoHelp.RegisterKeyCallback;
	local SetConfig = AutoHelp.SetConfig;
	local jy = AutoHelp.GetConfig;
	local jJ = AutoHelp.HealButtons;
	local jK = AutoHelp.SettingItems;
	local aS = UnitGUID("player")
	local aT = UnitName("player")
	local wt = false;
	local wu = false;
	local wv = false;
	local ww = false;
	local wx = false;
	local rT = nil;
	local HEAL_DEBUG = true;
	local wy = 10;
	local kJ = 5;
	local kK = 5;
	local kL = 1;
	AutoHelp.MyLastThreatState = 0;
	AutoHelp.DRINKING_MP = 0.5;
	AutoHelp.EATING_HP = 0.5;
	AutoHelp.IsInBattlefield = false;
	local wz = AutoHelp.TryUseAction;
	AutoHelp.VersionNo = 321;
	AutoHelp.Version = "V3.0.321"
	local wA = {
		"PLAYER_ENTERING_WORLD",
		"UNIT_MAXHEALTH",
		"UNIT_HEALTH_FREQUENT",
		"UNIT_HEALTH",
		"UNIT_AURA",
		"UNIT_TARGET",
		"GROUP_ROSTER_UPDATE",
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
		"UPDATE_ACTIVE_BATTLEFIELD",
		"PLAYER_LOGOUT",
		"UNIT_MANA",
		"UNIT_MAXPOWER",
		"UNIT_POWER_UPDATE",
		"UNIT_SPELLCAST_SENT",
		"UNIT_SPELLCAST_STOP",
		"UNIT_SPELLCAST_START",
		"UNIT_SPELLCAST_SUCCEEDED",
		"UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_DELAYED",
		"UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_STOP",
		"UNIT_SPELLCAST_CHANNEL_UPDATE",
		"COMBAT_LOG_EVENT_UNFILTERED",
		"PLAYER_TARGET_CHANGED",
		"UNIT_CONNECTION",
		"INCOMING_RESURRECT_CHANGED",
		"PLAYER_REGEN_ENABLED",
		"PLAYER_REGEN_DISABLED",
		"PLAYER_EQUIPMENT_CHANGED",
		"CHARACTER_POINTS_CHANGED",
		"AUTOFOLLOW_BEGIN",
		"AUTOFOLLOW_END",
		"UI_ERROR_MESSAGE",
		"RESURRECT_REQUEST",
		"START_AUTOREPEAT_SPELL",
		"STOP_AUTOREPEAT_SPELL",
		"UI_SCALE_CHANGED",
		"PLAYER_DEAD",
		"UPDATE_BATTLEFIELD_STATUS",
		"UNIT_COMBAT",
		"UNIT_ENTERED_VEHICLE",
		"UNIT_EXITED_VEHICLE"
	}
	local HEAL_TIMERS = HEAL_TIMERS;
	local wB = 0;
	local wC = 0;
	local wD = 0;
	local wE = 0;
	local wF = 0;
	local wG = 0;
	local wH = 0;
	local wI = 0;
	local wJ = 0;
	local wK = 0;
	local wL = 0;
	local wM = 0;
	local wN = 0;
	local wO = 0;
	HEAL_IS_RELOADING = false;
	local wP = false;
	local wQ = nil;
	local wR = nil;
	local wS = 100;
	local wT = 0;
	local wU = 100;
	local wV = 100;
	AutoHelp.RaidHealthPct = 100;
	local wW = nil;
	local wX = nil;
	local wY = UnitName("player")
	local wZ;
	function AutoHelp.AddNextAction(tInfo, w_, x0, mC)
		local x1 = {}
		x1.tInfo = tInfo;
		x1.key = w_;
		x1.delay = x0 or 0;
		x1.dontinterrupt = mC or true;
		AutoHelp.AddAction(x1)
	end;
	local function x2()
		if wZ then
			return true
		end;
		if AutoHelp.HasAction() then
			wZ = AutoHelp.GetNextAction()
			wZ.NextTime = GetTime() + wZ.delay;
			return true
		end
	end;
	local function x3()
		if x2() then
			if wZ.NextTime > GetTime() then
				HEAL_TIMERS["HEAL_TARGET"] = 0.001;
				return true
			end;
			if AutoHelp.TryUseAction(wZ.tInfo, wZ.key) then
				AutoHelp.DONT_INTERRUPT = wZ.dontinterrupt;
				wZ = nil;
				return true
			else
				wZ = nil;
				HEAL_TIMERS["HEAL_TARGET"] = 0.001;
				return true
			end
		end
	end;
	local function x4()
		AutoHelp.ClearAction()
	end;
	local function x5()
		HEAL_TIMERS["RELOAD_RAID"] = 2.3
	end;
	local function x6()
		HEAL_TIMERS["RELOAD_RAID"] = 0.3
	end;
	local function x7()
		if not HEAL_isReloadPending() then
			HEAL_TIMERS["RELOAD_RAID"] = 5
		end
	end;
	local function HEAL_isReloadPending()
		return HEAL_TIMERS["RELOAD_RAID"] > 0 or HEAL_TIMERS["RELOAD_UI"] > 0 or HEAL_IS_RELOADING
	end;
	local x8;
	local function x9(xa)
		x8 = xa
	end;
	local function xb(xc, xd)
		if not HEAL_TIMERS[xc] or HEAL_TIMERS[xc] <= 0 then
			HEAL_TIMERS[xc] = xd;
			return true
		end;
		if HEAL_TIMERS[xc] and HEAL_TIMERS[xc] > 0 then
			HEAL_TIMERS[xc] = HEAL_TIMERS[xc] - x8;
			if HEAL_TIMERS[xc] <= 0 then
				HEAL_TIMERS[xc] = xd;
				return true
			end
		end;
		return false
	end;
	local function xe(xc)
		if HEAL_TIMERS[xc] and HEAL_TIMERS[xc] > 0 then
			HEAL_TIMERS[xc] = HEAL_TIMERS[xc] - x8;
			return HEAL_TIMERS[xc] <= 0
		end;
		return false
	end;
	local function xf()
		local xg = {}
		for oz, p9 in pairs(HEAL_SPELL_BLACKLIST) do
			if HEAL_SPELL_BLACKLIST[oz] > 0 then
				HEAL_SPELL_BLACKLIST[oz] = HEAL_SPELL_BLACKLIST[oz] - x8
			end;
			if HEAL_SPELL_BLACKLIST[oz] > 0 then
				xg[oz] = HEAL_SPELL_BLACKLIST[oz]
			end
		end;
		HEAL_SPELL_BLACKLIST = xg
	end;
	local function xh(tInfo)
		if not tInfo then
			return
		end;
		local xi = false;
		local xj = false;
		local xk = false;
		local xl = false;
		local xm = false;
		for ow = 1, 256 do
			local cx, lT, nE, nF, cn, nG, nH, nI, nJ, ca, nK, nL = UnitDebuff(tInfo["unit"], ow)
			if not lT then
				break
			end;
			if nF == "Magic" then
				xi = true
			end;
			if nF == "Disease" then
				xj = true
			end;
			if nF == "Poison" then
				xk = true
			end;
			if nF == "Curse" then
				xl = true
			end;
			if cx == "逃亡" then
				xm = true
			end
		end;
		tInfo["hasDebuff"] = xi or xj or xk or xl;
		if xi ~= tInfo["hasMagic"] then
			tInfo["hasMagic"] = xi
		end;
		if xj ~= tInfo["hasDisease"] then
			tInfo["hasDisease"] = xj
		end;
		if xk ~= tInfo["hasPoison"] then
			tInfo["hasPoison"] = xk
		end;
		if xl ~= tInfo["hasCurse"] then
			tInfo["hasCurse"] = xl
		end;
		if xm ~= tInfo["hasTaowang"] then
			tInfo["hasTaowang"] = xm
		end
	end;
	local xn;
	local function xo(os, xp)
		local tInfo = HEAL_RAID[os]
		local xq = UnitIsDeadOrGhost(os) and not UnitIsFeignDeath(os)
		local tFeignDeath = UnitIsFeignDeath(os)
		local xr = UnitIsAFK(os)
		local xs = UnitIsConnected(os)
		if 1 == xp then
			local xt, xu, xv = UnitClass(os)
			local xw = UnitPowerType(os)
			if not HEAL_RAID[os] then
				HEAL_RAID[os] = {}
			end;
			tInfo = HEAL_RAID[os]
			local lw, lx = UnitName(os)
			tInfo["healthmax"] = UnitHealthMax(os)
			tInfo["health"] = UnitHealth(os)
			tInfo["loghealth"] = UnitHealth(os)
			tInfo["name"] = lw;
			tInfo["unit"] = os;
			tInfo["level"] = UnitLevel(os)
			tInfo["factoin"] = UnitFactionGroup(os)
			tInfo["class"] = xu;
			tInfo["classId"] = xv;
			tInfo["powertype"] = tonumber(xw)
			tInfo["power"] = UnitPower(os)
			tInfo["previousPower"] = tInfo["power"]
			tInfo["powermax"] = UnitPowerMax(os)
			tInfo["dead"] = xq;
			tInfo["FeignDeath"] = tFeignDeath;
			if GetPartyAssignment("MAINTANK", os) or UnitGroupRolesAssigned(os) == "TANK" then
				tInfo["role"] = "MAINTANK"
			elseif UnitGroupRolesAssigned(os) == "HEALER" then
				tInfo["role"] = "HEALER"
			elseif UnitGroupRolesAssigned(os) == "DAMAGER" then
				tInfo["role"] = "DAMAGER"
			else
				tInfo["role"] = "NONE"
			end;
			tInfo["charmed"] = UnitIsCharmed(os) and UnitCanAttack("player", os)
			tInfo["className"] = xt or ""
			tInfo["fullName"] = (lx or "") ~= "" and lw .. "-" .. lx or lw;
			tInfo["raidIcon"] = GetRaidTargetIndex(os)
			tInfo["visible"] = UnitIsVisible(os)
			tInfo["baseRange"] = UnitInRange(os) or "player" == os;
			tInfo["hasDebuff"] = false;
			tInfo["hp"] = tInfo["health"] / tInfo["healthmax"]
			tInfo["mp"] = tInfo["power"] / tInfo["powermax"]
			tInfo["lost"] = tInfo["healthmax"] - tInfo["health"]
			tInfo["afk"] = xr;
			tInfo["connected"] = xs;
			tInfo["groupNo"] = AutoHelp.GetUnitGroup(os)
			tInfo["isVehicle"] = UnitHasVehicleUI(os)
			if os == "player" or tInfo["groupNo"] == HEAL_RAID["player"]["groupNo"] then
				HEAL_RAID_GROUPS[os] = tInfo
			end;
			if not HEAL_RAID_NAMES[lw] then
				HEAL_RAID_NAMES[lw] = os
			end;
			tInfo["Auras"] = {}
			xh(tInfo)
			HEAL_RAID_GUIDS[UnitGUID(os)] = os
		elseif tInfo then
			if 2 == xp or 6 == xp then
				if 6 == xp then
					xn = tInfo["loghealth"]
				end;
				if 2 == xp then
					if tInfo["updateTime"] == GetTime() then
						return
					elseif UnitIsFeignDeath(os) and UnitHealth(os) == 0 then
						return
					else
						xn = UnitHealth(os)
					end
				end;
				tInfo["health"] = xn;
				if tInfo["dead"] ~= xq then
					if not xq then
						tInfo["healthmax"] = UnitHealthMax(os)
					end
				end
			elseif 3 == xp then
				tInfo["healthmax"] = UnitHealthMax(os)
				tInfo["loghealth"] = UnitHealth(os)
			elseif 4 == xp then
				tInfo["previousPower"] = tInfo["power"]
				tInfo["power"] = UnitPower(os)
			elseif 5 == xp then
				tInfo["powermax"] = UnitPowerMax(os)
			elseif 20 == xp then
				tInfo["isVehicle"] = UnitHasVehicleUI(os)
			end;
			tInfo["dead"] = xq;
			tInfo["FeignDeath"] = tFeignDeath;
			tInfo["afk"] = xr;
			tInfo["connected"] = xs;
			if not xq and tInfo["health"] > 0 then
				tInfo["hp"] = tInfo["health"] / tInfo["healthmax"]
			else
				tInfo["hp"] = 0
			end;
			tInfo["lost"] = tInfo["healthmax"] - tInfo["health"]
			if not xq and tInfo["power"] > 0 then
				tInfo["mp"] = tInfo["power"] / tInfo["powermax"]
			else
				tInfo["mp"] = 0
			end
		end;
		if xp == 4 or xp == 5 then
			wU = floor(GetRaidPowerPercent() * 100)
			if wU > 100 then
				wU = 100
			end
		end;
		if xp == 1 or xp == 2 or xp == 3 or xp == 4 or xp == 5 or xp == 6 then
			local oP, oQ, oY, oZ = GetPartyHealStatus()
			if not AutoHelp.PartyStatus then
				AutoHelp.PartyStatus = {}
			end;
			AutoHelp.PartyStatus.currentHealth = oP;
			AutoHelp.PartyStatus.totalHealth = oQ;
			AutoHelp.PartyStatus.totalNum = oY;
			AutoHelp.PartyStatus.totalAlive = oZ;
			AutoHelp.PartyStatus.hp = oP / oQ;
			AutoHelp.PartyStatus.losthp = oQ - oP;
			local oP, oQ, oR, oS, oT, oU, oV = GetRaidHealthStatus()
			wS = floor(oP / oQ * 100)
			if wS > 100 then
				wS = 100
			end;
			AutoHelp.RaidHealthPct = wS;
			AutoHelp.RaidTeamsPct = oV;
			wT = oQ - oP;
			if wT < 0 then
				wT = 0
			end;
			if oS == 0 then
				wU = 100
			else
				wU = floor(oR / oS * 100)
			end;
			if oU == 0 then
				wV = 100
			else
				wV = floor(oT / oU * 100)
			end;
			if jJ["RaidHealthText"] then
				local a5 = ""
				if wS >= 50 then
					a5 = a5 .. "团队血量：\124cff00ff00" .. wS .. "%\124r"
				else
					a5 = a5 .. "团队血量：\124cfff00000" .. wS .. "%\124r"
				end;
				a5 = a5 .. "  掉血总量：" .. floor(wT / 1000, 2) .. " K"
				if wU >= 40 then
					a5 = a5 .. "\r\n团队蓝量：\124cff00ff00" .. wU .. "%\124r"
				else
					a5 = a5 .. "\r\n团队蓝量：\124cfff00000" .. wU .. "%\124r"
				end;
				if wV >= 40 then
					a5 = a5 .. "  治疗蓝量：\124cff00ff00" .. wV .. "%\124r"
				else
					a5 = a5 .. "  治疗蓝量：\124cfff00000" .. wV .. "%\124r"
				end;
				jJ["RaidHealthText"]:SetText(a5)
			end
		end;
		return tInfo
	end;
	local function xx(os, xp)
		xo(os, xp)
	end;
	local function xy(os, xz)
		local xA = {
			["dead"] = true
		}
		local tInfo = HEAL_RAID[os] or xA;
		if abs(xz) > 10000 then
			xx(os, 2)
			return
		end;
		if not tInfo["dead"] then
			if tInfo["health"] ~= 0 then
				xn = tInfo["health"] + xz
			else
				xn = tInfo["loghealth"] + xz
			end;
			if xn < 0 then
				xn = 0
			elseif xn > tInfo["healthmax"] then
				xn = tInfo["healthmax"]
			end;
			tInfo["loghealth"] = xn;
			tInfo["updateTime"] = GetTime()
			if tInfo["health"] ~= xn then
				xx(os, 6)
			end
		end
	end;
	local function xB()
		if UnitExists("target") then
			for li, _ in pairs(HEAL_BOSS_UNITS) do
				if UnitExists(li) and UnitGUID("target") == UnitGUID(li) then
					return true
				end
			end
		end;
		return false
	end;
	AutoHelp.TargetInfo = nil;
	AutoHelp.LastTargetInfo = nil;
	function AutoHelp.UpdateTargetInfo(xp)
		if not UnitExists("target") then
			AutoHelp.TargetTime = nil;
			if AutoHelp.TargetInfo and not AutoHelp.TargetInfo["dead"] then
				AutoHelp.LastTargetInfo = AutoHelp.TargetInfo
			end;
			AutoHelp.TargetInfo = nil;
			return
		end;
		local tInfo = AutoHelp.TargetInfo;
		local os = "target"
		if 1 == xp then
			local tInfo = {}
			local lw, lx = UnitName(os)
			tInfo["unit"] = os;
			tInfo["healthmax"] = UnitHealthMax(os)
			tInfo["health"] = UnitHealth(os)
			tInfo["name"] = lw;
			tInfo["unit"] = os;
			tInfo["level"] = UnitLevel(os)
			tInfo["factoin"] = UnitFactionGroup(os)
			tInfo["className"], tInfo["class"], tInfo["classId"] = UnitClass(os)
			tInfo["powertype"] = UnitPowerType(os)
			tInfo["power"] = UnitPower(os)
			tInfo["previousPower"] = tInfo["power"]
			tInfo["powermax"] = UnitPowerMax(os)
			tInfo["dead"] = UnitIsDeadOrGhost(os) and not UnitIsFeignDeath(os)
			tInfo["FeignDeath"] = tFeignDeath;
			tInfo["charmed"] = UnitIsCharmed(os) and UnitCanAttack("player", os)
			tInfo["fullName"] = (lx or "") ~= "" and lw .. "-" .. lx or lw;
			tInfo["raidIcon"] = GetRaidTargetIndex(os)
			tInfo["visible"] = UnitIsVisible(os)
			tInfo["baseRange"] = UnitInRange(os) or "player" == os;
			tInfo["hasDebuff"] = false;
			tInfo["hp"] = tInfo["health"] / tInfo["healthmax"]
			tInfo["mp"] = tInfo["power"] / tInfo["powermax"]
			tInfo["lost"] = tInfo["healthmax"] - tInfo["health"]
			tInfo["afk"] = UnitIsAFK(os)
			tInfo["connected"] = UnitIsConnected(os)
			tInfo["guid"] = UnitGUID(os)
			tInfo["isFriend"] = UnitCanAssist("player", "target")
			tInfo["canAttack"] = UnitCanAttack("player", "target") and not tInfo["dead"]
			tInfo["targetKey"] = 2;
			tInfo["isBoss"] = AutoHelp.IsBossTarget()
			AutoHelp.TargetInfo = tInfo;
			AutoHelp.TargetTime = GetTime()
			AutoHelp.castinfo.nextSwing = false
		elseif tInfo then
			tInfo["dead"] = UnitIsDeadOrGhost(os) and not UnitIsFeignDeath(os)
			tInfo["FeignDeath"] = UnitIsFeignDeath(os)
			tInfo["afk"] = UnitIsAFK(os)
			tInfo["connected"] = UnitIsConnected(os)
			tInfo["health"] = UnitHealth(os)
			tInfo["healthmax"] = UnitHealthMax(os)
			tInfo["power"] = UnitPower(os)
			tInfo["powermax"] = UnitPowerMax(os)
			tInfo["isFriend"] = UnitCanAssist("player", "target")
			tInfo["canAttack"] = UnitCanAttack("player", "target") and not tInfo["dead"]
			if not tInfo["dead"] and tInfo["health"] > 0 then
				tInfo["hp"] = tInfo["health"] / tInfo["healthmax"]
			else
				tInfo["hp"] = 0
			end;
			tInfo["lost"] = tInfo["healthmax"] - tInfo["health"]
			if not tInfo["dead"] and tInfo["power"] > 0 then
				tInfo["mp"] = tInfo["power"] / tInfo["powermax"]
			else
				tInfo["mp"] = 0
			end
		end
	end;
	function HEAL_updatePlayerTarget()
		if HEAL_RAID["target"] then
			xx("target", 9)
		end;
		if UnitExists("target") then
			xo("target", 1)
		else
			table.wipe(VUHDO_RAID["target"] or {})
			HEAL_RAID["target"] = nil
		end
	end;
	local function xC(xD, xE, xF, xG, xH)
		local oz;
		local xI;
		oz = HEAL_RAID_GUIDS[xE]
		if not oz then
			return
		end;
		local xJ, xK, xL;
		local function xM(xD, xF, xG, xH)
			xJ, xK, xL = strsplit("_", xD)
			if "SPELL" == xJ then
				if ("HEAL" == xK or "HEAL" == xL) and "MISSED" ~= xL then
					return xH
				elseif "DAMAGE" == xK or "DAMAGE" == xL then
					return - xH
				elseif "ENERGIZE" == xK then
					return - 10001
				end
			elseif "DAMAGE" == xK then
				if "SWING" == xJ then
					return - xF
				elseif "RANGE" == xJ then
					return - xH
				elseif "ENVIRONMENTAL" == xJ then
					return - xG
				end
			elseif "DAMAGE" == xJ and "MISSED" ~= xL and "RESISTED" ~= xL then
				return - xH
			end;
			return 0
		end;
		xI = tonumber(xM(xD, xF, xG, xH)) or 0;
		if xI ~= 0 then
			xy(oz, xI)
		end
	end;
	local function xN(tInfo)
		if tInfo == nil then
			return
		end;
		local xO = tInfo["role"]
		local xP = tInfo["class"]
		wC = wC + 1;
		if xO == "MAINTANK" then
			HEAL_RAID_TANKS[tInfo["unit"]] = tInfo;
			wB = wB + 1
		end;
		if xP == "WARRIOR" then
			wF = wF + 1;
			if xO ~= "MAINTANK" then
				wE = wE + 1
			end
		end;
		if xP == "PALADIN" then
			wG = wG + 1;
			if xO ~= "MAINTANK" then
				wD = wD + 1
			end;
			HEAL_RAID_HEALER[tInfo["unit"]] = tInfo;
			HEAL_RAID_HEALER_GUIDS[UnitGUID(tInfo["unit"])] = tInfo
		end;
		if xP == "HUNTER" then
			wH = wH + 1;
			wE = wE + 1
		end;
		if xP == "ROGUE" then
			wI = wI + 1;
			wE = wE + 1
		end;
		if xP == "PRIEST" then
			wJ = wJ + 1;
			wD = wD + 1;
			HEAL_RAID_HEALER[tInfo["unit"]] = tInfo;
			HEAL_RAID_HEALER_GUIDS[UnitGUID(tInfo["unit"])] = tInfo
		end;
		if xP == "MAGE" then
			wK = wK + 1;
			wE = wE + 1
		end;
		if xP == "WARLOCK" then
			wL = wL + 1;
			wE = wE + 1
		end;
		if xP == "DRUID" then
			wM = wM + 1;
			if xO ~= "MAINTANK" then
				wD = wD + 1
			end;
			HEAL_RAID_HEALER[tInfo["unit"]] = tInfo;
			HEAL_RAID_HEALER_GUIDS[UnitGUID(tInfo["unit"])] = tInfo
		end;
		if xP == "SHAMAN" then
			wN = wN + 1;
			if xO ~= "MAINTANK" then
				wD = wD + 1
			end;
			HEAL_RAID_HEALER[tInfo["unit"]] = tInfo;
			HEAL_RAID_HEALER_GUIDS[UnitGUID(tInfo["unit"])] = tInfo
		end;
		if xP == "DEATHKNIGHT" then
			wO = wO + 1;
			if xO ~= "MAINTANK" then
				wE = wE + 1
			end
		end
	end;
	local function xQ()
		local xR;
		local tInfo;
		local xS;
		local oz, xT;
		local xU = HEAL_RAID;
		local md = HEAL_RAID_NAMES;
		HEAL_RAID = {}
		HEAL_RAID_HEALER = {}
		HEAL_RAID_NAMES = {}
		HEAL_RAID_GUIDS = {}
		HEAL_RAID_TANKS = {}
		HEAL_RAID_GROUPS = {}
		wB = 0;
		wC = 0;
		wD = 0;
		wE = 0;
		wF = 0;
		wG = 0;
		wH = 0;
		wI = 0;
		wJ = 0;
		wK = 0;
		wL = 0;
		wM = 0;
		wN = 0;
		wO = 0;
		AutoHelp.PLAYER_RAID_ID = getPlayerRaidUnit()
		if GetNumGroupMembers() == 0 and not UnitExists("party1") then
			xo("player", 1)
			tInfo = HEAL_RAID["player"]
			tInfo["role"] = "NONE"
			tInfo["raidIndex"] = 0;
			xN(tInfo)
		else
			xo("player", 1)
			HEAL_RAID["player"]["raidIndex"] = 0;
			oz, xT = getUnitIds()
			xS = GetNumGroupMembers()
			for ow = 1, xS do
				xR = oz .. ow;
				if UnitExists(xR) then
					local tInfo;
					if xR ~= AutoHelp.PLAYER_RAID_ID then
						tInfo = xo(xR, 1)
						tInfo["raidIndex"] = ow
					else
						tInfo = HEAL_RAID["player"]
					end;
					xN(tInfo)
				end
			end
		end;
		AutoHelp.GroupsNum = 0;
		for oz, tInfo in pairs(HEAL_RAID_GROUPS) do
			AutoHelp.GroupsNum = AutoHelp.GroupsNum + 1
		end;
		for oz, tInfo in pairs(xU) do
			local im = GetRaidUnit(tInfo["name"])
			if im ~= nil then
				im["BLACKLIST"] = tInfo["BLACKLIST"]
				if AutoHelp.playerClass == "PALADIN" or AutoHelp.playerClass == "DRUID" or AutoHelp.playerClass == "PRIEST" or AutoHelp.playerClass == "SHAMAN" then
					im["PROTECTLIST"] = tInfo["PROTECTLIST"]
				end;
				if AutoHelp.playerClass == "PALADIN" then
					im["DAOBIAOLIST"] = tInfo["DAOBIAOLIST"]
					im["HUDUNLIST"] = tInfo["HUDUNLIST"]
				end;
				if AutoHelp.playerClass == "DRUID" then
					im["ZHANFANGLIST"] = tInfo["ZHANFANGLIST"]
				end;
				if AutoHelp.playerClass == "HUNTER" then
					im["HASWUDAO"] = tInfo["HASWUDAO"]
				end;
				im["BUFFTYPE"] = tInfo["BUFFTYPE"]
				im["FIRSTLIST"] = tInfo["FIRSTLIST"]
				im["Auras"] = tInfo["Auras"]
			end
		end;
		table.wipe(xU)
		table.wipe(md)
		for oz, tInfo in pairs(HEAL_RAID) do
			tInfo["targetKey"] = tInfo["raidIndex"] + 3;
			xx(oz, 10)
		end;
		if AutoHelp.playerClass == "PALADIN" then
			local xV = jy("HEAL_STATUS_DAOBIAOUNIT")
			local xW = jy("HEAL_STATUS_HUDUNUNIT")
			local xX = false;
			local xY = false;
			for oz, tInfo in pairs(HEAL_RAID) do
				if xV == tInfo["name"] or (xV == nil or xV == "无") and tInfo["role"] == "MAINTANK" then
					tInfo["DAOBIAOLIST"] = true;
					xX = true;
					if xV == nil or xV == "无" then
						xV = tInfo["name"]
						AutoHelp.Debug("进入副本队伍，自动设置TANK为道标目标:" .. tInfo["name"])
						SetConfig("HEAL_STATUS_DAOBIAOUNIT", xV)
					end
				end;
				if xW == tInfo["name"] then
					tInfo["HUDUNLIST"] = true;
					xY = true
				end
			end;
			if not xX then
				SetConfig("HEAL_STATUS_DAOBIAOUNIT", "无")
			end;
			if not xY then
				SetConfig("HEAL_STATUS_HUDUNUNIT", "无")
			end
		end;
		if GetStatus("HEAL_STATUS_协助坦克") and not IsInRaid() then
			local cd, eu, rx, ry, rz, rA, rB, gs, rC, rD = GetInstanceInfo()
			local b8 = jy("AssistUnit")
			local xZ = false;
			for oz, tInfo in pairs(HEAL_RAID) do
				if b8 == tInfo["name"] or (b8 == nil or b8 == "无") and tInfo["role"] == "MAINTANK" and "party" == eu then
					xZ = true;
					if b8 == nil or b8 == "无" then
						b8 = tInfo["name"]
					end
				end
			end;
			if not xZ then
				SetConfig("AssistUnit", "无")
			else
				if jy("AssistUnit") ~= b8 and "party" == eu then
					SetConfig("AssistUnit", b8)
				end;
				if AutoHelp.playerClass == "HUNTER" and jy("误导对象") ~= b8 then
					AutoHelp.Debug("进入副本队伍，自动设置坦克为误导对象:" .. b8)
					SetConfig("误导对象", b8)
				end;
				if AutoHelp.playerClass == "ROGUE" and jy("嫁祸诀窍") ~= b8 then
					AutoHelp.Debug("进入副本队伍，自动设置坦克为嫁祸对象:" .. b8)
					SetConfig("嫁祸诀窍", b8)
				end
			end
		end;
		if jJ["RaidMembersText"] then
			local x_ = ""
			x_ = x_ .. "A:\124cff00ff00" .. tostring(wC)
			x_ = x_ .. "\124r T:\124cffC79C6E" .. tostring(wB)
			x_ = x_ .. "\124r H:\124cff00ff00" .. tostring(wD)
			x_ = x_ .. "\124r D:\124cfff00000" .. tostring(wE)
			x_ = x_ .. "\124r【\124cffC79C6E" .. tostring(wF)
			x_ = x_ .. "\124r,\124cffF58CBA" .. tostring(wG)
			x_ = x_ .. "\124r,\124cffF58CBA" .. tostring(wN)
			x_ = x_ .. "\124r,\124cffABD473" .. tostring(wH)
			x_ = x_ .. "\124r,\124cffFFF569" .. tostring(wI)
			x_ = x_ .. "\124r,\124cffFFFFFF" .. tostring(wJ)
			x_ = x_ .. "\124r,\124cff69CCF0" .. tostring(wK)
			x_ = x_ .. "\124r,\124cff9482C9" .. tostring(wL)
			x_ = x_ .. "\124r,\124cffFF7D0A" .. tostring(wM)
			x_ = x_ .. "\124r,\124cfff00000" .. tostring(wO)
			x_ = x_ .. "\124r】"
			jJ["RaidMembersText"]:SetText(x_)
		end;
		if jy("AutoFollowUnit") then
			local tInfo = GetRaidUnit(jy("AutoFollowUnit"))
			if tInfo then
				SetConfig("AutoFollowUnit", tInfo["name"])
			else
				SetConfig("AutoFollowUnit", nil)
			end
		end;
		if jy("AssistUnit") then
			local tInfo = GetRaidUnit(jy("AssistUnit"))
			if tInfo then
				SetConfig("AssistUnit", tInfo["name"])
			else
				SetConfig("AssistUnit", nil)
			end
		end
	end;
	function HEAL_reloadUI()
		if InCombatLockdown() then
			return
		end;
		HEAL_IS_RELOADING = true;
		xQ()
		HEAL_IS_RELOADING = false
	end;
	local function y0()
		if InCombatLockdown() then
			HEAL_IS_RELOADING = true;
			xQ()
			HEAL_IS_RELOADING = false;
			wu = true
		else
			HEAL_reloadUI()
		end
	end;
	local y1 = false;
	function AutoHelp.ChangeTargetHeal(hK)
		AutoHelp.ChangeHealTarget = hK;
		if not InCombatLockdown() then
			wW:SetAttribute("ChangeHealTarget", AutoHelp.ChangeHealTarget)
		end;
		if not y1 then
			y1 = true
		else
			x6()
		end
	end;
	AutoHelp.HealStat = {
		totalHeal = 0,
		overHeal = 0,
		spellNum = 0,
		critNum = 0,
		hotNum = 0,
		hotTotalHeal = 0,
		hotOverHeal = 0,
		combatTotalHeal = 0,
		combatOverHeal = 0,
		combatSpellNum = 0,
		combatCritNum = 0,
		combatHotNum = 0,
		combatHotTotalHeal = 0,
		combatHotOverHeal = 0,
		interruptNum = 0
	}
	local function y2(fm, y3, bx, y4, y5, bO, y6, y7, ca, cx, y8, amount, y9, ya, yb)
		local yc = "Hit"
		local yd;
		if y3 == "SPELL_PERIODIC_HEAL" then
			yc = "Tick"
			yd = true
		end;
		if ya == 1 and not yb then
			yb = ya;
			ya = nil
		end;
		if yb then
			yc = "Crit"
		end;
		AutoHelp.HealStat.totalHeal = AutoHelp.HealStat.totalHeal + amount;
		AutoHelp.HealStat.overHeal = AutoHelp.HealStat.overHeal + y9;
		if yd then
			AutoHelp.HealStat.hotNum = AutoHelp.HealStat.hotNum + 1
		else
			AutoHelp.HealStat.spellNum = AutoHelp.HealStat.spellNum + 1
		end;
		if yb then
			AutoHelp.HealStat.critNum = AutoHelp.HealStat.critNum + 1
		end;
		if InCombatLockdown() then
			AutoHelp.HealStat.combatTotalHeal = AutoHelp.HealStat.combatTotalHeal + amount;
			AutoHelp.HealStat.combatOverHeal = AutoHelp.HealStat.combatOverHeal + y9;
			if yd then
				AutoHelp.HealStat.combatHotNum = AutoHelp.HealStat.combatHotNum + 1
			else
				AutoHelp.HealStat.combatSpellNum = AutoHelp.HealStat.combatSpellNum + 1
			end;
			if yb then
				AutoHelp.HealStat.combatCritNum = AutoHelp.HealStat.combatCritNum + 1
			end
		end;
		AutoHelp.RefreshHealStat()
	end;
	local ye = {
		GetSpellInfo(78),
		GetSpellInfo(30213),
		GetSpellInfo(2973),
		GetSpellInfo(6807),
		GetSpellInfo(56815)
	}
	local function yf(eS)
		for gP, hK in pairs(ye) do
			if hK == eS then
				return true
			end
		end;
		return false
	end;
	local function yg(yh)
	end;
	local function yi()
		local yh = AutoHelp.castinfo;
		if not (yh.casting or yh.channeling) then
			return
		end;
		if yh.endTime and yh.endTime - GetTime() < 0.3 then
			return
		end;
		local tInfo = yh.targetInfo;
		if not tInfo then
			return
		end;
		if yh.spellName == AutoHelp.RESCURIT_NAME and not tInfo["dead"] then
			AutoHelp.Info("目标已经复活,打断复活，" .. tInfo["name"])
			AutoHelp.StopAction()
			return
		end;
		local mS, mT = getHealthLost(tInfo)
		if (tInfo["dead"] or mT > GetStatusNumber("HEAL_OVERHEAL_VALUE") / 100) and yh.spellName ~= AutoHelp.RESCURIT_NAME then
			local cx;
			if AutoHelp.LastAction then
				cx = AutoHelp.LastAction["spellName"]
			else
				cx = yh.spellName
			end;
			if tInfo["dead"] then
				AutoHelp.Info("\124cffFFF569=>目标已经死亡,打断 " .. cx .. "，" .. AutoHelp.GetColorName(tInfo) .. "\124r")
			else
				AutoHelp.Info("\124cffFFF569=>目标已经满血,打断 " .. cx .. "，" .. AutoHelp.GetColorName(tInfo) .. "," .. tostring(ceil(mT * 100)) .. "%\124r")
			end;
			AutoHelp.HealStat.interruptNum = AutoHelp.HealStat.interruptNum + 1;
			AutoHelp.StopAction()
			return
		end;
		HEAL_TIMERS["AUTO_INTERRUPT"] = 0.05
	end;
	local yj;
	local yk;
	local function yl(dW, ym, yn, ca)
		yj = ym;
		yk = yn;
		if yf(GetSpellInfo(ca)) then
			AutoHelp.castinfo.nextSwing = true
		end;
		HEAL_TIMERS["HEAL_TARGET"] = 0.05
	end;
	local yo = false;
	local function yp(aj, yq, yn, ca)
		if yn == yk then
			AutoHelp.castinfo.spellTarget = yj
		else
			AutoHelp.castinfo.spellTarget = nil
		end;
		AutoHelp.castinfo.lastStartTime = GetTime()
		AutoHelp.castinfo.sendTime = GetTime()
		AutoHelp.castinfo.castId = yn;
		AutoHelp.castinfo.spellId = ca;
		local yr, bv, bg;
		if yq then
			yr, _, _, bv, bg = ChannelInfo()
		else
			yr, _, _, bv, bg = CastingInfo()
		end;
		if not bv or not bg then
			return
		end;
		if yo then
			if AutoHelp.castinfo.lastEndTime and AutoHelp.castinfo.lastSendTime then
				print(GetTime() - AutoHelp.castinfo.lastEndTime, math.floor((GetTime() - AutoHelp.castinfo.lastSendTime) * 1000), AutoHelp.castinfo.lastCastTime)
			end;
			AutoHelp.castinfo.lastCastTime = bg - bv
		end;
		AutoHelp.castinfo.lastSendTime = GetTime()
		if yq then
			AutoHelp.castinfo.channeling = true;
			AutoHelp.castinfo.casting = nil
		else
			AutoHelp.castinfo.channeling = nil;
			AutoHelp.castinfo.casting = true
		end;
		AutoHelp.castinfo.startTime = bv / 1000;
		AutoHelp.castinfo.endTime = bg / 1000;
		AutoHelp.castinfo.timeDiff = GetTime() - AutoHelp.castinfo.sendTime;
		local ys = bg - bv;
		AutoHelp.castinfo.timeDiff = AutoHelp.castinfo.timeDiff > ys and ys or AutoHelp.castinfo.timeDiff;
		AutoHelp.castinfo.spellName = yr or ""
		AutoHelp.castinfo.spellLength = ys / 1000;
		if AutoHelp.castinfo.spellTarget then
			AutoHelp.castinfo.targetInfo = GetRaidUnit(AutoHelp.castinfo.spellTarget)
		else
			AutoHelp.castinfo.targetInfo = nil
		end;
		if ys then
			if AutoHelp.UseSpellQueueWindow and not x2() and InCombatLockdown() then
				HEAL_TIMERS["HEAL_TARGET"] = ys / 1000 - AutoHelp.SpellQueueWindow
			else
				HEAL_TIMERS["HEAL_TARGET"] = ys / 1000
			end
		end
	end;
	local function yt()
		if AutoHelp.castinfo.casting then
			local js, ok = select(4, CastingInfo())
			if js ~= nil and ok ~= nil then
				AutoHelp.castinfo.startTime, AutoHelp.castinfo.endTime = js / 1000, ok / 1000
			end
		end;
		if AutoHelp.castinfo.channeling then
			local js, ok = select(4, ChannelInfo())
			if js ~= nil and ok ~= nil then
				AutoHelp.castinfo.startTime, AutoHelp.castinfo.endTime = js / 1000, ok / 1000
			end
		end
	end;
	local function yu(aj, yn, ca)
		local cx = GetSpellInfo(ca)
		if yf(cx) then
			AutoHelp.castinfo.nextSwing = false
		end;
		if yn ~= AutoHelp.castinfo.castId then
			return
		end;
		if AutoHelp.castinfo.channeling and aj ~= "UNIT_SPELLCAST_CHANNEL_STOP" then
			return
		end;
		AutoHelp.castinfo.lastEndTime = GetTime()
		if AutoHelp.castinfo.sendTime == nil then
			return
		end;
		AutoHelp.castinfo.channeling = nil;
		AutoHelp.castinfo.casting = nil;
		AutoHelp.castinfo.caseId = nil;
		AutoHelp.castinfo.sendTime = nil;
		AutoHelp.castinfo.startTime = nil;
		AutoHelp.castinfo.endTime = nil;
		AutoHelp.castinfo.timeDiff = nil;
		AutoHelp.castinfo.spellName = nil;
		AutoHelp.castinfo.spellLength = nil;
		AutoHelp.castinfo.spellId = nil;
		AutoHelp.castinfo.spellTarget = nil;
		AutoHelp.castinfo.targetInfo = nil;
		if AutoHelp.LastAction then
			AutoHelp.LastAction = nil;
			AutoHelp.LastTarget = nil;
			AutoHelp.LastTime = nil
		end;
		AutoHelp.BotAction = nil;
		if HEAL_TIMERS["HEAL_TARGET"] > 0 then
			HEAL_TIMERS["HEAL_TARGET"] = 0.05
		end
	end;
	local function yv(cx)
		if (AutoHelp.castinfo.channeling or AutoHelp.castinfo.casting) and cx == AutoHelp.castinfo.spellName then
			return true
		end;
		return false
	end;
	AutoHelp.IsCastingSpell = yv;
	AutoHelp.BossIds = {}
	AutoHelp.RegisteredEvents = {}
	function AutoHelp.RegisterEvents(yw, aj, ca)
		AutoHelp.BossIds[yw] = true;
		if not AutoHelp.RegisteredEvents[aj] then
			AutoHelp.RegisteredEvents[aj] = {}
		end;
		if type(ca) == "string" then
			AutoHelp.RegisteredEvents[aj][ca] = ca
		else
			local cd = GetSpellInfo(ca)
			if cd then
				AutoHelp.RegisteredEvents[aj][cd] = ca
			else
				AutoHelp.RegisteredEvents[aj][ca] = ca
			end
		end
	end;
	local function yx(fm, aj, fo, fp, fq, fr, fs, ft, fu, fv, fw, yy, yz, yA, yB, yC, yD)
		if not AutoHelp.RegisteredEvents[aj] or not AutoHelp.RegisteredEvents[aj][yz] then
			return
		end;
		if AutoHelp.HandlerBossEvent then
			local qV = {}
			local yE = aj:sub(0, 6)
			qV.timestamp = fm;
			qV.event = aj;
			qV.sourceGUID = fp;
			qV.sourceName = fq;
			qV.sourceFlags = fr;
			qV.sourceRaidFlags = fs;
			qV.destGUID = ft;
			qV.destName = fu;
			qV.destFlags = fv;
			qV.destRaidFlags = fw;
			qV.startTime = GetTime()
			if yE == "SPELL_" then
				qV.spellId, qV.spellName = yy, yz;
				qV.auraId, qV.auraName = qV.spellId, qV.spellName;
				if qV.spellId == 0 then
					qV.spellId = AutoHelp.RegisteredEvents[aj][yz]
					qV.auraId = qV.spellId
				end;
				if aj == "SPELL_AURA_APPLIED" or aj == "SPELL_AURA_REFRESH" or aj == "SPELL_AURA_REMOVED" then
					qV.amount = yC;
					qV.auraType = yB;
					if not qV.sourceName then
						qV.sourceName = qV.destName;
						qV.sourceGUID = qV.destGUID;
						qV.sourceFlags = qV.destFlags
					end
				elseif aj == "SPELL_AURA_APPLIED_DOSE" or aj == "SPELL_AURA_REMOVED_DOSE" then
					qV.amount = yC;
					qV.auraType = yB;
					if not qV.sourceName then
						qV.sourceName = qV.destName;
						qV.sourceGUID = qV.destGUID;
						qV.sourceFlags = qV.destFlags
					end
				elseif aj == "SPELL_INTERRUPT" or aj == "SPELL_DISPEL" or aj == "SPELL_DISPEL_FAILED" or aj == "SPELL_AURA_STOLEN" then
					qV.extraSpellId, qV.extraSpellName = yB, yC
				end
			elseif aj == "UNIT_DIED" or aj == "UNIT_DESTROYED" then
				qV.sourceName = qV.destName;
				qV.sourceGUID = qV.destGUID;
				qV.sourceFlags = qV.destFlags
			elseif aj == "ENVIRONMENTAL_DAMAGE" then
				qV.environmentalType, qV.amount, qV.overkill, qV.school, qV.resisted, qV.blocked = yy, yz, yA, yB, yC, yD
			end;
			AutoHelp.HandlerBossEvent(qV)
		end
	end;
	local function yF(_, yG, yH, yI, yJ, yK, yL, yM, yN, yO, yP, yQ, yR, yS, yT, yU, yV, yW, yX)
		local tInfo;
		if "COMBAT_LOG_EVENT_UNFILTERED" == yG then
			local fm, aj, fo, fp, fq, fr, yY, ft, fu, fv, yZ, tk, nZ, yU, yV, yW, yX, y_, z0, z1, z2, z3, z4, z5 = CombatLogGetCurrentEventInfo()
			yx(fm, aj, fo, fp, fq, fr, yY, ft, fu, fv, yZ, tk, nZ, yU, yV, yW, yX, y_)
			if tk == 0 then
				local _, _, _, _, _, _, z6 = GetSpellInfo(nZ)
				if z6 then
					tk = z6
				end
			end;
			local oz = HEAL_RAID_GUIDS[ft]
			local z7 = HEAL_RAID_GUIDS[fp]
			xC(aj, ft, tk, nZ, yV)
			if AutoHelp.SpellDamageAction and CombatLog_Object_IsA(fr, COMBATLOG_FILTER_ME) and (aj == "SPELL_PERIODIC_DAMAGE" or aj == "SPELL_PERIODIC_MISSED" or aj == "SPELL_DAMAGE" or aj == "SPELL_MISSED" or aj == "SWING_DAMAGE" or aj == "SWING_MISSED") then
				AutoHelp.SpellDamageAction(fm, aj, fu, tk, nZ, yV)
			end;
			if aj == "SWING_MISSED" then
				if CombatLog_Object_IsA(fr, COMBATLOG_FILTER_ME) then
					AutoHelp.HEAL_OnAttack()
				elseif CombatLog_Object_IsA(fv, COMBATLOG_FILTER_ME) and tk == "PARRY" then
					AutoHelp.HEAL_OnAttack(true)
				end
			elseif aj == "SWING_DAMAGE" then
				if CombatLog_Object_IsA(fr, COMBATLOG_FILTER_ME) then
					AutoHelp.HEAL_OnAttack()
				end
			elseif aj == "SPELL_DAMAGE" then
				if CombatLog_Object_IsA(fr, COMBATLOG_FILTER_ME) then
					if yf(nZ) then
						AutoHelp.HEAL_OnAttack()
					end
				end;
				if CombatLog_Object_IsA(fr, COMBATLOG_FILTER_ME) then
					AutoHelp.HEAL_OnAttack()
				end
			elseif aj == "SPELL_MISSED" then
				if CombatLog_Object_IsA(fr, COMBATLOG_FILTER_ME) and yf(nZ) then
					AutoHelp.HEAL_OnAttack()
				end
			elseif aj == "SPELL_INTERRUPT" then
				if AutoHelp.SpellInterrupt then
					AutoHelp.SpellInterrupt(fq, tk, nZ, fu, yV, yW)
				end
			elseif aj == "SPELL_CAST_SUCCESS" then
				if AutoHelp.SpellCastSuccess then
					AutoHelp.SpellCastSuccess(fq, tk, nZ, fu, yV, yW)
				end;
				if z7 == "player" and GetStatus("STATUS_DEBUG") then
					local z8 = nZ;
					local im = AutoHelp.GetSpellBookItem(tk)
					if im and im.spellName then
						z8 = im.castName
					end;
					if fu then
						AutoHelp.Info2("=>\124cffFFF569" .. fu .. "\124r[" .. z8 .. "]")
					else
						AutoHelp.Info2("=>\124cffFFF569" .. fq .. "\124r[" .. z8 .. "]")
					end
				end
			elseif aj == "SPELL__CAST_START" then
				if AutoHelp.SpellCastStart then
					AutoHelp.SpellCastStart(fq, tk, nZ, fu, yV, yW)
				end
			end;
			if oz then
				local tInfo = HEAL_RAID[oz]
				if tInfo then
					if tInfo and (aj == "SPELL_AURA_APPLIED" or aj == "SPELL_AURA_REFRESH" or aj == "SPELL_AURA_APPLIED_DOSE" or aj == "SPELL_AURA_REMOVED_DOSE") then
						tInfo["Auras"][nZ] = {}
						tInfo["Auras"][nZ]["auraId"] = tk;
						tInfo["Auras"][nZ]["auraType"] = yV;
						tInfo["Auras"][nZ]["auraTime"] = GetTime()
						tInfo["Auras"][tk] = true
					end;
					if tInfo and aj == "SPELL_AURA_REMOVED" then
						if tInfo["Auras"][nZ] then
							table.wipe(tInfo["Auras"][nZ])
							tInfo["Auras"][nZ] = nil;
							tInfo["Auras"][tk] = nil
						end
					end;
					if tInfo and aj == "SPELL_AURA_APPLIED" and AutoHelp.SPELL_AURA_APPLIED then
						AutoHelp.SPELL_AURA_APPLIED(tInfo, tk, nZ)
					end;
					if tInfo and aj == "SPELL_AURA_REMOVED" and AutoHelp.SPELL_AURA_REMOVED then
						AutoHelp.SPELL_AURA_REMOVED(tInfo, tk, nZ)
					end
				end
			end;
			if AutoHelp.TargetInfo and AutoHelp.TargetInfo["guid"] == fp then
				if aj == "SPELL_CAST_START" then
					AutoHelp.TargetInfo["casting"] = true;
					AutoHelp.TargetInfo["cast_spellId"] = tk;
					AutoHelp.TargetInfo["cast_spellName"] = nZ;
					AutoHelp.TargetInfo["cast_starttime"] = GetTime()
				end;
				if aj == "SPELL_CAST_FAILED" or aj == "SPELL_CAST_SUCCESS" or aj == "SPELL_INTERRUPT" or aj == "UNIT_DIED" or aj == "UNIT_DIED" then
					if AutoHelp.TargetInfo["casting"] then
						AutoHelp.TargetInfo["casting"] = false;
						AutoHelp.TargetInfo["cast_spellId"] = nil;
						AutoHelp.TargetInfo["cast_spellName"] = nil;
						AutoHelp.TargetInfo["cast_starttime"] = nil
					end
				end
			end
		elseif "UNIT_AURA" == yG then
			tInfo = GetRaidUnit(yH)
			if tInfo then
				xh(tInfo)
			end
		elseif "UNIT_HEALTH" == yG or "UNIT_HEALTH_FREQUENT" == yG then
			if yH and HEAL_RAID[yH] then
				xx(yH, 2)
			end
		elseif "UNIT_POWER_UPDATE" == yG or "UNIT_POWER_FREQUENT" == yG or "UNIT_MANA" == yG then
			tInfo = GetRaidUnit(yH)
			if tInfo then
				xx(yH, 4)
			end
		elseif "UNIT_MAXHEALTH" == yG then
			tInfo = GetRaidUnit(yH)
			if tInfo then
				xx(yH, 3)
			end
		elseif "UNIT_TARGET" == yG then
			tInfo = GetRaidUnit(yH)
			if tInfo then
			end
		elseif "UNIT_COMBAT" == yG then
		elseif "UNIT_SPELLCAST_START" == yG then
			if "player" == yH then
				yp(yG, false, yI, yJ)
			end
		elseif "UNIT_SPELLCAST_SENT" == yG then
			if "player" == yH then
				yl(yH, yI, yJ, yK)
			end
		elseif "UNIT_SPELLCAST_CHANNEL_START" == yG then
			if "player" == yH then
				yp(yG, true, yI, yJ)
			end
		elseif "UNIT_SPELLCAST_CHANNEL_STOP" == yG then
			if "player" == yH then
				yu(yG, yI, yJ)
			end
		elseif "UNIT_SPELLCAST_SUCCEEDED" == yG then
			if "player" == yH then
				yu(yG, yI, yJ)
			end;
			if AutoHelp.OnSpellSucceeded then
				AutoHelp.OnSpellSucceeded(yH, yI, yJ)
			end
		elseif "UNIT_SPELLCAST_STOP" == yG then
			if "player" == yH then
				yu(yG, yI, yJ)
			end
		elseif "UNIT_SPELLCAST_INTERRUPTED" == yG then
			if "player" == yH then
				yu(yG, yI, yJ)
			end
		elseif "UNIT_SPELLCAST_CHANNEL_UPDATE" == yG then
			if "player" == yH then
				yt()
			end
		elseif "UNIT_SPELLCAST_DELAYED" == yG then
			if "player" == yH then
				yt()
			end
		elseif "UNIT_SPELLCAST_FAILED" == yG then
			if "player" == yH then
				yu(yG, yI, yJ)
			end
		elseif "CHAT_MSG_ADDON" == yG then
		elseif "UNIT_MAXPOWER" == yG then
			if HEAL_RAID[yH] then
				xx(yH, 5)
			end
		elseif "PLAYER_TARGET_CHANGED" == yG then
			if wv then
				AutoHelp.UpdateTargetInfo(1)
			end
		elseif "CHARACTER_POINTS_CHANGED" == yG then
			x6()
		elseif "GROUP_ROSTER_UPDATE" == yG or "INSTANCE_ENCOUNTER_ENGAGE_UNIT" == yG or "UPDATE_ACTIVE_BATTLEFIELD" == yG then
			if wv then
				x6()
			end
		elseif "PARTY_MEMBER_ENABLE" == yG or "PARTY_MEMBER_DISABLE" == yG then
			HEAL_TIMERS["CUSTOMIZE"] = 0.2
		elseif "PLAYER_ENTERING_WORLD" == yG then
			HEAL_init()
		elseif "PLAYER_EQUIPMENT_CHANGED" == yG then
			HEAL_TIMERS["EQUIP_CHANGED"] = 2
		elseif "UNIT_CONNECTION" == yG then
			if HEAL_RAID[yH] then
				xx(yH, 19)
			end
		elseif "ROLE_CHANGED_INFORM" == yG then
		elseif "PLAYER_LOGOUT" == yG then
		elseif "INCOMING_RESURRECT_CHANGED" == yG then
			if HEAL_RAID[yH] ~= nil then
				HEAL_AddSpellBlackList(yH, 5)
			end
		elseif "AUTOFOLLOW_BEGIN" == yG then
			wP = true;
			wR = yH
		elseif "AUTOFOLLOW_END" == yG then
			wP = false;
			wR = nil
		elseif "RESURRECT_REQUEST" == yG then
		elseif "START_AUTOREPEAT_SPELL" == yG then
		elseif "STOP_AUTOREPEAT_SPELL" == yG then
		elseif "UI_SCALE_CHANGED" == yG then
			AutoHelp.UISCALECHANGED()
		elseif "PLAYER_REGEN_ENABLED" == yG then
			if AutoHelp.Player_Regen_Enabled then
				AutoHelp.Player_Regen_Enabled()
			end;
			AutoHelp.MyLastThreatState = 0;
			ClearCombatValues()
		elseif "PLAYER_REGEN_DISABLED" == yG then
			if AutoHelp.Player_Regen_Disabled then
				AutoHelp.Player_Regen_Disabled()
			end
		elseif "PLAYER_DEAD" == yG then
			if GetStatus("STATUS_自动战场") and UnitIsDead("player") and not UnitIsGhost("player") then
				local _, eu = IsInInstance()
				if eu == "pvp" then
					RepopMe()
				end
			end
		elseif "UPDATE_BATTLEFIELD_STATUS" == yG then
			if GetBattlefieldWinner() and GetStatus("STATUS_自动战场") then
				HEAL_TIMERS["HEAL_TARGET"] = 0.1;
				LeaveBattlefield()
			end
		elseif "UNIT_ENTERED_VEHICLE" == yG then
			if yH and HEAL_RAID[yH] then
				xx(yH, 20)
			end
		elseif "UNIT_EXITED_VEHICLE" == yG then
			if yH and HEAL_RAID[yH] then
				xx(yH, 20)
			end
		elseif "UI_ERROR_MESSAGE" == yG then
			if AutoHelp.ErrorMessageHandle then
				AutoHelp.ErrorMessageHandle(yI)
			end;
			if yI == ERR_NOEMOTEWHILERUNNING then
				AutoHelp.MovingStatus = true;
				UIErrorsFrame:Clear()
			end;
			if yI == SPELL_FAILED_LINE_OF_SIGHT then
				if yj then
					local tInfo = GetRaidUnit(yj)
					if tInfo then
						if InCombatLockdown() then
							HEAL_AddSpellBlackList(tInfo["unit"], 1)
						else
							HEAL_AddSpellBlackList(tInfo["unit"], 3)
						end;
						if HEAL_TIMERS["HEAL_TARGET"] > 0.1 then
							HEAL_TIMERS["HEAL_TARGET"] = 0.001
						end
					end
				end
			elseif yI == SPELL_FAILED_NOT_STANDING then
				DoEmote("stand")
			elseif yI == SPELL_FAILED_MOVING then
			elseif yI == SPELL_FAILED_NOT_MOUNTED or yH == ERR_ATTACK_MOUNTED then
				if GetStatus("STATUS_自动下马") then
					Dismount()
				end
			elseif yI == "你必须面对目标。" or yI == "你面朝错误的方向！" or yI == SPELL_FAILED_UNIT_NOT_INFRONT then
				HEAL_ATTACK_ERRORFACING = true;
				HEAL_ATTACK_ERRORFACING_TIME = GetTime()
			elseif yI == "你必须位于目标背后。" or yI == "你必须位于目标背后" then
				HEAL_ATTACK_NOTBACK_TIME = GetTime()
			elseif yI == "法力值不足" or yI == ERR_OUT_OF_MANA then
				HEAL_ATTACK_OUTOFMANA_TIME = GetTime()
			elseif yI == ERR_PET_SPELL_DEAD then
				HEAL_PET_ISDEAD = true
			elseif yI == SPELL_FAILED_OUT_OF_RANGE then
				HEAL_ATTACK_OUTOFRANGE = true
			elseif yI == "物品栏已满。" then
				HEAL_ATTACK_FULLBAG = true
			else
			end
		else
			print("Error: Unexpected event: " .. yG)
		end
	end;
	function AutoHelp.GetMovingStatus()
		AutoHelp.MovingStatus = false;
		DoEmote("stand")
		return AutoHelp.MovingStatus
	end;
	function ShouldFollowLeader()
		if wP or not wQ or HEAL_ISASSISTING then
			return
		end;
		local cd, a5, z9, bv, bg, za, zb, zc, aH = CastingInfo()
		if cd ~= nil then
			return
		end;
		local d_ = CheckInteractDistance(wQ, 4)
		if d_ then
			local tInfo = GetRaidUnit(wQ)
			if tInfo then
				AutoHelp.FOLLOW_UNIT = tInfo["unit"]
				AutoHelp.TryUseAction(HEAL_RAID["player"], "KEY_STARTFOLLOW")
			end
		end
	end;
	local function zd()
		return GetStatus("HEAL_STATUS_DISMAGIC") or GetStatus("HEAL_STATUS_DISSICK") or GetStatus("HEAL_STATUS_DISPOSION") or GetStatus("HEAL_STATUS_DISCURSE")
	end;
	AutoHelp.DontDispelMagics = {
		GetSpellInfo(61572),
		GetSpellInfo(116),
		GetSpellInfo(29923),
		GetSpellInfo(12484),
		GetSpellInfo(28169),
		GetSpellInfo(30108),
		GetSpellInfo(15487)
	}
	AutoHelp.MustDispelMagics = {
		GetSpellInfo(118)
	}
	local ze = {}
	local zf = {}
	local zg = {}
	local zh = {}
	local zi = {}
	local zj = {
		GetSpellInfo(28542)
	}
	local function zk(tInfo)
		if not tInfo["hasDebuff"] then
			return
		end;
		local rk = AutoHelp.UnitHasDebuffs(tInfo["unit"], AutoHelp.DontDispelMagics)
		if tInfo["hasMagic"] and GetStatus("HEAL_STATUS_DISMAGIC") and AutoHelp.DispelMagicKey and not rk and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelMagicKey) then
			return AutoHelp.DispelMagicKey
		end;
		rk = AutoHelp.UnitHasDebuffs(tInfo["unit"], ze)
		if tInfo["hasDisease"] and GetStatus("HEAL_STATUS_DISSICK") and AutoHelp.DispelDiseaseKey and not rk and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelDiseaseKey) then
			return AutoHelp.DispelDiseaseKey
		end;
		rk = AutoHelp.UnitHasDebuffs(tInfo["unit"], zg)
		if tInfo["hasPoison"] and GetStatus("HEAL_STATUS_DISPOSION") and AutoHelp.DispelPoisonKey and not rk and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelPoisonKey) then
			return AutoHelp.DispelPoisonKey
		end;
		rk = AutoHelp.UnitHasDebuffs(tInfo["unit"], zi)
		if tInfo["hasCurse"] and GetStatus("HEAL_STATUS_DISCURSE") and AutoHelp.DispelCurseKey and not rk and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelCurseKey) then
			return AutoHelp.DispelCurseKey
		end
	end;
	local function zl(tInfo)
		if not tInfo["hasDebuff"] then
			return
		end;
		local zm = AutoHelp.UnitHasDebuffs(tInfo["unit"], AutoHelp.MustDispelMagics)
		if tInfo["hasMagic"] and AutoHelp.DispelMagicKey and zm and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelMagicKey) then
			return AutoHelp.DispelMagicKey
		end;
		zm = AutoHelp.UnitHasDebuffs(tInfo["unit"], zf)
		if tInfo["hasDisease"] and AutoHelp.DispelDiseaseKey and zm and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelDiseaseKey) then
			return AutoHelp.DispelDiseaseKey
		end;
		zm = AutoHelp.UnitHasDebuffs(tInfo["unit"], zh)
		if tInfo["hasPoison"] and AutoHelp.DispelPoisonKey and zm and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelPoisonKey) then
			return AutoHelp.DispelPoisonKey
		end;
		zm = AutoHelp.UnitHasDebuffs(tInfo["unit"], zj)
		if tInfo["hasCurse"] and AutoHelp.DispelCurseKey and zm and AutoHelp.CanUseAction(tInfo, AutoHelp.DispelCurseKey) then
			return AutoHelp.DispelCurseKey
		end
	end;
	local function zn()
		for oz, tInfo in pairs(HEAL_RAID) do
			if tInfo["hasDebuff"] and AutoHelp.IsValidEmergency(tInfo) and not tInfo["dead"] then
				local p = zl(tInfo)
				if p then
					return p, tInfo
				end
			end
		end
	end;
	local function zo(mH)
		if not GetStatus("HEAL_STATUS_ONLYHEALTARGET") then
			return false
		end;
		local tInfo = GetTargetOrEnmysTarget()
		if tInfo and AutoHelp.CanActionUnit(tInfo) then
			local mS, mT = getHealthLost(tInfo)
			if GetStatus("HEAL_STATUS_ONLYHEALTARGET_A") or mT <= GetStatusNumber("HEAL_AUTO_VALUE") / 100 then
				return AutoHelp.HealTeam(tInfo)
			end
		end;
		return false
	end;
	local function zp(mH)
		if not GetStatus("DRINKING_STATUS") then
			return false
		end;
		local oW, oX = UnitPowerType("player")
		if oX ~= "MANA" then
			return false
		end;
		if AutoHelp.IsDrinking() and mH["mp"] <= 0.9 then
			HEAL_TIMERS["HEAL_TARGET"] = 2;
			return true
		end;
		local jp = (GetStatusNumber("DRINKING_VALUE") or 30) / 100;
		if mH["mp"] <= jp and not AutoHelp.IsDrinking() and AutoHelp.TryUseAction(mH, "KEY_DRINKING") then
			AutoHelp.Info("蓝量低于" .. jp * 100 .. "%，开始喝水.")
			return true
		end;
		return false
	end;
	local function zq(mH)
		if not GetStatus("EATING_STATUS") then
			return false
		end;
		if AutoHelp.IsEating() and mH["hp"] < AutoHelp.EATING_HP then
			HEAL_TIMERS["HEAL_TARGET"] = 2;
			return true
		end;
		local jp = (GetStatusNumber("EATING_VALUE") or 50) / 100;
		if mH["hp"] <= jp and not AutoHelp.IsEating() and AutoHelp.TryUseAction(mH, "KEY_EATING") then
			AutoHelp.Info("生命值低于" .. jp * 100 .. "%，开始吃面包.")
			return true
		end;
		return false
	end;
	local function zr(mH)
		local oW, oX = UnitPowerType("player")
		if oX ~= "MANA" then
			return false
		end;
		if not GetStatus("EATING_STATUS") or not GetStatus("DRINKING_STATUS") then
			return false
		end;
		if AutoHelp.IsEating() and mH["hp"] <= 0.9 and AutoHelp.IsDrinking() and mH["mp"] <= 0.9 then
			HEAL_TIMERS["HEAL_TARGET"] = 2;
			return true
		end;
		local zs = (GetStatusNumber("EATING_VALUE") or 50) / 100;
		local zt = (GetStatusNumber("DRINKING_VALUE") or 30) / 100;
		if mH["mp"] < zt and mH["hp"] < zs then
			if (not AutoHelp.IsEating() or not AutoHelp.IsDrinking()) and AutoHelp.TryUseAction(mH, "吃喝") then
				AutoHelp.Info("生命值/蓝量低于设定值[" .. zs * 100 .. "%/" .. zt * 100 .. "%]，开始吃面包+喝水.")
				return true
			end
		end;
		return false
	end;
	local zu;
	local zv;
	local zw;
	local zx;
	local function zy()
		zu = nil;
		zv = nil;
		zw = nil;
		zx = nil
	end;
	function AutoHelp.SetStopAction(cn, lB)
		if not cn or cn == 0 then
			zy()
			return
		end;
		zw = GetTime() + cn;
		zu = cn;
		zv = lB or ""
	end;
	local function zz()
		if not zw then
			return false
		end;
		if GetTime() < zw then
			if not zx then
				zx = true;
				AutoHelp.Debug("开始：" .. (zv or "stopaction"))
			end;
			return true
		else
			AutoHelp.Debug("结束：" .. (zv or "stopaction"))
			zy()
			return false
		end
	end;
	function AutoHelp.IsStoping()
		if not zw or GetTime() >= zw then
			return false
		end;
		return true
	end;
	local zA;
	local zB;
	local zC;
	local zD;
	local zE;
	AutoHelp.STOP_HEAL = false;
	local function zF()
		zA = nil;
		zB = nil;
		zC = nil;
		zD = nil;
		AutoHelp.STOP_HEAL = false
	end;
	function AutoHelp.SetStopHealAction(cn, lB)
		if not cn or cn == 0 then
			zF()
			return
		end;
		zC = GetTime() + cn;
		zA = cn;
		zB = lB or ""
		AutoHelp.STOP_HEAL = true
	end;
	local function zG()
		if not zC then
			return false
		end;
		if GetTime() < zC then
			if not zD then
				zD = true;
				AutoHelp.Debug("开始：" .. (zB or "StopHealAction"))
			end;
			AutoHelp.STOP_HEAL = true;
			return true
		else
			AutoHelp.Debug("结束：" .. (zB or "StopHealAction"))
			zF()
			AutoHelp.STOP_HEAL = false;
			return false
		end
	end;
	AutoHelp.IsHealer = AutoHelp.IsHealer or true;
	function AutoHelp.IsValidEmergency(tInfo)
		return not HEAL_IsBlackList(tInfo["unit"]) and tInfo["connected"] and not tInfo["dead"] and not (UnitIsCharmed(tInfo["unit"]) or UnitCanAttack("player", tInfo["unit"])) and not tInfo["isVehicle"] and (UnitInRange(tInfo["unit"]) or tInfo["unit"] == "player") and UnitIsVisible(tInfo["unit"])
	end;
	local rK = {}
	local zH = {}
	local zI = {}
	local zJ = {}
	local zK = {}
	local zL = {}
	local function zM(mH)
		local mT, r7 = mH["hp"], mH["mp"] * 100;
		local r8 = mH["groupNo"]
		local r9 = AutoHelp.IsDrinking() and r7 < 0.90 or AutoHelp.IsEating() and mT < 0.9;
		table.wipe(rK)
		table.wipe(zH)
		table.wipe(zI)
		table.wipe(zJ)
		table.wipe(zK)
		table.wipe(zL)
		table.wipe(HEAL_RAID_ATTACKED_UNITS)
		local zN = 0;
		local zO = nil;
		local zP = nil;
		local zQ = nil;
		local zR = nil;
		local zS = nil;
		local zT = nil;
		local targetInfo = GetTargetOrEnmysTarget()
		for oz, tInfo in pairs(HEAL_RAID) do
			if AutoHelp.IsValidEmergency(tInfo) then
				local zU = UnitAffectingCombat("player") or UnitAffectingCombat(tInfo["unit"])
				if zU then
					local x = tInfo["unit"] .. "target"
					if UnitExists(x) and UnitCanAttack("player", x) and not UnitIsDeadOrGhost(x) and UnitExists(x .. "target") and UnitCanAssist("player", x .. "target") then
						local h4 = GetRaidUnit(UnitName(x .. "target"))
						if h4 then
							HEAL_RAID_ATTACKED_UNITS[oz] = UnitGUID(x)
						end
					end
				end;
				if AutoHelp.CAN_HEAL and (not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or zU) then
					local mT, mS;
					mT, mS = AutoHelp.GetUnitComingHP(tInfo, AutoHelp.CommingHealWindow)
					tInfo["ahp"], tInfo["alost"] = mT, mS;
					zH[# zH + 1] = oz;
					if GetStatus("HEAL_STATUS_FIRSTTARGET") and targetInfo and targetInfo["unit"] == oz and mT <= GetStatusNumber("HEAL_FIRSTPROTECT_VALUE") / 100 or tInfo["PROTECTLIST"] and mT < GetStatusNumber("HEAL_FIRSTPROTECT_VALUE") / 100 then
						zJ[# zJ + 1] = oz
					end;
					if GetStatus("HEAL_STATUS_AUTOHEAL") then
						if mT <= GetStatusNumber("HEAL_AUTO_VALUE") / 100 then
							rK[# rK + 1] = oz;
							local zV = zK[tInfo["groupNo"]]
							if not zV then
								zK[tInfo["groupNo"]] = {}
								zV = zK[tInfo["groupNo"]]
							end;
							zV[# zV + 1] = oz;
							if r8 == tInfo["groupNo"] then
								zL[# zL + 1] = oz
							end
						end
					end;
					if GetStatus("HEAL_STATUS_FIRSTTANK") then
						if tInfo["role"] == "MAINTANK" and mT <= GetStatusNumber("HEAL_FIRSTTANK_VALUE") / 100 then
							zI[# zI + 1] = oz
						end
					end
				end;
				if AutoHelp.CAN_BUFF and not r9 and not InCombatLockdown() then
					if AutoHelp.playerClass == "PALADIN" then
						if not zO then
							tInfo["aBuffKey"] = AutoHelp.CanClassBuff(tInfo)
							if tInfo["aBuffKey"] then
								zO = tInfo
							end
						end;
						if not zO and not zP then
							tInfo["aBuffKey"] = AutoHelp.CanUnitBuff(tInfo)
							if tInfo["aBuffKey"] then
								zP = tInfo
							end
						end
					end
				end
			end;
			if AutoHelp.CAN_RESCURIT and tInfo["dead"] then
				if GetStatus("HEAL_STATUS_RESCURIT") and not InCombatLockdown() and not r9 and not AutoHelp.IsMoving and not zR and not UnitHasIncomingResurrection(tInfo["unit"]) and AutoHelp.CanUseAction(tInfo, AutoHelp.RESCURIT_KEY) then
					if not zR and (tInfo["class"] == "PALADIN" or tInfo["class"] == "PRIEST" or tInfo["class"] == "SHAMAN" or tInfo["PROTECTLIST"]) then
						zR = tInfo
					end;
					if not zR and not zS and (tInfo["class"] == "DRUID" or tInfo["role"] == "MAINTANK") then
						zS = tInfo
					end;
					if not zR and not zS and not zT then
						zT = tInfo
					end
				end
			end
		end;
		if AutoHelp.CAN_RESCURIT then
			if not InCombatLockdown() then
				if zR and AutoHelp.TryUseAction(zR, AutoHelp.RESCURIT_KEY) then
					AutoHelp.DebugText = "救赎优先治疗"
					return true
				end;
				if zS and AutoHelp.TryUseAction(zS, AutoHelp.RESCURIT_KEY) then
					AutoHelp.DebugText = "救赎优先坦克小德"
					return true
				end;
				if zT and AutoHelp.TryUseAction(zT, AutoHelp.RESCURIT_KEY) then
					AutoHelp.DebugText = "救赎启动"
					return true
				end
			end
		end;
		if GetStatus("STATUS_治疗模式") then
			local zW = {}
			if # zJ > 0 then
				table.sort(zJ, function(rL, rM)
					return HEAL_RAID[rL]["alost"] > HEAL_RAID[rM]["alost"]
				end)
				zW[# zW + 1] = HEAL_RAID[zJ[1]]
			end;
			if # zI > 0 then
				table.sort(zI, function(rL, rM)
					return HEAL_RAID[rL]["alost"] > HEAL_RAID[rM]["alost"]
				end)
				zW[# zW + 1] = HEAL_RAID[zI[1]]
				if # zI > 1 then
					zW[# zW + 1] = HEAL_RAID[zI[2]]
				end
			end;
			if # rK > 0 then
				table.sort(rK, function(rL, rM)
					return HEAL_RAID[rL]["alost"] > HEAL_RAID[rM]["alost"]
				end)
				zW[# zW + 1] = HEAL_RAID[rK[1]]
				if # rK > 1 then
					zW[# zW + 1] = HEAL_RAID[rK[2]]
				end
			end;
			local function zX(h4)
				for _, b8 in ipairs(zH) do
					if b8 ~= h4 then
						return HEAL_RAID[b8]
					end
				end
			end;
			if # zW > 0 and not AutoHelp.STOP_HEAL then
				local zY = zW[1]
				local zZ = nil;
				if AutoHelp.playerClass == "PALADIN" and # zH > 1 then
					if AutoHelp.UnitHasBuffByPlayer(zY["unit"], 53563) then
						if # zW > 1 then
							zZ = zW[2]
						else
							table.sort(zH, function(rL, rM)
								return HEAL_RAID[rL]["alost"] > HEAL_RAID[rM]["alost"]
							end)
							zZ = zX(zY["unit"])
						end
					end
				end;
				if AutoHelp.IsMoving then
					if AutoHelp.HotTeam(zY, zZ) then
						AutoHelp.DebugText = "团队治疗(移动中)"
						return true
					end
				else
					if AutoHelp.HealTeam(zY, zZ) then
						AutoHelp.DebugText = "团队治疗"
						return true
					end
				end
			end
		end;
		if AutoHelp.playerClass == "PALADIN" then
			if zO and AutoHelp.TryUseAction(zO, zO["aBuffKey"]) then
				AutoHelp.DebugText = "强效BUFF启动"
				return true
			end;
			if zP and AutoHelp.TryUseAction(zP, zP["aBuffKey"]) then
				AutoHelp.DebugText = "普通BUFF启动"
				return true
			end
		else
			if AutoHelp.DoTeamBuff and AutoHelp.DoTeamBuff() then
				AutoHelp.DebugText = "团队BUFF模块启动"
				return true
			end
		end
	end;
	local function z_(b8)
		local p_ = C_Map.GetBestMapForUnit(b8)
		if p_ ~= nil then
			local A0 = C_Map.GetPlayerMapPosition(p_, b8)
			if A0 then
				return A0:GetXY()
			end
		end
	end;
	local rU = GetTime()
	local A1;
	local A2 = 0;
	local A3 = 0;
	local A4 = GetTime()
	local A5 = GetTime()
	local function A6(mH)
		local mT, r7 = mH["hp"], mH["mp"] * 100;
		if GetStatus("STATUS_治疗模式") and not GetStatus("STATUS_主动攻击") then
			return false
		end;
		if AutoHelp.isWotlk then
			local rX = AutoHelp.TargetInfo and (AutoHelp.TargetInfo["name"] == "镜像" or AutoHelp.TargetInfo["name"] == "裹体之网")
			if not rX and AutoHelp.AssistUnit and UnitExists(AutoHelp.AssistUnit) and UnitCanAssist("player", AutoHelp.AssistUnit) and UnitExists(AutoHelp.AssistUnit .. "target") then
				local zU = UnitAffectingCombat("player") or UnitAffectingCombat(AutoHelp.AssistUnit)
				if UnitCanAttack("player", AutoHelp.AssistUnit .. "target") and not UnitIsUnit("target", AutoHelp.AssistUnit .. "target") and not UnitIsDeadOrGhost(AutoHelp.AssistUnit .. "target") and zU then
					local tInfo = GetRaidUnit(AutoHelp.AssistUnit)
					if tInfo and AutoHelp.TryUseAction(tInfo, "协助目标") then
						if not HEAL_ISASSISTING then
							HEAL_ISASSISTING = true
						end;
						return true
					end
				end
			end
		else
			if AutoHelp.AssistUnit and UnitExists(AutoHelp.AssistUnit) and UnitCanAssist("player", AutoHelp.AssistUnit) and UnitExists(AutoHelp.AssistUnit .. "target") then
				local zU = UnitAffectingCombat("player") or UnitAffectingCombat(AutoHelp.AssistUnit)
				if UnitCanAttack("player", AutoHelp.AssistUnit .. "target") and not UnitIsUnit("target", AutoHelp.AssistUnit .. "target") and not UnitIsDead(AutoHelp.AssistUnit .. "target") and zU then
					local tInfo = GetRaidUnit(AutoHelp.AssistUnit)
					if tInfo and AutoHelp.TryUseAction(tInfo, "协助目标") then
						if not HEAL_ISASSISTING then
							HEAL_ISASSISTING = true
						end;
						return true
					end
				end
			end
		end;
		targetInfo = AutoHelp.TargetInfo;
		lastTarget = AutoHelp.LastTargetInfo;
		if GetStatus("STATUS_自动拾取") and not InCombatLockdown() then
			if not targetInfo and lastTarget and CanLootUnit(lastTarget["guid"]) then
				AutoHelp.LastTargetInfo = nil;
				DoEmote("stand")
				AutoHelp.TryUseAction(mH, "选择上一个敌方目标")
				A3 = true;
				A2 = GetTime() + 5;
				return true
			end;
			if targetInfo and targetInfo["dead"] and (not CanLootUnit(UnitGUID("target")) or HEAL_ATTACK_FULLBAG or GetTime() > A2) then
				if HEAL_ATTACK_FULLBAG then
					HEAL_ATTACK_FULLBAG = nil
				end;
				AutoHelp.LastTargetInfo = nil;
				AutoHelp.TryUseAction(mH, "清除目标")
				return true
			end;
			if targetInfo and targetInfo["dead"] and not HEAL_ATTACK_FULLBAG and A3 then
				A3 = false;
				AutoHelp.LastTargetInfo = nil;
				DoEmote("stand")
				AutoHelp.TryUseAction(targetInfo, "目标互动")
				return true
			end
		end;
		local A7 = GetToggleStatus(AutoHelp.FINDTARGETMODE)
		if HEAL_ISASSISTING then
			if not UnitExists("target") or UnitIsDead("target") or not AutoHelp.AssistUnit or not UnitIsUnit("target", AutoHelp.AssistUnit .. "target") then
				HEAL_ISASSISTING = false
			end
		end;
		if not targetInfo and HEAL_ISASSISTING then
			HEAL_ISASSISTING = false
		end;
		if GetStatus("STATUS_自动寻怪") then
			if UnitAffectingCombat("player") then
				if not targetInfo then
					for oz, tInfo in pairs(HEAL_RAID) do
						if AutoHelp.IsValidEmergency(tInfo) then
							local x = tInfo["unit"] .. "target"
							if UnitExists(x) and UnitCanAttack("player", x) and not UnitIsDeadOrGhost(x) then
								if AutoHelp.TryUseAction(tInfo, "协助目标") then
									return true
								end
							end
						end
					end;
					if UnitExists("pet") and UnitExists("pettarget") and UnitCanAttack("player", "pettarget") then
						if AutoHelp.TryUseAction(tInfo, "协助宠物") then
							return true
						end
					end
				end
			else
				if AutoHelp.TargetTime then
					if not A7 then
						if GetTime() >= AutoHelp.TargetTime + 10 then
							AutoHelp.AddCastAction("清除目标", true)
							return false
						end
					else
						if GetTime() >= AutoHelp.TargetTime + 10 then
							AutoHelp.AddCastAction("转身90度/清除目标", true)
							return false
						end
					end
				end
			end;
			if not targetInfo then
				if not InCombatLockdown() then
					if not A1 then
						if AutoHelp.TryUseAction(mH, "寻找目标") then
							A1 = true;
							return true
						end
					else
						if A7 == "转圈寻怪" then
							if GetTime() > A5 + 240 then
								A5 = GetTime()
							end;
							local A8 = GetStatusNumber("VALUE_SPEED", 2)
							if GetTime() < A5 + 120 then
								if GetStatus("STATUS_快速转圈") then
									if GetTime() > A4 + A8 and AutoHelp.TryUseAction(mH, "右转45度") then
										A4 = GetTime()
										A1 = false;
										return true
									end
								else
									if GetTime() > A4 + A8 * 2 and AutoHelp.TryUseAction(mH, "右转45度") then
										A4 = GetTime()
										A1 = false;
										return true
									end
								end
							else
								if GetStatus("STATUS_快速转圈") then
									if GetTime() > A4 + A8 and AutoHelp.TryUseAction(mH, "左转45度") then
										A4 = GetTime()
										A1 = false;
										return true
									end
								else
									if GetTime() > A4 + A8 * 2 and AutoHelp.TryUseAction(mH, "左转45度") then
										A4 = GetTime()
										A1 = false;
										return true
									end
								end
							end
						elseif A7 == "移动寻怪" then
							if AutoHelp.TryUseAction(mH, "移动搜索") then
								A1 = false;
								return true
							end
						else
							A1 = false
						end
					end
				end;
				return false
			else
				if not UnitCanAttack("player", targetInfo["unit"]) or UnitIsTapDenied("target") and not UnitPlayerControlled("target") and not UnitIsUnit("player", "targettarget") then
					AutoHelp.AddCastAction("清除目标", true)
					return false
				end
			end
		end;
		AutoHelp.UpdateTargetInfo(2)
		A1 = false;
		local zU = GetStatus("HEAL_STATUS_主动开怪") or UnitAffectingCombat("player") or UnitAffectingCombat("target") or hasAssist and UnitAffectingCombat(AutoHelp.AssistUnit)
		if not zU then
			return false
		end;
		local A9 = targetInfo and targetInfo["canAttack"] and not targetInfo["dead"]
		if not A9 then
			return false
		end;
		if GetStatus("STATUS_目标互动") then
			local ib, iG = AutoHelp.GetRange("target")
			if AutoHelp.AttackType == 1 then
				if iG >= 8 and iG <= 25 and (AutoHelp.playerClass == "WARRIOR" or AutoHelp.playerClass == "DRUID") then
					if AutoHelp.InteractTarget and AutoHelp.InteractTarget(mH, targetInfo) then
						return true
					end
				end;
				if HEAL_ATTACK_ERRORFACING or iG > 2 then
					if not rU or rU < GetTime() - 1 then
						HEAL_ATTACK_OUTOFRANGE = nil;
						HEAL_ATTACK_ERRORFACING = nil;
						AutoHelp.TryUseAction(targetInfo, "目标互动")
						rU = GetTime()
						return true
					end
				end
			elseif AutoHelp.AttackType == 2 then
				if iG > (AutoHelp.AttackRange or 30) then
					if not rU or rU < GetTime() - 0.5 then
						HEAL_ATTACK_OUTOFRANGE = nil;
						HEAL_ATTACK_ERRORFACING = nil;
						AutoHelp.TryUseAction(targetInfo, "目标互动")
						rU = GetTime()
						return true
					end
				end;
				if HEAL_ATTACK_ERRORFACING then
					HEAL_ATTACK_ERRORFACING = nil;
					AutoHelp.TryUseAction(mH, "转身")
					return true
				end;
				if iG <= (AutoHelp.AttackRange or 30) and AutoHelp.IsMoving then
					AutoHelp.TryUseAction(targetInfo, "停止移动")
					return true
				end
			end
		end;
		if AutoHelp.DoAttackAction and AutoHelp.DoAttackAction(mH, targetInfo) then
			AutoHelp.DebugText = "攻击模式"
			return true
		end
	end;
	local function Aa()
		local jS = 0;
		for oz, tInfo in pairs(HEAL_RAID) do
			if tInfo["hp"] <= 0.5 then
				return true
			end;
			if tInfo["hp"] <= 0.6 then
				jS = jS + 1
			end
		end;
		if jS >= 2 then
			return true
		end;
		return false
	end;
	local function Ab(mH, targetInfo)
		if AutoHelp.DoUrgentAction and AutoHelp.DoUrgentAction(mH, targetInfo) then
			return true
		end;
		if InCombatLockdown() and GetStatus("HEAL_STATUS_自动吃糖") and mH["hp"] <= (GetStatusNumber("HEAL_VALUE_保命血量") or 35) / 100 then
			if AutoHelp.TryUseAction(mH, "吃糖") then
				return true
			end;
			if AutoHelp.TryUseAction(mH, "喝红") then
				return true
			end
		end
	end;
	local function Ac()
		local r6 = not GetStatus("HEAL_STATUS_INBATTLE_HEAL") or UnitAffectingCombat("player") or UnitAffectingCombat("target")
		local mH = HEAL_RAID["player"]
		mH["ahp"], mH["alost"] = AutoHelp.GetUnitComingHP(mH, AutoHelp.CommingHealWindow)
		local mT, r7 = mH["hp"], mH["mp"]
		local r8 = mH["groupNo"]
		local r9 = AutoHelp.IsDrinking() and r7 < 0.90 or AutoHelp.IsEating() and mT < 0.9;
		if zz() then
			AutoHelp.DebugText = "\124cfff00000" .. (zv or "") .. "  " .. tostring(ceil(zw - GetTime())) .. "/" .. tostring(zu) .. "秒\124r"
			return false
		end;
		if not InCombatLockdown() and (AutoHelp.IsDrinking() and r7 < 0.9 or AutoHelp.IsEating() and mT < 0.9) then
			HEAL_TIMERS["HEAL_TARGET"] = 2;
			return false
		end;
		if AutoHelp.IsDrinking() or AutoHelp.IsEating() or UnitIsAFK("player") then
			AutoHelp.IsMoving = false
		else
			AutoHelp.IsMoving = IsPlayerMoving()
		end;
		if AutoHelp.IsMoving and IsMounted() then
			AutoHelp.DebugText = "骑马前进中"
			return false
		end;
		if IsFlying() then
			AutoHelp.DebugText = "飞行中"
			return false
		end;
		if not GetStatus("STATUS_自动下马") and IsMounted() then
			AutoHelp.DebugText = "骑马中(不自动下马)"
			return false
		end;
		if x3() then
			return true
		end;
		if zG() then
			AutoHelp.DebugText = "\124cfff00000" .. (zB or "") .. "  " .. tostring(ceil(zC - GetTime())) .. "/" .. tostring(zA) .. "秒\124r"
		end;
		if Ab(mH, AutoHelp.TargetInfo) then
			return true
		end;
		if AutoHelp.CAN_DISPEL then
			if GetStatus("HEAL_STATUS_FIRSTDISPAL") and AutoHelp.DoDispelAction and AutoHelp.DoDispelAction() then
				return true
			end
		end;
		if (AutoHelp.CAN_HEAL or AutoHelp.CAN_BUFF) and zM(mH) then
			return true
		end;
		if AutoHelp.CAN_DISPEL and GetStatus("STATUS_治疗模式") and AutoHelp.DoDispelAction and AutoHelp.DoDispelAction() then
			return true
		end;
		if not InCombatLockdown() then
			if AutoHelp.DoUncombatAction and AutoHelp.DoUncombatAction(mH) then
				AutoHelp.DebugText = "战前准备"
				return true
			end
		end;
		if AutoHelp.DoCommonAction and AutoHelp.DoCommonAction(mH) then
			AutoHelp.DebugText = ""
			return true
		end;
		if not InCombatLockdown() then
			if not AutoHelp.IsMoving and zr(mH) then
				AutoHelp.DebugText = "自动吃喝"
				return true
			end;
			if not AutoHelp.IsMoving and zp(mH) then
				AutoHelp.DebugText = "自动喝水"
				return true
			end;
			if not AutoHelp.IsMoving and zq(mH) then
				AutoHelp.DebugText = "自动吃面包"
				return true
			end;
			if not AutoHelp.IsMoving and not IsMounted() and AutoHelp.playerClass == "PALADIN" and GetStatus("HEAL_STATUS_AUTOMOUNT") then
				if AutoHelp.TryUseAction(mH, "战马") or AutoHelp.TryUseAction(mH, "军马") then
					AutoHelp.DebugText = "自动上马模块启动"
					return true
				end
			end
		end;
		if A6(mH) then
			AutoHelp.DebugText = "攻击模式"
			return true
		end;
		if AutoHelp.CAN_DISPEL and not GetStatus("STATUS_治疗模式") and AutoHelp.DoDispelAction and AutoHelp.DoDispelAction() then
			return true
		end;
		if GetStatus("STATUS_自动战场") and AutoHelp.DoBattleGround() then
			return true
		end;
		if xb("BLACK_LIST", 1) then
			xf()
		end;
		return false
	end;
	AutoHelp.ForceBreakSpell = false;
	local function Ad()
		AutoHelp.DebugText = nil;
		local mH = HEAL_RAID["player"]
		if UnitIsDeadOrGhost("player") then
			AutoHelp.DoActionIdle("已经死亡", "死亡状态")
			return false
		end;
		if UnitIsCharmed("player") then
			AutoHelp.DoActionIdle("被控制", "无法动作")
			return false
		end;
		if not mH then
			AutoHelp.DoActionIdle("未初始化团队", "等待脱战后重载")
			AutoHelp.SetDebugText("\124cff00ff00请不要在战斗中重载界面\124r")
			return false
		end;
		if jy("STATUS_AUTOINTERUPT") and AutoHelp.DoInterrupt and (UnitExists("target") and UnitCanAttack("player", "target") or UnitExists("focus") and UnitCanAttack("player", "focus")) then
			local b8 = "target"
			local cd, a5, z9, to, tp, za, zb, zc, ca = UnitCastingInfo(b8)
			if not cd or zc then
				b8 = "focus"
				cd, a5, z9, to, tp, za, zb, zc, ca = UnitCastingInfo(b8)
			end;
			if not cd or zc then
				b8 = "target"
				cd, a5, z9, to, tp, za, zc, ca = UnitChannelInfo(b8)
				if not cd or zc then
					b8 = "focus"
					cd, a5, z9, to, tp, za, zc, ca = UnitChannelInfo(b8)
				end
			end;
			if cd and not zc then
				local cn = tp - to;
				local point = cn * (GetStatusNumber("VALUE_AUTOINTERUPT") or 10) / 100;
				if not InCombatLockdown() then
					if AutoHelp.DoInterrupt(mH, b8, cd, to, tp, ca) then
						return true
					end
				else
					if GetTime() >= (to + point) / 1000 then
						if AutoHelp.DoInterrupt(mH, b8, cd, to, tp, ca) then
							return true
						end
					end
				end
			end
		end;
		if AutoHelp.ForceBreakSpell then
			AutoHelp.ForceBreakSpell = false
		else
			if AutoHelp.castinfo.channeling or AutoHelp.castinfo.casting then
				if AutoHelp.castinfo.endTime then
					local lL = AutoHelp.castinfo.endTime - GetTime()
					if AutoHelp.UseSpellQueueWindow and not x2() and InCombatLockdown() then
						local vL = lL - AutoHelp.SpellQueueWindow;
						if vL > 0 then
							HEAL_TIMERS["HEAL_TARGET"] = vL;
							return false
						end
					else
						if lL > 0 then
							HEAL_TIMERS["HEAL_TARGET"] = lL;
							return false
						end
					end
				else
					HEAL_TIMERS["HEAL_TARGET"] = 0.1;
					return false
				end
			end
		end;
		AutoHelp.InCooldown = false;
		local bv, cn = GetSpellCooldown(29515)
		if cn and cn > 0 then
			local lL = cn - (GetTime() - bv)
			if AutoHelp.UseSpellQueueWindow and not x2() and InCombatLockdown() then
				lL = lL - AutoHelp.SpellQueueWindow
			end;
			AutoHelp.InCooldown = lL > 0;
			if AutoHelp.playerClass ~= "WARRIOR" and lL > 0 then
				HEAL_TIMERS["HEAL_TARGET"] = lL;
				return false
			end
		end;
		AutoHelp.DONT_INTERRUPT = false;
		if Ac() then
			if HEAL_TIMERS["HEAL_TARGET"] <= 0 then
				HEAL_TIMERS["HEAL_TARGET"] = 0.1
			end;
			if AutoHelp.DebugText then
				AutoHelp.SetDebugText(AutoHelp.DebugText)
			end;
			return true
		end;
		AutoHelp.DONT_INTERRUPT = true;
		if HEAL_TIMERS["HEAL_TARGET"] <= 0 then
			AutoHelp.DoActionIdle("等待中...", "无")
			if not AutoHelp.DebugText then
				AutoHelp.DebugText = "无模块启动，等待中"
			end;
			AutoHelp.SetDebugText(AutoHelp.DebugText)
		end;
		return false
	end;
	AutoHelp.BATTLEGROUNDS = {}
	local function Ae()
		if AutoHelp.isClassic then
			return
		else
			local Af = GetNumBattlegroundTypes() or 0;
			for i = 1, Af do
				local cd, Ag, Ah, Ai, Aj = GetBattlegroundInfo(i)
				if cd and Ag then
					AutoHelp.BATTLEGROUNDS[# AutoHelp.BATTLEGROUNDS + 1] = cd
				end
			end
		end
	end;
	local function Ak(Al)
		local l6 = 0;
		local Af = GetNumBattlegroundTypes()
		for i = 1, Af do
			local cd, Ag, Ah, Ai, Aj = GetBattlegroundInfo(i)
			if cd and Ag then
				l6 = l6 + 1;
				if Al == cd then
					return l6
				end
			end
		end
	end;
	local function Am()
		local mH = HEAL_RAID["player"]
	end;
	function AutoHelp.DoBattleGround()
		local mH = HEAL_RAID["player"]
		local Al = jy("JOIN_战场")
		local An = Ak(Al)
		if Al == "组队战场" then
			An = 99
		end;
		if GetStatus("STATUS_自动战场") and An and not AutoHelp.UnitHasDebuff("player", "逃亡者") then
			local mt, mu, gs, mv, mw, mx, my = GetBattlefieldStatus(1)
			if mt == "active" then
				return Am()
			end;
			if mt == "confirm" then
				return AutoHelp.TryUseAction(mH, "KEY_JOINBATTLE")
			end;
			if mt == "none" and An ~= 99 and not InCombatLockdown() then
				local lh, action = AutoHelp.GetActionKey("KEY_AUTOBATTLE")
				action["macro"] = "/click BattlegroundType" .. An .. "\n/click BattlefieldFrameJoinButton"
				if AutoHelp.RefreshAction then
					AutoHelp.RefreshAction(action)
				end;
				return AutoHelp.TryUseAction(mH, "KEY_AUTOBATTLE")
			end
		end
	end;
	local function Ao()
		local tInfo = HEAL_RAID["player"]
		if AutoHelp.TryUseAction(tInfo, "KEY_STOPCAST") then
			AutoHelp.Debug("主手即将攻击，取消英勇", AutoHelp.main_swing_timer)
		end;
		AutoHelp.ShouldCastYY = false
	end;
	function AutoHelp.StopAutoCasting(p9)
		if p9 then
			HEAL_TIMERS["HEAL_TARGET"] = p9
		else
			HEAL_TIMERS["HEAL_TARGET"] = 1.5
		end
	end;
	function AutoHelp.TryDoAction(tInfo, p, Ap, Aq)
		if GetStatus("HEAL_STATUS_PAUSE") then
			if not Aq then
				AutoHelp.Debug(">>暂停状态，无法执行！")
			end;
			return
		end;
		if tInfo and p then
			if Ap then
				x4()
			end;
			if not Aq then
				AutoHelp.Debug(">>" .. p .. " 已加入施法队列。")
			end;
			return AutoHelp.AddNextAction(tInfo, p, 0)
		end
	end;
	local Ar = false;
	local As = 0;
	local At = 0;
	local Au;
	local Av;
	local Aw, Ax;
	local Ay = 1;
	local Az;
	local AA = nil;
	local AB = nil;
	function HEAL_OnUpdate(_, xa)
		if As < 0.08 then
			As = As + xa;
			At = At + xa;
			return
		else
			x9(xa + As)
			As = 0
		end;
		local AC = GetStatus("HEAL_STATUS_PAUSE")
		if xe("RELOAD_UI") then
			if HEAL_IS_RELOADING or InCombatLockdown() then
				HEAL_TIMERS["RELOAD_UI"] = 0.3
			else
				HEAL_reloadUI()
				wv = true
			end
		end;
		if not AC and xe("AUTO_INTERRUPT") and AutoHelp.BotAction then
			yi()
			AutoHelp.BotAction = false
		end;
		if xe("RELOAD_RAID") then
			y0()
		end;
		local AD = false;
		if not AC and xe("HEAL_TARGET") then
			if AutoHelp.IsChating then
				AutoHelp.DoActionIdle("等待输入结束...", "无")
				AutoHelp.SetDebugText("您正在聊天等输入，停止运行！")
			elseif UnitOnTaxi("player") then
				AutoHelp.DoActionIdle("正在乘坐飞机...", "无")
				AutoHelp.SetDebugText("飞机中，停止运行！")
			elseif UnitIsCharmed("player") or UnitIsPossessed("player") then
				AutoHelp.DoActionIdle("被控制无法动作...", "无")
				AutoHelp.SetDebugText("被控制，停止运行！")
			elseif HEAL_EDITBOX_EDITING then
				AutoHelp.DoActionIdle("正在编辑设置值...", "无")
				AutoHelp.SetDebugText("修改编辑中，停止运行！")
			elseif UnitInVehicle("player") and UnitHasVehicleUI("player") then
				AutoHelp.DoActionIdle("正在载具...", "无")
				AutoHelp.SetDebugText("控制载具，停止运行！")
			else
				local ja, s = pcall(function()
					AD = Ad()
				end)
				if not ja and s then
					if AA ~= s then
						AA = s;
						AB = GetTime()
						print("捕获到错误请提交给开发人员:", s)
						print(debugstack())
					elseif AB and GetTime() > AB + 120 then
						AB = GetTime()
						print("捕获到错误请提交给开发人员:", s)
						print(debugstack())
					end
				end
			end
		end;
		if not AC and HEAL_TIMERS["HEAL_TARGET"] <= 0 then
			if not Az then
				Az = 1
			end;
			HEAL_TIMERS["HEAL_TARGET"] = 1
		end;
		if not AC and wQ ~= nil and xb("AUTO_FOLLOW", 1) then
			if not wP and UnitExists(wQ) then
				local ib, iG = AutoHelp.GetRange(wQ)
				local AE, AF, AG, AH = GetUnitSpeed(wQ)
				if iG > 5 or AE > 0 or not AD then
					ShouldFollowLeader()
				end
			end
		end;
		if At < 1.2 then
			At = At + xa;
			return
		else
			x9(xa + At)
			At = 0
		end;
		if not AC and xb("BLACK_LIST", 1) then
			xf()
		end;
		if xe("RECALC_HEALS") then
			AutoHelp.RecalcSmartHealList()
		end;
		if xe("EQUIP_CHANGED") then
			AutoHelp.EquipmentChanged()
			AutoHelp.RecalcHealList("装备变化，重新评估治疗量：")
		end;
		if wu and not InCombatLockdown() then
			wu = false;
			if xe("CREATESECURE") then
				AutoHelp.CreateSecureFrame()
			end;
			if HEAL_TIMERS["RELOAD_RAID"] <= 0 then
				x6()
			end
		end
	end;
	function HEAL_init()
		HEAL_TIMERS["RELOAD_UI"] = 0.1;
		wt = true
	end;
	local AI;
	do
		local AJ = "wkey"
		local AK = "hkey"
		local AL = "C" .. "T" .. "R" .. "L-" .. "NUMPAD"
		AI = {
			[1] = {
				[AJ] = AL .. "1",
				[AK] = "{NUMPAD1}"
			},
			[2] = {
				[AJ] = AL .. "2",
				[AK] = "{NUMPAD2}"
			},
			[3] = {
				[AJ] = AL .. "3",
				[AK] = "{NUMPAD3}"
			},
			[4] = {
				[AJ] = AL .. "4",
				[AK] = "{NUMPAD4}"
			},
			[5] = {
				[AJ] = AL .. "5",
				[AK] = "{NUMPAD5}"
			},
			[6] = {
				[AJ] = AL .. "6",
				[AK] = "{NUMPAD6}"
			},
			[7] = {
				[AJ] = AL .. "7",
				[AK] = "{NUMPAD7}"
			},
			[8] = {
				[AJ] = AL .. "8",
				[AK] = "{NUMPAD8}"
			},
			[9] = {
				[AJ] = AL .. "9",
				[AK] = "{NUMPAD9}"
			},
			[10] = {
				[AJ] = AL .. "DIVIDE",
				[AK] = "{NumpadDiv}"
			},
			[11] = {
				[AJ] = AL .. "MULTIPLY",
				[AK] = "{NumpadMult}"
			},
			[12] = {
				[AJ] = AL .. "MINUS",
				[AK] = "{NumpadSub}"
			},
			[13] = {
				[AJ] = AL .. "PLUS",
				[AK] = "{NumpadAdd}"
			},
			[14] = {
				[AJ] = AL .. "DECIMAL",
				[AK] = "{NumpadDot}"
			}
		}
	end;
	function AutoHelp.CreateSecureFrame()
		SetBinding("CTRL-S")
		SetBinding("CTRL-R")
		SetBinding("CTRL-C")
		SetBinding("CTRL-V")
		SetBinding("CTRL-F11")
		SetOverrideBinding(UIParent, true, "TAB", "TARGETNEARESTENEMY")
		wW = CreateFrame("Frame", "AutoHelpBarFrame", UIParent, "SecureHandlerBaseTemplate,SecureHandlerAttributeTemplate")
		wW:SetFrameStrata("BACKGROUND")
		wW:SetWidth((kJ + kL) * 8 + 2)
		wW:SetHeight((kK + kL) * 2 + 2)
		wW:SetPoint("TOP", wy + 10, 100)
		wW.texture = wW:CreateTexture(nil, 'OVERLAY', nil, 7)
		wW.texture:SetColorTexture(0.1, 0.1, 0.1, 1)
		wW.texture:SetAllPoints()
		HEAL_BUTTONS["mainFrame"] = wW;
		AutoHelp.MainButtonFrame = wW;
		wW:Execute([[
        actionkeys = table.new();
    ]])
		wW:SetAttribute("DoAction", [[local a=self:GetAttribute("TargetNum")local b=self:GetAttribute("ActionNum")self:SetAttribute("KeyNum1",nil)local c;if not a or a==0 then elseif a==1 then elseif a==2 then c="target"elseif a==3 then c="player"elseif a>3 then local d=a-3;local e=PlayerInGroup()if not e then c=c or"player"elseif e=="raid"then c="raid"..d elseif e=="party"then c="party"..d end end;if not b or b<1 or b>#actionkeys then return""end;local f=actionkeys[b]local g=f.macro;if c and not UnitExists(c)then return""end;if c then g=string.rtgsub(g,"@target",c)end;if self:GetAttribute("ChangeHealTarget")and c then g="/target "..c.."\n"..g end;return g]])
		local function AM(action, v)
			local AN = {}
			AN[# AN + 1] = "local action = table.new()"
			for cd, jp in pairs(action) do
				local AO;
				if type(jp) == "boolean" then
					if jp then
						AO = [[action.%s = true]]
					else
						AO = [[action.%s = false]]
					end;
					AN[# AN + 1] = AO:format(cd)
				elseif type(jp) == "number" then
					AO = [[action.%s = %d]]
					AN[# AN + 1] = AO:format(cd, jp)
				elseif type(jp) == "string" then
					AO = [[action.%s = %q]]
					AN[# AN + 1] = AO:format(cd, jp)
				end
			end;
			if not v then
				AN[# AN + 1] = "actionkeys[#actionkeys+1] = action"
			else
				AN[# AN + 1] = "actionkeys[" .. v .. "] = action"
			end;
			return table.concat(AN, ";\n")
		end;
		AutoHelp.RefreshAction = function(action)
			wW:Execute(AM(action, action["actionkey"]))
		end;
		for l6, im in ipairs(AutoHelp.HEAL_ACTION_KEYS) do
			wW:Execute(AM(im))
		end;
		local function AP(jS)
			local gW = floor((jS - 1) / FRAME_ROWS)
			local y = Modulo(jS - 1, FRAME_ROWS)
			local cd = "BattleHelpActionButtonSlot" .. tostring(jS)
			local k8 = CreateFrame("Button", cd, wW, "SecureActionButtonTemplate")
			k8:SetAttribute("type", "macro")
			k8:SetSize(kJ, kK)
			k8:SetPoint("TOPLEFT", wW, gW * (kJ + kL), - y * (kK + kL))
			k8.texture = k8:CreateTexture(k8:GetName(), 'OVERLAY', nil, 7)
			k8.texture:SetColorTexture(0.2, 0.2, 0.2, 1)
			k8.texture:SetAllPoints()
			k8:Show()
			return k8
		end;
		FRAME_ROWS = 2;
		for jS = 1, 14 do
			local k8 = AP(jS)
			SecureHandlerWrapScript(k8, "OnClick", k8, [[self:SetAttribute("macrotext",nil)parent=parent or self:GetParent()local a=self:GetAttribute("KeyNum")local b=parent:GetAttribute("KeyNum1")local c=parent:GetAttribute("KeyNum2")local d=parent:GetAttribute("KeyNum3")local e=parent:GetAttribute("KeyNum4")if b==nil then parent:SetAttribute("KeyNum1",a)parent:SetAttribute("KeyNum2",nil)elseif c==nil then parent:SetAttribute("KeyNum2",a)parent:SetAttribute("KeyNum3",nil)elseif d==nil then parent:SetAttribute("KeyNum3",a)parent:SetAttribute("KeyNum4",nil)elseif e==nil then parent:SetAttribute("KeyNum1",nil)e=a;local f=b*14+c;local g=d*14+e;print(f,g)parent:SetAttribute("TargetNum",f)parent:SetAttribute("ActionNum",g)local h=parent:RunFor(parent,parent:GetAttribute("DoAction"))self:SetAttribute("macrotext",h)else parent:SetAttribute("KeyNum1",nil)end]])
			k8:SetAttribute("type", "macro")
			k8:SetAttribute("KeyNum", jS - 1)
			SetOverrideBindingClick(wW, true, AI[jS]["wkey"], k8:GetName())
		end;
		local AQ = AP(15)
		SecureHandlerWrapScript(AQ, "OnClick", AQ, [[
        parent = parent or self:GetParent();
        parent:SetAttribute("KeyNum1",nil);
    ]])
		SetOverrideBindingClick(wW, true, "CTRL-F9", AQ:GetName())
	end;
	function CreateFrames()
		if not InCombatLockdown() then
			AutoHelp.CreateSecureFrame()
		else
			wu = true;
			HEAL_TIMERS["CREATESECURE"] = 1
		end;
		local k8 = CreateFrame("Button", "BattleHelpPauseButton", UIParent)
		k8:SetScript("OnClick", function(self, f8)
			SetConfig("HEAL_STATUS_PAUSE", not GetStatus("HEAL_STATUS_PAUSE"))
		end)
		SetOverrideBindingClick(UIParent, true, "NUMPAD0", k8:GetName())
		local k8 = CreateFrame("Button", "BattleHelpGetInfoButton", UIParent)
		k8:SetScript("OnClick", function(self, f8)
			ShowEditInfo()
			AutoHelp.Debug("AutoHelp开始自动运行（小键盘零可以暂停/继续）。。。")
			AutoHelp.StartedMessage()
		end)
		SetOverrideBindingClick(UIParent, true, "RCTRL-F11", k8:GetName())
		if # AutoHelp.CommandKeys > 0 then
			for _, p in ipairs(AutoHelp.CommandKeys) do
				if p.wkey and p.command then
					SetOverrideBinding(UIParent, true, p.wkey, p.command)
				end
			end
		end;
		if # AutoHelp.MoveKeys > 0 then
			for _, p in ipairs(AutoHelp.MoveKeys) do
				if p.wkey and p.movecommand then
					SetOverrideBinding(UIParent, true, p.wkey, p.movecommand)
				end
			end
		end
	end;
	function ShowEditInfo()
		if wX == nil then
			CreateCheckWindow()
		end;
		local cd, AR = UnitFullName("player")
		local AS = UnitClass("player")
		local jU, jV = UnitFactionGroup("player")
		local im = wY;
		im = im .. "|" .. AS;
		im = im .. "|" .. getPlayerLevel("player")
		im = im .. "|" .. GetMinimapZoneText() .. "/" .. GetZoneText()
		im = im .. "|" .. AR .. "/" .. jV .. "/" .. AS .. "/" .. cd .. "[" .. AutoHelp.VersionNo .. "]"
		local AT = ""
		local d2 = ""
		local AU = ""
		for l6, im in ipairs(AutoHelp.HEAL_ACTION_KEYS) do
			local d = im["desc"] or im["name"]
			if not d then
				AutoHelp.Debug("加载错误，请Reload一下界面！" .. im["name"])
			end;
			if AU == "" then
				AU = d
			else
				AU = AU .. "," .. d
			end
		end;
		im = im .. "|" .. AU;
		im = im .. "|" .. tostring(# AutoHelp.HEAL_ACTION_KEYS)
		AT = ""
		for _, hW in ipairs(AI) do
			if AT == "" then
				AT = hW.hkey
			else
				AT = AT .. "," .. hW.hkey
			end
		end;
		im = im .. "|" .. AT;
		local AV = ""
		local AW = ""
		for i, p in ipairs(AutoHelp.CommandKeys) do
			local d = p["desc"]
			if not d then
				d = p["name"]
			end;
			if AV == "" then
				AV = d;
				AW = p["akey"]
			else
				AV = AV .. "," .. d;
				AW = AW .. "," .. p["akey"]
			end
		end;
		im = im .. "|" .. AV;
		im = im .. "|" .. AW;
		local AX = ""
		local AY = ""
		for i, p in ipairs(AutoHelp.MoveKeys) do
			local d = p["desc"]
			if not d then
				d = p["name"]
			end;
			if AX == "" then
				AX = d;
				AY = p["akey"]
			else
				AX = AX .. "," .. d;
				AY = AY .. "," .. p["akey"]
			end
		end;
		im = im .. "|" .. AX;
		im = im .. "|" .. AY;
		wX:SetText(im)
		wX:Show()
		wX:HighlightText()
		AutoHelp.MakePixelSquare(0, 0, 0)
	end;
	function HideEditInfo()
		if wX ~= nil then
			wX:Hide()
			return
		end
	end;
	function CreateCheckWindow()
		if wX ~= nil then
			return
		end;
		wX = CreateFrame("EditBox", nil, UIParent)
		wX:SetPoint("TOP", 0, 130)
		wX:SetSize(900, 50)
		wX:SetFont(ChatFontNormal:GetFont())
		wX:SetAutoFocus(true)
		wX:SetMultiLine(false)
		wX:SetFrameStrata("TOOLTIP")
		wX:SetFrameLevel(10000)
		wX:SetScript("OnEscapePressed", function()
		end)
		local ph = false;
		wX:SetScript("OnKeyDown", function(_, p)
			if p == "C" and IsControlKeyDown() then
				wX:SetAutoFocus(true)
				ph = true
			end
		end)
		wX:SetScript("OnKeyUp", function(_, p)
			wX:Hide()
		end)
	end;
	function StartAutoHelp()
		if ww then
			AutoHelp.Debug("AutoHelp正在运行中。。。")
			return
		end;
		AutoHelp.DoActionIdle("等待中...", "无")
		if AutoHelp.ColorFrame then
			AutoHelp.ColorFrame:Show()
			for _, AZ in pairs(wA) do
				AutoHelp.ColorFrame:RegisterEvent(AZ)
			end;
			AutoHelp.ColorFrame:SetScript("OnEvent", yF)
			AutoHelp.ColorFrame:SetScript("OnUpdate", HEAL_OnUpdate)
		end;
		HEAL_init()
		local A_ = jy("HEALMODE", AutoHelp.DefaultMode)
		SetConfig("HEALMODE", A_)
		ww = true;
		AutoHelp.Debug("AutoHelp加载完成，请按F12开始运行。。。")
	end;
	function StopAutoHelp()
		if not ww then
			AutoHelp.Debug("AutoHelp未运行！")
			return
		end;
		if AutoHelp.ColorFrame then
			AutoHelp.ColorFrame:Hide()
			for _, AZ in pairs(wA) do
				AutoHelp.ColorFrame:UnregisterEvent(AZ)
			end;
			AutoHelp.ColorFrame:SetScript("OnEvent", nil)
			AutoHelp.ColorFrame:SetScript("OnUpdate", nil)
		end;
		ww = false;
		AutoHelp.Debug("AutoHelp已经停止运行。")
	end;
	function AutoHelp.CanSelfBuff(mH)
		if AutoHelp.SelfBuffList then
			for _, jZ in ipairs(AutoHelp.SelfBuffList) do
				if jZ["AutoStatus"] and GetStatus(jZ["AutoStatus"]) and not AutoHelp.UnitHasBuff(mH["unit"], unpack(jZ["buffId"])) then
					if AutoHelp.CanUseAction(mH, jZ["key"]) then
						return jZ["key"]
					end
				end
			end
		end
	end;
	AutoHelp.HEAL_CLASSBUFF_LIST = {}
	function AutoHelp.GetClassBuffKey(nR)
		for _, jZ in ipairs(AutoHelp.ClassBuffList) do
			if jZ["AutoStatus"] and GetStatus(jZ["AutoStatus"]) then
				if jZ["name"] == nR then
					return jZ["name"], jZ["time"]
				end
			end
		end
	end;
	function AutoHelp.CanClassBuff(tInfo)
		if tInfo["BUFFTYPE"] then
			return
		end;
		local nR = AutoHelp.HEAL_CLASSBUFF_LIST[tInfo["class"]]
		if not nR then
			return
		end;
		local p, B0 = AutoHelp.GetClassBuffKey(nR)
		if p and (not AutoHelp.UnitHasBuff(tInfo["unit"], nR) or AutoHelp.GetBuffRemainTime(tInfo["unit"], nR) < B0 * 60) then
			if AutoHelp.CanUseAction(tInfo, p) then
				return p
			end
		end
	end;
	function AutoHelp.CanUnitBuff(tInfo)
		local nR = tInfo["BUFFTYPE"]
		if not nR then
			return
		end;
		local p, B0 = AutoHelp.GetClassBuffKey(nR)
		if p and (not AutoHelp.UnitHasBuff(tInfo["unit"], nR) or AutoHelp.GetBuffRemainTime(tInfo["unit"], nR) < B0 * 60) then
			if AutoHelp.CanUseAction(tInfo, p) then
				return p
			end
		end
	end;
	AutoHelp.IsWhisperProtecer = true;
	function AutoHelp.ProtectFriendMsg(B1, cd)
		local a1 = "执行医保：" .. B1 .. "=》" .. cd;
		AutoHelp.Debug(a1)
	end;
	function AutoHelp.ProtectSendWhisper(a1, cd)
	end;
	local jl;
	local function B2(B3, B4, B5, B6)
		local B7 = {}
		local B8 = false;
		local function B9()
			local jS = 0;
			local cd;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo[B5] then
					cd = tInfo["name"]
					jS = jS + 1
				end
			end;
			if jS > 0 then
				SetConfig(B4, cd)
			else
				SetConfig(B4, "无")
			end
		end;
		local function Ba(self, im)
			if not B6 then
				for oz, tInfo in pairs(HEAL_RAID) do
					if oz ~= im.unit then
						tInfo[B5] = false
					end
				end
			end;
			local tInfo = HEAL_RAID[im.unit]
			if tInfo then
				tInfo[B5] = not tInfo[B5]
				B9()
			end;
			HideUIPanel(jl)
		end;
		local function Bb(self, im)
			for oz, tInfo in pairs(HEAL_RAID) do
				tInfo[B5] = false
			end;
			B9()
			AutoHelp.Debug(B3 .. " 列表已经被清除！")
			HideUIPanel(jl)
		end;
		local function Bc(self, im)
			for oz, tInfo in pairs(HEAL_RAID) do
				if im.className == tInfo["className"] then
					tInfo[B5] = not tInfo[B5]
				end
			end;
			B9()
			HideUIPanel(jl)
		end;
		local function Bd(AS)
			local jk = {}
			local i = 0;
			for oz, tInfo in pairs(HEAL_RAID) do
				if AS == tInfo["className"] then
					i = i + 1;
					jk[i] = {
						text = tInfo["name"],
						checked = tInfo[B5] == true,
						arg1 = {
							field = B5,
							unit = oz,
							className = tInfo["className"]
						},
						func = Ba,
						tooltipTitle = "移除/增加",
						tooltipText = "点击移除或者增加进入" .. B3
					}
				end
			end;
			return i, jk
		end;
		local Be = {}
		local Bf = false;
		local jS = 0;
		for oz, tInfo in pairs(HEAL_RAID) do
			if tInfo[B5] then
				Bf = true;
				jS = jS + 1;
				tinsert(Be, {
					text = tInfo["name"] .. "(" .. tInfo["className"] .. ")",
					checked = tInfo[B5] == true,
					arg1 = {
						field = B5,
						unit = oz
					},
					func = Ba,
					tooltipTitle = "移除",
					tooltipText = "点击移除" .. B3
				})
			end
		end;
		if Bf then
			tinsert(B7, {
				text = B3 .. "[" .. tostring(jS) .. "]",
				notCheckable = true,
				hasArrow = true,
				menuList = Be
			})
			tinsert(B7, {
				text = "全部清除",
				notCheckable = true,
				arg1 = {
					field = B5
				},
				func = Bb
			})
		end;
		tinsert(B7, {
			text = "选择" .. B3,
			notCheckable = true,
			isTitle = true
		})
		local Bg = {}
		for oz, tInfo in pairs(HEAL_RAID) do
			Bg[tInfo["className"]] = true
		end;
		for cd, _ in pairs(Bg) do
			local i, jk = Bd(cd)
			if i > 0 then
				tinsert(B7, {
					text = cd .. "(" .. tostring(i) .. ")",
					notCheckable = true,
					hasArrow = true,
					menuList = jk
				})
			end
		end;
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 50, - 20, "MENU", 1)
	end;
	AutoHelp.CreateUnitMenu = B2;
	local function Bh(B3, B4, B5)
	end;
	function AutoHelp.RecalcHealList(lB)
		HEAL_TIMERS["RECALC_HEALS"] = 1
	end;
	function AutoHelp.GetSpellTooltip(ca)
		local bc;
		GameTooltip:SetSpellByID(ca)
		local Bi = GameTooltip:GetRegions()
		for i = 1, select("#", GameTooltip:GetRegions()) do
			local Bj = select(i, GameTooltip:GetRegions())
			if Bj and Bj:GetObjectType() == "FontString" and Bj:GetText() then
				if not bc then
					bc = Bj:GetText()
				else
					bc = bc .. " " .. Bj:GetText()
				end
			end
		end;
		return bc
	end;
	function AutoHelp.PopupListMenu(kp, Bk, Bl, kl, AT, Bm)
		local function k0(B7, im)
			kl:SetText(im.title)
			SetConfig(Bl .. "_TITLE", im.title)
			SetConfig(Bl, im.key)
			HideUIPanel(jl)
		end;
		local Bn = jy(Bl, Bm)
		if not AutoHelp.HasActionKey(Bn) then
			Bn = "无"
		end;
		local B7 = {}
		tinsert(B7, {
			text = kp,
			notCheckable = true,
			isTitle = true
		})
		for _, p in ipairs(AT) do
			action = AutoHelp.GetAction(p)
			local h4 = action["name"]
			if string.len(h4) > 8 then
				h4 = string.sub(h4, 1, 12)
			end;
			local kp = "\124T" .. action["icon"] .. ":14:14\124t" .. h4;
			table.insert(B7, {
				text = GetSpellInfo(action["spellId"]),
				checked = action["name"] == Bn,
				arg1 = {
					button = kl,
					key = action["name"],
					title = kp
				},
				func = k0,
				tooltipTitle = action["spellName"],
				tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
			})
		end;
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	function AutoHelp.PopupListMenu2(kp, Bk, Bl, kl, AT, Bm)
		local function k0(B7, im)
			kl:SetText(im.key)
			SetConfig(Bl, im.key)
			HideUIPanel(jl)
		end;
		local Bn = jy(Bl, Bm)
		if not AutoHelp.HasActionKey(Bn) then
			Bn = "无"
		end;
		local B7 = {}
		tinsert(B7, {
			text = kp,
			notCheckable = true,
			isTitle = true
		})
		for _, p in ipairs(AT) do
			action = AutoHelp.GetAction(p)
			local h4 = action["name"]
			if string.len(h4) > 8 then
				h4 = string.sub(h4, 1, 12)
			end;
			table.insert(B7, {
				text = GetSpellInfo(action["spellId"]),
				checked = action["name"] == Bn,
				arg1 = {
					button = kl,
					key = action["name"]
				},
				func = k0,
				tooltipTitle = action["spellName"],
				tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
			})
		end;
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	function AutoHelp.PopupItemListMenu(kp, Bk, Bl, kl, AT, Bm)
		local function k0(B7, im)
			kl:SetText(im.title)
			SetConfig(Bl .. "_TITLE", im.title)
			SetConfig(Bl, im.key)
			HideUIPanel(jl)
		end;
		local Bn = jy(Bl, Bm)
		local B7 = {}
		tinsert(B7, {
			text = kp,
			notCheckable = true,
			isTitle = true
		})
		for _, p in ipairs(AT) do
			local cd, itemLink, mf, mg, mh, mi, mj, mk, o7, o8, o9 = GetItemInfo(p)
			table.insert(B7, {
				text = cd,
				checked = cd == Bn,
				arg1 = {
					button = kl,
					key = cd,
					title = cd
				},
				func = k0,
				tooltipTitle = cd
			})
		end;
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	function AutoHelp.PopupFoodListMenu(kp, kl, Bl, Bo)
		local function k0(B7, im)
			if im.key == nil then
				if Bo then
					kl:SetText("选择食物")
				else
					kl:SetText("选择喝水")
				end;
				SetConfig(Bl, nil)
			else
				kl:SetText(string.sub(im.title, 1, 12))
				SetConfig(Bl, im.key)
			end;
			HideUIPanel(jl)
		end;
		local Bn = jy(Bl)
		local AT = AutoHelp.GetAllBagsFoods()
		local B7 = {}
		tinsert(B7, {
			text = kp,
			notCheckable = true,
			isTitle = true
		})
		for cd, kq in pairs(AT) do
			table.insert(B7, {
				text = cd,
				checked = cd == Bn,
				arg1 = {
					button = kl,
					key = kq,
					title = cd
				},
				func = k0,
				tooltipTitle = cd
			})
		end;
		table.insert(B7, {
			text = "\124cfff00000清除选择\124r",
			checked = false,
			arg1 = {
				button = kl,
				key = nil,
				title = "清除选择"
			},
			func = k0
		})
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	function AutoHelp.PopupBattleListMenu(kp, Bk, Bl, kl, AT, Bm)
		local function k0(B7, im)
			kl:SetText(im.title)
			SetConfig(Bl .. "_TITLE", im.title)
			SetConfig(Bl, im.key)
			HideUIPanel(jl)
		end;
		local Bn = jy(Bl, Bm)
		local fZ = false;
		for _, p in ipairs(AT) do
			if p == Bn then
				fZ = true;
				break
			end
		end;
		if not fZ then
			Bn = "无"
		end;
		local B7 = {}
		tinsert(B7, {
			text = kp,
			notCheckable = true,
			isTitle = true
		})
		for _, p in ipairs(AT) do
			table.insert(B7, {
				text = p,
				checked = p == Bn,
				arg1 = {
					button = kl,
					key = p,
					title = p
				},
				func = k0,
				tooltipTitle = p,
				tooltipText = p
			})
		end;
		local p = "组队战场"
		table.insert(B7, {
			text = p,
			checked = p == Bn,
			arg1 = {
				button = kl,
				key = p,
				title = p
			},
			func = k0,
			tooltipTitle = p,
			tooltipText = "组队战场，由队长排队，并自动进出战场。"
		})
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	function AutoHelp.GetMaxKeyLevel(p)
		local cf = 0;
		for i = 1, 20 do
			if AutoHelp.HasActionKey(p .. i) then
				cf = i
			else
				break
			end
		end;
		if cf == 0 and AutoHelp.HasActionKey(p) then
			return - 1
		end;
		return cf
	end;
	local function Bp(kl, Bq, Br, Bs)
		local function Bt(cd, p)
			local Bu = jy(cd, {})
			for i, hK in ipairs(Bu) do
				if hK == p then
					return true
				end
			end;
			return false
		end;
		local function Bv(cd, p)
			if Bt(cd, p) then
				return true
			end;
			for i = 1, 20 do
				if Bt(cd, p .. i) then
					return true
				end
			end;
			return false
		end;
		local function Bw(cd, p)
			local Bu = jy(cd, {})
			for i, hK in ipairs(Bu) do
				if hK == p then
					table.remove(Bu, i)
					SetConfig(cd, Bu)
					SetConfig(cd .. "_" .. jy("HEALMODE"), Bu)
					return
				end
			end;
			table.insert(Bu, p)
			SetConfig(cd, Bu)
			SetConfig(cd .. "_" .. jy("HEALMODE"), Bu)
		end;
		local function Bx(B7, im, f9, jI)
			Bw("HEALKEYS", im.key)
			SetConfig("HEAL_STATUS_AUTOCHOOSE", true)
		end;
		local function By(B7, im)
			Bw("MOVEHEALKEYS", im.key)
		end;
		local function Bz(B7, im)
			SetConfig("OverHealType", im.type)
			SetConfig("OverHealValue", im.value)
			AutoHelp.Debug("设置过量阈值为：" .. im.title)
		end;
		local function BA(B7, im)
			Bw("ATTACKKEYS", im.key)
		end;
		local function BB()
			SetConfig("HEALKEYS", AutoHelp["HEALKEYS_" .. jy("HEALMODE")])
			SetConfig("HEALKEYS_" .. jy("HEALMODE"), AutoHelp["HEALKEYS_" .. jy("HEALMODE")])
			SetConfig("MOVEHEALKEYS", AutoHelp["MOVEHEALKEYS_" .. jy("HEALMODE")])
			SetConfig("MOVEHEALKEYS_" .. jy("HEALMODE"), AutoHelp["MOVEHEALKEYS_" .. jy("HEALMODE")])
		end;
		local B7 = {}
		tinsert(B7, {
			text = "站位法术",
			notCheckable = true,
			isTitle = true
		})
		local n5, md = AutoHelp.GetSpellBooks()
		for _, p in ipairs(Bq) do
			if AutoHelp.SplitSubSpell then
				local bq = md[p]
				local BC = false;
				if AutoHelp.GetActionKey(p .. 1) then
					BC = true
				end;
				if BC then
					local jk = {}
					for i = 1, # bq - 1 do
						action = AutoHelp.GetAction(p .. tostring(i))
						if action then
							local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
							table.insert(jk, {
								text = kp,
								isNotRadio = true,
								checked = Bt("HEALKEYS", action["name"]),
								tooltipTitle = action["spellName"],
								tooltipText = AutoHelp.GetSpellTooltip(action["spellId"]),
								arg1 = {
									level = i,
									button = kl,
									key = action["name"],
									title = action["spellName"]
								},
								keepShownOnClick = true,
								func = Bx
							})
						end
					end;
					local action = AutoHelp.GetAction(p)
					if action then
						local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. p;
						table.insert(B7, {
							text = kp,
							notCheckable = true,
							keepShownOnClick = true,
							hasArrow = true,
							menuList = jk
						})
					end
				else
					local action = AutoHelp.GetAction(p)
					if action then
						local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
						table.insert(B7, {
							text = kp,
							isNotRadio = true,
							checked = Bt("HEALKEYS", action["name"]),
							arg1 = {
								level = i,
								button = kl,
								key = action["name"],
								title = action["spellName"]
							},
							keepShownOnClick = true,
							func = Bx,
							tooltipTitle = action["spellName"],
							tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
						})
					end
				end
			else
				local action = AutoHelp.GetAction(p)
				if action then
					local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
					table.insert(B7, {
						text = kp,
						isNotRadio = true,
						checked = Bt("HEALKEYS", action["name"]),
						arg1 = {
							level = i,
							button = kl,
							key = action["name"],
							title = action["spellName"]
						},
						keepShownOnClick = true,
						func = Bx,
						tooltipTitle = action["spellName"],
						tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
					})
				end
			end
		end;
		if Br and # Br > 0 then
			local BD = {}
			for _, p in ipairs(Br) do
				if AutoHelp.SplitSubSpell then
					local bq = md[p]
					local BC = false;
					if AutoHelp.GetActionKey(p .. 1) then
						BC = true
					end;
					if BC then
						local jk = {}
						for i = 1, # bq - 1 do
							local action = AutoHelp.GetAction(p .. tostring(i))
							if action then
								local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
								table.insert(jk, {
									text = kp,
									isNotRadio = true,
									checked = Bt("MOVEHEALKEYS", action["name"]),
									arg1 = {
										level = i,
										button = kl,
										key = action["name"],
										title = action["spellName"]
									},
									keepShownOnClick = true,
									func = By,
									tooltipTitle = action["spellName"],
									tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
								})
							end
						end;
						local action = AutoHelp.GetAction(p)
						if action then
							local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. p;
							table.insert(BD, {
								text = kp,
								notCheckable = true,
								keepShownOnClick = true,
								hasArrow = true,
								menuList = jk
							})
						end
					else
						local action = AutoHelp.GetAction(p)
						if action then
							local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
							table.insert(BD, {
								text = kp,
								isNotRadio = true,
								checked = Bt("MOVEHEALKEYS", action["name"]),
								arg1 = {
									level = i,
									button = kl,
									key = action["name"],
									title = action["spellName"]
								},
								keepShownOnClick = true,
								func = By,
								tooltipTitle = action["spellName"],
								tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
							})
						end
					end
				else
					local action = AutoHelp.GetAction(p)
					if action then
						local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
						table.insert(BD, {
							text = kp,
							isNotRadio = true,
							checked = Bt("MOVEHEALKEYS", action["name"]),
							arg1 = {
								level = i,
								button = kl,
								key = action["name"],
								title = action["spellName"]
							},
							keepShownOnClick = true,
							func = By,
							tooltipTitle = action["spellName"],
							tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
						})
					end
				end
			end;
			if # BD > 0 then
				tinsert(B7, {
					text = "",
					notCheckable = true,
					isTitle = true
				})
				tinsert(B7, {
					text = "移动法术",
					notCheckable = true,
					isTitle = true
				})
				for _, BE in ipairs(BD) do
					table.insert(B7, BE)
				end
			end
		end;
		if Bs and # Bs > 0 then
			local BF = {}
			for _, p in ipairs(Bs) do
				local action = AutoHelp.GetAction(p)
				if action then
					local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. GetSpellInfo(action["spellId"])
					table.insert(BF, {
						text = kp,
						isNotRadio = true,
						checked = Bt("ATTACKKEYS", action["name"]),
						arg1 = {
							level = i,
							button = kl,
							key = action["name"],
							title = action["spellName"]
						},
						keepShownOnClick = true,
						func = BA,
						tooltipTitle = action["spellName"],
						tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
					})
				end
			end;
			tinsert(B7, {
				text = "",
				notCheckable = true,
				isTitle = true
			})
			tinsert(B7, {
				text = "攻击性技能",
				notCheckable = true,
				isTitle = true
			})
			for _, BE in ipairs(BF) do
				table.insert(B7, BE)
			end
		end;
		local BG = jy("OverHealValue", 100)
		local BH = jy("OverHealType", "OVERHEALNORMAL")
		local BI = "\124cff00ff00控蓝模式(75%)\124r"
		local BJ = "\124cff00ff00智能控蓝设置\124r"
		local BK = "自动设定智能加血系数为75%，使用更低一等级治疗法术加血\n\n\124cff00ff00对于预期长时间战斗，可选择此项，用更低一等级的治疗法术加血，最大限度减少过量及控蓝\n由于智能加血未计算暴击带来的过量，本选项适合高暴击骑士加血\124r"
		local BL = "\124cffFFF569精准模式(100%)\124r"
		local BM = "\124cffFFF569智能精准设置\124r"
		local BN = "自动设定智能加血系数为100%，使用更准确的治疗法术保证加血少过量最大化治疗\n\n\124cff00ff00用最合适的治疗法术未计算暴击带来的过量，正常的过量及适度的战斗时长选择此项\124r"
		local BO = "\124cfff00000过量模式(125%)\124r"
		local BP = "\124cfff00000智能过量设置\124r"
		local BQ = "自动设定智能加血系数为125%，使用更高一等级治疗法术加血\n\n\124cff00ff00过量适合短时间高负荷战斗，以及未可言的时刻用来毛过量比例\124r"
		local BR = {
			{
				text = BI,
				isNotRadio = true,
				checked = BH == "OVERHEALLESSER",
				arg1 = {
					title = BI,
					type = "OVERHEALLESSER",
					value = 75
				},
				func = Bz,
				tooltipTitle = BJ,
				tooltipText = BK
			},
			{
				text = BL,
				isNotRadio = true,
				checked = BH == "OVERHEALNORMAL",
				arg1 = {
					title = BL,
					type = "OVERHEALNORMAL",
					value = 100
				},
				func = Bz,
				tooltipTitle = BM,
				tooltipText = BN
			},
			{
				text = BO,
				isNotRadio = true,
				checked = BH == "OVERLHEALMORE",
				arg1 = {
					title = BO,
					type = "OVERLHEALMORE",
					value = 125
				},
				func = Bz,
				tooltipTitle = BP,
				tooltipText = BQ
			}
		}
		tinsert(B7, {
			text = "",
			notCheckable = true,
			isTitle = true
		})
		tinsert(B7, {
			text = "\124cff69CCF0恢复缺省技能\124r",
			notCheckable = true,
			func = function()
				BB()
			end
		})
		tinsert(B7, {
			text = "",
			notCheckable = true,
			isTitle = true
		})
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 80, - 20, "MENU", 2)
	end;
	local function BS(kl, Bq, Br, Bs)
		local function Bt(cd, p)
			local Bu = jy(cd, {})
			for i, hK in ipairs(Bu) do
				if hK == p then
					return true
				end
			end;
			return false
		end;
		local function Bv(cd, p)
			if Bt(cd, p) then
				return true
			end;
			for i = 1, 20 do
				if Bt(cd, p .. i) then
					return true
				end
			end;
			return false
		end;
		local function Bw(cd, p)
			local Bu = jy(cd, {})
			for i, hK in ipairs(Bu) do
				if hK == p then
					table.remove(Bu, i)
					SetConfig(cd, Bu)
					SetConfig(cd .. "_" .. jy("HEALMODE"), Bu)
					return
				end
			end;
			table.insert(Bu, p)
			SetConfig(cd, Bu)
			SetConfig(cd .. "_" .. jy("HEALMODE"), Bu)
		end;
		local function Bx(B7, im, f9, jI)
			Bw("HEALKEYS", im.key)
			SetConfig("HEAL_STATUS_AUTOCHOOSE", true)
		end;
		local function By(B7, im)
			Bw("MOVEHEALKEYS", im.key)
		end;
		local function Bz(B7, im)
			SetConfig("OverHealType", im.type)
			SetConfig("OverHealValue", im.value)
			AutoHelp.Debug("设置过量阈值为：" .. im.title)
		end;
		local function BA(B7, im)
			Bw("ATTACKKEYS", im.key)
		end;
		local function BB()
			SetConfig("HEALKEYS", AutoHelp["HEALKEYS_" .. jy("HEALMODE")])
			SetConfig("HEALKEYS_" .. jy("HEALMODE"), AutoHelp["HEALKEYS_" .. jy("HEALMODE")])
			SetConfig("MOVEHEALKEYS", AutoHelp["MOVEHEALKEYS_" .. jy("HEALMODE")])
			SetConfig("MOVEHEALKEYS_" .. jy("HEALMODE"), AutoHelp["MOVEHEALKEYS_" .. jy("HEALMODE")])
		end;
		local B7 = {}
		tinsert(B7, {
			text = "站位法术",
			notCheckable = true,
			isTitle = true
		})
		for _, p in ipairs(Bq) do
			local BT = AutoHelp.GetMaxKeyLevel(p)
			if BT >= 1 then
				local jk = {}
				for i = 1, BT do
					action = AutoHelp.GetAction(p .. tostring(i))
					local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
					table.insert(jk, {
						text = kp,
						isNotRadio = true,
						checked = Bt("HEALKEYS", action["name"]),
						tooltipTitle = action["spellName"],
						tooltipText = AutoHelp.GetSpellTooltip(action["spellId"]),
						arg1 = {
							level = i,
							button = kl,
							key = action["name"],
							title = action["spellName"]
						},
						keepShownOnClick = true,
						func = Bx
					})
				end;
				local action = AutoHelp.GetAction(p .. tostring(BT))
				local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. GetSpellInfo(action["spellId"])
				table.insert(B7, {
					text = kp,
					checked = Bv("HEALKEYS", p),
					keepShownOnClick = true,
					hasArrow = true,
					menuList = jk
				})
			end;
			if BT == - 1 then
				action = AutoHelp.GetAction(p)
				local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. GetSpellInfo(action["spellId"])
				table.insert(B7, {
					text = kp,
					isNotRadio = true,
					checked = Bt("HEALKEYS", action["name"]),
					arg1 = {
						level = i,
						button = kl,
						key = action["name"],
						title = action["spellName"]
					},
					keepShownOnClick = true,
					func = Bx,
					tooltipTitle = action["spellName"],
					tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
				})
			end
		end;
		if Br and # Br > 0 then
			local BD = {}
			for _, p in ipairs(Br) do
				local BT = AutoHelp.GetMaxKeyLevel(p)
				if BT >= 1 then
					local jk = {}
					for i = 1, BT do
						action = AutoHelp.GetAction(p .. tostring(i))
						local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. action["spellName"]
						table.insert(jk, {
							text = kp,
							isNotRadio = true,
							checked = Bt("MOVEHEALKEYS", action["name"]),
							arg1 = {
								level = i,
								button = kl,
								key = action["name"],
								title = action["spellName"]
							},
							keepShownOnClick = true,
							func = By,
							tooltipTitle = action["spellName"],
							tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
						})
					end;
					local action = AutoHelp.GetAction(p .. tostring(BT))
					local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. GetSpellInfo(action["spellId"])
					table.insert(BD, {
						text = kp,
						checked = Bv("MOVEHEALKEYS", p),
						keepShownOnClick = true,
						hasArrow = true,
						menuList = jk
					})
				end;
				if BT == - 1 then
					action = AutoHelp.GetAction(p)
					local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. GetSpellInfo(action["spellId"])
					table.insert(BD, {
						text = kp,
						isNotRadio = true,
						checked = Bt("MOVEHEALKEYS", action["name"]),
						arg1 = {
							level = i,
							button = kl,
							key = action["name"],
							title = action["spellName"]
						},
						keepShownOnClick = true,
						func = By,
						tooltipTitle = action["spellName"],
						tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
					})
				end
			end;
			if # BD > 0 then
				tinsert(B7, {
					text = "",
					notCheckable = true,
					isTitle = true
				})
				tinsert(B7, {
					text = "移动法术",
					notCheckable = true,
					isTitle = true
				})
				for _, BE in ipairs(BD) do
					table.insert(B7, BE)
				end
			end
		end;
		if Bs and # Bs > 0 then
			local BF = {}
			for _, p in ipairs(Bs) do
				action = AutoHelp.GetAction(p)
				if action then
					local kp = "\124T" .. action["icon"] .. ":12:12\124t " .. GetSpellInfo(action["spellId"])
					table.insert(BF, {
						text = kp,
						isNotRadio = true,
						checked = Bt("ATTACKKEYS", action["name"]),
						arg1 = {
							level = i,
							button = kl,
							key = action["name"],
							title = action["spellName"]
						},
						keepShownOnClick = true,
						func = BA,
						tooltipTitle = action["spellName"],
						tooltipText = AutoHelp.GetSpellTooltip(action["spellId"])
					})
				end
			end;
			tinsert(B7, {
				text = "",
				notCheckable = true,
				isTitle = true
			})
			tinsert(B7, {
				text = "攻击性技能",
				notCheckable = true,
				isTitle = true
			})
			for _, BE in ipairs(BF) do
				table.insert(B7, BE)
			end
		end;
		local BG = jy("OverHealValue", 100)
		local BH = jy("OverHealType", "OVERHEALNORMAL")
		local BI = "\124cff00ff00控蓝模式(75%)\124r"
		local BJ = "\124cff00ff00智能控蓝设置\124r"
		local BK = "自动设定智能加血系数为75%，使用更低一等级治疗法术加血\n\n\124cff00ff00对于预期长时间战斗，可选择此项，用更低一等级的治疗法术加血，最大限度减少过量及控蓝\n由于智能加血未计算暴击带来的过量，本选项适合高暴击骑士加血\124r"
		local BL = "\124cffFFF569精准模式(100%)\124r"
		local BM = "\124cffFFF569智能精准设置\124r"
		local BN = "自动设定智能加血系数为100%，使用更准确的治疗法术保证加血少过量最大化治疗\n\n\124cff00ff00用最合适的治疗法术未计算暴击带来的过量，正常的过量及适度的战斗时长选择此项\124r"
		local BO = "\124cfff00000过量模式(125%)\124r"
		local BP = "\124cfff00000智能过量设置\124r"
		local BQ = "自动设定智能加血系数为125%，使用更高一等级治疗法术加血\n\n\124cff00ff00过量适合短时间高负荷战斗，以及未可言的时刻用来毛过量比例\124r"
		local BR = {
			{
				text = BI,
				isNotRadio = true,
				checked = BH == "OVERHEALLESSER",
				arg1 = {
					title = BI,
					type = "OVERHEALLESSER",
					value = 75
				},
				func = Bz,
				tooltipTitle = BJ,
				tooltipText = BK
			},
			{
				text = BL,
				isNotRadio = true,
				checked = BH == "OVERHEALNORMAL",
				arg1 = {
					title = BL,
					type = "OVERHEALNORMAL",
					value = 100
				},
				func = Bz,
				tooltipTitle = BM,
				tooltipText = BN
			},
			{
				text = BO,
				isNotRadio = true,
				checked = BH == "OVERLHEALMORE",
				arg1 = {
					title = BO,
					type = "OVERLHEALMORE",
					value = 125
				},
				func = Bz,
				tooltipTitle = BP,
				tooltipText = BQ
			}
		}
		tinsert(B7, {
			text = "",
			notCheckable = true,
			isTitle = true
		})
		tinsert(B7, {
			text = "\124cff69CCF0恢复缺省技能\124r",
			notCheckable = true,
			func = function()
				BB()
			end
		})
		tinsert(B7, {
			text = "",
			notCheckable = true,
			isTitle = true
		})
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		GameTooltip:Hide()
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 80, - 20, "MENU", 2)
	end;
	function AutoHelp.PopupMoreLevelListMenu(kl, Bq, Br, Bs)
		if AutoHelp.isWotlk then
			BS(kl, Bq, Br, Bs)
		else
			Bp(kl, Bq, Br, Bs)
		end
	end;
	local BU;
	function AutoHelp.PopupModeListMenu(kl, kn, BV, BW)
		local function k0(B7, im)
			if im.mode ~= nil then
				SetConfig("HEALMODE", im.mode)
				if AutoHelp.ModeChanged then
					AutoHelp.ModeChanged(im.mode)
				end
			end;
			HideUIPanel(jl)
		end;
		local B7 = {}
		for i = 1, # kn do
			if not kn[i].isTitle and not kn[i].hasArrow then
				kn[i].isNotRadio = true;
				kn[i].checked = BV == kn[i].name;
				kn[i].arg1 = {
					mode = kn[i].name,
					button = kl
				}
				kn[i].func = k0
			end;
			if kn[i].menuList then
				local jk = kn[i].menuList;
				for m9 = 1, # jk do
					jk[m9].isNotRadio = true;
					jk[m9].checked = BV == jk[m9].name;
					jk[m9].arg1 = {
						mode = jk[m9].name,
						button = kl
					}
					jk[m9].func = k0
				end
			end
		end;
		if not BU then
			tinsert(kn, {
				text = "关闭菜单",
				notCheckable = true,
				func = function()
					HideUIPanel(jl)
				end
			})
			BU = true
		end;
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(kn, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	function AutoHelp.PopupMainHandEquipsMenu(kl, BX)
		local function k0(B7, im)
			if not BX then
				SetConfig("MainHandItem", im.itemName)
				SetConfig("MainHandIcon", im.itemIcon)
			else
				SetConfig("OffHandItem", im.itemName)
				SetConfig("OffHandIcon", im.itemIcon)
			end;
			kl:SetText("\124T" .. im.itemIcon .. ":12:12\124t " .. string.sub(im.itemName, 1, 21))
			HideUIPanel(jl)
		end;
		local B7 = {}
		local BY;
		local BZ;
		if BX then
			BZ = jy("OffHandItem")
			BY = AutoHelp.GetOffHandEquipments()
		else
			BZ = jy("MainHandItem")
			BY = AutoHelp.GetMainHandEquipments()
		end;
		for i = 1, # BY do
			local kp = "\124T" .. BY[i].itemIcon .. ":12:12\124t " .. BY[i].itemName;
			tinsert(B7, {
				text = kp,
				isNotRadio = true,
				checked = BZ == BY[i].itemName,
				arg1 = {
					itemIcon = BY[i].itemIcon,
					itemName = BY[i].itemName
				},
				func = k0
			})
		end;
		tinsert(B7, {
			text = "关闭菜单",
			notCheckable = true,
			func = function()
				HideUIPanel(jl)
			end
		})
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 100, - 20, "MENU", 2)
	end;
	local B_ = {}
	local C0 = {}
	local C1 = {}
	local C2 = {}
	local C3 = {}
	local C4 = {}
	local C5 = {}
	local C6 = {}
	local C7 = {}
	local C8 = {}
	local function C9()
		if not AutoHelp.HEAL_SPELL_LIST then
			table.wipe(B_)
			table.wipe(C0)
			table.wipe(C1)
			table.wipe(C2)
			table.wipe(C3)
			table.wipe(C4)
			table.wipe(C5)
			table.wipe(C6)
			table.wipe(C7)
			table.wipe(C8)
			local function Ca(p)
				if AutoHelp.HasActionKey(p) then
					table.insert(B_, p)
				end
			end;
			local function Cb(p)
				if AutoHelp.HasActionKey(p) then
					table.insert(C4, p)
				end
			end;
			if GetStatus("HEAL_STATUS_ONEHEAL") then
				Ca(jy("ONEHEALKEY"))
			end;
			if GetStatus("HEAL_STATUS_AUTOCHOOSE") then
				local Cc = jy("HEALKEYS", AutoHelp.HEAL_MODES[AutoHelp.DefaultMode]["HEALKEYS"])
				if not Cc or # Cc == 0 then
					Cc = AutoHelp.HEAL_MODES[AutoHelp.DefaultMode]["HEALKEYS"]
				end;
				if Cc then
					for i = 1, # Cc do
						Ca(Cc[i])
					end
				end
			end;
			if GetStatus("HEAL_STATUS_AUTOCHOOSE") then
				local Cc = jy("MOVEHEALKEYS", AutoHelp.HEAL_MODES[AutoHelp.DefaultMode]["MOVEHEALKEYS"])
				if not Cc or # Cc == 0 then
					Cc = AutoHelp.HEAL_MODES[AutoHelp.DefaultMode]["MOVEHEALKEYS"]
				end;
				if Cc then
					for i = 1, # Cc do
						Cb(Cc[i])
					end
				end
			end;
			if # B_ > 0 then
				table.sort(B_, function(rL, rM)
					local Cd = AutoHelp.GetAction(rL)
					local Ce = AutoHelp.GetAction(rM)
					if not Cd or not Cd["baseHealAmount"] then
						return false
					end;
					if not Ce or not Ce["baseHealAmount"] then
						return true
					end;
					return Cd["baseHealAmount"] > Ce["baseHealAmount"]
				end)
			end;
			for i = 1, # B_ do
				local action = AutoHelp.GetAction(B_[i])
				local Cf = action["healType"]
				if Cf == 1 or Cf == 2 then
					C0[# C0 + 1] = B_[i]
				end;
				if Cf == 3 then
					C1[# C1 + 1] = B_[i]
				end;
				if Cf == 4 then
					C2[# C2 + 1] = B_[i]
				end;
				if Cf == 5 then
					C3[# C3 + 1] = B_[i]
				end
			end;
			if # C4 > 0 then
				table.sort(C4, function(rL, rM)
					local Cd = AutoHelp.GetAction(rL)
					local Ce = AutoHelp.GetAction(rM)
					if not Cd or not Cd["baseHealAmount"] then
						return false
					end;
					if not Ce or not Ce["baseHealAmount"] then
						return true
					end;
					return Cd["baseHealAmount"] > Ce["baseHealAmount"]
				end)
			end;
			for i = 1, # C4 do
				local action = AutoHelp.GetAction(C4[i])
				local Cf = action["healType"]
				if Cf == 1 or Cf == 2 then
					C5[# C5 + 1] = C4[i]
				end;
				if Cf == 3 then
					C6[# C6 + 1] = C4[i]
				end;
				if Cf == 4 then
					C7[# C7 + 1] = C4[i]
				end;
				if Cf == 5 then
					C8[# C8 + 1] = C4[i]
				end
			end;
			if GetStatus("STATUS_治疗模式") then
				if # B_ >= 1 then
					AutoHelp.Debug("\124cffFFF569=施法技能====治疗量=魔法==HPM=\124r")
					for i = 1, # B_ do
						local action = AutoHelp.GetAction(B_[i])
						local Cg = action["baseHealAmount"]
						if not Cg then
							Cg = 0
						end;
						AutoHelp.Debug(fmttxt(action["spellName"], 28) .. "\124cffF58CBA" .. fmttxt(tostring(Cg), 8) .. "\124cff00ff00" .. fmttxt(action["powerCost"], 10) .. "\124r\124cffFFF569" .. fmttxt(string.format("%.2f", Cg / action["powerCost"]), 15) .. "\124r")
					end
				end;
				if # C4 >= 1 then
					AutoHelp.Debug("\124cffFFF569=瞬发技能=====治疗量=魔法==HPM=\124r")
					for i = 1, # C4 do
						local action = AutoHelp.GetAction(C4[i])
						local Cg = action["baseHealAmount"]
						if not Cg then
							Cg = 0
						end;
						if action["powerCost"] == 0 then
							AutoHelp.Debug(fmttxt(action["spellName"], 28) .. "\124cffF58CBA" .. fmttxt(tostring(Cg), 8) .. "\124cff00ff00" .. fmttxt("-", 10) .. "\124r\124cffFFF569" .. fmttxt("-", 15) .. "\124r")
						else
							AutoHelp.Debug(fmttxt(action["spellName"], 28) .. "\124cffF58CBA" .. fmttxt(tostring(Cg), 8) .. "\124cff00ff00" .. fmttxt(action["powerCost"], 10) .. "\124r\124cffFFF569" .. fmttxt(string.format("%.2f", Cg / action["powerCost"]), 15) .. "\124r")
						end
					end
				end;
				AutoHelp.HEAL_SPELL_LIST = B_
			end
		end;
		return AutoHelp.HEAL_SPELL_LIST
	end;
	function AutoHelp.RecalcSmartHealList()
		if AutoHelp.CAN_HEAL then
			AutoHelp.HEAL_SPELL_LIST = nil;
			AutoHelp.HEAL_SPELL_LIST = C9()
		end
	end;
	local function Ch()
		local Ci = GetStatusNumber("OverHealValue") or 100;
		if not Ci or Ci < 50 or Ci > 150 then
			Ci = 100;
			SetConfig("OverHealValue", Ci)
		end;
		return Ci / 100
	end;
	function AutoHelp.GetHealingAction(tInfo)
		if AutoHelp.isRetail then
			return nil
		end;
		local mT, mS = tInfo["ahp"], tInfo["alost"]
		local Cj = Ch()
		local Ck = mS * Cj;
		local Cl = C9()
		if # Cl == 1 then
			if AutoHelp.CanUseAction(tInfo, Cl[# Cl]) then
				return Cl[# Cl]
			end
		end;
		local ra = HEAL_RAID_ATTACKED_UNITS[tInfo["unit"]]
		if ra and # C2 > 0 then
			for i = 1, # C2 do
				local p = C2[i]
				local action = AutoHelp.GetAction(p)
				if AutoHelp.CanUseAction(tInfo, p) then
					return p
				end
			end
		end;
		if not ra and # C1 > 0 then
			for i = 1, # C1 do
				local p = C1[i]
				local action = AutoHelp.GetAction(p)
				local bN = AutoHelp.CalcHealAmount(action, tInfo)
				if bN > 0 then
					bN = bN * 0.8
				end;
				if bN < Ck * 1.25 then
					if AutoHelp.CanUseAction(tInfo, p) then
						return p
					end
				end
			end
		end;
		if # C0 > 0 then
			local Cm = nil;
			for i = 1, # C0 do
				local p = C0[i]
				if AutoHelp.CanUseAction(tInfo, p) then
					Cm = p;
					local action = AutoHelp.GetAction(p)
					local bN = AutoHelp.CalcHealAmount(action, tInfo)
					if bN <= Ck * 1.1 then
						return p
					end
				end
			end;
			if Cm then
				return Cm
			end
		end;
		if AutoHelp.LastHealTeamAction and # AutoHelp.LastHealTeamAction > 0 then
			for i = 1, # AutoHelp.LastHealTeamAction do
				local p = AutoHelp.LastHealTeamAction[i]
				if AutoHelp.HasStopMoveKey(p) and AutoHelp.CanUseAction(tInfo, p) then
					return p
				end
			end
		end
	end;
	function AutoHelp.GetMoveHealingAction(tInfo)
		if AutoHelp.isRetail then
			return nil
		end;
		local mT, mS = tInfo["ahp"], tInfo["alost"]
		local Cj = Ch()
		local Ck = mS * Cj;
		local Cl = C4;
		local Cn = min(ceil(tInfo["healthmax"] * 0.15), 100)
		if AutoHelp.isWotlk then
			if AutoHelp.playerClass == "PALADIN" then
				if AutoHelp.UnitHasBuff("player", "圣光灌注") then
					if AutoHelp.CanUseAction(tInfo, "圣光闪现") then
						return "圣光闪现"
					end
				end;
				if AutoHelp.CanUseAction(tInfo, "神圣震击") then
					return "神圣震击"
				end
			end
		end;
		if # Cl == 1 then
			if AutoHelp.CanUseAction(tInfo, Cl[# Cl]) then
				return Cl[# Cl]
			end
		end;
		local ra = HEAL_RAID_ATTACKED_UNITS[tInfo["unit"]]
		if ra and # C7 > 0 then
			for i = 1, # C7 do
				local p = C7[i]
				local action = AutoHelp.GetAction(p)
				if AutoHelp.CanUseAction(tInfo, p) then
					return p
				end
			end
		end;
		if not ra and # C6 > 0 then
			for i = 1, # C6 do
				local p = C6[i]
				local action = AutoHelp.GetAction(p)
				local bN = AutoHelp.CalcHealAmount(action, tInfo)
				if bN + Cn > Ck and bN - Cn < Ck or bN < Ck or i == # C6 then
					if AutoHelp.CanUseAction(tInfo, p) then
						return p
					end
				end
			end
		end;
		if # C5 > 0 then
			for i = 1, # C5 do
				local p = C5[i]
				local action = AutoHelp.GetAction(p)
				local bN = AutoHelp.CalcHealAmount(action, tInfo)
				if bN + Cn > Ck and bN - Cn < Ck or bN < Ck then
					if action["spellTime"] == 0 and AutoHelp.CanUseAction(tInfo, p) then
						return p
					end
				end
			end
		end;
		if AutoHelp.LastMoveHealTeamAction and # AutoHelp.LastMoveHealTeamAction > 0 then
			for i = 1, # AutoHelp.LastMoveHealTeamAction do
				local p = AutoHelp.LastMoveHealTeamAction[i]
				if AutoHelp.HasMoveKey(p) and AutoHelp.CanUseAction(tInfo, p) then
					return p
				end
			end
		end
	end;
	function AutoHelp.HasMoveKey(p)
		local Bu = jy("MOVEHEALKEYS", {})
		for i, hK in ipairs(Bu) do
			if hK == p then
				return true
			end
		end;
		return false
	end;
	function AutoHelp.HasStopMoveKey(p)
		local Bu = jy("HEALKEYS", {})
		for i, hK in ipairs(Bu) do
			if hK == p then
				return true
			end
		end;
		return false
	end;
	local Co = "无"
	local function Cp(re)
		local function Cq(self, im)
			SetConfig(im.unit, im.value)
			HideUIPanel(jl)
		end;
		local function Cr(self, im)
			if im.value == "无" or im.value == "NONE" then
				HEAL_RAID[im.unit]["BUFFTYPE"] = nil
			else
				HEAL_RAID[im.unit]["BUFFTYPE"] = im.value
			end;
			HideUIPanel(jl)
		end;
		local function Cs(self, im)
			SetConfig("TANKBUFFKEY", im.value)
			HideUIPanel(jl)
		end;
		local function Ct(self, im)
			SetConfig("WARRIOR", im.value)
			SetConfig("PALADIN", im.value)
			SetConfig("HUNTER", im.value)
			SetConfig("ROGUE", im.value)
			SetConfig("PRIEST", im.value)
			SetConfig("MAGE", im.value)
			SetConfig("WARLOCK", im.value)
			SetConfig("DRUID", im.value)
			SetConfig("SHAMAN", im.value)
			SetConfig("DEATHKNIGHT", im.value)
			HideUIPanel(jl)
		end;
		local Cu = AutoHelp.ClassBuffList;
		local B7 = {}
		local Cv = {}
		for i = 1, # Cu do
			Cv[i] = {
				text = Cu[i]["title"],
				notCheckable = true,
				arg1 = {
					value = Cu[i]["name"]
				},
				func = Ct
			}
		end;
		tinsert(B7, {
			text = "所有职业祝福设置",
			notCheckable = true,
			hasArrow = true,
			menuList = Cv
		})
		local Cw = {}
		local jS = 1;
		for i = 1, # Cu do
			if not Cu[i]["ispower"] then
				Cw[jS] = {
					text = Cu[i]["title"],
					checked = Co == Cu[i]["name"],
					arg1 = {
						value = Cu[i]["name"]
					},
					func = Cs
				}
				jS = jS + 1
			end
		end;
		tinsert(B7, {
			text = "坦克祝福设置(" .. Co .. ")",
			notCheckable = true,
			hasArrow = true,
			menuList = Cw
		})
		tinsert(B7, {
			text = "当前职业祝福设置",
			notCheckable = true,
			isTitle = true
		})
		for i = 1, # Cu, 1 do
			tinsert(B7, {
				text = Cu[i]["title"],
				checked = Cu[i]["name"] == AutoHelp.HEAL_CLASSBUFF_LIST[re],
				arg1 = {
					value = Cu[i]["name"],
					unit = re
				},
				func = Cq
			})
		end;
		local Cx = false;
		for oz, tInfo in pairs(HEAL_RAID) do
			if tInfo["class"] == re then
				if Cx == false then
					Cx = true;
					tinsert(B7, {
						text = "单独设置队员祝福",
						notCheckable = true,
						isTitle = true
					})
				end;
				local Be = {}
				jS = 1;
				for i = 1, # Cu do
					if not Cu[i]["ispower"] then
						Be[jS] = {
							text = Cu[i]["title"],
							checked = tInfo["BUFFTYPE"] == Cu[i]["name"],
							arg1 = {
								value = Cu[i]["name"],
								unit = oz
							},
							func = Cr
						}
						jS = jS + 1
					end
				end;
				local cd = tInfo["name"]
				if tInfo["BUFFTYPE"] ~= nil then
					cd = cd .. "(" .. tInfo["BUFFTYPE"] .. ")"
				end;
				tinsert(B7, {
					text = cd,
					hasArrow = true,
					menuList = Be
				})
			end
		end;
		jl = CreateFrame("Frame", "BuffMenuFrame", UIParent, "UIDropDownMenuTemplate")
		EasyMenu(B7, jl, "cursor", - 50, - 20, "MENU", 1)
	end;
	local function Cy()
		local function Cz(h4, hK)
			if hK == 0 then
				Cp(h4)
			else
				if AutoHelp.ClassBuffList[hK] then
					AutoHelp.HEAL_CLASSBUFF_LIST[h4] = hK
				else
					AutoHelp.HEAL_CLASSBUFF_LIST[h4] = hK
				end;
				for oz, tInfo in pairs(HEAL_RAID) do
					if tInfo["class"] == h4 then
						if tInfo["role"] == "MAINTANK" and Co ~= "无" then
							tInfo["BUFFTYPE"] = Co
						else
							tInfo["BUFFTYPE"] = nil
						end
					end
				end
			end
		end;
		jB("TANKBUFFKEY", function(hK)
			TANKBUFFNO = hK;
			for oz, tInfo in pairs(HEAL_RAID) do
				if tInfo["role"] == "MAINTANK" then
					if hK == 1 then
						tInfo["BUFFTYPE"] = nil
					else
						tInfo["BUFFTYPE"] = Co
					end
				end
			end
		end)
		jB("WARRIOR", function(hK)
			Cz("WARRIOR", hK)
		end)
		jB("PALADIN", function(hK)
			Cz("PALADIN", hK)
		end)
		jB("HUNTER", function(hK)
			Cz("HUNTER", hK)
		end)
		jB("ROGUE", function(hK)
			Cz("ROGUE", hK)
		end)
		jB("PRIEST", function(hK)
			Cz("PRIEST", hK)
		end)
		jB("MAGE", function(hK)
			Cz("MAGE", hK)
		end)
		jB("WARLOCK", function(hK)
			Cz("WARLOCK", hK)
		end)
		jB("DRUID", function(hK)
			Cz("DRUID", hK)
		end)
		jB("SHAMAN", function(hK)
			Cz("SHAMAN", hK)
		end)
		jB("DEATHKNIGHT", function(hK)
			Cz("DEATHKNIGHT", hK)
		end)
	end;
	local CA = false;
	local CB = true;
	local CC = nil;
	local function CD()
		if AutoHelp.playerClass == "PALADIN" then
			Cy()
		end;
		jB("HEAL_STATUS_PROTECTWHISPER", function(hK)
			AutoHelp.IsWhisperProtecer = hK
		end)
		jB("AutoFollowUnit", function(b8)
			local k8 = AutoHelp.SettingItems["HEAL_STATUS_AUTOFOLLOW_BUTTON"]
			if b8 and UnitExists(b8) then
				wQ = b8;
				FollowUnit(b8)
				AutoHelp.Debug("开始自动跟随：" .. b8)
				if k8 then
					k8:SetText("跟随:" .. b8)
				end
			else
				if wQ then
					AutoHelp.Debug("停止自动跟随：" .. wQ)
				end;
				wQ = nil;
				FollowUnit("player")
				if k8 then
					k8:SetText("自动跟随")
				end
			end
		end)
		jB("HEAL_STATUS_TOGGLE_AUTOFOLLOW", function(k8)
			if jy("AutoFollowUnit") then
				SetConfig("AutoFollowUnit", nil)
			else
				local tInfo = GetRaidUnit("target")
				if tInfo and tInfo["unit"] == "player" then
					return
				end;
				if tInfo ~= nil then
					SetConfig("AutoFollowUnit", tInfo["name"])
				end
			end
		end)
		jB("AssistUnit", function(b8)
			local k8 = AutoHelp.SettingItems["HEAL_STATUS_ASSISTUNIT_BUTTON"]
			if b8 and UnitExists(b8) then
				local tInfo = GetRaidUnit(b8)
				AutoHelp.AssistUnit = tInfo["unit"]
				AutoHelp.AssistName = tInfo["name"]
				if k8 then
					k8:SetText("协助:" .. b8)
				end
			else
				if AutoHelp.AssistUnit then
					AutoHelp.Debug("停止协助攻击：" .. AutoHelp.AssistName)
				end;
				AutoHelp.AssistUnit = nil;
				AutoHelp.AssistName = nil;
				if k8 then
					k8:SetText("协助攻击")
				end
			end
		end)
		jB("HEAL_STATUS_TOGGLE_ASSISTUNIT", function(k8)
			if jy("AssistUnit") then
				SetConfig("AssistUnit", nil)
			else
				local tInfo = GetRaidUnit("target")
				if tInfo and tInfo["unit"] == "player" then
					AutoHelp.Debug("不能选择自己协助攻击！")
					return
				end;
				if tInfo ~= nil then
					SetConfig("AssistUnit", tInfo["name"])
				end
			end
		end)
		jB("HEAL_STATUS_SHOWINFOPANEL", function(hK)
			if AutoHelp.InfoPanel then
				if hK then
					AutoHelp.InfoPanel:Show()
				else
					AutoHelp.InfoPanel:Hide()
				end
			end
		end)
		jB("HEAL_STATUS_PAUSE", function(hK)
			if CB then
				CB = false
			end;
			if hK then
				AutoHelp.Debug("\124cfff00000AutoHelp已经暂停使用（小键盘零可以继续运行）！\124r")
				AutoHelp.DoActionIdle("\124cfff00000已经暂停.\124r", "无")
			else
				AutoHelp.Debug("AutoHelp已经开始继续运行（小键盘零可以暂停运行）！")
			end
		end)
		jB("HEAL_STATUS_创建队列宏", function(hK)
			if hK and AutoHelp.AutoCreateMacro then
				AutoHelp.AutoCreateMacro()
				FindOrCreateMacro("暂停切换", 135768, "/run AutoHelp.TogglePause()\n", 51)
				FindOrCreateMacro("隐藏切换", 135763, "/run AutoHelp.ToggleShown()\n")
			end
		end)
		jB("STATUS_目标互动", function(hK)
			if hK then
				SetCVar("AutoInteract", "1")
			else
				SetCVar("AutoInteract", AutoHelp.OrgiAutoInteract)
			end
		end)
		jB("HEALKEYS", function(hK)
			if not hK then
				return
			end;
			local kl = AutoHelp.SettingItems["HEAL_STATUS_MOREHEALBUTTON"]
			if kl then
				kl:SetText("法术(" .. # hK .. "/" .. # jy("MOVEHEALKEYS", {}) .. ")")
			end;
			AutoHelp.RecalcHealList("智能治疗，预估治疗量：")
		end)
		jB("MOVEHEALKEYS", function(hK)
			if not hK then
				return
			end;
			local kl = AutoHelp.SettingItems["HEAL_STATUS_MOREHEALBUTTON"]
			if kl then
				kl:SetText("法术(" .. # jy("HEALKEYS", {}) .. "/" .. # hK .. ")")
			end;
			AutoHelp.RecalcHealList("智能治疗，预估治疗量：")
		end)
		jB("ONEHEALTITLE", function(hK)
			local kl = AutoHelp.SettingItems["HEAL_STATUS_ONEHEALBUTTON"]
			if kl then
				kl:SetText(hK)
			end
		end)
		jB("HEALMODE", function(kH)
			if not kH then
				return
			end;
			local CE = AutoHelp.ModeDefaultSetting;
			local BV = AutoHelp.HEAL_MODES[kH]
			if BV == nil then
				BV = AutoHelp.HEAL_MODES[AutoHelp.DefaultMode]
				SetConfig("HEALMODE", AutoHelp.DefaultMode)
				return
			end;
			local kl = AutoHelp.SettingItems["HealHelpBaseFrametabbtn"]
			if kl then
				kl:SetText(kH)
			end;
			if CC ~= kH then
				CC = kH
			else
				return
			end;
			if jy("TALENTCHANGED") then
				for p, rS in pairs(AutoHelp.HEAL_MODES) do
					SetConfig("HEALKEYS_" .. p, nil)
					SetConfig("MOVEHEALKEYS_" .. p, nil)
				end
			end;
			if CE and BV then
				for al, hK in pairs(CE) do
					if BV[al] == nil then
						BV[al] = CE[al]
					end
				end
			end;
			for al, hK in pairs(BV) do
				if al == "modetip" then
					AutoHelp.Debug(hK)
				else
					if (al == "HEALKEYS" or al == "MOVEHEALKEYS") and BV["STATUS_治疗模式"] then
						local CF = jy(al .. "_" .. jy("HEALMODE"))
						AutoHelp[al .. "_" .. jy("HEALMODE")] = {}
						for _, p in ipairs(hK) do
							if AutoHelp.HasActionKey(p) then
								AutoHelp[al .. "_" .. jy("HEALMODE")][# AutoHelp[al .. "_" .. jy("HEALMODE")] + 1] = p
							end
						end;
						if not CF then
							CF = AutoHelp[al .. "_" .. jy("HEALMODE")]
						end;
						SetConfig(al, CF)
						SetConfig(al .. "_" .. jy("HEALMODE"), CF)
					else
						SetConfig(al, hK)
					end
				end
			end;
			if AutoHelp.ModeChanged then
				AutoHelp.ModeChanged(kH)
			end
		end)
	end;
	local CG = false;
	local CH = time({
		year = 2042,
		month = 12,
		day = 31
	})
	if CH < time() then
	end;
	function AutoHelp:CHAT_MSG_WHISPER(CI, CJ, CK, CL, lY)
		if GetStatus("HEAL_STATUS_AUTOFOLLOW") and lY ~= wY then
			if CI == "自动跟随我" then
				SetConfig("AutoFollowUnit", lY)
				print("自动跟随：" .. lY)
				AutoHelp.AddNextAction(HEAL_RAID["player"], "KEY_STARTFOLLOW", 0)
				HEAL_TIMERS["HEAL_TARGET"] = 0.001
			end;
			if CI == "停止跟随我" then
				SetConfig("AutoFollowUnit", nil)
				print("停止跟随：" .. lY)
				AutoHelp.AddNextAction(HEAL_RAID["player"], "KEY_STOPFOLLOW", 0)
				HEAL_TIMERS["HEAL_TARGET"] = 0.001
			end;
			if CI == "开始AOE" then
				SetConfig("AutoFollowUnit", nil)
				print("设置AOE：" .. lY)
				SetConfig("HEAL_STATUS_AOE", true)
			end;
			if CI == "停止AOE" then
				SetConfig("AutoFollowUnit", nil)
				print("停止AOE：" .. lY)
				SetConfig("HEAL_STATUS_AOE", false)
			end;
			if CI == "逃命跟随我" then
				print("开始跟随逃命: " .. lY)
				SetConfig("AutoFollowUnit", lY)
				SetConfig("STATUS_主动攻击", false)
				SetConfig("HEAL_STATUS_主动开怪", false)
				SetConfig("HEAL_STATUS_主动开怪2", false)
				SetConfig("STATUS_目标互动", false)
				SetConfig("STATUS_自动寻怪", false)
				AutoHelp.AddNextAction(HEAL_RAID["player"], "KEY_STARTFOLLOW", 0)
				HEAL_TIMERS["HEAL_TARGET"] = 0.001
			end;
			if CI == "开始协助我" then
				print("开始协助攻击：" .. lY)
				SetConfig("AutoFollowUnit", lY)
				SetConfig("STATUS_主动攻击", true)
				SetConfig("STATUS_目标互动", true)
				SetConfig("STATUS_自动寻怪", false)
				SetConfig("AssistUnit", lY)
				AutoHelp.AddNextAction(HEAL_RAID["player"], "KEY_STARTFOLLOW", 0)
				HEAL_TIMERS["HEAL_TARGET"] = 0.001
			end;
			if CI == "停止协助我" then
				print("停止协助攻击：" .. lY)
				SetConfig("AutoFollowUnit", nil)
				SetConfig("STATUS_主动攻击", true)
				SetConfig("STATUS_目标互动", false)
				SetConfig("STATUS_自动寻怪", false)
				SetConfig("AssistUnit", nil)
				AutoHelp.AddNextAction(HEAL_RAID["player"], "KEY_SOPTFOLLOW", 0)
				HEAL_TIMERS["HEAL_TARGET"] = 0.001
			end;
			if CI == "自动重载界面" and not InCombatLockdown() then
				AutoHelp.AddNextAction(HEAL_RAID["player"], "reload", 0)
			end;
			if CI == "施放技能" then
				AutoHelp.AddNextAction(HEAL_RAID["player"], CJ, 0)
			end;
			if CI == "设置参数" then
				if lY ~= wY and CJ ~= "" and CK ~= "" then
				end
			end
		end
	end;
	AutoHelp.CHAT_MSG_PARTY = AutoHelp.CHAT_MSG_WHISPER;
	AutoHelp.CHAT_MSG_PARTY_LEADER = AutoHelp.CHAT_MSG_WHISPER;
	AutoHelp.CHAT_MSG_RAID = AutoHelp.CHAT_MSG_WHISPER;
	AutoHelp.CHAT_MSG_RAID_LEADER = AutoHelp.CHAT_MSG_WHISPER;
	local function CM(cd, eu, rx, ry, rz, rA, rB, gs, rC, rD)
		if gs == 576 or gs == 578 or gs == 608 then
			AutoHelp.KillJX = true;
			return
		end;
		if gs == 619 or gs == 601 then
			AutoHelp.KillJX = true;
			return
		end;
		AutoHelp.KillJX = false
	end;
	AutoHelp.IsInUld = false;
	AutoHelp.IsInRaid = false;
	local CN = {
		724,
		631,
		649,
		249,
		603,
		616,
		615,
		533,
		624
	}
	local function CO()
		wP = false;
		local CP = GetMinimapZoneText()
		if CP == "奈法利安的巢穴" then
			AutoHelp.IsInNaiFa = true
		else
			AutoHelp.IsInNaiFa = false
		end;
		local cd, eu, rx, ry, rz, rA, rB, gs, rC, rD = GetInstanceInfo()
		CM(cd, eu, rx, ry, rz, rA, rB, gs, rC, rD)
		if AutoHelp.InstanceChanged then
			AutoHelp.InstanceChanged(cd, eu, rx, ry, rz, rA, rB, gs, rC, rD)
		end;
		if gs then
			for _, bi in ipairs(CN) do
				if bi == gs then
					AutoHelp.IsInRaid = true
				end
			end;
			if gs == 603 then
				AutoHelp.IsInUld = true
			end
		end
	end;
	AutoHelp.ZONE_CHANGED_INDOORS = CO;
	AutoHelp.ZONE_CHANGED = CO;
	AutoHelp.ZONE_CHANGED_NEW_AREA = CO;
	function AutoHelp.IsRaidBoss()
		if AutoHelp.IsInRaid then
			return UnitLevel("target") == - 1
		end;
		return false
	end;
	function AutoHelp:LOADING_SCREEN_DISABLED()
		local _, eu, CQ, _, _, _, _, CR, rC = GetInstanceInfo()
		AutoHelp.InstanceType = eu;
		AutoHelp.LastInstanceMapID = CR;
		AutoHelp.LastGroupSize = rC;
		AutoHelp.DifficultyIndex = CQ
	end;
	local function CS()
		AutoHelp.RegisterEvents(12017, "SPELL_AURA_APPLIED", 24573)
		AutoHelp.RegisterEvents(11983, "SPELL_CAST_START", 22539)
		AutoHelp.RegisterEvents(12017, "SPELL_AURA_APPLIED", 23401)
		AutoHelp.RegisterEvents(12017, "SPELL_AURA_REMOVED", 23401)
		AutoHelp.RegisterEvents(11983, "SPELL_CAST_START", 24314)
		AutoHelp.RegisterEvents(12017, "SPELL_AURA_APPLIED", 16856)
		AutoHelp.RegisterEvents(15778, "SPELL_AURA_APPLIED", 26613)
		AutoHelp.RegisterEvents(15509, "SPELL_AURA_APPLIED", 26180)
		AutoHelp.RegisterEvents(15589, "SPELL_CAST_START", 24314)
		AutoHelp.RegisterEvents(16011, "SPELL_CAST_SUCCESS", 55593)
		AutoHelp.RegisterEvents(15990, "SPELL_CAST_SUCCESS", 27808)
		AutoHelp.RegisterEvents(33271, "SPELL_AURA_APPLIED", 62692)
		AutoHelp.RegisterEvents(33271, "SPELL_AURA_REMOVED", 62692)
		AutoHelp.RegisterEvents(33118, "SPELL_CAST_START", 62680)
		AutoHelp.RegisterEvents(33118, "SPELL_CAST_START", 63472)
		AutoHelp.RegisterEvents(32906, "SPELL_CAST_START", 62437)
		if AutoHelp.RegisterBossEvent then
			AutoHelp.RegisterBossEvent()
		end
	end;
	function AutoHelp:CHAT_MSG_MONSTER_YELL(a1, CT, _, _, x)
		if a1 == jd.Nefarian.YellDruid or a1:find(jd.Nefarian.YellDruid) then
			self:SendSync("ClassCall", "DRUID")
		elseif a1 == jd.Nefarian.YellHunter or a1:find(jd.Nefarian.YellHunter) then
			self:SendSync("ClassCall", "HUNTER")
		elseif a1 == jd.Nefarian.YellWarlock or a1:find(jd.Nefarian.YellWarlock) then
			self:SendSync("ClassCall", "WARLOCK")
		elseif a1 == jd.Nefarian.YellMage or a1:find(jd.Nefarian.YellMage) then
			self:SendSync("ClassCall", "MAGE")
		elseif a1 == jd.Nefarian.YellPaladin or a1:find(jd.Nefarian.YellPaladin) then
			self:SendSync("ClassCall", "PALADIN")
		elseif a1 == jd.Nefarian.YellPriest or a1:find(jd.Nefarian.YellPriest) then
			self:SendSync("ClassCall", "PRIEST")
		elseif a1 == jd.Nefarian.YellRogue or a1:find(jd.Nefarian.YellRogue) then
			self:SendSync("ClassCall", "ROGUE")
		elseif a1 == jd.Nefarian.YellShaman or a1:find(jd.Nefarian.YellShaman) then
			self:SendSync("ClassCall", "SHAMAN")
		elseif a1 == jd.Nefarian.YellWarrior or a1:find(jd.Nefarian.YellWarrior) then
			self:SendSync("ClassCall", "WARRIOR")
		elseif a1 == jd.Nefarian.YellP2 or a1:find(jd.Nefarian.YellP2) then
			self:SendSync("Phase", 2)
		elseif a1 == jd.Nefarian.YellP3 or a1:find(jd.Nefarian.YellP3) then
			self:SendSync("Phase", 3)
		end
	end;
	local CU = {
		"CHAT_MSG_PARTY",
		"CHAT_MSG_PARTY_LEADER",
		"CHAT_MSG_RAID",
		"CHAT_MSG_RAID_LEADER",
		"CHAT_MSG_WHISPER",
		"ZONE_CHANGED_NEW_AREA",
		"ZONE_CHANGED",
		"ZONE_CHANGED_INDOORS",
		"LOADING_SCREEN_DISABLED",
		"CHAT_MSG_MONSTER_YELL",
		"CHAT_MSG_MONSTER_EMOTE",
		"CHAT_MSG_MONSTER_SAY",
		"CHAT_MSG_RAID_BOSS_EMOTE",
		"ACTIVE_TALENT_GROUP_CHANGED",
		"CVAR_UPDATE",
		"VARIABLES_LOADED",
		"ENCOUNTER_START",
		"ENCOUNTER_END",
		"UNIT_THREAT_SITUATION_UPDATE"
	}
	function AutoHelp.UNIT_THREAT_SITUATION_UPDATE(aj, ho)
		if ho == "player" and UnitExists("target") and AutoHelp.TargetInfo and AutoHelp.encounterID > 0 then
			if AutoHelp.isWotlk and not AutoHelp.TargetInfo["isBoss"] then
				return
			end;
			local CV = UnitThreatSituation(ho)
			if CV == nil then
				CV = 0
			end;
			local CW, mt, sQ, sR, sS = UnitDetailedThreatSituation("player", "target")
			if mt == nil then
				mt = 0
			end;
			if sS == nil then
				sS = 0
			end;
			if CV >= 2 and AutoHelp.MyLastThreatState < 2 then
				AutoHelp.MyLastThreatState = 2;
				if mt >= 2 then
					if AutoHelp.ThreatChanged then
						AutoHelp.ThreatChanged(AutoHelp.MyLastThreatState, sQ, sR, sS)
					end
				end
			elseif CV == 1 and AutoHelp.MyLastThreatState < 1 then
				AutoHelp.MyLastThreatState = 1;
				if mt == 1 then
					if AutoHelp.ThreatChanged then
						AutoHelp.ThreatChanged(AutoHelp.MyLastThreatState, sQ, sR, sS)
					end
				end
			else
				if AutoHelp.MyLastThreatState > 0 then
					AutoHelp.MyLastThreatState = 0;
					if AutoHelp.ThreatChanged then
						AutoHelp.ThreatChanged(AutoHelp.MyLastThreatState, sQ, sR, sS)
					end
				end
			end
		end
	end;
	AutoHelp.encounterID = 0;
	AutoHelp.encounterName = nil;
	local function CX(sT, sU, rx, sV)
		if jy("STATUS_治疗模式") then
			return
		end;
		if sT == 1137 or sT == 749 then
			if AutoHelp.playerClass == "WARRIOR" or AutoHelp.playerClass == "DRUID" and jy("HEALMODE") == "野性(猫)" then
				AutoHelp.Debug(">>>科隆加恩之战开始，自动开启始终AOE技能！！！")
				SaveConfigValue("STATUS_始终AOE", true)
				return
			end;
			return
		end;
		if sT == 1133 or sT == 753 then
			AutoHelp.Debug(">>>弗蕾亚之战开始，开启自动AOE技能！！！")
			SaveConfigValue("HEAL_STATUS_AOE", true)
			SaveConfigValue("STATUS_始终AOE", false)
			return
		end;
		if sT == 1134 or sT == 755 then
			if AutoHelp.playerClass == "WARRIOR" then
				AutoHelp.Debug(">>>奥杜尔将军之战开始，自动保留10怒气供打断！！！")
				SaveConfigValue("HEAL_STATUS_保留打断怒气", true)
				SaveConfigValue("HEAL_VALUE_保留打断怒气值", 10)
			end;
			if AutoHelp.playerClass == "ROGUE" then
				AutoHelp.Debug(">>>奥杜尔将军之战开始，自动保留25能量供打断！！！")
				SaveConfigValue("HEAL_STATUS_保留打断能量", true)
				SaveConfigValue("HEAL_VALUE_保留打断能量值", 25)
			end;
			if AutoHelp.playerClass == "WARLOCK" then
				SaveConfigValue("STATUS_恶魔_恶魔冲锋", false)
				SaveConfigValue("HEAL_STATUS_自动换蓝", false)
			end
		end
	end;
	local function CY(sT, sU, rx, sV, ja)
		if jy("STATUS_治疗模式") then
			return
		end;
		if sT == 1137 or sT == 749 then
			if AutoHelp.playerClass == "WARRIOR" then
				AutoHelp.Debug(">>>科隆加恩之战结束，恢复AOE设置！")
				RestoreConfigValue("STATUS_始终AOE")
				return
			end
		end;
		if sT == 1134 or sT == 755 then
			if AutoHelp.playerClass == "WARRIOR" then
				RestoreConfigValue("HEAL_STATUS_保留打断怒气")
				RestoreConfigValue("HEAL_VALUE_保留打断怒气值")
			end;
			if AutoHelp.playerClass == "ROGUE" then
				RestoreConfigValue("HEAL_STATUS_保留打断能量")
				RestoreConfigValue("HEAL_VALUE_保留打断能量值")
			end;
			if AutoHelp.playerClass == "WARLOCK" then
				RestoreConfigValue("STATUS_恶魔_恶魔冲锋")
				RestoreConfigValue("HEAL_STATUS_自动换蓝")
			end
		end
	end;
	function AutoHelp.ENCOUNTER_START(aj, sT, sU, rx, sV)
		AutoHelp.encounterID = sT;
		AutoHelp.encounterName = sU;
		CX(sT, sU, rx, sV)
		if AutoHelp.EncounterStart then
			AutoHelp.EncounterStart(sT, sU, rx, sV)
		end
	end;
	function AutoHelp.ENCOUNTER_END(aj, sT, sU, rx, sV, ja)
		AutoHelp.encounterID = 0;
		AutoHelp.encounterName = nil;
		CY(sT, sU, rx, sV, ja)
		if AutoHelp.EncounterEnd then
			AutoHelp.EncounterEnd(sT, sU, rx, sV, ja)
		end
	end;
	local function CZ(aj, C_, jp)
		if C_ == "SpellQueueWindow" then
			if tonumber(jp) < 200 or tonumber(jp) > 400 then
				C_Timer.After(1, function()
					SetCVar("SpellQueueWindow", "400")
				end)
				return
			end;
			AutoHelp.SpellQueueWindow = (tonumber(jp) or 400) / 1000 - AutoHelp.AdjustSpellQueueWindow;
			if AutoHelp.SpellQueueWindow < 0 then
				AutoHelp.SpellQueueWindow = 0
			end
		end;
		if C_ == "Gamma" then
			if jp ~= "1" then
				AutoHelp.Debug("\124cfff00000##为了正常运行，请勿调整伽马值\124r")
				C_Timer.After(2, function()
					SetCVar("Gamma", "1")
				end)
			end
		end;
		if C_ == "Contrast" then
			if jp ~= "0.5" then
				AutoHelp.Debug("\124cfff00000##为了正常运行，请勿调整对比度\124r")
				C_Timer.After(2, function()
					SetCVar("Contrast", "50")
				end)
			end
		end;
		if C_ == "Brightness" then
			if jp ~= "0.5" then
				AutoHelp.Debug("\124cfff00000##为了正常运行，请勿调整亮度\124r")
				C_Timer.After(2, function()
					SetCVar("Brightness", "50")
				end)
			end
		end
	end;
	AutoHelp.CVAR_UPDATE = CZ;
	AutoHelp.VARIABLES_LOADED = CZ;
	local function D0()
		SetConfig("TALENTCHANGED", true)
		StaticPopup_Show("AUTOHELP_TALENT_CHANGED")
	end;
	AutoHelp.ACTIVE_TALENT_GROUP_CHANGED = D0;
	local function D1()
		local D2 = GetCVar("Gamma")
		local D3 = GetCVar("Contrast")
		local D4 = GetCVar("Brightness")
		if D2 ~= "1" then
			SetCVar("Gamma", "1")
			AutoHelp.Debug("为了正常运行，已经为您调整Gamma设置为1(前值：" .. D2 .. ")")
		end;
		if D4 ~= "50" then
			SetCVar("Brightness", "50")
			AutoHelp.Debug("为了正常运行，已经为您调整亮度为正常50(前值：" .. D4 .. ")")
		end;
		if D3 ~= "50" then
			SetCVar("Contrast", "50")
			AutoHelp.Debug("为了正常运行，已经为您调整对比度为正常50(前值：" .. D3 .. ")")
		end;
		SetCVar("SpellQueueWindow", GetCVarDefault("SpellQueueWindow"))
		AutoHelp.SpellQueueWindow = (tonumber(GetCVar("SpellQueueWindow")) or 400) / 1000 - AutoHelp.AdjustSpellQueueWindow;
		if AutoHelp.SpellQueueWindow < 0 then
			AutoHelp.SpellQueueWindow = 0
		end;
		AutoHelp.OrgiAutoInteract = GetCVar("AutoInteract")
		SetCVar("cameraDistanceMaxZoomFactor", "4")
	end;
	AutoHelp.IsChating = false;
	local function D5()
		AutoHelp.IsChating = true
	end;
	local function D6()
		AutoHelp.IsChating = false
	end;
	local function D7(CI, Aq)
		if not CI then
			return
		end;
		if GetStatus("HEAL_STATUS_PAUSE") then
			AutoHelp.Debug(">>暂停状态，无法执行！")
			return
		end;
		local tInfo;
		local qZ = {}
		string.gsub(CI, '[^,|^/]+', function(oc)
			table.insert(qZ, oc)
		end)
		if AutoHelp.AddNextCastAction and not AutoHelp.AddNextCastAction(qZ) then
			return
		end;
		for al, p in ipairs(qZ) do
			local action = AutoHelp.GetAction(p)
			if not action then
				AutoHelp.Debug("没有找到技能：" .. p)
				return
			end;
			if action["target"] and AutoHelp.TargetInfo then
				tInfo = AutoHelp.TargetInfo
			else
				tInfo = HEAL_RAID["player"]
			end;
			local Ap = true;
			if al > 1 then
				Ap = false
			end;
			AutoHelp.TryDoAction(tInfo, p, Ap, Aq)
		end;
		if HEAL_TIMERS["HEAL_TARGET"] > 0 then
			HEAL_TIMERS["HEAL_TARGET"] = 0.01
		end
	end;
	AutoHelp.AddCastAction = D7;
	local function D8(CI)
		if CI == "reset" then
			HelpSettings = {}
			C_UI.Reload()
			return
		end;
		if CI == "version" then
			print("AutoHelp " .. AutoHelp.Version)
			return
		end;
		print("用法:")
		print("/ah version - 显示版本号")
		print("/ah reset - 恢复缺省设置")
		print("/ahcast 技能名称 - 加入技能施法队列")
	end;
	local function D9()
		SLASH_AUTOHELPCAST1 = "/ahcast"
		SlashCmdList["AUTOHELPCAST"] = D7;
		SLASH_AUTOHELP1 = "/ah"
		SLASH_AUTOHELP2 = "/autohelp"
		SlashCmdList["AUTOHELP"] = D8
	end;
	function AutoHelp.TogglePause()
		SetConfig("HEAL_STATUS_PAUSE", not GetStatus("HEAL_STATUS_PAUSE"))
	end;
	function AutoHelp.ToggleAOE()
		SetConfig("HEAL_STATUS_AOE", not GetStatus("HEAL_STATUS_AOE"))
	end;
	function AutoHelp.ToggleShown(Da)
		if Da == nil then
			Da = not AutoHelp.SettingItems["tab"]:IsShown()
		end;
		if Da then
			AutoHelp.SettingItems["tab"]:Show()
		else
			AutoHelp.SettingItems["tab"]:Hide()
		end
	end;
	function AutoHelp.SetMode(kH)
		if jy("HEALMODE") ~= kH then
			SetConfig("HEALMODE", kH)
			if AutoHelp.ModeChanged then
				AutoHelp.ModeChanged(kH)
			end
		end
	end;
	function AutoHelp.SetHealAll(mt, Cj)
		SetConfig("HEAL_STATUS_AUTOHEAL", mt or true)
		SetConfig("HEAL_AUTO_VALUE", Cj or 90)
	end;
	function AutoHelp.SetHealTank(mt, Cj)
		SetConfig("HEAL_STATUS_FIRSTTANK", mt or true)
		SetConfig("HEAL_FIRSTTANK_VALUE", Cj or 60)
	end;
	function AutoHelp.SetHealTarget(mt, Cj)
		SetConfig("HEAL_STATUS_FIRSTTARGET", mt or false)
		SetConfig("HEAL_FIRSTPROTECT_VALUE", Cj or 90)
	end;
	local Db = {
		545431,
		559130,
		559131,
		559126,
		559128,
		559133,
		559129,
		559132,
		559127
	}
	local function Dc(Dd)
		if Dd then
			for _, De in pairs(Db) do
				MuteSoundFile(De)
			end
		else
			for _, De in pairs(Db) do
				UnmuteSoundFile(De)
			end
		end
	end;
	AutoHelp.Glyphs = {}
	local function Df()
		if AutoHelp.isWotlk then
			for bi = 1, GetNumGlyphSockets() do
				local eF, Dg, eG = GetGlyphSocketInfo(bi)
				if eF and eG then
					AutoHelp.Glyphs[eG] = true;
					AutoHelp.Glyphs[bi] = eG
				end
			end
		end
	end;
	function AutoHelp:OnInitialize()
		for _, AZ in pairs(CU) do
			self.eventFrame:RegisterEvent(AZ)
		end;
		D1()
		AutoHelp.LoadActionKeys()
		CreateFrames()
		CD()
		Ae()
		Dc(true)
		Df()
		if AutoHelp.ClassInit then
			AutoHelp.ClassInit()
		end;
		InitNameplates(41)
		if AutoHelp.OPTIONS_INIT then
			AutoHelp.OPTIONS_INIT()
		end;
		if AutoHelp.ModeChanged then
			AutoHelp.ModeChanged(jy("HEALMODE"))
		end;
		CS()
		ChatFrame1EditBox:SetScript("OnEditFocusGained", D5)
		ChatFrame1EditBox:SetScript("OnEditFocusLost", D6)
		TradePlayerInputMoneyFrameGold:SetScript("OnEditFocusGained", D5)
		TradePlayerInputMoneyFrameGold:SetScript("OnEditFocusLost", D6)
		TradePlayerInputMoneyFrameSilver:SetScript("OnEditFocusGained", D5)
		TradePlayerInputMoneyFrameSilver:SetScript("OnEditFocusLost", D6)
		TradePlayerInputMoneyFrameCopper:SetScript("OnEditFocusGained", D5)
		TradePlayerInputMoneyFrameCopper:SetScript("OnEditFocusLost", D6)
		WhoFrameEditBox:SetScript("OnEditFocusGained", D5)
		WhoFrameEditBox:SetScript("OnEditFocusLost", D6)
		if AutoHelp.ClassAfterInit then
			AutoHelp.ClassAfterInit()
		end;
		D9()
		if AutoHelp.ClassLoaded then
			AutoHelp.ClassLoaded()
		end;
		StartAutoHelp()
	end;
	local function g7(self, aj, ...)
		if AutoHelp[aj] and type(AutoHelp[aj]) == "function" then
			if aj == 'COMBAT_LOG_EVENT_UNFILTERED' then
				AutoHelp[aj](AutoHelp, CombatLogGetCurrentEventInfo())
			else
				AutoHelp[aj](AutoHelp, ...)
			end
		end
	end;
	local function Dh()
		AutoHelp.playerGUID = UnitGUID("player")
		AutoHelp.playerName = UnitName("player")
		AutoHelp.playerLevel = UnitLevel("player")
		AutoHelp.playerFaction = UnitFactionGroup("player")
		local _, mr, ms = UnitRace("player")
		AutoHelp.playerRaceId = ms;
		AutoHelp.playerClassName, AutoHelp.playerClass, AutoHelp.playerClassIdx = UnitClass("player")
		if not HelpSettings or not HelpSettings["version"] or HelpSettings["version"] < AutoHelp.version then
			HelpSettings = {}
			HelpSettings["version"] = AutoHelp.version
		end;
		AutoHelp:OnInitialize()
	end;
	AutoHelp.eventFrame = AutoHelp.eventFrame or CreateFrame("Frame")
	AutoHelp.eventFrame:UnregisterAllEvents()
	AutoHelp.eventFrame:RegisterEvent("UNIT_PET")
	AutoHelp.eventFrame:SetScript("OnEvent", g7)
	local Di = 2;
	local function Dj(h3, fh)
		Di = Di - fh;
		if Di <= 0 then
			if AutoHelp.SPELLISOK then
				AutoHelp.eventFrame:SetScript("OnUpdate", nil)
				local ja, s = pcall(function()
					AutoHelp.GetSpellBooks(true)
					if AutoHelp.ClassConfig then
						AutoHelp.ClassConfig()
					end;
					Dh()
				end)
				if not ja and s then
					print("捕获到错误，请提交给开发人员:", s)
					print(debugstack())
				end
			else
				Di = 2
			end
		end
	end;
	function AutoHelp:PLAYER_LOGIN()
		if CG then
			return
		end;
		AutoHelp.GetSpellBooks(true)
		AutoHelp.CheckAllItems()
		Di = 2;
		AutoHelp.eventFrame:SetScript("OnUpdate", Dj)
		CO()
		self.eventFrame:UnregisterEvent("PLAYER_LOGIN")
	end;
	function AutoHelp.AboutVersion()
		StaticPopupDialogs["AUTOHELP_ABOUT_VERSION"] = {
			text = "About",
			button1 = "Yes (recomended)",
			button2 = "No",
			OnAccept = function()
			end,
			OnCancel = function()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = false,
			preferredIndex = STATICPOPUP_NUMDIALOGS or 3
		}
		StaticPopup_Show("AUTOHELP_ABOUT_VERSION")
	end;
	StaticPopupDialogs["AUTOHELP_STARTED"] = {
		text = "AutoHelp已经开始运行" .. "\n\n\124cfff00000请勿在战斗中重载界面, 会导致停用!!!\124r\n\n需要暂停或重新开始，请使用\124cff00ff00小键盘零\124r或者使用设置中的\124cff00ff00暂停\124r开关！" .. "\n\n仅限于内部交流和学习之用",
		button1 = "确定",
		OnAccept = function()
		end,
		OnCancel = function()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		preferredIndex = STATICPOPUP_NUMDIALOGS or 3
	}
	StaticPopupDialogs["AUTOHELP_TIPS"] = {
		text = "欢迎使用AutoHelp" .. "\n\n\124cfff00000AutoHelp可以开启(F12)\124r\n\n请运行AutoHelp，按F12开始运行\124cff00ff00\124r" .. "\n\n仅限于内部交流和学习之用",
		button1 = "确定",
		OnAccept = function()
		end,
		OnCancel = function()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		preferredIndex = STATICPOPUP_NUMDIALOGS or 3
	}
	StaticPopupDialogs["AUTOHELP_TALENT_CHANGED"] = {
		text = "欢迎使用AutoHelp" .. "\n\n\124cfff00000检测到您切换了天赋，需要重载界以保证AutoHelp技能完整性。\124r" .. "\n\n仅限于内部交流和学习之用",
		button1 = "确定",
		OnAccept = function()
			C_UI.Reload()
		end,
		OnCancel = function()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = false,
		preferredIndex = STATICPOPUP_NUMDIALOGS or 3
	}
	function AutoHelp.StartedMessage()
		StaticPopup_Show("AUTOHELP_STARTED")
	end;
	function AutoHelp:SendSync(a1, K)
		if a1 == "ClassCall" then
			local AS = LOCALIZED_CLASS_NAMES_MALE[K]
			if UnitClass("player") == AS then
				if b5 == "PRIEST" then
					AutoHelp.StopAction()
					AutoHelp.SetStopAction(30, "奈法点名停止动作 30秒！！！")
				elseif b5 == "PALADIN" then
					if AutoHelp.CanUseAction(HEAL_RAID["player"], "圣盾术") then
						AutoHelp.AddNextAction(HEAL_RAID["player"], "圣盾术")
					else
						AutoHelp.Debug("你被奈法点名，无敌CD中,")
					end
				else
					AutoHelp.Debug("你被奈法点名！")
				end
			end
		end
	end;
	if not IsLoggedIn() then
		AutoHelp.eventFrame:RegisterEvent("PLAYER_LOGIN")
	else
		AutoHelp:PLAYER_LOGIN()
	end
end;
ws()