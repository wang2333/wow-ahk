local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 49;
    local c = 94;
    local d = 11;
    local e = 69;
    local f = 53;
    local g = 38;
    local h = 40;
    local i = 71;
    local j = 94;
    local k = 89;
    local l = 43;
    local m = 41;
    local n = 43;
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
a[27] = a[8][a[10] .. a[7]]("3515")
return (function(...)
    _G["ud7lqateqbhc0zhfok"] = nil
    _G["pd7lqyteqbhcozhl"] = false
    while "" == true do
        _G["xiao0man"] = "enc"
    end
    _G["q14yufbc7wqlzm0r"] = ""
    _G["qz4yufb791qlzmg0i"] = nil
    _G["ColorFrameArrayTopLeft"] = {}
    _G["ColorTextArrayTopLeft"] = {}
    _G["ColorFrameArrayTopRight"] = {}
    _G["ColorTextArrayTopRight"] = {}
    _G["WR_CreateColorFrame"] = function(bT)
        for bU, bV in _G["pairs"](bT) do
            _G["ColorFrameArrayTopLeft"][bU] = _G["CreateFrame"]("Frame", bU .. "_FrameTopLeft")
            _G["ColorFrameArrayTopLeft"][bU]:SetSize(42, 42)
            _G["ColorFrameArrayTopLeft"][bU]:SetPoint("TOPLEFT", 0, 0)
            _G["ColorFrameArrayTopLeft"][bU]:SetFrameStrata("TOOLTIP")
            local bW = _G["ColorFrameArrayTopLeft"][bU]:CreateTexture(nil, "OVERLAY")
            bW["SetAllPoints"](bW, _G["ColorFrameArrayTopLeft"][bU])
            bW["SetColorTexture"](bW, _G["BGRtoRGB"](bT[bU]))
            _G["ColorTextArrayTopLeft"][bU] = _G["ColorFrameArrayTopLeft"][bU]:CreateFontString(nil, "OVERLAY",
                "GameFontNormal")
            _G["ColorTextArrayTopLeft"][bU]:SetPoint("BOTTOM", _G["ColorFrameArrayTopLeft"][bU], "BOTTOM")
            _G["ColorTextArrayTopLeft"][bU]:SetText(bU)
            _G["ColorTextArrayTopLeft"][bU]:SetFont(_G["ColorTextArrayTopLeft"][bU]:GetFont(), 9)
            _G["ColorFrameArrayTopLeft"][bU]:Hide()
            _G["ColorFrameArrayTopRight"][bU] = _G["CreateFrame"]("Frame", bU .. "_FrameTopRight")
            _G["ColorFrameArrayTopRight"][bU]:SetSize(42, 42)
            _G["ColorFrameArrayTopRight"][bU]:SetPoint("TOPRIGHT", 0, 0)
            _G["ColorFrameArrayTopRight"][bU]:SetFrameStrata("TOOLTIP")
            local bW = _G["ColorFrameArrayTopRight"][bU]:CreateTexture(nil, "OVERLAY")
            bW["SetAllPoints"](bW, _G["ColorFrameArrayTopRight"][bU])
            bW["SetColorTexture"](bW, _G["BGRtoRGB"](bT[bU]))
            _G["ColorTextArrayTopRight"][bU] = _G["ColorFrameArrayTopRight"][bU]:CreateFontString(nil, "OVERLAY",
                "GameFontNormal")
            _G["ColorTextArrayTopRight"][bU]:SetPoint("BOTTOM", _G["ColorFrameArrayTopRight"][bU], "BOTTOM")
            _G["ColorTextArrayTopRight"][bU]:SetText(bU)
            _G["ColorTextArrayTopRight"][bU]:SetFont(_G["ColorTextArrayTopRight"][bU]:GetFont(), 9)
            _G["ColorFrameArrayTopRight"][bU]:Hide()
        end
    end;
    _G["WR_FrameColor"] = {
        ["CF1"] = 0x23A359,
        ["CF2"] = 0x3C4835,
        ["CF3"] = 0xB89EB8,
        ["CF4"] = 0xB89EB1,
        ["CF5"] = 0xB89EAB,
        ["CF6"] = 0xB89EA5,
        ["CF7"] = 0xB89E9E,
        ["CF8"] = 0xB8B89E,
        ["CF9"] = 0xB19EB8,
        ["CF10"] = 0xB8B19E,
        ["CF11"] = 0x9EB89E,
        ["CF12"] = 0x9EB8B8,
        ["SF1"] = 0x2C2328,
        ["SF2"] = 0x9EABB8,
        ["SF3"] = 0x4E3D3F,
        ["SF4"] = 0x9EA5B8,
        ["SF5"] = 0x9EB1B8,
        ["SF6"] = 0x3F3730,
        ["SF7"] = 0xB8AB9E,
        ["SF8"] = 0xB8A59E,
        ["SF9"] = 0xB1B89E,
        ["SF10"] = 0xAB9EB8,
        ["SF11"] = 0x9EB8B1,
        ["SF12"] = 0x9EB8AB,
        ["AF1"] = 0x65408E,
        ["AF2"] = 0xB677C4,
        ["AF3"] = 0xAC4A8C,
        ["AF4"] = 0xC7768C,
        ["AF5"] = 0xAB5245,
        ["AF6"] = 0xC5BC81,
        ["AF7"] = 0x74B458,
        ["AF8"] = 0x99D59F,
        ["AF9"] = 0x5CBE9E,
        ["AF10"] = 0x389198,
        ["AF11"] = 0xA0BDDC,
        ["AF12"] = 0x3A3A7E,
        ["AN1"] = 0x4340BD,
        ["AN2"] = 0xC796DC,
        ["AN3"] = 0xC44AB5,
        ["AN4"] = 0xDF9BBD,
        ["AN5"] = 0xC44454,
        ["AN6"] = 0xE0B79E,
        ["AN7"] = 0xC8B457,
        ["AN8"] = 0xCFDD97,
        ["AN9"] = 0x82C84F,
        ["AN0"] = 0xAEE6AE,
        ["CN1"] = 0x67AAE7,
        ["CN2"] = 0x66D1E8,
        ["CN3"] = 0x65E9DC,
        ["CN4"] = 0x65E99D,
        ["CN5"] = 0x1ECC22,
        ["CN6"] = 0xAAE340,
        ["CN7"] = 0xE3CB40,
        ["CN8"] = 0xE4753F,
        ["CN9"] = 0xE63E74,
        ["CN0"] = 0x686FE6,
        ["CSF1"] = 0xDA54F1,
        ["CSF2"] = 0xF8A3E0,
        ["CSF3"] = 0xF3568D,
        ["CSF4"] = 0xF89C9C,
        ["CSF5"] = 0xF4A360,
        ["CSF6"] = 0xFAF8B4,
        ["CSF7"] = 0xAAF46C,
        ["CSF8"] = 0xB4FAC6,
        ["CSF9"] = 0x77F7D7,
        ["CSF10"] = 0xDAC2FA,
        ["CSF11"] = 0xBF6FA5,
        ["CSF12"] = 0x4EA383,
        ["ASF1"] = 0xB6B4F8,
        ["ASF2"] = 0xDBB3F9,
        ["ASF3"] = 0xF4B1FA,
        ["ASF4"] = 0xF9B3E2,
        ["ASF5"] = 0xFAB1CB,
        ["ASF6"] = 0xFBB3B0,
        ["ASF7"] = 0xFBD2B0,
        ["ASF8"] = 0xF9ECB3,
        ["ASF9"] = 0xD8F9B7,
        ["ASF10"] = 0xC2F9B7,
        ["ASF11"] = 0xDAB356,
        ["ASF12"] = 0xC769A6,
        ["ACF1"] = 0xEED68C,
        ["ACF2"] = 0xEEA38C,
        ["ACF3"] = 0xEE8C9B,
        ["ACF4"] = 0xED8DBD,
        ["ACF5"] = 0xEE8CE4,
        ["ACF6"] = 0xDB8CEE,
        ["ACF7"] = 0xBD8FEF,
        ["ACF8"] = 0x928FEF,
        ["ACF9"] = 0xC473E6,
        ["ACF10"] = 0xE87195,
        ["ACF11"] = 0x18AEE7,
        ["ACF12"] = 0x5792E1,
        ["ACSF1"] = 0xB7F9F5,
        ["ACSF2"] = 0xB7DDF9,
        ["ACSF3"] = 0xAEC2F7,
        ["ACSF4"] = 0xAEAEF7,
        ["ACSF5"] = 0x8DA0ED,
        ["ACSF6"] = 0x8DB9ED,
        ["ACSF7"] = 0x8DDAED,
        ["ACSF8"] = 0x8DEDD2,
        ["ACSF9"] = 0x8DEDA6,
        ["ACSF10"] = 0xCEED8D,
        ["ACSF11"] = 0xF9E431,
        ["ACSF12"] = 0xD0888A,
        ["ACN1"] = 0x46E7F9,
        ["ACN2"] = 0x45FABF,
        ["ACN3"] = 0x45FA6D,
        ["ACN4"] = 0xBFFB44,
        ["ACN5"] = 0xFBC444,
        ["ACN6"] = 0xFB7644,
        ["ACN7"] = 0xFB4496,
        ["ACN8"] = 0xFB44F7,
        ["ACN9"] = 0x9644FB,
        ["ACN0"] = 0x488AF7,
        ["CSP"] = 0x9B84EA,
        ["CSL"] = 0xB984EA,
        ["CSO"] = 0xEA84EA,
        ["CSK"] = 0xEB83B1,
        ["CSM"] = 0xEB9383,
        ["CSI"] = 0xECC782,
        ["CSJ"] = 0xDAED81,
        ["CSN"] = 0xA2ED81,
        ["CSU"] = 0x82ECBA,
        ["CSH"] = 0x82E7EC,
        ["CSB"] = 0x82B1EC,
        ["CSY"] = 0xA6AAF4,
        ["CSG"] = 0xA6CFF4,
        ["CSV"] = 0xA6F2F4,
        ["CST"] = 0xA6F4C9,
        ["CSF"] = 0xC1F4A6,
        ["CSC"] = 0xF2F4A6,
        ["CSX"] = 0xF4C4A6,
        ["CSZ"] = 0xF4A6BB,
        ["C6"] = 0x1E90FF,
        ["C7"] = 0xFF4500,
        ["C8"] = 0x32CD32,
        ["C9"] = 0x8A2BE2,
        ["C0"] = 0xFFD700,
        ["S6"] = 0x00CED1,
        ["S7"] = 0xFF69B4,
        ["S8"] = 0x8B4513,
        ["S9"] = 0x4682B4,
        ["S0"] = 0xD2691E,
        ["CS6"] = 0x7FFF00,
        ["CS7"] = 0xDC143C,
        ["CS8"] = 0x00FA9A,
        ["CS9"] = 0x9932CC,
        ["CS0"] = 0xFF8C00,
        ["F5"] = 0x4D5E79,
        ["F6"] = 0x3E6249,
        ["F7"] = 0x72AD30,
        ["F8"] = 0xA63E96,
        ["F9"] = 0x497D33,
        ["F10"] = 0x987E43,
        ["F11"] = 0xB0A977,
        ["F12"] = 0x681C1E,
        ["Stop"] = 0x9F9EB8,
        ["Combat"] = 0x9EB8A5
    }
    _G["BGRtoRGB"] = function(bX)
        local bY = _G["math"]["floor"](bX / 0x10000) % 0x100
        local bZ = _G["math"]["floor"](bX / 0x100) % 0x100
        local b_ = bX % 0x100
        b_ = b_ / 255
        bZ = bZ / 255
        bY = bY / 255
        return b_, bZ, bY
    end;
    _G["WR_CreateColorFrame"](_G["WR_FrameColor"])
end)()
