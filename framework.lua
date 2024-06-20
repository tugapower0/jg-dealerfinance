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

function Framework.CheckAmount(amount, source)
    local Player = Framework.GetPlayerData(source)

    if Config.Framework == "ESX" then
        if Player.getAccount('bank').money < amount then
            return false
        end
    elseif Config.Framework == "QBCore" then
        if Player.Functions.GetMoney('bank') < amount then
            return false
        end
    else
        print("Unknown framework specified in Config.Framework")
        return false
    end
    return true
end

function Framework.RemoveMoney(amount, source)
    local Player = Framework.GetPlayerData(source)

    if Config.Framework == "ESX" then
        Player.removeAccountMoney('bank', amount)
        return true
    elseif Config.Framework == "QBCore" then
        Player.Functions.RemoveMoney('bank', amount)
        return true
    else
        print("Unknown framework specified in Config.Framework")
        return false
    end
end