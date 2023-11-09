RegisterNetEvent('DisplayRolePlayName')
AddEventHandler('DisplayRolePlayName',function(playerInfo)
  
    local AboveHeadLabel = ""
   
    -- json decoder
    local PlayerInfoData = json.decode(playerInfo)
    PlayerID = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))
    PlayerFirstName = PlayerInfoData.firstname
    PlayerLastName = PlayerInfoData.lastname

    PlayerRolePlayName = PlayerFirstName .. " " .. PlayerLastName

    -- PlayerID -> true || RolePlayName -> true
    if Config.ShowPlayerID and Config.ShowRolePlayName  then

        AboveHeadLabel = "[" .. PlayerID .. "] " .. PlayerRolePlayName

    -- PlayerID -> false || RolePlayName -> true
    elseif not Config.ShowPlayerID  and Config.ShowRolePlayName then

        AboveHeadLabel = PlayerRolePlayName

    -- PlayerID -> true || RolePlayName -> false
    elseif Config.ShowPlayerID  then

        AboveHeadLabel = "[" .. PlayerID .. "]"
    end

    local ped = GetPlayerPed(-1)

    if ped then
        local x, y, z = table.unpack(GetEntityCoords(ped))
        DrawText3DAboveHead(x, y, z + 1.0, AboveHeadLabel)
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
    -- local factor = (string.len(text)) / 370
    -- DrawRect(_x,_y+0.0125, 0.03+ factor, 0.03, 41, 11, 41, 90)
end
