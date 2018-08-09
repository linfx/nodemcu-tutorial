-------------
-- wifi
-------------
function setupWifi()
    print('Setting up WiFi...')
    wifi.setmode(wifi.STATION)
    wifi.sta.config("pc-lin","123456789")
    wifi.sta.autoconnect(1)

    status = nil

    wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function()
        blinking({100, 100 , 100, 500})
        status = 'STA_WRONGPWD'
        print(status)
    end)

    wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function()
        blinking({2000, 2000})
        status = 'STA_APNOTFOUND'
        print(status)
    end)

    wifi.sta.eventMonReg(wifi.STA_CONNECTING, function(previous_State)
        blinking({300, 300})
        status = 'STA_CONNECTING'
        print(status)
    end)

    wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
        blinking()
        status = 'STA_GOTIP'
        print(status, wifi.sta.getip())
    end)

    wifi.sta.eventMonStart(1000)
end
