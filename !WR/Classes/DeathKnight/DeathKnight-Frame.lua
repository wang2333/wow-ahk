local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 72;
    local c = 79;
    local d = 54;
    local e = 86;
    local f = 89;
    local g = 41;
    local h = 48;
    local i = 19;
    local j = 59;
    local k = 98;
    local l = 13;
    local m = 32;
    local n = 67;
    local o = "g"
    local p = "m"
    local q = "n"
    local r = "a"
    local s = "b"
    local t = "p"
    local u = "r"
    local v = "s"
    local w = "t"
    local x = "c"
    local y = "o"
    local z = "u"
    local A = "h"
    local B = "d"
    local C = "e"
    local D = "i"
    local E = "k"
    local F = "l"
    local G = "y"
    local H = "w"
    local I = a[8][w .. r .. s .. F .. C][x .. y .. q .. x .. r .. w]
    local J = a[8][p .. r .. w .. A][F .. B .. C .. a[2] .. t] or a[8][p .. r .. w .. A][v .. x .. r .. F .. C]
    local K = v .. w .. u .. D .. q .. o;
    local L = a[8][v .. C .. w .. p .. C .. w .. r .. w .. r .. s .. F .. C]
    local M = a[8][K][v .. z .. s]
    local N = a[8][K][x .. A .. r .. u]
    local O = a[8][v .. C .. F .. C .. x .. w]
    local P = a[8][K][s .. G .. w .. C]
    local Q = function()
        return a[8]
    end;
    local R = a[8][w .. r .. s .. F .. C][z .. q .. t .. r .. x .. E] or a[8][z .. q .. t .. r .. x .. E]
    local S = a[8][K][o .. v .. z .. s]
    local T = a[8][w .. y .. q .. z .. p .. s .. C .. u]
    local function U(V)
        local W, X, Y = "", "", {}
        local Z = 256;
        local _ = {}
        if V == u then
            return X
        end
        for a0 = 0, Z - 1 do
            _[a0] = N(a0)
        end
        local a1 = 1;
        local function a2()
            local a3 = T(M(V, a1, a1), 36)
            a1 = a1 + 1;
            local a4 = T(M(V, a1, a1 + a3 - 1), 36)
            a1 = a1 + a3;
            return a4
        end
        W = N(a2())
        Y[1] = W;
        while a1 < #V do
            local a5 = a2()
            if _[a5] then
                X = _[a5]
            else
                X = W .. M(W, 1, 1)
            end
            _[Z] = W .. M(X, 1, 1)
            Y[#Y + 1], W, Z = X, X, Z + 1
        end
        return I(Y)
    end
    local l = a[10]
    local a6 = a[8][s .. D .. w] and a[8][s .. D .. w][s .. a[2] .. y .. u] or function(a7, V)
        local a8, W = 1, 0;
        while a7 > 0 and V > 0 do
            local a9, aa = a7 % 2, V % 2;
            if a9 ~= aa then
                W = W + a8
            end
            a7, V, a8 = (a7 - a9) / 2, (V - aa) / 2, a8 * 2
        end
        if a7 < V then
            a7 = V
        end
        while a7 > 0 do
            local a9 = a7 % 2;
            if a9 > 0 then
                W = W + a8
            end
            a7, a8 = (a7 - a9) / 2, a8 * 2
        end
        return W
    end;
    local ab = l .. a[15]
    local ac = Q()
    local ad = l .. a[5]
    local function ae(af, ag, ah)
        if ah then
            local ai = af / 2 ^ (ag - 1) % 2 ^ (ah - 1 - (ag - 1) + 1)
            return ai - ai % 1
        else
            local aj = 2 ^ (ag - 1)
            return af % (aj + aj) >= aj and 1 or 0
        end
    end
    local ak = l .. a[9]
    local al = 1;
    local am = l .. a[14]
    local an = U(u)
    local ao = l .. a[1]
    local function ap()
        local aq, ar, as, at = P(an, al, al + 3)
        aq = a6(aq, 156)
        ar = a6(ar, 156)
        as = a6(as, 156)
        at = a6(at, 156)
        al = al + 4;
        return at * 16777216 + as * 65536 + ar * 256 + aq
    end
    local au = l .. a[19]
    local av = U(q .. a[4] .. w)
    local function aw()
        local ax = a6(P(an, al, al), 156)
        al = al + 1;
        return ax
    end
    local ay = a[8][a[10]]
    local az = l .. a[7]
    local function aA()
        local aB = ap()
        local aC = ap()
        local aD = 1;
        local aE = ae(aC, 1, 20) * 2 ^ 32 + aB;
        local aF = ae(aC, 21, 31)
        local aG = (-1) ^ ae(aC, 32)
        if aF == 0 then
            if aE == 0 then
                return aG * 0
            else
                aF = 1;
                aD = 0
            end
        elseif aF == 2047 then
            return aE == 0 and aG * 1 / 0 or aG * 0 / 0
        end
        return J(aG, aF - 1023) * (aD + aE / 2 ^ 52)
    end
    local aH = a[12]
    local aI = av == a[17]
    local aJ = l .. a[11]
    local aK = ap;
    local function aL(aM)
        local aN;
        if not aM then
            aM = aK()
            if aM == 0 then
                return ""
            end
        end
        aN = M(an, al, al + aM - 1)
        al = al + aM;
        local aO = {}
        for aP = 1, #aN do
            aO[aP] = N(a6(P(M(aN, aP, aP)), 156))
        end
        return I(aO)
    end
    local aQ = l .. a[4]
    local aR = ap;
    local aS = av == C;
    local aT = a[3]
    local function aU(...)
        return {...}, O("#", ...)
    end
    local function aV(aW, aX, aY)
        local function aZ(a0, a_)
            local b0 = an;
            for a1 = 1, #a_ do
                local W = P(a_, a1, a1) - (a0 + a1) % 256;
                if W < 0 then
                    W = W + 256
                end
                b0 = b0 .. N(W)
            end
            return b0
        end
        local function b1(b2)
            return S(b2, '..', function(b3)
                return N(T(b3, 16) % 256)
            end)
        end
        ac[am] = function(b4)
            return aA() .. b4
        end;
        ac[ak] = function(b5, b6)
            return T(aZ(b5, b1(b6)))
        end;
        ac[aQ] = function()
            return ay
        end;
        ac[ab] = function()
            return an
        end;
        ac[aJ] = function(b7, b8)
            return aZ(b7, b1(b8))
        end;
        ac[ao] = function()
            return aS
        end;
        ac[ad] = function()
            return aX
        end;
        ac[az] = function(a2)
            local a0 = 0;
            for a1 = 1, #a2 do
                a0 = a0 + P(a2, a1, a1)
            end
            return a0
        end;
        ac[au] = function()
            return aI
        end;
        return b1(aW .. aY)
    end
    local function b9()
        local ba = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0}
        local bb = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local bc = {}
        local bd = {ba, nil, bb, nil, bc}
        if F ~= q then
            return bb
        end
        bd[4] = aw()
        for aP = 1, ap() do
            local be = a6(ap(), 182)
            local bf = a6(ap(), 119)
            local bg = ae(be, 1, 2)
            local bh = ae(bf, 1, 11)
            local bi = {bh, ae(be, 3, 11), nil, nil, bf}
            if bg == 0 then
                bi[3] = ae(be, 12, 20)
                bi[5] = ae(be, 21, 29)
            elseif bg == 1 then
                bi[3] = ae(bf, 12, 33)
            elseif bg == 2 then
                bi[3] = ae(bf, 12, 32) - 1048575
            elseif bg == 3 then
                bi[3] = ae(bf, 12, 32) - 1048575;
                bi[5] = ae(be, 21, 29)
            end
            ba[aP] = bi
        end
        local bj = ap()
        local bk = {0, 0, 0, 0, 0, 0, 0}
        for aP = 1, bj do
            local bg = aw()
            local bl;
            if bg == 1 then
                bl = aw() ~= 0
            elseif bg == 2 then
                bl = aA()
            elseif bg == 0 then
                bl = aL()
            end
            bk[aP] = bl
        end
        bd[2] = bk;
        for aP = 1, ap() do
            bb[aP - 1] = b9()
        end
        return bd
    end
    local function bm(bd, bn, bo)
        local bp = bd[1]
        local bq = bd[2]
        local br = bd[3]
        local bs = bd[4]
        return function(...)
            local bp = bp;
            local bq = bq;
            local br = br;
            local bs = bs;
            local bt = aV(aT, ac, aH)
            local aU = aU;
            local bu = 1;
            local bv = -1;
            if av ~= E then
                return bu
            end
            local bw = {}
            local bx = {...}
            local by = {}
            local bz = O("#", ...) - 1;
            for aP = 0, bz do
                if aP >= bs then
                    bw[aP - bs] = bx[aP + 1]
                else
                    by[aP] = bx[aP + 1]
                end
            end
            local bA = bz - bs + 1;
            local bi;
            local bB;
            while true do
                bi = bp[bu]
                bB = bi[1]
                if bB <= 34 then
                    if bB <= 16 then
                        if bB <= 7 then
                            if bB <= 3 then
                                if bB <= 1 then
                                    if bB == 0 then
                                        by[bi[2]] = by[bi[3]] + bq[bi[5]]
                                    else
                                        local bC = bi[2]
                                        local bx = {}
                                        local bD = 0;
                                        local bE = bC + bi[3] - 1;
                                        for aP = bC + 1, bE do
                                            bD = bD + 1;
                                            bx[bD] = by[aP]
                                        end
                                        local bF = {by[bC](R(bx, 1, bE - bC))}
                                        local bE = bC + bi[5] - 2;
                                        bD = 0;
                                        for aP = bC, bE do
                                            bD = bD + 1;
                                            by[aP] = bF[bD]
                                        end
                                        bv = bE
                                    end
                                elseif bB == 2 then
                                    local bG = br[bi[3]]
                                    local bH;
                                    local bI = {}
                                    bH = L({}, {
                                        [a[16] .. a[16] .. D .. q .. B .. C .. a[2]] = function(bJ, bK)
                                            local bL = bI[bK]
                                            return bL[1][bL[2]]
                                        end,
                                        [a[16] .. a[16] .. q .. C .. H .. D .. q .. B .. C .. a[2]] = function(bJ, bK,
                                            bM)
                                            local bL = bI[bK]
                                            bL[1][bL[2]] = bM
                                        end
                                    })
                                    for aP = 1, bi[5] do
                                        bu = bu + 1;
                                        local bN = bp[bu]
                                        if bN[1] == 7 then
                                            bI[aP - 1] = {by, bN[3]}
                                        else
                                            bI[aP - 1] = {bn, bN[3]}
                                        end
                                        bt[#bt + 1] = bI
                                    end
                                    by[bi[2]] = bm(bG, bH, bo)
                                else
                                    local bC = bi[2]
                                    local bO = by[bi[3]]
                                    by[bC + 1] = bO;
                                    by[bC] = bO[bq[bi[5]]]
                                end
                            elseif bB <= 5 then
                                if bB > 4 then
                                    local bC;
                                    by[bi[2]] = bq[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = #by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = bq[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = #by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = bq[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    by[bC] = by[bC] - by[bC + 2]
                                    bu = bu + bi[3]
                                else
                                    local bP;
                                    local bF, bE;
                                    local bE;
                                    local bD;
                                    local bx;
                                    local bC;
                                    by[bi[2]] = bo[bq[bi[3]]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = bn[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = bn[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bx = {}
                                    bD = 0;
                                    bE = bC + bi[3] - 1;
                                    for aP = bC + 1, bE do
                                        bD = bD + 1;
                                        bx[bD] = by[aP]
                                    end
                                    bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                                    bE = bE + bC - 1;
                                    bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        by[aP] = bF[bD]
                                    end
                                    bv = bE;
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bx = {}
                                    bD = 0;
                                    bE = bv;
                                    for aP = bC + 1, bE do
                                        bD = bD + 1;
                                        bx[bD] = by[aP]
                                    end
                                    bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                                    bE = bE + bC - 1;
                                    bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        by[aP] = bF[bD]
                                    end
                                    bv = bE;
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bx = {}
                                    bE = bv;
                                    for aP = bC + 1, bE do
                                        bx[#bx + 1] = by[aP]
                                    end
                                    do
                                        return by[bC](R(bx, 1, bE - bC))
                                    end
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bE = bv;
                                    bP = {}
                                    bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        bP[bD] = by[aP]
                                    end
                                    do
                                        return R(bP, 1, bD)
                                    end
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    do
                                        return
                                    end
                                end
                            elseif bB > 6 then
                                by[bi[2]] = by[bi[3]]
                            else
                                bu = bu + bi[3]
                            end
                        elseif bB <= 11 then
                            if bB <= 9 then
                                if bB == 8 then
                                    by[bi[2]] = bo[bq[bi[3]]]
                                else
                                    local bO;
                                    local bF;
                                    local bE;
                                    local bD;
                                    local bx;
                                    local bC;
                                    by[bi[2]] = by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bx = {}
                                    bD = 0;
                                    bE = bC + bi[3] - 1;
                                    for aP = bC + 1, bE do
                                        bD = bD + 1;
                                        bx[bD] = by[aP]
                                    end
                                    bF = {by[bC](R(bx, 1, bE - bC))}
                                    bE = bC + bi[5] - 2;
                                    bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        by[aP] = bF[bD]
                                    end
                                    bv = bE;
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]] + by[bi[5]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]] % bq[bi[5]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bO = by[bi[3]]
                                    by[bC + 1] = bO;
                                    by[bC] = bO[bq[bi[5]]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    by[bi[2]] = by[bi[3]]
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    bC = bi[2]
                                    bx = {}
                                    bD = 0;
                                    bE = bC + bi[3] - 1;
                                    for aP = bC + 1, bE do
                                        bD = bD + 1;
                                        bx[bD] = by[aP]
                                    end
                                    bF = {by[bC](R(bx, 1, bE - bC))}
                                    bE = bC + bi[5] - 2;
                                    bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        by[aP] = bF[bD]
                                    end
                                    bv = bE;
                                    bu = bu + 1;
                                    bi = bp[bu]
                                    if by[bi[2]] > by[bi[5]] then
                                        bu = bu + 1
                                    else
                                        bu = bu + bi[3]
                                    end
                                end
                            elseif bB > 10 then
                                local bO = by[bi[3]]
                                if not bO then
                                    bu = bu + 1
                                else
                                    by[bi[2]] = bO;
                                    bu = bu + bp[bu + 1][3] + 1
                                end
                            else
                                local bP;
                                local bF, bE;
                                local bE;
                                local bD;
                                local bx;
                                local bC;
                                by[bi[2]] = bn[bi[3]]
                                bu = bu + 1;
                                bi = bp[bu]
                                by[bi[2]] = by[bi[3]]
                                bu = bu + 1;
                                bi = bp[bu]
                                by[bi[2]] = bn[bi[3]]
                                bu = bu + 1;
                                bi = bp[bu]
                                by[bi[2]] = by[bi[3]]
                                bu = bu + 1;
                                bi = bp[bu]
                                bC = bi[2]
                                bx = {}
                                bD = 0;
                                bE = bC + bi[3] - 1;
                                for aP = bC + 1, bE do
                                    bD = bD + 1;
                                    bx[bD] = by[aP]
                                end
                                bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                                bE = bE + bC - 1;
                                bD = 0;
                                for aP = bC, bE do
                                    bD = bD + 1;
                                    by[aP] = bF[bD]
                                end
                                bv = bE;
                                bu = bu + 1;
                                bi = bp[bu]
                                bC = bi[2]
                                bx = {}
                                bE = bv;
                                for aP = bC + 1, bE do
                                    bx[#bx + 1] = by[aP]
                                end
                                do
                                    return by[bC](R(bx, 1, bE - bC))
                                end
                                bu = bu + 1;
                                bi = bp[bu]
                                bC = bi[2]
                                bE = bv;
                                bP = {}
                                bD = 0;
                                for aP = bC, bE do
                                    bD = bD + 1;
                                    bP[bD] = by[aP]
                                end
                                do
                                    return R(bP, 1, bD)
                                end
                                bu = bu + 1;
                                bi = bp[bu]
                                do
                                    return
                                end
                            end
                        elseif bB <= 13 then
                            if bB == 12 then
                                by[bi[2]] = bi[3] ~= 0
                            else
                                local bC = bi[2]
                                local bx = {}
                                local bE = bv;
                                for aP = bC + 1, bE do
                                    bx[#bx + 1] = by[aP]
                                end
                                do
                                    return by[bC](R(bx, 1, bE - bC))
                                end
                            end
                        elseif bB <= 14 then
                            local bC = bi[2]
                            local bx = {}
                            local bD = 0;
                            local bE = bC + bi[3] - 1;
                            for aP = bC + 1, bE do
                                bD = bD + 1;
                                bx[bD] = by[aP]
                            end
                            local bF = {by[bC](R(bx, 1, bE - bC))}
                            local bE = bC + bi[5] - 2;
                            bD = 0;
                            for aP = bC, bE do
                                bD = bD + 1;
                                by[aP] = bF[bD]
                            end
                            bv = bE
                        elseif bB == 15 then
                            by[bi[2]] = by[bi[3]] % by[bi[5]]
                        else
                            local bC = bi[2]
                            local bx = {}
                            local bD = 0;
                            local bE = bC + bi[3] - 1;
                            for aP = bC + 1, bE do
                                bD = bD + 1;
                                bx[bD] = by[aP]
                            end
                            local bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                            bE = bE + bC - 1;
                            bD = 0;
                            for aP = bC, bE do
                                bD = bD + 1;
                                by[aP] = bF[bD]
                            end
                            bv = bE
                        end
                    elseif bB <= 25 then
                        if bB <= 20 then
                            if bB <= 18 then
                                if bB > 17 then
                                    local bC = bi[2]
                                    local bx = {}
                                    local bE = bv;
                                    for aP = bC + 1, bE do
                                        bx[#bx + 1] = by[aP]
                                    end
                                    do
                                        return by[bC](R(bx, 1, bE - bC))
                                    end
                                else
                                    by[bi[2]] = by[bi[3]] + bq[bi[5]]
                                end
                            elseif bB == 19 then
                                local bQ;
                                local bO;
                                local bF;
                                local bE;
                                local bD;
                                local bx;
                                local bC;
                                by[bi[2]] = bo[bq[bi[3]]]
                                bu = bu + 1;
                                bi = bp[bu]
                                by[bi[2]] = by[bi[3]][bq[bi[5]]]
                                bu = bu + 1;
                                bi = bp[bu]
                                by[bi[2]] = by[bi[3]]
                                bu = bu + 1;
                                bi = bp[bu]
                                bC = bi[2]
                                bx = {}
                                bD = 0;
                                bE = bC + bi[3] - 1;
                                for aP = bC + 1, bE do
                                    bD = bD + 1;
                                    bx[bD] = by[aP]
                                end
                                bF = {by[bC](R(bx, 1, bE - bC))}
                                bE = bC + bi[5] - 2;
                                bD = 0;
                                for aP = bC, bE do
                                    bD = bD + 1;
                                    by[aP] = bF[bD]
                                end
                                bv = bE;
                                bu = bu + 1;
                                bi = bp[bu]
                                bO = bi[3]
                                bQ = by[bO]
                                for aP = bO + 1, bi[5] do
                                    bQ = bQ .. by[aP]
                                end
                                by[bi[2]] = bQ
                            else
                                by[bi[2]] = bn[bi[3]]
                            end
                        elseif bB <= 22 then
                            if bB == 21 then
                                local bC = bi[2]
                                by[bC] = by[bC] - by[bC + 2]
                                bu = bu + bi[3]
                            else
                                local bG = br[bi[3]]
                                local bH;
                                local bI = {}
                                bH = L({}, {
                                    [a[16] .. a[16] .. D .. q .. B .. C .. a[2]] = function(bJ, bK)
                                        local bL = bI[bK]
                                        return bL[1][bL[2]]
                                    end,
                                    [a[16] .. a[16] .. q .. C .. H .. D .. q .. B .. C .. a[2]] = function(bJ, bK, bM)
                                        local bL = bI[bK]
                                        bL[1][bL[2]] = bM
                                    end
                                })
                                for aP = 1, bi[5] do
                                    bu = bu + 1;
                                    local bN = bp[bu]
                                    if bN[1] == 7 then
                                        bI[aP - 1] = {by, bN[3]}
                                    else
                                        bI[aP - 1] = {bn, bN[3]}
                                    end
                                    bt[#bt + 1] = bI
                                end
                                by[bi[2]] = bm(bG, bH, bo)
                            end
                        elseif bB <= 23 then
                            by[bi[2]] = bo[bq[bi[3]]]
                        elseif bB == 24 then
                            by[bi[2]] = by[bi[3]] % by[bi[5]]
                        else
                            by[bi[2]] = by[bi[3]][bq[bi[5]]]
                        end
                    elseif bB <= 29 then
                        if bB <= 27 then
                            if bB == 26 then
                                local bO = bi[3]
                                local bQ = by[bO]
                                for aP = bO + 1, bi[5] do
                                    bQ = bQ .. by[aP]
                                end
                                by[bi[2]] = bQ
                            else
                                by[bi[2]] = by[bi[3]] + by[bi[5]]
                            end
                        elseif bB == 28 then
                            by[bi[2]] = bm(br[bi[3]], nil, bo)
                        else
                            local bC = bi[2]
                            local bx = {}
                            local bE = bC + bi[3] - 1;
                            for aP = bC + 1, bE do
                                bx[#bx + 1] = by[aP]
                            end
                            do
                                return by[bC](R(bx, 1, bE - bC))
                            end
                        end
                    elseif bB <= 31 then
                        if bB == 30 then
                            by[bi[2]] = by[bi[3]]
                        else
                            by[bi[2]] = by[bi[3]] % bq[bi[5]]
                        end
                    elseif bB <= 32 then
                        local bC = bi[2]
                        by[bC] = by[bC] - by[bC + 2]
                        bu = bu + bi[3]
                    elseif bB == 33 then
                        by[bi[2]] = #by[bi[3]]
                    else
                        if by[bi[2]] == bq[bi[5]] then
                            bu = bu + 1
                        else
                            bu = bu + bi[3]
                        end
                    end
                elseif bB <= 51 then
                    if bB <= 42 then
                        if bB <= 38 then
                            if bB <= 36 then
                                if bB > 35 then
                                    local bC = bi[2]
                                    local bx = {}
                                    local bD = 0;
                                    local bE = bC + bi[3] - 1;
                                    for aP = bC + 1, bE do
                                        bD = bD + 1;
                                        bx[bD] = by[aP]
                                    end
                                    local bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                                    bE = bE + bC - 1;
                                    bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        by[aP] = bF[bD]
                                    end
                                    bv = bE
                                else
                                    local bC = bi[2]
                                    local bE = bv;
                                    local bP = {}
                                    local bD = 0;
                                    for aP = bC, bE do
                                        bD = bD + 1;
                                        bP[bD] = by[aP]
                                    end
                                    do
                                        return R(bP, 1, bD)
                                    end
                                end
                            elseif bB == 37 then
                                by[bi[2]] = bm(br[bi[3]], nil, bo)
                            else
                                by[bi[2]] = bq[bi[3]]
                            end
                        elseif bB <= 40 then
                            if bB > 39 then
                                local bC = bi[2]
                                local bx = {}
                                local bD = 0;
                                local bE = bv;
                                for aP = bC + 1, bE do
                                    bD = bD + 1;
                                    bx[bD] = by[aP]
                                end
                                local bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                                bE = bE + bC - 1;
                                bD = 0;
                                for aP = bC, bE do
                                    bD = bD + 1;
                                    by[aP] = bF[bD]
                                end
                                bv = bE
                            else
                                by[bi[2]] = by[bi[3]] - by[bi[5]]
                            end
                        elseif bB == 41 then
                            local bC = bi[2]
                            local bR = by[bC + 2]
                            local bS = by[bC] + bR;
                            by[bC] = bS;
                            if bR > 0 then
                                if bS <= by[bC + 1] then
                                    bu = bu + bi[3]
                                    by[bC + 3] = bS
                                end
                            elseif bS >= by[bC + 1] then
                                bu = bu + bi[3]
                                by[bC + 3] = bS
                            end
                        else
                            if by[bi[2]] == bq[bi[5]] then
                                bu = bu + 1
                            else
                                bu = bu + bi[3]
                            end
                        end
                    elseif bB <= 46 then
                        if bB <= 44 then
                            if bB > 43 then
                                by[bi[2]] = bi[3] ~= 0
                            else
                                local bC = bi[2]
                                local bE = bC + bi[3] - 2;
                                local bP = {}
                                local bD = 0;
                                for aP = bC, bE do
                                    bD = bD + 1;
                                    bP[bD] = by[aP]
                                end
                                do
                                    return R(bP, 1, bD)
                                end
                            end
                        elseif bB == 45 then
                            local bC = bi[2]
                            local bE = bC + bi[3] - 2;
                            local bP = {}
                            local bD = 0;
                            for aP = bC, bE do
                                bD = bD + 1;
                                bP[bD] = by[aP]
                            end
                            do
                                return R(bP, 1, bD)
                            end
                        else
                            by[bi[2]] = by[bi[3]] % bq[bi[5]]
                        end
                    elseif bB <= 48 then
                        if bB == 47 then
                            local bC = bi[2]
                            local bO = by[bi[3]]
                            by[bC + 1] = bO;
                            by[bC] = bO[bq[bi[5]]]
                        else
                            local bC = bi[2]
                            local bx = {}
                            local bE = bC + bi[3] - 1;
                            for aP = bC + 1, bE do
                                bx[#bx + 1] = by[aP]
                            end
                            do
                                return by[bC](R(bx, 1, bE - bC))
                            end
                        end
                    elseif bB <= 49 then
                        by[bi[2]] = by[bi[3]] - by[bi[5]]
                    elseif bB > 50 then
                        local bC = bi[2]
                        local bx = {}
                        local bD = 0;
                        local bE = bv;
                        for aP = bC + 1, bE do
                            bD = bD + 1;
                            bx[bD] = by[aP]
                        end
                        local bF, bE = aU(by[bC](R(bx, 1, bE - bC)))
                        bE = bE + bC - 1;
                        bD = 0;
                        for aP = bC, bE do
                            bD = bD + 1;
                            by[aP] = bF[bD]
                        end
                        bv = bE
                    else
                        local bC = bi[2]
                        local bE = bv;
                        local bP = {}
                        local bD = 0;
                        for aP = bC, bE do
                            bD = bD + 1;
                            bP[bD] = by[aP]
                        end
                        do
                            return R(bP, 1, bD)
                        end
                    end
                elseif bB <= 60 then
                    if bB <= 55 then
                        if bB <= 53 then
                            if bB == 52 then
                                by[bi[2]] = #by[bi[3]]
                            else
                                bo[bq[bi[3]]] = by[bi[2]]
                            end
                        elseif bB > 54 then
                            local bO = bi[3]
                            local bQ = by[bO]
                            for aP = bO + 1, bi[5] do
                                bQ = bQ .. by[aP]
                            end
                            by[bi[2]] = bQ
                        else
                            do
                                return
                            end
                        end
                    elseif bB <= 57 then
                        if bB == 56 then
                            by[bi[2]] = bq[bi[3]]
                        else
                            bu = bu + bi[3]
                        end
                    elseif bB <= 58 then
                        by[bi[2]] = by[bi[3]] + by[bi[5]]
                    elseif bB == 59 then
                        if by[bi[2]] > by[bi[5]] then
                            bu = bu + 1
                        else
                            bu = bu + bi[3]
                        end
                    else
                        bo[bq[bi[3]]] = by[bi[2]]
                    end
                elseif bB <= 64 then
                    if bB <= 62 then
                        if bB > 61 then
                            local bO = by[bi[3]]
                            if not bO then
                                bu = bu + 1
                            else
                                by[bi[2]] = bO;
                                bu = bu + bp[bu + 1][3] + 1
                            end
                        else
                            if not by[bi[2]] then
                                bu = bu + 1
                            else
                                bu = bu + bi[3]
                            end
                        end
                    elseif bB > 63 then
                        local bP;
                        local bF;
                        local bE;
                        local bD;
                        local bx;
                        local bC;
                        by[bi[2]] = bo[bq[bi[3]]]
                        bu = bu + 1;
                        bi = bp[bu]
                        by[bi[2]] = by[bi[3]][bq[bi[5]]]
                        bu = bu + 1;
                        bi = bp[bu]
                        by[bi[2]] = bo[bq[bi[3]]]
                        bu = bu + 1;
                        bi = bp[bu]
                        by[bi[2]] = by[bi[3]]
                        bu = bu + 1;
                        bi = bp[bu]
                        by[bi[2]] = bq[bi[3]]
                        bu = bu + 1;
                        bi = bp[bu]
                        bC = bi[2]
                        bx = {}
                        bD = 0;
                        bE = bC + bi[3] - 1;
                        for aP = bC + 1, bE do
                            bD = bD + 1;
                            bx[bD] = by[aP]
                        end
                        bF = {by[bC](R(bx, 1, bE - bC))}
                        bE = bC + bi[5] - 2;
                        bD = 0;
                        for aP = bC, bE do
                            bD = bD + 1;
                            by[aP] = bF[bD]
                        end
                        bv = bE;
                        bu = bu + 1;
                        bi = bp[bu]
                        by[bi[2]] = by[bi[3]] % bq[bi[5]]
                        bu = bu + 1;
                        bi = bp[bu]
                        bC = bi[2]
                        bx = {}
                        bE = bC + bi[3] - 1;
                        for aP = bC + 1, bE do
                            bx[#bx + 1] = by[aP]
                        end
                        do
                            return by[bC](R(bx, 1, bE - bC))
                        end
                        bu = bu + 1;
                        bi = bp[bu]
                        bC = bi[2]
                        bE = bv;
                        bP = {}
                        bD = 0;
                        for aP = bC, bE do
                            bD = bD + 1;
                            bP[bD] = by[aP]
                        end
                        do
                            return R(bP, 1, bD)
                        end
                        bu = bu + 1;
                        bi = bp[bu]
                        do
                            return
                        end
                    else
                        by[bi[2]] = bn[bi[3]]
                    end
                elseif bB <= 66 then
                    if bB > 65 then
                        local bC = bi[2]
                        local bR = by[bC + 2]
                        local bS = by[bC] + bR;
                        by[bC] = bS;
                        if bR > 0 then
                            if bS <= by[bC + 1] then
                                bu = bu + bi[3]
                                by[bC + 3] = bS
                            end
                        elseif bS >= by[bC + 1] then
                            bu = bu + bi[3]
                            by[bC + 3] = bS
                        end
                    else
                        if not by[bi[2]] then
                            bu = bu + 1
                        else
                            bu = bu + bi[3]
                        end
                    end
                elseif bB <= 67 then
                    by[bi[2]] = by[bi[3]][bq[bi[5]]]
                elseif bB == 68 then
                    do
                        return
                    end
                else
                    if by[bi[2]] > by[bi[5]] then
                        bu = bu + 1
                    else
                        bu = bu + bi[3]
                    end
                end
                bu = bu + 1
            end
        end
    end
    return bm(b9(), {}, Q())()
end;
a[26] = _ENV;
a[20] = a[a[18]]()
a[29] = a[8][a[10] .. a[4]]
a[24] = a[8][a[10] .. a[1]]
a[21] = a[8][a[10] .. a[9]]
a[28] = a[8][a[10] .. a[11]]
_G = a[8][a[10] .. a[5]]()
a[25] = a[8][a[10] .. a[19]]
a[22] = a[8][a[10] .. a[15]]
a[27] = a[8][a[10] .. a[7]]("00EBE0C")
return (function(...)
    _G["qxw3iagfxbqp1ilz"] = function(bT)
        _G["xm"] = "小满"
        _G["xiao1man"](bT)
    end;
    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
        _G["wlx"] = "xiaoman.top"
    end
    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
        _G["wlx"] = "xiaoman.top"
    end
    _G["WR_DeathKnightConfigFrame"] = function()
        if _G["WR_ConfigIsOK"] ~= nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            return
        end
        if not _G["WR_BN_Tag_20250314"] or not _G["WR_BN_Tag_20250314"]() then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            return
        end
        _G["WR_ConfigIsOK"] = true
        local bU = 185
        local bV = 750
        local bW = -15
        local bX = _G["CreateFrame"]("Frame", "WowRobotConfigFrame", _G["UIParent"], "UIPanelDialogTemplate")
        bX["SetSize"](bX, bU, bV)
        bX["SetPoint"](bX, "TOPLEFT", -5, -63)
        bX["SetMovable"](bX, true)
        bX["EnableMouse"](bX, true)
        bX["RegisterForDrag"](bX, "LeftButton")
        bX["SetScript"](bX, "OnDragStart", bX["StartMoving"])
        bX["SetScript"](bX, "OnDragStop", bX["StopMovingOrSizing"])
        bX["SetFrameStrata"](bX, "FULLSCREEN")
        bX["Hide"](bX)
        bX["title"] = bX["CreateFontString"](bX, nil, "OVERLAY", "GameFontHighlight")
        bX["title"]:SetPoint("TOP", bX["Title"], "TOP", 0, 0)
        bX["title"]:SetText("|cff00adf0WOW-Robot")
        local bY = bX["CreateTexture"](bX, nil, "ARTWORK")
        bY["SetSize"](bY, 35, 35)
        bY["SetPoint"](bY, "TOPLEFT", 20, -35)
        bY["SetTexture"](bY, "Interface\\AddOns\\!WR\\VX WOW-Robot\\VX WOW-Robot.tga")
        local bZ = _G["CreateFrame"]("CheckButton", "WR_TestCheckbox", bX, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "LEFT", bY, "RIGHT", 15, 0)
        bZ["SetChecked"](bZ, false)
        bZ["text"]:SetText("调试模式")
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "如果卡技能，请打开此选项，\n可以查出卡在什么技能或功能上了。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        local c0 = _G["CreateFrame"]("Frame", "BS_Frame", bX)
        c0["SetSize"](c0, 1, 1)
        c0["SetPoint"](c0, "CENTER", 0, 0)
        local c1 = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        c1["SetText"](c1, "智能目标")
        c1["SetPoint"](c1, "TOPLEFT", bY, "BOTTOMLEFT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_ZNMB_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", c1, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "锁定",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "范围",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "锁定：锁定当前所选目标，丢失目标的时候，切换最近的目标。\n范围：只要目标不在攻击范围内，切换最近的目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZNMB"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_ZNMB"])
        end
        _G["BS_ZNJD_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_ZNJD_Text"]["SetText"](_G["BS_ZNJD_Text"], "智能焦点")
        _G["BS_ZNJD_Text"]["SetPoint"](_G["BS_ZNJD_Text"], "TOPRIGHT", c1, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_ZNJD_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["BS_ZNJD_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffffff骷髅",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffcc3300十字",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cff3a8ff3方块",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cffc3c3e3月亮",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff11ff11三角",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffbf6af7菱形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cfffd7c07圆形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cffebeb1b星型",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "自动设定指定标记的单位为焦点。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZNJD"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_ZNJD"])
        end
        local c7 = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        c7["SetText"](c7, "冰霜巨龙")
        c7["SetPoint"](c7, "TOPRIGHT", _G["BS_ZNJD_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_BSJL_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", c7, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "快速",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "正常",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "叠层",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "快速：|cff00adf0冰霜之柱|r内施放冰霜巨龙。\n正常：|cff00adf0冰霜之柱|r内，触发|cff00adf0挫骨扬灰|r或|cff00adf0不洁之力|r，施放冰霜巨龙。\n叠层：尽可能叠加更多的增益后施放冰霜巨龙。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_BSJL"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_BSJL"])
        end
        local c8 = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        c8["SetText"](c8, "心灵冰冻")
        c8["SetPoint"](c8, "TOPRIGHT", c7, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_XLBD_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", c8, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff00adf0智能|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cff00adf0目标|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cff00adf0指向|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cff00adf0焦点|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：打断所有单位的施法。\n目标：仅打断当前目标的施法。\n指向：仅打断当前指向单位的施法。\n焦点：仅打断焦点单位的施法。(若无焦点则打断所有单位。)\n|cffffffff白色：打断大部分技能。|r\n|cff00adf0蓝色：仅断重要的技能。|r")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_XLBD"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_XLBD"])
        end
        local c9 = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        c9["SetText"](c9, "打断延迟")
        c9["SetPoint"](c9, "TOPRIGHT", c8, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_DDMS_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", c9, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "秒断",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "80%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "90%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择秒断或打断延迟时间。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_DDMS"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_DDMS"])
        end
        local ca = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        ca["SetText"](ca, "窒息")
        ca["SetPoint"](ca, "TOPRIGHT", c9, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_ZX_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", ca, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：控制所有单位。\n目标：仅控制当前目标。\n指向：仅控制指向单位。\n焦点：仅控制焦点单位。(若无焦点则控制所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZX"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_ZX"])
        end
        local cb = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        cb["SetText"](cb, "枯萎凋零")
        cb["SetPoint"](cb, "TOPRIGHT", ca, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_KWDL_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cb, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "AOE",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "常驻：单体和AOE，均使用枯萎凋零。\nAOE：仅AOE的时候使用枯萎凋零。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_KWDL"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_KWDL"])
        end
        local cc = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        cc["SetText"](cc, "巫妖之躯")
        cc["SetPoint"](cc, "TOPRIGHT", cb, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_WYZQ_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cc, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用巫妖之躯。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_WYZQ"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_WYZQ"])
        end
        local cd = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        cd["SetText"](cd, "冰封之韧")
        cd["SetPoint"](cd, "TOPRIGHT", cc, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_BFZR_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cd, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用冰封之韧。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_BFZR"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_BFZR"])
        end
        local ce = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        ce["SetText"](ce, "灵界打击")
        ce["SetPoint"](ce, "TOPRIGHT", cd, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_LJDJ_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", ce, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用灵界打击。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_LJDJ"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_LJDJ"])
        end
        local cf = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        cf["SetText"](cf, "治疗石")
        cf["SetPoint"](cf, "TOPRIGHT", ce, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_ZLS_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cf, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗石。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZLS"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_ZLS"])
        end
        local cg = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        cg["SetText"](cg, "治疗药水")
        cg["SetPoint"](cg, "TOPRIGHT", cf, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_ZLYS_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cg, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZLYS"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_ZLYS"])
        end
        _G["BS_SP1_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_SP1_Text"]["SetText"](_G["BS_SP1_Text"], "饰品①")
        _G["BS_SP1_Text"]["SetPoint"](_G["BS_SP1_Text"], "TOPRIGHT", cg, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_SP1_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["BS_SP1_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_SP1"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_SP1"])
        end
        _G["BS_SP2_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_SP2_Text"]["SetText"](_G["BS_SP2_Text"], "饰品②")
        _G["BS_SP2_Text"]["SetPoint"](_G["BS_SP2_Text"], "TOPRIGHT", _G["BS_SP1_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_SP2_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["BS_SP2_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_SP2"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_SP2"])
        end
        _G["BS_WuQi_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_WuQi_Text"]["SetText"](_G["BS_WuQi_Text"], "武器")
        _G["BS_WuQi_Text"]["SetPoint"](_G["BS_WuQi_Text"], "TOPRIGHT", _G["BS_SP2_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_WuQi_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["BS_WuQi_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：爆发模式使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_WuQi"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_WuQi"])
        end
        local ch = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        ch["SetText"](ch, "施法速度")
        ch["SetPoint"](ch, "TOPRIGHT", _G["BS_WuQi_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_SFSD_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", ch, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "15%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "25%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "在公共冷却(GCD)前0.1-0.3秒插入下一个技能。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_SFSD"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_SFSD"])
        end
        local ci = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        ci["SetText"](ci, "插件功率")
        ci["SetPoint"](ci, "TOPRIGHT", ch, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "BS_CJGL_Dropdown", c0, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", ci, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "最高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "较高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "中等",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "较低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "最低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "功率设置会影响插件的反应速度。\n功率越高，反应越快，帧数下降。\n功率越低，反应越慢，帧数提高。\n请根据自己的电脑性能酌情调整。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_CJGL"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["BS_CJGL"])
        end
        _G["BS_FWWQ_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_FWWQ_Text"]["SetText"](_G["BS_FWWQ_Text"], "符武")
        _G["BS_FWWQ_Text"]["SetPoint"](_G["BS_FWWQ_Text"], "TOPRIGHT", ci, "BOTTOMRIGHT", -33, bW)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_FWWQ_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_FWWQ_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0符文武器|r(爆发)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_FWWQ"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ["SetChecked"](bZ, true)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_FWWQ"])
        end
        _G["BS_BLTX_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_BLTX_Text"]["SetText"](_G["BS_BLTX_Text"], "吐息")
        _G["BS_BLTX_Text"]["SetPoint"](_G["BS_BLTX_Text"], "LEFT", _G["BS_FWWQ_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_BLTX_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_BLTX_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0冰龙吐息|r(爆发)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_BLTX"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_BLTX"])
        end
        _G["BS_ZEFZ_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_ZEFZ_Text"]["SetText"](_G["BS_ZEFZ_Text"], "附肢")
        _G["BS_ZEFZ_Text"]["SetPoint"](_G["BS_ZEFZ_Text"], "LEFT", _G["BS_BLTX_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_ZEFZ_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_ZEFZ_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0憎恶附肢|r(爆发)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZEFZ"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            bZ["SetChecked"](bZ, true)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_ZEFZ"])
        end
        _G["BS_FHMY_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_FHMY_Text"]["SetText"](_G["BS_FHMY_Text"], "战复")
        _G["BS_FHMY_Text"]["SetPoint"](_G["BS_FHMY_Text"], "LEFT", _G["BS_ZEFZ_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_FHMY_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_FHMY_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0复活盟友|r(指向战复)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_FHMY"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bZ["SetChecked"](bZ, true)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_FHMY"])
        end
        _G["BS_FMFHZ_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_FMFHZ_Text"]["SetText"](_G["BS_FMFHZ_Text"], "魔罩")
        _G["BS_FMFHZ_Text"]["SetPoint"](_G["BS_FMFHZ_Text"], "TOP", _G["BS_FWWQ_Checkbox"], "BOTTOM", 0, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_FMFHZ_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_FMFHZ_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0反魔法护罩|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_FMFHZ"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_FMFHZ"])
        end
        _G["BS_ZMBY_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_ZMBY_Text"]["SetText"](_G["BS_ZMBY_Text"], "冰雨")
        _G["BS_ZMBY_Text"]["SetPoint"](_G["BS_ZMBY_Text"], "LEFT", _G["BS_FMFHZ_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_ZMBY_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_ZMBY_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0致盲冰雨|r(控制)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_ZMBY"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            bZ["SetChecked"](bZ, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_ZMBY"])
        end
        _G["BS_WZFS_Text"] = c0["CreateFontString"](c0, nil, "ARTWORK", "GameFontNormal")
        _G["BS_WZFS_Text"]["SetText"](_G["BS_WZFS_Text"], "尸鬼")
        _G["BS_WZFS_Text"]["SetPoint"](_G["BS_WZFS_Text"], "LEFT", _G["BS_ZMBY_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "BS_WZFS_Checkbox", c0, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["BS_WZFS_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0亡者复生|r(爆发)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["BS_WZFS"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bZ["SetChecked"](bZ, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["BS_WZFS"])
        end
        local cj = _G["CreateFrame"]("Frame", "XE_Frame", bX)
        cj["SetSize"](cj, 1, 1)
        cj["SetPoint"](cj, "CENTER", 0, 0)
        local ck = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        ck["SetText"](ck, "智能目标")
        ck["SetPoint"](ck, "TOPLEFT", bY, "BOTTOMLEFT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_ZNMB_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", ck, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "锁定",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "范围",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "锁定：锁定当前所选目标，丢失目标的时候，切换最近的目标。\n范围：只要目标不在攻击范围内，切换最近的目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_ZNMB"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_ZNMB"])
        end
        local cl = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cl["SetText"](cl, "心灵冰冻")
        cl["SetPoint"](cl, "TOPRIGHT", ck, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_XLBD_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cl, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：打断所有单位的施法。\n目标：仅打断当前目标的施法。\n指向：仅打断当前指向单位的施法。\n焦点：仅打断焦点单位的施法。(若无焦点则打断所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_XLBD"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_XLBD"])
        end
        local cm = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cm["SetText"](cm, "打断模式")
        cm["SetPoint"](cm, "TOPRIGHT", cl, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_DDMS_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cm, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "秒断",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "80%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "90%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择秒断或打断延迟时间。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_DDMS"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_DDMS"])
        end
        local cn = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cn["SetText"](cn, "致盲冰雨")
        cn["SetPoint"](cn, "TOPRIGHT", cm, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_ZMBY_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cn, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "击晕附近特定的钢条施法单位。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_ZMBY"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_ZMBY"])
        end
        local co = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        co["SetText"](co, "窒息")
        co["SetPoint"](co, "TOPRIGHT", cn, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_ZX_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", co, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：控制所有单位。\n目标：仅控制当前目标。\n指向：仅控制指向单位。\n焦点：仅控制焦点单位。(若无焦点则控制所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_ZX"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_ZX"])
        end
        local cp = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cp["SetText"](cp, "亡者大军")
        cp["SetPoint"](cp, "TOPRIGHT", co, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_WZDJ_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cp, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "使用[亡者大军]技能")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_WZDJ"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_WZDJ"])
        end
        local cq = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cq["SetText"](cq, "憎恶附肢")
        cq["SetPoint"](cq, "TOPRIGHT", cp, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_ZEFZ_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cq, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "使用[憎恶附肢]技能")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_ZEFZ"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_ZEFZ"])
        end
        local cr = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cr["SetText"](cr, "反魔法罩")
        cr["SetPoint"](cr, "TOPRIGHT", cq, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_FMFHZ_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cr, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "反射对你施法的法术。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_FMFHZ"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_FMFHZ"])
        end
        _G["XE_FHMY_Text"] = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        _G["XE_FHMY_Text"]["SetText"](_G["XE_FHMY_Text"], "复活盟友")
        _G["XE_FHMY_Text"]["SetPoint"](_G["XE_FHMY_Text"], "TOPRIGHT", cr, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_FHMY_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["XE_FHMY_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "战复鼠标指向的队友。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_FHMY"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_FHMY"])
        end
        local cs = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cs["SetText"](cs, "巫妖之躯")
        cs["SetPoint"](cs, "TOPRIGHT", _G["XE_FHMY_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_WYZQ_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cs, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用巫妖之躯。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_WYZQ"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_WYZQ"])
        end
        local ct = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        ct["SetText"](ct, "冰封之韧")
        ct["SetPoint"](ct, "TOPRIGHT", cs, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_BFZR_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", ct, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用冰封之韧。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_BFZR"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_BFZR"])
        end
        local cu = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cu["SetText"](cu, "灵界打击")
        cu["SetPoint"](cu, "TOPRIGHT", ct, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_LJDJ_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cu, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用灵界打击。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_LJDJ"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_LJDJ"])
        end
        local cv = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cv["SetText"](cv, "治疗石")
        cv["SetPoint"](cv, "TOPRIGHT", cu, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_ZLS_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cv, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗石。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_ZLS"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_ZLS"])
        end
        local cw = cj["CreateFontString"](cj, nil, "ARTWORK", "GameFontNormal")
        cw["SetText"](cw, "治疗药水")
        cw["SetPoint"](cw, "TOPRIGHT", cv, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XE_ZLYS_Dropdown", cj, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cw, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XE_ZLYS"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XE_ZLYS"])
        end
        local cx = _G["CreateFrame"]("Frame", "XX_Frame", bX)
        cx["SetSize"](cx, 1, 1)
        cx["SetPoint"](cx, "CENTER", 0, 0)
        local cy = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cy["SetText"](cy, "智能目标")
        cy["SetPoint"](cy, "TOPLEFT", bY, "BOTTOMLEFT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_ZNMB_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cy, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "锁定",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "范围",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "锁定：锁定当前所选目标，丢失目标的时候，切换最近的目标。\n范围：只要目标不在攻击范围内，切换最近的目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_ZNMB"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_ZNMB"])
        end
        _G["XX_ZNJD_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_ZNJD_Text"]["SetText"](_G["XX_ZNJD_Text"], "智能焦点")
        _G["XX_ZNJD_Text"]["SetPoint"](_G["XX_ZNJD_Text"], "TOPRIGHT", cy, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_ZNJD_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["XX_ZNJD_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffffff骷髅",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cffcc3300十字",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cff3a8ff3方块",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cffc3c3e3月亮",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff11ff11三角",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cffbf6af7菱形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cfffd7c07圆形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cffebeb1b星型",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "自动设定指定标记的单位为焦点。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_ZNJD"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_ZNJD"])
        end
        local cz = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cz["SetText"](cz, "心灵冰冻")
        cz["SetPoint"](cz, "TOPRIGHT", _G["XX_ZNJD_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_XLBD_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cz, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff00adf0智能|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cff00adf0目标|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cff00adf0指向|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cff00adf0焦点|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：打断所有单位的施法。\n目标：仅打断当前目标的施法。\n指向：仅打断当前指向单位的施法。\n焦点：仅打断焦点单位的施法。(若无焦点则打断所有单位。)\n|cffffffff白色：打断大部分技能。|r\n|cff00adf0蓝色：仅断重要的技能。|r")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_XLBD"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_XLBD"])
        end
        local cA = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cA["SetText"](cA, "打断延迟")
        cA["SetPoint"](cA, "TOPRIGHT", cz, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_DDMS_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cA, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "秒断",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "80%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "90%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择秒断或打断延迟时间。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_DDMS"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_DDMS"])
        end
        local cB = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cB["SetText"](cB, "窒息")
        cB["SetPoint"](cB, "TOPRIGHT", cA, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_ZX_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cB, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：控制所有单位。\n目标：仅控制当前目标。\n指向：仅控制指向单位。\n焦点：仅控制焦点单位。(若无焦点则控制所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_ZX"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_ZX"])
        end
        local cC = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cC["SetText"](cC, "治疗石")
        cC["SetPoint"](cC, "TOPRIGHT", cB, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_ZLS_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cC, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗石。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_ZLS"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_ZLS"])
        end
        local cD = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cD["SetText"](cD, "治疗药水")
        cD["SetPoint"](cD, "TOPRIGHT", cC, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_ZLYS_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cD, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_ZLYS"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_ZLYS"])
        end
        _G["XX_SP1_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_SP1_Text"]["SetText"](_G["XX_SP1_Text"], "饰品①")
        _G["XX_SP1_Text"]["SetPoint"](_G["XX_SP1_Text"], "TOPRIGHT", cD, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_SP1_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["XX_SP1_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_SP1"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_SP1"])
        end
        _G["XX_SP2_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_SP2_Text"]["SetText"](_G["XX_SP2_Text"], "饰品②")
        _G["XX_SP2_Text"]["SetPoint"](_G["XX_SP2_Text"], "TOPRIGHT", _G["XX_SP1_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_SP2_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["XX_SP2_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_SP2"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_SP2"])
        end
        _G["XX_WuQi_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_WuQi_Text"]["SetText"](_G["XX_WuQi_Text"], "武器")
        _G["XX_WuQi_Text"]["SetPoint"](_G["XX_WuQi_Text"], "TOPRIGHT", _G["XX_SP2_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_WuQi_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", _G["XX_WuQi_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：爆发模式使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_WuQi"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_WuQi"])
        end
        local cE = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cE["SetText"](cE, "施法速度")
        cE["SetPoint"](cE, "TOPRIGHT", _G["XX_WuQi_Text"], "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_SFSD_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cE, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "15%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "25%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "在公共冷却(GCD)前0.1-0.3秒插入下一个技能。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_SFSD"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_SFSD"])
        end
        local cF = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        cF["SetText"](cF, "插件功率")
        cF["SetPoint"](cF, "TOPRIGHT", cE, "BOTTOMRIGHT", 0, bW)
        local c2 = _G["CreateFrame"]("Frame", "XX_CJGL_Dropdown", cx, "UIDropDownMenuTemplate")
        c2["SetPoint"](c2, "LEFT", cF, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c2, 70)
        local c3 = {{
            ["text"] = "最高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 1)
            end
        }, {
            ["text"] = "较高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 2)
            end
        }, {
            ["text"] = "中等",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 3)
            end
        }, {
            ["text"] = "较低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 4)
            end
        }, {
            ["text"] = "最低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c2, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c2, function()
            for c4, c5 in _G["ipairs"](c3) do
                local c6 = _G["UIDropDownMenu_CreateInfo"]()
                c6["text"] = c5["text"]
                c6["func"] = c5["func"]
                _G["UIDropDownMenu_AddButton"](c6)
            end
        end)
        c2["SetScript"](c2, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "功率设置会影响插件的反应速度。\n功率越高，反应越快，帧数下降。\n功率越低，反应越慢，帧数提高。\n请根据自己的电脑性能酌情调整。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c2["SetScript"](c2, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_CJGL"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c2, _G["WRSet"]["XX_CJGL"])
        end
        _G["XX_NotADD_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_NotADD_Text"]["SetText"](_G["XX_NotADD_Text"], "防衅")
        _G["XX_NotADD_Text"]["SetPoint"](_G["XX_NotADD_Text"], "TOPRIGHT", cF, "BOTTOMRIGHT", -33, bW)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_NotADD_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_NotADD_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "不主动攻击未战斗的单位。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_NotADD"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            bZ["SetChecked"](bZ, true)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_NotADD"])
        end
        _G["XX_QZJS_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_QZJS_Text"]["SetText"](_G["XX_QZJS_Text"], "预防")
        _G["XX_QZJS_Text"]["SetPoint"](_G["XX_QZJS_Text"], "LEFT", _G["XX_NotADD_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_QZJS_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_QZJS_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "使用减伤技能提前应对部分尖刺伤害。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_QZJS"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_QZJS"])
        end
        _G["XX_ZMBY_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_ZMBY_Text"]["SetText"](_G["XX_ZMBY_Text"], "冰雨")
        _G["XX_ZMBY_Text"]["SetPoint"](_G["XX_ZMBY_Text"], "LEFT", _G["XX_QZJS_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_ZMBY_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_ZMBY_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0致盲冰雨|r(控制)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_ZMBY"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_ZMBY"])
        end
        _G["XX_FHMY_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_FHMY_Text"]["SetText"](_G["XX_FHMY_Text"], "战复")
        _G["XX_FHMY_Text"]["SetPoint"](_G["XX_FHMY_Text"], "LEFT", _G["XX_ZMBY_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_FHMY_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_FHMY_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0复活盟友|r(指向战复)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_FHMY"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ["SetChecked"](bZ, true)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_FHMY"])
        end
        _G["XX_FMFHZ_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_FMFHZ_Text"]["SetText"](_G["XX_FMFHZ_Text"], "魔罩")
        _G["XX_FMFHZ_Text"]["SetPoint"](_G["XX_FMFHZ_Text"], "TOP", _G["XX_NotADD_Checkbox"], "BOTTOM", 0, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_FMFHZ_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_FMFHZ_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0反魔法护罩|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_FMFHZ"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            bZ["SetChecked"](bZ, true)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_FMFHZ"])
        end
        _G["XX_XXGZX_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_XXGZX_Text"]["SetText"](_G["XX_XXGZX_Text"], "吸血")
        _G["XX_XXGZX_Text"]["SetPoint"](_G["XX_XXGZX_Text"], "LEFT", _G["XX_FMFHZ_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_XXGZX_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_XXGZX_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0吸血鬼之血|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_XXGZX"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            bZ["SetChecked"](bZ, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_XXGZX"])
        end
        _G["XX_WYZQ_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_WYZQ_Text"]["SetText"](_G["XX_WYZQ_Text"], "巫妖")
        _G["XX_WYZQ_Text"]["SetPoint"](_G["XX_WYZQ_Text"], "LEFT", _G["XX_XXGZX_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_WYZQ_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_WYZQ_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0巫妖之躯|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_WYZQ"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bZ["SetChecked"](bZ, true)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bT)
                _G["xm"] = "小满"
                _G["xiao1man"](bT)
            end;
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_WYZQ"])
        end
        _G["XX_BFZR_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_BFZR_Text"]["SetText"](_G["XX_BFZR_Text"], "冰韧")
        _G["XX_BFZR_Text"]["SetPoint"](_G["XX_BFZR_Text"], "LEFT", _G["XX_WYZQ_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_BFZR_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_BFZR_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0冰封之韧|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_BFZR"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_BFZR"])
        end
        _G["XX_FWFL_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_FWFL_Text"]["SetText"](_G["XX_FWFL_Text"], "分流")
        _G["XX_FWFL_Text"]["SetPoint"](_G["XX_FWFL_Text"], "TOP", _G["XX_FMFHZ_Checkbox"], "BOTTOM", 0, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_FWFL_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_FWFL_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0符文分流|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_FWFL"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            bZ["SetChecked"](bZ, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_FWFL"])
        end
        _G["XX_SWJB_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_SWJB_Text"]["SetText"](_G["XX_SWJB_Text"], "鬼步")
        _G["XX_SWJB_Text"]["SetPoint"](_G["XX_SWJB_Text"], "LEFT", _G["XX_FWFL_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_SWJB_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_SWJB_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0死亡脚步|r(位移)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_SWJB"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_SWJB"])
        end
        _G["XX_HBSL_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_HBSL_Text"]["SetText"](_G["XX_HBSL_Text"], "锁链")
        _G["XX_HBSL_Text"]["SetPoint"](_G["XX_HBSL_Text"], "LEFT", _G["XX_SWJB_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_HBSL_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_HBSL_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0寒冰锁链|r(特殊指向)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_HBSL"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_HBSL"])
        end
        _G["XX_FWRW_Text"] = cx["CreateFontString"](cx, nil, "ARTWORK", "GameFontNormal")
        _G["XX_FWRW_Text"]["SetText"](_G["XX_FWRW_Text"], "刃舞")
        _G["XX_FWRW_Text"]["SetPoint"](_G["XX_FWRW_Text"], "LEFT", _G["XX_HBSL_Text"], "RIGHT", 8, 0)
        local bZ = _G["CreateFrame"]("CheckButton", "XX_FWRW_Checkbox", cx, "UICheckButtonTemplate")
        bZ["SetPoint"](bZ, "TOP", _G["XX_FWRW_Text"], "BOTTOM", 0, 0)
        bZ["SetChecked"](bZ, false)
        bZ["SetScript"](bZ, "OnEnter", function(b_)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], b_, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0符文刃舞|r(爆发)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bZ["SetScript"](bZ, "OnLeave", function(b_)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["XX_FWRW"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            bZ["SetChecked"](bZ, true)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            bZ["SetChecked"](bZ, _G["WRSet"]["XX_FWRW"])
        end
        _G["ToggleConfigFrame"] = function()
            if bX["IsShown"](bX) then
                _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                if _G["cu3vft61qi8zvg0lfe"][1] == true then
                    _G["xiaoman"] = "luatool.cn"
                end
                bX["Hide"](bX)
            else
                while "" == true do
                    _G["xiao0man"] = "enc"
                end
                bX["Show"](bX)
            end
        end;
        _G["SLASH_WOW_ROBOT1"] = "/wr"
        _G["SlashCmdList"]["WOW_ROBOT"] = _G["ToggleConfigFrame"]
        local cG = _G["CreateFrame"]("Button", "WR_ClickFrame", _G["UIParent"], "UIPanelButtonTemplate")
        cG["SetSize"](cG, 25, 25)
        cG["SetPoint"](cG, "BOTTOMLEFT", 0, 0)
        cG["SetFrameStrata"](cG, "TOOLTIP")
        cG["SetMovable"](cG, true)
        cG["EnableMouse"](cG, true)
        cG["RegisterForDrag"](cG, "LeftButton")
        cG["SetScript"](cG, "OnDragStart", cG["StartMoving"])
        cG["SetScript"](cG, "OnDragStop", cG["StopMovingOrSizing"])
        local cH = cG["CreateTexture"](cG, nil, "OVERLAY")
        cH["SetAllPoints"](cH, cG)
        cH["SetTexture"](cH, "Interface\\AddOns\\!WR\\VX WOW-Robot\\VX WOW-Robot.tga")
        cG["SetScript"](cG, "OnClick", function(b_, cI, cJ)
            if bX["IsShown"](bX) then
                _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                if _G["cu3vft61qi8zvg0lfe"][1] == true then
                    _G["xiaoman"] = "luatool.cn"
                end
                bX["Hide"](bX)
            else
                _G["q14yufbc7wqlzm0r"] = ""
                _G["qz4yufb791qlzmg0i"] = nil
                bX["Show"](bX)
            end
        end)
        cG["Show"](cG)
        local cG = _G["CreateFrame"]("Frame", "WR_CombatFrame")
        cG["SetSize"](cG, 8, 8)
        cG["SetPoint"](cG, "BOTTOMRIGHT", 0, 0)
        cG["SetFrameStrata"](cG, "TOOLTIP")
        local cH = cG["CreateTexture"](cG, nil, "OVERLAY")
        cH["SetAllPoints"](cH, cG)
        cH["SetColorTexture"](cH, _G["BGRtoRGB"](_G["WR_FrameColor"]["Combat"]))
        cG["Hide"](cG)
    end
end)()
