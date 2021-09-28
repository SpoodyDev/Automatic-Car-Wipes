local scripts = {}
local CooldownList = {}

function IsPopulationTypeNormal(vehicle)
    local BlacklistedTypes = {0, 7}
    for i=1, #BlacklistedTypes do 
        if (GetvehiclePopulationType(vehicle) == BlacklistedTypes[i]) then return false end
    end
    return true
end

function GetvehicleOwner(vehicle)
    if (not DoesvehicleExist(vehicle)) then 
        return nil 
    end
    local owner = NetworkGetvehicleOwner(vehicle)
    if (IsPopulationTypeNormal(vehicle)) then return nil end
    return owner
end

RegisterCommand("delallveh", function(source, args, raw)
    local playerID = args[1]
    if (IsPlayerAceAllowed(source, "anticheat.moderation")) then
        if (playerID ~= nil and tonumber(playerID) ~= nil) then 
            vehicleWipe(source, tonumber(playerID))
        end
    end
end, false)

function delallveh(source, target)
    TriggerClientEvent("wld:delallveh", -1, tonumber(target))
end

function DoesResourceExist(resourceName)
    local badStates = {"missing", "uninitialized", "unknown"}
    local state = GetResourceState(resourceName)
    for i=1, #badStates do 
        if (state == badStates[i]) then return false end
    end
    return true
end

RegisterServerEvent("anticheat:ResourceStarted")
AddEventHandler("anticheat:ResourceStarted", function(resourceName)
    if (not DoesResourceExist(resourceName)) then 
        KickPlayer(source, "Baby fuck me - Spoody")
    end
end)

Citizen.CreateThread(function()
    while true do
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.60vw; margin: -0.4vw; background-color: rgba(191, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-cog"></i> SYSTEM: {0}</div>',
            args = {"Car Wipe In 30 Seconds! "}
        })
        Wait(30000)
        TriggerClientEvent("wld:delallveh", -1, -1)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.60vw; margin: -0.4vw; background-color: rgba(191, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-cog"></i> SYSTEM: {0}</div>',
            args = {"All Cars Have Been Cleared! "}
        })
        Citizen.Wait(2750000)
    end
  end)