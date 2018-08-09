-------------
-- define
-------------
IO_BLINK = 0     --GPIO16 LED1
IO_LED = 4       --GPIO2  LED2
TMR_BLINK = 5
MQTT_HOST = 'mqtt.wayto.com.cn'
MQTT_PORT = 1883
-------------
-- init all globals
-------------
function loadLib(fname)
    if file.open(fname .. ".lc") then
        file.close()
        dofile(fname .. ".lc")
    else
        dofile(fname .. ".lua")
    end
end

function initGPIO()
    gpio.mode(IO_BLINK, gpio.OUTPUT)
end
-------------
initGPIO()
setupWifi()
-------------
-- blink
-------------
blink = nil
tmr.register(TMR_BLINK, 100, tmr.ALARM_AUTO, function()
    gpio.write(IO_BLINK, blink.i % 2)
    tmr.interval(TMR_BLINK, blink[blink.i + 1])
    blink.i = (blink.i + 1) % #blink
end)

function blinking(param)
    if type(param) == 'table' then
        blink = param
        blink.i = 0
        tmr.interval(TMR_BLINK, 1)
        running, _ = tmr.state(TMR_BLINK)
        if running ~= true then
            tmr.start(TMR_BLINK)
        end
    else
        tmr.stop(TMR_BLINK)
        gpio.write(IO_BLINK, param or gpio.LOW)
    end
end