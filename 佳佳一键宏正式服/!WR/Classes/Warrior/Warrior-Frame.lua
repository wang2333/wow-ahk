local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]
a[a[18]] = function()
    local b = 81;
    local c = 38;
    local d = 52;
    local e = 97;
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
a[27] = a[8][a[10] .. a[7]]("AEA2F2")
return (function(...)
    _G["qxw3iagfxbqp1ilz"] = function(bL)
        _G["xm"] = "小满"
        _G["xiao1man"](bL)
    end;
    _G["fbak5vqu1idms9h"] = true
    if _G["fbak5vqu1idms9h"] == "" then
        _G["xiaoman1"] = 7
    elseif _G["fbak5vqu1idms9h"] == nil then
        _G["xiaoman2"] = 52
    end
    while "" == true do
        _G["xiao0man"] = "enc"
    end
    _G["WR_WarriorConfigFrame"] = function()
        if _G["WR_ConfigIsOK"] ~= nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            return
        end
        if not _G["WR_BN_Tag_20250314"] or not _G["WR_BN_Tag_20250314"]() then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            return
        end
        _G["WR_ConfigIsOK"] = true
        local bM = 185
        local bN = 750
        local bO = -15
        local bP = _G["CreateFrame"]("Frame", "WowRobotConfigFrame", _G["UIParent"], "UIPanelDialogTemplate")
        bP["SetSize"](bP, bM, bN)
        bP["SetPoint"](bP, "LEFT", 10, 80)
        bP["SetMovable"](bP, true)
        bP["EnableMouse"](bP, true)
        bP["RegisterForDrag"](bP, "LeftButton")
        bP["SetScript"](bP, "OnDragStart", bP["StartMoving"])
        bP["SetScript"](bP, "OnDragStop", bP["StopMovingOrSizing"])
        bP["SetFrameStrata"](bP, "FULLSCREEN")
        bP["Hide"](bP)
        bP["title"] = bP["CreateFontString"](bP, nil, "OVERLAY", "GameFontHighlight")
        bP["title"]:SetPoint("TOP", bP["Title"], "TOP", 0, 0)
        bP["title"]:SetText("|cff00adf0WOW-Robot")
        local bQ = bP["CreateTexture"](bP, nil, "ARTWORK")
        bQ["SetSize"](bQ, 35, 35)
        bQ["SetPoint"](bQ, "TOPLEFT", 20, -35)
        bQ["SetTexture"](bQ, "Interface\\AddOns\\!WR\\VX WOW-Robot\\VX WOW-Robot.tga")
        local bR = _G["CreateFrame"]("CheckButton", "WR_TestCheckbox", bP, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "LEFT", bQ, "RIGHT", 15, 0)
        bR["SetChecked"](bR, false)
        bR["text"]:SetText("调试模式")
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "如果卡技能，请打开此选项，\n可以查出卡在什么技能或功能上了。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        local bT = _G["CreateFrame"]("Frame", "KBZ_Frame", bP)
        bT["SetSize"](bT, 1, 1)
        bT["SetPoint"](bT, "CENTER", 0, 0)
        local bU = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        bU["SetText"](bU, "智能目标")
        bU["SetPoint"](bU, "TOPLEFT", bQ, "BOTTOMLEFT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_ZNMB_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", bU, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "锁定",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "范围",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "锁定：锁定当前所选目标，丢失目标的时候，切换最近的目标。\n范围：只要目标不在攻击范围内，切换最近的目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_ZNMB"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_ZNMB"])
        end
        _G["KBZ_ZNJD_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_ZNJD_Text"]["SetText"](_G["KBZ_ZNJD_Text"], "智能焦点")
        _G["KBZ_ZNJD_Text"]["SetPoint"](_G["KBZ_ZNJD_Text"], "TOPRIGHT", bU, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_ZNJD_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["KBZ_ZNJD_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffffff骷髅",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffcc3300十字",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cff3a8ff3方块",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffc3c3e3月亮",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff11ff11三角",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cffbf6af7菱形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cfffd7c07圆形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffebeb1b星型",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "自动设定指定标记的单位为焦点。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_ZNJD"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_ZNJD"])
        end
        local b_ = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        b_["SetText"](b_, "拳击")
        b_["SetPoint"](b_, "TOPRIGHT", _G["KBZ_ZNJD_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_QJ_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", b_, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff00adf0智能|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cff00adf0目标|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cff00adf0指向|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cff00adf0焦点|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：打断所有单位的施法。\n目标：仅打断当前目标的施法。\n指向：仅打断当前指向单位的施法。\n焦点：仅打断焦点单位的施法。(若无焦点则打断所有单位。)\n|cffffffff白色：打断大部分技能。|r\n|cff00adf0蓝色：仅断重要的技能。|r")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_QJ"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_QJ"])
        end
        local c0 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c0["SetText"](c0, "打断延迟")
        c0["SetPoint"](c0, "TOPRIGHT", b_, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_DDMS_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c0, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "秒断",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "80%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "90%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择秒断或打断延迟时间。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_DDMS"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_DDMS"])
        end
        local c1 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c1["SetText"](c1, "风暴之锤")
        c1["SetPoint"](c1, "TOPRIGHT", c0, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_FBZC_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c1, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：控制所有单位。\n目标：仅控制当前目标。\n指向：仅控制指向单位。\n焦点：仅控制焦点单位。(若无焦点则控制所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_FBZC"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_FBZC"])
        end
        _G["KBZ_ZT_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_ZT_Text"]["SetText"](_G["KBZ_ZT_Text"], "姿态")
        _G["KBZ_ZT_Text"]["SetPoint"](_G["KBZ_ZT_Text"], "TOPRIGHT", c1, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_ZT_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["KBZ_ZT_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "狂暴",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "自动",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "狂暴：维持狂暴姿态。\n自动：某些需要减伤的环境自动切防御姿态。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_ZT"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_ZT"])
        end
        local c2 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c2["SetText"](c2, "胜利在望")
        c2["SetPoint"](c2, "TOPRIGHT", _G["KBZ_ZT_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_SLZW_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c2, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定值，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_SLZW"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_SLZW"])
        end
        local c3 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c3["SetText"](c3, "狂怒回复")
        c3["SetPoint"](c3, "TOPRIGHT", c2, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_KNHF_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c3, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定值，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_KNHF"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_KNHF"])
        end
        local c4 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c4["SetText"](c4, "集结呐喊")
        c4["SetPoint"](c4, "TOPRIGHT", c3, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_JJNH_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c4, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_JJNH"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_JJNH"])
        end
        local c5 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c5["SetText"](c5, "治疗石")
        c5["SetPoint"](c5, "TOPRIGHT", c4, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_ZLS_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c5, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗石。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_ZLS"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_ZLS"])
        end
        local c6 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c6["SetText"](c6, "治疗药水")
        c6["SetPoint"](c6, "TOPRIGHT", c5, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_ZLYS_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c6, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_ZLYS"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_ZLYS"])
        end
        _G["KBZ_SP1_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_SP1_Text"]["SetText"](_G["KBZ_SP1_Text"], "饰品①")
        _G["KBZ_SP1_Text"]["SetPoint"](_G["KBZ_SP1_Text"], "TOPRIGHT", c6, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_SP1_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["KBZ_SP1_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_SP1"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_SP1"])
        end
        _G["KBZ_SP2_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_SP2_Text"]["SetText"](_G["KBZ_SP2_Text"], "饰品②")
        _G["KBZ_SP2_Text"]["SetPoint"](_G["KBZ_SP2_Text"], "TOPRIGHT", _G["KBZ_SP1_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_SP2_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["KBZ_SP2_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_SP2"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_SP2"])
        end
        _G["KBZ_WuQi_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_WuQi_Text"]["SetText"](_G["KBZ_WuQi_Text"], "武器")
        _G["KBZ_WuQi_Text"]["SetPoint"](_G["KBZ_WuQi_Text"], "TOPRIGHT", _G["KBZ_SP2_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_WuQi_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["KBZ_WuQi_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：爆发模式使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_WuQi"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_WuQi"])
        end
        local c7 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c7["SetText"](c7, "施法速度")
        c7["SetPoint"](c7, "TOPRIGHT", _G["KBZ_WuQi_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_SFSD_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c7, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "15%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "25%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "在公共冷却(GCD)前0.1-0.3秒插入下一个技能。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_SFSD"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_SFSD"])
        end
        local c8 = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        c8["SetText"](c8, "插件功率")
        c8["SetPoint"](c8, "TOPRIGHT", c7, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "KBZ_CJGL_Dropdown", bT, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", c8, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "最高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "较高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "中等",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "较低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "最低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "功率设置会影响插件的反应速度。\n功率越高，反应越快，帧数下降。\n功率越低，反应越慢，帧数提高。\n请根据自己的电脑性能酌情调整。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_CJGL"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["KBZ_CJGL"])
        end
        _G["KBZ_FSFS_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_FSFS_Text"]["SetText"](_G["KBZ_FSFS_Text"], "反射")
        _G["KBZ_FSFS_Text"]["SetPoint"](_G["KBZ_FSFS_Text"], "TOPRIGHT", c8, "BOTTOMRIGHT", -33, bO)
        local bR = _G["CreateFrame"]("CheckButton", "KBZ_FSFS_Checkbox", bT, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["KBZ_FSFS_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0法术反射|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_FSFS"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bR["SetChecked"](bR, true)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bR["SetChecked"](bR, _G["WRSet"]["KBZ_FSFS"])
        end
        _G["KBZ_ZDB_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_ZDB_Text"]["SetText"](_G["KBZ_ZDB_Text"], "震荡")
        _G["KBZ_ZDB_Text"]["SetPoint"](_G["KBZ_ZDB_Text"], "LEFT", _G["KBZ_FSFS_Text"], "RIGHT", 8, 0)
        local bR = _G["CreateFrame"]("CheckButton", "KBZ_ZDB_Checkbox", bT, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["KBZ_ZDB_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0震荡波|r(控制)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_ZDB"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bR["SetChecked"](bR, true)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bR["SetChecked"](bR, _G["WRSet"]["KBZ_ZDB"])
        end
        _G["KBZ_PDNH_Text"] = bT["CreateFontString"](bT, nil, "ARTWORK", "GameFontNormal")
        _G["KBZ_PDNH_Text"]["SetText"](_G["KBZ_PDNH_Text"], "破胆")
        _G["KBZ_PDNH_Text"]["SetPoint"](_G["KBZ_PDNH_Text"], "LEFT", _G["KBZ_ZDB_Text"], "RIGHT", 8, 0)
        local bR = _G["CreateFrame"]("CheckButton", "KBZ_PDNH_Checkbox", bT, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["KBZ_PDNH_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0破胆怒吼|r(控制)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["KBZ_PDNH"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            bR["SetChecked"](bR, true)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            bR["SetChecked"](bR, _G["WRSet"]["KBZ_PDNH"])
        end
        local c9 = _G["CreateFrame"]("Frame", "FZ_Frame", bP)
        c9["SetSize"](c9, 1, 1)
        c9["SetPoint"](c9, "CENTER", 0, 0)
        local ca = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        ca["SetText"](ca, "智能目标")
        ca["SetPoint"](ca, "TOPLEFT", bQ, "BOTTOMLEFT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_ZNMB_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", ca, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "锁定",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "范围",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "锁定：锁定当前所选目标，丢失目标的时候，切换最近的目标。\n范围：只要目标不在攻击范围内，切换最近的目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_ZNMB"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_ZNMB"])
        end
        _G["FZ_ZNJD_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_ZNJD_Text"]["SetText"](_G["FZ_ZNJD_Text"], "智能焦点")
        _G["FZ_ZNJD_Text"]["SetPoint"](_G["FZ_ZNJD_Text"], "TOPRIGHT", ca, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_ZNJD_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["FZ_ZNJD_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffffff骷髅",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffcc3300十字",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cff3a8ff3方块",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffc3c3e3月亮",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff11ff11三角",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cffbf6af7菱形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cfffd7c07圆形",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffebeb1b星型",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "自动设定指定标记的单位为焦点。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_ZNJD"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_ZNJD"])
        end
        local cb = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        cb["SetText"](cb, "拳击")
        cb["SetPoint"](cb, "TOPRIGHT", _G["FZ_ZNJD_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_QJ_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cb, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff00adf0智能|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cff00adf0目标|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cff00adf0指向|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cff00adf0焦点|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffff5040禁用|r",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：打断所有单位的施法。\n目标：仅打断当前目标的施法。\n指向：仅打断当前指向单位的施法。\n焦点：仅打断焦点单位的施法。(若无焦点则打断所有单位。)\n|cffffffff白色：打断大部分技能。|r\n|cff00adf0蓝色：仅断重要的技能。|r")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_QJ"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_QJ"])
        end
        local cc = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        cc["SetText"](cc, "打断延迟")
        cc["SetPoint"](cc, "TOPRIGHT", cb, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_DDMS_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cc, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "秒断",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "80%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "90%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择秒断或打断延迟时间。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_DDMS"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_DDMS"])
        end
        local cd = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        cd["SetText"](cd, "风暴之锤")
        cd["SetPoint"](cd, "TOPRIGHT", cc, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_FBZC_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cd, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：控制所有单位。\n目标：仅控制当前目标。\n指向：仅控制指向单位。\n焦点：仅控制焦点单位。(若无焦点则控制所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_FBZC"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_FBZC"])
        end
        _G["FZ_DPCF_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_DPCF_Text"]["SetText"](_G["FZ_DPCF_Text"], "盾牌冲锋")
        _G["FZ_DPCF_Text"]["SetPoint"](_G["FZ_DPCF_Text"], "TOPRIGHT", cd, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_DPCF_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["FZ_DPCF_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "常驻：任何使用使用盾牌冲锋。\n爆发：仅爆发时使用盾牌冲锋。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_DPCF"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_DPCF"])
        end
        local ce = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        ce["SetText"](ce, "盾墙")
        ce["SetPoint"](ce, "TOPRIGHT", _G["FZ_DPCF_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_DQ_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", ce, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "当生命值低于设定值，自动使用盾墙。\n注：建议手动规划盾墙减伤。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_DQ"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_DQ"])
        end
        local cf = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        cf["SetText"](cf, "破釜沉舟")
        cf["SetPoint"](cf, "TOPRIGHT", ce, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_PFCZ_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cf, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定值，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_PFCZ"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_PFCZ"])
        end
        local cg = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        cg["SetText"](cg, "集结呐喊")
        cg["SetPoint"](cg, "TOPRIGHT", cf, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_JJNH_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cg, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_JJNH"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_JJNH"])
        end
        local ch = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        ch["SetText"](ch, "治疗石")
        ch["SetPoint"](ch, "TOPRIGHT", cg, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_ZLS_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", ch, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗石。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_ZLS"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_ZLS"])
        end
        local ci = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        ci["SetText"](ci, "治疗药水")
        ci["SetPoint"](ci, "TOPRIGHT", ch, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_ZLYS_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", ci, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_ZLYS"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_ZLYS"])
        end
        _G["FZ_SP1_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_SP1_Text"]["SetText"](_G["FZ_SP1_Text"], "饰品①")
        _G["FZ_SP1_Text"]["SetPoint"](_G["FZ_SP1_Text"], "TOPRIGHT", ci, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_SP1_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["FZ_SP1_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_SP1"] == nil then
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_SP1"])
        end
        _G["FZ_SP2_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_SP2_Text"]["SetText"](_G["FZ_SP2_Text"], "饰品②")
        _G["FZ_SP2_Text"]["SetPoint"](_G["FZ_SP2_Text"], "TOPRIGHT", _G["FZ_SP1_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_SP2_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["FZ_SP2_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cff00adf010%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cff00adf020%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cff00adf030%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "|cff00adf040%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "|cff00adf050%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffba55d310%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "|cffba55d320%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "|cffba55d330%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }, {
            ["text"] = "|cffba55d340%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 11)
            end
        }, {
            ["text"] = "|cffba55d350%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 12)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 13)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：随爆发技能同时使用。\n|cff00adf0自保：自己生命值低于设定值时使用。\n|cffba55d3协助：队友或自己生命值低于设定值时使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_SP2"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_SP2"])
        end
        _G["FZ_WuQi_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_WuQi_Text"]["SetText"](_G["FZ_WuQi_Text"], "武器")
        _G["FZ_WuQi_Text"]["SetPoint"](_G["FZ_WuQi_Text"], "TOPRIGHT", _G["FZ_SP2_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_WuQi_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["FZ_WuQi_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cffffa500常驻",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cff90ee90爆发",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "|cffffa500常驻：CD好了就用。\n|cff90ee90爆发：爆发模式使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_WuQi"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_WuQi"])
        end
        local cj = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        cj["SetText"](cj, "施法速度")
        cj["SetPoint"](cj, "TOPRIGHT", _G["FZ_WuQi_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_SFSD_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cj, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "15%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "25%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "在公共冷却(GCD)前0.1-0.3秒插入下一个技能。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_SFSD"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_SFSD"])
        end
        local ck = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        ck["SetText"](ck, "插件功率")
        ck["SetPoint"](ck, "TOPRIGHT", cj, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "FZ_CJGL_Dropdown", c9, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", ck, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "最高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "较高",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "中等",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "较低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "最低",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "功率设置会影响插件的反应速度。\n功率越高，反应越快，帧数下降。\n功率越低，反应越慢，帧数提高。\n请根据自己的电脑性能酌情调整。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_CJGL"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["FZ_CJGL"])
        end
        _G["FZ_NotADD_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_NotADD_Text"]["SetText"](_G["FZ_NotADD_Text"], "防衅")
        _G["FZ_NotADD_Text"]["SetPoint"](_G["FZ_NotADD_Text"], "TOPRIGHT", ck, "BOTTOMRIGHT", -33, bO)
        local bR = _G["CreateFrame"]("CheckButton", "FZ_NotADD_Checkbox", c9, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["FZ_NotADD_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "勾选后，不主动攻击未战斗的单位。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_NotADD"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            bR["SetChecked"](bR, true)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            bR["SetChecked"](bR, _G["WRSet"]["FZ_NotADD"])
        end
        _G["FZ_FSFS_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_FSFS_Text"]["SetText"](_G["FZ_FSFS_Text"], "反射")
        _G["FZ_FSFS_Text"]["SetPoint"](_G["FZ_FSFS_Text"], "LEFT", _G["FZ_NotADD_Text"], "RIGHT", 8, 0)
        local bR = _G["CreateFrame"]("CheckButton", "FZ_FSFS_Checkbox", c9, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["FZ_FSFS_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0法术反射|r(减伤)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_FSFS"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bR["SetChecked"](bR, true)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bR["SetChecked"](bR, _G["WRSet"]["FZ_FSFS"])
        end
        _G["FZ_ZDB_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_ZDB_Text"]["SetText"](_G["FZ_ZDB_Text"], "震荡")
        _G["FZ_ZDB_Text"]["SetPoint"](_G["FZ_ZDB_Text"], "LEFT", _G["FZ_FSFS_Text"], "RIGHT", 8, 0)
        local bR = _G["CreateFrame"]("CheckButton", "FZ_ZDB_Checkbox", c9, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["FZ_ZDB_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0震荡波|r(控制)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_ZDB"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            bR["SetChecked"](bR, true)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            bR["SetChecked"](bR, _G["WRSet"]["FZ_ZDB"])
        end
        _G["FZ_PDNH_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_PDNH_Text"]["SetText"](_G["FZ_PDNH_Text"], "破胆")
        _G["FZ_PDNH_Text"]["SetPoint"](_G["FZ_PDNH_Text"], "LEFT", _G["FZ_ZDB_Text"], "RIGHT", 8, 0)
        local bR = _G["CreateFrame"]("CheckButton", "FZ_PDNH_Checkbox", c9, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["FZ_PDNH_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0破胆怒吼|r(控制)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_PDNH"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            bR["SetChecked"](bR, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bR["SetChecked"](bR, _G["WRSet"]["FZ_PDNH"])
        end
        _G["FZ_TSXF_Text"] = c9["CreateFontString"](c9, nil, "ARTWORK", "GameFontNormal")
        _G["FZ_TSXF_Text"]["SetText"](_G["FZ_TSXF_Text"], "天神")
        _G["FZ_TSXF_Text"]["SetPoint"](_G["FZ_TSXF_Text"], "TOP", _G["FZ_NotADD_Checkbox"], "BOTTOM", 0, 0)
        local bR = _G["CreateFrame"]("CheckButton", "FZ_TSXF_Checkbox", c9, "UICheckButtonTemplate")
        bR["SetPoint"](bR, "TOP", _G["FZ_TSXF_Text"], "BOTTOM", 0, 0)
        bR["SetChecked"](bR, false)
        bR["SetScript"](bR, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "|cff00adf0天神下凡|r(爆发)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bR["SetScript"](bR, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["FZ_TSXF"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            bR["SetChecked"](bR, true)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            bR["SetChecked"](bR, _G["WRSet"]["FZ_TSXF"])
        end
        local cl = _G["CreateFrame"]("Frame", "WQZ_Frame", bP)
        cl["SetSize"](cl, 1, 1)
        cl["SetPoint"](cl, "CENTER", 0, 0)
        local cm = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cm["SetText"](cm, "智能目标")
        cm["SetPoint"](cm, "TOPLEFT", bQ, "BOTTOMLEFT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_ZNMB_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cm, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "当失去目标的时候，自动切换一个最近的目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_ZNMB"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_ZNMB"])
        end
        local cn = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cn["SetText"](cn, "拳击")
        cn["SetPoint"](cn, "TOPRIGHT", cm, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_QJ_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cn, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：自动打断一切目标。\n目标：只打断当前目标。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_QJ"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_QJ"])
        end
        local co = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        co["SetText"](co, "打断延迟")
        co["SetPoint"](co, "TOPRIGHT", cn, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_DDMS_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", co, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "秒断",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }, {
            ["text"] = "80%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 9)
            end
        }, {
            ["text"] = "90%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 10)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择秒断或打断延迟时间。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_DDMS"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_DDMS"])
        end
        local cp = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cp["SetText"](cp, "法术反射")
        cp["SetPoint"](cp, "TOPRIGHT", co, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_FSFS_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cp, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "反射对你施法的法术。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_FSFS"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_FSFS"])
        end
        local cq = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cq["SetText"](cq, "破胆怒吼")
        cq["SetPoint"](cq, "TOPRIGHT", cp, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_PDNH_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cq, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "恐惧附近特定的钢条施法单位。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_PDNH"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_PDNH"])
        end
        local cr = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cr["SetText"](cr, "风暴之锤")
        cr["SetPoint"](cr, "TOPRIGHT", cq, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_FBZC_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cr, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "智能",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "目标",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "指向",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "焦点",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"],
                "智能：控制所有单位。\n目标：仅控制当前目标。\n指向：仅控制指向单位。\n焦点：仅控制焦点单位。(若无焦点则控制所有单位。)")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_FBZC"] == nil then
            _G["fbak5vqu1idms9h"] = true
            if _G["fbak5vqu1idms9h"] == "" then
                _G["xiaoman1"] = 7
            elseif _G["fbak5vqu1idms9h"] == nil then
                _G["xiaoman2"] = 52
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["qxw3iagfxbqp1ilz"] = function(bL)
                _G["xm"] = "小满"
                _G["xiao1man"](bL)
            end;
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_FBZC"])
        end
        _G["WQZ_FYZT_Text"] = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        _G["WQZ_FYZT_Text"]["SetText"](_G["WQZ_FYZT_Text"], "防御姿态")
        _G["WQZ_FYZT_Text"]["SetPoint"](_G["WQZ_FYZT_Text"], "TOPRIGHT", cr, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_FYZT_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["WQZ_FYZT_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "在特定的AOE场景自动切换防御姿态。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_FYZT"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_FYZT"])
        end
        _G["WQZ_WSKT_Text"] = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        _G["WQZ_WSKT_Text"]["SetText"](_G["WQZ_WSKT_Text"], "无视苦痛")
        _G["WQZ_WSKT_Text"]["SetPoint"](_G["WQZ_WSKT_Text"], "TOPRIGHT", _G["WQZ_FYZT_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_WSKT_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", _G["WQZ_WSKT_Text"], "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "开启",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "在特定的AOE场景自动使用无视苦痛。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_WSKT"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_WSKT"])
        end
        local cs = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cs["SetText"](cs, "饰品")
        cs["SetPoint"](cs, "TOPRIGHT", _G["WQZ_WSKT_Text"], "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_SP_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cs, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "1号",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "2号",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "1-2号",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "选择开爆发技能的时候，同时使用的饰品。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_SP"] == nil then
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_SP"])
        end
        local ct = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        ct["SetText"](ct, "爆发药水")
        ct["SetPoint"](ct, "TOPRIGHT", cs, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_BFYS_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", ct, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "|cff00adf0使用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "开爆发技能的时候，同时爆发药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_BFYS"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_BFYS"])
        end
        local cu = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cu["SetText"](cu, "胜利在望")
        cu["SetPoint"](cu, "TOPRIGHT", ct, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_SLZW_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cu, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "50%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }, {
            ["text"] = "60%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 6)
            end
        }, {
            ["text"] = "70%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 7)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 8)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定值，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_SLZW"] == nil then
            _G["ud7lqateqbhc0zhfok"] = nil
            _G["pd7lqyteqbhcozhl"] = false
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["rh0dy1wi4xzo3qjkt"] ~= nil then
                _G["wlx"] = "xiaoman.top"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_SLZW"])
        end
        local cv = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cv["SetText"](cv, "剑在人在")
        cv["SetPoint"](cv, "TOPRIGHT", cu, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_JZRZ_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cv, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定值，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_JZRZ"] == nil then
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_JZRZ"])
        end
        local cw = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cw["SetText"](cw, "苦痛免疫")
        cw["SetPoint"](cw, "TOPRIGHT", cv, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_KTMY_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cw, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定值，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_KTMY"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_KTMY"])
        end
        local cx = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cx["SetText"](cx, "治疗石")
        cx["SetPoint"](cx, "TOPRIGHT", cw, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_ZLS_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cx, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗石。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_ZLS"] == nil then
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["cu3vft61qi8zvg0lfe"] = {nil, false}
            if _G["cu3vft61qi8zvg0lfe"][1] == true then
                _G["xiaoman"] = "luatool.cn"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_ZLS"])
        end
        local cy = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cy["SetText"](cy, "治疗药水")
        cy["SetPoint"](cy, "TOPRIGHT", cx, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_ZLYS_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cy, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "40%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 5)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用治疗药水。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_ZLYS"] == nil then
            while "" == true do
                _G["xiao0man"] = "enc"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            _G["q14yufbc7wqlzm0r"] = ""
            _G["qz4yufb791qlzmg0i"] = nil
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_ZLYS"])
        end
        local cz = cl["CreateFontString"](cl, nil, "ARTWORK", "GameFontNormal")
        cz["SetText"](cz, "集结呐喊")
        cz["SetPoint"](cz, "TOPRIGHT", cy, "BOTTOMRIGHT", 0, bO)
        local bV = _G["CreateFrame"]("Frame", "WQZ_JJNH_Dropdown", cl, "UIDropDownMenuTemplate")
        bV["SetPoint"](bV, "LEFT", cz, "RIGHT", -16, -2)
        _G["UIDropDownMenu_SetWidth"](bV, 70)
        local bW = {{
            ["text"] = "10%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 1)
            end
        }, {
            ["text"] = "20%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 2)
            end
        }, {
            ["text"] = "30%",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 3)
            end
        }, {
            ["text"] = "|cffff5040禁用",
            ["func"] = function()
                _G["UIDropDownMenu_SetSelectedID"](bV, 4)
            end
        }}
        _G["UIDropDownMenu_Initialize"](bV, function()
            for bX, bY in _G["ipairs"](bW) do
                local bZ = _G["UIDropDownMenu_CreateInfo"]()
                bZ["text"] = bY["text"]
                bZ["func"] = bY["func"]
                _G["UIDropDownMenu_AddButton"](bZ)
            end
        end)
        bV["SetScript"](bV, "OnEnter", function(bS)
            _G["GameTooltip"]["SetOwner"](_G["GameTooltip"], bS, "ANCHOR_RIGHT")
            _G["GameTooltip"]["SetText"](_G["GameTooltip"], "当生命值低于设定，自动使用。")
            _G["GameTooltip"]["Show"](_G["GameTooltip"])
        end)
        bV["SetScript"](bV, "OnLeave", function(bS)
            _G["GameTooltip"]["Hide"](_G["GameTooltip"])
        end)
        if _G["WRSet"]["WQZ_JJNH"] == nil then
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, 1)
        else
            if _G["ah0dy1wiqxzo3qjet"] == "" then
                _G["ubpo"] = "xiaoman"
            end
            _G["UIDropDownMenu_SetSelectedID"](bV, _G["WRSet"]["WQZ_JJNH"])
        end
        _G["ToggleConfigFrame"] = function()
            if bP["IsShown"](bP) then
                _G["q14yufbc7wqlzm0r"] = ""
                _G["qz4yufb791qlzmg0i"] = nil
                bP["Hide"](bP)
            else
                _G["fbak5vqu1idms9h"] = true
                if _G["fbak5vqu1idms9h"] == "" then
                    _G["xiaoman1"] = 7
                elseif _G["fbak5vqu1idms9h"] == nil then
                    _G["xiaoman2"] = 52
                end
                bP["Show"](bP)
            end
        end;
        _G["SLASH_WOW_ROBOT1"] = "/wr"
        _G["SlashCmdList"]["WOW_ROBOT"] = _G["ToggleConfigFrame"]
        local cA = _G["CreateFrame"]("Button", "WR_ClickFrame", _G["UIParent"], "UIPanelButtonTemplate")
        cA["SetSize"](cA, 25, 25)
        cA["SetPoint"](cA, "BOTTOMLEFT", 0, 0)
        cA["SetFrameStrata"](cA, "TOOLTIP")
        cA["SetMovable"](cA, true)
        cA["EnableMouse"](cA, true)
        cA["RegisterForDrag"](cA, "LeftButton")
        cA["SetScript"](cA, "OnDragStart", cA["StartMoving"])
        cA["SetScript"](cA, "OnDragStop", cA["StopMovingOrSizing"])
        local cB = cA["CreateTexture"](cA, nil, "OVERLAY")
        cB["SetAllPoints"](cB, cA)
        cB["SetTexture"](cB, "Interface\\AddOns\\!WR\\VX WOW-Robot\\VX WOW-Robot.tga")
        cA["SetScript"](cA, "OnClick", function(bS, cC, cD)
            if bP["IsShown"](bP) then
                _G["fbak5vqu1idms9h"] = true
                if _G["fbak5vqu1idms9h"] == "" then
                    _G["xiaoman1"] = 7
                elseif _G["fbak5vqu1idms9h"] == nil then
                    _G["xiaoman2"] = 52
                end
                bP["Hide"](bP)
            else
                _G["fbak5vqu1idms9h"] = true
                if _G["fbak5vqu1idms9h"] == "" then
                    _G["xiaoman1"] = 7
                elseif _G["fbak5vqu1idms9h"] == nil then
                    _G["xiaoman2"] = 52
                end
                bP["Show"](bP)
            end
        end)
        cA["Show"](cA)
        local cA = _G["CreateFrame"]("Frame", "WR_CombatFrame")
        cA["SetSize"](cA, 8, 8)
        cA["SetPoint"](cA, "BOTTOMRIGHT", 0, 0)
        cA["SetFrameStrata"](cA, "TOOLTIP")
        local cB = cA["CreateTexture"](cA, nil, "OVERLAY")
        cB["SetAllPoints"](cB, cA)
        cB["SetColorTexture"](cB, _G["BGRtoRGB"](_G["WR_FrameColor"]["Combat"]))
        cA["Hide"](cA)
    end
end)()
