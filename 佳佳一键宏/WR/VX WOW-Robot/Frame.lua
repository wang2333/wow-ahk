local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 65;
    local c = 95;
    local d = 83;
    local e = 77;
    local f = 69;
    local g = 44;
    local h = 95;
    local i = 71;
    local j = 60;
    local k = "g"
    local l = "m"
    local m = "n"
    local n = "a"
    local o = "b"
    local p = "p"
    local q = "r"
    local r = "s"
    local s = "t"
    local t = "c"
    local u = "o"
    local v = "u"
    local w = "h"
    local x = "d"
    local y = "e"
    local z = "i"
    local A = "k"
    local B = "l"
    local C = "y"
    local D = "w"
    local E = a[8][s .. n .. o .. B .. y][t .. u .. m .. t .. n .. s]
    local F = a[8][l .. n .. s .. w][B .. x .. y .. a[2] .. p] or a[8][l .. n .. s .. w][r .. t .. n .. B .. y]
    local G = r .. s .. q .. z .. m .. k;
    local H = a[8][r .. y .. s .. l .. y .. s .. n .. s .. n .. o .. B .. y]
    local I = a[8][G][r .. v .. o]
    local J = a[8][G][t .. w .. n .. q]
    local K = a[8][r .. y .. B .. y .. t .. s]
    local L = a[8][G][o .. C .. s .. y]
    local M = function()
        return a[8]
    end;
    local N = a[8][s .. n .. o .. B .. y][v .. m .. p .. n .. t .. A] or a[8][v .. m .. p .. n .. t .. A]
    local O = a[8][G][k .. r .. v .. o]
    local P = a[8][s .. u .. m .. v .. l .. o .. y .. q]
    local function Q(R)
        local S, T, U = "", "", {}
        local V = 256;
        local W = {}
        if R == q then
            return T
        end
        for X = 0, V - 1 do
            W[X] = J(X)
        end
        local Y = 1;
        local function Z()
            local _ = P(I(R, Y, Y), 36)
            Y = Y + 1;
            local a0 = P(I(R, Y, Y + _ - 1), 36)
            Y = Y + _;
            return a0
        end
        S = J(Z())
        U[1] = S;
        while Y < #R do
            local a1 = Z()
            if W[a1] then
                T = W[a1]
            else
                T = S .. I(S, 1, 1)
            end
            W[V] = S .. I(T, 1, 1)
            U[#U + 1], S, V = T, T, V + 1
        end
        return E(U)
    end
    local a2 = a[10]
    local a3 = a[8][o .. z .. s] and a[8][o .. z .. s][o .. a[2] .. u .. q] or function(a4, R)
        local a5, S = 1, 0;
        while a4 > 0 and R > 0 do
            local a6, a7 = a4 % 2, R % 2;
            if a6 ~= a7 then
                S = S + a5
            end
            a4, R, a5 = (a4 - a6) / 2, (R - a7) / 2, a5 * 2
        end
        if a4 < R then
            a4 = R
        end
        while a4 > 0 do
            local a6 = a4 % 2;
            if a6 > 0 then
                S = S + a5
            end
            a4, a5 = (a4 - a6) / 2, a5 * 2
        end
        return S
    end;
    local a8 = a2 .. a[15]
    local a9 = M()
    local aa = a2 .. a[5]
    local function ab(ac, ad, ae)
        if ae then
            local af = ac / 2 ^ (ad - 1) % 2 ^ (ae - 1 - (ad - 1) + 1)
            return af - af % 1
        else
            local ag = 2 ^ (ad - 1)
            return ac % (ag + ag) >= ag and 1 or 0
        end
    end
    local ah = a2 .. a[9]
    local ai = 1;
    local aj = a2 .. a[14]
    local ak = Q(q)
    local al = a2 .. a[1]
    local function am()
        local an, ao, ap, aq = L(ak, ai, ai + 3)
        an = a3(an, 156)
        ao = a3(ao, 156)
        ap = a3(ap, 156)
        aq = a3(aq, 156)
        ai = ai + 4;
        return aq * 16777216 + ap * 65536 + ao * 256 + an
    end
    local ar = a2 .. a[19]
    local as = Q(m .. a[4] .. s)
    local function at()
        local au = a3(L(ak, ai, ai), 156)
        ai = ai + 1;
        return au
    end
    local av = a[8][a[10]]
    local aw = a2 .. a[7]
    local function ax()
        local ay = am()
        local az = am()
        local aA = 1;
        local aB = ab(az, 1, 20) * 2 ^ 32 + ay;
        local aC = ab(az, 21, 31)
        local aD = (-1) ^ ab(az, 32)
        if aC == 0 then
            if aB == 0 then
                return aD * 0
            else
                aC = 1;
                aA = 0
            end
        elseif aC == 2047 then
            return aB == 0 and aD * 1 / 0 or aD * 0 / 0
        end
        return F(aD, aC - 1023) * (aA + aB / 2 ^ 52)
    end
    local aE = a[12]
    local aF = as == a[17]
    local aG = a2 .. a[11]
    local aH = am;
    local function aI(aJ)
        local aK;
        if not aJ then
            aJ = aH()
            if aJ == 0 then
                return ""
            end
        end
        aK = I(ak, ai, ai + aJ - 1)
        ai = ai + aJ;
        local aL = {}
        for aM = 1, #aK do
            aL[aM] = J(a3(L(I(aK, aM, aM)), 156))
        end
        return E(aL)
    end
    local aN = a2 .. a[4]
    local aO = am;
    local aP = as == y;
    local aQ = a[3]
    local function aR(...)
        return {...}, K("#", ...)
    end
    local function aS(aT, aU, aV)
        local function aW(X, aX)
            local aY = ak;
            for Y = 1, #aX do
                local S = L(aX, Y, Y) - (X + Y) % 256;
                if S < 0 then
                    S = S + 256
                end
                aY = aY .. J(S)
            end
            return aY
        end
        local function aZ(a_)
            return O(a_, '..', function(b0)
                return J(P(b0, 16) % 256)
            end)
        end
        a9[aj] = function(b1)
            return ax() .. b1
        end;
        a9[ah] = function(b2, b3)
            return P(aW(b2, aZ(b3)))
        end;
        a9[aN] = function()
            return av
        end;
        a9[a8] = function()
            return ak
        end;
        a9[aG] = function(b4, b5)
            return aW(b4, aZ(b5))
        end;
        a9[al] = function()
            return aP
        end;
        a9[aa] = function()
            return aU
        end;
        a9[aw] = function(Z)
            local X = 0;
            for Y = 1, #Z do
                X = X + L(Z, Y, Y)
            end
            return X
        end;
        a9[ar] = function()
            return aF
        end;
        return aZ(aT .. aV)
    end
    local function b6()
        local b7 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0}
        local b8 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local b9 = {}
        local ba = {b7, nil, b8, nil, b9}
        if B ~= m then
            return b8
        end
        ba[4] = at()
        for aM = 1, am() do
            local bb = a3(am(), 182)
            local bc = a3(am(), 119)
            local bd = ab(bb, 1, 2)
            local be = ab(bc, 1, 11)
            local bf = {be, ab(bb, 3, 11), nil, nil, bc}
            if bd == 0 then
                bf[3] = ab(bb, 12, 20)
                bf[5] = ab(bb, 21, 29)
            elseif bd == 1 then
                bf[3] = ab(bc, 12, 33)
            elseif bd == 2 then
                bf[3] = ab(bc, 12, 32) - 1048575
            elseif bd == 3 then
                bf[3] = ab(bc, 12, 32) - 1048575;
                bf[5] = ab(bb, 21, 29)
            end
            b7[aM] = bf
        end
        local bg = am()
        local bh = {0, 0, 0, 0, 0, 0, 0}
        for aM = 1, bg do
            local bd = at()
            local bi;
            if bd == 1 then
                bi = at() ~= 0
            elseif bd == 2 then
                bi = ax()
            elseif bd == 0 then
                bi = aI()
            end
            bh[aM] = bi
        end
        ba[2] = bh;
        for aM = 1, am() do
            b8[aM - 1] = b6()
        end
        return ba
    end
    local function bj(ba, bk, bl)
        local bm = ba[1]
        local bn = ba[2]
        local bo = ba[3]
        local bp = ba[4]
        return function(...)
            local bm = bm;
            local bn = bn;
            local bo = bo;
            local bp = bp;
            local bq = aS(aQ, a9, aE)
            local aR = aR;
            local br = 1;
            local bs = -1;
            if as ~= A then
                return br
            end
            local bt = {}
            local bu = {...}
            local bv = {}
            local bw = K("#", ...) - 1;
            for aM = 0, bw do
                if aM >= bp then
                    bt[aM - bp] = bu[aM + 1]
                else
                    bv[aM] = bu[aM + 1]
                end
            end
            local bx = bw - bp + 1;
            local bf;
            local by;
            while true do
                bf = bm[br]
                by = bf[1]
                if by <= 34 then
                    if by <= 16 then
                        if by <= 7 then
                            if by <= 3 then
                                if by <= 1 then
                                    if by == 0 then
                                        bv[bf[2]] = bv[bf[3]] + bn[bf[5]]
                                    else
                                        local bz = bf[2]
                                        local bu = {}
                                        local bA = 0;
                                        local bB = bz + bf[3] - 1;
                                        for aM = bz + 1, bB do
                                            bA = bA + 1;
                                            bu[bA] = bv[aM]
                                        end
                                        local bC = {bv[bz](N(bu, 1, bB - bz))}
                                        local bB = bz + bf[5] - 2;
                                        bA = 0;
                                        for aM = bz, bB do
                                            bA = bA + 1;
                                            bv[aM] = bC[bA]
                                        end
                                        bs = bB
                                    end
                                elseif by == 2 then
                                    local bD = bo[bf[3]]
                                    local bE;
                                    local bF = {}
                                    bE = H({}, {
                                        [a[16] .. a[16] .. z .. m .. x .. y .. a[2]] = function(bG, bH)
                                            local bI = bF[bH]
                                            return bI[1][bI[2]]
                                        end,
                                        [a[16] .. a[16] .. m .. y .. D .. z .. m .. x .. y .. a[2]] = function(bG, bH,
                                            bJ)
                                            local bI = bF[bH]
                                            bI[1][bI[2]] = bJ
                                        end
                                    })
                                    for aM = 1, bf[5] do
                                        br = br + 1;
                                        local bK = bm[br]
                                        if bK[1] == 7 then
                                            bF[aM - 1] = {bv, bK[3]}
                                        else
                                            bF[aM - 1] = {bk, bK[3]}
                                        end
                                        bq[#bq + 1] = bF
                                    end
                                    bv[bf[2]] = bj(bD, bE, bl)
                                else
                                    local bz = bf[2]
                                    local bL = bv[bf[3]]
                                    bv[bz + 1] = bL;
                                    bv[bz] = bL[bn[bf[5]]]
                                end
                            elseif by <= 5 then
                                if by > 4 then
                                    local bz;
                                    bv[bf[2]] = bn[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = #bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bn[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = #bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bn[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bv[bz] = bv[bz] - bv[bz + 2]
                                    br = br + bf[3]
                                else
                                    local bM;
                                    local bC, bB;
                                    local bB;
                                    local bA;
                                    local bu;
                                    local bz;
                                    bv[bf[2]] = bl[bn[bf[3]]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bk[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bk[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bu = {}
                                    bA = 0;
                                    bB = bz + bf[3] - 1;
                                    for aM = bz + 1, bB do
                                        bA = bA + 1;
                                        bu[bA] = bv[aM]
                                    end
                                    bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                                    bB = bB + bz - 1;
                                    bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bv[aM] = bC[bA]
                                    end
                                    bs = bB;
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bu = {}
                                    bA = 0;
                                    bB = bs;
                                    for aM = bz + 1, bB do
                                        bA = bA + 1;
                                        bu[bA] = bv[aM]
                                    end
                                    bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                                    bB = bB + bz - 1;
                                    bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bv[aM] = bC[bA]
                                    end
                                    bs = bB;
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bu = {}
                                    bB = bs;
                                    for aM = bz + 1, bB do
                                        bu[#bu + 1] = bv[aM]
                                    end
                                    do
                                        return bv[bz](N(bu, 1, bB - bz))
                                    end
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bB = bs;
                                    bM = {}
                                    bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bM[bA] = bv[aM]
                                    end
                                    do
                                        return N(bM, 1, bA)
                                    end
                                    br = br + 1;
                                    bf = bm[br]
                                    do
                                        return
                                    end
                                end
                            elseif by > 6 then
                                bv[bf[2]] = bv[bf[3]]
                            else
                                br = br + bf[3]
                            end
                        elseif by <= 11 then
                            if by <= 9 then
                                if by == 8 then
                                    bv[bf[2]] = bl[bn[bf[3]]]
                                else
                                    local bL;
                                    local bC;
                                    local bB;
                                    local bA;
                                    local bu;
                                    local bz;
                                    bv[bf[2]] = bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bu = {}
                                    bA = 0;
                                    bB = bz + bf[3] - 1;
                                    for aM = bz + 1, bB do
                                        bA = bA + 1;
                                        bu[bA] = bv[aM]
                                    end
                                    bC = {bv[bz](N(bu, 1, bB - bz))}
                                    bB = bz + bf[5] - 2;
                                    bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bv[aM] = bC[bA]
                                    end
                                    bs = bB;
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]] + bv[bf[5]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]] % bn[bf[5]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bL = bv[bf[3]]
                                    bv[bz + 1] = bL;
                                    bv[bz] = bL[bn[bf[5]]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bv[bf[2]] = bv[bf[3]]
                                    br = br + 1;
                                    bf = bm[br]
                                    bz = bf[2]
                                    bu = {}
                                    bA = 0;
                                    bB = bz + bf[3] - 1;
                                    for aM = bz + 1, bB do
                                        bA = bA + 1;
                                        bu[bA] = bv[aM]
                                    end
                                    bC = {bv[bz](N(bu, 1, bB - bz))}
                                    bB = bz + bf[5] - 2;
                                    bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bv[aM] = bC[bA]
                                    end
                                    bs = bB;
                                    br = br + 1;
                                    bf = bm[br]
                                    if bv[bf[2]] > bv[bf[5]] then
                                        br = br + 1
                                    else
                                        br = br + bf[3]
                                    end
                                end
                            elseif by > 10 then
                                local bL = bv[bf[3]]
                                if not bL then
                                    br = br + 1
                                else
                                    bv[bf[2]] = bL;
                                    br = br + bm[br + 1][3] + 1
                                end
                            else
                                local bM;
                                local bC, bB;
                                local bB;
                                local bA;
                                local bu;
                                local bz;
                                bv[bf[2]] = bk[bf[3]]
                                br = br + 1;
                                bf = bm[br]
                                bv[bf[2]] = bv[bf[3]]
                                br = br + 1;
                                bf = bm[br]
                                bv[bf[2]] = bk[bf[3]]
                                br = br + 1;
                                bf = bm[br]
                                bv[bf[2]] = bv[bf[3]]
                                br = br + 1;
                                bf = bm[br]
                                bz = bf[2]
                                bu = {}
                                bA = 0;
                                bB = bz + bf[3] - 1;
                                for aM = bz + 1, bB do
                                    bA = bA + 1;
                                    bu[bA] = bv[aM]
                                end
                                bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                                bB = bB + bz - 1;
                                bA = 0;
                                for aM = bz, bB do
                                    bA = bA + 1;
                                    bv[aM] = bC[bA]
                                end
                                bs = bB;
                                br = br + 1;
                                bf = bm[br]
                                bz = bf[2]
                                bu = {}
                                bB = bs;
                                for aM = bz + 1, bB do
                                    bu[#bu + 1] = bv[aM]
                                end
                                do
                                    return bv[bz](N(bu, 1, bB - bz))
                                end
                                br = br + 1;
                                bf = bm[br]
                                bz = bf[2]
                                bB = bs;
                                bM = {}
                                bA = 0;
                                for aM = bz, bB do
                                    bA = bA + 1;
                                    bM[bA] = bv[aM]
                                end
                                do
                                    return N(bM, 1, bA)
                                end
                                br = br + 1;
                                bf = bm[br]
                                do
                                    return
                                end
                            end
                        elseif by <= 13 then
                            if by == 12 then
                                bv[bf[2]] = bf[3] ~= 0
                            else
                                local bz = bf[2]
                                local bu = {}
                                local bB = bs;
                                for aM = bz + 1, bB do
                                    bu[#bu + 1] = bv[aM]
                                end
                                do
                                    return bv[bz](N(bu, 1, bB - bz))
                                end
                            end
                        elseif by <= 14 then
                            local bz = bf[2]
                            local bu = {}
                            local bA = 0;
                            local bB = bz + bf[3] - 1;
                            for aM = bz + 1, bB do
                                bA = bA + 1;
                                bu[bA] = bv[aM]
                            end
                            local bC = {bv[bz](N(bu, 1, bB - bz))}
                            local bB = bz + bf[5] - 2;
                            bA = 0;
                            for aM = bz, bB do
                                bA = bA + 1;
                                bv[aM] = bC[bA]
                            end
                            bs = bB
                        elseif by == 15 then
                            bv[bf[2]] = bv[bf[3]] % bv[bf[5]]
                        else
                            local bz = bf[2]
                            local bu = {}
                            local bA = 0;
                            local bB = bz + bf[3] - 1;
                            for aM = bz + 1, bB do
                                bA = bA + 1;
                                bu[bA] = bv[aM]
                            end
                            local bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                            bB = bB + bz - 1;
                            bA = 0;
                            for aM = bz, bB do
                                bA = bA + 1;
                                bv[aM] = bC[bA]
                            end
                            bs = bB
                        end
                    elseif by <= 25 then
                        if by <= 20 then
                            if by <= 18 then
                                if by > 17 then
                                    local bz = bf[2]
                                    local bu = {}
                                    local bB = bs;
                                    for aM = bz + 1, bB do
                                        bu[#bu + 1] = bv[aM]
                                    end
                                    do
                                        return bv[bz](N(bu, 1, bB - bz))
                                    end
                                else
                                    bv[bf[2]] = bv[bf[3]] + bn[bf[5]]
                                end
                            elseif by == 19 then
                                local bN;
                                local bL;
                                local bC;
                                local bB;
                                local bA;
                                local bu;
                                local bz;
                                bv[bf[2]] = bl[bn[bf[3]]]
                                br = br + 1;
                                bf = bm[br]
                                bv[bf[2]] = bv[bf[3]][bn[bf[5]]]
                                br = br + 1;
                                bf = bm[br]
                                bv[bf[2]] = bv[bf[3]]
                                br = br + 1;
                                bf = bm[br]
                                bz = bf[2]
                                bu = {}
                                bA = 0;
                                bB = bz + bf[3] - 1;
                                for aM = bz + 1, bB do
                                    bA = bA + 1;
                                    bu[bA] = bv[aM]
                                end
                                bC = {bv[bz](N(bu, 1, bB - bz))}
                                bB = bz + bf[5] - 2;
                                bA = 0;
                                for aM = bz, bB do
                                    bA = bA + 1;
                                    bv[aM] = bC[bA]
                                end
                                bs = bB;
                                br = br + 1;
                                bf = bm[br]
                                bL = bf[3]
                                bN = bv[bL]
                                for aM = bL + 1, bf[5] do
                                    bN = bN .. bv[aM]
                                end
                                bv[bf[2]] = bN
                            else
                                bv[bf[2]] = bk[bf[3]]
                            end
                        elseif by <= 22 then
                            if by == 21 then
                                local bz = bf[2]
                                bv[bz] = bv[bz] - bv[bz + 2]
                                br = br + bf[3]
                            else
                                local bD = bo[bf[3]]
                                local bE;
                                local bF = {}
                                bE = H({}, {
                                    [a[16] .. a[16] .. z .. m .. x .. y .. a[2]] = function(bG, bH)
                                        local bI = bF[bH]
                                        return bI[1][bI[2]]
                                    end,
                                    [a[16] .. a[16] .. m .. y .. D .. z .. m .. x .. y .. a[2]] = function(bG, bH, bJ)
                                        local bI = bF[bH]
                                        bI[1][bI[2]] = bJ
                                    end
                                })
                                for aM = 1, bf[5] do
                                    br = br + 1;
                                    local bK = bm[br]
                                    if bK[1] == 7 then
                                        bF[aM - 1] = {bv, bK[3]}
                                    else
                                        bF[aM - 1] = {bk, bK[3]}
                                    end
                                    bq[#bq + 1] = bF
                                end
                                bv[bf[2]] = bj(bD, bE, bl)
                            end
                        elseif by <= 23 then
                            bv[bf[2]] = bl[bn[bf[3]]]
                        elseif by == 24 then
                            bv[bf[2]] = bv[bf[3]] % bv[bf[5]]
                        else
                            bv[bf[2]] = bv[bf[3]][bn[bf[5]]]
                        end
                    elseif by <= 29 then
                        if by <= 27 then
                            if by == 26 then
                                local bL = bf[3]
                                local bN = bv[bL]
                                for aM = bL + 1, bf[5] do
                                    bN = bN .. bv[aM]
                                end
                                bv[bf[2]] = bN
                            else
                                bv[bf[2]] = bv[bf[3]] + bv[bf[5]]
                            end
                        elseif by == 28 then
                            bv[bf[2]] = bj(bo[bf[3]], nil, bl)
                        else
                            local bz = bf[2]
                            local bu = {}
                            local bB = bz + bf[3] - 1;
                            for aM = bz + 1, bB do
                                bu[#bu + 1] = bv[aM]
                            end
                            do
                                return bv[bz](N(bu, 1, bB - bz))
                            end
                        end
                    elseif by <= 31 then
                        if by == 30 then
                            bv[bf[2]] = bv[bf[3]]
                        else
                            bv[bf[2]] = bv[bf[3]] % bn[bf[5]]
                        end
                    elseif by <= 32 then
                        local bz = bf[2]
                        bv[bz] = bv[bz] - bv[bz + 2]
                        br = br + bf[3]
                    elseif by == 33 then
                        bv[bf[2]] = #bv[bf[3]]
                    else
                        if bv[bf[2]] == bn[bf[5]] then
                            br = br + 1
                        else
                            br = br + bf[3]
                        end
                    end
                elseif by <= 51 then
                    if by <= 42 then
                        if by <= 38 then
                            if by <= 36 then
                                if by > 35 then
                                    local bz = bf[2]
                                    local bu = {}
                                    local bA = 0;
                                    local bB = bz + bf[3] - 1;
                                    for aM = bz + 1, bB do
                                        bA = bA + 1;
                                        bu[bA] = bv[aM]
                                    end
                                    local bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                                    bB = bB + bz - 1;
                                    bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bv[aM] = bC[bA]
                                    end
                                    bs = bB
                                else
                                    local bz = bf[2]
                                    local bB = bs;
                                    local bM = {}
                                    local bA = 0;
                                    for aM = bz, bB do
                                        bA = bA + 1;
                                        bM[bA] = bv[aM]
                                    end
                                    do
                                        return N(bM, 1, bA)
                                    end
                                end
                            elseif by == 37 then
                                bv[bf[2]] = bj(bo[bf[3]], nil, bl)
                            else
                                bv[bf[2]] = bn[bf[3]]
                            end
                        elseif by <= 40 then
                            if by > 39 then
                                local bz = bf[2]
                                local bu = {}
                                local bA = 0;
                                local bB = bs;
                                for aM = bz + 1, bB do
                                    bA = bA + 1;
                                    bu[bA] = bv[aM]
                                end
                                local bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                                bB = bB + bz - 1;
                                bA = 0;
                                for aM = bz, bB do
                                    bA = bA + 1;
                                    bv[aM] = bC[bA]
                                end
                                bs = bB
                            else
                                bv[bf[2]] = bv[bf[3]] - bv[bf[5]]
                            end
                        elseif by == 41 then
                            local bz = bf[2]
                            local bO = bv[bz + 2]
                            local bP = bv[bz] + bO;
                            bv[bz] = bP;
                            if bO > 0 then
                                if bP <= bv[bz + 1] then
                                    br = br + bf[3]
                                    bv[bz + 3] = bP
                                end
                            elseif bP >= bv[bz + 1] then
                                br = br + bf[3]
                                bv[bz + 3] = bP
                            end
                        else
                            if bv[bf[2]] == bn[bf[5]] then
                                br = br + 1
                            else
                                br = br + bf[3]
                            end
                        end
                    elseif by <= 46 then
                        if by <= 44 then
                            if by > 43 then
                                bv[bf[2]] = bf[3] ~= 0
                            else
                                local bz = bf[2]
                                local bB = bz + bf[3] - 2;
                                local bM = {}
                                local bA = 0;
                                for aM = bz, bB do
                                    bA = bA + 1;
                                    bM[bA] = bv[aM]
                                end
                                do
                                    return N(bM, 1, bA)
                                end
                            end
                        elseif by == 45 then
                            local bz = bf[2]
                            local bB = bz + bf[3] - 2;
                            local bM = {}
                            local bA = 0;
                            for aM = bz, bB do
                                bA = bA + 1;
                                bM[bA] = bv[aM]
                            end
                            do
                                return N(bM, 1, bA)
                            end
                        else
                            bv[bf[2]] = bv[bf[3]] % bn[bf[5]]
                        end
                    elseif by <= 48 then
                        if by == 47 then
                            local bz = bf[2]
                            local bL = bv[bf[3]]
                            bv[bz + 1] = bL;
                            bv[bz] = bL[bn[bf[5]]]
                        else
                            local bz = bf[2]
                            local bu = {}
                            local bB = bz + bf[3] - 1;
                            for aM = bz + 1, bB do
                                bu[#bu + 1] = bv[aM]
                            end
                            do
                                return bv[bz](N(bu, 1, bB - bz))
                            end
                        end
                    elseif by <= 49 then
                        bv[bf[2]] = bv[bf[3]] - bv[bf[5]]
                    elseif by > 50 then
                        local bz = bf[2]
                        local bu = {}
                        local bA = 0;
                        local bB = bs;
                        for aM = bz + 1, bB do
                            bA = bA + 1;
                            bu[bA] = bv[aM]
                        end
                        local bC, bB = aR(bv[bz](N(bu, 1, bB - bz)))
                        bB = bB + bz - 1;
                        bA = 0;
                        for aM = bz, bB do
                            bA = bA + 1;
                            bv[aM] = bC[bA]
                        end
                        bs = bB
                    else
                        local bz = bf[2]
                        local bB = bs;
                        local bM = {}
                        local bA = 0;
                        for aM = bz, bB do
                            bA = bA + 1;
                            bM[bA] = bv[aM]
                        end
                        do
                            return N(bM, 1, bA)
                        end
                    end
                elseif by <= 60 then
                    if by <= 55 then
                        if by <= 53 then
                            if by == 52 then
                                bv[bf[2]] = #bv[bf[3]]
                            else
                                bl[bn[bf[3]]] = bv[bf[2]]
                            end
                        elseif by > 54 then
                            local bL = bf[3]
                            local bN = bv[bL]
                            for aM = bL + 1, bf[5] do
                                bN = bN .. bv[aM]
                            end
                            bv[bf[2]] = bN
                        else
                            do
                                return
                            end
                        end
                    elseif by <= 57 then
                        if by == 56 then
                            bv[bf[2]] = bn[bf[3]]
                        else
                            br = br + bf[3]
                        end
                    elseif by <= 58 then
                        bv[bf[2]] = bv[bf[3]] + bv[bf[5]]
                    elseif by == 59 then
                        if bv[bf[2]] > bv[bf[5]] then
                            br = br + 1
                        else
                            br = br + bf[3]
                        end
                    else
                        bl[bn[bf[3]]] = bv[bf[2]]
                    end
                elseif by <= 64 then
                    if by <= 62 then
                        if by > 61 then
                            local bL = bv[bf[3]]
                            if not bL then
                                br = br + 1
                            else
                                bv[bf[2]] = bL;
                                br = br + bm[br + 1][3] + 1
                            end
                        else
                            if not bv[bf[2]] then
                                br = br + 1
                            else
                                br = br + bf[3]
                            end
                        end
                    elseif by > 63 then
                        local bM;
                        local bC;
                        local bB;
                        local bA;
                        local bu;
                        local bz;
                        bv[bf[2]] = bl[bn[bf[3]]]
                        br = br + 1;
                        bf = bm[br]
                        bv[bf[2]] = bv[bf[3]][bn[bf[5]]]
                        br = br + 1;
                        bf = bm[br]
                        bv[bf[2]] = bl[bn[bf[3]]]
                        br = br + 1;
                        bf = bm[br]
                        bv[bf[2]] = bv[bf[3]]
                        br = br + 1;
                        bf = bm[br]
                        bv[bf[2]] = bn[bf[3]]
                        br = br + 1;
                        bf = bm[br]
                        bz = bf[2]
                        bu = {}
                        bA = 0;
                        bB = bz + bf[3] - 1;
                        for aM = bz + 1, bB do
                            bA = bA + 1;
                            bu[bA] = bv[aM]
                        end
                        bC = {bv[bz](N(bu, 1, bB - bz))}
                        bB = bz + bf[5] - 2;
                        bA = 0;
                        for aM = bz, bB do
                            bA = bA + 1;
                            bv[aM] = bC[bA]
                        end
                        bs = bB;
                        br = br + 1;
                        bf = bm[br]
                        bv[bf[2]] = bv[bf[3]] % bn[bf[5]]
                        br = br + 1;
                        bf = bm[br]
                        bz = bf[2]
                        bu = {}
                        bB = bz + bf[3] - 1;
                        for aM = bz + 1, bB do
                            bu[#bu + 1] = bv[aM]
                        end
                        do
                            return bv[bz](N(bu, 1, bB - bz))
                        end
                        br = br + 1;
                        bf = bm[br]
                        bz = bf[2]
                        bB = bs;
                        bM = {}
                        bA = 0;
                        for aM = bz, bB do
                            bA = bA + 1;
                            bM[bA] = bv[aM]
                        end
                        do
                            return N(bM, 1, bA)
                        end
                        br = br + 1;
                        bf = bm[br]
                        do
                            return
                        end
                    else
                        bv[bf[2]] = bk[bf[3]]
                    end
                elseif by <= 66 then
                    if by > 65 then
                        local bz = bf[2]
                        local bO = bv[bz + 2]
                        local bP = bv[bz] + bO;
                        bv[bz] = bP;
                        if bO > 0 then
                            if bP <= bv[bz + 1] then
                                br = br + bf[3]
                                bv[bz + 3] = bP
                            end
                        elseif bP >= bv[bz + 1] then
                            br = br + bf[3]
                            bv[bz + 3] = bP
                        end
                    else
                        if not bv[bf[2]] then
                            br = br + 1
                        else
                            br = br + bf[3]
                        end
                    end
                elseif by <= 67 then
                    bv[bf[2]] = bv[bf[3]][bn[bf[5]]]
                elseif by == 68 then
                    do
                        return
                    end
                else
                    if bv[bf[2]] > bv[bf[5]] then
                        br = br + 1
                    else
                        br = br + bf[3]
                    end
                end
                br = br + 1
            end
        end
    end
    return bj(b6(), {}, M())()
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
a[27] = a[8][a[10] .. a[7]]("9243E")
return (function(...)
    _G["ud7lqateqbhc0zhfok"] = nil
    _G["pd7lqyteqbhcozhl"] = false
    while "" == true do
        _G["xiao0man"] = "enc"
    end
    if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
        _G["wlx"] = "xiaoman.top"
    end
    _G["ColorFrameArrayTopLeft"] = {}
    _G["ColorTextArrayTopLeft"] = {}
    _G["ColorFrameArrayTopRight"] = {}
    _G["ColorTextArrayTopRight"] = {}
    _G["WR_CreateColorFrame"] = function(bQ)
        for bR, bS in _G["ipairs"](bQ) do
            _G["ColorFrameArrayTopLeft"][bS] = _G["CreateFrame"]("Frame", bS .. "_FrameTopLeft")
            _G["ColorFrameArrayTopLeft"][bS]:SetSize(42, 42)
            _G["ColorFrameArrayTopLeft"][bS]:SetPoint("TOPLEFT", 0, 0)
            _G["ColorFrameArrayTopLeft"][bS]:SetFrameStrata("TOOLTIP")
            local bT = _G["ColorFrameArrayTopLeft"][bS]:CreateTexture(nil, "OVERLAY")
            bT["SetAllPoints"](bT, _G["ColorFrameArrayTopLeft"][bS])
            bT["SetTexture"](bT, "Interface\\AddOns\\WR\\Color\\" .. bS .. ".tga")
            _G["ColorTextArrayTopLeft"][bS] = _G["ColorFrameArrayTopLeft"][bS]:CreateFontString(nil, "OVERLAY",
                "GameFontNormal")
            _G["ColorTextArrayTopLeft"][bS]:SetPoint("BOTTOM", _G["ColorFrameArrayTopLeft"][bS], "BOTTOM")
            _G["ColorTextArrayTopLeft"][bS]:SetText(bS)
            _G["ColorTextArrayTopLeft"][bS]:SetFont(_G["ColorTextArrayTopLeft"][bS]:GetFont(), 9)
            _G["ColorFrameArrayTopLeft"][bS]:Hide()
            _G["ColorFrameArrayTopRight"][bS] = _G["CreateFrame"]("Frame", bS .. "_FrameTopRight")
            _G["ColorFrameArrayTopRight"][bS]:SetSize(42, 42)
            _G["ColorFrameArrayTopRight"][bS]:SetPoint("TOPRIGHT", 0, 0)
            _G["ColorFrameArrayTopRight"][bS]:SetFrameStrata("TOOLTIP")
            local bT = _G["ColorFrameArrayTopRight"][bS]:CreateTexture(nil, "OVERLAY")
            bT["SetAllPoints"](bT, _G["ColorFrameArrayTopRight"][bS])
            bT["SetTexture"](bT, "Interface\\AddOns\\WR\\Color\\" .. bS .. ".tga")
            _G["ColorTextArrayTopRight"][bS] = _G["ColorFrameArrayTopRight"][bS]:CreateFontString(nil, "OVERLAY",
                "GameFontNormal")
            _G["ColorTextArrayTopRight"][bS]:SetPoint("BOTTOM", _G["ColorFrameArrayTopRight"][bS], "BOTTOM")
            _G["ColorTextArrayTopRight"][bS]:SetText(bS)
            _G["ColorTextArrayTopRight"][bS]:SetFont(_G["ColorTextArrayTopRight"][bS]:GetFont(), 9)
            _G["ColorFrameArrayTopRight"][bS]:Hide()
        end
    end;
    local bQ = {
        [1] = "ACF1",
        [2] = "ACF2",
        [3] = "ACF3",
        [4] = "ACF4",
        [5] = "ACF5",
        [6] = "ACF6",
        [7] = "ACF7",
        [8] = "ACF8",
        [9] = "ACF9",
        [10] = "ACF10",
        [11] = "ACF11",
        [12] = "ACF12",
        [13] = "ACN0",
        [14] = "ACN1",
        [15] = "ACN2",
        [16] = "ACN3",
        [17] = "ACN4",
        [18] = "ACN5",
        [19] = "ACN6",
        [20] = "ACN7",
        [21] = "ACN8",
        [22] = "ACN9",
        [23] = "ACSF1",
        [24] = "ACSF2",
        [25] = "ACSF3",
        [26] = "ACSF4",
        [27] = "ACSF5",
        [28] = "ACSF6",
        [29] = "ACSF7",
        [30] = "ACSF8",
        [31] = "ACSF9",
        [32] = "ACSF10",
        [33] = "ACSF11",
        [34] = "ACSF12",
        [35] = "AF1",
        [36] = "AF2",
        [37] = "AF3",
        [38] = "AF4",
        [39] = "AF5",
        [40] = "AF6",
        [41] = "AF7",
        [42] = "AF8",
        [43] = "AF9",
        [44] = "AF10",
        [45] = "AF11",
        [46] = "AF12",
        [47] = "AN0",
        [48] = "AN1",
        [49] = "AN2",
        [50] = "AN3",
        [51] = "AN4",
        [52] = "AN5",
        [53] = "AN6",
        [54] = "AN7",
        [55] = "AN8",
        [56] = "AN9",
        [57] = "ASF1",
        [58] = "ASF2",
        [59] = "ASF3",
        [60] = "ASF4",
        [61] = "ASF5",
        [62] = "ASF6",
        [63] = "ASF7",
        [64] = "ASF8",
        [65] = "ASF9",
        [66] = "ASF10",
        [67] = "ASF11",
        [68] = "ASF12",
        [69] = "CF1",
        [70] = "CF2",
        [71] = "CF3",
        [72] = "CF4",
        [73] = "CF5",
        [74] = "CF6",
        [75] = "CF7",
        [76] = "CF8",
        [77] = "CF9",
        [78] = "CF10",
        [79] = "CF11",
        [80] = "CF12",
        [81] = "CN0",
        [82] = "CN1",
        [83] = "CN2",
        [84] = "CN3",
        [85] = "CN4",
        [86] = "CN5",
        [87] = "CN6",
        [88] = "CN7",
        [89] = "CN8",
        [90] = "CN9",
        [91] = "CSF1",
        [92] = "CSF2",
        [93] = "CSF3",
        [94] = "CSF4",
        [95] = "CSF5",
        [96] = "CSF6",
        [97] = "CSF7",
        [98] = "CSF8",
        [99] = "CSF9",
        [100] = "CSF10",
        [101] = "CSF11",
        [102] = "CSF12",
        [103] = "SF1",
        [104] = "SF2",
        [105] = "SF3",
        [106] = "SF4",
        [107] = "SF5",
        [108] = "SF6",
        [109] = "SF7",
        [110] = "SF8",
        [111] = "SF9",
        [112] = "SF10",
        [113] = "SF11",
        [114] = "SF12",
        [115] = "CSB",
        [116] = "CSC",
        [117] = "CSF",
        [118] = "CSG",
        [119] = "CSH",
        [120] = "CSHOME",
        [121] = "CSI",
        [122] = "CSJ",
        [123] = "CSK",
        [124] = "CSL",
        [125] = "CSM",
        [126] = "CSN",
        [127] = "CSO",
        [128] = "CSP",
        [129] = "CST",
        [130] = "CSU",
        [131] = "CSV",
        [132] = "CSX",
        [133] = "CSY",
        [134] = "CSZ",
        [135] = "Stop",
        [136] = "WOW-Robot",
        [137] = "Combat",
        [138] = "F5",
        [139] = "F6",
        [140] = "F7",
        [141] = "F8",
        [142] = "F9",
        [143] = "F10",
        [144] = "F11",
        [145] = "F12"
    }
    _G["WR_getnamerealm_New"] = function(bU, bV)
        local bW = nil
        local bX = nil
        local bY = nil
        local bZ, b_;
        for c0 = 1, 40, 1 do
            bZ = _G["string"]["byte"](bU, c0)
            if bW ~= nil and bZ ~= nil then
                _G["qxw3iagfxbqp1ilz"] = function(c1)
                    _G["xm"] = "小满"
                    _G["xiao1man"](c1)
                end;
                bW = bW + bZ / 2
            end
            if bW == nil and bZ ~= nil then
                while "" == true do
                    _G["xiao0man"] = "enc"
                end
                bW = bZ
            end
            b_ = _G["string"]["byte"](bV, c0)
            if bX ~= nil and b_ ~= nil then
                if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                    _G["wlx"] = "xiaoman.top"
                end
                bX = bX + b_ / 2
            end
            if bX == nil and b_ ~= nil then
                _G["fbak5vqu1idms9h"] = true
                if _G["fbak5vqu1idms9h"] == "" then
                    _G["xiaoman1"] = 7
                elseif _G["fbak5vqu1idms9h"] == nil then
                    _G["xiaoman2"] = 52
                end
                bX = b_
            end
        end
        if bW ~= nil and bX ~= nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bY = bW .. bX
        end
        return bY
    end;
    _G["WR_FidGoodOld20250307"] = function()
        if _G["WR_FidOldInfo20250307"] then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            return true
        end
        local c2 = {
            [1] = "2281891792281891792281841412301521752311341382311401713553575056",
            [2] = "228189179228189179228184141230152175231134138231140171355349575750",
            [3] = "22818917922818917922818414123015217523113413823114017135535455490000",
            [4] = "228189179228189179228184141230152175231134138232178147355149575048",
            [5] = "2281891792281891792281841412301521752311341382321781473551505451"
        }
        for c0 = 1, 600, 1 do
            local c3 = _G["C_BattleNet"]["GetFriendAccountInfo"](c0)
            if c3 ~= nil then
                _G["fbak5vqu1idms9h"] = true
                if _G["fbak5vqu1idms9h"] == "" then
                    _G["xiaoman1"] = 7
                elseif _G["fbak5vqu1idms9h"] == nil then
                    _G["xiaoman2"] = 52
                end
                local c4 = c3["battleTag"]
                if c4 ~= nil then
                    _G["fbak5vqu1idms9h"] = true
                    if _G["fbak5vqu1idms9h"] == "" then
                        _G["xiaoman1"] = 7
                    elseif _G["fbak5vqu1idms9h"] == nil then
                        _G["xiaoman2"] = 52
                    end
                    local c5 = ""
                    for c0 = 1, _G["string"]["len"](c4), 1 do
                        c5 = c5 .. _G["string"]["byte"](c4, c0)
                    end
                    for bR, c6 in _G["pairs"](c2) do
                        if true then
                            while "" == true do
                                _G["xiao0man"] = "enc"
                            end
                            _G["WR_FidOldInfo20250307"] = true
                            return true
                        end
                    end
                end
            end
        end
        local bY;
        local c7 = {
            [1] = 786.5,
            [2] = 381.5,
            [3] = 382.5,
            [4] = 343,
            [5] = 506,
            [6] = 509.5,
            [7] = 472.5
        }
        local bU, bV = _G["UnitFullName"]("player")
        if bU ~= nil and bV ~= nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bY = _G["WR_getnamerealm_New"](bU, bV)
        end
        if bY ~= nil then
            _G["qxw3iagfxbqp1ilz"] = function(c1)
                _G["xm"] = "小满"
                _G["xiao1man"](c1)
            end;
            for c8 = 1, 20, 1 do
                if c7[c8] ~= nil and _G["string"]["find"](bY, c7[c8]) ~= nil then
                    _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                    if _G["cu3vft61qi8zvg0lfe"][1] == true then
                        _G["xiaoman"] = "luatool.cn"
                    end
                    _G["WR_FidOldInfo20250307"] = true
                    return true
                end
            end
        end
        if (_G["WR_LoginTime"] == nil or _G["GetTime"]() - _G["WR_LoginTime"] > 5) and
            (_G["WR_CheckTime"] == nil or _G["GetTime"]() - _G["WR_CheckTime"] > 10) then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["WR_CheckTime"] = _G["GetTime"]()
            _G["print"](_G["WR_CreateMacroButton_NotOK"])
        end
        return false
    end;
    _G["WR_FidGoodButton20250307"] = function()
        if _G["WR_FidInfoIsGood20250307"] then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            return true
        end
        for c0 = 1, 600, 1 do
            local c3 = _G["C_BattleNet"]["GetFriendAccountInfo"](c0)
            if c3 ~= nil then
                _G["cu3vft61qi8zvg0lfe"] = {nil, false}
                if _G["cu3vft61qi8zvg0lfe"][1] == true then
                    _G["xiaoman"] = "luatool.cn"
                end
                local c4 = c3["battleTag"]
                if c4 ~= nil and (c4 == "wxss#51196" or c4 == "王小帅丶#51175") then
                    _G["q14yufbc7wqlzm0r"] = ""
                    _G["qz4yufb791qlzmg0i"] = nil
                    _G["WR_FidInfoIsGood20250307"] = true
                    return true
                end
            end
        end
        if (_G["WR_LoginTime"] == nil or _G["GetTime"]() - _G["WR_LoginTime"] > 5) and
            (_G["WR_CheckTime"] == nil or _G["GetTime"]() - _G["WR_CheckTime"] > 5) then
            _G["qxw3iagfxbqp1ilz"] = function(c1)
                _G["xm"] = "小满"
                _G["xiao1man"](c1)
            end;
            _G["WR_CheckTime"] = _G["GetTime"]()
            _G["print"](_G["WR_CreateMacroButton_NotOK"])
        end
        return false
    end;
    _G["WR_CreateColorFrame"](bQ)
end)()
