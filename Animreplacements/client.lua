AddStateBagChangeHandler('policeAnim', nil, function(bagName, key, value, reserved, replicated)
    local prefix, id = bagName:match("^(.-):(%d+)$")
    if prefix == 'player' then
        local sourcePlayer = GetPlayerFromServerId(tonumber(id))
        local playerPed = GetPlayerPed(sourcePlayer)
        SetWeaponAnimationOverride(playerPed, value and "Michael" or "default")
    end
end)

-- idea zone

AddStateBagChangeHandler('policeAnim', nil, function(bagName, key, value, reserved, replicated)
    local prefix, id = bagName:match("^(.-):(%d+)$")
    if prefix == 'player' then
        local sourcePlayer = GetPlayerFromServerId(tonumber(id))
        local playerPed = GetPlayerPed(sourcePlayer)
        if value == 'Michael' then
            SetWeaponAnimationOverride(playerPed, value and "Michael" or "default")
        elseif value == 'default' then
            SetWeaponAnimationOverride(playerPed, value and "default" or "default")
        elseif value == 'Trevor' then
            SetWeaponAnimationOverride(playerPed, value and "Trevor" or "default")
        end
    end
end)