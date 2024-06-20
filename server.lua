lib.callback.register('fetchfinancedvehicles', function(source)
    local identifier = Framework.GetPlayerIdentifier(source)
    return MySQL.query.await("SELECT finance_data, plate FROM " .. Framework.VehiclesTable .. " WHERE " .. Framework.PlayerIdentifier .. " = @identifier AND financed = 1", {
        ["@identifier"] = identifier
    })
end)

lib.callback.register('MakePayment', function(source, vehicle, amount, paymenttype, vehicleData)
    local Player = Framework.GetPlayerData(source)

    if not Framework.CheckAmount(amount, source) then
        print("Not enough money")
    end

    if paymenttype == "payment" then
        local newdata = vehicleData
        local finance_data = json.decode(newdata.finance_data)
        finance_data.paid = finance_data.paid + amount
        finance_data.payments_complete = finance_data.payments_complete + 1
        newdata.finance_data = json.encode(finance_data)
        if finance_data.payments_complete >= finance_data.total_payments then
            Framework.RemoveMoney(amount, source)
            MySQL.Async.execute("UPDATE "..Framework.VehiclesTable.." SET finance_data = NULL, financed = 0 WHERE "..Framework.PlayerIdentifier.." = @identifier AND plate = @vehicle_id", {
                ["@identifier"] = Framework.GetPlayerIdentifier(source),
                ["@vehicle_id"] = vehicleData.plate
            })
            return true
        end
        Framework.RemoveMoney(amount, source)
        MySQL.Async.execute("UPDATE " .. Framework.VehiclesTable .. " SET finance_data = @finance_data WHERE " .. Framework.PlayerIdentifier .. " = @identifier AND plate = @vehicle_id", {
            ["@finance_data"] = newdata.finance_data,
            ["@identifier"] = Framework.GetPlayerIdentifier(source),
            ["@vehicle_id"] = vehicleData.plate
        })
        return true
    else
        MySQL.Async.execute("UPDATE " .. Framework.VehiclesTable .. " SET finance_data = NULL, financed = 0 WHERE " .. Framework.PlayerIdentifier .. " = @identifier AND plate = @data", {
            ["@identifier"] = Framework.GetPlayerIdentifier(source),
            ["@data"] = vehicleData.plate
        })

        Framework.RemoveMoney(amount, source)
        return true
    end
end)
