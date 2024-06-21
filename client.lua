local identifier = "jg-dealerfinance"

while GetResourceState("lb-phone") ~= "started" do
    Wait(500)
end

local function addApp()
    local added, errorMessage = exports["lb-phone"]:AddCustomApp({
        identifier = identifier, -- unique app identifier

        

        name = "JG Finance",
        description = "Manage your financed vehicles.",
        developer = "WL",

        defaultApp = false, --  set to true, the app will automatically be added to the player's phone
        size = 59812, -- the app size in kb
        -- price = 0, -- OPTIONAL make players pay with in-game money to download the app


        -- ui = "http://localhost:3000",
        ui = GetCurrentResourceName() .. "/ui/dist/index.html",

        icon = "https://cfx-nui-" .. GetCurrentResourceName() .. "/ui/icon.png",

        fixBlur = true -- set to true if you use em, rem etc instead of px in your css
    })

    if not added then
        print("Could not add app:", errorMessage)
    end
end

addApp()

AddEventHandler("onResourceStart", function(resource)
    if resource == "lb-phone" then
        addApp()
    end
end)

local vehicles = {}

RegisterNUICallback("Fetching", function(data,cb)
    local action = data.action
    if action == "fetching" then
        lib.callback("fetchfinancedvehicles", false, function(test)
            vehicles = test
            cb(vehicles)
        end)
    end
end)

RegisterNUICallback("Payment", function(data,cb)
    local action = data.action
    local index = data.index
    local amount = data.amount
    local type = data.type
    local data2 = data.data 

    if action == "payment" then
        if not vehicles[index+1] then
            return cb(false)
        end
        print("Payment2")

            local vehicle = vehicles[index+1]
            local vehicleData = json.decode(vehicle.finance_data)
            local newdata = json.encode(data2)
            local vehiclepay = nil
            if data.type == "payment" then vehiclepay = vehicleData.recurring_payment else vehiclepay =  vehicleData.total - vehicleData.paid end

            if not (vehicleData.vehicle == newdata.vehicle or amount == vehiclepay) then
                return cb(false)
            end
            print("Calling MakePayment")
            lib.callback("MakePayment", false, function(data)
                if not data then
                    return cb(false)
                end
                lib.callback("fetchfinancedvehicles", false, function(test)
                    vehicles = test
                    cb(vehicles)
                end)
            end, vehicleData.vehicle, amount, type, vehicle)

    end
end)
