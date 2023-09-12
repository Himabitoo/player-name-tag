RegisterNetEvent('DisplayRolePlayName')
AddEventHandler('DisplayRolePlayName',function(playerInfo)
  
    local AboveHeadLabel = ""
   
    -- json decoder
    local PlayerInfoData = json.decode(playerInfo)
    PlayerCID = PlayerInfoData.cid
    PlayerFirstName = PlayerInfoData.firstname
    PlayerLastName = PlayerInfoData.lastname

    PlayerRolePlayName = PlayerFirstName .. " " .. PlayerLastName

    -- PlayerID -> true || RolePlayName -> true
    if Config.ShowPlayerID and Config.ShowRolePlayName  then

        AboveHeadLabel = "[" .. PlayerCID .. "] " .. PlayerRolePlayName

    -- PlayerID -> false || RolePlayName -> true
    elseif not Config.ShowPlayerID  and Config.ShowRolePlayName then

        AboveHeadLabel = PlayerRolePlayName

    -- PlayerID -> true || RolePlayName -> false
    elseif Config.ShowPlayerID  then

        AboveHeadLabel = "[" .. PlayerCID .. "]"
    end

    local x, y, z = GetPlayerCoordsByCID(PlayerCID)

    if x and y and z then
        print("プレイヤーの座標: x = " .. x .. ", y = " .. y .. ", z = " .. z)
    else
        print("プレイヤーが見つかりませんでした。")
    end

    DrawText3DAboveHead(x,y,z,AboveHeadLabel)

end)


function DrawText3DAboveHead(x, y, z, label)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        local scale = 0.3 -- scale of label
        local font = 0 -- choose your font

        SetTextScale(scale, scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()

        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(label)

        DrawText(_x, _y)
    end
end


function GetPlayerCoordsByCID(cid)
    local player = GetPlayerFromServerId(cid)
    if player ~= -1 then
        local coords = GetEntityCoords(GetPlayerPed(-1))
        return coords.x, coords.y, coords.z
    else
        return nil, nil, nil
    end
end