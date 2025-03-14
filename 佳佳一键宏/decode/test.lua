local a = {"6", "x", "C", "2", "5", "A", "8", _G, "1", "F", "4", "E", "0", "9", "7", "_", "B", "D", "3", 37, 56, 12, 91,
           54, 78, 18, 40, 62, 25}
a[10] = a[16] .. a[13] .. a[2] .. a[17] .. a[1] .. a[4] .. a[5] .. a[11] .. a[6] .. a[13] .. a[12] .. a[14] .. a[15] ..
            a[18] .. a[7] .. a[9] .. a[10] .. a[11] .. a[13] .. a[19] .. a[3]

local key = "r"
function calculateSum(str)
    local sum = 0
    for i = 1, #str do
        sum = sum + string.byte(str, i)
    end
    return sum
end
function decompress(compressedStr)
    local currentChar, nextChar, result = "", "", {}
    local dictSize = 256
    local dictionary = {}

    if compressedStr == key then
        return nextChar
    end

    for i = 0, dictSize - 1 do
        dictionary[i] = string.char(i)
    end

    local position = 1
    local function readValue()
        local digitCount = tonumber(string.sub(compressedStr, position, position), 36)
        position = position + 1
        local value = tonumber(string.sub(compressedStr, position, position + digitCount - 1), 36)
        position = position + digitCount
        return value
    end

    currentChar = string.char(readValue())
    result[1] = currentChar

    while position < #compressedStr do
        local code = readValue()
        if dictionary[code] then
            nextChar = dictionary[code]
        else
            nextChar = currentChar .. string.sub(currentChar, 1, 1)
        end
        dictionary[dictSize] = currentChar .. string.sub(nextChar, 1, 1)
        result[#result + 1], currentChar, dictSize = nextChar, nextChar, dictSize + 1
    end

    return table.concat(result)
end
local decompressedKey = decompress(key)
function decrypt(shift, encryptedText)
    local decryptedText = decompressedKey
    for i = 1, #encryptedText do
        local charCode = string.byte(encryptedText, i) - (shift + i) % 256
        if charCode < 0 then
            charCode = charCode + 256
        end
        decryptedText = decryptedText .. string.char(charCode)
    end
    return decryptedText
end
function hexToString(hexStr)
    return string.gsub(hexStr, '..', function(hexPair)
        return string.char(tonumber(hexPair, 16) % 256)
    end)
end

a[21] = function(a_, aX)
    return tonumber(decrypt(calculateSum(a_), hexToString(aX)))
end
a[22] = function()
    return decompressedKey
end
a[24] = function()
    return true
end
a[25] = function()
    return false
end
a[28] = function(a_, aX)
    return decrypt(calculateSum(a_), hexToString(aX))
end
a[29] = function()
    return _G[a[10]]
end
print(a[28]('A3E5965','7751487A544B7D522882354D86262B892F4FC8DBE0DAE1'))





-- a[28](a[27],"C5C6CDC7CFD1CAD1D4CECFD6D0D8DAD3DADDD7D8DFD9E1DEDCE0DEE0E2E0E2E7E5E5ECEBE9EBEAEBEEF0EEF1F7F2F4F3F4F8F5F7FEF9FCFF00FF020504000608")
-- ==>
-- 119120115115355349495754


-- a[28](a[27],"7751487A544B7D522882354D86262B892F4FC8DBE0DAE1")
-- ==>
-- wxss#51196




