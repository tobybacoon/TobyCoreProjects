AddStateBagChangeHandler('policeAnim', nil, function(bagName, key, value, reserved, replicated)
    if not value then return end
    local sourcePlayer = GetPlayerFromServerId(tonumber(id))
    local playerPed = GetPlayerPed(sourcePlayer)

    SetWeaponAnimationOverride(playerPed, value and "customanim" or "default")
end)