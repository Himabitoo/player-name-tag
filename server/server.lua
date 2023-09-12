function GetCharInfoById(cid)

    local charInfo = nil
    local query = "SELECT charinfo FROM players WHERE cid = @cid LIMIT 1"

    MySQL.Async.fetchScalar(query, {['@cid'] = cid}, function(result)
        if result then
            charInfo = result
        end
    end)
    
    while charInfo == nil do
        Citizen.Wait(10)
    end

    return charInfo
end

function GetRoalNameFromInfo(playerCid,charInfo)

    local FirstName = ""
    local LastName = ""

    local InfoData = json.decode(charInfo)

    FirstName = InfoData.firstname
    LastName = InfoData.lastname

    -- new { "firstname":Firstname, "lastname":Lastname}
    local newInfoData = json.encode({
        cid = playerCid,
        firstname = FirstName,
        lastname = LastName
    })

    return newInfoData
end

function GetPlayerCid(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, identifier in ipairs(identifiers) do
        if string.find(identifier, "steam:") then
            return tonumber(string.sub(identifier, 7), 16)
        end
    end
    return nil
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, player in ipairs(GetPlayers()) do
            local playerCid = GetPlayerCid(player)
            local charInfo = GetCharInfoById(playerCid)
            TriggerClientEvent('DisplayRolePlayName', -1, GetRoalNameFromInfo(playerCid,charInfo))
        end
    end
end)