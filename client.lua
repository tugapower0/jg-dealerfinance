while GetResourceState('qs-smartphone-pro') ~= 'started' do
    Wait(500)
end

local ui = 'https://cfx-nui-' .. GetCurrentResourceName() .. '/ui/'

local function addApp()
    local added, errorMessage = exports['qs-smartphone-pro']:addCustomApp({
        app = 'dealerfinance',
        image = ui .. 'icon.png',
        ui = ui .. 'dist/index.html',
        label = 'JG Finance',
        job = false,
        blockedJobs = {},
        timeout = 5000,
        creator = 'WL',
        category = 'social',
        isGame = false,
        description = 'Manage your financed vehicles!',
        age = '16+',
        extraDescription = {
            {
                header = 'JG Finance',
                head = 'Manage your financed vehicles!',
                image = 'https://media.istockphoto.com/photos/abstract-background-wallpaper-picture-id952039286?b=1&k=20&m=952039286&s=170667a&w=0&h=LmOcMt7FHxFUAr2bOSfTUPV9sQhME6ABtAYLM0cMkR4=',
                footer = 'Em teste, NAO USAR!'
            }
        }
    })

    if not added then
        return print('Could not add app:', errorMessage)
    end
    print('App added')
end

local function removeApp()
    local removed, errorMessage = exports['qs-smartphone-pro']:removeCustomApp('dealerfinance')
    if not removed then
        return print('Failed to remove app', errorMessage)
    end
    print('App removed')
end

RegisterCommand('removeapp', function()
    removeApp()
end, false)

CreateThread(addApp)

AddEventHandler('onResourceStart', function(resource)
    if resource == 'qs-smartphone-pro' then
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
