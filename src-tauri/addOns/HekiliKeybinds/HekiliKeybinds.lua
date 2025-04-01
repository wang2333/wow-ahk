-- 缓存频繁使用的API
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitPower = UnitPower
local UnitExists = UnitExists
local UnitIsFriend = UnitIsFriend
local UnitIsDead = UnitIsDead
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitAffectingCombat = UnitAffectingCombat
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local UnitName = UnitName
local UnitClass = UnitClass
local UnitRace = UnitRace
local UnitIsUnit = UnitIsUnit
local UnitInVehicle = UnitInVehicle
local UnitIsVisible = UnitIsVisible
local UnitIsBossMob = UnitIsBossMob
local UnitLevel = UnitLevel
local UnitGUID = UnitGUID
local UnitHasIncomingResurrection = UnitHasIncomingResurrection
local UnitThreatSituation = UnitThreatSituation
local GetTime = GetTime
local GetSpellCharges = C_Spell.GetSpellCharges
local GetSpellCooldown = C_Spell.GetSpellCooldown
local GetSpellTexture = C_Spell.GetSpellTexture
local GetSpellName = C_Spell.GetSpellName
local IsSpellInRange = C_Spell.IsSpellInRange
local IsSpellUsable = C_Spell.IsSpellUsable
local IsInInstance = IsInInstance
local IsPlayerSpell = IsPlayerSpell
local IsPlayerMoving = IsPlayerMoving
local IsMounted = IsMounted
local IsKeyDown = IsKeyDown
local IsUsableItem = C_Item.IsUsableItem
local GetItemCooldown = C_Item.GetItemCooldown
local GetSpecialization = GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo
local GetShapeshiftFormID = GetShapeshiftFormID
local GetHaste = GetHaste
local GetUnitSpeed = GetUnitSpeed
local FindBaseSpellByID = FindBaseSpellByID
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local GetActiveLossOfControlDataCount = C_LossOfControl.GetActiveLossOfControlDataCount
local GetActiveLossOfControlData = C_LossOfControl.GetActiveLossOfControlData
local tContains = tContains
local max = math.max
local player = "player"
local target = "target"
local mouseover = "mouseover"

-- 标记是否在执行返回操作
local startTimeCR = 0
local zhuanzhuanTime = 0
local isReturning = false
local chengong = false
local frameCounter = 0
local lastColor = nil
local ticker = nil
local buttonColor = nil
local oldThreshold = nil
local createdMacros = {}

-- 配置部分
local CONFIG = {
    BLOCK_SIZE = 2,
    DEFAULT_COLOR = "#FFFFFF",
    TAB_COLOR = "#001000",
    SPELL_COLORS = {
        HEALING_POTION = "#000213",     -- 治疗药水颜色
        SHIELD_OF_VENGEANCE = "#000214",-- 复仇之盾颜色
        DIVINE_PROTECTION = "#000215",  -- 圣佑术颜色
        WORD_OF_GLORY = "#000217",      -- 荣耀圣令颜色
        WORD_OF_GLORY_M = "#000218",      -- 鼠标荣耀圣令颜色
        FREE_BLESSING = "#000219",      -- 自由祝福颜色
        FREE_BLESSING_M = "#000220",      -- 自由祝福宏颜色
        RESURRECTION = "#000221",       -- 战复颜色
        DIVINE_SHIELD = "#000222",      -- 圣盾术颜色
        WILL_TO_SURVIVE = "#000223",    -- 生存意志颜色
        BLESSED_HAMMER = "#000224",     -- 祝福之锤颜色
        HS_REBUKE_T = "#000313",     -- 目标谴难颜色
        HS_REBUKE_M = "#000314",     -- 鼠标谴难颜色
        SHIELD_OF_THE_RIGHTEOUS = "#000315",    -- 正义盾击颜色
        HS_AVENGERS_SHIELD_T = "#000317",    -- 目标复仇者之盾颜色
        HS_AVENGERS_SHIELD_M = "#000318",    -- 鼠标复仇者之盾颜色
        BLESSING_OF_PROTECTION = "#000319",    -- 保护祝福颜色
        BLESSING_OF_SPELLWARDING = "#000320",    -- 破咒祝福颜色
        LAY_ON_HANDS = "#000321",     -- 圣疗术颜色
        LAY_ON_HANDS_1 = "#000322",     -- 圣疗术队友1颜色
        LAY_ON_HANDS_2 = "#000323",     -- 圣疗术队友2颜色
        LAY_ON_HANDS_3 = "#000324",     -- 圣疗术队友3颜色
        LAY_ON_HANDS_4 = "#000366",     -- 圣疗术队友4颜色
        CLEANSE_TOXINS = "#000367",     -- 清毒术颜色
        CLEANSE_TOXINS_1 = "#000368",     -- 清毒术队友1颜色
        CLEANSE_TOXINS_2 = "#000369",     -- 清毒术队友2颜色
        CLEANSE_TOXINS_3 = "#000370",     -- 清毒术队友3颜色
        CLEANSE_TOXINS_4 = "#000371",     -- 清毒术队友4颜色
        HAND_OF_RECKONING_T = "#000372",     -- 目标清算之手颜色
        HAND_OF_RECKONING_M = "#000373",     -- 鼠标清算之手颜色
        HAMMER_OF_JUSTICE = "#000374",     -- 制裁之锤颜色
        BLINDING_LIGHT = "#000375",     -- 盲目之光颜色
        HEALTHSTONE = "#000381",     -- 治疗石颜色
        BLESSING_OF_SACRIFICE_1 = "#000382",     -- 牺牲祝福队友1颜色
        BLESSING_OF_SACRIFICE_2 = "#000383",     -- 牺牲祝福队友2颜色
        BLESSING_OF_SACRIFICE_3 = "#000384",     -- 牺牲祝福队友3颜色
        BLESSING_OF_SACRIFICE_4 = "#000385",     -- 牺牲祝福队友4颜色
        WORD_OF_GLORY_1 = "#000386",     -- 荣耀圣令队友1颜色
        WORD_OF_GLORY_2 = "#000387",     -- 荣耀圣令队友2颜色
        WORD_OF_GLORY_3 = "#000388",     -- 荣耀圣令队友3颜色
        WORD_OF_GLORY_4 = "#000389",     -- 荣耀圣令队友4颜色
        DEVOTION_AURA = "#000390",     -- 虔诚光环颜色
        CRUSADER_AURA = "#000396",     -- 十字军光环颜色
        HS_Trinket = "#000397",     -- 饰品颜色
        HS_TAB = "#000398",     -- 切换目标颜色
        HS_REBUKE_1 = "#000399",     -- 谴难队友1目标颜色
        HS_REBUKE_2 = "#000400",     -- 谴难队友2目标颜色
        HS_REBUKE_3 = "#000401",     -- 谴难队友3目标颜色
        HS_REBUKE_4 = "#000402",     -- 谴难队友4目标颜色
        HS_AVENGERS_SHIELD_1 = "#000403",     -- 复仇者之盾队友1目标颜色
        HS_AVENGERS_SHIELD_2 = "#000404",     -- 复仇者之盾队友2目标颜色
        HS_AVENGERS_SHIELD_3 = "#000405",     -- 复仇者之盾队友3目标颜色
        HS_AVENGERS_SHIELD_4 = "#000411",     -- 复仇者之盾队友4目标颜色
        HS_HAMMER_OF_JUSTICE_T = "#000412",     -- 制裁之锤目标颜色
        HS_HAMMER_OF_JUSTICE_M = "#000413",     -- 制裁之锤鼠标颜色
        HS_HAMMER_OF_JUSTICE_1 = "#000414",     -- 制裁之锤队友1目标颜色
        HS_HAMMER_OF_JUSTICE_2 = "#000415",     -- 制裁之锤队友2目标颜色
        HS_HAMMER_OF_JUSTICE_3 = "#000416",     -- 制裁之锤队友3目标颜色
        HS_HAMMER_OF_JUSTICE_4 = "#000417",     -- 制裁之锤队友4目标颜色
        HAND_OF_RECKONING_1 = "#000426",     -- 清算之手队友1目标颜色
        HAND_OF_RECKONING_2 = "#000427",     -- 清算之手队友2目标颜色
        HAND_OF_RECKONING_3 = "#000428",     -- 清算之手队友3目标颜色
        HAND_OF_RECKONING_4 = "#000429",     -- 清算之手队友4目标颜色
        Intercession_1 = "#000430",     -- 战复队友1目标颜色
        Intercession_2 = "#000431",     -- 战复队友2目标颜色
        Intercession_3 = "#000432",     -- 战复队友3目标颜色
        Intercession_4 = "#000433"     -- 战复队友4目标颜色
    },
    SPELL_IDS = {
        WORD_OF_GLORY = 85673,
        BLESSING_OF_SACRIFICE = 6940,
        HEALING_POTION = 431416,
        SHIELD_OF_VENGEANCE = 184662,
        DIVINE_PROTECTION = 403876,
        FREE_BLESSING = 1044,
        RESURRECTION = 391054,
        DIVINE_SHIELD = 642,
        WILL_TO_SURVIVE = 59752,
        REBUKE = 96231,
        BLESSED_HAMMER = 204019,
        SHIELD_OF_THE_RIGHTEOUS = 53600,
        AVENGERS_SHIELD = 31935,
        BLESSING_OF_PROTECTION = 1022,
        BLESSING_OF_SPELLWARDING = 204018,
        LAY_ON_HANDS = 633,
        LAY_ON_HANDS2 = 471195,
        CLEANSE_TOXINS = 213644,
        HAND_OF_RECKONING = 62124,
        HAMMER_OF_JUSTICE = 853,
        BLINDING_LIGHT = 115750
    },
    DANGEROUS_SPELLS = {
        casts = {"晦暗之风", "命令咆哮", "暮光打击", "喧神教化", "警示尖鸣", "震颤猛击", "晦幽纺纱", "虚空涌动", "黏稠黑暗", "巨岩碾压", "酸性新星"},
        channels = {"黑暗脉动", "铸造利斧", "铸造利剑", "铸造利锤", "晦影腐朽", "虚空涌动", "虚空爆发"},
        playerCasts = {"深重呕吐"},
        wgCasts = {"震地猛击", "震颤猛击", "晦幽纺纱"}
    },
    MOVEMENT_IMPAIRING_CASTS = {"冻结之缚", "晦幽纺纱"}
}

