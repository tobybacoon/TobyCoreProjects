if GetResourceState('core') then 
    local player = PlayerId()
    local playerPed = GetPlayerPed(player)

    AddEventHandler('core:character:server:select', function(player)
        local character = Core.getCharacter(player)
        local job = character:hasGroupData('police')
        Wait(5000)
            if job then
                Player(player).state:set('policeAnim', true, true)
            end
    end)
end

CreateThread(function ()
    while true do
      for _, player in pairs(GetPlayers()) do
          local character = Core.getCharacter(player)
          local job = character:hasGroupData('police')
          if job then
              Player(player).state:set('policeAnim', police, true)
          end
      end
         Citizen.Wait(5000)
     end
end)