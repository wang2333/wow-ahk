local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 39;
    local c = 34;
    local d = 20;
    local e = 94;
    local f = 98;
    local g = 41;
    local h = 66;
    local i = 84;
    local j = 57;
    local k = 89;
    local l = 35;
    local m = 47;
    local n = 81;
    local o = 24;
    local p = "g"
    local q = "m"
    local r = "n"
    local s = "a"
    local t = "b"
    local u = "p"
    local v = "r"
    local w = "s"
    local x = "t"
    local y = "c"
    local z = "o"
    local A = "u"
    local B = "h"
    local C = "d"
    local D = "e"
    local E = "i"
    local F = "k"
    local G = "l"
    local H = "y"
    local I = "w"
    local J = a[8][x .. s .. t .. G .. D][y .. z .. r .. y .. s .. x]
    local K = a[8][q .. s .. x .. B][G .. C .. D .. a[2] .. u] or a[8][q .. s .. x .. B][w .. y .. s .. G .. D]
    local L = w .. x .. v .. E .. r .. p;
    local M = a[8][w .. D .. x .. q .. D .. x .. s .. x .. s .. t .. G .. D]
    local N = a[8][L][w .. A .. t]
    local O = a[8][L][y .. B .. s .. v]
    local P = a[8][w .. D .. G .. D .. y .. x]
    local Q = a[8][L][t .. H .. x .. D]
    local R = function()
        return a[8]
    end;
    local S = a[8][x .. s .. t .. G .. D][A .. r .. u .. s .. y .. F] or a[8][A .. r .. u .. s .. y .. F]
    local T = a[8][L][p .. w .. A .. t]
    local U = a[8][x .. z .. r .. A .. q .. t .. D .. v]
    local function V(W)
        local X, Y, Z = "", "", {}
        local _ = 256;
        local a0 = {}
        if W == v then
            return Y
        end
        for a1 = 0, _ - 1 do
            a0[a1] = O(a1)
        end
        local a2 = 1;
        local function a3()
            local a4 = U(N(W, a2, a2), 36)
            a2 = a2 + 1;
            local a5 = U(N(W, a2, a2 + a4 - 1), 36)
            a2 = a2 + a4;
            return a5
        end
        X = O(a3())
        Z[1] = X;
        while a2 < #W do
            local a6 = a3()
            if a0[a6] then
                Y = a0[a6]
            else
                Y = X .. N(X, 1, 1)
            end
            a0[_] = X .. N(Y, 1, 1)
            Z[#Z + 1], X, _ = Y, Y, _ + 1
        end
        return J(Z)
    end
    local l = a[10]
    local a7 = a[8][t .. E .. x] and a[8][t .. E .. x][t .. a[2] .. z .. v] or function(a8, W)
        local a9, X = 1, 0;
        while a8 > 0 and W > 0 do
            local aa, ab = a8 % 2, W % 2;
            if aa ~= ab then
                X = X + a9
            end
            a8, W, a9 = (a8 - aa) / 2, (W - ab) / 2, a9 * 2
        end
        if a8 < W then
            a8 = W
        end
        while a8 > 0 do
            local aa = a8 % 2;
            if aa > 0 then
                X = X + a9
            end
            a8, a9 = (a8 - aa) / 2, a9 * 2
        end
        return X
    end;
    local ac = l .. a[15]
    local ad = R()
    local ae = l .. a[5]
    local function af(ag, ah, ai)
        if ai then
            local aj = ag / 2 ^ (ah - 1) % 2 ^ (ai - 1 - (ah - 1) + 1)
            return aj - aj % 1
        else
            local ak = 2 ^ (ah - 1)
            return ag % (ak + ak) >= ak and 1 or 0
        end
    end
    local al = l .. a[9]
    local am = 1;
    local an = l .. a[14]
    local ao = V(v)
    local ap = l .. a[1]
    local function aq()
        local ar, as, at, au = Q(ao, am, am + 3)
        ar = a7(ar, 156)
        as = a7(as, 156)
        at = a7(at, 156)
        au = a7(au, 156)
        am = am + 4;
        return au * 16777216 + at * 65536 + as * 256 + ar
    end
    local av = l .. a[19]
    local aw = V(r .. a[4] .. x)
    local function ax()
        local ay = a7(Q(ao, am, am), 156)
        am = am + 1;
        return ay
    end
    local az = a[8][a[10]]
    local aA = l .. a[7]
    local function aB()
        local aC = aq()
        local aD = aq()
        local aE = 1;
        local aF = af(aD, 1, 20) * 2 ^ 32 + aC;
        local aG = af(aD, 21, 31)
        local aH = (-1) ^ af(aD, 32)
        if aG == 0 then
            if aF == 0 then
                return aH * 0
            else
                aG = 1;
                aE = 0
            end
        elseif aG == 2047 then
            return aF == 0 and aH * 1 / 0 or aH * 0 / 0
        end
        return K(aH, aG - 1023) * (aE + aF / 2 ^ 52)
    end
    local aI = a[12]
    local aJ = aw == a[17]
    local aK = l .. a[11]
    local aL = aq;
    local function aM(aN)
        local aO;
        if not aN then
            aN = aL()
            if aN == 0 then
                return ""
            end
        end
        aO = N(ao, am, am + aN - 1)
        am = am + aN;
        local aP = {}
        for aQ = 1, #aO do
            aP[aQ] = O(a7(Q(N(aO, aQ, aQ)), 156))
        end
        return J(aP)
    end
    local aR = l .. a[4]
    local aS = aq;
    local aT = aw == D;
    local aU = a[3]
    local function aV(...)
        return {...}, P("#", ...)
    end
    local function aW(aX, aY, aZ)
        local function a_(a1, b0)
            local b1 = ao;
            for a2 = 1, #b0 do
                local X = Q(b0, a2, a2) - (a1 + a2) % 256;
                if X < 0 then
                    X = X + 256
                end
                b1 = b1 .. O(X)
            end
            return b1
        end
        local function b2(b3)
            return T(b3, '..', function(b4)
                return O(U(b4, 16) % 256)
            end)
        end
        ad[an] = function(b5)
            return aB() .. b5
        end;
        ad[al] = function(b6, b7)
            return U(a_(b6, b2(b7)))
        end;
        ad[aR] = function()
            return az
        end;
        ad[ac] = function()
            return ao
        end;
        ad[aK] = function(b8, b9)
            return a_(b8, b2(b9))
        end;
        ad[ap] = function()
            return aT
        end;
        ad[ae] = function()
            return aY
        end;
        ad[aA] = function(a3)
            local a1 = 0;
            for a2 = 1, #a3 do
                a1 = a1 + Q(a3, a2, a2)
            end
            return a1
        end;
        ad[av] = function()
            return aJ
        end;
        return b2(aX .. aZ)
    end
    local function ba()
        local bb = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0}
        local bc = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local bd = {}
        local be = {bb, nil, bc, nil, bd}
        if G ~= r then
            return bc
        end
        be[4] = ax()
        for aQ = 1, aq() do
            local bf = a7(aq(), 182)
            local bg = a7(aq(), 119)
            local bh = af(bf, 1, 2)
            local bi = af(bg, 1, 11)
            local bj = {bi, af(bf, 3, 11), nil, nil, bg}
            if bh == 0 then
                bj[3] = af(bf, 12, 20)
                bj[5] = af(bf, 21, 29)
            elseif bh == 1 then
                bj[3] = af(bg, 12, 33)
            elseif bh == 2 then
                bj[3] = af(bg, 12, 32) - 1048575
            elseif bh == 3 then
                bj[3] = af(bg, 12, 32) - 1048575;
                bj[5] = af(bf, 21, 29)
            end
            bb[aQ] = bj
        end
        local bk = aq()
        local bl = {0, 0, 0, 0, 0, 0, 0}
        for aQ = 1, bk do
            local bh = ax()
            local bm;
            if bh == 1 then
                bm = ax() ~= 0
            elseif bh == 2 then
                bm = aB()
            elseif bh == 0 then
                bm = aM()
            end
            bl[aQ] = bm
        end
        be[2] = bl;
        for aQ = 1, aq() do
            bc[aQ - 1] = ba()
        end
        return be
    end
    local function bn(be, bo, bp)
        local bq = be[1]
        local br = be[2]
        local bs = be[3]
        local bt = be[4]
        return function(...)
            local bq = bq;
            local br = br;
            local bs = bs;
            local bt = bt;
            local bu = aW(aU, ad, aI)
            local aV = aV;
            local bv = 1;
            local bw = -1;
            if aw ~= F then
                return bv
            end
            local bx = {}
            local by = {...}
            local bz = {}
            local bA = P("#", ...) - 1;
            for aQ = 0, bA do
                if aQ >= bt then
                    bx[aQ - bt] = by[aQ + 1]
                else
                    bz[aQ] = by[aQ + 1]
                end
            end
            local bB = bA - bt + 1;
            local bj;
            local bC;
            while true do
                bj = bq[bv]
                bC = bj[1]
                if bC <= 34 then
                    if bC <= 16 then
                        if bC <= 7 then
                            if bC <= 3 then
                                if bC <= 1 then
                                    if bC == 0 then
                                        bz[bj[2]] = bz[bj[3]] + br[bj[5]]
                                    else
                                        local bD = bj[2]
                                        local by = {}
                                        local bE = 0;
                                        local bF = bD + bj[3] - 1;
                                        for aQ = bD + 1, bF do
                                            bE = bE + 1;
                                            by[bE] = bz[aQ]
                                        end
                                        local bG = {bz[bD](S(by, 1, bF - bD))}
                                        local bF = bD + bj[5] - 2;
                                        bE = 0;
                                        for aQ = bD, bF do
                                            bE = bE + 1;
                                            bz[aQ] = bG[bE]
                                        end
                                        bw = bF
                                    end
                                elseif bC == 2 then
                                    local bH = bs[bj[3]]
                                    local bI;
                                    local bJ = {}
                                    bI = M({}, {
                                        [a[16] .. a[16] .. E .. r .. C .. D .. a[2]] = function(bK, bL)
                                            local bM = bJ[bL]
                                            return bM[1][bM[2]]
                                        end,
                                        [a[16] .. a[16] .. r .. D .. I .. E .. r .. C .. D .. a[2]] = function(bK, bL,
                                            bN)
                                            local bM = bJ[bL]
                                            bM[1][bM[2]] = bN
                                        end
                                    })
                                    for aQ = 1, bj[5] do
                                        bv = bv + 1;
                                        local bO = bq[bv]
                                        if bO[1] == 7 then
                                            bJ[aQ - 1] = {bz, bO[3]}
                                        else
                                            bJ[aQ - 1] = {bo, bO[3]}
                                        end
                                        bu[#bu + 1] = bJ
                                    end
                                    bz[bj[2]] = bn(bH, bI, bp)
                                else
                                    local bD = bj[2]
                                    local bP = bz[bj[3]]
                                    bz[bD + 1] = bP;
                                    bz[bD] = bP[br[bj[5]]]
                                end
                            elseif bC <= 5 then
                                if bC > 4 then
                                    local bD;
                                    bz[bj[2]] = br[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = #bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = br[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = #bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = br[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    bz[bD] = bz[bD] - bz[bD + 2]
                                    bv = bv + bj[3]
                                else
                                    local bQ;
                                    local bG, bF;
                                    local bF;
                                    local bE;
                                    local by;
                                    local bD;
                                    bz[bj[2]] = bp[br[bj[3]]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bo[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bo[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    by = {}
                                    bE = 0;
                                    bF = bD + bj[3] - 1;
                                    for aQ = bD + 1, bF do
                                        bE = bE + 1;
                                        by[bE] = bz[aQ]
                                    end
                                    bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                                    bF = bF + bD - 1;
                                    bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bz[aQ] = bG[bE]
                                    end
                                    bw = bF;
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    by = {}
                                    bE = 0;
                                    bF = bw;
                                    for aQ = bD + 1, bF do
                                        bE = bE + 1;
                                        by[bE] = bz[aQ]
                                    end
                                    bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                                    bF = bF + bD - 1;
                                    bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bz[aQ] = bG[bE]
                                    end
                                    bw = bF;
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    by = {}
                                    bF = bw;
                                    for aQ = bD + 1, bF do
                                        by[#by + 1] = bz[aQ]
                                    end
                                    do
                                        return bz[bD](S(by, 1, bF - bD))
                                    end
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    bF = bw;
                                    bQ = {}
                                    bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bQ[bE] = bz[aQ]
                                    end
                                    do
                                        return S(bQ, 1, bE)
                                    end
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    do
                                        return
                                    end
                                end
                            elseif bC > 6 then
                                bz[bj[2]] = bz[bj[3]]
                            else
                                bv = bv + bj[3]
                            end
                        elseif bC <= 11 then
                            if bC <= 9 then
                                if bC == 8 then
                                    bz[bj[2]] = bp[br[bj[3]]]
                                else
                                    local bP;
                                    local bG;
                                    local bF;
                                    local bE;
                                    local by;
                                    local bD;
                                    bz[bj[2]] = bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    by = {}
                                    bE = 0;
                                    bF = bD + bj[3] - 1;
                                    for aQ = bD + 1, bF do
                                        bE = bE + 1;
                                        by[bE] = bz[aQ]
                                    end
                                    bG = {bz[bD](S(by, 1, bF - bD))}
                                    bF = bD + bj[5] - 2;
                                    bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bz[aQ] = bG[bE]
                                    end
                                    bw = bF;
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]] + bz[bj[5]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]] % br[bj[5]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    bP = bz[bj[3]]
                                    bz[bD + 1] = bP;
                                    bz[bD] = bP[br[bj[5]]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bz[bj[2]] = bz[bj[3]]
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    bD = bj[2]
                                    by = {}
                                    bE = 0;
                                    bF = bD + bj[3] - 1;
                                    for aQ = bD + 1, bF do
                                        bE = bE + 1;
                                        by[bE] = bz[aQ]
                                    end
                                    bG = {bz[bD](S(by, 1, bF - bD))}
                                    bF = bD + bj[5] - 2;
                                    bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bz[aQ] = bG[bE]
                                    end
                                    bw = bF;
                                    bv = bv + 1;
                                    bj = bq[bv]
                                    if bz[bj[2]] > bz[bj[5]] then
                                        bv = bv + 1
                                    else
                                        bv = bv + bj[3]
                                    end
                                end
                            elseif bC > 10 then
                                local bP = bz[bj[3]]
                                if not bP then
                                    bv = bv + 1
                                else
                                    bz[bj[2]] = bP;
                                    bv = bv + bq[bv + 1][3] + 1
                                end
                            else
                                local bQ;
                                local bG, bF;
                                local bF;
                                local bE;
                                local by;
                                local bD;
                                bz[bj[2]] = bo[bj[3]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bz[bj[2]] = bz[bj[3]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bz[bj[2]] = bo[bj[3]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bz[bj[2]] = bz[bj[3]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bD = bj[2]
                                by = {}
                                bE = 0;
                                bF = bD + bj[3] - 1;
                                for aQ = bD + 1, bF do
                                    bE = bE + 1;
                                    by[bE] = bz[aQ]
                                end
                                bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                                bF = bF + bD - 1;
                                bE = 0;
                                for aQ = bD, bF do
                                    bE = bE + 1;
                                    bz[aQ] = bG[bE]
                                end
                                bw = bF;
                                bv = bv + 1;
                                bj = bq[bv]
                                bD = bj[2]
                                by = {}
                                bF = bw;
                                for aQ = bD + 1, bF do
                                    by[#by + 1] = bz[aQ]
                                end
                                do
                                    return bz[bD](S(by, 1, bF - bD))
                                end
                                bv = bv + 1;
                                bj = bq[bv]
                                bD = bj[2]
                                bF = bw;
                                bQ = {}
                                bE = 0;
                                for aQ = bD, bF do
                                    bE = bE + 1;
                                    bQ[bE] = bz[aQ]
                                end
                                do
                                    return S(bQ, 1, bE)
                                end
                                bv = bv + 1;
                                bj = bq[bv]
                                do
                                    return
                                end
                            end
                        elseif bC <= 13 then
                            if bC == 12 then
                                bz[bj[2]] = bj[3] ~= 0
                            else
                                local bD = bj[2]
                                local by = {}
                                local bF = bw;
                                for aQ = bD + 1, bF do
                                    by[#by + 1] = bz[aQ]
                                end
                                do
                                    return bz[bD](S(by, 1, bF - bD))
                                end
                            end
                        elseif bC <= 14 then
                            local bD = bj[2]
                            local by = {}
                            local bE = 0;
                            local bF = bD + bj[3] - 1;
                            for aQ = bD + 1, bF do
                                bE = bE + 1;
                                by[bE] = bz[aQ]
                            end
                            local bG = {bz[bD](S(by, 1, bF - bD))}
                            local bF = bD + bj[5] - 2;
                            bE = 0;
                            for aQ = bD, bF do
                                bE = bE + 1;
                                bz[aQ] = bG[bE]
                            end
                            bw = bF
                        elseif bC == 15 then
                            bz[bj[2]] = bz[bj[3]] % bz[bj[5]]
                        else
                            local bD = bj[2]
                            local by = {}
                            local bE = 0;
                            local bF = bD + bj[3] - 1;
                            for aQ = bD + 1, bF do
                                bE = bE + 1;
                                by[bE] = bz[aQ]
                            end
                            local bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                            bF = bF + bD - 1;
                            bE = 0;
                            for aQ = bD, bF do
                                bE = bE + 1;
                                bz[aQ] = bG[bE]
                            end
                            bw = bF
                        end
                    elseif bC <= 25 then
                        if bC <= 20 then
                            if bC <= 18 then
                                if bC > 17 then
                                    local bD = bj[2]
                                    local by = {}
                                    local bF = bw;
                                    for aQ = bD + 1, bF do
                                        by[#by + 1] = bz[aQ]
                                    end
                                    do
                                        return bz[bD](S(by, 1, bF - bD))
                                    end
                                else
                                    bz[bj[2]] = bz[bj[3]] + br[bj[5]]
                                end
                            elseif bC == 19 then
                                local bR;
                                local bP;
                                local bG;
                                local bF;
                                local bE;
                                local by;
                                local bD;
                                bz[bj[2]] = bp[br[bj[3]]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bz[bj[2]] = bz[bj[3]][br[bj[5]]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bz[bj[2]] = bz[bj[3]]
                                bv = bv + 1;
                                bj = bq[bv]
                                bD = bj[2]
                                by = {}
                                bE = 0;
                                bF = bD + bj[3] - 1;
                                for aQ = bD + 1, bF do
                                    bE = bE + 1;
                                    by[bE] = bz[aQ]
                                end
                                bG = {bz[bD](S(by, 1, bF - bD))}
                                bF = bD + bj[5] - 2;
                                bE = 0;
                                for aQ = bD, bF do
                                    bE = bE + 1;
                                    bz[aQ] = bG[bE]
                                end
                                bw = bF;
                                bv = bv + 1;
                                bj = bq[bv]
                                bP = bj[3]
                                bR = bz[bP]
                                for aQ = bP + 1, bj[5] do
                                    bR = bR .. bz[aQ]
                                end
                                bz[bj[2]] = bR
                            else
                                bz[bj[2]] = bo[bj[3]]
                            end
                        elseif bC <= 22 then
                            if bC == 21 then
                                local bD = bj[2]
                                bz[bD] = bz[bD] - bz[bD + 2]
                                bv = bv + bj[3]
                            else
                                local bH = bs[bj[3]]
                                local bI;
                                local bJ = {}
                                bI = M({}, {
                                    [a[16] .. a[16] .. E .. r .. C .. D .. a[2]] = function(bK, bL)
                                        local bM = bJ[bL]
                                        return bM[1][bM[2]]
                                    end,
                                    [a[16] .. a[16] .. r .. D .. I .. E .. r .. C .. D .. a[2]] = function(bK, bL, bN)
                                        local bM = bJ[bL]
                                        bM[1][bM[2]] = bN
                                    end
                                })
                                for aQ = 1, bj[5] do
                                    bv = bv + 1;
                                    local bO = bq[bv]
                                    if bO[1] == 7 then
                                        bJ[aQ - 1] = {bz, bO[3]}
                                    else
                                        bJ[aQ - 1] = {bo, bO[3]}
                                    end
                                    bu[#bu + 1] = bJ
                                end
                                bz[bj[2]] = bn(bH, bI, bp)
                            end
                        elseif bC <= 23 then
                            bz[bj[2]] = bp[br[bj[3]]]
                        elseif bC == 24 then
                            bz[bj[2]] = bz[bj[3]] % bz[bj[5]]
                        else
                            bz[bj[2]] = bz[bj[3]][br[bj[5]]]
                        end
                    elseif bC <= 29 then
                        if bC <= 27 then
                            if bC == 26 then
                                local bP = bj[3]
                                local bR = bz[bP]
                                for aQ = bP + 1, bj[5] do
                                    bR = bR .. bz[aQ]
                                end
                                bz[bj[2]] = bR
                            else
                                bz[bj[2]] = bz[bj[3]] + bz[bj[5]]
                            end
                        elseif bC == 28 then
                            bz[bj[2]] = bn(bs[bj[3]], nil, bp)
                        else
                            local bD = bj[2]
                            local by = {}
                            local bF = bD + bj[3] - 1;
                            for aQ = bD + 1, bF do
                                by[#by + 1] = bz[aQ]
                            end
                            do
                                return bz[bD](S(by, 1, bF - bD))
                            end
                        end
                    elseif bC <= 31 then
                        if bC == 30 then
                            bz[bj[2]] = bz[bj[3]]
                        else
                            bz[bj[2]] = bz[bj[3]] % br[bj[5]]
                        end
                    elseif bC <= 32 then
                        local bD = bj[2]
                        bz[bD] = bz[bD] - bz[bD + 2]
                        bv = bv + bj[3]
                    elseif bC == 33 then
                        bz[bj[2]] = #bz[bj[3]]
                    else
                        if bz[bj[2]] == br[bj[5]] then
                            bv = bv + 1
                        else
                            bv = bv + bj[3]
                        end
                    end
                elseif bC <= 51 then
                    if bC <= 42 then
                        if bC <= 38 then
                            if bC <= 36 then
                                if bC > 35 then
                                    local bD = bj[2]
                                    local by = {}
                                    local bE = 0;
                                    local bF = bD + bj[3] - 1;
                                    for aQ = bD + 1, bF do
                                        bE = bE + 1;
                                        by[bE] = bz[aQ]
                                    end
                                    local bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                                    bF = bF + bD - 1;
                                    bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bz[aQ] = bG[bE]
                                    end
                                    bw = bF
                                else
                                    local bD = bj[2]
                                    local bF = bw;
                                    local bQ = {}
                                    local bE = 0;
                                    for aQ = bD, bF do
                                        bE = bE + 1;
                                        bQ[bE] = bz[aQ]
                                    end
                                    do
                                        return S(bQ, 1, bE)
                                    end
                                end
                            elseif bC == 37 then
                                bz[bj[2]] = bn(bs[bj[3]], nil, bp)
                            else
                                bz[bj[2]] = br[bj[3]]
                            end
                        elseif bC <= 40 then
                            if bC > 39 then
                                local bD = bj[2]
                                local by = {}
                                local bE = 0;
                                local bF = bw;
                                for aQ = bD + 1, bF do
                                    bE = bE + 1;
                                    by[bE] = bz[aQ]
                                end
                                local bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                                bF = bF + bD - 1;
                                bE = 0;
                                for aQ = bD, bF do
                                    bE = bE + 1;
                                    bz[aQ] = bG[bE]
                                end
                                bw = bF
                            else
                                bz[bj[2]] = bz[bj[3]] - bz[bj[5]]
                            end
                        elseif bC == 41 then
                            local bD = bj[2]
                            local bS = bz[bD + 2]
                            local bT = bz[bD] + bS;
                            bz[bD] = bT;
                            if bS > 0 then
                                if bT <= bz[bD + 1] then
                                    bv = bv + bj[3]
                                    bz[bD + 3] = bT
                                end
                            elseif bT >= bz[bD + 1] then
                                bv = bv + bj[3]
                                bz[bD + 3] = bT
                            end
                        else
                            if bz[bj[2]] == br[bj[5]] then
                                bv = bv + 1
                            else
                                bv = bv + bj[3]
                            end
                        end
                    elseif bC <= 46 then
                        if bC <= 44 then
                            if bC > 43 then
                                bz[bj[2]] = bj[3] ~= 0
                            else
                                local bD = bj[2]
                                local bF = bD + bj[3] - 2;
                                local bQ = {}
                                local bE = 0;
                                for aQ = bD, bF do
                                    bE = bE + 1;
                                    bQ[bE] = bz[aQ]
                                end
                                do
                                    return S(bQ, 1, bE)
                                end
                            end
                        elseif bC == 45 then
                            local bD = bj[2]
                            local bF = bD + bj[3] - 2;
                            local bQ = {}
                            local bE = 0;
                            for aQ = bD, bF do
                                bE = bE + 1;
                                bQ[bE] = bz[aQ]
                            end
                            do
                                return S(bQ, 1, bE)
                            end
                        else
                            bz[bj[2]] = bz[bj[3]] % br[bj[5]]
                        end
                    elseif bC <= 48 then
                        if bC == 47 then
                            local bD = bj[2]
                            local bP = bz[bj[3]]
                            bz[bD + 1] = bP;
                            bz[bD] = bP[br[bj[5]]]
                        else
                            local bD = bj[2]
                            local by = {}
                            local bF = bD + bj[3] - 1;
                            for aQ = bD + 1, bF do
                                by[#by + 1] = bz[aQ]
                            end
                            do
                                return bz[bD](S(by, 1, bF - bD))
                            end
                        end
                    elseif bC <= 49 then
                        bz[bj[2]] = bz[bj[3]] - bz[bj[5]]
                    elseif bC > 50 then
                        local bD = bj[2]
                        local by = {}
                        local bE = 0;
                        local bF = bw;
                        for aQ = bD + 1, bF do
                            bE = bE + 1;
                            by[bE] = bz[aQ]
                        end
                        local bG, bF = aV(bz[bD](S(by, 1, bF - bD)))
                        bF = bF + bD - 1;
                        bE = 0;
                        for aQ = bD, bF do
                            bE = bE + 1;
                            bz[aQ] = bG[bE]
                        end
                        bw = bF
                    else
                        local bD = bj[2]
                        local bF = bw;
                        local bQ = {}
                        local bE = 0;
                        for aQ = bD, bF do
                            bE = bE + 1;
                            bQ[bE] = bz[aQ]
                        end
                        do
                            return S(bQ, 1, bE)
                        end
                    end
                elseif bC <= 60 then
                    if bC <= 55 then
                        if bC <= 53 then
                            if bC == 52 then
                                bz[bj[2]] = #bz[bj[3]]
                            else
                                bp[br[bj[3]]] = bz[bj[2]]
                            end
                        elseif bC > 54 then
                            local bP = bj[3]
                            local bR = bz[bP]
                            for aQ = bP + 1, bj[5] do
                                bR = bR .. bz[aQ]
                            end
                            bz[bj[2]] = bR
                        else
                            do
                                return
                            end
                        end
                    elseif bC <= 57 then
                        if bC == 56 then
                            bz[bj[2]] = br[bj[3]]
                        else
                            bv = bv + bj[3]
                        end
                    elseif bC <= 58 then
                        bz[bj[2]] = bz[bj[3]] + bz[bj[5]]
                    elseif bC == 59 then
                        if bz[bj[2]] > bz[bj[5]] then
                            bv = bv + 1
                        else
                            bv = bv + bj[3]
                        end
                    else
                        bp[br[bj[3]]] = bz[bj[2]]
                    end
                elseif bC <= 64 then
                    if bC <= 62 then
                        if bC > 61 then
                            local bP = bz[bj[3]]
                            if not bP then
                                bv = bv + 1
                            else
                                bz[bj[2]] = bP;
                                bv = bv + bq[bv + 1][3] + 1
                            end
                        else
                            if not bz[bj[2]] then
                                bv = bv + 1
                            else
                                bv = bv + bj[3]
                            end
                        end
                    elseif bC > 63 then
                        local bQ;
                        local bG;
                        local bF;
                        local bE;
                        local by;
                        local bD;
                        bz[bj[2]] = bp[br[bj[3]]]
                        bv = bv + 1;
                        bj = bq[bv]
                        bz[bj[2]] = bz[bj[3]][br[bj[5]]]
                        bv = bv + 1;
                        bj = bq[bv]
                        bz[bj[2]] = bp[br[bj[3]]]
                        bv = bv + 1;
                        bj = bq[bv]
                        bz[bj[2]] = bz[bj[3]]
                        bv = bv + 1;
                        bj = bq[bv]
                        bz[bj[2]] = br[bj[3]]
                        bv = bv + 1;
                        bj = bq[bv]
                        bD = bj[2]
                        by = {}
                        bE = 0;
                        bF = bD + bj[3] - 1;
                        for aQ = bD + 1, bF do
                            bE = bE + 1;
                            by[bE] = bz[aQ]
                        end
                        bG = {bz[bD](S(by, 1, bF - bD))}
                        bF = bD + bj[5] - 2;
                        bE = 0;
                        for aQ = bD, bF do
                            bE = bE + 1;
                            bz[aQ] = bG[bE]
                        end
                        bw = bF;
                        bv = bv + 1;
                        bj = bq[bv]
                        bz[bj[2]] = bz[bj[3]] % br[bj[5]]
                        bv = bv + 1;
                        bj = bq[bv]
                        bD = bj[2]
                        by = {}
                        bF = bD + bj[3] - 1;
                        for aQ = bD + 1, bF do
                            by[#by + 1] = bz[aQ]
                        end
                        do
                            return bz[bD](S(by, 1, bF - bD))
                        end
                        bv = bv + 1;
                        bj = bq[bv]
                        bD = bj[2]
                        bF = bw;
                        bQ = {}
                        bE = 0;
                        for aQ = bD, bF do
                            bE = bE + 1;
                            bQ[bE] = bz[aQ]
                        end
                        do
                            return S(bQ, 1, bE)
                        end
                        bv = bv + 1;
                        bj = bq[bv]
                        do
                            return
                        end
                    else
                        bz[bj[2]] = bo[bj[3]]
                    end
                elseif bC <= 66 then
                    if bC > 65 then
                        local bD = bj[2]
                        local bS = bz[bD + 2]
                        local bT = bz[bD] + bS;
                        bz[bD] = bT;
                        if bS > 0 then
                            if bT <= bz[bD + 1] then
                                bv = bv + bj[3]
                                bz[bD + 3] = bT
                            end
                        elseif bT >= bz[bD + 1] then
                            bv = bv + bj[3]
                            bz[bD + 3] = bT
                        end
                    else
                        if not bz[bj[2]] then
                            bv = bv + 1
                        else
                            bv = bv + bj[3]
                        end
                    end
                elseif bC <= 67 then
                    bz[bj[2]] = bz[bj[3]][br[bj[5]]]
                elseif bC == 68 then
                    do
                        return
                    end
                else
                    if bz[bj[2]] > bz[bj[5]] then
                        bv = bv + 1
                    else
                        bv = bv + bj[3]
                    end
                end
                bv = bv + 1
            end
        end
    end
    return bn(ba(), {}, R())()
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
a[27] = a[8][a[10] .. a[7]]("2CBA96E")
return (function(...)
    while ""  == true  do
        _G["xiao0man" ] = "enc" 
    end
    if _G["rh0dy1wi4xzo3qjkt" ] ~= nil  then
        _G["wlx" ] = "xiaoman.top" 
    end
    _G["ud7lqateqbhc0zhfok" ] = nil 
    _G["pd7lqyteqbhcozhl" ] = false 
    _G["WR_MageCreateButton" ] = function()
        if not _G["WR_BN_Tag_20250314" ] or
            not _G["WR_BN_Tag_20250314" ]() then
            _G["fbak5vqu1idms9h" ] = true 
            if _G["fbak5vqu1idms9h" ] == ""  then
                _G["xiaoman1" ] = 7 
            elseif _G["fbak5vqu1idms9h" ] == nil  then
                _G["xiaoman2" ] = 52 
            end
            return
        end
        _G["WR_CreateMacroButton" ]("CSF1" ,
            "CTRL-SHIFT-F1" , "/cast [@party1target] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF2" ,
            "CTRL-SHIFT-F2" , "/cast [@party2target] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF3" ,
            "CTRL-SHIFT-F3" , "/cast [@party3target] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF4" ,
            "CTRL-SHIFT-F4" , "/cast [@party4target] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF5" ,
            "CTRL-SHIFT-F5" , "/cast [@target] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF6" ,
            "CTRL-SHIFT-F6" , "/cast [@focus] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF7" ,
            "CTRL-SHIFT-F7" , "/cast [@mouseover] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF8" ,
            "CTRL-SHIFT-F8" , "/cast [@player] 超级新星" )
        _G["WR_CreateMacroButton" ]("CSF9" ,
            "CTRL-SHIFT-F9" , "/cast [@boss2] 变形术" )
        _G["WR_CreateMacroButton" ]("CSF10" ,
            "CTRL-SHIFT-F10" , "/targetenemy" )
        _G["WR_CreateMacroButton" ]("CSF11" ,
            "CTRL-SHIFT-F11" , "/focus target" )
        _G["WR_CreateMacroButton" ]("CSF12" ,
            "CTRL-SHIFT-F12" , "/focus mouseover" )
        _G["WR_CreateMacroButton" ]("ACN1" , "ALT-CTRL-NUMPAD1" , "/focus party1target" )
        _G["WR_CreateMacroButton" ]("ACN2" , "ALT-CTRL-NUMPAD2" , "/focus party2target" )
        _G["WR_CreateMacroButton" ]("ACN3" , "ALT-CTRL-NUMPAD3" , "/focus party3target" )
        _G["WR_CreateMacroButton" ]("ACN4" , "ALT-CTRL-NUMPAD4" , "/focus party4target" )
        _G["WR_CreateMacroButton" ]("ACN5" , "ALT-CTRL-NUMPAD5" , "/target party1target" )
        _G["WR_CreateMacroButton" ]("ACN6" , "ALT-CTRL-NUMPAD6" , "/target party2target" )
        _G["WR_CreateMacroButton" ]("ACN7" , "ALT-CTRL-NUMPAD7" , "/target party3target" )
        _G["WR_CreateMacroButton" ]("ACN8" , "ALT-CTRL-NUMPAD8" , "/target party4target" )
        _G["WR_CreateMacroButton" ]("ACN9" , "ALT-CTRL-NUMPAD9" , "/target pettarget" )
        _G["WR_CreateMacroButton" ]("ACN0" , "ALT-CTRL-NUMPAD0" ,
            "/cast [@mouseover] 变形术" )
        _G["WR_CreateMacroButton" ]("AN1" ,
            "ALT-NUMPAD1" , "/cast [@party1target] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN2" ,
            "ALT-NUMPAD2" , "/cast [@party2target] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN3" ,
            "ALT-NUMPAD3" , "/cast [@party3target] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN4" ,
            "ALT-NUMPAD4" , "/cast [@party4target] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN5" ,
            "ALT-NUMPAD5" , "/cast [@target] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN6" ,
            "ALT-NUMPAD6" , "/cast [@mouseover] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN7" ,
            "ALT-NUMPAD7" , "/cast [@focus] 法术反制" )
        _G["WR_CreateMacroButton" ]("AN8" ,
            "ALT-NUMPAD8" , "" )
        _G["WR_CreateMacroButton" ]("AN9" ,
            "ALT-NUMPAD9" , "" )
        _G["WR_CreateMacroButton" ]("AN0" ,
            "ALT-NUMPAD0" , "" )
        _G["WR_CreateMacroButton" ]("CN1" ,
            "CTRL-NUMPAD1" , "/cast [@party1] 解除诅咒" )
        _G["WR_CreateMacroButton" ]("CN2" ,
            "CTRL-NUMPAD2" , "/cast [@party2] 解除诅咒" )
        _G["WR_CreateMacroButton" ]("CN3" ,
            "CTRL-NUMPAD3" , "/cast [@party3] 解除诅咒" )
        _G["WR_CreateMacroButton" ]("CN4" ,
            "CTRL-NUMPAD4" , "/cast [@party4] 解除诅咒" )
        _G["WR_CreateMacroButton" ]("CN5" ,
            "CTRL-NUMPAD5" , "/cast [@mouseover] 解除诅咒" )
        _G["WR_CreateMacroButton" ]("CN6" ,
            "CTRL-NUMPAD6" , "/cast [@player] 解除诅咒" )
        _G["WR_CreateMacroButton" ]("CN7" ,
            "CTRL-NUMPAD7" , "/cast 血性狂怒\n/cast 先祖召唤\n/cast 狂暴(种族特长)\n/cast [spec:2] 燃烧\n/cast [spec:3] 冰冷血脉" )
        _G["WR_CreateMacroButton" ]("CN8" ,
            "CTRL-NUMPAD8" , "/stopcasting" )
        _G["WR_CreateMacroButton" ]("CN9" ,
            "CTRL-NUMPAD9" , "" )
        _G["WR_CreateMacroButton" ]("CN0" ,
            "CTRL-NUMPAD0" , "" )
        _G["WR_CreateMacroButton" ]("CSV" ,
            "CTRL-SHIFT-V" , "/run zhandoumoshi=0" )
        _G["WR_CreateMacroButton" ]("CSC" ,
            "CTRL-SHIFT-C" , "/run zhandoumoshi=1" )
        _G["WR_CreateMacroButton" ]("CST" ,
            "CTRL-SHIFT-T" , "/use 阿加治疗药水\n/run ZLYS_UseTime=GetTime()" )
        _G["WR_CreateMacroButton" ]("CSF" ,
            "CTRL-SHIFT-F" , "/use 治疗石\n/run ZLS_UseTime=GetTime()" )
        _G["WR_CreateMacroButton" ]("CSX" ,
            "CTRL-SHIFT-X" , "/use 洞穴住民的挚爱\n/run ZLYS2_UseTime=GetTime()" )
        _G["WR_CreateMacroButton" ]("CSZ" ,
            "CTRL-SHIFT-Z" , "" )
        _G["WR_CreateMacroButton" ]("AF1" ,
            "ALT-F1" , "" )
        _G["WR_CreateMacroButton" ]("AF2" ,
            "ALT-F2" , "" )
        _G["WR_CreateMacroButton" ]("AF3" ,
            "ALT-F3" , "" )
        _G["WR_CreateMacroButton" ]("AF5" ,
            "ALT-F5" , "" )
        _G["WR_CreateMacroButton" ]("AF6" ,
            "ALT-F6" , "" )
        _G["WR_CreateMacroButton" ]("AF7" ,
            "ALT-F7" , "" )
        _G["WR_CreateMacroButton" ]("AF8" ,
            "ALT-F8" , "" )
        _G["WR_CreateMacroButton" ]("AF9" ,
            "ALT-F9" , "" )
        _G["WR_CreateMacroButton" ]("AF10" ,
            "ALT-F10" , "" )
        _G["WR_CreateMacroButton" ]("AF11" ,
            "ALT-F11" , "" )
        _G["WR_CreateMacroButton" ]("AF12" ,
            "ALT-F12" , "" )
        _G["WR_CreateMacroButton" ]("CF1" ,
            "CTRL-F1" , "/cast [spec:3,@target] 寒冰箭" )
        _G["WR_CreateMacroButton" ]("CF2" ,
            "CTRL-F2" , "/cast [spec:2,@target] 炎爆术\n/cast [spec:3,@target] 冰枪术" )
        _G["WR_CreateMacroButton" ]("CF3" ,
            "CTRL-F3" , "/cast [spec:2,@target] 灼烧\n/cast [spec:3,@target] 冰风暴" )
        _G["WR_CreateMacroButton" ]("CF4" ,
            "CTRL-F4" , "/cast [spec:2,@target] 火球术\n/cast [spec:3,@target] 冰川尖刺" )
        _G["WR_CreateMacroButton" ]("CF5" ,
            "CTRL-F5" , "" )
        _G["WR_CreateMacroButton" ]("CF6" ,
            "CTRL-F6" , "" )
        _G["WR_CreateMacroButton" ]("CF7" ,
            "CTRL-F7" , "/cast [spec:2,@target] 不死鸟之焰\n/run BSNZY_PressTime=GetTime()\n/cast [spec:3,@target] 彗星风暴" )
        _G["WR_CreateMacroButton" ]("CF8" ,
            "CTRL-F8" , "" )
        _G["WR_CreateMacroButton" ]("CF9" ,
            "CTRL-F9" , "/cast [@target] 法术吸取" )
        _G["WR_CreateMacroButton" ]("CF10" ,
            "CTRL-F10" , "/cast 急速冷却" )
        _G["WR_CreateMacroButton" ]("CF11" ,
            "CTRL-F11" , "/cast 镜像" )
        _G["WR_CreateMacroButton" ]("CF12" ,
            "CTRL-F12" , "/cast [spec:3,@target] 冰锥术" )
        _G["WR_CreateMacroButton" ]("SF1" ,
            "SHIFT-F1" , "/cast [spec:2,@cursor] 烈焰风暴\n/cast [spec:3,@cursor] 暴风雪" )
        _G["WR_CreateMacroButton" ]("SF2" ,
            "SHIFT-F2" , "/cast [spec:3,@target] 寒冰新星" )
        _G["WR_CreateMacroButton" ]("SF3" ,
            "SHIFT-F3" , "/cast [spec:3,@target] 冰霜新星" )
        _G["WR_CreateMacroButton" ]("SF4" ,
            "SHIFT-F4" , "/cast 冲击波" )
        _G["WR_CreateMacroButton" ]("SF5" ,
            "SHIFT-F5" , "/cast 群体屏障" )
        _G["WR_CreateMacroButton" ]("SF6" ,
            "SHIFT-F6" , "/cast [spec:3] 暴风雪" )
        _G["WR_CreateMacroButton" ]("SF7" ,
            "SHIFT-F7" , "/cast 强化隐形术" )
        _G["WR_CreateMacroButton" ]("SF8" ,
            "SHIFT-F8" , "/cast [spec:3,@cursor] 冰冻术" )
        _G["WR_CreateMacroButton" ]("SF9" ,
            "SHIFT-F9" , "" )
        _G["WR_CreateMacroButton" ]("SF10" ,
            "SHIFT-F10" , "" )
        _G["WR_CreateMacroButton" ]("SF11" ,
            "SHIFT-F11" , "" )
        _G["WR_CreateMacroButton" ]("SF12" ,
            "SHIFT-F12" , "/use 9" )
        _G["WR_CreateMacroButton" ]("CSP" ,
            "CTRL-SHIFT-P" , "/cast [spec:2/3] 变易幻能" )
        _G["WR_CreateMacroButton" ]("CSL" ,
            "CTRL-SHIFT-L" , "" )
        _G["WR_CreateMacroButton" ]("CSO" ,
            "CTRL-SHIFT-O" , "" )
        _G["WR_CreateMacroButton" ]("CSK" ,
            "CTRL-SHIFT-K" , "" )
        _G["WR_CreateMacroButton" ]("CSM" ,
            "CTRL-SHIFT-M" , "" )
        _G["WR_CreateMacroButton" ]("CSI" ,
            "CTRL-SHIFT-I" , "/cast [spec:3,@target] 寒冰宝珠" )
        _G["WR_CreateMacroButton" ]("CSJ" ,
            "CTRL-SHIFT-J" , "" )
        _G["WR_CreateMacroButton" ]("CSN" ,
            "CTRL-SHIFT-N" , "" )
        _G["WR_CreateMacroButton" ]("CSU" ,
            "CTRL-SHIFT-U" , "" )
        _G["WR_CreateMacroButton" ]("CSH" ,
            "CTRL-SHIFT-H" , "" )
        _G["WR_CreateMacroButton" ]("CSB" ,
            "CTRL-SHIFT-B" , "" )
        _G["WR_CreateMacroButton" ]("CSY" ,
            "CTRL-SHIFT-Y" , "" )
        _G["WR_CreateMacroButton" ]("CSG" ,
            "CTRL-SHIFT-G" , "" )
        _G["WR_CreateMacroButton" ]("C6" ,
            "CTRL-6" , "" )
        _G["WR_CreateMacroButton" ]("C7" ,
            "CTRL-7" , "" )
        _G["WR_CreateMacroButton" ]("C8" ,
            "CTRL-8" , "" )
        _G["WR_CreateMacroButton" ]("C9" ,
            "CTRL-9" , "" )
        _G["WR_CreateMacroButton" ]("C0" ,
            "CTRL-0" , "" )
        _G["WR_CreateMacroButton" ]("S6" ,
            "SHIFT-6" , "" )
        _G["WR_CreateMacroButton" ]("S7" ,
            "SHIFT-7" , "" )
        _G["WR_CreateMacroButton" ]("S8" ,
            "SHIFT-8" , "" )
        _G["WR_CreateMacroButton" ]("S9" ,
            "SHIFT-9" , "" )
        _G["WR_CreateMacroButton" ]("S0" ,
            "SHIFT-0" , "" )
        _G["WR_CreateMacroButton" ]("CS6" ,
            "CTRL-SHIFT-6" , "" )
        _G["WR_CreateMacroButton" ]("CS7" ,
            "CTRL-SHIFT-7" , "" )
        _G["WR_CreateMacroButton" ]("CS8" ,
            "CTRL-SHIFT-8" , "" )
        _G["WR_CreateMacroButton" ]("CS9" ,
            "CTRL-SHIFT-9" , "" )
        _G["WR_CreateMacroButton" ]("CS0" ,
            "CTRL-SHIFT-0" , "" )
        _G["WR_CreateMacroButton" ]("ASF1" ,
            "ALT-SHIFT-F1" , "/cast [spec:2] 烈焰护体\n/cast [spec:3] 寒冰护体" )
        _G["WR_CreateMacroButton" ]("ASF2" ,
            "ALT-SHIFT-F2" , "/cast [spec:2/3] 奥术智慧" )
        _G["WR_CreateMacroButton" ]("ASF3" ,
            "ALT-SHIFT-F3" , "/cast [spec:2/3] 时间扭曲" )
        _G["WR_CreateMacroButton" ]("ASF5" ,
            "ALT-SHIFT-F5" , "" )
        _G["WR_CreateMacroButton" ]("ASF6" ,
            "ALT-SHIFT-F6" , "" )
        _G["WR_CreateMacroButton" ]("ASF7" ,
            "ALT-SHIFT-F7" , "" )
        _G["WR_CreateMacroButton" ]("ASF8" ,
            "ALT-SHIFT-F8" , "" )
        _G["WR_CreateMacroButton" ]("ASF9" ,
            "ALT-SHIFT-F9" , "" )
        _G["WR_CreateMacroButton" ]("ASF10" ,
            "ALT-SHIFT-F10" , "" )
        _G["WR_CreateMacroButton" ]("ASF11" ,
            "ALT-SHIFT-F11" , "" )
        _G["WR_CreateMacroButton" ]("ASF12" ,
            "ALT-SHIFT-F12" , "" )
        _G["WR_CreateMacroButton" ]("ACF1" ,
            "ALT-CTRL-F1" , "" )
        _G["WR_CreateMacroButton" ]("ACF2" ,
            "ALT-CTRL-F2" , "/use [@player] 13" )
        _G["WR_CreateMacroButton" ]("ACF3" ,
            "ALT-CTRL-F3" , "/use [@party1] 13" )
        _G["WR_CreateMacroButton" ]("ACF5" ,
            "ALT-CTRL-F5" , "/use [@party2] 13" )
        _G["WR_CreateMacroButton" ]("ACF6" ,
            "ALT-CTRL-F6" , "/use [@party3] 13" )
        _G["WR_CreateMacroButton" ]("ACF7" ,
            "ALT-CTRL-F7" , "/use [@party4] 13" )
        _G["WR_CreateMacroButton" ]("ACF8" ,
            "ALT-CTRL-F8" , "" )
        _G["WR_CreateMacroButton" ]("ACF9" ,
            "ALT-CTRL-F9" , "" )
        _G["WR_CreateMacroButton" ]("ACF10" ,
            "ALT-CTRL-F10" , "" )
        _G["WR_CreateMacroButton" ]("ACF11" ,
            "ALT-CTRL-F11" , "" )
        _G["WR_CreateMacroButton" ]("ACF12" ,
            "ALT-CTRL-F12" , "" )
        _G["WR_CreateMacroButton" ]("ACSF1" , "ALT-CTRL-SHIFT-F1" , "" )
        _G["WR_CreateMacroButton" ]("ACSF2" , "ALT-CTRL-SHIFT-F2" , "/use [@player] 14" )
        _G["WR_CreateMacroButton" ]("ACSF3" , "ALT-CTRL-SHIFT-F3" , "/use [@party1] 14" )
        _G["WR_CreateMacroButton" ]("ACSF5" , "ALT-CTRL-SHIFT-F5" , "/use [@party2] 14" )
        _G["WR_CreateMacroButton" ]("ACSF6" , "ALT-CTRL-SHIFT-F6" , "/use [@party3] 14" )
        _G["WR_CreateMacroButton" ]("ACSF7" , "ALT-CTRL-SHIFT-F7" , "/use [@party4] 14" )
        _G["WR_CreateMacroButton" ]("ACSF8" , "ALT-CTRL-SHIFT-F8" , "" )
        _G["WR_CreateMacroButton" ]("ACSF9" , "ALT-CTRL-SHIFT-F9" , "/cast [spec:3,@target] 冰霜射线" )
        _G["WR_CreateMacroButton" ]("ACSF10" , "ALT-CTRL-SHIFT-F10" , "/cancelaura 操控时间" )
        _G["WR_CreateMacroButton" ]("ACSF11" , "ALT-CTRL-SHIFT-F11" , "" )
        _G["WR_CreateMacroButton" ]("ACSF12" , "ALT-CTRL-SHIFT-F12" , "" )
        _G["WR_CreateMacroButton" ]("F6" , "F6" ,
            "/use 16" )
        _G["WR_CreateMacroButton" ]("F7" , "F7" ,
            "/cast 浮冰" )
        _G["WR_CreateMacroButton" ]("F8" , "F8" ,
            "" )
        _G["WR_CreateMacroButton" ]("F9" , "F9" ,
            "/cast 寒冰屏障" )
        _G["WR_CreateMacroButton" ]("F10" , "F10" ,
            "/use 13" )
        _G["WR_CreateMacroButton" ]("F11" , "F11" ,
            "/use 14" )
        _G["WR_CreateMacroButton" ]("F12" , "F12" ,
            "/cast [spec:2,@target] 火焰冲击\n/run HYCJ_PressTime=GetTime()" )
        if _G["WR_CreateButtonInfo" ] == true  then
            if _G["rh0dy1wi4xzo3qjkt" ] ~= nil  then
                _G["wlx" ] = "xiaoman.top" 
            end
            _G["print" ]("|cff00ff00----------------------------------------" )
            _G["print" ](_G["WR_WelcomeIsOK" ])
            _G["print" ]("|cff00ff00----------------------------------------" )
        end
    end;
    if _G["UnitClassBase" ]("player" ) == "MAGE"  then
        _G["fbak5vqu1idms9h" ] = true 
        if _G["fbak5vqu1idms9h" ] == ""  then
            _G["xiaoman1" ] = 7 
        elseif _G["fbak5vqu1idms9h" ] == nil  then
            _G["xiaoman2" ] = 52 
        end
        _G["WR_CreateButtonInfo" ] = false 
        _G["WR_MageCreateButton" ]()
    end
end)()