-- 按键绑定颜色映射表
local KEYBIND_COLORS = {
    -- 数字键
    ["1"] = "#000001", ["2"] = "#000002", ["3"] = "#000003", ["4"] = "#000004",
    ["5"] = "#000005", ["6"] = "#000006", ["7"] = "#000007", ["8"] = "#000008",
    ["9"] = "#000009", ["0"] = "#000010", ["-"] = "#000011", ["="] = "#000012",

    -- 功能键
    ["F1"] = "#000013", ["F2"] = "#000014", ["F3"] = "#000015", ["F4"] = "#000016",
    ["F5"] = "#000017", ["F6"] = "#000018", ["F7"] = "#000019", ["F8"] = "#000020",
    ["F9"] = "#000021", ["F10"] = "#000022", ["F11"] = "#000023", ["F12"] = "#000024",

    -- 字母键
    ["A"] = "#000025", ["B"] = "#000026", ["C"] = "#000027", ["D"] = "#000028",
    ["E"] = "#000029", ["F"] = "#000030", ["G"] = "#000031", ["H"] = "#000032",
    ["I"] = "#000033", ["J"] = "#000034", ["K"] = "#000035", ["L"] = "#000036",
    ["M"] = "#000037", ["N"] = "#000038", ["O"] = "#000039", ["P"] = "#000040",
    ["Q"] = "#000041", ["R"] = "#000042", ["S"] = "#000043", ["T"] = "#000044",
    ["U"] = "#000045", ["V"] = "#000046", ["W"] = "#000047", ["X"] = "#000048",
    ["Y"] = "#000049", ["Z"] = "#000050",

    -- Ctrl+数字和符号
    ["C1"] = "#000051", ["C2"] = "#000052", ["C3"] = "#000053", ["C4"] = "#000054",
    ["C5"] = "#000055", ["C6"] = "#000056", ["C7"] = "#000057", ["C8"] = "#000058",
    ["C9"] = "#000059", ["C0"] = "#000060", ["C-"] = "#000061", ["C="] = "#000062",

    -- Ctrl+功能键
    ["CF1"] = "#000063", ["CF2"] = "#000064", ["CF3"] = "#000065", ["CF4"] = "#000066",
    ["CF5"] = "#000067", ["CF6"] = "#000068", ["CF7"] = "#000069", ["CF8"] = "#000070",
    ["CF9"] = "#000071", ["CF10"] = "#000072", ["CF11"] = "#000073", ["CF12"] = "#000074",

    -- Ctrl+字母键
    ["CA"] = "#000075", ["CB"] = "#000076", ["CC"] = "#000077", ["CD"] = "#000078",
    ["CE"] = "#000079", ["CF"] = "#000080", ["CG"] = "#000081", ["CH"] = "#000082",
    ["CI"] = "#000083", ["CJ"] = "#000084", ["CK"] = "#000085", ["CL"] = "#000086",
    ["CM"] = "#000087", ["CN"] = "#000088", ["CO"] = "#000089", ["CP"] = "#000090",
    ["CQ"] = "#000091", ["CR"] = "#000092", ["CS"] = "#000093", ["CT"] = "#000094",
    ["CU"] = "#000095", ["CV"] = "#000096", ["CW"] = "#000097", ["CX"] = "#000098",
    ["CY"] = "#000099", ["CZ"] = "#000100",

    -- Alt+数字和符号
    ["A1"] = "#000101", ["A2"] = "#000102", ["A3"] = "#000103", ["A4"] = "#000104",
    ["A5"] = "#000105", ["A6"] = "#000106", ["A7"] = "#000107", ["A8"] = "#000108",
    ["A9"] = "#000109", ["A0"] = "#000110", ["A-"] = "#000111", ["A="] = "#000112",

    -- Alt+功能键
    ["AF1"] = "#000113", ["AF2"] = "#000114", ["AF3"] = "#000115", ["AF4"] = "#000116",
    ["AF5"] = "#000117", ["AF6"] = "#000118", ["AF7"] = "#000119", ["AF8"] = "#000120",
    ["AF9"] = "#000121", ["AF10"] = "#000122", ["AF11"] = "#000123", ["AF12"] = "#000124",

    -- Alt+字母键
    ["AA"] = "#000125", ["AB"] = "#000126", ["AC"] = "#000127", ["AD"] = "#000128",
    ["AE"] = "#000129", ["AF"] = "#000130", ["AG"] = "#000131", ["AH"] = "#000132",
    ["AI"] = "#000133", ["AJ"] = "#000134", ["AK"] = "#000135", ["AL"] = "#000136",
    ["AM"] = "#000137", ["AN"] = "#000138", ["AO"] = "#000139", ["AP"] = "#000140",
    ["AQ"] = "#000141", ["AR"] = "#000142", ["AS"] = "#000143", ["AT"] = "#000144",
    ["AU"] = "#000145", ["AV"] = "#000146", ["AW"] = "#000147", ["AX"] = "#000148",
    ["AY"] = "#000149", ["AZ"] = "#000150",

    -- Shift+数字和符号
    ["S1"] = "#000151", ["S2"] = "#000152", ["S3"] = "#000153", ["S4"] = "#000154",
    ["S5"] = "#000155", ["S6"] = "#000156", ["S7"] = "#000157", ["S8"] = "#000158",
    ["S9"] = "#000159", ["S0"] = "#000160", ["S-"] = "#000161", ["S="] = "#000162",

    -- Shift+功能键
    ["SF1"] = "#000163", ["SF2"] = "#000164", ["SF3"] = "#000165", ["SF4"] = "#000166",
    ["SF5"] = "#000167", ["SF6"] = "#000168", ["SF7"] = "#000169", ["SF8"] = "#000170",
    ["SF9"] = "#000171", ["SF10"] = "#000172", ["SF11"] = "#000173", ["SF12"] = "#000174",

    -- Shift+字母键
    ["SA"] = "#000175", ["SB"] = "#000176", ["SC"] = "#000177", ["SD"] = "#000178",
    ["SE"] = "#000179", ["SF"] = "#000180", ["SG"] = "#000181", ["SH"] = "#000182",
    ["SI"] = "#000183", ["SJ"] = "#000184", ["SK"] = "#000185", ["SL"] = "#000186",
    ["SM"] = "#000187", ["SN"] = "#000188", ["SO"] = "#000189", ["SP"] = "#000190",
    ["SQ"] = "#000191", ["SR"] = "#000192", ["SS"] = "#000193", ["ST"] = "#000194",
    ["SU"] = "#000195", ["SV"] = "#000196", ["SW"] = "#000197", ["SX"] = "#000198",
    ["SY"] = "#000199", ["SZ"] = "#000200",

    -- Alt+Ctrl数字和符号
    ["AC1"] = "#000201", ["AC2"] = "#000202", ["AC3"] = "#000203", ["AC4"] = "#000204",
    ["AC5"] = "#000205", ["AC6"] = "#000206", ["AC7"] = "#000207", ["AC8"] = "#000208",
    ["AC9"] = "#000209", ["AC0"] = "#000210", ["AC-"] = "#000211", ["AC="] = "#000212",

    -- Alt+Ctrl+功能键
    ["ACF1"] = "#000213", ["ACF2"] = "#000214", ["ACF3"] = "#000215", ["ACF4"] = "#000216",
    ["ACF5"] = "#000217", ["ACF6"] = "#000218", ["ACF7"] = "#000219", ["ACF8"] = "#000220",
    ["ACF9"] = "#000221", ["ACF10"] = "#000222", ["ACF11"] = "#000223", ["ACF12"] = "#000224",

    -- Alt+Ctrl+字母键
    ["ACA"] = "#000225", ["ACB"] = "#000226", ["ACC"] = "#000227", ["ACD"] = "#000228",
    ["ACE"] = "#000229", ["ACF"] = "#000230", ["ACG"] = "#000231", ["ACH"] = "#000232",
    ["ACI"] = "#000233", ["ACJ"] = "#000234", ["ACK"] = "#000235", ["ACL"] = "#000236",
    ["ACM"] = "#000237", ["ACN"] = "#000238", ["ACO"] = "#000239", ["ACP"] = "#000240",
    ["ACQ"] = "#000241", ["ACR"] = "#000242", ["ACS"] = "#000243", ["ACT"] = "#000244",
    ["ACU"] = "#000245", ["ACV"] = "#000246", ["ACW"] = "#000247", ["ACX"] = "#000248",
    ["ACY"] = "#000249", ["ACZ"] = "#000250",

    -- Ctrl+Shift+数字和符号
    ["CS1"] = "#000251", ["CS2"] = "#000252", ["CS3"] = "#000253", ["CS4"] = "#000254",
    ["CS5"] = "#000255", ["CS6"] = "#000256", ["CS7"] = "#000257", ["CS8"] = "#000258",
    ["CS9"] = "#000259", ["CS0"] = "#000260", ["CS-"] = "#000261", ["CS="] = "#000262",

    -- Ctrl+Shift+功能键
    ["CSF1"] = "#000263", ["CSF2"] = "#000264", ["CSF3"] = "#000265", ["CSF4"] = "#000266",
    ["CSF5"] = "#000267", ["CSF6"] = "#000268", ["CSF7"] = "#000269", ["CSF8"] = "#000270",
    ["CSF9"] = "#000271", ["CSF10"] = "#000272", ["CSF11"] = "#000273", ["CSF12"] = "#000274",

    -- Ctrl+Shift+字母键
    ["CSA"] = "#000275", ["CSB"] = "#000276", ["CSC"] = "#000277", ["CSD"] = "#000278",
    ["CSE"] = "#000279", ["CSF"] = "#000280", ["CSG"] = "#000281", ["CSH"] = "#000282",
    ["CSI"] = "#000283", ["CSJ"] = "#000284", ["CSK"] = "#000285", ["CSL"] = "#000286",
    ["CSM"] = "#000287", ["CSN"] = "#000288", ["CSO"] = "#000289", ["CSP"] = "#000290",
    ["CSQ"] = "#000291", ["CSR"] = "#000292", ["CSS"] = "#000293", ["CST"] = "#000294",
    ["CSU"] = "#000295", ["CSV"] = "#000296", ["CSW"] = "#000297", ["CSX"] = "#000298",
    ["CSY"] = "#000299", ["CSZ"] = "#000300",

    -- Alt+Shift+数字和符号
    ["AS1"] = "#000301", ["AS2"] = "#000302", ["AS3"] = "#000303", ["AS4"] = "#000304",
    ["AS5"] = "#000305", ["AS6"] = "#000306", ["AS7"] = "#000307", ["AS8"] = "#000308",
    ["AS9"] = "#000309", ["AS0"] = "#000310", ["AS-"] = "#000311", ["AS="] = "#000312",

    -- Alt+Shift+功能键
    ["ASF1"] = "#000313", ["ASF2"] = "#000314", ["ASF3"] = "#000315", ["ASF4"] = "#000316",
    ["ASF5"] = "#000317", ["ASF6"] = "#000318", ["ASF7"] = "#000319", ["ASF8"] = "#000320",
    ["ASF9"] = "#000321", ["ASF10"] = "#000322", ["ASF11"] = "#000323", ["ASF12"] = "#000324",

    -- Alt+Shift+字母键
    ["ASA"] = "#000325", ["ASB"] = "#000326", ["ASC"] = "#000327", ["ASD"] = "#000328",
    ["ASE"] = "#000329", ["ASF"] = "#000330", ["ASG"] = "#000331", ["ASH"] = "#000332",
    ["ASI"] = "#000333", ["ASJ"] = "#000334", ["ASK"] = "#000335", ["ASL"] = "#000336",
    ["ASM"] = "#000337", ["ASN"] = "#000338", ["ASO"] = "#000339", ["ASP"] = "#000340",
    ["ASQ"] = "#000341", ["ASR"] = "#000342", ["ASS"] = "#000343", ["AST"] = "#000344",
    ["ASU"] = "#000345", ["ASV"] = "#000346", ["ASW"] = "#000347", ["ASX"] = "#000348",
    ["ASY"] = "#000349", ["ASZ"] = "#000350",

    -- 右边的数字键和符号
    ["N1"] = "#000351", ["N2"] = "#000352", ["N3"] = "#000353", ["N4"] = "#000354",
    ["N5"] = "#000355", ["N6"] = "#000356", ["N7"] = "#000357", ["N8"] = "#000358",
    ["N9"] = "#000359", ["N0"] = "#000360", ["N."] = "#000361", ["N/"] = "#000362",
    ["N*"] = "#000363", ["N-"] = "#000364", ["N+"] = "#000365",

    -- Ctrl + 右边的数字键和符号
    ["CN1"] = "#000366", ["CN2"] = "#000367", ["CN3"] = "#000368", ["CN4"] = "#000369",
    ["CN5"] = "#000370", ["CN6"] = "#000371", ["CN7"] = "#000372", ["CN8"] = "#000373",
    ["CN9"] = "#000374", ["CN0"] = "#000375", ["CN."] = "#000376", ["CN/"] = "#000377",
    ["CN*"] = "#000378", ["CN-"] = "#000379", ["CN+"] = "#000380",

    -- Alt + 右边的数字键和符号
    ["AN1"] = "#000381", ["AN2"] = "#000382", ["AN3"] = "#000383", ["AN4"] = "#000384",
    ["AN5"] = "#000385", ["AN6"] = "#000386", ["AN7"] = "#000387", ["AN8"] = "#000388",
    ["AN9"] = "#000389", ["AN0"] = "#000390", ["AN."] = "#000391", ["AN/"] = "#000392",
    ["AN*"] = "#000393", ["AN-"] = "#000394", ["AN+"] = "#000395",

    -- Shift + 右边的数字键和符号
    ["SN1"] = "#000396", ["SN2"] = "#000397", ["SN3"] = "#000398", ["SN4"] = "#000399",
    ["SN5"] = "#000400", ["SN6"] = "#000401", ["SN7"] = "#000402", ["SN8"] = "#000403",
    ["SN9"] = "#000404", ["SN0"] = "#000405", ["SN."] = "#000406", ["SN/"] = "#000407",
    ["SN*"] = "#000408", ["SN-"] = "#000409", ["SN+"] = "#000410",

    -- Alt + Ctrl + 右边的数字键和符号
    ["ACN1"] = "#000411", ["ACN2"] = "#000412", ["ACN3"] = "#000413", ["ACN4"] = "#000414",
    ["ACN5"] = "#000415", ["ACN6"] = "#000416", ["ACN7"] = "#000417", ["ACN8"] = "#000418",
    ["ACN9"] = "#000419", ["ACN0"] = "#000420", ["ACN."] = "#000421", ["ACN/"] = "#000422",
    ["ACN*"] = "#000423", ["ACN-"] = "#000424", ["ACN+"] = "#000425",

    -- Ctrl + Shift + 右边的数字键和符号
    ["CSN1"] = "#000426", ["CSN2"] = "#000427", ["CSN3"] = "#000428", ["CSN4"] = "#000429",
    ["CSN5"] = "#000430", ["CSN6"] = "#000431", ["CSN7"] = "#000432", ["CSN8"] = "#000433",
    ["CSN9"] = "#000434", ["CSN0"] = "#000435", ["CSN."] = "#000436", ["CSN/"] = "#000437",
    ["CSN*"] = "#000438", ["CSN-"] = "#000439", ["CSN+"] = "#000440",

    -- Alt + Shift + 右边的数字键和符号
    ["ASN1"] = "#000441", ["ASN2"] = "#000442", ["ASN3"] = "#000443", ["ASN4"] = "#000444",
    ["ASN5"] = "#000445", ["ASN6"] = "#000446", ["ASN7"] = "#000447", ["ASN8"] = "#000448",
    ["ASN9"] = "#000449", ["ASN0"] = "#000450", ["ASN."] = "#000451", ["ASN/"] = "#000452",
    ["ASN*"] = "#000453", ["ASN-"] = "#000454", ["ASN+"] = "#000455",

    -- [];'\,./ 单键映射
    ["["] = "#000456", ["]"] = "#000457", [";"] = "#000458", ["'"] = "#000459", ["\\"] = "#000460",
    [","] = "#000461", ["."] = "#000462", ["/"] = "#000463",

    -- Ctrl + [];'\,./ 键
    ["C["] = "#000464", ["C]"] = "#000465", ["C;"] = "#000466", ["C'"] = "#000467", ["C\\"] = "#000468",
    ["C,"] = "#000469", ["C."] = "#000470", ["C/"] = "#000471",

    -- Alt + [];'\,./ 键
    ["A["] = "#000472", ["A]"] = "#000473", ["A;"] = "#000474", ["A'"] = "#000475", ["A\\"] = "#000476",
    ["A,"] = "#000477", ["A."] = "#000478", ["A/"] = "#000479",

    -- Shift + [];'\,./ 键
    ["S["] = "#000480", ["S]"] = "#000481", ["S;"] = "#000482", ["S'"] = "#000483", ["S\\"] = "#000484",
    ["S,"] = "#000485", ["S."] = "#000486", ["S/"] = "#000487",

    -- Alt + Ctrl + [];'\,./ 键
    ["AC["] = "#000488", ["AC]"] = "#000489", ["AC;"] = "#000490", ["AC'"] = "#000491", ["AC\\"] = "#000492",
    ["AC,"] = "#000493", ["AC."] = "#000494", ["AC/"] = "#000495",

    -- Ctrl + Shift + [];'\,./ 键
    ["CS["] = "#000496", ["CS]"] = "#000497", ["CS;"] = "#000498", ["CS'"] = "#000499", ["CS\\"] = "#000500",
    ["CS,"] = "#000501", ["CS."] = "#000502", ["CS/"] = "#000503",

    -- Alt + Shift + [];'\,./ 键
    ["AS["] = "#000504", ["AS]"] = "#000505", ["AS;"] = "#000506", ["AS'"] = "#000507", ["AS\\"] = "#000508",
    ["AS,"] = "#000509", ["AS."] = "#000510", ["AS/"] = "#000511"
}

