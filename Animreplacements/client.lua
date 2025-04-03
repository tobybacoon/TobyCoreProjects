AddStateBagChangeHandler('policeAnim', nil, function(bagName, key, value, reserved, replicated)
    local prefix, id = bagName:match("^(.-):(%d+)$")
    if prefix == 'player' then
        local sourcePlayer = GetPlayerFromServerId(tonumber(id))
        local playerPed = GetPlayerPed(sourcePlayer)
        SetWeaponAnimationOverride(playerPed, value and "Michael" or "default")
    end
end)