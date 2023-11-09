
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('nazu-nametag:GetActivePlayersFullName')
AddEventHandler('nazu-nametag:GetActivePlayersFullName', function ()

    local ActivePlayersInfoList = {}

    for _, player in ipairs(GetPlayers()) do

        print(player)

        local playerInfo = QBCore.Functions.GetPlayer(player)
        if playerInfo then

            print(playerInfo.PlayerData.charinfo.firstname)
            print(playerInfo.PlayerData.charinfo.lastname)

            -- new { "firstname":Firstname, "lastname":Lastname}
            local newPlayerInfo = json.encode({
                firstname = playerInfo.PlayerData.charinfo.firstname,
                lastname = playerInfo.PlayerData.charinfo.lastname
            })

            table.insert(ActivePlayersInfoList,newPlayerInfo)
            -- print(newPlayerInfo)
        end
    end

    TriggerClientEvent('nazu-nametag:DisplayRolePlayName', -1, ActivePlayersInfoList)
end)



-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         for _, playerInfo in ipairs(ActivePlayersNamelist) do
--             -- local playerName = GetPlayerName(player)
--             TriggerClientEvent('nazu-nametag:DisplayRolePlayName', -1, playerInfo)
--         end
--     end
-- end)


-- function GetCharInfoByName(name)

--     local charInfo = nil
--     local query = "SELECT charinfo FROM players WHERE name = @name LIMIT 1"

--     MySQL.Async.fetchScalar(query, {['@name'] = name}, function(result)
--         if result then
--             charInfo = result
--         end
--     end)
    
--     while charInfo == nil do
--         Citizen.Wait(10)
--     end

--     return charInfo
-- end

-- function GetRoalNameFromInfo(charInfo)

--     local FirstName = ""
--     local LastName = ""

--     local InfoData = json.decode(charInfo)

--     FirstName = InfoData.firstname
--     LastName = InfoData.lastname

--     -- new { "firstname":Firstname, "lastname":Lastname}
--     local newInfoData = json.encode({
--         firstname = FirstName,
--         lastname = LastName
--     })

--     return newInfoData
-- end
