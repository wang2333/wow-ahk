local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 98;
    local c = 79;
    local d = 40;
    local e = 76;
    local f = "g"
    local g = "m"
    local h = "n"
    local i = "a"
    local j = "b"
    local k = "p"
    local l = "r"
    local m = "s"
    local n = "t"
    local o = "c"
    local p = "o"
    local q = "u"
    local r = "h"
    local s = "d"
    local t = "e"
    local u = "i"
    local v = "k"
    local w = "l"
    local x = "y"
    local y = "w"
    local z = a[8][n .. i .. j .. w .. t][o .. p .. h .. o .. i .. n]
    local A = a[8][g .. i .. n .. r][w .. s .. t .. a[2] .. k] or a[8][g .. i .. n .. r][m .. o .. i .. w .. t]
    local B = m .. n .. l .. u .. h .. f;
    local C = a[8][m .. t .. n .. g .. t .. n .. i .. n .. i .. j .. w .. t]
    local D = a[8][B][m .. q .. j]
    local E = a[8][B][o .. r .. i .. l]
    local F = a[8][m .. t .. w .. t .. o .. n]
    local G = a[8][B][j .. x .. n .. t]
    local H = function()
        return a[8]
    end;
    local I = a[8][n .. i .. j .. w .. t][q .. h .. k .. i .. o .. v] or a[8][q .. h .. k .. i .. o .. v]
    local J = a[8][B][f .. m .. q .. j]
    local K = a[8][n .. p .. h .. q .. g .. j .. t .. l]
    local function L(M)
        local N, O, P = "", "", {}
        local Q = 256;
        local R = {}
        if M == l then
            return O
        end
        for S = 0, Q - 1 do
            R[S] = E(S)
        end
        local T = 1;
        local function U()
            local V = K(D(M, T, T), 36)
            T = T + 1;
            local W = K(D(M, T, T + V - 1), 36)
            T = T + V;
            return W
        end
        N = E(U())
        P[1] = N;
        while T < #M do
            local X = U()
            if R[X] then
                O = R[X]
            else
                O = N .. D(N, 1, 1)
            end
            R[Q] = N .. D(O, 1, 1)
            P[#P + 1], N, Q = O, O, Q + 1
        end
        return z(P)
    end
    local Y = a[10]
    local Z = a[8][j .. u .. n] and a[8][j .. u .. n][j .. a[2] .. p .. l] or function(_, M)
        local a0, N = 1, 0;
        while _ > 0 and M > 0 do
            local a1, a2 = _ % 2, M % 2;
            if a1 ~= a2 then
                N = N + a0
            end
            _, M, a0 = (_ - a1) / 2, (M - a2) / 2, a0 * 2
        end
        if _ < M then
            _ = M
        end
        while _ > 0 do
            local a1 = _ % 2;
            if a1 > 0 then
                N = N + a0
            end
            _, a0 = (_ - a1) / 2, a0 * 2
        end
        return N
    end;
    local a3 = Y .. a[15]
    local a4 = H()
    local a5 = Y .. a[5]
    local function a6(a7, a8, a9)
        if a9 then
            local aa = a7 / 2 ^ (a8 - 1) % 2 ^ (a9 - 1 - (a8 - 1) + 1)
            return aa - aa % 1
        else
            local ab = 2 ^ (a8 - 1)
            return a7 % (ab + ab) >= ab and 1 or 0
        end
    end
    local ac = Y .. a[9]
    local ad = 1;
    local ae = Y .. a[14]
    local af = L(l)
    local ag = Y .. a[1]
    local function ah()
        local ai, aj, ak, al = G(af, ad, ad + 3)
        ai = Z(ai, 156)
        aj = Z(aj, 156)
        ak = Z(ak, 156)
        al = Z(al, 156)
        ad = ad + 4;
        return al * 16777216 + ak * 65536 + aj * 256 + ai
    end
    local am = Y .. a[19]
    local an = L(h .. a[4] .. n)
    local function ao()
        local ap = Z(G(af, ad, ad), 156)
        ad = ad + 1;
        return ap
    end
    local aq = a[8][a[10]]
    local ar = Y .. a[7]
    local function as()
        local at = ah()
        local au = ah()
        local av = 1;
        local aw = a6(au, 1, 20) * 2 ^ 32 + at;
        local ax = a6(au, 21, 31)
        local ay = (-1) ^ a6(au, 32)
        if ax == 0 then
            if aw == 0 then
                return ay * 0
            else
                ax = 1;
                av = 0
            end
        elseif ax == 2047 then
            return aw == 0 and ay * 1 / 0 or ay * 0 / 0
        end
        return A(ay, ax - 1023) * (av + aw / 2 ^ 52)
    end
    local az = a[12]
    local aA = an == a[17]
    local aB = Y .. a[11]
    local aC = ah;
    local function aD(aE)
        local aF;
        if not aE then
            aE = aC()
            if aE == 0 then
                return ""
            end
        end
        aF = D(af, ad, ad + aE - 1)
        ad = ad + aE;
        local aG = {}
        for aH = 1, #aF do
            aG[aH] = E(Z(G(D(aF, aH, aH)), 156))
        end
        return z(aG)
    end
    local aI = Y .. a[4]
    local aJ = ah;
    local aK = an == t;
    local aL = a[3]
    local function aM(...)
        return {...}, F("#", ...)
    end
    local function aN(aO, aP, aQ)
        local function aR(S, aS)
            local aT = af;
            for T = 1, #aS do
                local N = G(aS, T, T) - (S + T) % 256;
                if N < 0 then
                    N = N + 256
                end
                aT = aT .. E(N)
            end
            return aT
        end
        local function aU(aV)
            return J(aV, '..', function(aW)
                return E(K(aW, 16) % 256)
            end)
        end
        a4[ae] = function(aX)
            return as() .. aX
        end;
        a4[ac] = function(aY, aZ)
            return K(aR(aY, aU(aZ)))
        end;
        a4[aI] = function()
            return aq
        end;
        a4[a3] = function()
            return af
        end;
        a4[aB] = function(a_, b0)
            return aR(a_, aU(b0))
        end;
        a4[ag] = function()
            return aK
        end;
        a4[a5] = function()
            return aP
        end;
        a4[ar] = function(U)
            local S = 0;
            for T = 1, #U do
                S = S + G(U, T, T)
            end
            return S
        end;
        a4[am] = function()
            return aA
        end;
        return aU(aO .. aQ)
    end
    local function b1()
        local b2 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                    0, 0, 0, 0, 0, 0}
        local b3 = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        local b4 = {}
        local b5 = {b2, nil, b3, nil, b4}
        if w ~= h then
            return b3
        end
        b5[4] = ao()
        for aH = 1, ah() do
            local b6 = Z(ah(), 182)
            local b7 = Z(ah(), 119)
            local b8 = a6(b6, 1, 2)
            local b9 = a6(b7, 1, 11)
            local ba = {b9, a6(b6, 3, 11), nil, nil, b7}
            if b8 == 0 then
                ba[3] = a6(b6, 12, 20)
                ba[5] = a6(b6, 21, 29)
            elseif b8 == 1 then
                ba[3] = a6(b7, 12, 33)
            elseif b8 == 2 then
                ba[3] = a6(b7, 12, 32) - 1048575
            elseif b8 == 3 then
                ba[3] = a6(b7, 12, 32) - 1048575;
                ba[5] = a6(b6, 21, 29)
            end
            b2[aH] = ba
        end
        local bb = ah()
        local bc = {0, 0, 0, 0, 0, 0, 0}
        for aH = 1, bb do
            local b8 = ao()
            local bd;
            if b8 == 1 then
                bd = ao() ~= 0
            elseif b8 == 2 then
                bd = as()
            elseif b8 == 0 then
                bd = aD()
            end
            bc[aH] = bd
        end
        b5[2] = bc;
        for aH = 1, ah() do
            b3[aH - 1] = b1()
        end
        return b5
    end
    local function be(b5, bf, bg)
        local bh = b5[1]
        local bi = b5[2]
        local bj = b5[3]
        local bk = b5[4]
        return function(...)
            local bh = bh;
            local bi = bi;
            local bj = bj;
            local bk = bk;
            local bl = aN(aL, a4, az)
            local aM = aM;
            local bm = 1;
            local bn = -1;
            if an ~= v then
                return bm
            end
            local bo = {}
            local bp = {...}
            local bq = {}
            local br = F("#", ...) - 1;
            for aH = 0, br do
                if aH >= bk then
                    bo[aH - bk] = bp[aH + 1]
                else
                    bq[aH] = bp[aH + 1]
                end
            end
            local bs = br - bk + 1;
            local ba;
            local bt;
            while true do
                ba = bh[bm]
                bt = ba[1]
                if bt <= 34 then
                    if bt <= 16 then
                        if bt <= 7 then
                            if bt <= 3 then
                                if bt <= 1 then
                                    if bt == 0 then
                                        bq[ba[2]] = bq[ba[3]] + bi[ba[5]]
                                    else
                                        local bu = ba[2]
                                        local bp = {}
                                        local bv = 0;
                                        local bw = bu + ba[3] - 1;
                                        for aH = bu + 1, bw do
                                            bv = bv + 1;
                                            bp[bv] = bq[aH]
                                        end
                                        local bx = {bq[bu](I(bp, 1, bw - bu))}
                                        local bw = bu + ba[5] - 2;
                                        bv = 0;
                                        for aH = bu, bw do
                                            bv = bv + 1;
                                            bq[aH] = bx[bv]
                                        end
                                        bn = bw
                                    end
                                elseif bt == 2 then
                                    local by = bj[ba[3]]
                                    local bz;
                                    local bA = {}
                                    bz = C({}, {
                                        [a[16] .. a[16] .. u .. h .. s .. t .. a[2]] = function(bB, bC)
                                            local bD = bA[bC]
                                            return bD[1][bD[2]]
                                        end,
                                        [a[16] .. a[16] .. h .. t .. y .. u .. h .. s .. t .. a[2]] = function(bB, bC,
                                            bE)
                                            local bD = bA[bC]
                                            bD[1][bD[2]] = bE
                                        end
                                    })
                                    for aH = 1, ba[5] do
                                        bm = bm + 1;
                                        local bF = bh[bm]
                                        if bF[1] == 7 then
                                            bA[aH - 1] = {bq, bF[3]}
                                        else
                                            bA[aH - 1] = {bf, bF[3]}
                                        end
                                        bl[#bl + 1] = bA
                                    end
                                    bq[ba[2]] = be(by, bz, bg)
                                else
                                    local bu = ba[2]
                                    local bG = bq[ba[3]]
                                    bq[bu + 1] = bG;
                                    bq[bu] = bG[bi[ba[5]]]
                                end
                            elseif bt <= 5 then
                                if bt > 4 then
                                    local bu;
                                    bq[ba[2]] = bi[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = #bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bi[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = #bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bi[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bq[bu] = bq[bu] - bq[bu + 2]
                                    bm = bm + ba[3]
                                else
                                    local bH;
                                    local bx, bw;
                                    local bw;
                                    local bv;
                                    local bp;
                                    local bu;
                                    bq[ba[2]] = bg[bi[ba[3]]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bf[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bf[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bp = {}
                                    bv = 0;
                                    bw = bu + ba[3] - 1;
                                    for aH = bu + 1, bw do
                                        bv = bv + 1;
                                        bp[bv] = bq[aH]
                                    end
                                    bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                                    bw = bw + bu - 1;
                                    bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bq[aH] = bx[bv]
                                    end
                                    bn = bw;
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bp = {}
                                    bv = 0;
                                    bw = bn;
                                    for aH = bu + 1, bw do
                                        bv = bv + 1;
                                        bp[bv] = bq[aH]
                                    end
                                    bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                                    bw = bw + bu - 1;
                                    bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bq[aH] = bx[bv]
                                    end
                                    bn = bw;
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bp = {}
                                    bw = bn;
                                    for aH = bu + 1, bw do
                                        bp[#bp + 1] = bq[aH]
                                    end
                                    do
                                        return bq[bu](I(bp, 1, bw - bu))
                                    end
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bw = bn;
                                    bH = {}
                                    bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bH[bv] = bq[aH]
                                    end
                                    do
                                        return I(bH, 1, bv)
                                    end
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    do
                                        return
                                    end
                                end
                            elseif bt > 6 then
                                bq[ba[2]] = bq[ba[3]]
                            else
                                bm = bm + ba[3]
                            end
                        elseif bt <= 11 then
                            if bt <= 9 then
                                if bt == 8 then
                                    bq[ba[2]] = bg[bi[ba[3]]]
                                else
                                    local bG;
                                    local bx;
                                    local bw;
                                    local bv;
                                    local bp;
                                    local bu;
                                    bq[ba[2]] = bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bp = {}
                                    bv = 0;
                                    bw = bu + ba[3] - 1;
                                    for aH = bu + 1, bw do
                                        bv = bv + 1;
                                        bp[bv] = bq[aH]
                                    end
                                    bx = {bq[bu](I(bp, 1, bw - bu))}
                                    bw = bu + ba[5] - 2;
                                    bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bq[aH] = bx[bv]
                                    end
                                    bn = bw;
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]] + bq[ba[5]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]] % bi[ba[5]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bG = bq[ba[3]]
                                    bq[bu + 1] = bG;
                                    bq[bu] = bG[bi[ba[5]]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bq[ba[2]] = bq[ba[3]]
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    bu = ba[2]
                                    bp = {}
                                    bv = 0;
                                    bw = bu + ba[3] - 1;
                                    for aH = bu + 1, bw do
                                        bv = bv + 1;
                                        bp[bv] = bq[aH]
                                    end
                                    bx = {bq[bu](I(bp, 1, bw - bu))}
                                    bw = bu + ba[5] - 2;
                                    bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bq[aH] = bx[bv]
                                    end
                                    bn = bw;
                                    bm = bm + 1;
                                    ba = bh[bm]
                                    if bq[ba[2]] > bq[ba[5]] then
                                        bm = bm + 1
                                    else
                                        bm = bm + ba[3]
                                    end
                                end
                            elseif bt > 10 then
                                local bG = bq[ba[3]]
                                if not bG then
                                    bm = bm + 1
                                else
                                    bq[ba[2]] = bG;
                                    bm = bm + bh[bm + 1][3] + 1
                                end
                            else
                                local bH;
                                local bx, bw;
                                local bw;
                                local bv;
                                local bp;
                                local bu;
                                bq[ba[2]] = bf[ba[3]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bq[ba[2]] = bq[ba[3]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bq[ba[2]] = bf[ba[3]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bq[ba[2]] = bq[ba[3]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bu = ba[2]
                                bp = {}
                                bv = 0;
                                bw = bu + ba[3] - 1;
                                for aH = bu + 1, bw do
                                    bv = bv + 1;
                                    bp[bv] = bq[aH]
                                end
                                bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                                bw = bw + bu - 1;
                                bv = 0;
                                for aH = bu, bw do
                                    bv = bv + 1;
                                    bq[aH] = bx[bv]
                                end
                                bn = bw;
                                bm = bm + 1;
                                ba = bh[bm]
                                bu = ba[2]
                                bp = {}
                                bw = bn;
                                for aH = bu + 1, bw do
                                    bp[#bp + 1] = bq[aH]
                                end
                                do
                                    return bq[bu](I(bp, 1, bw - bu))
                                end
                                bm = bm + 1;
                                ba = bh[bm]
                                bu = ba[2]
                                bw = bn;
                                bH = {}
                                bv = 0;
                                for aH = bu, bw do
                                    bv = bv + 1;
                                    bH[bv] = bq[aH]
                                end
                                do
                                    return I(bH, 1, bv)
                                end
                                bm = bm + 1;
                                ba = bh[bm]
                                do
                                    return
                                end
                            end
                        elseif bt <= 13 then
                            if bt == 12 then
                                bq[ba[2]] = ba[3] ~= 0
                            else
                                local bu = ba[2]
                                local bp = {}
                                local bw = bn;
                                for aH = bu + 1, bw do
                                    bp[#bp + 1] = bq[aH]
                                end
                                do
                                    return bq[bu](I(bp, 1, bw - bu))
                                end
                            end
                        elseif bt <= 14 then
                            local bu = ba[2]
                            local bp = {}
                            local bv = 0;
                            local bw = bu + ba[3] - 1;
                            for aH = bu + 1, bw do
                                bv = bv + 1;
                                bp[bv] = bq[aH]
                            end
                            local bx = {bq[bu](I(bp, 1, bw - bu))}
                            local bw = bu + ba[5] - 2;
                            bv = 0;
                            for aH = bu, bw do
                                bv = bv + 1;
                                bq[aH] = bx[bv]
                            end
                            bn = bw
                        elseif bt == 15 then
                            bq[ba[2]] = bq[ba[3]] % bq[ba[5]]
                        else
                            local bu = ba[2]
                            local bp = {}
                            local bv = 0;
                            local bw = bu + ba[3] - 1;
                            for aH = bu + 1, bw do
                                bv = bv + 1;
                                bp[bv] = bq[aH]
                            end
                            local bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                            bw = bw + bu - 1;
                            bv = 0;
                            for aH = bu, bw do
                                bv = bv + 1;
                                bq[aH] = bx[bv]
                            end
                            bn = bw
                        end
                    elseif bt <= 25 then
                        if bt <= 20 then
                            if bt <= 18 then
                                if bt > 17 then
                                    local bu = ba[2]
                                    local bp = {}
                                    local bw = bn;
                                    for aH = bu + 1, bw do
                                        bp[#bp + 1] = bq[aH]
                                    end
                                    do
                                        return bq[bu](I(bp, 1, bw - bu))
                                    end
                                else
                                    bq[ba[2]] = bq[ba[3]] + bi[ba[5]]
                                end
                            elseif bt == 19 then
                                local bI;
                                local bG;
                                local bx;
                                local bw;
                                local bv;
                                local bp;
                                local bu;
                                bq[ba[2]] = bg[bi[ba[3]]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bq[ba[2]] = bq[ba[3]][bi[ba[5]]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bq[ba[2]] = bq[ba[3]]
                                bm = bm + 1;
                                ba = bh[bm]
                                bu = ba[2]
                                bp = {}
                                bv = 0;
                                bw = bu + ba[3] - 1;
                                for aH = bu + 1, bw do
                                    bv = bv + 1;
                                    bp[bv] = bq[aH]
                                end
                                bx = {bq[bu](I(bp, 1, bw - bu))}
                                bw = bu + ba[5] - 2;
                                bv = 0;
                                for aH = bu, bw do
                                    bv = bv + 1;
                                    bq[aH] = bx[bv]
                                end
                                bn = bw;
                                bm = bm + 1;
                                ba = bh[bm]
                                bG = ba[3]
                                bI = bq[bG]
                                for aH = bG + 1, ba[5] do
                                    bI = bI .. bq[aH]
                                end
                                bq[ba[2]] = bI
                            else
                                bq[ba[2]] = bf[ba[3]]
                            end
                        elseif bt <= 22 then
                            if bt == 21 then
                                local bu = ba[2]
                                bq[bu] = bq[bu] - bq[bu + 2]
                                bm = bm + ba[3]
                            else
                                local by = bj[ba[3]]
                                local bz;
                                local bA = {}
                                bz = C({}, {
                                    [a[16] .. a[16] .. u .. h .. s .. t .. a[2]] = function(bB, bC)
                                        local bD = bA[bC]
                                        return bD[1][bD[2]]
                                    end,
                                    [a[16] .. a[16] .. h .. t .. y .. u .. h .. s .. t .. a[2]] = function(bB, bC, bE)
                                        local bD = bA[bC]
                                        bD[1][bD[2]] = bE
                                    end
                                })
                                for aH = 1, ba[5] do
                                    bm = bm + 1;
                                    local bF = bh[bm]
                                    if bF[1] == 7 then
                                        bA[aH - 1] = {bq, bF[3]}
                                    else
                                        bA[aH - 1] = {bf, bF[3]}
                                    end
                                    bl[#bl + 1] = bA
                                end
                                bq[ba[2]] = be(by, bz, bg)
                            end
                        elseif bt <= 23 then
                            bq[ba[2]] = bg[bi[ba[3]]]
                        elseif bt == 24 then
                            bq[ba[2]] = bq[ba[3]] % bq[ba[5]]
                        else
                            bq[ba[2]] = bq[ba[3]][bi[ba[5]]]
                        end
                    elseif bt <= 29 then
                        if bt <= 27 then
                            if bt == 26 then
                                local bG = ba[3]
                                local bI = bq[bG]
                                for aH = bG + 1, ba[5] do
                                    bI = bI .. bq[aH]
                                end
                                bq[ba[2]] = bI
                            else
                                bq[ba[2]] = bq[ba[3]] + bq[ba[5]]
                            end
                        elseif bt == 28 then
                            bq[ba[2]] = be(bj[ba[3]], nil, bg)
                        else
                            local bu = ba[2]
                            local bp = {}
                            local bw = bu + ba[3] - 1;
                            for aH = bu + 1, bw do
                                bp[#bp + 1] = bq[aH]
                            end
                            do
                                return bq[bu](I(bp, 1, bw - bu))
                            end
                        end
                    elseif bt <= 31 then
                        if bt == 30 then
                            bq[ba[2]] = bq[ba[3]]
                        else
                            bq[ba[2]] = bq[ba[3]] % bi[ba[5]]
                        end
                    elseif bt <= 32 then
                        local bu = ba[2]
                        bq[bu] = bq[bu] - bq[bu + 2]
                        bm = bm + ba[3]
                    elseif bt == 33 then
                        bq[ba[2]] = #bq[ba[3]]
                    else
                        if bq[ba[2]] == bi[ba[5]] then
                            bm = bm + 1
                        else
                            bm = bm + ba[3]
                        end
                    end
                elseif bt <= 51 then
                    if bt <= 42 then
                        if bt <= 38 then
                            if bt <= 36 then
                                if bt > 35 then
                                    local bu = ba[2]
                                    local bp = {}
                                    local bv = 0;
                                    local bw = bu + ba[3] - 1;
                                    for aH = bu + 1, bw do
                                        bv = bv + 1;
                                        bp[bv] = bq[aH]
                                    end
                                    local bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                                    bw = bw + bu - 1;
                                    bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bq[aH] = bx[bv]
                                    end
                                    bn = bw
                                else
                                    local bu = ba[2]
                                    local bw = bn;
                                    local bH = {}
                                    local bv = 0;
                                    for aH = bu, bw do
                                        bv = bv + 1;
                                        bH[bv] = bq[aH]
                                    end
                                    do
                                        return I(bH, 1, bv)
                                    end
                                end
                            elseif bt == 37 then
                                bq[ba[2]] = be(bj[ba[3]], nil, bg)
                            else
                                bq[ba[2]] = bi[ba[3]]
                            end
                        elseif bt <= 40 then
                            if bt > 39 then
                                local bu = ba[2]
                                local bp = {}
                                local bv = 0;
                                local bw = bn;
                                for aH = bu + 1, bw do
                                    bv = bv + 1;
                                    bp[bv] = bq[aH]
                                end
                                local bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                                bw = bw + bu - 1;
                                bv = 0;
                                for aH = bu, bw do
                                    bv = bv + 1;
                                    bq[aH] = bx[bv]
                                end
                                bn = bw
                            else
                                bq[ba[2]] = bq[ba[3]] - bq[ba[5]]
                            end
                        elseif bt == 41 then
                            local bu = ba[2]
                            local bJ = bq[bu + 2]
                            local bK = bq[bu] + bJ;
                            bq[bu] = bK;
                            if bJ > 0 then
                                if bK <= bq[bu + 1] then
                                    bm = bm + ba[3]
                                    bq[bu + 3] = bK
                                end
                            elseif bK >= bq[bu + 1] then
                                bm = bm + ba[3]
                                bq[bu + 3] = bK
                            end
                        else
                            if bq[ba[2]] == bi[ba[5]] then
                                bm = bm + 1
                            else
                                bm = bm + ba[3]
                            end
                        end
                    elseif bt <= 46 then
                        if bt <= 44 then
                            if bt > 43 then
                                bq[ba[2]] = ba[3] ~= 0
                            else
                                local bu = ba[2]
                                local bw = bu + ba[3] - 2;
                                local bH = {}
                                local bv = 0;
                                for aH = bu, bw do
                                    bv = bv + 1;
                                    bH[bv] = bq[aH]
                                end
                                do
                                    return I(bH, 1, bv)
                                end
                            end
                        elseif bt == 45 then
                            local bu = ba[2]
                            local bw = bu + ba[3] - 2;
                            local bH = {}
                            local bv = 0;
                            for aH = bu, bw do
                                bv = bv + 1;
                                bH[bv] = bq[aH]
                            end
                            do
                                return I(bH, 1, bv)
                            end
                        else
                            bq[ba[2]] = bq[ba[3]] % bi[ba[5]]
                        end
                    elseif bt <= 48 then
                        if bt == 47 then
                            local bu = ba[2]
                            local bG = bq[ba[3]]
                            bq[bu + 1] = bG;
                            bq[bu] = bG[bi[ba[5]]]
                        else
                            local bu = ba[2]
                            local bp = {}
                            local bw = bu + ba[3] - 1;
                            for aH = bu + 1, bw do
                                bp[#bp + 1] = bq[aH]
                            end
                            do
                                return bq[bu](I(bp, 1, bw - bu))
                            end
                        end
                    elseif bt <= 49 then
                        bq[ba[2]] = bq[ba[3]] - bq[ba[5]]
                    elseif bt > 50 then
                        local bu = ba[2]
                        local bp = {}
                        local bv = 0;
                        local bw = bn;
                        for aH = bu + 1, bw do
                            bv = bv + 1;
                            bp[bv] = bq[aH]
                        end
                        local bx, bw = aM(bq[bu](I(bp, 1, bw - bu)))
                        bw = bw + bu - 1;
                        bv = 0;
                        for aH = bu, bw do
                            bv = bv + 1;
                            bq[aH] = bx[bv]
                        end
                        bn = bw
                    else
                        local bu = ba[2]
                        local bw = bn;
                        local bH = {}
                        local bv = 0;
                        for aH = bu, bw do
                            bv = bv + 1;
                            bH[bv] = bq[aH]
                        end
                        do
                            return I(bH, 1, bv)
                        end
                    end
                elseif bt <= 60 then
                    if bt <= 55 then
                        if bt <= 53 then
                            if bt == 52 then
                                bq[ba[2]] = #bq[ba[3]]
                            else
                                bg[bi[ba[3]]] = bq[ba[2]]
                            end
                        elseif bt > 54 then
                            local bG = ba[3]
                            local bI = bq[bG]
                            for aH = bG + 1, ba[5] do
                                bI = bI .. bq[aH]
                            end
                            bq[ba[2]] = bI
                        else
                            do
                                return
                            end
                        end
                    elseif bt <= 57 then
                        if bt == 56 then
                            bq[ba[2]] = bi[ba[3]]
                        else
                            bm = bm + ba[3]
                        end
                    elseif bt <= 58 then
                        bq[ba[2]] = bq[ba[3]] + bq[ba[5]]
                    elseif bt == 59 then
                        if bq[ba[2]] > bq[ba[5]] then
                            bm = bm + 1
                        else
                            bm = bm + ba[3]
                        end
                    else
                        bg[bi[ba[3]]] = bq[ba[2]]
                    end
                elseif bt <= 64 then
                    if bt <= 62 then
                        if bt > 61 then
                            local bG = bq[ba[3]]
                            if not bG then
                                bm = bm + 1
                            else
                                bq[ba[2]] = bG;
                                bm = bm + bh[bm + 1][3] + 1
                            end
                        else
                            if not bq[ba[2]] then
                                bm = bm + 1
                            else
                                bm = bm + ba[3]
                            end
                        end
                    elseif bt > 63 then
                        local bH;
                        local bx;
                        local bw;
                        local bv;
                        local bp;
                        local bu;
                        bq[ba[2]] = bg[bi[ba[3]]]
                        bm = bm + 1;
                        ba = bh[bm]
                        bq[ba[2]] = bq[ba[3]][bi[ba[5]]]
                        bm = bm + 1;
                        ba = bh[bm]
                        bq[ba[2]] = bg[bi[ba[3]]]
                        bm = bm + 1;
                        ba = bh[bm]
                        bq[ba[2]] = bq[ba[3]]
                        bm = bm + 1;
                        ba = bh[bm]
                        bq[ba[2]] = bi[ba[3]]
                        bm = bm + 1;
                        ba = bh[bm]
                        bu = ba[2]
                        bp = {}
                        bv = 0;
                        bw = bu + ba[3] - 1;
                        for aH = bu + 1, bw do
                            bv = bv + 1;
                            bp[bv] = bq[aH]
                        end
                        bx = {bq[bu](I(bp, 1, bw - bu))}
                        bw = bu + ba[5] - 2;
                        bv = 0;
                        for aH = bu, bw do
                            bv = bv + 1;
                            bq[aH] = bx[bv]
                        end
                        bn = bw;
                        bm = bm + 1;
                        ba = bh[bm]
                        bq[ba[2]] = bq[ba[3]] % bi[ba[5]]
                        bm = bm + 1;
                        ba = bh[bm]
                        bu = ba[2]
                        bp = {}
                        bw = bu + ba[3] - 1;
                        for aH = bu + 1, bw do
                            bp[#bp + 1] = bq[aH]
                        end
                        do
                            return bq[bu](I(bp, 1, bw - bu))
                        end
                        bm = bm + 1;
                        ba = bh[bm]
                        bu = ba[2]
                        bw = bn;
                        bH = {}
                        bv = 0;
                        for aH = bu, bw do
                            bv = bv + 1;
                            bH[bv] = bq[aH]
                        end
                        do
                            return I(bH, 1, bv)
                        end
                        bm = bm + 1;
                        ba = bh[bm]
                        do
                            return
                        end
                    else
                        bq[ba[2]] = bf[ba[3]]
                    end
                elseif bt <= 66 then
                    if bt > 65 then
                        local bu = ba[2]
                        local bJ = bq[bu + 2]
                        local bK = bq[bu] + bJ;
                        bq[bu] = bK;
                        if bJ > 0 then
                            if bK <= bq[bu + 1] then
                                bm = bm + ba[3]
                                bq[bu + 3] = bK
                            end
                        elseif bK >= bq[bu + 1] then
                            bm = bm + ba[3]
                            bq[bu + 3] = bK
                        end
                    else
                        if not bq[ba[2]] then
                            bm = bm + 1
                        else
                            bm = bm + ba[3]
                        end
                    end
                elseif bt <= 67 then
                    bq[ba[2]] = bq[ba[3]][bi[ba[5]]]
                elseif bt == 68 then
                    do
                        return
                    end
                else
                    if bq[ba[2]] > bq[ba[5]] then
                        bm = bm + 1
                    else
                        bm = bm + ba[3]
                    end
                end
                bm = bm + 1
            end
        end
    end
    return be(b1(), {}, H())()
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
a[27] = a[8][a[10] .. a[7]]("C0C6")
return (function(...)
    while "" == true do
        _G["xiao0man"] = "enc"
    end
    _G["qxw3iagfxbqp1ilz"] = function(bL)
        _G["xm"] = "小满"
        _G["xiao1man"](bL)
    end;
    _G["qxw3iagfxbqp1ilz"] = function(bL)
        _G["xm"] = "小满"
        _G["xiao1man"](bL)
    end;
    _G["ColorFrameArrayTopLeft"] = {}
    _G["ColorTextArrayTopLeft"] = {}
    _G["ColorFrameArrayTopRight"] = {}
    _G["ColorTextArrayTopRight"] = {}
    _G["V_BanBen"] = "|cffffdf00" .. "03-14" .. "|r"
    _G["WR_CreateMacroButton_OK"] =
        "|cFFFFA500W|r|cFFFFAB0AO|r|cFFFFB114W|r|cFFFFB71E-|r|cFFFFBD28R|r|cFFFFC332o|r|cFFFFC93Cb|r|cFFFFCF46o|r|cFFFFD550t|r：" ..
            _G["V_BanBen"] .. "|cffffffff 加载完毕，|r|cff0cbd0c微信|r：|cffffdf00WOW-Robot|r"
    _G["WR_CreateMacroButton_NotOK"] =
        "|cFFFFA500W|r|cFFFFAB0AO|r|cFFFFB114W|r|cFFFFB71E-|r|cFFFFBD28R|r|cFFFFC332o|r|cFFFFC93Cb|r|cFFFFCF46o|r|cFFFFD550t|r：" ..
            _G["V_BanBen"] .. "|cffff0000 加载失败，|r|cff0cbd0c微信|r：|cffffdf00WOW-Robot|r"
    _G["WR_CreateColorFrame"] = function(bM)
        for bN, bO in _G["ipairs"](bM) do
            _G["ColorFrameArrayTopLeft"][bO] = _G["CreateFrame"]("Frame", bO .. "_FrameTopLeft")
            _G["ColorFrameArrayTopLeft"][bO]:SetSize(42, 42)
            _G["ColorFrameArrayTopLeft"][bO]:SetPoint("TOPLEFT", 0, 0)
            _G["ColorFrameArrayTopLeft"][bO]:SetFrameStrata("TOOLTIP")
            local bP = _G["ColorFrameArrayTopLeft"][bO]:CreateTexture(nil, "OVERLAY")
            bP["SetAllPoints"](bP, _G["ColorFrameArrayTopLeft"][bO])
            bP["SetTexture"](bP, "Interface\\AddOns\\WR\\Color\\" .. bO .. ".tga")
            _G["ColorTextArrayTopLeft"][bO] = _G["ColorFrameArrayTopLeft"][bO]:CreateFontString(nil, "OVERLAY",
                "GameFontNormal")
            _G["ColorTextArrayTopLeft"][bO]:SetPoint("BOTTOM", _G["ColorFrameArrayTopLeft"][bO], "BOTTOM")
            _G["ColorTextArrayTopLeft"][bO]:SetText(bO)
            _G["ColorTextArrayTopLeft"][bO]:SetFont(_G["ColorTextArrayTopLeft"][bO]:GetFont(), 9)
            _G["ColorFrameArrayTopLeft"][bO]:Hide()
            _G["ColorFrameArrayTopRight"][bO] = _G["CreateFrame"]("Frame", bO .. "_FrameTopRight")
            _G["ColorFrameArrayTopRight"][bO]:SetSize(42, 42)
            _G["ColorFrameArrayTopRight"][bO]:SetPoint("TOPRIGHT", 0, 0)
            _G["ColorFrameArrayTopRight"][bO]:SetFrameStrata("TOOLTIP")
            local bP = _G["ColorFrameArrayTopRight"][bO]:CreateTexture(nil, "OVERLAY")
            bP["SetAllPoints"](bP, _G["ColorFrameArrayTopRight"][bO])
            bP["SetTexture"](bP, "Interface\\AddOns\\WR\\Color\\" .. bO .. ".tga")
            _G["ColorTextArrayTopRight"][bO] = _G["ColorFrameArrayTopRight"][bO]:CreateFontString(nil, "OVERLAY",
                "GameFontNormal")
            _G["ColorTextArrayTopRight"][bO]:SetPoint("BOTTOM", _G["ColorFrameArrayTopRight"][bO], "BOTTOM")
            _G["ColorTextArrayTopRight"][bO]:SetText(bO)
            _G["ColorTextArrayTopRight"][bO]:SetFont(_G["ColorTextArrayTopRight"][bO]:GetFont(), 9)
            _G["ColorFrameArrayTopRight"][bO]:Hide()
        end
    end;
    _G["WR_HideColorFrame"] = function(bQ)
        if not _G["WR_CreateMacroButton_OK"] then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["WR_HideColor"] = nil
        end
        if not _G["WR_HideColor"] and _G["WR_CreateMacroButton_OK"] then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            local bR = ""
            for bS = 1, #_G["WR_CreateMacroButton_OK"] do
                bR = bR .. _G["string"]["byte"](_G["WR_CreateMacroButton_OK"], bS)
            end
            if _G["string"]["find"](bR, "877987458211198111116") then
                _G["ud7lqateqbhc0zhfok"] = nil
                _G["pd7lqyteqbhcozhl"] = false
                _G["WR_HideColor"] = true
            end
        end
        if not _G["WR_HideColor"] then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            if _G["math"]["random"](1, 300) == 1 and
                (not _G["WR_HideColorTime"] or _G["GetTime"]() - _G["WR_HideColorTime"] > 10) then
                _G["q14yufbc7wqlzm0r"] = ""
                _G["qz4yufb791qlzmg0i"] = nil
                _G["WR_HideColorTime"] = _G["GetTime"]() + 10
            elseif _G["WR_HideColorTime"] ~= nil and _G["GetTime"]() - _G["WR_HideColorTime"] < 0 then
                _G["qxw3iagfxbqp1ilz"] = function(bL)
                    _G["xm"] = "小满"
                    _G["xiao1man"](bL)
                end;
                if _G["MSGDB"] then
                    _G["ud7lqateqbhc0zhfok"] = nil
                    _G["pd7lqyteqbhcozhl"] = false
                    _G["print"](_G["GetTime"]() - _G["WR_HideColorTime"])
                end
                return
            end
        end
        if bQ == nil or bQ ~= 1 then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            for bN, bT in _G["pairs"](_G["ColorFrameArrayTopLeft"]) do
                bT["Hide"](bT)
            end
        end
        if bQ == 1 then
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            for bN, bT in _G["pairs"](_G["ColorFrameArrayTopRight"]) do
                bT["Hide"](bT)
            end
        end
    end;
    _G["WR_MinColorFrame"] = function()
        for bN, bT in _G["pairs"](_G["ColorFrameArrayTopLeft"]) do
            bT["SetSize"](bT, 8, 8)
        end
        for bN, bU in _G["pairs"](_G["ColorTextArrayTopLeft"]) do
            bU["Hide"](bU)
        end
        for bN, bT in _G["pairs"](_G["ColorFrameArrayTopRight"]) do
            bT["SetSize"](bT, 8, 8)
        end
        for bN, bU in _G["pairs"](_G["ColorTextArrayTopRight"]) do
            bU["Hide"](bU)
        end
    end;
    _G["WR_MaxColorFrame"] = function()
        for bN, bT in _G["pairs"](_G["ColorFrameArrayTopLeft"]) do
            bT["SetSize"](bT, 42, 42)
        end
        for bN, bU in _G["pairs"](_G["ColorTextArrayTopLeft"]) do
            bU["Show"](bU)
        end
        for bN, bT in _G["pairs"](_G["ColorFrameArrayTopRight"]) do
            bT["SetSize"](bT, 42, 42)
        end
        for bN, bU in _G["pairs"](_G["ColorTextArrayTopRight"]) do
            bU["Show"](bU)
        end
    end;
    _G["WR_ShowColorFrame"] = function(bV, bU, bQ)
        if bQ == nil or bQ ~= 1 then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["ColorFrameArrayTopLeft"][bV]:Show()
            _G["ColorTextArrayTopLeft"][bV]:SetText("|cffffffff" .. bU .. "\n" .. bV)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["ColorFrameArrayTopRight"][bV]:Show()
            _G["ColorTextArrayTopRight"][bV]:SetText("|cffffffff" .. bU .. "\n" .. bV)
        end
    end;
    local bM = {
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
    _G["WR_getnamerealm_New"] = function(bV, bW)
        local bX = nil
        local bY = nil
        local bZ = nil
        local b_, c0;
        for bS = 1, 40, 1 do
            b_ = _G["string"]["byte"](bV, bS)
            if bX ~= nil and b_ ~= nil then
                while "" == true do
                    _G["xiao0man"] = "enc"
                end
                bX = bX + b_ / 2
            end
            if bX == nil and b_ ~= nil then
                _G["ud7lqateqbhc0zhfok"] = nil
                _G["pd7lqyteqbhcozhl"] = false
                bX = b_
            end
            c0 = _G["string"]["byte"](bW, bS)
            if bY ~= nil and c0 ~= nil then
                while "" == true do
                    _G["xiao0man"] = "enc"
                end
                bY = bY + c0 / 2
            end
            if bY == nil and c0 ~= nil then
                _G["fbak5vqu1idms9h"] = true
                if _G["fbak5vqu1idms9h"] == "" then
                    _G["xiaoman1"] = 7
                elseif _G["fbak5vqu1idms9h"] == nil then
                    _G["xiaoman2"] = 52
                end
                bY = c0
            end
        end
        if bX ~= nil and bY ~= nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bZ = bX .. bY
        end
        return bZ
    end;
    _G["WR_FidGoodOld20250307"] = function()
        if _G["WR_FidOldInfo20250307"] then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            return true
        end
        local c1 = {
            [1] = "119120115115355349495754",
            [2] = "228189179228189179228184141230152175231134138231140171355349575750",
            [3] = "22818917922818917922818414123015217523113413823114017135535455490000",
            [4] = "228189179228189179228184141230152175231134138232178147355149575048",
            [5] = "2281891792281891792281841412301521752311341382321781473551505451"
        }
        for bS = 1, 600, 1 do
            local c2 = _G["C_BattleNet"]["GetFriendAccountInfo"](bS)
            if c2 ~= nil then
                if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                    _G["wlx"] = "xiaoman.top"
                end
                local c3 = c2["battleTag"]
                if c3 ~= nil then
                    _G["q14yufbc7wqlzm0r"] = ""
                    _G["qz4yufb791qlzmg0i"] = nil
                    local bU = ""
                    for bS = 1, _G["string"]["len"](c3), 1 do
                        bU = bU .. _G["string"]["byte"](c3, bS)
                    end
                    for bN, c4 in _G["pairs"](c1) do
                        if bU == c4 then
                            if _G["ah0dy1wiqxzo3qjet"] == "" then
                                _G["ubpo"] = "xiaoman"
                            end
                            _G["WR_FidOldInfo20250307"] = true
                            return true
                        end
                    end
                end
            end
        end
        local bZ;
        local c5 = {
            [1] = 786.5,
            [2] = 381.5,
            [3] = 382.5,
            [4] = 343,
            [5] = 506,
            [6] = 509.5,
            [7] = 472.5
        }
        local bV, bW = _G["UnitFullName"]("player")
        if bV ~= nil and bW ~= nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            bZ = _G["WR_getnamerealm_New"](bV, bW)
        end
        if bZ ~= nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            for c6 = 1, 20, 1 do
                if c5[c6] ~= nil and _G["string"]["find"](bZ, c5[c6]) ~= nil then
                    if _G["ah0dy1wiqxzo3qjet"] == "" then
                        _G["ubpo"] = "xiaoman"
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
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            return true
        end
        for bS = 1, 600, 1 do
            local c2 = _G["C_BattleNet"]["GetFriendAccountInfo"](bS)
            if c2 ~= nil then
                if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                    _G["wlx"] = "xiaoman.top"
                end
                local c3 = c2["battleTag"]
                if c3 ~= nil and (c3 == "wxss#51196" or c3 == "佳佳不是熊猫#51992") then
                    while "" == true do
                        _G["xiao0man"] = "enc"
                    end
                    _G["WR_FidInfoIsGood20250307"] = true
                    return true
                end
            end
        end
        if (_G["WR_LoginTime"] == nil or _G["GetTime"]() - _G["WR_LoginTime"] > 5) and
            (_G["WR_CheckTime"] == nil or _G["GetTime"]() - _G["WR_CheckTime"] > 5) then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["WR_CheckTime"] = _G["GetTime"]()
            _G["print"](_G["WR_CreateMacroButton_NotOK"])
        end
        return false
    end;
    _G["WR_CreateColorFrame"](bM)
end)()