-- 技能宏分配颜色
local macrosColors = {
    "#000251", "#000252", "#000253", "#000254", "#000255", "#000256", 
    "#000257", "#000258", "#000259", "#000260", "#000261", "#000262",
    "#000263", "#000264", "#000265", "#000266", "#000267", "#000268",
    "#000269", "#000270", "#000271", "#000272", "#000273", "#000274",
    "#000276", "#000277", "#000279", "#000280", "#000281", "#000282",
    "#000283", "#000284", "#000285", "#000286", "#000287", "#000288",
    "#000289", "#000290", "#000291", "#000292", "#000294", "#000295",
    "#000296", "#000298", "#000299", "#000300",
    "#000488", "#000489", "#000490", "#000491", "#000492", "#000493", 
    "#000494", "#000495", "#000496", "#000497", "#000498", "#000499", 
    "#000500", "#000501", "#000502", "#000503", "#000504", "#000505", 
    "#000506", "#000507", "#000508", "#000509", "#000510", "#000511"
}

-- 创建并初始化UI框架
local frame = CreateFrame("Frame")
local colorBlock = CreateFrame("Frame", nil, UIParent)
colorBlock:SetSize(CONFIG.BLOCK_SIZE, CONFIG.BLOCK_SIZE)
colorBlock:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
colorBlock:SetFrameStrata("TOOLTIP")
colorBlock:Show()

local texture = colorBlock:CreateTexture()
texture:SetAllPoints()

