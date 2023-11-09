TriggerServerEvent('nazu-nametag:GetActivePlayersFullName')

local ActivePlayersInfo

RegisterNetEvent('nazu-nametag:DisplayRolePlayName')
AddEventHandler('nazu-nametag:DisplayRolePlayName', function(ActivePlayersNamelist)

    ActivePlayersInfo = ActivePlayersNamelist

end)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(0)
        if ActivePlayersInfo then
            for _, playerInfo in ipairs(ActivePlayersInfo) do

                local AboveHeadLabel = ""

                -- json decoder
                local PlayerInfoData = json.decode(playerInfo)

                print(PlayerInfoData)

                PlayerID = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))
                PlayerFirstName = PlayerInfoData.firstname
                PlayerLastName = PlayerInfoData.lastname

                local playerFullName = PlayerFirstName .. " " .. PlayerLastName

                print(playerFullName)


                -- PlayerID -> false || RolePlayName -> true
                if not Config.ShowPlayerID and Config.ShowRolePlayName then

                    AboveHeadLabel = playerFullName

                -- PlayerID -> true || RolePlayName -> true
                elseif Config.ShowPlayerID and Config.ShowRolePlayName  then

                    AboveHeadLabel = "[" .. PlayerID .. "] " .. playerFullName


                -- PlayerID -> true || RolePlayName -> false
                elseif Config.ShowPlayerID and not Config.ShowRolePlayName then

                    AboveHeadLabel = "[" .. PlayerID .. "]"

                else

                    print('config error')

                end

                print(AboveHeadLabel)

                local ped = GetPlayerPed(-1)

                if ped then
                    local x, y, z = table.unpack(GetEntityCoords(ped))
                    DrawText3DAboveHead(x, y, z + 1.0, AboveHeadLabel)
                end
            end
        else

            print("no info data")

        end
    end
end)

function DrawText3DAboveHead(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)

    AddTextComponentString(text)
    DrawText(_x,_y)
end
