-- Export gettters
local Chat = GetExport("chat")
local Radial = exports.radial

-- Character getters
local character = Core.getCharacterBySource(source)
local job = character:hasGroupData('police')

-- Helper function for statebag
local function updateAnimState(source, enabled)
    local state = Player(source).state
    state.policeAnim = enabled
end

-- Radial menu option
if job then
    Radial:AddOption({
        id = "FirearmTraining",
        text = "Toggle Firearm Training",
        icon = "accessibility",
    })

    AddEventHandler("radial:onNavigate_FirearmTraining", function()
        if source == 0 then return end
        if not character or not job then return end
    
        local currentOptOut = character:getMetadata('policeTraining')
        local newOptState = not currentOptOut
    
        character:setMetadata('policeTraining', newOptState)
    
        updateAnimState(source, newOptState)
    end)
end

-- Event to update the state bag when the character is selected
AddEventHandler('core:character:server:select', function(source)
    if not character or source == 0 then return end
    if not job then return end

    if job then
        local enabled = false
        if character.metadata['policeTraining'] == nil then
            character:setMetadata('policeTraining', true)
            enabled = true
        else
            enabled = character:getMetadata('policeTraining')
        end
        updateAnimState(source, enabled)
    end
end)