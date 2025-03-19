local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 96;
    local c = 64;
    local d = 59;
    local e = 89;
    local f = 16;
    local g = 13;
    local h = 32;
    local i = 80;
    local j = 27;
    local k = 72;
    local l = 44;
    local m = 36;
    local n = 89;
    local o = 54;
    local p = 63;
    local q = 28;
    local r = "g"
    local s = "m"
    local t = "n"
    local u = "a"
    local v = "b"
    local w = "p"
    local x = "r"
    local y = "s"
    local z = "t"
    local A = "c"
    local B = "o"
    local C = "u"
    local D = "h"
    local E = "d"
    local F = "e"
    local G = "i"
    local H = "k"
    local I = "l"
    local J = "y"
    local K = "w"
    local L = a[8][z .. u .. v .. I .. F][A .. B .. t .. A .. u .. z]
    local M = a[8][s .. u .. z .. D][I .. E .. F .. a[2] .. w] or a[8][s .. u .. z .. D][y .. A .. u .. I .. F]
    local N = y .. z .. x .. G .. t .. r;
    local O = a[8][y .. F .. z .. s .. F .. z .. u .. z .. u .. v .. I .. F]
    local P = a[8][N][y .. C .. v]
    local Q = a[8][N][A .. D .. u .. x]
    local R = a[8][y .. F .. I .. F .. A .. z]
    local S = a[8][N][v .. J .. z .. F]
    local T = function()
        return a[8]
    end;
    local U = a[8][z .. u .. v .. I .. F][C .. t .. w .. u .. A .. H] or a[8][C .. t .. w .. u .. A .. H]
    local V = a[8][N][r .. y .. C .. v]
    local W = a[8][z .. B .. t .. C .. s .. v .. F .. x]
    local function X(Y)
        local Z, _, a0 = "", "", {}
        local a1 = 256;
        local a2 = {}
        if Y == x then
            return _
        end
        for a3 = 0, a1 - 1 do
            a2[a3] = Q(a3)
        end
        local a4 = 1;
        local function a5()
            local a6 = W(P(Y, a4, a4), 36)
            a4 = a4 + 1;
            local a7 = W(P(Y, a4, a4 + a6 - 1), 36)
            a4 = a4 + a6;
            return a7
        end
        Z = Q(a5())
        a0[1] = Z;
        while a4 < #Y do
            local a8 = a5()
            if a2[a8] then
                _ = a2[a8]
            else
                _ = Z .. P(Z, 1, 1)
            end
            a2[a1] = Z .. P(_, 1, 1)
            a0[#a0 + 1], Z, a1 = _, _, a1 + 1
        end
        return L(a0)
    end
    local l = a[10]
    local a9 = a[8][v .. G .. z] and a[8][v .. G .. z][v .. a[2] .. B .. x] or function(aa, Y)
        local ab, Z = 1, 0;
        while aa > 0 and Y > 0 do
            local ac, ad = aa % 2, Y % 2;
            if ac ~= ad then
                Z = Z + ab
            end
            aa, Y, ab = (aa - ac) / 2, (Y - ad) / 2, ab * 2
        end
        if aa < Y then
            aa = Y
        end
        while aa > 0 do
            local ac = aa % 2;
            if ac > 0 then
                Z = Z + ab
            end
            aa, ab = (aa - ac) / 2, ab * 2
        end
        return Z
    end;
    local ae = l .. a[15]
    local af = T()
    local ag = l .. a[5]
    local function ah(ai, aj, ak)
        if ak then
            local al = ai / 2 ^ (aj - 1) % 2 ^ (ak - 1 - (aj - 1) + 1)
            return al - al % 1
        else
            local am = 2 ^ (aj - 1)
            return ai % (am + am) >= am and 1 or 0
        end
    end
    local an = l .. a[9]
    local ao = 1;
    local ap = l .. a[14]
    local aq = X(x)
    local ar = l .. a[1]
    local function as()
        local at, au, av, aw = S(aq, ao, ao + 3)
        at = a9(at, 156)
        au = a9(au, 156)
        av = a9(av, 156)
        aw = a9(aw, 156)
        ao = ao + 4;
        return aw * 16777216 + av * 65536 + au * 256 + at
    end
    local ax = l .. a[19]
    local ay = X(t .. a[4] .. z)
    local function az()
        local aA = a9(S(aq, ao, ao), 156)
        ao = ao + 1;
        return aA
    end
    local aB = a[8][a[10]]
    local aC = l .. a[7]
    local function aD()
        local aE = as()
        local aF = as()
        local aG = 1;
        local aH = ah(aF, 1, 20) * 2 ^ 32 + aE;
        local aI = ah(aF, 21, 31)
        local aJ = (-1) ^ ah(aF, 32)
        if aI == 0 then
            if aH == 0 then
                return aJ * 0
            else
                aI = 1;
                aG = 0
            end
        elseif aI == 2047 then
            return aH == 0 and aJ * 1 / 0 or aJ * 0 / 0
        end
        return M(aJ, aI - 1023) * (aG + aH / 2 ^ 52)
    end
    local aK = a[12]
    local aL = ay == a[17]
    local aM = l .. a[11]
    local aN = as;
    local function aO(aP)
        local aQ;
        if not aP then
            aP = aN()
            if aP == 0 then
                return ""
            end
        end
        aQ = P(aq, ao, ao + aP - 1)
        ao = ao + aP;
        local aR = {}
        for aS = 1, #aQ do
            aR[aS] = Q(a9(S(P(aQ, aS, aS)), 156))
        end
        return L(aR)
    end
    local aT = l .. a[4]
    local aU = as;
    local aV = ay == F;
    local aW = a[3]
    local function aX(...)
        return {...}, R("#", ...)
    end
    local function aY(aZ, a_, b0)
        local function b1(a3, b2)
            local b3 = aq;
            for a4 = 1, #b2 do
                local Z = S(b2, a4, a4) - (a3 + a4) % 256;
                if Z < 0 then
                    Z = Z + 256
                end
                b3 = b3 .. Q(Z)
            end
            return b3
        end
        local function b4(b5)
            return V(b5, '..', function(b6)
                return Q(W(b6, 16) % 256)
            end)
        end
        af[ap] = function(b7)
            return aD() .. b7
        end;
        af[an] = function(b8, b9)
            return W(b1(b8, b4(b9)))
        end;
        af[aT] = function()
            return aB
        end;
        af[ae] = function()
            return aq
        end;
        af[aM] = function(ba, bb)
            return b1(ba, b4(bb))
        end;
        af[ar] = function()
            return aV
        end;
        af[ag] = function()
            return a_
        end;
        af[aC] = function(a5)
            local a3 = 0;
            for a4 = 1, #a5 do
                a3 = a3 + S(a5, a4, a4)
            end
            return a3
        end;
        af[ax] = function()
            return aL
        end;
        return b4(aZ .. b0)
    end
    local function bc()
        local bd = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0}
        local be = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local bf = {}
        local bg = {bd, nil, be, nil, bf}
        if I ~= t then
            return be
        end
        bg[4] = az()
        for aS = 1, as() do
            local bh = a9(as(), 182)
            local bi = a9(as(), 119)
            local bj = ah(bh, 1, 2)
            local bk = ah(bi, 1, 11)
            local bl = {bk, ah(bh, 3, 11), nil, nil, bi}
            if bj == 0 then
                bl[3] = ah(bh, 12, 20)
                bl[5] = ah(bh, 21, 29)
            elseif bj == 1 then
                bl[3] = ah(bi, 12, 33)
            elseif bj == 2 then
                bl[3] = ah(bi, 12, 32) - 1048575
            elseif bj == 3 then
                bl[3] = ah(bi, 12, 32) - 1048575;
                bl[5] = ah(bh, 21, 29)
            end
            bd[aS] = bl
        end
        local bm = as()
        local bn = {0, 0, 0, 0, 0, 0, 0}
        for aS = 1, bm do
            local bj = az()
            local bo;
            if bj == 1 then
                bo = az() ~= 0
            elseif bj == 2 then
                bo = aD()
            elseif bj == 0 then
                bo = aO()
            end
            bn[aS] = bo
        end
        bg[2] = bn;
        for aS = 1, as() do
            be[aS - 1] = bc()
        end
        return bg
    end
    local function bp(bg, bq, br)
        local bs = bg[1]
        local bt = bg[2]
        local bu = bg[3]
        local bv = bg[4]
        return function(...)
            local bs = bs;
            local bt = bt;
            local bu = bu;
            local bv = bv;
            local bw = aY(aW, af, aK)
            local aX = aX;
            local bx = 1;
            local by = -1;
            if ay ~= H then
                return bx
            end
            local bz = {}
            local bA = {...}
            local bB = {}
            local bC = R("#", ...) - 1;
            for aS = 0, bC do
                if aS >= bv then
                    bz[aS - bv] = bA[aS + 1]
                else
                    bB[aS] = bA[aS + 1]
                end
            end
            local bD = bC - bv + 1;
            local bl;
            local bE;
            while true do
                bl = bs[bx]
                bE = bl[1]
                if bE <= 34 then
                    if bE <= 16 then
                        if bE <= 7 then
                            if bE <= 3 then
                                if bE <= 1 then
                                    if bE == 0 then
                                        bB[bl[2]] = bB[bl[3]] + bt[bl[5]]
                                    else
                                        local bF = bl[2]
                                        local bA = {}
                                        local bG = 0;
                                        local bH = bF + bl[3] - 1;
                                        for aS = bF + 1, bH do
                                            bG = bG + 1;
                                            bA[bG] = bB[aS]
                                        end
                                        local bI = {bB[bF](U(bA, 1, bH - bF))}
                                        local bH = bF + bl[5] - 2;
                                        bG = 0;
                                        for aS = bF, bH do
                                            bG = bG + 1;
                                            bB[aS] = bI[bG]
                                        end
                                        by = bH
                                    end
                                elseif bE == 2 then
                                    local bJ = bu[bl[3]]
                                    local bK;
                                    local bL = {}
                                    bK = O({}, {
                                        [a[16] .. a[16] .. G .. t .. E .. F .. a[2]] = function(bM, bN)
                                            local bO = bL[bN]
                                            return bO[1][bO[2]]
                                        end,
                                        [a[16] .. a[16] .. t .. F .. K .. G .. t .. E .. F .. a[2]] = function(bM, bN,
                                            bP)
                                            local bO = bL[bN]
                                            bO[1][bO[2]] = bP
                                        end
                                    })
                                    for aS = 1, bl[5] do
                                        bx = bx + 1;
                                        local bQ = bs[bx]
                                        if bQ[1] == 7 then
                                            bL[aS - 1] = {bB, bQ[3]}
                                        else
                                            bL[aS - 1] = {bq, bQ[3]}
                                        end
                                        bw[#bw + 1] = bL
                                    end
                                    bB[bl[2]] = bp(bJ, bK, br)
                                else
                                    local bF = bl[2]
                                    local bR = bB[bl[3]]
                                    bB[bF + 1] = bR;
                                    bB[bF] = bR[bt[bl[5]]]
                                end
                            elseif bE <= 5 then
                                if bE > 4 then
                                    local bF;
                                    bB[bl[2]] = bt[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = #bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bt[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = #bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bt[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bB[bF] = bB[bF] - bB[bF + 2]
                                    bx = bx + bl[3]
                                else
                                    local bS;
                                    local bI, bH;
                                    local bH;
                                    local bG;
                                    local bA;
                                    local bF;
                                    bB[bl[2]] = br[bt[bl[3]]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bq[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bq[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bA = {}
                                    bG = 0;
                                    bH = bF + bl[3] - 1;
                                    for aS = bF + 1, bH do
                                        bG = bG + 1;
                                        bA[bG] = bB[aS]
                                    end
                                    bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                                    bH = bH + bF - 1;
                                    bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bB[aS] = bI[bG]
                                    end
                                    by = bH;
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bA = {}
                                    bG = 0;
                                    bH = by;
                                    for aS = bF + 1, bH do
                                        bG = bG + 1;
                                        bA[bG] = bB[aS]
                                    end
                                    bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                                    bH = bH + bF - 1;
                                    bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bB[aS] = bI[bG]
                                    end
                                    by = bH;
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bA = {}
                                    bH = by;
                                    for aS = bF + 1, bH do
                                        bA[#bA + 1] = bB[aS]
                                    end
                                    do
                                        return bB[bF](U(bA, 1, bH - bF))
                                    end
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bH = by;
                                    bS = {}
                                    bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bS[bG] = bB[aS]
                                    end
                                    do
                                        return U(bS, 1, bG)
                                    end
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    do
                                        return
                                    end
                                end
                            elseif bE > 6 then
                                bB[bl[2]] = bB[bl[3]]
                            else
                                bx = bx + bl[3]
                            end
                        elseif bE <= 11 then
                            if bE <= 9 then
                                if bE == 8 then
                                    bB[bl[2]] = br[bt[bl[3]]]
                                else
                                    local bR;
                                    local bI;
                                    local bH;
                                    local bG;
                                    local bA;
                                    local bF;
                                    bB[bl[2]] = bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bA = {}
                                    bG = 0;
                                    bH = bF + bl[3] - 1;
                                    for aS = bF + 1, bH do
                                        bG = bG + 1;
                                        bA[bG] = bB[aS]
                                    end
                                    bI = {bB[bF](U(bA, 1, bH - bF))}
                                    bH = bF + bl[5] - 2;
                                    bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bB[aS] = bI[bG]
                                    end
                                    by = bH;
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]] + bB[bl[5]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]] % bt[bl[5]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bR = bB[bl[3]]
                                    bB[bF + 1] = bR;
                                    bB[bF] = bR[bt[bl[5]]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bB[bl[2]] = bB[bl[3]]
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    bF = bl[2]
                                    bA = {}
                                    bG = 0;
                                    bH = bF + bl[3] - 1;
                                    for aS = bF + 1, bH do
                                        bG = bG + 1;
                                        bA[bG] = bB[aS]
                                    end
                                    bI = {bB[bF](U(bA, 1, bH - bF))}
                                    bH = bF + bl[5] - 2;
                                    bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bB[aS] = bI[bG]
                                    end
                                    by = bH;
                                    bx = bx + 1;
                                    bl = bs[bx]
                                    if bB[bl[2]] > bB[bl[5]] then
                                        bx = bx + 1
                                    else
                                        bx = bx + bl[3]
                                    end
                                end
                            elseif bE > 10 then
                                local bR = bB[bl[3]]
                                if not bR then
                                    bx = bx + 1
                                else
                                    bB[bl[2]] = bR;
                                    bx = bx + bs[bx + 1][3] + 1
                                end
                            else
                                local bS;
                                local bI, bH;
                                local bH;
                                local bG;
                                local bA;
                                local bF;
                                bB[bl[2]] = bq[bl[3]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bB[bl[2]] = bB[bl[3]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bB[bl[2]] = bq[bl[3]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bB[bl[2]] = bB[bl[3]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bF = bl[2]
                                bA = {}
                                bG = 0;
                                bH = bF + bl[3] - 1;
                                for aS = bF + 1, bH do
                                    bG = bG + 1;
                                    bA[bG] = bB[aS]
                                end
                                bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                                bH = bH + bF - 1;
                                bG = 0;
                                for aS = bF, bH do
                                    bG = bG + 1;
                                    bB[aS] = bI[bG]
                                end
                                by = bH;
                                bx = bx + 1;
                                bl = bs[bx]
                                bF = bl[2]
                                bA = {}
                                bH = by;
                                for aS = bF + 1, bH do
                                    bA[#bA + 1] = bB[aS]
                                end
                                do
                                    return bB[bF](U(bA, 1, bH - bF))
                                end
                                bx = bx + 1;
                                bl = bs[bx]
                                bF = bl[2]
                                bH = by;
                                bS = {}
                                bG = 0;
                                for aS = bF, bH do
                                    bG = bG + 1;
                                    bS[bG] = bB[aS]
                                end
                                do
                                    return U(bS, 1, bG)
                                end
                                bx = bx + 1;
                                bl = bs[bx]
                                do
                                    return
                                end
                            end
                        elseif bE <= 13 then
                            if bE == 12 then
                                bB[bl[2]] = bl[3] ~= 0
                            else
                                local bF = bl[2]
                                local bA = {}
                                local bH = by;
                                for aS = bF + 1, bH do
                                    bA[#bA + 1] = bB[aS]
                                end
                                do
                                    return bB[bF](U(bA, 1, bH - bF))
                                end
                            end
                        elseif bE <= 14 then
                            local bF = bl[2]
                            local bA = {}
                            local bG = 0;
                            local bH = bF + bl[3] - 1;
                            for aS = bF + 1, bH do
                                bG = bG + 1;
                                bA[bG] = bB[aS]
                            end
                            local bI = {bB[bF](U(bA, 1, bH - bF))}
                            local bH = bF + bl[5] - 2;
                            bG = 0;
                            for aS = bF, bH do
                                bG = bG + 1;
                                bB[aS] = bI[bG]
                            end
                            by = bH
                        elseif bE == 15 then
                            bB[bl[2]] = bB[bl[3]] % bB[bl[5]]
                        else
                            local bF = bl[2]
                            local bA = {}
                            local bG = 0;
                            local bH = bF + bl[3] - 1;
                            for aS = bF + 1, bH do
                                bG = bG + 1;
                                bA[bG] = bB[aS]
                            end
                            local bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                            bH = bH + bF - 1;
                            bG = 0;
                            for aS = bF, bH do
                                bG = bG + 1;
                                bB[aS] = bI[bG]
                            end
                            by = bH
                        end
                    elseif bE <= 25 then
                        if bE <= 20 then
                            if bE <= 18 then
                                if bE > 17 then
                                    local bF = bl[2]
                                    local bA = {}
                                    local bH = by;
                                    for aS = bF + 1, bH do
                                        bA[#bA + 1] = bB[aS]
                                    end
                                    do
                                        return bB[bF](U(bA, 1, bH - bF))
                                    end
                                else
                                    bB[bl[2]] = bB[bl[3]] + bt[bl[5]]
                                end
                            elseif bE == 19 then
                                local bT;
                                local bR;
                                local bI;
                                local bH;
                                local bG;
                                local bA;
                                local bF;
                                bB[bl[2]] = br[bt[bl[3]]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bB[bl[2]] = bB[bl[3]][bt[bl[5]]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bB[bl[2]] = bB[bl[3]]
                                bx = bx + 1;
                                bl = bs[bx]
                                bF = bl[2]
                                bA = {}
                                bG = 0;
                                bH = bF + bl[3] - 1;
                                for aS = bF + 1, bH do
                                    bG = bG + 1;
                                    bA[bG] = bB[aS]
                                end
                                bI = {bB[bF](U(bA, 1, bH - bF))}
                                bH = bF + bl[5] - 2;
                                bG = 0;
                                for aS = bF, bH do
                                    bG = bG + 1;
                                    bB[aS] = bI[bG]
                                end
                                by = bH;
                                bx = bx + 1;
                                bl = bs[bx]
                                bR = bl[3]
                                bT = bB[bR]
                                for aS = bR + 1, bl[5] do
                                    bT = bT .. bB[aS]
                                end
                                bB[bl[2]] = bT
                            else
                                bB[bl[2]] = bq[bl[3]]
                            end
                        elseif bE <= 22 then
                            if bE == 21 then
                                local bF = bl[2]
                                bB[bF] = bB[bF] - bB[bF + 2]
                                bx = bx + bl[3]
                            else
                                local bJ = bu[bl[3]]
                                local bK;
                                local bL = {}
                                bK = O({}, {
                                    [a[16] .. a[16] .. G .. t .. E .. F .. a[2]] = function(bM, bN)
                                        local bO = bL[bN]
                                        return bO[1][bO[2]]
                                    end,
                                    [a[16] .. a[16] .. t .. F .. K .. G .. t .. E .. F .. a[2]] = function(bM, bN, bP)
                                        local bO = bL[bN]
                                        bO[1][bO[2]] = bP
                                    end
                                })
                                for aS = 1, bl[5] do
                                    bx = bx + 1;
                                    local bQ = bs[bx]
                                    if bQ[1] == 7 then
                                        bL[aS - 1] = {bB, bQ[3]}
                                    else
                                        bL[aS - 1] = {bq, bQ[3]}
                                    end
                                    bw[#bw + 1] = bL
                                end
                                bB[bl[2]] = bp(bJ, bK, br)
                            end
                        elseif bE <= 23 then
                            bB[bl[2]] = br[bt[bl[3]]]
                        elseif bE == 24 then
                            bB[bl[2]] = bB[bl[3]] % bB[bl[5]]
                        else
                            bB[bl[2]] = bB[bl[3]][bt[bl[5]]]
                        end
                    elseif bE <= 29 then
                        if bE <= 27 then
                            if bE == 26 then
                                local bR = bl[3]
                                local bT = bB[bR]
                                for aS = bR + 1, bl[5] do
                                    bT = bT .. bB[aS]
                                end
                                bB[bl[2]] = bT
                            else
                                bB[bl[2]] = bB[bl[3]] + bB[bl[5]]
                            end
                        elseif bE == 28 then
                            bB[bl[2]] = bp(bu[bl[3]], nil, br)
                        else
                            local bF = bl[2]
                            local bA = {}
                            local bH = bF + bl[3] - 1;
                            for aS = bF + 1, bH do
                                bA[#bA + 1] = bB[aS]
                            end
                            do
                                return bB[bF](U(bA, 1, bH - bF))
                            end
                        end
                    elseif bE <= 31 then
                        if bE == 30 then
                            bB[bl[2]] = bB[bl[3]]
                        else
                            bB[bl[2]] = bB[bl[3]] % bt[bl[5]]
                        end
                    elseif bE <= 32 then
                        local bF = bl[2]
                        bB[bF] = bB[bF] - bB[bF + 2]
                        bx = bx + bl[3]
                    elseif bE == 33 then
                        bB[bl[2]] = #bB[bl[3]]
                    else
                        if bB[bl[2]] == bt[bl[5]] then
                            bx = bx + 1
                        else
                            bx = bx + bl[3]
                        end
                    end
                elseif bE <= 51 then
                    if bE <= 42 then
                        if bE <= 38 then
                            if bE <= 36 then
                                if bE > 35 then
                                    local bF = bl[2]
                                    local bA = {}
                                    local bG = 0;
                                    local bH = bF + bl[3] - 1;
                                    for aS = bF + 1, bH do
                                        bG = bG + 1;
                                        bA[bG] = bB[aS]
                                    end
                                    local bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                                    bH = bH + bF - 1;
                                    bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bB[aS] = bI[bG]
                                    end
                                    by = bH
                                else
                                    local bF = bl[2]
                                    local bH = by;
                                    local bS = {}
                                    local bG = 0;
                                    for aS = bF, bH do
                                        bG = bG + 1;
                                        bS[bG] = bB[aS]
                                    end
                                    do
                                        return U(bS, 1, bG)
                                    end
                                end
                            elseif bE == 37 then
                                bB[bl[2]] = bp(bu[bl[3]], nil, br)
                            else
                                bB[bl[2]] = bt[bl[3]]
                            end
                        elseif bE <= 40 then
                            if bE > 39 then
                                local bF = bl[2]
                                local bA = {}
                                local bG = 0;
                                local bH = by;
                                for aS = bF + 1, bH do
                                    bG = bG + 1;
                                    bA[bG] = bB[aS]
                                end
                                local bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                                bH = bH + bF - 1;
                                bG = 0;
                                for aS = bF, bH do
                                    bG = bG + 1;
                                    bB[aS] = bI[bG]
                                end
                                by = bH
                            else
                                bB[bl[2]] = bB[bl[3]] - bB[bl[5]]
                            end
                        elseif bE == 41 then
                            local bF = bl[2]
                            local bU = bB[bF + 2]
                            local bV = bB[bF] + bU;
                            bB[bF] = bV;
                            if bU > 0 then
                                if bV <= bB[bF + 1] then
                                    bx = bx + bl[3]
                                    bB[bF + 3] = bV
                                end
                            elseif bV >= bB[bF + 1] then
                                bx = bx + bl[3]
                                bB[bF + 3] = bV
                            end
                        else
                            if bB[bl[2]] == bt[bl[5]] then
                                bx = bx + 1
                            else
                                bx = bx + bl[3]
                            end
                        end
                    elseif bE <= 46 then
                        if bE <= 44 then
                            if bE > 43 then
                                bB[bl[2]] = bl[3] ~= 0
                            else
                                local bF = bl[2]
                                local bH = bF + bl[3] - 2;
                                local bS = {}
                                local bG = 0;
                                for aS = bF, bH do
                                    bG = bG + 1;
                                    bS[bG] = bB[aS]
                                end
                                do
                                    return U(bS, 1, bG)
                                end
                            end
                        elseif bE == 45 then
                            local bF = bl[2]
                            local bH = bF + bl[3] - 2;
                            local bS = {}
                            local bG = 0;
                            for aS = bF, bH do
                                bG = bG + 1;
                                bS[bG] = bB[aS]
                            end
                            do
                                return U(bS, 1, bG)
                            end
                        else
                            bB[bl[2]] = bB[bl[3]] % bt[bl[5]]
                        end
                    elseif bE <= 48 then
                        if bE == 47 then
                            local bF = bl[2]
                            local bR = bB[bl[3]]
                            bB[bF + 1] = bR;
                            bB[bF] = bR[bt[bl[5]]]
                        else
                            local bF = bl[2]
                            local bA = {}
                            local bH = bF + bl[3] - 1;
                            for aS = bF + 1, bH do
                                bA[#bA + 1] = bB[aS]
                            end
                            do
                                return bB[bF](U(bA, 1, bH - bF))
                            end
                        end
                    elseif bE <= 49 then
                        bB[bl[2]] = bB[bl[3]] - bB[bl[5]]
                    elseif bE > 50 then
                        local bF = bl[2]
                        local bA = {}
                        local bG = 0;
                        local bH = by;
                        for aS = bF + 1, bH do
                            bG = bG + 1;
                            bA[bG] = bB[aS]
                        end
                        local bI, bH = aX(bB[bF](U(bA, 1, bH - bF)))
                        bH = bH + bF - 1;
                        bG = 0;
                        for aS = bF, bH do
                            bG = bG + 1;
                            bB[aS] = bI[bG]
                        end
                        by = bH
                    else
                        local bF = bl[2]
                        local bH = by;
                        local bS = {}
                        local bG = 0;
                        for aS = bF, bH do
                            bG = bG + 1;
                            bS[bG] = bB[aS]
                        end
                        do
                            return U(bS, 1, bG)
                        end
                    end
                elseif bE <= 60 then
                    if bE <= 55 then
                        if bE <= 53 then
                            if bE == 52 then
                                bB[bl[2]] = #bB[bl[3]]
                            else
                                br[bt[bl[3]]] = bB[bl[2]]
                            end
                        elseif bE > 54 then
                            local bR = bl[3]
                            local bT = bB[bR]
                            for aS = bR + 1, bl[5] do
                                bT = bT .. bB[aS]
                            end
                            bB[bl[2]] = bT
                        else
                            do
                                return
                            end
                        end
                    elseif bE <= 57 then
                        if bE == 56 then
                            bB[bl[2]] = bt[bl[3]]
                        else
                            bx = bx + bl[3]
                        end
                    elseif bE <= 58 then
                        bB[bl[2]] = bB[bl[3]] + bB[bl[5]]
                    elseif bE == 59 then
                        if bB[bl[2]] > bB[bl[5]] then
                            bx = bx + 1
                        else
                            bx = bx + bl[3]
                        end
                    else
                        br[bt[bl[3]]] = bB[bl[2]]
                    end
                elseif bE <= 64 then
                    if bE <= 62 then
                        if bE > 61 then
                            local bR = bB[bl[3]]
                            if not bR then
                                bx = bx + 1
                            else
                                bB[bl[2]] = bR;
                                bx = bx + bs[bx + 1][3] + 1
                            end
                        else
                            if not bB[bl[2]] then
                                bx = bx + 1
                            else
                                bx = bx + bl[3]
                            end
                        end
                    elseif bE > 63 then
                        local bS;
                        local bI;
                        local bH;
                        local bG;
                        local bA;
                        local bF;
                        bB[bl[2]] = br[bt[bl[3]]]
                        bx = bx + 1;
                        bl = bs[bx]
                        bB[bl[2]] = bB[bl[3]][bt[bl[5]]]
                        bx = bx + 1;
                        bl = bs[bx]
                        bB[bl[2]] = br[bt[bl[3]]]
                        bx = bx + 1;
                        bl = bs[bx]
                        bB[bl[2]] = bB[bl[3]]
                        bx = bx + 1;
                        bl = bs[bx]
                        bB[bl[2]] = bt[bl[3]]
                        bx = bx + 1;
                        bl = bs[bx]
                        bF = bl[2]
                        bA = {}
                        bG = 0;
                        bH = bF + bl[3] - 1;
                        for aS = bF + 1, bH do
                            bG = bG + 1;
                            bA[bG] = bB[aS]
                        end
                        bI = {bB[bF](U(bA, 1, bH - bF))}
                        bH = bF + bl[5] - 2;
                        bG = 0;
                        for aS = bF, bH do
                            bG = bG + 1;
                            bB[aS] = bI[bG]
                        end
                        by = bH;
                        bx = bx + 1;
                        bl = bs[bx]
                        bB[bl[2]] = bB[bl[3]] % bt[bl[5]]
                        bx = bx + 1;
                        bl = bs[bx]
                        bF = bl[2]
                        bA = {}
                        bH = bF + bl[3] - 1;
                        for aS = bF + 1, bH do
                            bA[#bA + 1] = bB[aS]
                        end
                        do
                            return bB[bF](U(bA, 1, bH - bF))
                        end
                        bx = bx + 1;
                        bl = bs[bx]
                        bF = bl[2]
                        bH = by;
                        bS = {}
                        bG = 0;
                        for aS = bF, bH do
                            bG = bG + 1;
                            bS[bG] = bB[aS]
                        end
                        do
                            return U(bS, 1, bG)
                        end
                        bx = bx + 1;
                        bl = bs[bx]
                        do
                            return
                        end
                    else
                        bB[bl[2]] = bq[bl[3]]
                    end
                elseif bE <= 66 then
                    if bE > 65 then
                        local bF = bl[2]
                        local bU = bB[bF + 2]
                        local bV = bB[bF] + bU;
                        bB[bF] = bV;
                        if bU > 0 then
                            if bV <= bB[bF + 1] then
                                bx = bx + bl[3]
                                bB[bF + 3] = bV
                            end
                        elseif bV >= bB[bF + 1] then
                            bx = bx + bl[3]
                            bB[bF + 3] = bV
                        end
                    else
                        if not bB[bl[2]] then
                            bx = bx + 1
                        else
                            bx = bx + bl[3]
                        end
                    end
                elseif bE <= 67 then
                    bB[bl[2]] = bB[bl[3]][bt[bl[5]]]
                elseif bE == 68 then
                    do
                        return
                    end
                else
                    if bB[bl[2]] > bB[bl[5]] then
                        bx = bx + 1
                    else
                        bx = bx + bl[3]
                    end
                end
                bx = bx + 1
            end
        end
    end
    return bp(bc(), {}, T())()
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
a[27] = a[8][a[10] .. a[7]]("09714BDD")
return (function(...)
    _G["q14yufbc7wqlzm0r"] = ""
    _G["qz4yufb791qlzmg0i"] = nil
    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
        _G["wlx"] = "xiaoman.top"
    end
    _G["ud7lqateqbhc0zhfok"] = nil
    _G["pd7lqyteqbhcozhl"] = false
    _G["WR_PriestConfigFrame"] = function()
        if _G["WR_ConfigIsOK"] ~= nil then
            _G["qxw3iagfxbqp1ilz"] = function(bW)
                _G["xm"] = "小满"
                _G["xiao1man"](bW)
            end;
            return
        end
        if not _G["WR_FidOldInfo20250307"] then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            if _G["WR_FidGoodOld20250307"] then
                while "" == true do
                    _G["xiao0man"] = "enc"
                end
                _G["WR_FidGoodOld20250307"]()
            end
            return
        end
        if not _G["Welcome_XiaoManZS"] then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            if _G["WR_BN_Tag_20250314"] then
                if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                    _G["wlx"] = "xiaoman.top"
                end
                _G["WR_BN_Tag_20250314"]()
            end
            return
        end
        _G["WR_ConfigIsOK"] = true
        local bX = 185
        local bY = 250
        local bZ = -15
        local b_ = _G["CreateFrame"]("Frame", "WowRobotConfigFrame", _G["UIParent"], "UIPanelDialogTemplate")
        b_["SetSize"](b_, bX, bY)
        b_["SetPoint"](b_, "LEFT", -5, 0)
        b_["SetMovable"](b_, true)
        b_["EnableMouse"](b_, true)
        b_["RegisterForDrag"](b_, "LeftButton")
        b_["SetScript"](b_, "OnDragStart", b_["StartMoving"])
        b_["SetScript"](b_, "OnDragStop", b_["StopMovingOrSizing"])
        b_["SetFrameStrata"](b_, "FULLSCREEN")
        b_["Hide"](b_)
        b_["title"] = b_["CreateFontString"](b_, nil, "OVERLAY", "GameFontHighlight")
        b_["title"]:SetPoint("TOP", b_["Title"], "TOP", 0, 0)
        b_["title"]:SetText("|cff00adf0WOW-Robot")
        local c0 = b_["CreateTexture"](b_, nil, "ARTWORK")
        c0["SetSize"](c0, 40, 40)
        c0["SetPoint"](c0, "TOPLEFT", 20, -35)
        c0["SetTexture"](c0, "Interface\\AddOns\\WR\\Color\\WOW-Robot.tga")
        _G["checkbox"] = _G["CreateFrame"]("CheckButton", "WR_TestCheckbox", b_, "UICheckButtonTemplate")
        _G["checkbox"]["SetPoint"](_G["checkbox"], "LEFT", c0, "RIGHT", 10, 0)
        _G["checkbox"]["SetChecked"](_G["checkbox"], false)
        _G["checkbox"]["SetScript"](_G["checkbox"], "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "如果卡技能，请勾选此选项，\n可以查出卡在什么技能或功能上了。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        local c2 = b_["CreateFontString"](b_, nil, "ARTWORK", "GameFontNormal")
        c2["SetText"](c2, "调试模式")
        c2["SetPoint"](c2, "LEFT", _G["checkbox"], "RIGHT", 0, 0)
        local c3 = b_["CreateFontString"](b_, nil, "ARTWORK", "GameFontNormal")
        c3["SetText"](c3, "当前专精")
        c3["SetPoint"](c3, "TOPLEFT", c0, "BOTTOMLEFT", 0, bZ)
        local c4 = _G["CreateFrame"]("Frame", nil, b_)
        c4["SetSize"](c4, 90, 20)
        c4["SetPoint"](c4, "LEFT", c3, "RIGHT", 0, 0)
        _G["TianFu_Text"] = c4["CreateFontString"](c4, nil, "ARTWORK", "GameFontNormal")
        _G["TianFu_Text"]["SetText"](_G["TianFu_Text"], "戒律")
        _G["TianFu_Text"]["SetAllPoints"](_G["TianFu_Text"], c4)
        c4["SetScript"](c4, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "目前仅有|cffffffff戒律|r。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c4["SetScript"](c4, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        _G["JL_Frame"] = _G["CreateFrame"]("Frame", "JL_Frame", b_)
        _G["JL_Frame"]["SetSize"](_G["JL_Frame"], 1, 1)
        _G["JL_Frame"]["SetPoint"](_G["JL_Frame"], "CENTER", 0, 0)
        _G["JL_ZYSR_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_ZYSR_Text"]["SetText"](_G["JL_ZYSR_Text"], "真言术韧")
        _G["JL_ZYSR_Text"]["SetPoint"](_G["JL_ZYSR_Text"], "TOPRIGHT", c3, "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_ZYSR_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_ZYSR_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0普通",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffffdf00祷言",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cff00adf0普通：真言术：韧。\n|cffffdf00祷言：坚韧祷言。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_ZYSR"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bW)
                _G["xm"] = "小满"
                _G["xiao1man"](bW)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_ZYSR"])
        end
        _G["JL_SSZL_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_SSZL_Text"]["SetText"](_G["JL_SSZL_Text"], "神圣之灵")
        _G["JL_SSZL_Text"]["SetPoint"](_G["JL_SSZL_Text"], "TOPRIGHT", _G["JL_ZYSR_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_SSZL_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_SSZL_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0普通",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffffdf00祷言",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cff00adf0普通：神圣之灵。\n|cffffdf00祷言：精神祷言。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_SSZL"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_SSZL"])
        end
        _G["JL_AYFH_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_AYFH_Text"]["SetText"](_G["JL_AYFH_Text"], "暗影防护")
        _G["JL_AYFH_Text"]["SetPoint"](_G["JL_AYFH_Text"], "TOPRIGHT", _G["JL_SSZL_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_AYFH_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_AYFH_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0普通",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffffdf00祷言",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cff00adf0普通：暗影防护。\n|cffffdf00祷言：暗影防护祷言。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_AYFH"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_AYFH"])
        end
        _G["JL_QS_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_QS_Text"]["SetText"](_G["JL_QS_Text"], "驱散")
        _G["JL_QS_Text"]["SetPoint"](_G["JL_QS_Text"], "TOPRIGHT", _G["JL_AYFH_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_QS_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_QS_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0正常",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffffdf00优先",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cff00adf0正常：驱散Debuff。|r\n|cffffdf00优先：优先驱散危险的Debuff。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_QS"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_QS"])
        end
        _G["JL_ZLDY_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_ZLDY_Text"]["SetText"](_G["JL_ZLDY_Text"], "治疗祷言")
        _G["JL_ZLDY_Text"]["SetPoint"](_G["JL_ZLDY_Text"], "TOPRIGHT", _G["JL_QS_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_ZLDY_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_ZLDY_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "条件合适时，使用|cff00adf0治疗祷言|r为各队伍进行治疗。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_ZLDY"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bW)
                _G["xm"] = "小满"
                _G["xiao1man"](bW)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_ZLDY"])
        end
        _G["JL_SSXX_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_SSXX_Text"]["SetText"](_G["JL_SSXX_Text"], "神圣新星")
        _G["JL_SSXX_Text"]["SetPoint"](_G["JL_SSXX_Text"], "TOPRIGHT", _G["JL_ZLDY_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_SSXX_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_SSXX_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "条件合适时，使用|cff00adf0神圣新星|r进行治疗。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_SSXX"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_SSXX"])
        end
        _G["JL_YHDY_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_YHDY_Text"]["SetText"](_G["JL_YHDY_Text"], "愈合祷言")
        _G["JL_YHDY_Text"]["SetPoint"](_G["JL_YHDY_Text"], "TOPRIGHT", _G["JL_SSXX_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_YHDY_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_YHDY_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "条件合适时，使用|cff00adf0愈合祷言|r为本队进行治疗。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_YHDY"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_YHDY"])
        end
        _G["JL_HF_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_HF_Text"]["SetText"](_G["JL_HF_Text"], "恢复")
        _G["JL_HF_Text"]["SetPoint"](_G["JL_HF_Text"], "TOPRIGHT", _G["JL_YHDY_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_HF_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_HF_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "条件合适时，使用|cff00adf0恢复|r进行治疗。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_HF"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_HF"])
        end
        _G["JL_ZYSD_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_ZYSD_Text"]["SetText"](_G["JL_ZYSD_Text"], "真言术盾")
        _G["JL_ZYSD_Text"]["SetPoint"](_G["JL_ZYSD_Text"], "TOPRIGHT", _G["JL_HF_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_ZYSD_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_ZYSD_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0默认",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cff00adf0积极",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "默认：自动给坦克以及血量较低的队友使用|cff00adf0真言术盾|r。\n积极：更积极的给队友使用|cff00adf0真言术盾|r。\n|cffff5040禁用：完全不使用|cff00adf0真言术盾|r|r。(此选项不影响模式2的全团套盾)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_ZYSD"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_ZYSD"])
        end
        _G["JL_TKYZ_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_TKYZ_Text"]["SetText"](_G["JL_TKYZ_Text"], "痛苦压制")
        _G["JL_TKYZ_Text"]["SetPoint"](_G["JL_TKYZ_Text"], "TOPRIGHT", _G["JL_ZYSD_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_TKYZ_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_TKYZ_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 5)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 6)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 7)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 8)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 9)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 10)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 11)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffffff白色：对所有队友使用。\n|cff00adf0蓝色：仅对坦克使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_TKYZ"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bW)
                _G["xm"] = "小满"
                _G["xiao1man"](bW)
            end;
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_TKYZ"])
        end
        _G["JL_JWDY_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_JWDY_Text"]["SetText"](_G["JL_JWDY_Text"], "绝望祷言")
        _G["JL_JWDY_Text"]["SetPoint"](_G["JL_JWDY_Text"], "TOPRIGHT", _G["JL_TKYZ_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_JWDY_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_JWDY_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "当玩家血量低于设定值，自动使用|cff00adf0绝望祷言|r。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_JWDY"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_JWDY"])
        end
        _G["JL_TKXZ_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_TKXZ_Text"]["SetText"](_G["JL_TKXZ_Text"], "坦克选择")
        _G["JL_TKXZ_Text"]["SetPoint"](_G["JL_TKXZ_Text"], "TOPRIGHT", _G["JL_JWDY_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_TKXZ_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_TKXZ_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        _G["JL_TKXZ_selectedItems"] = {}
        _G["JL_TKXZ_menuItems"] = {{
            ["text"] = "        ",
            ["id"] = 1
        }, {
            ["text"] = "        ",
            ["id"] = 2
        }, {
            ["text"] = "        ",
            ["id"] = 3
        }, {
            ["text"] = "        ",
            ["id"] = 4
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](_G["JL_TKXZ_menuItems"]) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = function(c1)
                    _G["JL_TKXZ_selectedItems"][c8["id"]] = not _G["JL_TKXZ_selectedItems"][c8["id"]]
                    if _G["JL_TKXZ_selectedItems"][c8["id"]] then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        c1["checked"] = true
                    else
                        _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                        if _G["cu3vft61qi8zvg0lfe"][1] == true then
                            _G["xiaoman"] = "luatool.cn"
                        end
                        c1["checked"] = false
                    end
                    _G["UIDropDownMenu_Refresh"](c5)
                end;
                c9["checked"] = _G["JL_TKXZ_selectedItems"][c8["id"]] or false
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "选择坦克后(可多选)，自动全程维持坦克身上的|cff00adf0盾|r和|cff00adf0恢复|r。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        for ca = 1, 4 do
            if _G["WRSet"]["JL_TKXZ"] ~= nil and _G["WRSet"]["JL_TKXZ"][ca] ~= nil then
                _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                if _G["cu3vft61qi8zvg0lfe"][1] == true then
                    _G["xiaoman"] = "luatool.cn"
                end
                _G["JL_TKXZ_selectedItems"][ca] = _G["WRSet"]["JL_TKXZ"][ca]
            end
        end
        _G["JL_TDSX_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_TDSX_Text"]["SetText"](_G["JL_TDSX_Text"], "团盾顺序")
        _G["JL_TDSX_Text"]["SetPoint"](_G["JL_TDSX_Text"], "TOPRIGHT", _G["JL_TKXZ_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_TDSX_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_TDSX_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0正序",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cff00adf0倒序",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "按下模式2(爆发)后，对全团上|cff00adf0真言术：盾|r的顺序。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_TDSX"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_TDSX"])
        end
        _G["JL_NLGZ_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_NLGZ_Text"]["SetText"](_G["JL_NLGZ_Text"], "能量灌注")
        _G["JL_NLGZ_Text"]["SetPoint"](_G["JL_NLGZ_Text"], "TOPRIGHT", _G["JL_TDSX_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_NLGZ_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_NLGZ_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "按下模式2(爆发)后，自动对自己使用|cff00adf0能量灌注|r。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_NLGZ"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_NLGZ"])
        end
        _G["JL_FHS_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_FHS_Text"]["SetText"](_G["JL_FHS_Text"], "复活术")
        _G["JL_FHS_Text"]["SetPoint"](_G["JL_FHS_Text"], "TOPRIGHT", _G["JL_NLGZ_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_FHS_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_FHS_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "脱离战斗后，对死亡的队友使用复活术。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_FHS"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_FHS"])
        end
        _G["JL_AYM_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_AYM_Text"]["SetText"](_G["JL_AYM_Text"], "暗影魔")
        _G["JL_AYM_Text"]["SetPoint"](_G["JL_AYM_Text"], "TOPRIGHT", _G["JL_FHS_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_AYM_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_AYM_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00ADF010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cff249FD620%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cff4892BD30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }, {
            ["text"] = "|cff6D85A440%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 4)
            end
        }, {
            ["text"] = "|cff91778B50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 5)
            end
        }, {
            ["text"] = "|cffB66A7260%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 6)
            end
        }, {
            ["text"] = "|cffDA5D5970%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 7)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 8)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "当蓝量低于设定值自动释放|cff00adf0暗影魔|r。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_AYM"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_AYM"])
        end
        _G["JL_ZLMS_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_ZLMS_Text"]["SetText"](_G["JL_ZLMS_Text"], "治疗模式")
        _G["JL_ZLMS_Text"]["SetPoint"](_G["JL_ZLMS_Text"], "TOPRIGHT", _G["JL_AYM_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_ZLMS_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_ZLMS_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cff00adf0自动",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cff996b1f坦克",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }, {
            ["text"] = "|cff9C3590脆皮",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cff00adf0自动：治疗所有单位(可应对大部分情况)。|r\n|cff996b1f坦克：仅治疗坦克，需要团长设置\"坦克\"职责。|r\n|cff9C3590脆皮：排除坦克，治疗其他职业，需要团长设置\"坦克\"职责。|r")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_ZLMS"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_ZLMS"])
        end
        _G["JL_CGZH_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_CGZH_Text"]["SetText"](_G["JL_CGZH_Text"], "|cff00adf0刺骨之寒")
        _G["JL_CGZH_Text"]["SetPoint"](_G["JL_CGZH_Text"], "TOPRIGHT", _G["JL_ZLMS_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_CGZH_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_CGZH_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        _G["JL_CGZH_selectedItems"] = {}
        _G["JL_CGZH_menuItems"] = {{
            ["text"] = "1",
            ["id"] = 1
        }, {
            ["text"] = "2",
            ["id"] = 2
        }, {
            ["text"] = "3",
            ["id"] = 3
        }, {
            ["text"] = "4",
            ["id"] = 4
        }, {
            ["text"] = "5",
            ["id"] = 5
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](_G["JL_CGZH_menuItems"]) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = function(c1)
                    _G["JL_CGZH_selectedItems"][c8["id"]] = not _G["JL_CGZH_selectedItems"][c8["id"]]
                    if _G["JL_CGZH_selectedItems"][c8["id"]] then
                        if _G["ah0dy1wiqxzo3qjet"] == "" then
                            _G["ubpo"] = "xiaoman"
                        end
                        c1["checked"] = true
                    else
                        _G["q14yufbc7wqlzm0r"] = ""
                        _G["qz4yufb791qlzmg0i"] = nil
                        c1["checked"] = false
                    end
                    _G["UIDropDownMenu_Refresh"](c5)
                end;
                c9["checked"] = _G["JL_CGZH_selectedItems"][c8["id"]] or false
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffff5040注意：此选项仅作用于|cff00adf0十字军试炼-阿努巴拉克|r的战斗中|r。\n选择编号后，优先治疗中了|cff00adf0刺骨之寒|r且|cff00adf0对应编号|r的玩家。\n这个编号是按团队前后顺序编制的，某些WA可以将此编号显示在团队框架内。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        for ca = 1, 5 do
            if _G["WRSet"]["JL_CGZH"] ~= nil and _G["WRSet"]["JL_CGZH"][ca] ~= nil then
                while "" == true do
                    _G["xiao0man"] = "enc"
                end
                _G["JL_CGZH_selectedItems"][ca] = _G["WRSet"]["JL_CGZH"][ca]
            end
        end
        _G["JL_ZDGS_Text"] = _G["JL_Frame"]["CreateFontString"](_G["JL_Frame"], nil, "ARTWORK", "GameFontNormal")
        _G["JL_ZDGS_Text"]["SetText"](_G["JL_ZDGS_Text"], "|cffff5040自动跟随")
        _G["JL_ZDGS_Text"]["SetPoint"](_G["JL_ZDGS_Text"], "TOPRIGHT", _G["JL_CGZH_Text"], "BOTTOMRIGHT", 0, bZ)
        local c5 = _G["CreateFrame"]("Frame", "JL_ZDGS_Dropdown", _G["JL_Frame"], "UIDropDownMenuTemplate")
        c5["SetPoint"](c5, "LEFT", _G["JL_ZDGS_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](c5, 70)
        local c6 = {{
            ["text"] = "|cffffdf00坦克",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](c5, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](c5, function()
            for c7, c8 in _G["ipairs"](c6) do
                local c9 = _G["UIDropDownMenu_CreateInfo"]()
                c9["text"] = c8["text"]
                c9["func"] = c8["func"]
                _G["UIDropDownMenu_AddButton"](c9)
            end
        end)
        c5["SetScript"](c5, "OnEnter", function(c1)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], c1, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffff5040请谨慎使用此功能。\n不要长时间使用此功能。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        c5["SetScript"](c5, "OnLeave", function(c1)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["JL_ZDGS"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](c5, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](c5, _G["WRSet"]["JL_ZDGS"])
        end
        _G["ToggleConfigFrame"] = function()
            if b_["IsShown"](b_) then
                _G["qxw3iagfxbqp1ilz"] = function(bW)
                    _G["xm"] = "小满"
                    _G["xiao1man"](bW)
                end;
                b_["Hide"](b_)
            else
                _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                if _G["cu3vft61qi8zvg0lfe"][1] == true then
                    _G["xiaoman"] = "luatool.cn"
                end
                b_["Show"](b_)
            end
        end;
        _G["SLASH_WOW_ROBOT1"] = "/wr"
        _G["SlashCmdList"]["WOW_ROBOT"] = _G["ToggleConfigFrame"]
        local cb = _G["CreateFrame"]("Button", "WR_ClickFrame", _G["UIParent"], "UIPanelButtonTemplate")
        cb["SetSize"](cb, 25, 25)
        cb["SetPoint"](cb, "BOTTOMLEFT", 0, 0)
        cb["SetFrameStrata"](cb, "FULLSCREEN")
        cb["SetMovable"](cb, true)
        cb["EnableMouse"](cb, true)
        cb["RegisterForDrag"](cb, "LeftButton")
        cb["SetScript"](cb, "OnDragStart", cb["StartMoving"])
        cb["SetScript"](cb, "OnDragStop", cb["StopMovingOrSizing"])
        local cc = cb["CreateTexture"](cb, nil, "OVERLAY")
        cc["SetAllPoints"](cc, cb)
        cc["SetTexture"](cc, "Interface\\AddOns\\WR\\Color\\WOW-Robot.tga")
        cb["SetScript"](cb, "OnClick", function(c1, cd, ce)
            if b_["IsShown"](b_) then
                _G["ud7lqateqbhc0zhfok"] = nil
                _G["pd7lqyteqbhcozhl"] = false
                b_["Hide"](b_)
            else
                _G["qxw3iagfxbqp1ilz"] = function(bW)
                    _G["xm"] = "小满"
                    _G["xiao1man"](bW)
                end;
                b_["Show"](b_)
            end
        end)
        cb["Show"](cb)
        local cb = _G["CreateFrame"]("Frame", "WR_CombatFrame")
        cb["SetSize"](cb, 8, 8)
        cb["SetPoint"](cb, "BOTTOMRIGHT", 0, 0)
        cb["SetFrameStrata"](cb, "FULLSCREEN")
        local cc = cb["CreateTexture"](cb, nil, "OVERLAY")
        cc["SetAllPoints"](cc, cb)
        cc["SetTexture"](cc, "Interface\\AddOns\\WR\\Color\\Combat.tga")
        cb["Hide"](cb)
    end
end)()
