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

-- idea zone -- 

AddEventHandler('core:character:server:select', function(source)
    if not character or source == 0 then return end
    if not job then return end

    if job then
        local animState = false
        if character.metadata['policeTraining'] == nil then
            character:setMetadata('policeTraining', 'Micheal')
            animState = 'Micheal'
        else
            animState = character:getMetadata('policeTraining')
        end
        updateAnimState(source, animState)
    end
end)

Chat:registerCommand('PoliceAming', function(source, args, rawCommand)
    if source == 0 then return end
    if not character or not job then return end
    local animation = args[1]
    if animation ~= "default" and animation ~= "tactical" and animation ~= "police" then
        TriggerClientEvent('lib:notify', source,
            { type = 'error', description = "Invalid Animation name or Capitals used. Please choose default, tactical, or police." })
        return
    else
        character:setMetadata('policeTraining', args[1])
        updateAnimState(source, args[1])
    end
end, {
    description = "Set your aiming Animation.",
    params = {
        { name = "Animation", help = "Enter The Animation name (default, tactical, police)" }
    },
}, '')


if job then
    Radial:AddOption({
        id = "FirearmTraining",
        text = "Toggle Firearm Training",
        icon = "accessibility",
    })

    AddEventHandler("radial:onNavigate_FirearmTraining", function()
        if source == 0 then return end
        if not character or not job then return end
    
        local currentAnim = character:getMetadata('policeTraining')
    
        if currentAnim == "tactical" or currentAnim == "police" then
            character:setMetadata('policeTrainingPrev', currentAnim)
            character:setMetadata('policeTraining', "default")
            updateAnimState(source, "default")
        elseif currentAnim == "default" then
            local prevAnim = character:getMetadata('policeTrainingPrev')
            if prevAnim then 
                character:setMetadata('policeTraining', prevAnim)
                updateAnimState(source, prevAnim)
                character:setMetadata('policeTraining_prev', nil)
            end
        end
    end)
end
