QBCore, ESX = nil, nil

Framework = {
    Client = {},
    Server = {},
}


if Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()

    Framework.VehiclesTable = "player_vehicles"
    Framework.PlayerIdentifier = "citizenid"

elseif Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()

    Framework.VehiclesTable = "owned_vehicles"
    Framework.PlayerIdentifier = "owner"

end


function Framework.GetPlayerIdentifier(source)
    if Config.Framework == "QBCore" then
        return QBCore.Functions.GetPlayer(source).PlayerData.citizenid
    elseif Config.Framework == "ESX" then
        return ESX.GetPlayerFromId(source).identifier
    end
end

function Framework.GetPlayerData(source)
    if Config.Framework == "QBCore" then
        return QBCore.Functions.GetPlayer(source)
    elseif Config.Framework == "ESX" then
        return ESX.GetPlayerFromId(source)
    end
end