local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 39;
    local c = 34;
    local d = 23;
    local e = 14;
    local f = 18;
    local g = 94;
    local h = 39;
    local i = 62;
    local j = 68;
    local k = 94;
    local l = "g"
    local m = "m"
    local n = "n"
    local o = "a"
    local p = "b"
    local q = "p"
    local r = "r"
    local s = "s"
    local t = "t"
    local u = "c"
    local v = "o"
    local w = "u"
    local x = "h"
    local y = "d"
    local z = "e"
    local A = "i"
    local B = "k"
    local C = "l"
    local D = "y"
    local E = "w"
    local F = a[8][t .. o .. p .. C .. z][u .. v .. n .. u .. o .. t]
    local G = a[8][m .. o .. t .. x][C .. y .. z .. a[2] .. q] or a[8][m .. o .. t .. x][s .. u .. o .. C .. z]
    local H = s .. t .. r .. A .. n .. l;
    local I = a[8][s .. z .. t .. m .. z .. t .. o .. t .. o .. p .. C .. z]
    local J = a[8][H][s .. w .. p]
    local K = a[8][H][u .. x .. o .. r]
    local L = a[8][s .. z .. C .. z .. u .. t]
    local M = a[8][H][p .. D .. t .. z]
    local N = function()
        return a[8]
    end;
    local O = a[8][t .. o .. p .. C .. z][w .. n .. q .. o .. u .. B] or a[8][w .. n .. q .. o .. u .. B]
    local P = a[8][H][l .. s .. w .. p]
    local Q = a[8][t .. v .. n .. w .. m .. p .. z .. r]
    local function R(S)
        local T, U, V = "", "", {}
        local W = 256;
        local X = {}
        if S == r then
            return U
        end
        for Y = 0, W - 1 do
            X[Y] = K(Y)
        end
        local Z = 1;
        local function _()
            local a0 = Q(J(S, Z, Z), 36)
            Z = Z + 1;
            local a1 = Q(J(S, Z, Z + a0 - 1), 36)
            Z = Z + a0;
            return a1
        end
        T = K(_())
        V[1] = T;
        while Z < #S do
            local a2 = _()
            if X[a2] then
                U = X[a2]
            else
                U = T .. J(T, 1, 1)
            end
            X[W] = T .. J(U, 1, 1)
            V[#V + 1], T, W = U, U, W + 1
        end
        return F(V)
    end
    local a3 = a[10]
    local a4 = a[8][p .. A .. t] and a[8][p .. A .. t][p .. a[2] .. v .. r] or function(a5, S)
        local a6, T = 1, 0;
        while a5 > 0 and S > 0 do
            local a7, a8 = a5 % 2, S % 2;
            if a7 ~= a8 then
                T = T + a6
            end
            a5, S, a6 = (a5 - a7) / 2, (S - a8) / 2, a6 * 2
        end
        if a5 < S then
            a5 = S
        end
        while a5 > 0 do
            local a7 = a5 % 2;
            if a7 > 0 then
                T = T + a6
            end
            a5, a6 = (a5 - a7) / 2, a6 * 2
        end
        return T
    end;
    local a9 = a3 .. a[15]
    local aa = N()
    local ab = a3 .. a[5]
    local function ac(ad, ae, af)
        if af then
            local ag = ad / 2 ^ (ae - 1) % 2 ^ (af - 1 - (ae - 1) + 1)
            return ag - ag % 1
        else
            local ah = 2 ^ (ae - 1)
            return ad % (ah + ah) >= ah and 1 or 0
        end
    end
    local ai = a3 .. a[9]
    local aj = 1;
    local ak = a3 .. a[14]
    local al = R(r)
    local am = a3 .. a[1]
    local function an()
        local ao, ap, aq, ar = M(al, aj, aj + 3)
        ao = a4(ao, 156)
        ap = a4(ap, 156)
        aq = a4(aq, 156)
        ar = a4(ar, 156)
        aj = aj + 4;
        return ar * 16777216 + aq * 65536 + ap * 256 + ao
    end
    local as = a3 .. a[19]
    local at = R(n .. a[4] .. t)
    local function au()
        local av = a4(M(al, aj, aj), 156)
        aj = aj + 1;
        return av
    end
    local aw = a[8][a[10]]
    local ax = a3 .. a[7]
    local function ay()
        local az = an()
        local aA = an()
        local aB = 1;
        local aC = ac(aA, 1, 20) * 2 ^ 32 + az;
        local aD = ac(aA, 21, 31)
        local aE = (-1) ^ ac(aA, 32)
        if aD == 0 then
            if aC == 0 then
                return aE * 0
            else
                aD = 1;
                aB = 0
            end
        elseif aD == 2047 then
            return aC == 0 and aE * 1 / 0 or aE * 0 / 0
        end
        return G(aE, aD - 1023) * (aB + aC / 2 ^ 52)
    end
    local aF = a[12]
    local aG = at == a[17]
    local aH = a3 .. a[11]
    local aI = an;
    local function aJ(aK)
        local aL;
        if not aK then
            aK = aI()
            if aK == 0 then
                return ""
            end
        end
        aL = J(al, aj, aj + aK - 1)
        aj = aj + aK;
        local aM = {}
        for aN = 1, #aL do
            aM[aN] = K(a4(M(J(aL, aN, aN)), 156))
        end
        return F(aM)
    end
    local aO = a3 .. a[4]
    local aP = an;
    local aQ = at == z;
    local aR = a[3]
    local function aS(...)
        return {...}, L("#", ...)
    end
    local function aT(aU, aV, aW)
        local function aX(Y, aY)
            local aZ = al;
            for Z = 1, #aY do
                local T = M(aY, Z, Z) - (Y + Z) % 256;
                if T < 0 then
                    T = T + 256
                end
                aZ = aZ .. K(T)
            end
            return aZ
        end
        local function a_(b0)
            return P(b0, '..', function(b1)
                return K(Q(b1, 16) % 256)
            end)
        end
        aa[ak] = function(b2)
            return ay() .. b2
        end;
        aa[ai] = function(b3, b4)
            return Q(aX(b3, a_(b4)))
        end;
        aa[aO] = function()
            return aw
        end;
        aa[a9] = function()
            return al
        end;
        aa[aH] = function(b5, b6)
            return aX(b5, a_(b6))
        end;
        aa[am] = function()
            return aQ
        end;
        aa[ab] = function()
            return aV
        end;
        aa[ax] = function(_)
            local Y = 0;
            for Z = 1, #_ do
                Y = Y + M(_, Z, Z)
            end
            return Y
        end;
        aa[as] = function()
            return aG
        end;
        return a_(aU .. aW)
    end
    local function b7()
        local b8 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0}
        local b9 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local ba = {}
        local bb = {b8, nil, b9, nil, ba}
        if C ~= n then
            return b9
        end
        bb[4] = au()
        for aN = 1, an() do
            local bc = a4(an(), 182)
            local bd = a4(an(), 119)
            local be = ac(bc, 1, 2)
            local bf = ac(bd, 1, 11)
            local bg = {bf, ac(bc, 3, 11), nil, nil, bd}
            if be == 0 then
                bg[3] = ac(bc, 12, 20)
                bg[5] = ac(bc, 21, 29)
            elseif be == 1 then
                bg[3] = ac(bd, 12, 33)
            elseif be == 2 then
                bg[3] = ac(bd, 12, 32) - 1048575
            elseif be == 3 then
                bg[3] = ac(bd, 12, 32) - 1048575;
                bg[5] = ac(bc, 21, 29)
            end
            b8[aN] = bg
        end
        local bh = an()
        local bi = {0, 0, 0, 0, 0, 0, 0}
        for aN = 1, bh do
            local be = au()
            local bj;
            if be == 1 then
                bj = au() ~= 0
            elseif be == 2 then
                bj = ay()
            elseif be == 0 then
                bj = aJ()
            end
            bi[aN] = bj
        end
        bb[2] = bi;
        for aN = 1, an() do
            b9[aN - 1] = b7()
        end
        return bb
    end
    local function bk(bb, bl, bm)
        local bn = bb[1]
        local bo = bb[2]
        local bp = bb[3]
        local bq = bb[4]
        return function(...)
            local bn = bn;
            local bo = bo;
            local bp = bp;
            local bq = bq;
            local br = aT(aR, aa, aF)
            local aS = aS;
            local bs = 1;
            local bt = -1;
            if at ~= B then
                return bs
            end
            local bu = {}
            local bv = {...}
            local bw = {}
            local bx = L("#", ...) - 1;
            for aN = 0, bx do
                if aN >= bq then
                    bu[aN - bq] = bv[aN + 1]
                else
                    bw[aN] = bv[aN + 1]
                end
            end
            local by = bx - bq + 1;
            local bg;
            local bz;
            while true do
                bg = bn[bs]
                bz = bg[1]
                if bz <= 34 then
                    if bz <= 16 then
                        if bz <= 7 then
                            if bz <= 3 then
                                if bz <= 1 then
                                    if bz == 0 then
                                        bw[bg[2]] = bw[bg[3]] + bo[bg[5]]
                                    else
                                        local bA = bg[2]
                                        local bv = {}
                                        local bB = 0;
                                        local bC = bA + bg[3] - 1;
                                        for aN = bA + 1, bC do
                                            bB = bB + 1;
                                            bv[bB] = bw[aN]
                                        end
                                        local bD = {bw[bA](O(bv, 1, bC - bA))}
                                        local bC = bA + bg[5] - 2;
                                        bB = 0;
                                        for aN = bA, bC do
                                            bB = bB + 1;
                                            bw[aN] = bD[bB]
                                        end
                                        bt = bC
                                    end
                                elseif bz == 2 then
                                    local bE = bp[bg[3]]
                                    local bF;
                                    local bG = {}
                                    bF = I({}, {
                                        [a[16] .. a[16] .. A .. n .. y .. z .. a[2]] = function(bH, bI)
                                            local bJ = bG[bI]
                                            return bJ[1][bJ[2]]
                                        end,
                                        [a[16] .. a[16] .. n .. z .. E .. A .. n .. y .. z .. a[2]] = function(bH, bI,
                                            bK)
                                            local bJ = bG[bI]
                                            bJ[1][bJ[2]] = bK
                                        end
                                    })
                                    for aN = 1, bg[5] do
                                        bs = bs + 1;
                                        local bL = bn[bs]
                                        if bL[1] == 7 then
                                            bG[aN - 1] = {bw, bL[3]}
                                        else
                                            bG[aN - 1] = {bl, bL[3]}
                                        end
                                        br[#br + 1] = bG
                                    end
                                    bw[bg[2]] = bk(bE, bF, bm)
                                else
                                    local bA = bg[2]
                                    local bM = bw[bg[3]]
                                    bw[bA + 1] = bM;
                                    bw[bA] = bM[bo[bg[5]]]
                                end
                            elseif bz <= 5 then
                                if bz > 4 then
                                    local bA;
                                    bw[bg[2]] = bo[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = #bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bo[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = #bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bo[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bw[bA] = bw[bA] - bw[bA + 2]
                                    bs = bs + bg[3]
                                else
                                    local bN;
                                    local bD, bC;
                                    local bC;
                                    local bB;
                                    local bv;
                                    local bA;
                                    bw[bg[2]] = bm[bo[bg[3]]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bl[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bl[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bv = {}
                                    bB = 0;
                                    bC = bA + bg[3] - 1;
                                    for aN = bA + 1, bC do
                                        bB = bB + 1;
                                        bv[bB] = bw[aN]
                                    end
                                    bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                                    bC = bC + bA - 1;
                                    bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bw[aN] = bD[bB]
                                    end
                                    bt = bC;
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bv = {}
                                    bB = 0;
                                    bC = bt;
                                    for aN = bA + 1, bC do
                                        bB = bB + 1;
                                        bv[bB] = bw[aN]
                                    end
                                    bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                                    bC = bC + bA - 1;
                                    bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bw[aN] = bD[bB]
                                    end
                                    bt = bC;
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bv = {}
                                    bC = bt;
                                    for aN = bA + 1, bC do
                                        bv[#bv + 1] = bw[aN]
                                    end
                                    do
                                        return bw[bA](O(bv, 1, bC - bA))
                                    end
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bC = bt;
                                    bN = {}
                                    bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bN[bB] = bw[aN]
                                    end
                                    do
                                        return O(bN, 1, bB)
                                    end
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    do
                                        return
                                    end
                                end
                            elseif bz > 6 then
                                bw[bg[2]] = bw[bg[3]]
                            else
                                bs = bs + bg[3]
                            end
                        elseif bz <= 11 then
                            if bz <= 9 then
                                if bz == 8 then
                                    bw[bg[2]] = bm[bo[bg[3]]]
                                else
                                    local bM;
                                    local bD;
                                    local bC;
                                    local bB;
                                    local bv;
                                    local bA;
                                    bw[bg[2]] = bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bv = {}
                                    bB = 0;
                                    bC = bA + bg[3] - 1;
                                    for aN = bA + 1, bC do
                                        bB = bB + 1;
                                        bv[bB] = bw[aN]
                                    end
                                    bD = {bw[bA](O(bv, 1, bC - bA))}
                                    bC = bA + bg[5] - 2;
                                    bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bw[aN] = bD[bB]
                                    end
                                    bt = bC;
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]] + bw[bg[5]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]] % bo[bg[5]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bM = bw[bg[3]]
                                    bw[bA + 1] = bM;
                                    bw[bA] = bM[bo[bg[5]]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bw[bg[2]] = bw[bg[3]]
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    bA = bg[2]
                                    bv = {}
                                    bB = 0;
                                    bC = bA + bg[3] - 1;
                                    for aN = bA + 1, bC do
                                        bB = bB + 1;
                                        bv[bB] = bw[aN]
                                    end
                                    bD = {bw[bA](O(bv, 1, bC - bA))}
                                    bC = bA + bg[5] - 2;
                                    bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bw[aN] = bD[bB]
                                    end
                                    bt = bC;
                                    bs = bs + 1;
                                    bg = bn[bs]
                                    if bw[bg[2]] > bw[bg[5]] then
                                        bs = bs + 1
                                    else
                                        bs = bs + bg[3]
                                    end
                                end
                            elseif bz > 10 then
                                local bM = bw[bg[3]]
                                if not bM then
                                    bs = bs + 1
                                else
                                    bw[bg[2]] = bM;
                                    bs = bs + bn[bs + 1][3] + 1
                                end
                            else
                                local bN;
                                local bD, bC;
                                local bC;
                                local bB;
                                local bv;
                                local bA;
                                bw[bg[2]] = bl[bg[3]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bw[bg[2]] = bw[bg[3]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bw[bg[2]] = bl[bg[3]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bw[bg[2]] = bw[bg[3]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bA = bg[2]
                                bv = {}
                                bB = 0;
                                bC = bA + bg[3] - 1;
                                for aN = bA + 1, bC do
                                    bB = bB + 1;
                                    bv[bB] = bw[aN]
                                end
                                bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                                bC = bC + bA - 1;
                                bB = 0;
                                for aN = bA, bC do
                                    bB = bB + 1;
                                    bw[aN] = bD[bB]
                                end
                                bt = bC;
                                bs = bs + 1;
                                bg = bn[bs]
                                bA = bg[2]
                                bv = {}
                                bC = bt;
                                for aN = bA + 1, bC do
                                    bv[#bv + 1] = bw[aN]
                                end
                                do
                                    return bw[bA](O(bv, 1, bC - bA))
                                end
                                bs = bs + 1;
                                bg = bn[bs]
                                bA = bg[2]
                                bC = bt;
                                bN = {}
                                bB = 0;
                                for aN = bA, bC do
                                    bB = bB + 1;
                                    bN[bB] = bw[aN]
                                end
                                do
                                    return O(bN, 1, bB)
                                end
                                bs = bs + 1;
                                bg = bn[bs]
                                do
                                    return
                                end
                            end
                        elseif bz <= 13 then
                            if bz == 12 then
                                bw[bg[2]] = bg[3] ~= 0
                            else
                                local bA = bg[2]
                                local bv = {}
                                local bC = bt;
                                for aN = bA + 1, bC do
                                    bv[#bv + 1] = bw[aN]
                                end
                                do
                                    return bw[bA](O(bv, 1, bC - bA))
                                end
                            end
                        elseif bz <= 14 then
                            local bA = bg[2]
                            local bv = {}
                            local bB = 0;
                            local bC = bA + bg[3] - 1;
                            for aN = bA + 1, bC do
                                bB = bB + 1;
                                bv[bB] = bw[aN]
                            end
                            local bD = {bw[bA](O(bv, 1, bC - bA))}
                            local bC = bA + bg[5] - 2;
                            bB = 0;
                            for aN = bA, bC do
                                bB = bB + 1;
                                bw[aN] = bD[bB]
                            end
                            bt = bC
                        elseif bz == 15 then
                            bw[bg[2]] = bw[bg[3]] % bw[bg[5]]
                        else
                            local bA = bg[2]
                            local bv = {}
                            local bB = 0;
                            local bC = bA + bg[3] - 1;
                            for aN = bA + 1, bC do
                                bB = bB + 1;
                                bv[bB] = bw[aN]
                            end
                            local bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                            bC = bC + bA - 1;
                            bB = 0;
                            for aN = bA, bC do
                                bB = bB + 1;
                                bw[aN] = bD[bB]
                            end
                            bt = bC
                        end
                    elseif bz <= 25 then
                        if bz <= 20 then
                            if bz <= 18 then
                                if bz > 17 then
                                    local bA = bg[2]
                                    local bv = {}
                                    local bC = bt;
                                    for aN = bA + 1, bC do
                                        bv[#bv + 1] = bw[aN]
                                    end
                                    do
                                        return bw[bA](O(bv, 1, bC - bA))
                                    end
                                else
                                    bw[bg[2]] = bw[bg[3]] + bo[bg[5]]
                                end
                            elseif bz == 19 then
                                local bO;
                                local bM;
                                local bD;
                                local bC;
                                local bB;
                                local bv;
                                local bA;
                                bw[bg[2]] = bm[bo[bg[3]]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bw[bg[2]] = bw[bg[3]][bo[bg[5]]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bw[bg[2]] = bw[bg[3]]
                                bs = bs + 1;
                                bg = bn[bs]
                                bA = bg[2]
                                bv = {}
                                bB = 0;
                                bC = bA + bg[3] - 1;
                                for aN = bA + 1, bC do
                                    bB = bB + 1;
                                    bv[bB] = bw[aN]
                                end
                                bD = {bw[bA](O(bv, 1, bC - bA))}
                                bC = bA + bg[5] - 2;
                                bB = 0;
                                for aN = bA, bC do
                                    bB = bB + 1;
                                    bw[aN] = bD[bB]
                                end
                                bt = bC;
                                bs = bs + 1;
                                bg = bn[bs]
                                bM = bg[3]
                                bO = bw[bM]
                                for aN = bM + 1, bg[5] do
                                    bO = bO .. bw[aN]
                                end
                                bw[bg[2]] = bO
                            else
                                bw[bg[2]] = bl[bg[3]]
                            end
                        elseif bz <= 22 then
                            if bz == 21 then
                                local bA = bg[2]
                                bw[bA] = bw[bA] - bw[bA + 2]
                                bs = bs + bg[3]
                            else
                                local bE = bp[bg[3]]
                                local bF;
                                local bG = {}
                                bF = I({}, {
                                    [a[16] .. a[16] .. A .. n .. y .. z .. a[2]] = function(bH, bI)
                                        local bJ = bG[bI]
                                        return bJ[1][bJ[2]]
                                    end,
                                    [a[16] .. a[16] .. n .. z .. E .. A .. n .. y .. z .. a[2]] = function(bH, bI, bK)
                                        local bJ = bG[bI]
                                        bJ[1][bJ[2]] = bK
                                    end
                                })
                                for aN = 1, bg[5] do
                                    bs = bs + 1;
                                    local bL = bn[bs]
                                    if bL[1] == 7 then
                                        bG[aN - 1] = {bw, bL[3]}
                                    else
                                        bG[aN - 1] = {bl, bL[3]}
                                    end
                                    br[#br + 1] = bG
                                end
                                bw[bg[2]] = bk(bE, bF, bm)
                            end
                        elseif bz <= 23 then
                            bw[bg[2]] = bm[bo[bg[3]]]
                        elseif bz == 24 then
                            bw[bg[2]] = bw[bg[3]] % bw[bg[5]]
                        else
                            bw[bg[2]] = bw[bg[3]][bo[bg[5]]]
                        end
                    elseif bz <= 29 then
                        if bz <= 27 then
                            if bz == 26 then
                                local bM = bg[3]
                                local bO = bw[bM]
                                for aN = bM + 1, bg[5] do
                                    bO = bO .. bw[aN]
                                end
                                bw[bg[2]] = bO
                            else
                                bw[bg[2]] = bw[bg[3]] + bw[bg[5]]
                            end
                        elseif bz == 28 then
                            bw[bg[2]] = bk(bp[bg[3]], nil, bm)
                        else
                            local bA = bg[2]
                            local bv = {}
                            local bC = bA + bg[3] - 1;
                            for aN = bA + 1, bC do
                                bv[#bv + 1] = bw[aN]
                            end
                            do
                                return bw[bA](O(bv, 1, bC - bA))
                            end
                        end
                    elseif bz <= 31 then
                        if bz == 30 then
                            bw[bg[2]] = bw[bg[3]]
                        else
                            bw[bg[2]] = bw[bg[3]] % bo[bg[5]]
                        end
                    elseif bz <= 32 then
                        local bA = bg[2]
                        bw[bA] = bw[bA] - bw[bA + 2]
                        bs = bs + bg[3]
                    elseif bz == 33 then
                        bw[bg[2]] = #bw[bg[3]]
                    else
                        if bw[bg[2]] == bo[bg[5]] then
                            bs = bs + 1
                        else
                            bs = bs + bg[3]
                        end
                    end
                elseif bz <= 51 then
                    if bz <= 42 then
                        if bz <= 38 then
                            if bz <= 36 then
                                if bz > 35 then
                                    local bA = bg[2]
                                    local bv = {}
                                    local bB = 0;
                                    local bC = bA + bg[3] - 1;
                                    for aN = bA + 1, bC do
                                        bB = bB + 1;
                                        bv[bB] = bw[aN]
                                    end
                                    local bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                                    bC = bC + bA - 1;
                                    bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bw[aN] = bD[bB]
                                    end
                                    bt = bC
                                else
                                    local bA = bg[2]
                                    local bC = bt;
                                    local bN = {}
                                    local bB = 0;
                                    for aN = bA, bC do
                                        bB = bB + 1;
                                        bN[bB] = bw[aN]
                                    end
                                    do
                                        return O(bN, 1, bB)
                                    end
                                end
                            elseif bz == 37 then
                                bw[bg[2]] = bk(bp[bg[3]], nil, bm)
                            else
                                bw[bg[2]] = bo[bg[3]]
                            end
                        elseif bz <= 40 then
                            if bz > 39 then
                                local bA = bg[2]
                                local bv = {}
                                local bB = 0;
                                local bC = bt;
                                for aN = bA + 1, bC do
                                    bB = bB + 1;
                                    bv[bB] = bw[aN]
                                end
                                local bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                                bC = bC + bA - 1;
                                bB = 0;
                                for aN = bA, bC do
                                    bB = bB + 1;
                                    bw[aN] = bD[bB]
                                end
                                bt = bC
                            else
                                bw[bg[2]] = bw[bg[3]] - bw[bg[5]]
                            end
                        elseif bz == 41 then
                            local bA = bg[2]
                            local bP = bw[bA + 2]
                            local bQ = bw[bA] + bP;
                            bw[bA] = bQ;
                            if bP > 0 then
                                if bQ <= bw[bA + 1] then
                                    bs = bs + bg[3]
                                    bw[bA + 3] = bQ
                                end
                            elseif bQ >= bw[bA + 1] then
                                bs = bs + bg[3]
                                bw[bA + 3] = bQ
                            end
                        else
                            if bw[bg[2]] == bo[bg[5]] then
                                bs = bs + 1
                            else
                                bs = bs + bg[3]
                            end
                        end
                    elseif bz <= 46 then
                        if bz <= 44 then
                            if bz > 43 then
                                bw[bg[2]] = bg[3] ~= 0
                            else
                                local bA = bg[2]
                                local bC = bA + bg[3] - 2;
                                local bN = {}
                                local bB = 0;
                                for aN = bA, bC do
                                    bB = bB + 1;
                                    bN[bB] = bw[aN]
                                end
                                do
                                    return O(bN, 1, bB)
                                end
                            end
                        elseif bz == 45 then
                            local bA = bg[2]
                            local bC = bA + bg[3] - 2;
                            local bN = {}
                            local bB = 0;
                            for aN = bA, bC do
                                bB = bB + 1;
                                bN[bB] = bw[aN]
                            end
                            do
                                return O(bN, 1, bB)
                            end
                        else
                            bw[bg[2]] = bw[bg[3]] % bo[bg[5]]
                        end
                    elseif bz <= 48 then
                        if bz == 47 then
                            local bA = bg[2]
                            local bM = bw[bg[3]]
                            bw[bA + 1] = bM;
                            bw[bA] = bM[bo[bg[5]]]
                        else
                            local bA = bg[2]
                            local bv = {}
                            local bC = bA + bg[3] - 1;
                            for aN = bA + 1, bC do
                                bv[#bv + 1] = bw[aN]
                            end
                            do
                                return bw[bA](O(bv, 1, bC - bA))
                            end
                        end
                    elseif bz <= 49 then
                        bw[bg[2]] = bw[bg[3]] - bw[bg[5]]
                    elseif bz > 50 then
                        local bA = bg[2]
                        local bv = {}
                        local bB = 0;
                        local bC = bt;
                        for aN = bA + 1, bC do
                            bB = bB + 1;
                            bv[bB] = bw[aN]
                        end
                        local bD, bC = aS(bw[bA](O(bv, 1, bC - bA)))
                        bC = bC + bA - 1;
                        bB = 0;
                        for aN = bA, bC do
                            bB = bB + 1;
                            bw[aN] = bD[bB]
                        end
                        bt = bC
                    else
                        local bA = bg[2]
                        local bC = bt;
                        local bN = {}
                        local bB = 0;
                        for aN = bA, bC do
                            bB = bB + 1;
                            bN[bB] = bw[aN]
                        end
                        do
                            return O(bN, 1, bB)
                        end
                    end
                elseif bz <= 60 then
                    if bz <= 55 then
                        if bz <= 53 then
                            if bz == 52 then
                                bw[bg[2]] = #bw[bg[3]]
                            else
                                bm[bo[bg[3]]] = bw[bg[2]]
                            end
                        elseif bz > 54 then
                            local bM = bg[3]
                            local bO = bw[bM]
                            for aN = bM + 1, bg[5] do
                                bO = bO .. bw[aN]
                            end
                            bw[bg[2]] = bO
                        else
                            do
                                return
                            end
                        end
                    elseif bz <= 57 then
                        if bz == 56 then
                            bw[bg[2]] = bo[bg[3]]
                        else
                            bs = bs + bg[3]
                        end
                    elseif bz <= 58 then
                        bw[bg[2]] = bw[bg[3]] + bw[bg[5]]
                    elseif bz == 59 then
                        if bw[bg[2]] > bw[bg[5]] then
                            bs = bs + 1
                        else
                            bs = bs + bg[3]
                        end
                    else
                        bm[bo[bg[3]]] = bw[bg[2]]
                    end
                elseif bz <= 64 then
                    if bz <= 62 then
                        if bz > 61 then
                            local bM = bw[bg[3]]
                            if not bM then
                                bs = bs + 1
                            else
                                bw[bg[2]] = bM;
                                bs = bs + bn[bs + 1][3] + 1
                            end
                        else
                            if not bw[bg[2]] then
                                bs = bs + 1
                            else
                                bs = bs + bg[3]
                            end
                        end
                    elseif bz > 63 then
                        local bN;
                        local bD;
                        local bC;
                        local bB;
                        local bv;
                        local bA;
                        bw[bg[2]] = bm[bo[bg[3]]]
                        bs = bs + 1;
                        bg = bn[bs]
                        bw[bg[2]] = bw[bg[3]][bo[bg[5]]]
                        bs = bs + 1;
                        bg = bn[bs]
                        bw[bg[2]] = bm[bo[bg[3]]]
                        bs = bs + 1;
                        bg = bn[bs]
                        bw[bg[2]] = bw[bg[3]]
                        bs = bs + 1;
                        bg = bn[bs]
                        bw[bg[2]] = bo[bg[3]]
                        bs = bs + 1;
                        bg = bn[bs]
                        bA = bg[2]
                        bv = {}
                        bB = 0;
                        bC = bA + bg[3] - 1;
                        for aN = bA + 1, bC do
                            bB = bB + 1;
                            bv[bB] = bw[aN]
                        end
                        bD = {bw[bA](O(bv, 1, bC - bA))}
                        bC = bA + bg[5] - 2;
                        bB = 0;
                        for aN = bA, bC do
                            bB = bB + 1;
                            bw[aN] = bD[bB]
                        end
                        bt = bC;
                        bs = bs + 1;
                        bg = bn[bs]
                        bw[bg[2]] = bw[bg[3]] % bo[bg[5]]
                        bs = bs + 1;
                        bg = bn[bs]
                        bA = bg[2]
                        bv = {}
                        bC = bA + bg[3] - 1;
                        for aN = bA + 1, bC do
                            bv[#bv + 1] = bw[aN]
                        end
                        do
                            return bw[bA](O(bv, 1, bC - bA))
                        end
                        bs = bs + 1;
                        bg = bn[bs]
                        bA = bg[2]
                        bC = bt;
                        bN = {}
                        bB = 0;
                        for aN = bA, bC do
                            bB = bB + 1;
                            bN[bB] = bw[aN]
                        end
                        do
                            return O(bN, 1, bB)
                        end
                        bs = bs + 1;
                        bg = bn[bs]
                        do
                            return
                        end
                    else
                        bw[bg[2]] = bl[bg[3]]
                    end
                elseif bz <= 66 then
                    if bz > 65 then
                        local bA = bg[2]
                        local bP = bw[bA + 2]
                        local bQ = bw[bA] + bP;
                        bw[bA] = bQ;
                        if bP > 0 then
                            if bQ <= bw[bA + 1] then
                                bs = bs + bg[3]
                                bw[bA + 3] = bQ
                            end
                        elseif bQ >= bw[bA + 1] then
                            bs = bs + bg[3]
                            bw[bA + 3] = bQ
                        end
                    else
                        if not bw[bg[2]] then
                            bs = bs + 1
                        else
                            bs = bs + bg[3]
                        end
                    end
                elseif bz <= 67 then
                    bw[bg[2]] = bw[bg[3]][bo[bg[5]]]
                elseif bz == 68 then
                    do
                        return
                    end
                else
                    if bw[bg[2]] > bw[bg[5]] then
                        bs = bs + 1
                    else
                        bs = bs + bg[3]
                    end
                end
                bs = bs + 1
            end
        end
    end
    return bk(b7(), {}, N())()
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
a[27] = a[8][a[10] .. a[7]]("81BB7")
return (function(...)
    _G["ud7lqateqbhc0zhfok"] = nil
    _G["pd7lqyteqbhcozhl"] = false
    _G["q14yufbc7wqlzm0r"] = ""
    _G["qz4yufb791qlzmg0i"] = nil
    _G["cu3vft61qi8zvg0lfe"] = {nil, false}
    if _G["cu3vft61qi8zvg0lfe"][1] == true then
        _G["xiaoman"] = "luatool.cn"
    end
    _G["WR_Addon_Version"] = "20250331"
    _G["TestPlayerName"] = {
        [1] = "佳小萨",
        [2] = "佳小法",
        [3] = "佳小骑",
        [4] = "佳小猎",
        [5] = "佳小牧",
        [6] = "佳小德",
        [7] = "佳小战",
        [8] = "佳小贼",
        [9] = "佳小龙",
        [10] = "佳小僧",
        [11] = "佳小邪",
        [12] = "佳小术",
        [13] = "佳小烬"
    }
    local bR = _G["CreateFrame"]("Frame", "WOW-Robot")
    bR["SetScript"](bR, "OnUpdate", function(bS, bT)
        if _G["WR_LoginTime"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["WR_LoginTime"] = _G["GetTime"]()
        end
        if _G["WR_TemporaryTtopTime"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["WR_TemporaryTtopTime"] = 0.3
        end
        if _G["WR_StopTime"] == nil or _G["GetTime"]() - _G["WR_StopTime"] > _G["WR_TemporaryTtopTime"] then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["WR_StopTime"] = nil
            if _G["WR_LastTime"] == nil then
                _G["q14yufbc7wqlzm0r"] = ""
                _G["qz4yufb791qlzmg0i"] = nil
                _G["WR_LastTime"] = _G["GetTime"]()
            end
            if _G["WRSet"] ~= nil then
                if _G["ah0dy1wiqxzo3qjet"] == "" then
                    _G["ubpo"] = "xiaoman"
                end
                if _G["UnitClassBase"]("player") == "SHAMAN" and _G["GetSpecialization"]() == 2 then
                    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                        _G["wlx"] = "xiaoman.top"
                    end
                    if _G["WRSet"]["ZQ_CJGL"] ~= nil then
                        _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                        if _G["cu3vft61qi8zvg0lfe"][1] == true then
                            _G["xiaoman"] = "luatool.cn"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["ZQ_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "SHAMAN" and _G["GetSpecialization"]() == 3 then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    if _G["WRSet"]["HF_CJGL"] ~= nil then
                        _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                        if _G["cu3vft61qi8zvg0lfe"][1] == true then
                            _G["xiaoman"] = "luatool.cn"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["HF_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "PRIEST" and _G["GetSpecialization"]() == 1 then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    if _G["WRSet"]["JL_CJGL"] ~= nil then
                        _G["q14yufbc7wqlzm0r"] = ""
                        _G["qz4yufb791qlzmg0i"] = nil
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["JL_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "PRIEST" and _G["GetSpecialization"]() == 2 then
                    _G["qxw3iagfxbqp1ilz"] = function(bU)
                        _G["xm"] = "小满"
                        _G["xiao1man"](bU)
                    end;
                    if _G["WRSet"]["SS_CJGL"] ~= nil then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["SS_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "MONK" and _G["GetSpecialization"]() == 1 then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    if _G["WRSet"]["JX_CJGL"] ~= nil then
                        _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                        if _G["cu3vft61qi8zvg0lfe"][1] == true then
                            _G["xiaoman"] = "luatool.cn"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["JX_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "MONK" and _G["GetSpecialization"]() == 2 then
                    _G["fbak5vqu1idms9h"] = true
                    if _G["fbak5vqu1idms9h"] == "" then
                        _G["xiaoman1"] = 7
                    elseif _G["fbak5vqu1idms9h"] == nil then
                        _G["xiaoman2"] = 52
                    end
                    if _G["WRSet"]["ZW_CJGL"] ~= nil then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["ZW_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DRUID" and _G["GetSpecialization"]() == 1 then
                    if _G["ah0dy1wiqxzo3qjet"] == "" then
                        _G["ubpo"] = "xiaoman"
                    end
                    if _G["WRSet"]["PH_CJGL"] ~= nil then
                        _G["q14yufbc7wqlzm0r"] = ""
                        _G["qz4yufb791qlzmg0i"] = nil
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["PH_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DRUID" and _G["GetSpecialization"]() == 2 then
                    if _G["ah0dy1wiqxzo3qjet"] == "" then
                        _G["ubpo"] = "xiaoman"
                    end
                    if _G["WRSet"]["YX_CJGL"] ~= nil then
                        if _G["ah0dy1wiqxzo3qjet"] == "" then
                            _G["ubpo"] = "xiaoman"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["YX_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DRUID" and _G["GetSpecialization"]() == 3 then
                    if _G["ah0dy1wiqxzo3qjet"] == "" then
                        _G["ubpo"] = "xiaoman"
                    end
                    if _G["WRSet"]["SH_CJGL"] ~= nil then
                        if _G["ah0dy1wiqxzo3qjet"] == "" then
                            _G["ubpo"] = "xiaoman"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["SH_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DRUID" and _G["GetSpecialization"]() == 4 then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    if _G["WRSet"]["HF_CJGL"] ~= nil then
                        _G["ud7lqateqbhc0zhfok"] = nil
                        _G["pd7lqyteqbhcozhl"] = false
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["HF_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "MAGE" and _G["GetSpecialization"]() == 3 then
                    _G["q14yufbc7wqlzm0r"] = ""
                    _G["qz4yufb791qlzmg0i"] = nil
                    if _G["WRSet"]["BF_CJGL"] ~= nil then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["BF_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "MAGE" and _G["GetSpecialization"]() == 2 then
                    _G["qxw3iagfxbqp1ilz"] = function(bU)
                        _G["xm"] = "小满"
                        _G["xiao1man"](bU)
                    end;
                    if _G["WRSet"]["HF_CJGL"] ~= nil then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["HF_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "HUNTER" and _G["GetSpecialization"]() == 1 then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    if _G["WRSet"]["SW_CJGL"] ~= nil then
                        _G["q14yufbc7wqlzm0r"] = ""
                        _G["qz4yufb791qlzmg0i"] = nil
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["SW_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "HUNTER" and _G["GetSpecialization"]() == 3 then
                    _G["qxw3iagfxbqp1ilz"] = function(bU)
                        _G["xm"] = "小满"
                        _G["xiao1man"](bU)
                    end;
                    if _G["WRSet"]["SC_CJGL"] ~= nil then
                        _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                        if _G["cu3vft61qi8zvg0lfe"][1] == true then
                            _G["xiaoman"] = "luatool.cn"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["SC_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "ROGUE" and _G["GetSpecialization"]() == 1 then
                    _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                    if _G["cu3vft61qi8zvg0lfe"][1] == true then
                        _G["xiaoman"] = "luatool.cn"
                    end
                    if _G["WRSet"]["QX_CJGL"] ~= nil then
                        while "" == true do
                            _G["xiao0man"] = "enc"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["QX_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "ROGUE" and _G["GetSpecialization"]() == 3 then
                    _G["qxw3iagfxbqp1ilz"] = function(bU)
                        _G["xm"] = "小满"
                        _G["xiao1man"](bU)
                    end;
                    if _G["WRSet"]["MR_CJGL"] ~= nil then
                        _G["q14yufbc7wqlzm0r"] = ""
                        _G["qz4yufb791qlzmg0i"] = nil
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["MR_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "WARLOCK" and _G["GetSpecialization"]() == 2 then
                    _G["qxw3iagfxbqp1ilz"] = function(bU)
                        _G["xm"] = "小满"
                        _G["xiao1man"](bU)
                    end;
                    if _G["WRSet"]["EM_CJGL"] ~= nil then
                        _G["ud7lqateqbhc0zhfok"] = nil
                        _G["pd7lqyteqbhcozhl"] = false
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["EM_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "PALADIN" and _G["GetSpecialization"]() == 1 then
                    if _G["ah0dy1wiqxzo3qjet"] == "" then
                        _G["ubpo"] = "xiaoman"
                    end
                    if _G["WRSet"]["NQ_CJGL"] ~= nil then
                        while "" == true do
                            _G["xiao0man"] = "enc"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["NQ_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "PALADIN" and _G["GetSpecialization"]() == 2 then
                    _G["q14yufbc7wqlzm0r"] = ""
                    _G["qz4yufb791qlzmg0i"] = nil
                    if _G["WRSet"]["FQ_CJGL"] ~= nil then
                        _G["ud7lqateqbhc0zhfok"] = nil
                        _G["pd7lqyteqbhcozhl"] = false
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["FQ_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "PALADIN" and _G["GetSpecialization"]() == 3 then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    if _G["WRSet"]["CJQ_CJGL"] ~= nil then
                        while "" == true do
                            _G["xiao0man"] = "enc"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["CJQ_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "WARRIOR" and _G["GetSpecialization"]() == 2 then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    if _G["WRSet"]["KBZ_CJGL"] ~= nil then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["KBZ_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "WARRIOR" and _G["GetSpecialization"]() == 3 then
                    if _G["ah0dy1wiqxzo3qjet"] == "" then
                        _G["ubpo"] = "xiaoman"
                    end
                    if _G["WRSet"]["FZ_CJGL"] ~= nil then
                        _G["fbak5vqu1idms9h"] = true
                        if _G["fbak5vqu1idms9h"] == "" then
                            _G["xiaoman1"] = 7
                        elseif _G["fbak5vqu1idms9h"] == nil then
                            _G["xiaoman2"] = 52
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["FZ_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DEATHKNIGHT" and _G["GetSpecialization"]() == 1 then
                    _G["fbak5vqu1idms9h"] = true
                    if _G["fbak5vqu1idms9h"] == "" then
                        _G["xiaoman1"] = 7
                    elseif _G["fbak5vqu1idms9h"] == nil then
                        _G["xiaoman2"] = 52
                    end
                    if _G["WRSet"]["XX_CJGL"] ~= nil then
                        if _G["ah0dy1wiqxzo3qjet"] == "" then
                            _G["ubpo"] = "xiaoman"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["XX_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DEATHKNIGHT" and _G["GetSpecialization"]() == 2 then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    if _G["WRSet"]["BS_CJGL"] ~= nil then
                        if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                            _G["wlx"] = "xiaoman.top"
                        end
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["BS_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "EVOKER" and _G["GetSpecialization"]() == 3 then
                    _G["q14yufbc7wqlzm0r"] = ""
                    _G["qz4yufb791qlzmg0i"] = nil
                    if _G["WRSet"]["ZH_CJGL"] ~= nil then
                        _G["q14yufbc7wqlzm0r"] = ""
                        _G["qz4yufb791qlzmg0i"] = nil
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["ZH_CJGL"] * 0.05
                    end
                elseif _G["UnitClassBase"]("player") == "DEMONHUNTER" and _G["GetSpecialization"]() == 2 then
                    _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                    if _G["cu3vft61qi8zvg0lfe"][1] == true then
                        _G["xiaoman"] = "luatool.cn"
                    end
                    if _G["WRSet"]["FC_CJGL"] ~= nil then
                        _G["qxw3iagfxbqp1ilz"] = function(bU)
                            _G["xm"] = "小满"
                            _G["xiao1man"](bU)
                        end;
                        _G["WR_Delay"] = 0.05 + _G["WRSet"]["FC_CJGL"] * 0.05
                    end
                end
            end
            if _G["WR_Delay"] == nil then
                if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                    _G["wlx"] = "xiaoman.top"
                end
                _G["WR_Delay"] = 0.1
            end
            if _G["GetTime"]() - _G["WR_LastTime"] > _G["WR_Delay"] and _G["WR_Startup"] then
                _G["qxw3iagfxbqp1ilz"] = function(bU)
                    _G["xm"] = "小满"
                    _G["xiao1man"](bU)
                end;
                if _G["UnitClassBase"]("player") == "MAGE" then
                    _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                    if _G["cu3vft61qi8zvg0lfe"][1] == true then
                        _G["xiaoman"] = "luatool.cn"
                    end
                    _G["WR_Mage"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "HUNTER" then
                    _G["q14yufbc7wqlzm0r"] = ""
                    _G["qz4yufb791qlzmg0i"] = nil
                    _G["WR_Hunter"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "ROGUE" then
                    _G["qxw3iagfxbqp1ilz"] = function(bU)
                        _G["xm"] = "小满"
                        _G["xiao1man"](bU)
                    end;
                    _G["WR_Rogue"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "SHAMAN" then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    _G["WR_Shaman"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "WARRIOR" then
                    _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                    if _G["cu3vft61qi8zvg0lfe"][1] == true then
                        _G["xiaoman"] = "luatool.cn"
                    end
                    _G["WR_Warrior"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "EVOKER" then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    _G["WR_Evoker"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "WARLOCK" then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    _G["WR_Warlock"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "DEATHKNIGHT" then
                    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                        _G["wlx"] = "xiaoman.top"
                    end
                    _G["WR_DeathKnight"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "PRIEST" then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    _G["WR_Priest"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "MONK" then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    _G["WR_Monk"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "PALADIN" then
                    _G["fbak5vqu1idms9h"] = true
                    if _G["fbak5vqu1idms9h"] == "" then
                        _G["xiaoman1"] = 7
                    elseif _G["fbak5vqu1idms9h"] == nil then
                        _G["xiaoman2"] = 52
                    end
                    _G["WR_Paladin"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "DRUID" then
                    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                        _G["wlx"] = "xiaoman.top"
                    end
                    _G["WR_Druid"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                elseif _G["UnitClassBase"]("player") == "DEMONHUNTER" then
                    _G["fbak5vqu1idms9h"] = true
                    if _G["fbak5vqu1idms9h"] == "" then
                        _G["xiaoman1"] = 7
                    elseif _G["fbak5vqu1idms9h"] == nil then
                        _G["xiaoman2"] = 52
                    end
                    _G["WR_DemonHunter"]()
                    _G["WR_LastTime"] = _G["GetTime"]()
                end
            end
            for bV, bW in _G["ipairs"](_G["TestPlayerName"]) do
                if _G["UnitName"]("player") == bW then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    _G["WR_EventNotifications"]()
                    if _G["WR_TestCheckbox"] ~= nil then
                        _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                        if _G["cu3vft61qi8zvg0lfe"][1] == true then
                            _G["xiaoman"] = "luatool.cn"
                        end
                        _G["WR_TestCheckbox"]["SetChecked"](_G["WR_TestCheckbox"], "true")
                    end
                    break
                end
            end
            _G["WR_HidePlayerNotFound"]()
            if _G["WR_TestCheckbox"] ~= nil and _G["WR_TestCheckbox"]["GetChecked"](_G["WR_TestCheckbox"]) == true then
                _G["ud7lqateqbhc0zhfok"] = nil
                _G["pd7lqyteqbhcozhl"] = false
                _G["WR_MaxColorFrame"]()
            else
                if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                    _G["wlx"] = "xiaoman.top"
                end
                _G["WR_MinColorFrame"]()
            end
        end
    end)
end)()
