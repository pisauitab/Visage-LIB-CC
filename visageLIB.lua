local visage = {}

function visage.displayIndex(mon, index)
    mon.setBackgroundColor(colors.blue)
    mon.clear()

    local monWidth, monHeight = mon.getSize()
    local isSmall = (monWidth<9)

    local textLength = (isSmall and 0 or 8) + #tostring(index)
    local start = (monWidth-textLength)/2

    local txt
    if textLength%2 == monWidth%2 then
        if isSmall then txt = ""..index
        else txt = "monitor "..index
        end
    else
        if isSmall then txt = "m"..index
        else txt = "monitor  "..index
        end
    end

    mon.setCursorPos(start+1, 2)
    mon.write(txt)
end

function visage.setOnAll(mons, fun)
    local functions = {}

    for i, mon in ipairs(mons) do
        if not (mon == "moved") then
            table.insert(functions, function()
                fun(mon, i)
            end)
        end
    end

    parallel.waitForAll(table.unpack(functions))
end

function visage.detectMonitors()
    return table.pack(peripheral.find("monitor"))
end

function visage.displayIndexes (mons)
    visage.setOnAll(mons,visage.displayIndex)
end

function visage.orderMonitors(mons, userOrder)

    local function revTable(inTable)
        local reversed = {}
        local len = #inTable
    
        for i=1, len do
            reversed[i] = inTable[len-i+1]
        end
    
        return reversed
    end
    
    local function split(str, delim)
        local res = {}
        for match in (str..delim):gmatch("(.-)"..delim) do
            table.insert(res,match)
        end
        return res
    end
    
    local function pairParse(original, code)
        local res = {}
        for k,v in pairs(original) do
            res[k] = v
        end
    
        local swaps = split(code, " ")
    
        for _, swap in ipairs(swaps) do
            local indices = split(swap, ":")
            local left = tonumber(indices[1])
            local right = tonumber(indices[2])
    
            if not res[left]=="moved" then res[right] = "moved" end
            res[left] = original[right]
        end
        
        return res
    end

    if userOrder == "" then
        -- nothing !
    elseif userOrder == "rev" then
        mons = revTable(mons)
    else
        mons = pairParse(mons, userOrder)
    end

    return mons
end

return visage
