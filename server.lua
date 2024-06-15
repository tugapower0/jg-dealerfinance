lib.callback.register('fetchfinancedvehicles', function()
    return MySQL.query.await("SELECT finance_data, plate FROM "..Framework.VehiclesTable.." WHERE "..Framework.PlayerIdentifier.." = @identifier AND financed = 1", {
        ["@identifier"] = Framework.GetPlayerIdentifier(source)
    })
end)

lib.callback.register('MakePayment', function(source,vehicle, amount, paymenttype, vehicleData)
    local Player = Framework.GetPlayerData(source)

    if Player.getAccount('bank').money < amount then
        return false
    end

    if paymenttype == "payment" then
        local newdata = vehicleData
        local finance_data = json.decode(newdata.finance_data)
        finance_data.paid = finance_data.paid + amount
        finance_data.payments_complete = finance_data.payments_complete + 1
        newdata.finance_data = json.encode(finance_data)
        MySQL.Async.execute("UPDATE "..Framework.VehiclesTable.." SET finance_data = @finance_data WHERE "..Framework.PlayerIdentifier.." = @identifier AND plate = @vehicle_id", {
            ["@finance_data"] = newdata.finance_data,
            ["@identifier"] = Framework.GetPlayerIdentifier(source),
            ["@vehicle_id"] = vehicleData.plate
        })
        Player.removeAccountMoney('bank', amount)
        print("Payments Complete2")
        return true
    else
        print(vehicleData.plate)
        MySQL.Async.execute("UPDATE "..Framework.VehiclesTable.." SET finance_data = NULL, financed = 0 WHERE "..Framework.PlayerIdentifier.." = @identifier AND plate = @data", {
            ["@identifier"] = Framework.GetPlayerIdentifier(source),
            ["@data"] = vehicleData.plate
        })
        Player.removeAccountMoney('bank', amount)
        print("Payments Complete3")
        return true
    end

    return falsew
end)