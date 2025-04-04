local Chat = GetExport("chat")
local debug = true

local jobFilter = {
    sasp,
    marshals,
    safr,
    saha,
    sacl
}

local readableNames = {
    ["sasp"] = "SASP",
    ["marshals"] = "Marshals",
    ["safr"] = "SAFR",
    ["saha"] = "SAHA",
    ["sacl"] = "SACL"
}

local allowedJobs = {
    ["sasp"] = true,
    ["marshals"] = true,
    ["safr"] = true,
    ["saha"] = true,
    ["sacl"] = true
}

local jobColors = {
    sasp = {r = 0, g = 0, b = 255},-- Blue
}

local function sendMessage(playerId, message, job)
    exports.chat:addMessage(playerId, {
        color = {255, 0, 0},
        args = {"MDT", message}
      })
end

Chat:RegisterCommand("mdt", function(source, args, rawCommand)
    local character = Core.getCharacterBySource(source)
    local job = character:hasGroup(jobFilter)
    local input = rawCommand:sub(5):gsub("^%s+", "")
    local target, message = input:match("^(%S+)%s*(.*)")
    local name = character:getName()
    local firstname, lastname = name:match("^(%S+)%s+(%S+)$")
    local callsign = character:getMetadata('callsign')
    local targetJobName = jobFilter[target]
    local sentMessage
    if not job then return end

    if debug then 
        print("MDT Message sent")
        print('Job filter:' ..json.encode(job))
        print('Character:' ..json.encode(character))
        print('Name:' ..name)
        print('Callsign:' ..callsign)
    end

    if input == "" then
        -- insert logic for opening MDT here
        return
    end

    if targetJobName then
        local readableName = readableNames[targetJobName]
        local sentMessage = string.format("DIRECT TO %s | %s.%s (%s) | %s", readableName, firstname:upper():sub(1, 1), lastname:upper(), callsign, message)
        local players = Core.getCharacters()

        local messageSent = false
        for _, playerId in ipairs(players) do
            local targetPlayer = Core.getCharacterBySource(playerId)
            local targetJob = targetPlayer:hasGroup(targetJobName)
            if targetJob == targetJobName then
                sendMessage(playerId, finalMessage, job)
                messageSent = true
            end
        end
        sendMessage(source, sentMessage, job)

        if not messageSent then
            TriggerClientEvent('lib:notify', src, {type = 'error', description = "No players with that job found"})
        end

    elseif target == "all" then
        finalMessage = string.format("%s.%s (%s) | %s", firstname:upper():sub(1, 1), lastname:upper(), callsign, message)
        local messageSent = false
        for _, playerId in ipairs(players) do
            local targetPlayer = Core.getCharacterBySource(playerId)
            local targetJob = targetPlayer:hasGroup(targetJobName)

            if allowedJobs[targetJob] then
                sendMessage(playerId, finalMessage, job)
                messageSent = true
            end
        end
        if not messageSent then
            sendMessage(source, finalMessage, job)
        end
    else
        local found = false
        for _, playerId in ipairs(players) do
            local targetCharacter = Core.getCharacterBySource(playerId)
            local name = targetCharacter:getName()
            local targetFirstName, targetLastName = name:match("^(%S+)%s+(%S+)$")
            local targetcallsign = targetCharacter:getMetadata('callsign')
            if callsign == target then
                finalMessage = string.format("%s.%s (%s) To %s.%s (%s) | %s", firstname:upper():sub(1, 1), lastname:upper(), callsign, targetFirstName:upper():sub(1, 1), targetLastName:upper(), targetcallsign, message)
                sendMessage(playerId, finalMessage, job)
                sendMessage(source, finalMessage, job)
                found = true
                break
            end
        end

        if not found then
            TriggerClientEvent('lib:notify', src, {type = 'error', description = "Player with that callsign not found"})
        end
    end

end, {
    description = "Send a message to your colleagues or open the MDT.",
    params = {
        {name="target", help="Callsign, Nickname, Job Name, or 'all'. Leave blank to open MDT"},
        {name="message", help="Message to send. Leave blank to open MDT"}
    },
},'')
