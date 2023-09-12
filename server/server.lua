function GetCharInfoByName(name)

    local charInfo = nil
    local query = "SELECT charinfo FROM players WHERE name = @name LIMIT 1"

    MySQL.Async.fetchScalar(query, {['@name'] = name}, function(result)
        if result then
            charInfo = result
        end
    end)
    
    while charInfo == nil do
        Citizen.Wait(10)
    end

    return charInfo
end

function GetRoalNameFromInfo(charInfo)

    local FirstName = ""
    local LastName = ""

    local InfoData = json.decode(charInfo)

    FirstName = InfoData.firstname
    LastName = InfoData.lastname

    -- new { "firstname":Firstname, "lastname":Lastname}
    local newInfoData = json.encode({
        firstname = FirstName,
        lastname = LastName
    })

    return newInfoData
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, player in ipairs(GetPlayers()) do
            local playerName = GetPlayerName(player)
            local charInfo = GetCharInfoByName(playerName)
            TriggerClientEvent('DisplayRolePlayName', -1, GetRoalNameFromInfo(charInfo))
        end
    end
end)