-- 技能按键分配函数
local function GetNextKeyBinding(counter)
    local keyBindings = {
        -- Ctrl+Shift+数字和符号
        "CTRL-SHIFT-1", "CTRL-SHIFT-2", "CTRL-SHIFT-3", "CTRL-SHIFT-4", "CTRL-SHIFT-5", "CTRL-SHIFT-6", "CTRL-SHIFT-7", "CTRL-SHIFT-8", "CTRL-SHIFT-9", "CTRL-SHIFT-0",
        "CTRL-SHIFT--", "CTRL-SHIFT-=", -- 符号键: "-" 和 "="
    
        -- Ctrl+Shift+功能键
        "CTRL-SHIFT-F1", "CTRL-SHIFT-F2", "CTRL-SHIFT-F3", "CTRL-SHIFT-F4", "CTRL-SHIFT-F5", "CTRL-SHIFT-F6", "CTRL-SHIFT-F7", "CTRL-SHIFT-F8", "CTRL-SHIFT-F9", "CTRL-SHIFT-F10", "CTRL-SHIFT-F11", "CTRL-SHIFT-F12", -- 功能键
    
        -- Ctrl+Shift+字母键
        "CTRL-SHIFT-B", "CTRL-SHIFT-C", "CTRL-SHIFT-E", "CTRL-SHIFT-F", "CTRL-SHIFT-G", "CTRL-SHIFT-H", "CTRL-SHIFT-I", "CTRL-SHIFT-J", "CTRL-SHIFT-K", "CTRL-SHIFT-L", "CTRL-SHIFT-M", "CTRL-SHIFT-N", "CTRL-SHIFT-O", "CTRL-SHIFT-P", "CTRL-SHIFT-Q", "CTRL-SHIFT-R", "CTRL-SHIFT-T", "CTRL-SHIFT-U", "CTRL-SHIFT-V", "CTRL-SHIFT-X", "CTRL-SHIFT-Y", "CTRL-SHIFT-Z", -- 字母键
    
        -- Alt+Ctrl+[];'\,./ 键
        "ALT-CTRL-[", "ALT-CTRL-]", "ALT-CTRL-;", "ALT-CTRL-'","ALT-CTRL-\\", "ALT-CTRL-,", "ALT-CTRL-.", "ALT-CTRL-/",
    
        -- Ctrl+Shift+[];'\,./ 键
        "CTRL-SHIFT-[", "CTRL-SHIFT-]", "CTRL-SHIFT-;", "CTRL-SHIFT-'","CTRL-SHIFT-\\", "CTRL-SHIFT-,", "CTRL-SHIFT-.", "CTRL-SHIFT-/",
    
        -- Alt+Shift+[];'\,./ 键
        "ALT-SHIFT-[", "ALT-SHIFT-]", "ALT-SHIFT-;", "ALT-SHIFT-'","ALT-SHIFT-\\", "ALT-SHIFT-,", "ALT-SHIFT-.", "ALT-SHIFT-/",
    }

    -- 返回按键绑定（根据计数器）
    return keyBindings[counter] or ""
end

-- 十六进制颜色转换RGB
local function HexToRGBA(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255, 1
end

-- 颜色设置函数
local function setColor(hex)
    if lastColor ~= hex then
        texture:SetColorTexture(HexToRGBA(hex))
        lastColor = hex
    end
end

-- 创建宏按钮并保存颜色
local function HS_CreateMacroButton(framename, button, macrotext, spellname)
    if spellname ~= nil then
        -- 分配颜色（根据技能顺序循环分配颜色表中的颜色）
        local colorIndex = (#createdMacros % #macrosColors) + 1
        local color = macrosColors[colorIndex]
        
        -- 保存宏的技能 ID 和颜色
        table.insert(createdMacros, { name = spellname, macrotext = macrotext, color = color })
    end
    -- 其他宏创建逻辑保持不变
    frameCounter = frameCounter + 1
    local uniqueFrameName = framename.."_"..frameCounter

    -- 创建一个安全的按钮，确保它在战斗中也能执行
    local frame = CreateFrame("Button", uniqueFrameName, UIParent, "SecureActionButtonTemplate")
    frame:RegisterForClicks("AnyDown", "AnyUp")  -- 支持按下和松开都触发

    -- 设置按钮的属性为执行宏
    frame:SetAttribute("type", "macro")
    frame:SetAttribute("macrotext", macrotext)  -- 设置宏文本

    -- 取消原有按键绑定
    SetBinding(button, nil)

    -- 将指定的按键绑定到新的按钮点击事件
    SetBinding(button, "CLICK "..uniqueFrameName..":LeftButton")
end

-- 遍历技能并为每个技能创建一个宏按钮
local function CreateMacrosForSpells()
    -- 定义一个计数器用于技能的排序
    local spellCounter = 1

    -- 遍历所有技能行
    for i = 1, C_SpellBook.GetNumSpellBookSkillLines() do
        -- 获取第 i 行技能的信息
        local skillLineInfo = C_SpellBook.GetSpellBookSkillLineInfo(i)
        local offset, numSlots = skillLineInfo.itemIndexOffset, skillLineInfo.numSpellBookItems

        -- 遍历技能行中的所有技能槽
        for j = offset + 1, offset + numSlots do
            -- 获取技能信息
            local spellInfo = C_SpellBook.GetSpellBookItemInfo(j, Enum.SpellBookSpellBank.Player)
            local spellID = spellInfo.spellID
            local name = spellInfo.name
            local isPassive = spellInfo.isPassive
            local isOffSpec = spellInfo.isOffSpec

            -- 过滤掉被动技能
            if not isPassive and not isOffSpec then
                -- 获取下一组按键绑定
                local button = GetNextKeyBinding(spellCounter)

                -- 创建宏文本
                local macroText = "/cast " .. name  -- 创建宏文本

                -- 创建宏按钮，绑定到指定按键
                HS_CreateMacroButton("HS_SpellMacroButton", button, macroText, name)

                -- 打印调试信息
                --print(spellCounter, "名称:", name, "ID:", spellID, "按键:", button)

                -- 增加计数器
                spellCounter = spellCounter + 1
            end
        end
    end
end

-- 创建宏按钮并绑定到指定按键
local function CreatePaladinMacros()
    local macros = {
        {name = "HS_HEALING_POTION", key = "ALT-CTRL-F1", command = "/use 阿加治疗药水"},
        {name = "HS_SHIELD_OF_VENGEANCE", key = "ALT-CTRL-F2", command = "/cast 复仇之盾"},
        {name = "HS_DIVINE_PROTECTION", key = "ALT-CTRL-F3", command = "/cast 圣佑术"},
        {name = "HS_WORD_OF_GLORY", key = "ALT-CTRL-F5", command = "/cast [@player] 荣耀圣令"},
        {name = "HS_WORD_OF_GLORY_M", key = "ALT-CTRL-F6", command = "/cast [@mouseover] 荣耀圣令"},
        {name = "HS_FREE_BLESSING", key = "ALT-CTRL-F7", command = "/cast [@player] 自由祝福"},
        {name = "HS_FREE_BLESSING_M", key = "ALT-CTRL-F8", command = "/cast [@focus,exists] 自由祝福; [@targettarget,exists] 自由祝福; [@player] 自由祝福"},
        {name = "HS_RESURRECTION", key = "ALT-CTRL-F9", command = "/cast [@mouseover] 代祷"},
        {name = "HS_DIVINE_SHIELD", key = "ALT-CTRL-F10", command = "/cast 圣盾术"},
        {name = "HS_WILL_TO_SURVIVE", key = "ALT-CTRL-F11", command = "/cast 生存意志"},
        {name = "HS_BLESSED_HAMMER", key = "ALT-CTRL-F12", command = "/cast 祝福之锤"},
        {name = "HS_REBUKE_T", key = "ALT-SHIFT-F1", command = "/cast 责难"},
        {name = "HS_REBUKE_M", key = "ALT-SHIFT-F2", command = "/cast [@mouseover] 责难"},
        {name = "HS_SHIELD_OF_THE_RIGHTEOUS", key = "ALT-SHIFT-F3", command = "/cast 正义盾击"},
        {name = "HS_AVENGERS_SHIELD_T", key = "ALT-SHIFT-F5", command = "/cast 复仇者之盾"},
        {name = "HS_AVENGERS_SHIELD_M", key = "ALT-SHIFT-F6", command = "/cast [@mouseover] 复仇者之盾"},
        {name = "HS_BLESSING_OF_PROTECTION", key = "ALT-SHIFT-F7", command = "/cast [@targettarget,exists] 保护祝福"},
        {name = "HS_BLESSING_OF_SPELLWARDING", key = "ALT-SHIFT-F8", command = "/cast [@player] 破咒祝福"},
        {name = "HS_LAY_ON_HANDS", key = "ALT-SHIFT-F9", command = "/cast [@player] 圣疗术"},
        {name = "HS_LAY_ON_HANDS_1", key = "ALT-SHIFT-F10", command = "/cast [@party1,exists,nodead] 圣疗术"},
        {name = "HS_LAY_ON_HANDS_2", key = "ALT-SHIFT-F11", command = "/cast [@party2,exists,nodead] 圣疗术"},
        {name = "HS_LAY_ON_HANDS_3", key = "ALT-SHIFT-F12", command = "/cast [@party3,exists,nodead] 圣疗术"},
        {name = "HS_LAY_ON_HANDS_4", key = "CTRL-NUMPAD1", command = "/cast [@party4,exists,nodead] 圣疗术"},
        {name = "HS_CLEANSE_TOXINS", key = "CTRL-NUMPAD2", command = "/cast [@player] 清毒术"},
        {name = "HS_CLEANSE_TOXINS_1", key = "CTRL-NUMPAD3", command = "/cast [@party1,exists,nodead] 清毒术"},
        {name = "HS_CLEANSE_TOXINS_2", key = "CTRL-NUMPAD4", command = "/cast [@party2,exists,nodead] 清毒术"},
        {name = "HS_CLEANSE_TOXINS_3", key = "CTRL-NUMPAD5", command = "/cast [@party3,exists,nodead] 清毒术"},
        {name = "HS_CLEANSE_TOXINS_4", key = "CTRL-NUMPAD6", command = "/cast [@party4,exists,nodead] 清毒术"},
        {name = "HS_HAND_OF_RECKONING", key = "CTRL-NUMPAD7", command = "/cast 清算之手"},
        {name = "HS_HAND_OF_RECKONING_M", key = "CTRL-NUMPAD8", command = "/cast [@mouseover] 清算之手"},
        {name = "HS_HAMMER_OF_JUSTICE", key = "CTRL-NUMPAD9", command = "/cast [target=mouseover,harm,exists] 制裁之锤; 制裁之锤"},
        {name = "HS_BLINDING_LIGHT", key = "CTRL-NUMPAD0", command = "/cast 盲目之光"},
        {name = "HS_HEALTHSTONE", key = "ALT-NUMPAD1", command = "/use 治疗石"},
        {name = "HS_BLESSING_OF_SACRIFICE_1", key = "ALT-NUMPAD2", command = "/cast [@party1,exists,nodead] 牺牲祝福"},
        {name = "HS_BLESSING_OF_SACRIFICE_2", key = "ALT-NUMPAD3", command = "/cast [@party2,exists,nodead] 牺牲祝福"},
        {name = "HS_BLESSING_OF_SACRIFICE_3", key = "ALT-NUMPAD4", command = "/cast [@party3,exists,nodead] 牺牲祝福"},
        {name = "HS_BLESSING_OF_SACRIFICE_4", key = "ALT-NUMPAD5", command = "/cast [@party4,exists,nodead] 牺牲祝福"},
        {name = "HS_WORD_OF_GLORY_1", key = "ALT-NUMPAD6", command = "/cast [@party1,exists,nodead] 荣耀圣令"},
        {name = "HS_WORD_OF_GLORY_2", key = "ALT-NUMPAD7", command = "/cast [@party2,exists,nodead] 荣耀圣令"},
        {name = "HS_WORD_OF_GLORY_3", key = "ALT-NUMPAD8", command = "/cast [@party3,exists,nodead] 荣耀圣令"},
        {name = "HS_WORD_OF_GLORY_4", key = "ALT-NUMPAD9", command = "/cast [@party4,exists,nodead] 荣耀圣令"},
        {name = "HS_DEVOTION_AURA", key = "ALT-NUMPAD0", command = "/cast 虔诚光环"},
        {name = "HS_CRUSADER_AURA", key = "SHIFT-NUMPAD1", command = "/cast 十字军光环"},
        {name = "HS_Trinket", key = "SHIFT-NUMPAD2", command = "/use 13\n/use 14"},
        {name = "HS_TAB", key = "SHIFT-NUMPAD3", command = "/targetenemy [combat]"},
        {name = "HS_REBUKE_1", key = "SHIFT-NUMPAD4", command = "/cast [@party1target] 责难"},
        {name = "HS_REBUKE_2", key = "SHIFT-NUMPAD5", command = "/cast [@party2target] 责难"},
        {name = "HS_REBUKE_3", key = "SHIFT-NUMPAD6", command = "/cast [@party3target] 责难"},
        {name = "HS_REBUKE_4", key = "SHIFT-NUMPAD7", command = "/cast [@party4target] 责难"},
        {name = "HS_AVENGERS_SHIELD_1", key = "SHIFT-NUMPAD8", command = "/cast [@party1target] 复仇者之盾"},
        {name = "HS_AVENGERS_SHIELD_2", key = "SHIFT-NUMPAD9", command = "/cast [@party2target] 复仇者之盾"},
        {name = "HS_AVENGERS_SHIELD_3", key = "SHIFT-NUMPAD0", command = "/cast [@party3target] 复仇者之盾"},
        {name = "HS_AVENGERS_SHIELD_4", key = "ALT-CTRL-NUMPAD1", command = "/cast [@party4target] 复仇者之盾"},
        {name = "HS_HAMMER_OF_JUSTICE_T", key = "ALT-CTRL-NUMPAD2", command = "/cast 制裁之锤"},
        {name = "HS_HAMMER_OF_JUSTICE_M", key = "ALT-CTRL-NUMPAD3", command = "/cast [@mouseover] 制裁之锤"},
        {name = "HS_HAMMER_OF_JUSTICE_1", key = "ALT-CTRL-NUMPAD4", command = "/cast [@party1target] 制裁之锤"},
        {name = "HS_HAMMER_OF_JUSTICE_2", key = "ALT-CTRL-NUMPAD5", command = "/cast [@party2target] 制裁之锤"},
        {name = "HS_HAMMER_OF_JUSTICE_3", key = "ALT-CTRL-NUMPAD6", command = "/cast [@party3target] 制裁之锤"},
        {name = "HS_HAMMER_OF_JUSTICE_4", key = "ALT-CTRL-NUMPAD7", command = "/cast [@party4target] 制裁之锤"},
        {name = "HS_HAND_OF_RECKONING_1", key = "CTRL-SHIFT-NUMPAD1", command = "/cast [@party1target] 清算之手"},
        {name = "HS_HAND_OF_RECKONING_2", key = "CTRL-SHIFT-NUMPAD2", command = "/cast [@party2target] 清算之手"},
        {name = "HS_HAND_OF_RECKONING_3", key = "CTRL-SHIFT-NUMPAD3", command = "/cast [@party3target] 清算之手"},
        {name = "HS_HAND_OF_RECKONING_4", key = "CTRL-SHIFT-NUMPAD4", command = "/cast [@party4target] 清算之手"},
        {name = "HS_Intercession_1", key = "CTRL-SHIFT-NUMPAD5", command = "/cast [@party1,exists,dead] 代祷"},
        {name = "HS_Intercession_2", key = "CTRL-SHIFT-NUMPAD6", command = "/cast [@party2,exists,dead] 代祷"},
        {name = "HS_Intercession_3", key = "CTRL-SHIFT-NUMPAD7", command = "/cast [@party3,exists,dead] 代祷"},
        {name = "HS_Intercession_4", key = "CTRL-SHIFT-NUMPAD8", command = "/cast [@party4,exists,dead] 代祷"},
    }
    for _, macro in ipairs(macros) do
        HS_CreateMacroButton(macro.name, macro.key, macro.command)
        --print(macro.key..', '..macro.command)
    end
end

-- 获取当前专精的配置
local function GetCurrentSettings()
    return HSPlugin_Settings[GetSpecialization() or 0]
end

-- buff/debuff检查函数
local function HasAura(unit, auraName, isDebuff)
    isDebuff = isDebuff or false -- 如果isDebuff为空，则默认为false，即检查buff
    local filter = isDebuff and "HARMFUL" or "HELPFUL" -- 当isDebuff为true时使用减益，否则使用增益
    
    return AuraUtil.FindAuraByName(auraName, unit, filter) ~= nil

end

-- 技能冷却时间
local function GetSpellCooldownDuration(spellID)
    local cooldownInfo = GetSpellCooldown(spellID)
    if cooldownInfo then
        if cooldownInfo.startTime and cooldownInfo.duration then
            local currentTime = GetTime()
            local remainingCD = cooldownInfo.startTime + cooldownInfo.duration - currentTime
            return remainingCD > 0 and remainingCD or 0
        end
    end
    return 0
end

-- 检查技能是否准备好
local function IsSpellReady(spellID)
    local settings = GetCurrentSettings()
    -- 检查有没有学会该技能
	if not IsPlayerSpell(spellID) then return false end
	-- 检查法力值是否足够
    if select(2, IsSpellUsable(spellID)) then
        return false
    end

    local cooldown = GetSpellCooldownDuration(spellID)
    local _, gcdMS = GetSpellBaseCooldown(spellID)

    -- 如果技能没有冷却或者在GCD内即将结束冷却,则返回true
    return cooldown == 0 or (gcdMS ~= 0 and cooldown < settings.tqjnajThreshold)
end

-- 检查物品是否准备好
local function IsItemReady(itemIDorName)
    local startTime, duration, isCooldownEnabled = GetItemCooldown(itemIDorName)
    if not IsUsableItem(itemIDorName) then return false end
    if not isCooldownEnabled then return false end

    local currentTime = GetTime()
    return (startTime + duration) <= currentTime
end

-- 打断检查函数
local function GetCastingOrChannel(spellID)
    local settings = GetCurrentSettings()
    -- 不使用制裁之锤单位列表
    local noInterruptTargets = {
        ["锥喉鹿角巨虫"] = true,
        ["佐尔拉姆斯守门人"] = true,
        ["佐尔拉姆斯通灵师"] = true,
        ["骷髅劫掠者"] = true,
        ["纳祖达"] = true,
        ["缝合助理"] = true,
        ["艾什凡指挥官"] = true,
        ["苏雷吉网法师"] = true,
        ["夜幕司令官"] = true,
        ["伊克辛"] = true,
        ["纳克特"] = true,
        ["阿提克"] = true,
        ["鲜血监督者"] = true,
        ["安苏雷克的传令官"] = true,
        ["谢非提克"] = true,
        ["长者织影"] = true,
        ["英格拉·马洛克"] = true,
        ["唤雾者"] = true,
        ["阿玛厄斯"] = true,
        ["代言人布洛克"] = true,
        ["代言人夏多克朗"] = true,
        ["拉夏南"] = true,
        ["达加·燃影者"] = true,
    }

    -- 获取单位施法信息
    local function GetUnitCastInfo(unit)
        local name, _, _, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(unit)
        if name and not notInterruptible then
            local progress = math.floor(((GetTime() * 1000 - startTime) / (endTime - startTime)) * 100)
            return {
                casting = {name = name, startTime = startTime, endTime = endTime, progress = progress},
                channeling = nil
            }
        end

        name, _, _, startTime, endTime, _, notInterruptible = UnitChannelInfo(unit)
        if name and not notInterruptible then
            return {
                casting = nil,
                channeling = {name = name, startTime = startTime, endTime = endTime}
            }
        end

        return {casting = nil, channeling = nil}
    end

    -- 获取单位标识符
    local function GetUnitIdentifier(unit)
        if unit:find("party") then
            return unit:match("party(%d)")
        end
        return unit == "target" and "T" or unit == "mouseover" and "M" or unit
    end

    -- 检查单位是否可打断
    local function CanInterruptUnit(unit, target)
        return UnitExists(target) and 
               IsSpellInRange(spellID, target) and
               (spellID ~= 853 or 
                (not noInterruptTargets[UnitName(target)] and 
                 not UnitIsBossMob(target) and 
                 UnitLevel(target) < 82 and 
                 UnitName(target) ~= "扬升宝珠"))
    end

    local units = {"party1", "party2", "party3", "party4", "target", "mouseover"}
    local bestTarget = {endTime = math.huge, progress = -1, unit = nil}
    local channelTarget = nil

    for _, unit in ipairs(units) do
        if UnitExists(unit) then
            local target = unit:find("party") and unit.."target" or unit
            
            if CanInterruptUnit(unit, target) then
                local castInfo = GetUnitCastInfo(target)

                if castInfo.casting and (spellID == 31935 or castInfo.casting.progress > settings.daduanThreshold) then
                    if castInfo.casting.endTime < bestTarget.endTime then
                        bestTarget = {
                            endTime = castInfo.casting.endTime,
                            progress = castInfo.casting.progress,
                            unit = unit
                        }
                    end
                elseif castInfo.channeling and not channelTarget then
                    channelTarget = unit
                end
            end
        end
    end

    local targetUnit = bestTarget.unit or channelTarget
    if targetUnit then
        local id = GetUnitIdentifier(targetUnit)
        local spellPrefix = spellID == 96231 and "HS_REBUKE_" or
                           spellID == 31935 and "HS_AVENGERS_SHIELD_" or
                           spellID == 853 and "HS_HAMMER_OF_JUSTICE_"
        
        return spellPrefix and CONFIG.SPELL_COLORS[spellPrefix..id]
    end

    return nil
end

-- GCD时间
local function CalculateGCD()
    local _, class = UnitClass(player)
    local haste = GetHaste()

    -- 基础GCD计算
    local baseGCD = max(0.75, 1.5 * 100 / (100 + haste))

    -- 特殊职业和形态的GCD调整
    local specialClasses = { ROGUE = true, MONK = true, FERAL_DRUID = true }
    if specialClasses[class] then
        return 1.0
    elseif class == "DRUID" then
        local form = GetShapeshiftFormID()
        if form == 1 then
            return 1.0
        end
    end

    return baseGCD
end

-- 获取失去控制文本
local function GetActiveLossOfControl()
    local numLossOfControl = GetActiveLossOfControlDataCount()

    for i = 1, numLossOfControl do
        local lossOfControlData = GetActiveLossOfControlData(i)

        if lossOfControlData then
            return lossOfControlData.displayText
        end
    end
    return nil
end

-- 判断单位是否在队伍里面或者团队里面
local function IsInMyGroupOrRaid(unit)
    -- 如果不是友方单位，直接返回false
    if not UnitIsFriend("player", unit) then
        return false
    end

    -- 使用WoW API直接检查单位是否在队伍或团队中
    return UnitInParty(unit) or UnitInRaid(unit)
end

-- 圣疗自己和队友
local function checkHealthAndLayOnHands()
    local settings = GetCurrentSettings()
    local spellColors = CONFIG.SPELL_COLORS
    local spellIds = CONFIG.SPELL_IDS
	
    -- 辅助函数：检查单位是否符合施法条件
    local function canLayOnHands(unit)
        return UnitExists(unit) and not HasAura(unit, "自律", true) and 
               not UnitIsDeadOrGhost(unit) and UnitIsVisible(unit) and
               IsSpellInRange(spellIds.LAY_ON_HANDS, unit)
    end

    -- 判断自己是否需要圣疗术
    if settings.healSelf and canLayOnHands(player) then
        local playerHealthPercent = UnitHealth(player) / UnitHealthMax(player) * 100
        if playerHealthPercent < settings.healSelfThreshold then
            return spellColors.LAY_ON_HANDS
        end
    end

    -- 遍历队友寻找血量最低的队友
    local lowestHealth = settings.healAllyThreshold
    local targetIndex
    
    for i = 1, 4 do
        local unit = "party"..i
        
        -- 检查单位是否存在且没有自律
        if UnitExists(unit) and not HasAura(unit, "自律", true) and 
           not UnitIsDeadOrGhost(unit) and UnitIsVisible(unit) and
           IsSpellInRange(spellIds.LAY_ON_HANDS, unit) then
            
            local healthPercent = UnitHealth(unit) / UnitHealthMax(unit) * 100
            if healthPercent < lowestHealth then
                lowestHealth = healthPercent
                targetIndex = i
            end
        end
    end

    -- 返回对应的法术颜色或nil
    return targetIndex and spellColors["LAY_ON_HANDS_"..targetIndex] or nil
end

-- 牺牲祝福队友
local function checkBlessingofSacrifice()
    local settings = GetCurrentSettings()
    local spellColors = CONFIG.SPELL_COLORS
    local lowestHealth = settings.blessingSacrificeThreshold
    local targetIndex

    -- 遍历队友寻找血量最低的队友
    for i = 1, 4 do
        local unit = "party"..i
        -- 判断单位是否存在且存活,在施法范围内并且可见
        if UnitExists(unit) and not UnitIsDeadOrGhost(unit) and 
           IsSpellInRange(6940, unit) and UnitIsVisible(unit) then
            
            local healthPercent = UnitHealth(unit) / UnitHealthMax(unit) * 100
            -- 筛选血量最低且低于阈值的队友
            if healthPercent < lowestHealth then
                lowestHealth = healthPercent
                targetIndex = i
            end
        end
    end

    -- 返回对应的法术颜色或nil
    return targetIndex and spellColors["BLESSING_OF_SACRIFICE_"..targetIndex] or nil
end

-- 荣耀圣令自己和队友
local function checkWordofGlory()
    local settings = GetCurrentSettings()
    local spellColors = CONFIG.SPELL_COLORS
    local holyPower = UnitPower(player, Enum.PowerType.HolyPower)
    local playerHealth = UnitHealth(player) / UnitHealthMax(player) * 100
    local hasHolyBuff = HasAura(player, "闪耀之光") or HasAura(player, "神圣意志")
    local hasEnoughPower = not settings.glorySelf_2 and holyPower >= 3

    -- 检查自身是否需要荣耀圣令
    if settings.glorySelf and playerHealth < settings.glorySelfThreshold then
        if hasHolyBuff or hasEnoughPower then
            return spellColors.WORD_OF_GLORY
        end
    end

    -- 检查队友是否需要荣耀圣令
    if settings.gloryAlly and (hasHolyBuff or (not settings.gloryAlly_2 and holyPower >= 3)) then
        local lowestHealth = 100
        local targetIndex

        for i = 1, 4 do
            local unit = "party"..i
            if UnitExists(unit) and not UnitIsDeadOrGhost(unit) and 
               IsSpellInRange(85673, unit) and UnitIsVisible(unit) then
                
                local healthPercent = UnitHealth(unit) / UnitHealthMax(unit) * 100
                if healthPercent < settings.gloryAllyThreshold and healthPercent < lowestHealth then
                    lowestHealth = healthPercent
                    targetIndex = i
                end
            end
        end

        if targetIndex then
            return spellColors["WORD_OF_GLORY_"..targetIndex]
        end
    end

    return nil
end

-- 战复队友
local function checkIntercession()
    local settings = GetCurrentSettings()
    -- 获取玩家的职业和天赋ID
    local specID = GetSpecialization()
    local id = GetSpecializationInfo(specID)
    
    -- 检查圣骑士职业和圣能条件
    if id == 66 and UnitPower(player, Enum.PowerType.HolyPower) < 3 then
        return nil
    end

    -- 辅助函数：检查单位是否符合复活条件
    local function canResurrect(unit)
        return UnitExists(unit) and 
               UnitIsDeadOrGhost(unit) and 
               IsInMyGroupOrRaid(unit) and 
               not UnitHasIncomingResurrection(unit) and
               IsSpellInRange(391054, unit) and 
               UnitIsVisible(unit)
    end

    -- 鼠标指向模式
    if settings.zhanfuSetting == "鼠标指向" then
        if canResurrect(mouseover) then
            return CONFIG.SPELL_COLORS.RESURRECTION
        end
        return nil
    end

    -- 自动模式
    if settings.zhanfuSetting == "自动" then
        for i = 1, 4 do
            local unit = "party"..i
            if canResurrect(unit) then
                return CONFIG.SPELL_COLORS["Intercession_"..i]
            end
        end
    end

    return nil
end

-- 驱散队友和自己
local function CheckPartyForPoisonOrDisease()
    local spellColors = CONFIG.SPELL_COLORS
    local CLEANSE_TOXINS = CONFIG.SPELL_IDS.CLEANSE_TOXINS

    -- 辅助函数：检查单位是否有中毒或疾病 debuff
    local function hasPoisonOrDisease(unit)
        if not unit then return false end
        
        -- 使用 AuraUtil.ForEachAura 遍历单位的 debuff
        local hasDebuff = false
        AuraUtil.ForEachAura(unit, "HARMFUL", nil, function(_, _, _, debuffType)
            if debuffType == "Poison" or debuffType == "Disease" then
                hasDebuff = true
                return true -- 终止遍历
            end
        end)
        return hasDebuff
    end

    -- 获取玩家的职业和天赋ID
    local specID = GetSpecialization()
    if not specID then return nil end
    
    local id = GetSpecializationInfo(specID)
    if not id then return nil end

    -- 优先驱散顺序：惩戒骑士优先自己，然后队友；其他职业优先队友，再自己
    local checkPriority = (id == 70 or id == 65) and {player, "party1", "party2", "party3", "party4"} or {"party1", "party2", "party3", "party4", player}

    -- 辅助函数：返回施法颜色
    local function getSpellColor(unit)
        if unit == player then
            return spellColors.CLEANSE_TOXINS
        else
            local index = tonumber(unit:match("party(%d)"))
            if index then
                return spellColors["CLEANSE_TOXINS_" .. index]
            end
        end
    end

    -- 遍历检查队友和玩家的 debuff
    for _, unit in ipairs(checkPriority) do
        if UnitExists(unit) and IsSpellInRange(CLEANSE_TOXINS, unit) and UnitIsVisible(unit) and hasPoisonOrDisease(unit) then
            return getSpellColor(unit)
        end
    end

    -- 如果没有发现需要驱散的 debuff，返回 nil
    return nil
end

-- 嘲讽检查函数
local function GetTauntTarget(spellID)
    local spellColors = CONFIG.SPELL_COLORS
    -- 不使用嘲讽的目标列表
    local noTauntTargets = {
        ["扬升宝珠"] = true,
        ["水晶碎片"] = true,
    }

    -- 检查单位是否可以嘲讽
    local function CanTauntUnit(unit)
        if not UnitExists(unit) then return false end
        
        local threatInfo = UnitThreatSituation(player, unit)
        return threatInfo and threatInfo <= 2 and 
               UnitAffectingCombat(unit) and
               IsSpellInRange(spellID, unit) and
               not noTauntTargets[UnitName(unit)]
    end

    -- 获取嘲讽颜色代码
    local function GetTauntColor(unit)
        if unit:find("party") then
            return spellColors["HAND_OF_RECKONING_"..unit:match("party(%d)")]
        elseif unit == "target" then
            return spellColors.HAND_OF_RECKONING_T
        elseif unit == "mouseover" then
            return spellColors.HAND_OF_RECKONING_M
        end
    end

    -- 辅助函数：检查并返回嘲讽颜色
    local function CheckAndReturnColor(unit)
        local target = unit:find("party") and unit.."target" or unit
        if CanTauntUnit(target) then
            return GetTauntColor(unit)
        end
    end

    -- 按优先级检查目标
    local units = {"target", "mouseover", "party1", "party2", "party3", "party4"}
    
    for _, unit in ipairs(units) do
        local color = CheckAndReturnColor(unit)
        if color then
            return color
        end
    end

    return nil
end

-- 惩戒专精检查函数
local function handleDangerousMechanicsCJ()
    local settings = GetCurrentSettings()
    local pSpeed = GetUnitSpeed(player) / 7 * 100
    local targetCast = UnitCastingInfo(target)
    local targetChannel = UnitChannelInfo(target)
    local hpP = UnitHealth(player) / UnitHealthMax(player) * 100
    local spellIds = CONFIG.SPELL_IDS
    local spellColors = CONFIG.SPELL_COLORS

    -- 生存意志检查
    if UnitRace(player) == "人类" and GetActiveLossOfControl() == "昏迷" and IsSpellReady(spellIds.WILL_TO_SURVIVE) then
        return spellColors.WILL_TO_SURVIVE
    end

    -- 圣疗术
    if IsPlayerSpell(spellIds.LAY_ON_HANDS) then
        local hasGlyph = IsPlayerSpell(387791)
        local spellId = hasGlyph and spellIds.LAY_ON_HANDS2 or spellIds.LAY_ON_HANDS
        
        if GetSpellCooldownDuration(spellId) == 0 then
            local lohColor = checkHealthAndLayOnHands()
            if lohColor then return lohColor end
        end
    end

    -- 治疗石检查
    if settings.healingStone and IsItemReady("治疗石") and hpP < settings.healingStoneThreshold then
        return spellColors.HEALTHSTONE
    end

    -- 治疗药水检查
    if settings.agraPotion and IsItemReady("治疗药水") and hpP < settings.agraPotionThreshold then
        return spellColors.HEALING_POTION
    end

    -- 打断检查
    if settings.daduan and IsSpellReady(spellIds.REBUKE) then
        local CCRColor = GetCastingOrChannel(spellIds.REBUKE)
        if CCRColor then return CCRColor end
    end

    -- 防御技能检查
    local needDefense = (UnitIsUnit("targettarget", player) and tContains(CONFIG.DANGEROUS_SPELLS.playerCasts, targetCast)) or
                       tContains(CONFIG.DANGEROUS_SPELLS.casts, targetCast) or
                       tContains(CONFIG.DANGEROUS_SPELLS.channels, targetChannel) or
                       HasAura(player, "折光射线", true) or
                       HasAura(player, "腐蚀", true) or
                       HasAura(player, "深渊腐蚀", true) or
                       HasAura(player, "艾泽里特炸药", true)

    if needDefense then
        if IsSpellReady(spellIds.SHIELD_OF_VENGEANCE) then
            return spellColors.SHIELD_OF_VENGEANCE
        elseif IsSpellReady(spellIds.DIVINE_PROTECTION) then
            return spellColors.DIVINE_PROTECTION
        end
    end

    -- 圣盾术血量
    if IsSpellReady(spellIds.DIVINE_SHIELD) and (not HasAura(player, "自律", true) or (IsPlayerSpell(146956) and HasAura(player, "自律", true))) then
        if HasAura(player, "过度生长", true) or (settings.dsSelf and hpP < settings.dsSelfThreshold) then
            return spellColors.DIVINE_SHIELD
        end
    end

    -- 圣佑术血量
    if IsSpellReady(spellIds.DIVINE_PROTECTION) and
       settings.sysSelf and hpP < settings.sysSelfThreshold then
        return spellColors.DIVINE_PROTECTION
    end

    -- 复仇之盾
    if IsSpellReady(spellIds.SHIELD_OF_VENGEANCE) and
       settings.fczdSelf and hpP < settings.fczdSelfThreshold then
        return spellColors.SHIELD_OF_VENGEANCE
    end

    -- 荣耀圣令检查
    if IsSpellReady(spellIds.WORD_OF_GLORY) and hpP < 70 then
        local debuffList = {"腐败之水", "深渊轰击", "深渊腐蚀", "腐蚀", "熔岩重炮", "寒冰镰刀"}
        for _, debuff in ipairs(debuffList) do
            if HasAura(player, debuff, true) then
                return spellColors.WORD_OF_GLORY
            end
        end
    end

    -- 保护祝福检查
    if IsSpellReady(spellIds.BLESSING_OF_PROTECTION) and UnitCastingInfo(target) == "病态凝视" then
        return spellColors.BLESSING_OF_PROTECTION
    end

    -- 牺牲祝福检查
    if settings.blessingSacrifice and IsSpellReady(spellIds.BLESSING_OF_SACRIFICE) then
        local BOSColor = checkBlessingofSacrifice()
        if BOSColor then return BOSColor end
    end

    -- 清毒术
    if settings.qusan and IsSpellReady(spellIds.CLEANSE_TOXINS) and UnitName("boss1") ~= "收割者吉卡塔尔" then
        local dangerColorCT = CheckPartyForPoisonOrDisease()
        if dangerColorCT then return dangerColorCT end
        if settings.qscz and HasAura(player, "虚空裂隙", true) then
            return spellColors.CLEANSE_TOXINS
        end
    end

    -- 荣耀圣令自己和队友
    if IsSpellReady(spellIds.WORD_OF_GLORY) then
        local WOGColor = checkWordofGlory()
        if WOGColor then return WOGColor end
    end

    -- 制裁之锤打断检查
    if settings.zczcdd and IsSpellReady(spellIds.HAMMER_OF_JUSTICE) then
        local HOJColor = GetCastingOrChannel(spellIds.HAMMER_OF_JUSTICE)
        if HOJColor then return HOJColor end
    end

    -- 自由祝福检查
    if settings.ziyou and IsSpellReady(spellIds.FREE_BLESSING) then
        if ((tContains(CONFIG.MOVEMENT_IMPAIRING_CASTS, targetCast) or UnitCastingInfo("boss2") == "寒冰镰刀")) then
            return spellColors.FREE_BLESSING_M
        end
        if (GetActiveLossOfControl() == "被定身" or (IsPlayerMoving() and pSpeed > 0 and pSpeed < 60)) and 
           UnitName("boss1") ~= "收割者吉卡塔尔" then
            return spellColors.FREE_BLESSING
        end
    end

    -- 战复
    if settings.zhanfu and IsSpellReady(spellIds.RESURRECTION) then
        local ZFColor = checkIntercession()
        if ZFColor then return ZFColor end
    end

    return nil
end

-- 防骑专精检查函数
local function handleDangerousMechanicsFQ()
    local settings = GetCurrentSettings()
    local pSpeed = GetUnitSpeed(player) / 7 * 100
    local hpP = UnitHealth(player) / UnitHealthMax(player) * 100
    local targetCast = UnitCastingInfo(target)
    local spellIds = CONFIG.SPELL_IDS
    local spellColors = CONFIG.SPELL_COLORS
    local inInstance, instanceType = IsInInstance()

    --s 生存意志检查
    if UnitRace(player) == "人类" and GetActiveLossOfControl() == "昏迷" and IsSpellReady(spellIds.WILL_TO_SURVIVE) then
        return spellColors.WILL_TO_SURVIVE
    end

    -- 嘲讽
    if IsSpellReady(spellIds.HAND_OF_RECKONING) and inInstance and instanceType == "party" then
        local HORColor = GetTauntTarget(spellIds.HAND_OF_RECKONING)
        if HORColor then return HORColor end
    end

    -- 圣疗术
    if IsPlayerSpell(spellIds.LAY_ON_HANDS) then
        local hasGlyph = IsPlayerSpell(387791)
        local spellId = hasGlyph and spellIds.LAY_ON_HANDS2 or spellIds.LAY_ON_HANDS
        
        if GetSpellCooldownDuration(spellId) == 0 then
            local lohColor = checkHealthAndLayOnHands()
            if lohColor then return lohColor end
        end
    end

    -- 治疗石检查
    if settings.healingStone and IsItemReady("治疗石") and hpP < settings.healingStoneThreshold then
        return spellColors.HEALTHSTONE
    end

    -- 治疗药水检查
    if settings.agraPotion and IsItemReady("治疗药水") and hpP < settings.agraPotionThreshold then
        return spellColors.HEALING_POTION
    end

    -- 打断检查
    if settings.daduan and IsSpellReady(spellIds.REBUKE) then
        local CCRColor = GetCastingOrChannel(spellIds.REBUKE)
        if CCRColor then return CCRColor end
    end

    -- 牺牲祝福检查
    if settings.blessingSacrifice and IsSpellReady(spellIds.BLESSING_OF_SACRIFICE) then
        local BOSColor = checkBlessingofSacrifice()
        if BOSColor then return BOSColor end
    end

    -- 圣盾术血量
    if settings.dsSelf and hpP < settings.dsSelfThreshold and IsSpellReady(spellIds.DIVINE_SHIELD) and
       (not HasAura(player, "自律", true) or (IsPlayerSpell(146956) and HasAura(player, "自律", true))) then
        return spellColors.DIVINE_SHIELD
    end

    -- 应对尖刺技能
    if not HasAura(player, "信仰圣光") and IsSpellReady(spellIds.WORD_OF_GLORY) then
        local dangerousCasts = {
            "震地猛击", "火成岩锤", "暗影爪击", -- 宝库
            "黑曜光束", "恐惧猛击", -- 破晨
            "压制", "霜凝匕首", "汰劣程序", -- 千丝
            "嚼碎", "毁伤", -- 通灵
            "熔火乱舞", "碎颅打击", "熔岩之拳", "暗影烈焰斩", "碾碎", "噬体烈焰", -- 巴托
            "贪食撕咬", -- 回响
            "钢刃之歌" -- 围攻
        }

        if tContains(dangerousCasts, UnitCastingInfo(target)) then
            return spellColors.WORD_OF_GLORY
        end
    end

    -- 保护祝福检查
    if IsSpellReady(spellIds.BLESSING_OF_PROTECTION) and UnitCastingInfo(target) == "病态凝视" then
        return spellColors.BLESSING_OF_PROTECTION
    end

    -- 清毒术
    if settings.qusan and IsSpellReady(spellIds.CLEANSE_TOXINS) and UnitName("boss1") ~= "收割者吉卡塔尔" then
        local dangerColorCT = CheckPartyForPoisonOrDisease()
        if dangerColorCT then return dangerColorCT end
        if settings.qscz and HasAura(player, "虚空裂隙", true) then
            return spellColors.CLEANSE_TOXINS
        end
    end

    -- 荣耀圣令自己和队友
    if IsSpellReady(spellIds.WORD_OF_GLORY) then
        local WOGColor = checkWordofGlory()
        if WOGColor then return WOGColor end
    end

    -- 制裁之锤打断检查
    if settings.zczcdd and IsSpellReady(spellIds.HAMMER_OF_JUSTICE) then
        local HOJColor = GetCastingOrChannel(spellIds.HAMMER_OF_JUSTICE)
        if HOJColor then return HOJColor end
    end

    -- 复仇者之盾打断检查
    if IsSpellReady(spellIds.AVENGERS_SHIELD) then
        local CCAColor = GetCastingOrChannel(spellIds.AVENGERS_SHIELD)
        if CCAColor then return CCAColor end
    end

    -- 自由祝福检查
    if settings.ziyou and IsSpellReady(spellIds.FREE_BLESSING) then
        if ((tContains(CONFIG.MOVEMENT_IMPAIRING_CASTS, targetCast) or UnitCastingInfo("boss2") == "寒冰镰刀")) then
            return spellColors.FREE_BLESSING_M
        end
        if (GetActiveLossOfControl() == "被定身" or (IsPlayerMoving() and pSpeed > 0 and pSpeed < 60)) and 
           UnitName("boss1") ~= "收割者吉卡塔尔" then
            return spellColors.FREE_BLESSING
        end
    end

    -- 战复
    if settings.zhanfu and IsSpellReady(spellIds.RESURRECTION) then
        local ZFColor = checkIntercession()
        if ZFColor then return ZFColor end
    end

    return nil
end

-- 插入技能配置表
local SPELL_STATE = {
    DIVINE_SHIELD = {
        name = "圣盾术",
        failed = false,
        color = CONFIG.SPELL_COLORS.DIVINE_SHIELD,
        spellId = CONFIG.SPELL_IDS.DIVINE_SHIELD
    },
    BLESSING_OF_SPELLWARDING = {
        name = "破咒祝福",
        failed = false,
        color = CONFIG.SPELL_COLORS.BLESSING_OF_SPELLWARDING,
        spellId = CONFIG.SPELL_IDS.BLESSING_OF_SPELLWARDING
    },
    HAMMER_OF_JUSTICE = {
        name = "制裁之锤",
        failed = false,
        color = CONFIG.SPELL_COLORS.HAMMER_OF_JUSTICE,
        spellId = CONFIG.SPELL_IDS.HAMMER_OF_JUSTICE
    },
    BLINDING_LIGHT = {
        name = "盲目之光",
        failed = false,
        color = CONFIG.SPELL_COLORS.BLINDING_LIGHT,
        spellId = CONFIG.SPELL_IDS.BLINDING_LIGHT
    }
}

-- 主检查函数
local function CheckHekiliKeybindings()
    local settings = GetCurrentSettings()
    local spellIds = CONFIG.SPELL_IDS
    local spellColors = CONFIG.SPELL_COLORS
    local specID = GetSpecialization()
    local inInstance, instanceType = IsInInstance()

    -- 提前返回条件检查
    if ChatFrame1EditBoxFocusMid:IsVisible() or UnitInVehicle(player) or 
       UnitCastingInfo(player) or UnitIsDeadOrGhost(player) then
        setColor(CONFIG.DEFAULT_COLOR)
        zhuanzhuanTime = GetTime()
        return
    end

    -- 光环检查
    if settings.guanghuan and UnitClass(player) == "圣骑士" then
        local isMounted = IsMounted()
        local auraToCheck = isMounted and "十字军光环" or "虔诚光环"
        local auraColor = isMounted and spellColors.CRUSADER_AURA or spellColors.DEVOTION_AURA
        if not HasAura(player, auraToCheck) then
            setColor(auraColor)
            return
        end
    end

    -- 快速退出条件
    if not (Hekili and Hekili.DB and Hekili.DB.profile and Hekili.DB.profile.displays) or IsMounted() then
        setColor(CONFIG.DEFAULT_COLOR)
        return
    end

    -- 按键处理
    if not (IsKeyDown("LCTRL") or IsKeyDown("LALT") or IsKeyDown("LSHIFT")) then
        local currentTime = GetTime()
        
        -- 检查是否有失败的技能
        for _, spell in pairs(SPELL_STATE) do
            if spell.failed then
                startTimeCR = currentTime
                spell.failed = false
                isReturning = true
                buttonColor = spell.color
                break
            end
        end
        
        if isReturning and (currentTime - startTimeCR < CalculateGCD()) and not chengong then
            setColor(buttonColor)
            return
        end
        isReturning = false
    end

    -- 专精检查
    if not specID then
        setColor(CONFIG.DEFAULT_COLOR)
        return
    end

    local id = GetSpecializationInfo(specID)
    local inCombat = UnitAffectingCombat(player)

    -- 战斗中检查
    if inCombat then
        -- 目标切换检查
        if settings.autoTAB then
            if UnitIsFriend(player, target) or not UnitExists(target) or 
               UnitIsDead(target) or UnitName(target) == "扬升宝珠" then
                setColor(spellColors.HS_TAB)
                return
            end
        end

        -- 专精相关处理
        local dangerColor = (id == 70) and handleDangerousMechanicsCJ() or (id == 66) and handleDangerousMechanicsFQ()
        if dangerColor then
            setColor(dangerColor)
            return
        end
    else
        -- 非战斗状态防骑处理
        if id == 66 and inInstance and (instanceType == "raid" or instanceType == "party") and 
           (GetTime() - zhuanzhuanTime > CalculateGCD()) then
            local holyPower = UnitPower(player, Enum.PowerType.HolyPower)
            local blessedHammerCharges = GetSpellCharges(spellIds.BLESSED_HAMMER).currentCharges

            if blessedHammerCharges > 1 and IsSpellReady(spellIds.BLESSED_HAMMER) and holyPower < 5 then
                setColor(spellColors.BLESSED_HAMMER)
                return
            end
            if holyPower == 5 and IsSpellReady(spellIds.SHIELD_OF_THE_RIGHTEOUS) then
                setColor(spellColors.SHIELD_OF_THE_RIGHTEOUS)
                return
            end
        end
    end

    -- Hekili按键绑定检查
    if inCombat and UnitExists(target) then
        for id, display in pairs(Hekili.DB.profile.displays) do
            local displayFrame = _G["HekiliDisplay" .. id]
            if displayFrame and displayFrame.Buttons then
                local button = displayFrame.Buttons[1]
                if button then
                    if button.Ability and button.Ability.id and GetSpellCooldownDuration(button.Ability.id) > settings.tqjnajThreshold then
                        setColor(CONFIG.DEFAULT_COLOR)
                        return
                    end

                    if button.Keybinding and button.Keybinding:GetText() then
                        local color = KEYBIND_COLORS[button.Keybinding:GetText()]
                        if color then
                            setColor(color)
                            return
                        end
                    end

                    if button.Ability then
                        if button.Ability.item then
                            setColor(spellColors.HS_Trinket)
                            return
                        elseif button.Ability.id then
                            local hekiliAbilityID = FindBaseSpellByID(button.Ability.id)
                            for _, macro in ipairs(createdMacros) do
                                if macro and macro.name and 
                                   (macro.name == GetSpellName(hekiliAbilityID) or 
                                    GetSpellTexture(macro.name) == GetSpellTexture(hekiliAbilityID)) then
                                    setColor(macro.color)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    setColor(CONFIG.DEFAULT_COLOR)
end

-- 注册事件
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("TRAIT_CONFIG_UPDATED")
    
-- 事件处理函数
frame:SetScript("OnEvent", function(self, event, ...)
    -- 刷新脚本更新频率
    local settings = GetCurrentSettings()
    if ticker and oldThreshold ~= settings.jbgxplThreshold then
        ticker:Cancel()
        ticker = C_Timer.NewTicker(settings.jbgxplThreshold, CheckHekiliKeybindings)
        oldThreshold = settings.jbgxplThreshold
    end
    
    if event == "PLAYER_ENTERING_WORLD" then
        -- 创建技能宏
        CreateMacrosForSpells()
        -- 创建骑士宏
        CreatePaladinMacros()
        ticker = C_Timer.NewTicker(settings.jbgxplThreshold, CheckHekiliKeybindings)
        oldThreshold = settings.jbgxplThreshold
    elseif event == "TRAIT_CONFIG_UPDATED" then
        -- 天赋更新时重新创建宏
        CreateMacrosForSpells()
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        -- 获取当前战斗日志事件信息
        local _, subevent, _, sourceGUID, _, _, _, _, _, _, _, _, spellName, _, _, _, _, _ = CombatLogGetCurrentEventInfo()
        --只有自己技能事件
        if sourceGUID == UnitGUID(player) then
            -- 技能成功事件
            if subevent == "SPELL_CAST_SUCCESS" then
                chengong = true
                -- 重置所有技能失败状态
                for _, spell in pairs(SPELL_STATE) do
                    spell.failed = false
                end
            -- 技能失败事件
            elseif subevent == "SPELL_CAST_FAILED" then
                local gcd = GetSpellCooldownDuration(61304)
                --print("技能使用失败：" .. spellName .. " (ID: " .. spellId .. ")")
                chengong = false
                
                -- 检查失败的技能
                for _, spell in pairs(SPELL_STATE) do
                    if spellName == spell.name and not spell.failed and 
                       GetSpellCooldownDuration(spell.spellId) <= gcd then
                        spell.failed = true
                        break
                    end
                end
            end
        end
    end
end)